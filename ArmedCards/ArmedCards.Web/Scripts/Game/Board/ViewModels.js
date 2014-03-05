/// <reference path="../../knockout-3.0.0.js" />
/// <reference path="../../knockout.mapping-latest.js" />

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

    this.UpdateModel = function (newModel) {
        var self = this;

        self.Players.removeAll();

        self.Players(newModel.Players);

        self.Spectators.removeAll();

        self.Spectators(newModel.Spectators);
    }.bind(this);
};

var GameHeader = function (headerLink, headerText, subHeaderText) {
    this.HeaderLink = ko.observable(headerLink);
    this.HeaderText = ko.observable(headerText);
    this.SubHeaderText = ko.observable(subHeaderText);

    this.UpdateModel = function (newModel) {
        var self = this;

        self.HeaderLink(newModel.HeaderLink);
        self.HeaderText(newModel.HeaderText);
        self.SubHeaderText(newModel.SubHeaderText);
    }.bind(this);
};

var GameOver = function (hasWinner, winner, rankedPlayers, gameID) {
    this.HasWinner = ko.observable(hasWinner);
    this.Winner = ko.observable(winner);
    this.RankedPlayers = ko.observableArray(rankedPlayers);
    this.GameID = ko.observable(gameID);

    this.UpdateModel = function (newModel) {
        var self = this;

        self.HasWinner(newModel.HasWinner);
        self.Winner(newModel.Winner);
        self.RankedPlayers.removeAll();
        self.RankedPlayers(newModel.RankedPlayers);
        self.GameID(newModel.GameID);
    }.bind(this);
};

var GameWaiting = function (showWaiting) {
    this.ShowWaiting = ko.observable(showWaiting);

    this.UpdateModel = function (newModel) {
        var self = this;

        self.ShowWaiting(newModel.ShowWaiting);
    }.bind(this);
};

var GameRoundQuestion = function (question, instructions, showQuestion) {
    this.Question = ko.observable(question);
    this.Instructions = ko.observable(instructions);
    this.ShowQuestion = ko.observable(showQuestion);
    this.ApplyOutTopTop = ko.observable(true);

    this.UpdateModel = function (newModel) {
        var self = this;

        $('.question.card').removeAttr('style');
        self.ApplyOutTopTop(true);

        self.Question(newModel.Question);
        self.Instructions(newModel.Instructions);
        self.ShowQuestion(newModel.ShowQuestion);
    }.bind(this);
};

var GameAnswers = function (roundHasWinner, groupedAnswers, isCommander, waitingOnAllAnswers, showAnswers, handShowing, showBoard) {
    this.RoundHasWinner = ko.observable(roundHasWinner);
    this.GroupedAnswers = ko.observableArray(groupedAnswers);
    this.IsCommander = ko.observable(isCommander);
    this.WaitingOnAllAnswers = ko.observable(waitingOnAllAnswers);
    this.ShowAnswers = ko.observable(showAnswers);
    this.HandShowing = ko.observable(handShowing);
    this.ShowBoard = ko.observable(showBoard);

    this.UpdateModel = function (newModel) {
        var self = this;

        self.RoundHasWinner(newModel.RoundHasWinner);
        self.IsCommander(newModel.IsCommander);
        self.GroupedAnswers.removeAll();
        self.GroupedAnswers(newModel.GroupedAnswers);
        self.WaitingOnAllAnswers(newModel.WaitingOnAllAnswers);
        self.ShowAnswers(newModel.ShowAnswers);
        self.HandShowing(newModel.HandShowing);
        self.ShowBoard(newModel.ShowBoard);
    }.bind(this);
};

var GameHand = function (show, cards, showBoard) {
    this.Show = ko.observable(show);
    this.Cards = ko.observableArray(cards);
    this.ShowBoard = ko.observable(showBoard);

    this.UpdateModel = function (newModel) {
        var self = this;

        self.Show(newModel.Show);
        self.Cards.removeAll();
        self.Cards(newModel.Cards);
        self.ShowBoard(newModel.ShowBoard);
    }.bind(this);
};

var GameVotesToKick = function (votes) {
    if (votes.length > 0)
    {
        this.Votes = ko.mapping.fromJSON(votes);
    }
    else
    {
        this.Votes = ko.observableArray(votes);
    }

    this.RemoveVote = function (toKickUserId) {
        var self = this;

        self.Votes.remove(function (vote) {
            return vote.UserToKick.UserId = toKickUserId;
        });

    }.bind(this);

    this.UpdateVote = function (newVote) {
        var self = this;

        var oldVote = ko.utils.arrayFirst(self.Votes(), function (vote) {
            return vote.UserToKick.UserId = newVote.UserToKick.UserId;
        });

        oldVote.VotesToKick(newVote.VotesToKick);
        oldVote.VotesNotToKick(newVote.VotesNotToKick);
    }.bind(this);
};

var GameCompletedRounds = function (rounds) {
    this.Rounds = new ko.observableArray(rounds);
    this.Hidden = new ko.observable(true);
};