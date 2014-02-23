/// <reference path="ViewModels.js" />

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

function ViewModelInit() {

}

if (!ArmedCards.Game.ViewModelInit) {
    ArmedCards.Game.ViewModelInit = new ViewModelInit();
}

//***************************************************************//
// View model initialization
//**************************************************************//

ViewModelInit.prototype.GameHeader = function () {
    var $gameHeaderJson = $('#gameHeaderJson');

    var parsed = $.parseJSON($gameHeaderJson.val());
    $gameHeaderJson.remove();

    ArmedCards.Game.ViewModels.GameHeaderViewModel = new GameHeader(parsed.HeaderLink, parsed.HeaderText, parsed.SubHeaderText);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameHeaderViewModel, document.getElementById('gameHeader'));
};

ViewModelInit.prototype.GameOver = function () {
    var $gameOverJson = $('#gameOverJson');

    var parsed = $.parseJSON($gameOverJson.val());
    $gameOverJson.remove();

    ArmedCards.Game.ViewModels.GameOverViewModel = new GameOver(parsed.HasWinner, parsed.Winner, parsed.RankedPlayers, parsed.GameID);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameOverViewModel, document.getElementById('gameOverDiv'));
};

ViewModelInit.prototype.GameWaiting = function () {
    var $gameJson = $('#gameWaitingJson');

    var parsed = $.parseJSON($gameJson.val());
    $gameJson.remove();

    ArmedCards.Game.ViewModels.GameWaitingViewModel = new GameWaiting(parsed.ShowWaiting);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameWaitingViewModel, document.getElementById('waitingGame'));
};

ViewModelInit.prototype.GameRoundQuestion = function () {
    var $gameJson = $('#gameRoundQuestionJson');

    var parsed = $.parseJSON($gameJson.val());
    $gameJson.remove();

    ArmedCards.Game.ViewModels.GameRoundQuestionViewModel = new GameRoundQuestion(parsed.Question, parsed.Instructions, parsed.ShowQuestion);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameRoundQuestionViewModel, document.getElementById('gameRoundQuestionDiv'));
};

ViewModelInit.prototype.GameAnswers = function () {
    var $gameJson = $('#gameAnswersJson');

    var parsed = $.parseJSON($gameJson.val());
    $gameJson.remove();

    ArmedCards.Game.ViewModels.GameAnswers = new GameAnswers(parsed.RoundHasWinner,
                                                             parsed.GroupedAnswers,
                                                             parsed.IsCommander,
                                                             parsed.WaitingOnAllAnswers,
                                                             parsed.ShowAnswers,
                                                             parsed.HandShowing,
                                                             parsed.ShowBoard);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameAnswers, document.getElementById('answers'));
};

ViewModelInit.prototype.GameHand = function () {
    var $gameJson = $('#gameHandJson');

    var parsed = $.parseJSON($gameJson.val());
    $gameJson.remove();

    ArmedCards.Game.ViewModels.GameHand = new GameHand(parsed.Show, parsed.Cards, parsed.ShowBoard);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameHand, document.getElementById('hand'));
};

ViewModelInit.prototype.GameLobby = function () {
    var $lobbyJson = $('#lobbyJson');
    
    var parsed = $.parseJSON($lobbyJson.val());
    $lobbyJson.remove();

    ArmedCards.Game.ViewModels.GameLobbyViewModel = new GameLobby(parsed.Players, parsed.Spectators);

    ko.applyBindings(ArmedCards.Game.ViewModels.GameLobbyViewModel, document.getElementById('gameLobby'));
};

$.Topic("renderViews").subscribe(function () {
    ArmedCards.Game.ViewModelInit.GameHeader();
    ArmedCards.Game.ViewModelInit.GameLobby();
    ArmedCards.Game.ViewModelInit.GameOver();
    ArmedCards.Game.ViewModelInit.GameWaiting();
    ArmedCards.Game.ViewModelInit.GameRoundQuestion();
    ArmedCards.Game.ViewModelInit.GameAnswers();
    ArmedCards.Game.ViewModelInit.GameHand();
});