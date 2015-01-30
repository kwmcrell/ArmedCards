/// <reference path="../../../Content/Templates/Game/Listing/Player.html" />
/// <reference path="../../../Content/Templates/Game/Listing/Player.html" />
/// <reference path="../../angular.js" />
/// <reference path="../../Core/AngularHub.js" />
/// <reference path="../../Core/AngularChat.js" />

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

function ListingCtrl($scope, $http, $window, $timeout, ArmedCardsHub, ArmedCardsChat) {
    $scope.reconnecting = false;
    $scope.unableToReconnect = false;
    $scope.passphraseWrong = false;
    $scope.armedCardsHub = ArmedCardsHub;

    $scope.overlay = true;
    $scope.showLoading = true;

    $http.get('/GameListing/Games').success(function (data, status, headers, config) {
        $scope.showLoading = false;
        $scope.overlay = false;

        $scope.games = data.Games;
        $scope.maxOfficialDeckCount = data.MaxOfficialDeckCount
    });

    // Update ArmedCardsHub
    UpdateHub($scope, ArmedCardsHub);

    //Setup Chat
    SetupChat($scope, ArmedCardsHub, ArmedCardsChat);

    //Setup Event Listeners
    SetupEventListeners($scope);

    //Setup Game Detail
    $scope.Detail = SetupGameDetail($scope, $http, $window, $timeout);
};

function UpdateHub($scope, ArmedCardsHub) {
    ArmedCardsHub.SendMessage = function (message) {
        if (message.Message != null && message.Message != undefined && message.Message != '') {

            message.GameID = angular.element('#Game_GameID').val();
            message.Global = !angular.element('#discussion').hasClass('hidden');
            message.ConnectionType = angular.element('#ConnectionType').val();

            ArmedCardsHub.Hub.SendMessage(message);
        }

        // Clear text box and reset focus for next comment. 
        message.Message = '';
        angular.element('#message').focus();
    };

    ArmedCardsHub.Join = function () {
        var gameID = angular.element('#Game_GameID').val();
        var connectionType = angular.element('#ConnectionType').val();

        ArmedCardsHub.Hub.Join(gameID, connectionType);
    };

    $scope.$on('hubStartComplete', ArmedCardsHub.Join);

    ArmedCardsHub.Hub.addNewMethods(['Join', 'SendMessage']);
};

function SetupChat($scope, ArmedCardsHub, ArmedCardsChat) {
    var chat = new ArmedCardsChat();

    chat.UpdateLobby = function (activeConnections) {
        $scope.players = activeConnections;

        $scope.$apply();
    };

    chat.RemoveConnection = function (connection) {
        var index = $scope.players.indexOf(connection);

        $scope.players.splice(index, 1);

        $scope.$apply();
    };

    ArmedCardsHub.Hub.addNewListeners({
        'BroadcastGlobalMessage': function (message) {
            chat.BroadcastGlobalMessage(message, $scope.messages);
            $scope.$apply();
        },
        'UpdateLobby': chat.UpdateLobby,
        'RemoveConnection': chat.RemoveConnection
    });

    chat.Init();

    chat.InitGlobalMessages().success(function (data, status, headers, config) {
        $scope.messages = data.Messages;

        chat.ScrollDiscussion('#discussion');
    });
};

function SetupEventListeners($scope) {
    $scope.$on('hubReconnecting', function () {
        $scope.overlay = true;
        $scope.reconnecting = true;

        $scope.$apply();
    });

    $scope.$on('hubReconnected', function () {
        $scope.overlay = false;
        $scope.reconnecting = false;

        $scope.$apply();
    });

    $scope.$on('hubDisconnected', function () {
        $scope.overlay = true;
        $scope.reconnecting = false;
        $scope.unableToReconnect = true;

        $scope.$apply();
    });
};

function SetupGameDetail($scope, $http, $window, $timeout) {
    var detail = { };

    detail.getDetail = function (id) {
        $scope.overlay = true;
        $scope.showLoading = true;
        $http.get('/Detail?id=' + id).success(detail.showDetail);
    };

    detail.showDetail = function (data, status, headers, config) {
        $scope.gameDetail = data.Game;

        $scope.showLoading = false;
        $scope.showGameDetail = true;
        $scope.overlay = true;

        $timeout(function () {

            var detailModal = angular.element('#detailModal');

            var outerHeight = detailModal.outerHeight();
            var windowHeight = angular.element($window).height();

            if (outerHeight > windowHeight) {
                detailModal.height(windowHeight - 50);
                detailModal.css('overflow', 'scroll');
                detailModal.css('margin-top', '0em');
                detailModal.css('top', '0%');
            }

        }, 50);
    };

    detail.validatePassphraseResponse = function (response) {
        $scope.showGameDetail = false;

        if (response.Validated == 0) {
            $scope.passphraseWrong = true;
        }
        else {
            $scope.passphraseWrong = false;
            $window.location.href = response.URL;
        }
    };

    detail.validatePassphrase = function (playerType) {
        var passphrase = angular.element('#userSuppliedPassphrase');

        $scope.showLoading = true;

        if (passphrase != null || passphrase != undefined) {

            var data = {
                id: $scope.gameDetail.GameID,
                passphrase: passphrase.val(),
                playerType: playerType
            };

            
            $http.post('/ValidatePassphrase', data)
                 .success(detail.validatePassphraseResponse);
        }
        else {
            this.validatePassphraseResponse({
                Validated : 1
            });
        }
    };

    detail.hideDetail = function () {
        $scope.showGameDetail = false;
        $scope.overlay = false;

        var detailModal = angular.element('#detailModal');

        detailModal.height('');
        detailModal.css('overflow', '');
        detailModal.css('margin-top', '');
        detailModal.css('top', '');
    };

    return detail;
};

/* Controllers */

angular.module('gameApp').controller('ListingCtrl', ['$scope', '$http', '$window', '$timeout', 'ArmedCardsHub', 'ArmedCardsChat', ListingCtrl]);

/* Directives  */
angular.module('gameApp').directive('rgdPlayer', function () {
    return {
        restrict: 'AEC',
        replace: true,
        templateUrl: '/Content/Templates/Game/Listing/Player.html'
    };
});

angular.module('gameApp').directive('rgdGame', ['$http', '$timeout', '$window', function ($http, $timeout, $window) {
    return {
        restrict: 'AEC',
        templateUrl: '/Content/Templates/Game/Listing/Game.html',
        scope: false,
        replace: true,
        link: function ($scope, $element, $attributes) {
            $element.bind({
                click: function () {
                    $scope.Detail.getDetail($attributes.id);
                }
            });
        }
    };
}]);

angular.module('gameApp').directive('rgdGamedetail', function () {
    return {
        restrict: 'AEC',
        templateUrl: '/Content/Templates/Game/Listing/Detail.html',
        scope: false,
        replace: true
    }
});