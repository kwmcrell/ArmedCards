﻿/// <reference path="Hand.js" />
/// <reference path="Common.js" />
/// <reference path="Waiting.js" />
/// <reference path="../../Core/Utilities.js" />
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

function State() {

}

if (!ArmedCards.Game.State) {
	ArmedCards.Game.State = new State();
}

State.prototype.UpdateGame = function (html) {
    ArmedCards.Game.Waiting.ClearTimeout();

	$('#gameContainer').html(html);

	ArmedCards.Game.Common.Init();
	ArmedCards.Game.Hand.Init();
};

State.prototype.UpdateAnswers = function (answers, answered, winnerSelected) {
    var currentCardCount = $('#answers').find('.card:not(.outTop)').length;
    var $tempDiv = $('<div />').html(answers); //
    var showingAnswers = $tempDiv.find('.pickinTime').length > 0;
    var newCardsCount = $tempDiv.find('.card').length - currentCardCount;

    $('#answers').html(answers);

    if (answered) {
        if (!showingAnswers)
        {
            var completeCardArray = $('#answers').find('.card');

            for (var i = 0; i < currentCardCount; i++) {
                $(completeCardArray[i]).removeClass('outTop');
            }
        }

		$('#hand').addClass('hidden');
		$('#answers').removeClass('hidden');

		if (winnerSelected) {
		    $('.pickMultiple.noShadow').removeClass('noShadow');
		    ArmedCards.Game.Hand.DealAnswersComplete();
		}
		else {
		    ArmedCards.Game.Hand.DealAnswers();
		}
	}
};

State.prototype.WinnerSelected = function (answers, playerList, gameView, isWaiting, gameOver) {
	ArmedCards.Game.State.UpdateAnswers(answers, true, true);

	ArmedCards.Game.State.UpdateLobby(playerList);

	ArmedCards.Game.State.NewRoundStarting(gameView, isWaiting, gameOver);
};

State.prototype.NewRoundStarting = function (gameView, isWaiting, gameOver) {
	var options = {
		"positionClass": "toast-bottom-full-width",
		"fadeIn": 300,
		"fadeOut": 1000,
		"timeOut": 14000,
		"extendedTimeOut": 0,
		"newestOnTop": false,
		"messageClass": "toast-message messageContainer"
	};

	var message = "Starting in {0} seconds...";
	var title = "New Round";

	if (gameOver) {
		message = "Display final scoreboard in {0} seconds...";
		title = "Game Over!";
	}

	toastr.info(message.format("15"), title, options);
	for (var i = 14; i > 0; i--) {
		var delay = (15 - i) * 1000;

		ArmedCards.Game.State.RoundAlert(delay, i.toString(), message);
	}

	setTimeout(function () {
		ArmedCards.Game.State.UpdateGame(gameView);

		if (isWaiting) {
			ArmedCards.Game.Waiting.currentQuestion = null;
			ArmedCards.Game.Waiting.StartWaiting();
		}
		else {

		}
	}, 15000);
};

State.prototype.RoundAlert = function (timeDelay, timeLeft, message) {
    setTimeout(function () {
        ArmedCards.Game.Common.UpdateMessageDiv(message.format(timeLeft));
	}, timeDelay);
};

State.prototype.UpdateGameView = function (gameView, playerList) {
	ArmedCards.Game.State.UpdateGame(gameView);
	ArmedCards.Game.State.UpdateLobby(playerList);
};

State.prototype.UpdateLobby = function (playerList) {
	$('#gameLobby').html(playerList)
};

State.prototype.CommanderLeft = function (gameView, playerList, commanderName, isWaiting) {
	ArmedCards.Game.State.UpdateGameView(gameView, playerList);

	var options = {
		"positionClass": "toast-bottom-full-width",
		"fadeIn": 300,
		"fadeOut": 1000,
		"timeOut": 8000,
		"extendedTimeOut": 0,
		"newestOnTop": false
	};

	var message = "{0} cares about nobody and has abandoned their post.";
	var title = "Round has been lost";

	toastr.info(message.format(commanderName), title, options);

	if (isWaiting) {
		ArmedCards.Game.Waiting.currentQuestion = null;
		ArmedCards.Game.Waiting.Init();
	}
};

State.prototype.VoteToKickResults = function (message, title, kick, kickUserId) {
	var options = {
		"positionClass": "toast-bottom-full-width",
		"fadeIn": 300,
		"fadeOut": 500,
		"timeOut": 5000,
		"extendedTimeOut": 0,
		"newestOnTop": false
	};

	toastr.info(message, title, options);
	
	$('#alert-vote-{0}'.format(kickUserId)).remove();

	if (kick) {
		window.location = "/GameListing";
	}
};

State.prototype.AlertUsersVote = function (partial, kickUser) {
	var $alertContainer = $('#alert-container');

	var $userAlert = $('#alert-vote-{0}'.format(kickUser.UserId));

	if ($userAlert.length == 0) {
		$alertContainer.append(partial);
	}
	else {
		$('#alert-vote-{0}'.format(kickUser.UserId)).html(partial);
	}
};

State.prototype.Init = function () {
	var hub = $.connection.ArmedCardsHub;
	hub.client.UpdateAnswers = ArmedCards.Game.State.UpdateAnswers;
	hub.client.WinnerSelected = ArmedCards.Game.State.WinnerSelected;
	hub.client.UpdateGameView = ArmedCards.Game.State.UpdateGameView;
	hub.client.UpdateLobbyView = ArmedCards.Game.State.UpdateLobby;
	hub.client.CommanderLeft = ArmedCards.Game.State.CommanderLeft;
	hub.client.VoteToKickResults = ArmedCards.Game.State.VoteToKickResults;
	hub.client.AlertUsersVote = ArmedCards.Game.State.AlertUsersVote;
};

State.prototype.ConnectionSuccess = function () {

};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.State.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.State.ConnectionSuccess);