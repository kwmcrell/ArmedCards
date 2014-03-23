/// <reference path="jQueryTopic.js" />

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
ArmedCards.Core = ArmedCards.Core || {};

function Hub() {

}

if (!ArmedCards.Core.Hub) {
    ArmedCards.Core.Hub = new Hub();
}

Hub.prototype.ConnectionSlowed = function () {

};

Hub.prototype.Reconnecting = function () {
    ArmedCards.Core.Hub.TryingToReconnect = true;
    $('#hubConnectionText').addClass('on');
    $('#overlay').addClass('on');
};

Hub.prototype.Disconnected = function () {
    if (ArmedCards.Core.Hub.TryingToReconnect) {
        $('#reconnecting').addClass('hidden');
        $('#unableToReconnect').removeClass('hidden');
    }
};

Hub.prototype.Reconnected = function () {
    ArmedCards.Core.Hub.TryingToReconnect = false;

    $('#hubConnectionText').removeClass('on');
    $('#overlay').removeClass('on');

    $.Topic("hubReconnected").publish();
};

Hub.prototype.ReloadPage = function() {
    window.location.reload();
};

Hub.prototype.startHub = function () {
    $.Topic("renderViews").publish();

    //Setup hub events
    $.Topic("beforeHubStart").publish();

    $.connection.hub.reconnecting(ArmedCards.Core.Hub.Reconnecting);

    $.connection.hub.reconnected(ArmedCards.Core.Hub.Reconnected);

    $.connection.hub.disconnected(ArmedCards.Core.Hub.Disconnected);

    // Start the hub. 
    $.connection.hub.start().done(function () {
        $.Topic("hubStartComplete").publish();
    });

    $('#reloadPage').unbind().bind({
        click: ArmedCards.Core.Hub.ReloadPage
    })
};

$(document).ready(ArmedCards.Core.Hub.startHub);