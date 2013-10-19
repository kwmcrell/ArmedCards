/// <reference path="../jQuery/jquery-1.9.1.js" />
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
	var sidebarHeight = $('#sidebar').height() - 30;

	var gameHeaderHeight = $('#gameHeader').height();
	var gameLobbyHeight = $('#gameLobby').height();
	var playerHeaderHeight = $('#playerHeader').height();
	var chatInputDivHeight = $('#chatInputDiv').height();
	var tabContainer = $('#tabContainer').height();
	var playersHeaderHeight = $('#playersHeader').height();

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
	$('#discussion').removeClass('hidden');

	$('#globalChatTab').addClass('active');
	$('#gameDiscussion').addClass('hidden');
};

Sidebar.prototype.GameChatTab = function (event) {
	event.preventDefault();

	$('#globalChatTab').removeClass('active');
	$('#gameDiscussion').removeClass('hidden');

	$('#gameChatTab').addClass('active');
	$('#discussion').addClass('hidden');
};

Sidebar.prototype.PlayerMenuOpen = function (event) {
	event.preventDefault();

	var alreadyOpen = $(this).hasClass('open');

	$('.playerMenu').removeClass('open');

	if (!alreadyOpen) {
		$(this).addClass('open');
	}
};

Sidebar.prototype.LobbyUpdate = function (result) {
	if (result != null && result.LobbyView != null) {
		$('#gameLobby').html(result.LobbyView);
	}

	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

Sidebar.prototype.KickPlayer = function () {
	var data = {
		gameID: $('#Game_GameID').val(),
		kickUserId: $(this).attr('data-userId'),
		voteToKick: true
	};

	var url = "/KickPlayer/Vote";

	$.ajax({
		url: url,
		type: "POST",
		data: data
	});
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

	$('#gameLobby')
	.off({
		click: ArmedCards.Game.Sidebar.KickPlayer
	}, '[name="kickPlayer"]')
	.on({
		click: ArmedCards.Game.Sidebar.KickPlayer
	}, '[name="kickPlayer"]');

	$(document).undelegate().delegate('.playerMenu', 'click', ArmedCards.Game.Sidebar.PlayerMenuOpen);

	$(window).resize(ArmedCards.Game.Sidebar.CalculateChatHeight);
};

Sidebar.prototype.ConnectionSuccess = function () {
	ArmedCards.Game.Sidebar.CalculateChatHeight();
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Sidebar.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.Sidebar.ConnectionSuccess);
$.Topic("lobbyUpdated").subscribe(ArmedCards.Game.Sidebar.LobbyUpdate);
$.Topic("newMessageAlert").subscribe(ArmedCards.Game.Sidebar.AlertNewMessage);
