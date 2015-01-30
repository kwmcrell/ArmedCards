/// <reference path="Common.js" />
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

function Commander() {
	
}

if (!ArmedCards.Game.Commander) {
	ArmedCards.Game.Commander = new Commander();
}

Commander.prototype.WinnerSelected = function (event) {
	event.preventDefault();

	$('#overlay').addClass('on');
	$('#winnerConfirm').addClass('on');

	var $card = $(this);
	var html = new Array();

	if (ArmedCards.Game.Common.CurrentInstructions > ArmedCards.Game.Common.QuestionInstructions.Normal) {
		ArmedCards.Game.Commander.WinnerSelectedMulti($card, html);
	}
	else {
		html.push(ArmedCards.Game.Common.GetFullElementHTML($card));
	}

	$('#winnerCard').html(html.join(""));
};

Commander.prototype.WinnerSelectedMulti = function ($card, html) {
	var profileId = $card.attr('data-playedBy');

	html.push(ArmedCards.Game.Common.GetFullElementHTML($('[data-playedBy="' + profileId + '"][data-playOrder="0"]')));
	html.push(ArmedCards.Game.Common.GetFullElementHTML($('[data-playedBy="' + profileId + '"][data-playOrder="1"]')));

	if (ArmedCards.Game.Common.CurrentInstructions == ArmedCards.Game.Common.QuestionInstructions.Draw2Pick3) {
		html.push(ArmedCards.Game.Common.GetFullElementHTML($('[data-playedBy="' + profileId + '"][data-playOrder="2"]')));
	}
};

Commander.prototype.CancelWinner = function (event) {
	event.preventDefault();
	$('#overlay').removeClass('on');
	$('#winnerConfirm').removeClass('on');

	$('#winnerCard').empty();
};

Commander.prototype.PickWinner = function (event) {
	event.preventDefault();
	$('#overlay').removeClass('on');
	$('#winnerConfirm').removeClass('on');
	var $winnerCard = $('#winnerCard');

	var data = {
	    GameID: $('#Game_GameID').val(),
	    CardIDs: ArmedCards.Game.Common.GetChildrenIDs($winnerCard)
	};

	$('#overlay').addClass('on');
	$('#loadingScreen').addClass('on');
	$.connection.ArmedCardsHub.server.PickWinner(data);

	$winnerCard.empty();
};

Commander.prototype.PreventDefault = function (event) {
    event.preventDefault();
};

Commander.prototype.Init = function () {
	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Commander.WinnerSelected
	}, '.played.pick .answer.card')
	.on({
		click: ArmedCards.Game.Commander.WinnerSelected
	}, '.played.pick .answer.card');

	$('#gameContainer')
	.off({
	    click: ArmedCards.Game.Commander.PreventDefault
	}, '.played.noPick .answer.card')
	.on({
	    click: ArmedCards.Game.Commander.PreventDefault
	}, '.played.noPick .answer.card');

	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Commander.CancelWinner
	}, '#winnerNope')
	.on({
		click: ArmedCards.Game.Commander.CancelWinner
	}, '#winnerNope');

	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Commander.PickWinner
	}, '#winnerSubmit')
	.on({
		click: ArmedCards.Game.Commander.PickWinner
	}, '#winnerSubmit');
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Commander.Init);