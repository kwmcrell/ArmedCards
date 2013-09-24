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
	this.QuestionInstructions = {
		Normal: 0,
		Pick2: 1,
		Draw2Pick3: 2
	};

	this.MultiPicks = {
		Pick1: { CssClass: 'first', Available: true, Number: 1 },
		Pick2: { CssClass: 'second', Available: true, Number: 2 },
		Pick3: { CssClass: 'third', Available: true, Number: 3 }
	};

	this.CurrentInstructions = 0;
	this.CurrentPickCount = 1;
}

if (!ArmedCards.Game.Hand) {
	ArmedCards.Game.Hand = new Hand();
}

Hand.prototype.CardSelected = function (event) {
	event.preventDefault();

	if (ArmedCards.Game.Hand.CurrentInstructions == ArmedCards.Game.Hand.QuestionInstructions.Pick2) {
		ArmedCards.Game.Hand.CardSelectedPick2($(this));
	}
	else if (ArmedCards.Game.Hand.CurrentInstructions == ArmedCards.Game.Hand.QuestionInstructions.Draw2Pick3) {
		ArmedCards.Game.Hand.CardSelectedPick3($(this));
	}
	else {
		$('#overlay').addClass('on');
		$('#cardToPlayConfirm').addClass('on');

		var html = $(this).clone().wrap('<div />').parent().html();

		$('#cardToPlay').html(html);
	}
};

Hand.prototype.CardSelectedPick2 = function ($card) {
	if (ArmedCards.Game.Hand.CurrentPickCount == 1) {
		$('[name="pickOrder"]', $card).removeClass('hidePickOrder');
		$card.addClass('picked');
		$card.addClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);
		ArmedCards.Game.Hand.MultiPicks.Pick1.Available = false;

		ArmedCards.Game.Hand.CurrentPickCount++;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
	}
	else if (ArmedCards.Game.Hand.CurrentPickCount == 2 && !$card.hasClass('picked')) {
		$('#overlay').addClass('on');
		$('#cardToPlayConfirm').addClass('on');

		$card.addClass('picked');
		$card.addClass('lastPicked');
		ArmedCards.Game.Hand.CurrentPickCount++;

		var html = new Array();

		html.push(ArmedCards.Game.Hand.GetFullElementHTML($('.answer.card.picked.first')));
		html.push(ArmedCards.Game.Hand.GetFullElementHTML($card));

		$('#cardToPlay').html(html.join(""));
	}
	else if ($card.hasClass('picked')) {
		$card.removeClass('picked');
		$card.removeClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);

		ArmedCards.Game.Hand.CurrentPickCount = ArmedCards.Game.Hand.MultiPicks.Pick1.Number;
		ArmedCards.Game.Hand.MultiPicks.Pick1.Available = true;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick1.Number);

		var $pickOrder = $('[name="pickOrder"]', $card);
		$pickOrder.addClass('hidePickOrder');
		$card.one({
			mouseout: function () {
				$pickOrder.removeClass('hidePickOrder');
			}
		});
	}
};

Hand.prototype.CardSelectedPick3 = function ($card) {
	if (ArmedCards.Game.Hand.CurrentPickCount < 3 && !$card.hasClass('picked')) {
		$('[name="pickOrder"]', $card).removeClass('hidePickOrder');
		$card.addClass('picked');
		
		if (ArmedCards.Game.Hand.MultiPicks.Pick1.Available == true) {
			$card.addClass(ArmedCards.Game.Hand.MultiPicks.Pick1.CssClass);
			ArmedCards.Game.Hand.MultiPicks.Pick1.Available = false;
		}
		else if (ArmedCards.Game.Hand.MultiPicks.Pick2.Available == true)
		{
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
	}
	else if (ArmedCards.Game.Hand.CurrentPickCount == 3 && !$card.hasClass('picked')) {
		$('#overlay').addClass('on');
		$('#cardToPlayConfirm').addClass('on');
		ArmedCards.Game.Hand.CurrentPickCount++;

		$card.addClass('picked');
		$card.addClass('lastPicked');
		var html = new Array();

		html.push(ArmedCards.Game.Hand.GetFullElementHTML($('.answer.card.picked.first')));
		html.push(ArmedCards.Game.Hand.GetFullElementHTML($('.answer.card.picked.second')));
		html.push(ArmedCards.Game.Hand.GetFullElementHTML($card));

		$('#cardToPlay').html(html.join(""));
	}
	else {
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
			ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
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

	if (ArmedCards.Game.Hand.CurrentInstructions == ArmedCards.Game.Hand.QuestionInstructions.Pick2) {
		$('.answer.card.picked.lastPicked').removeClass('picked');
		ArmedCards.Game.Hand.CurrentPickCount = ArmedCards.Game.Hand.MultiPicks.Pick1.Number;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick2.Number);
	}
	else if (ArmedCards.Game.Hand.CurrentInstructions == ArmedCards.Game.Hand.QuestionInstructions.Draw2Pick3) {
		$('.answer.card.picked.lastPicked').removeClass('picked');
		ArmedCards.Game.Hand.CurrentPickCount = ArmedCards.Game.Hand.MultiPicks.Pick2.Number;
		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick3.Number);
	}
};

Hand.prototype.HandlePickOrder = function (value) {
	if (ArmedCards.Game.Hand.CurrentInstructions > ArmedCards.Game.Hand.QuestionInstructions.Normal) {
		$('[name="pickOrder"]', $('#hand')).addClass('pickOrder');

		$('[name="pickOrder"]', $('#hand')).not($('.answer.card.picked [name="pickOrder"]'))
                                           .html(value);
	}
};

Hand.prototype.HandleCardInstructions = function () {
	var instructions = $('#CurrentRound_Question_Instructions').val();

	if (instructions != null) {
		ArmedCards.Game.Hand.CurrentInstructions = parseInt(instructions);

		ArmedCards.Game.Hand.HandlePickOrder(ArmedCards.Game.Hand.MultiPicks.Pick1.Number);
	}
};

Hand.prototype.GetChildrenIDs = function ($element) {
	var ids = new Array();

	$element.children().each(function () {
		ids.push($(this).attr('id'));
	});

	return ids;
}

Hand.prototype.GetFullElementHTML = function ($element) {
	return $element.clone().wrap('<div />').parent().html();
};

Hand.prototype.Init = function () {
	$('.hand .answer.card').unbind().bind({
		click: ArmedCards.Game.Hand.CardSelected
	});

	$('#cardToPlayNope').unbind().bind({
		click: ArmedCards.Game.Hand.CancelPlay
	});

	$('#cardToPlaySubmit').unbind().bind({
		click: ArmedCards.Game.Hand.PlayCard
	});

	ArmedCards.Game.Hand.HandleCardInstructions();
};

Hand.prototype.ConnectionSuccess = function () {

};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Hand.Init);
$.Topic("hubStartComplete").subscribe(ArmedCards.Game.Hand.ConnectionSuccess);