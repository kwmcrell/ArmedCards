﻿/// <reference path="Utilities.js" />
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

function Chat() {
    
}

if (!ArmedCards.Core.Chat) {
    ArmedCards.Core.Chat = new Chat();
}

Chat.prototype.BroadcastGlobalMessage = function (message) {
    // Html encode display name and message.  
    var encodedName = $('<div />').text(message.SentBy + " (" + new Date(message.DateSent).toLocaleTimeString() + ")").html();
    var encodedMsg = $('<div />').text(message.Message).html();

    // Add the message to the page.
    var $discussion = $('#discussion');

    $discussion.append('<li><strong>' + encodedName
        + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
    $discussion.scrollTop($discussion.get(0).scrollHeight);
};

Chat.prototype.SendGlobalMessage = function (event) {
    event.preventDefault();

    var hub = $.connection.ArmedCardsHub;

    var messageText = $('#message').val();

    if (messageText != null && messageText != undefined && messageText != '') {

        var message = {
            Message: messageText
        };

        hub.server.SendGlobalMessage(message);

        // Clear text box and reset focus for next comment. 
        $('#message').val('').focus();
    }
};

Chat.prototype.SendMessage = function (event) {
    ArmedCards.Core.Chat.SendGlobalMessage(event);
};

Chat.prototype.Join = function () {
    var hub = $.connection.ArmedCardsHub;

    var gameID = $('#Game_GameID').val();

    hub.server.Join(gameID);
};

Chat.prototype.UpdateLobby = function (lobby) {
    var html = $.map(lobby.ActiveConnections, function (value, key) {
                    return '<li name="{0}">{1}</li>'.format(value.ActiveConnectionID, value.UserName);
    });

    $('#playerList').html(html.join(''));
};

Chat.prototype.RemoveConnection = function (connection) {
    $('[name="{0}"]'.format(connection.ActiveConnectionID), '#playerList').remove();
};

Chat.prototype.Init = function () {
    var hub = $.connection.ArmedCardsHub;
    hub.client.BroadcastGlobalMessage = ArmedCards.Core.Chat.BroadcastGlobalMessage;
    hub.client.UpdateLobby = ArmedCards.Core.Chat.UpdateLobby;
    hub.client.RemoveConnection = ArmedCards.Core.Chat.RemoveConnection;

    // Set initial focus to message input box.   
    $('#message').focus();

    $('#sendmessage').unbind().bind({
        click: ArmedCards.Core.Chat.SendMessage
    });

    $('#message').unbind().bind({
        keypress: function (event) {
            if (event.keyCode == 13) {
                ArmedCards.Core.Chat.SendMessage(event);
            }
        }
    });
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Core.Chat.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Core.Chat.Join);