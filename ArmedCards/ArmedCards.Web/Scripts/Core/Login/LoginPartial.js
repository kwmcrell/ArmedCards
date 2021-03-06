﻿/*
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

function LoginPartial() {

}

if (!ArmedCards.Core.LoginPartial) {
    ArmedCards.Core.LoginPartial = new LoginPartial();
}

LoginPartial.prototype.signIn = function (event) {
    event.preventDefault();
    $('#overlay').addClass('on');
    $('#confirmMessage').addClass('on');
}

LoginPartial.prototype.logOff = function (event) {
	event.preventDefault();

    var connection = $.connection;
    if (connection.ArmedCardsHub != null) {
    	connection.ArmedCardsHub.server.Disconnect();
    }

    document.getElementById('logoutForm').submit();
}

LoginPartial.prototype.externalLoginSubmit = function (event) {
    event.preventDefault();
    $('#externalLogin').submit();
}

LoginPartial.prototype.init = function () {
    $('#signIn').unbind().bind({
        click: ArmedCards.Core.LoginPartial.signIn
    });

    $('#logOff').unbind().bind({
        click: ArmedCards.Core.LoginPartial.logOff
    });

    $('#registerSave').unbind().bind({
        click: ArmedCards.Core.LoginPartial.externalLoginSubmit
    });
}

$(document).ready(ArmedCards.Core.LoginPartial.init);
