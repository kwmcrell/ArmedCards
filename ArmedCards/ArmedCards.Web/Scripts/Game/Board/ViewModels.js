/// <reference path="../../knockout-3.0.0.js" />

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

function ViewModels() {

}

if (!ArmedCards.Game.ViewModels) {
    ArmedCards.Game.ViewModels = new ViewModels();
}

/***************************************************************/
// Knockout specific functions
/***************************************************************/

var GameLobby = function (currentPlayers, currentSpectators) {
    this.Players = ko.observableArray(currentPlayers);
    this.Spectators = ko.observableArray(currentSpectators);

    this.replacePlayers = function (newPlayers) {
        var self = this;

        self.Players.removeAll();

        self.Players(newPlayers);
    }.bind(this);

    this.replaceSpectators = function (newSpectators) {
        var self = this;

        self.Spectators.removeAll();

        self.Spectators(newSpectators);
    }.bind(this);
};

var GameHeader = function (headerLink, headerText, subHeaderText) {
    this.HeaderLink = ko.observable(headerLink);
    this.HeaderText = ko.observable(headerText);
    this.SubHeaderText = ko.observable(subHeaderText);
};

var GameOver = function (hasWinner, winner, rankedPlayers, gameID) {
    this.HasWinner = ko.observable(hasWinner);
    this.Winner = ko.observable(winner);
    this.RankedPlayers = ko.observableArray(rankedPlayers);
    this.GameID = ko.observable(gameID);
};

var GameWaiting = function (showWaiting) {
    this.ShowWaiting = ko.observable(showWaiting);
};

var GameRoundQuestion = function (question, instructions, showQuestion) {
    this.Question = ko.observable(question);
    this.Instructions = ko.observable(instructions);
    this.ShowQuestion = ko.observable(showQuestion);
};

var GameAnswers = function (roundHasWinner, groupedAnswers, isCommander, waitingOnAllAnswers, showAnswers, handShowing, showBoard) {
    this.RoundHasWinner = ko.observable(roundHasWinner);
    this.GroupedAnswers = ko.observableArray(groupedAnswers);
    this.IsCommander = ko.observable(isCommander);
    this.WaitingOnAllAnswers = ko.observable(waitingOnAllAnswers);
    this.ShowAnswers = ko.observable(showAnswers);
    this.HandShowing = ko.observable(handShowing);
    this.ShowBoard = ko.observable(showBoard);
};

var GameHand = function (show, cards, showBoard) {
    this.Show = ko.observable(show);
    this.Cards = ko.observableArray(cards);
    this.ShowBoard = ko.observable(showBoard);
};