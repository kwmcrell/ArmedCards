/// <reference path="../angular.js" />
/// <reference path="../angular-signalr-hub.js" />

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

function AngularHub() {
    this.TryingToReconnect = false;
    this.listeners = {
        'temp': function() { }
    };

    this.methods = new Array();
}

if (!ArmedCards.Core.AngularHub) {
    ArmedCards.Core.AngularHub = new AngularHub();
}

ArmedCards.Core.AngularHub.App = angular.module('gameApp', ['SignalR']);

AngularHub.prototype.Reconnecting = function () {
    ArmedCards.Core.AngularHub.TryingToReconnect = true;
    $('#hubConnectionText').addClass('on');
    $('#overlay').addClass('on');
};

AngularHub.prototype.Disconnected = function () {
    if (ArmedCards.Core.AngularHub.TryingToReconnect) {
        $('#reconnecting').addClass('hidden');
        $('#unableToReconnect').removeClass('hidden');
    }
};

AngularHub.prototype.Reconnected = function ($rootScope) {
    ArmedCards.Core.AngularHub.TryingToReconnect = false;

    $('#hubConnectionText').removeClass('on');
    $('#overlay').removeClass('on');

    $rootScope.$broadcast('hubReconnected');
};

AngularHub.prototype.AddMethod = function (name) {
    ArmedCards.Core.AngularHub.methods.push(name);
};

AngularHub.prototype.Factory = function ($rootScope, Hub) {
    var ArmedCardsHub = this;

    ArmedCardsHub.Reconnecting = function () {
        ArmedCards.Core.AngularHub.Reconnecting();
    };

    ArmedCardsHub.Reconnected = function () {
        ArmedCards.Core.AngularHub.Reconnected($rootScope);
    };

    ArmedCardsHub.Disconnected = function () {
        ArmedCards.Core.AngularHub.Disconnected();
    };

    $rootScope.$broadcast('beforeHubStart');

    //declaring the hub connection
    ArmedCardsHub.Hub = new Hub('ArmedCardsHub', ArmedCards.Core.AngularHub.listeners, ArmedCards.Core.AngularHub.methods,
                                 ArmedCardsHub.Reconnecting, ArmedCardsHub.Reconnected,
                                 ArmedCardsHub.Disconnected);

    return ArmedCardsHub;
};

ArmedCards.Core.AngularHub.App.factory('ArmedCardsHub', ['$rootScope', 'Hub', ArmedCards.Core.AngularHub.Factory]);

