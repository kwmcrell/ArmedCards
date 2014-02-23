/// <reference path="Common.js" />
/// <reference path="../jQuery/jquery-1.9.1.js" />
/// <reference path="../../GreenSock/TweenMax.js" />
/// <reference path="../../GreenSock/TimelineMax.js" />
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

function Hand() {
	this.MultiPicks = {
		Pick1: { CssClass: 'first', Available: true, Number: 1 },
		Pick2: { CssClass: 'second', Available: true, Number: 2 },
		Pick3: { CssClass: 'third', Available: true, Number: 3 }
	};

	this.CurrentPickCount = 1;
}

if (!ArmedCards.Game.Hand) {
	ArmedCards.Game.Hand = new Hand();
}

Hand.prototype.DisplaySelectedCards = function (cards, $card) {
	$('#overlay').addClass('on');
	$('#cardToPlayConfirm').addClass('on');
	ArmedCards.Game.Hand.CurrentPickCount++;

	$card.addClass('picked');
	$card.addClass('lastPicked');

	cards.push(ArmedCards.Game.Common.GetFullElementHTML($card));

	$('#cardToPlay').html(cards.join(""));
}

Hand.prototype.CardSelected = function (event) {
	event.preventDefault();
	var $card = $(this);

	if (ArmedCards.Game.Common.CurrentInstructions == ArmedCards.Game.Common.QuestionInstructions.Pick2) {
		ArmedCards.Game.Hand.CardSelectedPick2($card);
	}
	else if (ArmedCards.Game.Common.CurrentInstructions == ArmedCards.Game.Common.QuestionInstructions.Draw2Pick3) {
		ArmedCards.Game.Hand.CardSelectedPick3($card);
	}
	else {
		var cards = new Array();
		ArmedCards.Game.Hand.DisplaySelectedCards(cards, $card);
	}
};

Hand.prototype.CardSelectedPick2 = function ($card) {
	if (ArmedCards.Game.Hand.CurrentPickCount == 1 && !$card.hasClass('picked')) {
		ArmedCards.Game.Hand.SelectCard($card);
	}
	else if (ArmedCards.Game.Hand.CurrentPickCount == 2 && !$card.hasClass('picked')) {
		var cards = new Array();
		cards.push(ArmedCards.Game.Common.GetFullElementHTML($('.answer.card.picked.first')));

		ArmedCards.Game.Hand.DisplaySelectedCards(cards, $card);
	}
	else {
		ArmedCards.Game.Hand.UnselectCard($card);
	}
};

Hand.prototype.CardSelectedPick3 = function ($card) {
	if (ArmedCards.Game.Hand.CurrentPickCount < 3 && !$card.hasClass('picked')) {
		ArmedCards.Game.Hand.SelectCard($card);
	}
	else if (ArmedCards.Game.Hand.CurrentPickCount == 3 && !$card.hasClass('picked')) {
		var cards = new Array();
		cards.push(ArmedCards.Game.Common.GetFullElementHTML($('.answer.card.picked.first')));
		cards.push(ArmedCards.Game.Common.GetFullElementHTML($('.answer.card.picked.second')));

		ArmedCards.Game.Hand.DisplaySelectedCards(cards, $card);
	}
	else {
		ArmedCards.Game.Hand.UnselectCard($card);
	}
};

Hand.prototype.SelectCard = function ($card) {
	$('[name="pickOrder"]', $card).removeClass('hidePickOrder');
	$card.addClass('picked');

	if (ArmedCards.Game.Hand.MultiPicks.Pick1.Available == true) {
		$card.addClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);
		ArmedCards.Game.Hand.MultiPicks.Pick1.Available = false;
	}
	else if (ArmedCards.Game.Hand.MultiPicks.Pick2.Available == true) {
		$card.addClass(ArmedCards.Game.Hand.MultiPicks.Pick2.CssClass);
		ArmedCards.Game.Hand.MultiPicks.Pick2.Available = false;
	}

	ArmedCards.Game.Hand.CurrentPickCount++;
	if (ArmedCards.Game.Hand.MultiPicks.Pick2.Available == true) {
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
	}
	else {
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick3.Number);
	}
};

Hand.prototype.UnselectCard = function ($card) {
	if ($card.hasClass('picked')) {
		$card.removeClass('picked');

		var pick1 = $card.hasClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);
		var pick2 = $card.hasClass(ArmedCards.Game.Hand.MultiPicks.Pick2.CssClass);

		if (pick1) {
			$card.removeClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);
			ArmedCards.Game.Hand.MultiPicks.Pick1.Available = true;
			ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick1.Number);
		}
		else if (pick2) {
			$card.removeClass(ArmedCards.Game.Hand.MultiPicks.Pick2.CssClass);
			ArmedCards.Game.Hand.MultiPicks.Pick2.Available = true;
			if (ArmedCards.Game.Hand.MultiPicks.Pick1.Available == true) {
				ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick1.Number);
			}
			else {
				ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
			}
		}

		ArmedCards.Game.Hand.CurrentPickCount--;

		var $pickOrder = $('[name="pickOrder"]', $card);
		$pickOrder.addClass('hidePickOrder');
		$card.one({
			mouseout: function () {
				$pickOrder.removeClass('hidePickOrder');
			}
		});
	}
};

Hand.prototype.CancelPlay = function (event) {
	event.preventDefault();
	$('#overlay').removeClass('on');
	$('#cardToPlayConfirm').removeClass('on');

	$('#cardToPlay').empty();

	var $lastPicked = $('.answer.card.picked.lastPicked');
	$lastPicked.removeClass('picked');
	$lastPicked.removeClass('lastPicked');

	if (ArmedCards.Game.Common.CurrentInstructions == ArmedCards.Game.Common.QuestionInstructions.Pick2) {
		ArmedCards.Game.Hand.CurrentPickCount = ArmedCards.Game.Hand.MultiPicks.Pick2.Number;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
	}
	else if (ArmedCards.Game.Common.CurrentInstructions == ArmedCards.Game.Common.QuestionInstructions.Draw2Pick3) {
		ArmedCards.Game.Hand.CurrentPickCount = ArmedCards.Game.Hand.MultiPicks.Pick3.Number;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick3.Number);
	}
};

Hand.prototype.HandlePickOrder = function (value) {
	if (ArmedCards.Game.Common.CurrentInstructions > ArmedCards.Game.Common.QuestionInstructions.Normal) {
		$('[name="pickOrder"]', $('#hand')).addClass('pickOrder');

		$('[name="pickOrder"]', $('#hand')).not($('.answer.card.picked [name="pickOrder"]'))
                                           .html(value);
	}
};

Hand.prototype.PlayCard = function (event) {
	event.preventDefault();
	$('#overlay').removeClass('on');
	$('#cardToPlayConfirm').removeClass('on');

	var data = {
		GameID: $('#Game_GameID').val(),
		CardIDs: ArmedCards.Game.Common.GetChildrenIDs($('#cardToPlay'))
	};

	$.connection.ArmedCardsHub.server.PlayCard(data);

	$('#cardToPlay').empty();
};

Hand.prototype.Init = function () {
	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Hand.CardSelected
	}, '.hand .answer.card')
	.on({
		click: ArmedCards.Game.Hand.CardSelected
	}, '.hand .answer.card');

	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Hand.CancelPlay
	}, '#cardToPlayNope')
	.on({
		click: ArmedCards.Game.Hand.CancelPlay
	}, '#cardToPlayNope');

	$('#gameContainer')
	.off({
		click: ArmedCards.Game.Hand.PlayCard
	}, '#cardToPlaySubmit')
	.on({
		click: ArmedCards.Game.Hand.PlayCard
	}, '#cardToPlaySubmit');

	if ($('#answers').is(':visible')) {
	    ArmedCards.Game.Hand.DealAnswers();
	}
	else {
	    ArmedCards.Game.Hand.DealHand();
	}

	if (ArmedCards.Game.Common.CurrentInstructions > ArmedCards.Game.Common.QuestionInstructions.Normal) {
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick1.Number);
	}
	ArmedCards.Game.Hand.CurrentPickCount = 1;
};

Hand.prototype.DealHand = function () {
    TweenMax.staggerTo($('.hand .answer.card.outTop'), .4, { left: "0%", top: "0em", onComplete: ArmedCards.Game.Hand.DealCard }, .4);
};

Hand.prototype.DealAnswers = function () {
    TweenMax.staggerTo($('#answers .answer.card.outTop'), .4, { left: "0%", top: "0em", onComplete: ArmedCards.Game.Hand.DealCard }, .4,
                        ArmedCards.Game.Hand.DealAnswersComplete);
};

Hand.prototype.DealAnswersComplete = function () {
    var winnerPicked = $('.winnerPicked');

    if (winnerPicked != null) {
        setTimeout(function () {
            $('#roundWinner').addClass('winner');

            var $winningUser = $('.user.winningUser');

            $winningUser.show();

            setTimeout(function () {
                TweenMax.to($winningUser, .5, { height: "100px" });
                $winningUser.addClass('visible');

                setTimeout(function () {
                    TweenMax.to('.user.losingUser', .1, { opacity: "1" });
                }, 500);
            }, 500);
        }, 500);
    }
};

Hand.prototype.DealCard = function () {
    var $target = $(this.target);
    var $parent = $target.parent();

    $target.removeClass('outTop');

    if($parent.hasClass('pickMultiple'))
    {
        var groupCount = parseInt($parent.attr('data-groupCount'));

        if($parent.children().index($target) == groupCount - 1)
        {
            setTimeout(function () { $parent.removeClass('noShadow'); }, 300);
        }
    }
};

Hand.prototype.ConnectionSuccess = function () {

};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Hand.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.Hand.ConnectionSuccess);