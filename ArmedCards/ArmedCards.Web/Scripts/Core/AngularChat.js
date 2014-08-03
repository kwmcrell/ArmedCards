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

AngularChat.prototype.Factory = function ($rootScope, $http, $timeout) {
    var ArmedCardsChat = function () {
        this.offsetHours = new Date().getTimezoneOffset() / 60;
    };

    ArmedCardsChat.prototype.InitGlobalMessages = function () {
        return $http.get('/ChatMessage/View?offsetHours=' + this.offsetHours);
    };

    ArmedCardsChat.prototype.Init = function () {
        angular.element('#message').focus();
    };

    ArmedCardsChat.prototype.RemoveConnection = function (connection) { };

    ArmedCardsChat.prototype.UpdateLobby = function (activeConnections) { };

    ArmedCardsChat.prototype.BroadcastGlobalMessage = function (message, globalMessages) {
        message.DateSent = new Date(message.SentDate).toLocaleTimeString();

        globalMessages.push(message);

        //scroll to bottom
        this.ScrollDiscussion('#discussion');
    };

    ArmedCardsChat.prototype.ScrollDiscussion = function (discussionId) {
        $timeout(function () {
            var discussion = angular.element(discussionId);

            if (discussion[0]) {
                discussion.scrollTop(discussion[0].scrollHeight);
            }
            
        }, 100);
    };

    ArmedCardsChat.prototype.BroadcastGameMessage = function (message, gameMessages) { };

    return ArmedCardsChat;
};

angular.module('gameApp').factory('ArmedCardsChat', ['$rootScope', '$http', '$timeout', ArmedCards.Core.AngularChat.Factory]);
