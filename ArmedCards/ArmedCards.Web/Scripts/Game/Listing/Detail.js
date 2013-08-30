/*
* Copyright (c) 2013, Kevin McRell & Paul Miller
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are permitted
* provided that the following conditions are met:
* 
* * Redistributions of source code must retain the above copyright notice, this list of conditions
*   and the following disclaimer.
* * Redistributions in binary form must reproduce the above copyright notice, this list of
*   conditions and the following disclaimer in the documentation and/or other materials provided
*   with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
* IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
* DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
* DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
* WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

var ArmedCards = ArmedCards || {};
ArmedCards.Game = ArmedCards.Game || {};

function Detail() {

}

if (!ArmedCards.Game.Detail) {
    ArmedCards.Game.Detail = new Detail();
}

Detail.prototype.hideDetail = function (event) {
    event.preventDefault();
    $('#detailModal').removeClass('on');
    $('#overlay').removeClass('on');
};

Detail.prototype.getDetail = function (event) {
    event.preventDefault();
    $.ajax({
        type: 'GET',
        url: '/Detail',
        data: { id: $(this).attr("id") },
        success: ArmedCards.Game.Detail.showDetail,
        error: function (jqXHR, textStatus, errorThrown) {
            alert(textStatus + '     ' + errorThrown + '     ' + jqXHR);
        }
    });
};

Detail.prototype.validatePassphrase = function (event) {
    event.preventDefault();
    if ($('#userSuppliedPassphrase') != null || $('#userSuppliedPassphrase') != undefined) {

        $.ajax({
            type: 'POST',
            url: '/ValidatePassphrase',
            data: { id: $('#Game_GameID').val(), passphrase: $('#userSuppliedPassphrase').val() },
            success: ArmedCards.Game.Detail.validatePassphraseResponse,
            error: function (jqXHR, textStatus, errorThrown) {
                alert(textStatus + '     ' + errorThrown + '     ' + jqXHR);
            }
        });
    }
    else {
        ArmedCards.Game.Detail.validatePassphraseResponse(1);
    }
};

Detail.prototype.validatePassphraseResponse = function (response) {
    if (response == 0) {
        $('#wrong').addClass('open');
    }
    else {
        $('#wrong').removeClass('open');
        alert('Correct');
    }
};

Detail.prototype.showDetail = function (response) {
    var modal = $('#detailModal');
    modal.html(response);
    modal.addClass('on');
    $('#overlay').addClass('on');
};

Detail.prototype.init = function () {
    $(document).on({
        click : ArmedCards.Game.Detail.hideDetail
    }, '#detailNope');

    $(document).on({
        click: ArmedCards.Game.Detail.validatePassphrase
    }, '#detailDoIt');

    $('.game').on({
        click: ArmedCards.Game.Detail.getDetail
    });
};

$(document).ready(ArmedCards.Game.Detail.init);