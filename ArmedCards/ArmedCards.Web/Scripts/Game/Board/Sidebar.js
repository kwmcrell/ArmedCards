/// <reference path="../jQuery/jquery-1.9.1.js" />
/// <reference path="Common.js" />
/// <reference path="../../toastr.js" />
/// <reference path="../../Core/ViewModels.js" />
/// <reference path="../../knockout-3.0.0.js" />
/// <reference path="ViewModels.js" />
/// <reference path="../../angular.js" />
/// <reference path="../../Core/Chat.js" />

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

function Sidebar() {

}

if (!ArmedCards.Game.Sidebar) {
	ArmedCards.Game.Sidebar = new Sidebar();
}

Sidebar.prototype.SideBarToggle = function (event) {
	event.preventDefault();

	var $body = $(document.body);

	var isOpen = $body.hasClass('chatOpen');

	if (isOpen) {
		$body.removeClass('chatOpen');
	}
	else {
		$body.addClass('chatOpen');
		$('#sideBarToggle').parent().removeClass('new');
	}
};

Sidebar.prototype.CalculateChatHeight = function () {
	var sidebarHeight = $('#sidebar').height();

	var gameHeaderHeight = $('#gameHeader').height();
	var gameLobbyHeight = $('#gameLobby').height();
	var playerHeaderHeight = $('#playerHeader').height();
	var chatInputDivHeight = $('#chatInputDiv').height();
	var tabContainer = $('#tabContainer').height();
	var playersHeaderHeight = $('#playersHeader').height();
    
	if ($('#chatInputDiv:visible').length == 0)
	{
	    chatInputDivHeight = 0;
	}

	var chatClientNewHeight = sidebarHeight - gameHeaderHeight
                                                - gameLobbyHeight
                                                - playerHeaderHeight
                                                - chatInputDivHeight
                                                - tabContainer
                                                - playersHeaderHeight;

	$('#chatClient').height(chatClientNewHeight);
	$('#gameDiscussion').height(chatClientNewHeight);
	$('#discussion').height(chatClientNewHeight);
};

Sidebar.prototype.AlertNewMessage = function () {
	var $body = $(document.body);

	var isOpen = $body.hasClass('chatOpen');

	if (!isOpen) {
		$('#sideBarToggle').parent().addClass('new');
	}
};

Sidebar.prototype.GlobalChatTab = function (event) {
	event.preventDefault();

	$('#gameChatTab').removeClass('active');
	$('#roundHistoryTab').removeClass('active');
	$('#discussion').removeClass('hidden');

	$('#globalChatTab').addClass('active');
	$('#gameDiscussion').addClass('hidden');
	ArmedCards.Game.ViewModels.GameCompletedRounds.Hidden(true);
	$('#chatInputDiv').removeClass('hidden');
	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.GameChatTab = function (event) {
	event.preventDefault();

	$('#globalChatTab').removeClass('active');
	$('#roundHistoryTab').removeClass('active');
	$('#gameDiscussion').removeClass('hidden');

	$('#gameChatTab').addClass('active');
	$('#discussion').addClass('hidden');
	ArmedCards.Game.ViewModels.GameCompletedRounds.Hidden(true);
	$('#chatInputDiv').removeClass('hidden');
	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.RoundHistoryTab = function (event) {
    event.preventDefault();

    $('#roundHistoryTab').addClass('active');
    ArmedCards.Game.ViewModels.GameCompletedRounds.Hidden(false);

    $('#chatInputDiv').addClass('hidden');

    $('#gameChatTab').removeClass('active');
    $('#globalChatTab').removeClass('active');

    $('#discussion').addClass('hidden');
    $('#gameDiscussion').addClass('hidden');

    ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.PlayerMenuOpen = function (event) {
	event.preventDefault();

	var alreadyOpen = $(this).hasClass('open');

	$('.playerMenu').removeClass('open');

	if (!alreadyOpen) {
		$(this).addClass('open');
	}
};

Sidebar.prototype.LobbyUpdate = function (lobbyJson) {
    ArmedCards.Game.ViewModels.GameLobbyViewModel.UpdateModel(lobbyJson);

	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.ViewSpectators = function(event)
{
    event.preventDefault();

    $('#spectatorList').html($('#hiddenSpectatorList').html());

    ArmedCards.Game.Common.ShowModal('#spectatorModal');
};

Sidebar.prototype.HideSpectators = function (event) {
    event.preventDefault();
    ArmedCards.Game.Common.HideModal('#spectatorModal');
};

Sidebar.prototype.Init = function () {
	$('#sideBarToggle').unbind().bind({
		click: ArmedCards.Game.Sidebar.SideBarToggle
	});

	$('#globalChatTab').unbind().bind({
		click: ArmedCards.Game.Sidebar.GlobalChatTab
	});

	$('#gameChatTab').unbind().bind({
		click: ArmedCards.Game.Sidebar.GameChatTab
	});

	$('#roundHistoryTab').unbind().bind({
        click: ArmedCards.Game.Sidebar.RoundHistoryTab
	})

	$('#gameLobby')
	.off({
	    click: ArmedCards.Game.Sidebar.ViewSpectators
	}, '#spectatorCount')
	.on({
	    click: ArmedCards.Game.Sidebar.ViewSpectators
	}, '#spectatorCount');

    $('#gameContainer')
	.off({
	    click: ArmedCards.Game.Sidebar.HideSpectators
	}, '#hideSpectatorsModal')
	.on({
	    click: ArmedCards.Game.Sidebar.HideSpectators
	}, '#hideSpectatorsModal');

	$(document).undelegate().delegate('.playerMenu', 'click', ArmedCards.Game.Sidebar.PlayerMenuOpen);

	$(window).resize(ArmedCards.Game.Sidebar.CalculateChatHeight);
};

Sidebar.prototype.ConnectionSuccess = function () {
	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.GameChatCtrl = function ($scope, $http) {
    var offsetHours = new Date().getTimezoneOffset() / 60;

    $http.get('/ChatMessage/View?gameID=' + $('#Game_GameID').val() + '&global=false&offsetHours=' + offsetHours).success(function (data, status, headers, config) {
        $scope.gameMessages = data.Messages;
    });

    $http.get('/ChatMessage/View?offsetHours=' + offsetHours).success(function (data, status, headers, config) {
        $scope.globalMessages = data.Messages;
    });
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Sidebar.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.Sidebar.ConnectionSuccess);
$.Topic("lobbyUpdated").subscribe(ArmedCards.Game.Sidebar.LobbyUpdate);
$.Topic("newMessageAlert").subscribe(ArmedCards.Game.Sidebar.AlertNewMessage);


/* Controllers */
var gameApp = angular.module('gameApp', []);

gameApp.controller('GameChatCtrl', ['$scope', '$http', ArmedCards.Game.Sidebar.GameChatCtrl]);

/* Directives */
gameApp.directive('rgdChatmessage', ArmedCards.Core.Chat.RgdChatmessage);