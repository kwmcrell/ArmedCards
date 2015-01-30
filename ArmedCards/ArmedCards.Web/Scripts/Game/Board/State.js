/// <reference path="Hand.js" />
/// <reference path="Common.js" />
/// <reference path="Waiting.js" />
/// <reference path="ViewModels.js" />
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

State.prototype.UpdateGame = function (gameBoardViewModel) {
    ArmedCards.Game.Waiting.ClearTimeout();

    ArmedCards.Game.ViewModels.GameHeaderViewModel.UpdateModel(gameBoardViewModel.HeaderViewModel);

    ArmedCards.Game.ViewModels.GameOverViewModel.UpdateModel(gameBoardViewModel.GameOverViewModel);

    ArmedCards.Game.ViewModels.GameWaitingViewModel.UpdateModel(gameBoardViewModel.WaitingViewModel);

    ArmedCards.Game.ViewModels.GameRoundQuestionViewModel.UpdateModel(gameBoardViewModel.RoundQuestionViewModel);

    ArmedCards.Game.ViewModels.GameAnswers.UpdateModel(gameBoardViewModel.AnswersViewModel);

    ArmedCards.Game.ViewModels.GameHand.UpdateModel(gameBoardViewModel.HandViewModel);

	ArmedCards.Game.Common.Init();
	ArmedCards.Game.Hand.Init();
};

State.prototype.UpdateAnswers = function (answersViewModel, answered, winnerSelected) {
    var currentCardCount = $('#answers').find('.card:not(.outTop)').length;
    var newCardsCount = answersViewModel.GroupedAnswers.length - currentCardCount;

    ArmedCards.Game.ViewModels.GameAnswers.UpdateModel(answersViewModel);

    if (answered) {
        if (!answersViewModel.ShowAnswers)
        {
            var completeCardArray = $('#answers').find('.card');

            for (var i = 0; i < currentCardCount; i++) {
                $(completeCardArray[i]).removeClass('outTop');
            }
        }

        ArmedCards.Game.ViewModels.GameHand.Show(false);
        ArmedCards.Game.ViewModels.GameAnswers.HandShowing(false);

        $('#overlay').removeClass('on');
        $('#loadingScreen').removeClass('on');

		if (winnerSelected) {
		    $('.pickMultiple.noShadow').removeClass('noShadow');
		    ArmedCards.Game.Hand.DealAnswersComplete();
		}
		else {
		    ArmedCards.Game.Hand.DealAnswers();
		}
	}
};

State.prototype.WinnerSelected = function (answersViewModel, gameBoardViewModel, isWaiting, gameOver, completedRound) {
    $('#overlay').removeClass('on');
    $('#loadingScreen').removeClass('on');

    ArmedCards.Game.ViewModels.GameCompletedRounds.Rounds.unshift(completedRound);

    ArmedCards.Game.State.UpdateAnswers(answersViewModel, true, true);

    ArmedCards.Game.State.UpdateLobby(gameBoardViewModel.LobbyViewModel);

    ArmedCards.Game.State.NewRoundStarting(gameBoardViewModel, isWaiting, gameOver);
};

State.prototype.NewRoundStarting = function (gameBoardViewModel, isWaiting, gameOver) {
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
	    ArmedCards.Game.State.UpdateGame(gameBoardViewModel);

		if (isWaiting) {
		    ArmedCards.Game.ViewModels.GameWaitingViewModel.UpdateModel(gameBoardViewModel.WaitingViewModel);

			ArmedCards.Game.Waiting.currentQuestion = null;
			ArmedCards.Game.Waiting.StartWaiting();
		}
	}, 15000);
};

State.prototype.RoundAlert = function (timeDelay, timeLeft, message) {
    setTimeout(function () {
        ArmedCards.Game.Common.UpdateMessageDiv(message.format(timeLeft));
	}, timeDelay);
};

State.prototype.UpdateGameView = function (gameBoardViewModel, lobbyViewModel) {
    ArmedCards.Game.State.UpdateGame(gameBoardViewModel);
    ArmedCards.Game.State.UpdateLobby(lobbyViewModel);
};

State.prototype.UpdateLobby = function (json) {
    $.Topic("lobbyUpdated").publish(json);
};

State.prototype.CommanderLeft = function (gameBoardViewModel, lobbyViewModel, commanderName, isWaiting) {
    ArmedCards.Game.State.UpdateGameView(gameBoardViewModel, lobbyViewModel);

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
	
	ArmedCards.Game.ViewModels.GameVotesToKick.RemoveVote(kickUserId);

	if (kick) {
		window.location = "/GameListing";
	}
};

State.prototype.AlertUsersVote = function (vote) {
	var $userAlert = $('#alert-vote-{0}'.format(vote.UserToKick.UserId));

	if ($userAlert.length == 0) {
	    ArmedCards.Game.ViewModels.GameVotesToKick.Votes.push(ko.mapping.fromJS(vote));
	}
	else {
	    ArmedCards.Game.ViewModels.GameVotesToKick.UpdateVote(vote);
	}
};

State.prototype.ForceLeave = function () {
    window.location = "/GameListing";
};

State.prototype.Beforeunload = function () {
    var isPersistent = $('#Game_IsPersistent').val().toLowerCase();

    if (isPersistent == 'false') {
        $.ajax({
            type: 'POST',
            url: $('#leaveGameLink').attr('href') + '&windowUnload=true',
            async: false
        });
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
	hub.client.ForceLeave = ArmedCards.Game.State.ForceLeave;

	$(window).bind('beforeunload', ArmedCards.Game.State.Beforeunload);
};

State.prototype.ConnectionSuccess = function () {

};

State.prototype.ConnectionReconnected = function () {
    $.connection.ArmedCardsHub.server.RefreshGameView($('#Game_GameID').val(), $('#ConnectionType').val());
};


$.Topic("beforeHubStart").subscribe(ArmedCards.Game.State.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.State.ConnectionSuccess);
$.Topic("hubReconnected").subscribe(ArmedCards.Game.State.ConnectionReconnected)
