/// <reference path="AngularHub.js" />

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

function AngularChat() {
}

if (!ArmedCards.Core.AngularChat) {
    ArmedCards.Core.AngularChat = new AngularChat();
}

AngularChat.prototype.Factory = function ($rootScope, $http, ArmedCardsHub) {
    var ArmedCardsChat = this;

    // Update ArmedCardsHub
    ArmedCardsHub.SendMessage = function (message) {
        if (message.Message != null && message.Message != undefined && message.Message != '') {

            message.GameID = $('#Game_GameID').val();
            message.Global = !$('#discussion').hasClass('hidden');
            message.ConnectionType = $('#ConnectionType').val();

            ArmedCardsHub.Hub.SendMessage(message);
        }

        // Clear text box and reset focus for next comment. 
        message.Message = '';
        angular.element('#message').focus();
    };

    ArmedCardsHub.Join = function () {
        var gameID = $('#Game_GameID').val();
        var connectionType = $('#ConnectionType').val();

        ArmedCardsHub.Hub.Join(gameID, connectionType);
    };

    $rootScope.$on('hubStartComplete', ArmedCardsHub.Join);

    ArmedCardsHub.Hub.addNewListeners({
        'BroadcastGameMessage': ArmedCards.Core.AngularChat.BroadcastGameMessage,
        'RemoveConnection': ArmedCards.Core.AngularChat.RemoveConnection
    });

    var offsetHours = new Date().getTimezoneOffset() / 60;
    
    ArmedCardsChat.InitGlobalMessages = function () {
        return $http.get('/ChatMessage/View?offsetHours=' + offsetHours);
    };

    ArmedCardsChat.Init = function () {
        ArmedCardsHub.Hub.addNewMethods(['Join', 'SendMessage']);

        angular.element('#message').focus();

        ArmedCards.Core.ViewModels.LobbyViewModel = new Lobby([]);

        var mainLobby = document.getElementById('mainLobby');

        if (mainLobby != null) {
            ko.applyBindings(ArmedCards.Core.ViewModels.LobbyViewModel, mainLobby);
        }
    };

    ArmedCardsChat.Init();

    ArmedCardsChat.RemoveConnection = function (connection) {
        $('[name="{0}"]'.format(connection.ActiveConnectionID), '#playerList').remove();
    };

    ArmedCardsChat.UpdateLobby = function (lobby) {
        ArmedCards.Core.ViewModels.LobbyViewModel.replacePlayers(lobby.ActiveConnections);
    };

    ArmedCardsChat.BroadcastGlobalMessage = function (message, globalMessages) {
        globalMessages.push(message);

        //scroll to bottom
    };

    ArmedCardsChat.BroadcastGameMessage = function (message, gameMessages) {
        gameMessages.push(message);

        $.Topic("newMessageAlert").publish();

        //scroll to bottom
    };

    return ArmedCardsChat;
};

ArmedCards.Core.AngularHub.App.factory('ArmedCardsChat', ['$rootScope', '$http', 'ArmedCardsHub', ArmedCards.Core.AngularChat.Factory]);

/* Controllers */
var Lobby = function (activeConnections) {
    this.ActiveConnections = ko.observableArray(activeConnections);

    this.replacePlayers = function (newActiveConnections) {
        var self = this;

        self.ActiveConnections.removeAll();

        self.ActiveConnections(newActiveConnections);
    }.bind(this);
};
