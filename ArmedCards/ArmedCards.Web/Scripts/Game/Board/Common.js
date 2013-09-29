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

function Common() {
	this.QuestionInstructions = {
		Normal: 0,
		Pick2: 1,
		Draw2Pick3: 2
	};

	this.CurrentInstructions = 0;
}

if (!ArmedCards.Game.Common) {
	ArmedCards.Game.Common = new Common();
}

Common.prototype.SetCurrentInstructions = function () {
	var instructions = $('#CurrentRound_Question_Instructions').val();

	if (instructions != null) {
		ArmedCards.Game.Common.CurrentInstructions = parseInt(instructions);
	}
};

Common.prototype.GetFullElementHTML = function ($element) {
	return $element.clone().wrap('<div />').parent().html();
};


Common.prototype.GetChildrenIDs = function ($element) {
	var ids = new Array();

	$element.children().each(function () {
		ids.push($(this).attr('id'));
	});

	return ids;
};

Common.prototype.Init = function () {
	ArmedCards.Game.Common.SetCurrentInstructions();
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.Common.Init);