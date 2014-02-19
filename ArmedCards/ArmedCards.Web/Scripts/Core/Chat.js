/// <reference path="Utilities.js" />
/// <reference path="jQueryTopic.js" />
/// <reference path="ViewModels.js" />
/// <reference path="../knockout-3.0.0.js" />
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

Chat.prototype.BroadcastMessage = function (message, $discussion) {
    // Html encode display name and message.

    if (message.ConnectionType == 2 && !message.Global)
    {
        message.SentBy = "[Spectator] " + message.SentBy;
    }

	var encodedName = $('<div />').text(message.SentBy + " (" + new Date(message.DateSent).toLocaleTimeString() + ")").html();
	var encodedMsg = $('<div />').text(message.Message).html();

	$discussion.append('<li><strong>' + encodedName
        + '</strong>:&nbsp;&nbsp;' + encodedMsg + '</li>');
	$discussion.scrollTop($discussion.get(0).scrollHeight);
};

Chat.prototype.BroadcastGlobalMessage = function (message) {
    // Add the message to the page.
    var $discussion = $('#discussion');

    ArmedCards.Core.Chat.BroadcastMessage(message, $discussion);
};

Chat.prototype.BroadcastGameMessage = function (message) {
	// Add the message to the page.
	var $discussion = $('#gameDiscussion');

	ArmedCards.Core.Chat.BroadcastMessage(message, $discussion);

	$.Topic("newMessageAlert").publish();
};

Chat.prototype.SendMessage = function (event) {
	event.preventDefault();

	var hub = $.connection.ArmedCardsHub;
	var messageText = $('#message').val();

	if (messageText != null && messageText != undefined && messageText != '') {
		var message = {
			Message: messageText,
			GameID: $('#Game_GameID').val(),
			Global: !$('#discussion').hasClass('hidden'),
			ConnectionType: $('#ConnectionType').val()
		};

		hub.server.SendMessage(message);
	}

	// Clear text box and reset focus for next comment. 
	$('#message').val('').focus();
};

Chat.prototype.Join = function () {
    var hub = $.connection.ArmedCardsHub;

    var gameID = $('#Game_GameID').val();
    var connectionType = $('#ConnectionType').val();

    hub.server.Join(gameID, connectionType);
};

Chat.prototype.UpdateLobby = function (lobby) {
    ArmedCards.Core.ViewModels.LobbyViewModel.replacePlayers(lobby.ActiveConnections);
};

Chat.prototype.RemoveConnection = function (connection) {
    $('[name="{0}"]'.format(connection.ActiveConnectionID), '#playerList').remove();
};

Chat.prototype.Init = function () {
    var hub = $.connection.ArmedCardsHub;
    hub.client.BroadcastGlobalMessage = ArmedCards.Core.Chat.BroadcastGlobalMessage;
    hub.client.BroadcastGameMessage = ArmedCards.Core.Chat.BroadcastGameMessage;
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

    ArmedCards.Core.ViewModels.LobbyViewModel = new Lobby([]);

    ko.applyBindings(ArmedCards.Core.ViewModels.LobbyViewModel);
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Core.Chat.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Core.Chat.Join);

/***************************************************************/
// Knockout specific functions
/***************************************************************/

var Lobby = function (activeConnections) {
    this.ActiveConnections = ko.observableArray(activeConnections);

    this.replacePlayers = function (newActiveConnections) {
        var self = this;

        self.ActiveConnections.removeAll();

        self.ActiveConnections(newActiveConnections);
    }.bind(this);
};