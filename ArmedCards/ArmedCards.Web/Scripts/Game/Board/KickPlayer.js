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

function KickPlayer() {

}

if (!ArmedCards.Game.KickPlayer) {
	ArmedCards.Game.KickPlayer = new KickPlayer();
}

KickPlayer.prototype.Kick = function (e) {
	e.preventDefault();

	var userId = $(this).attr('data-userId');

	ArmedCards.Game.KickPlayer.Vote(true, userId);
	ArmedCards.Game.KickPlayer.RemoveAlert(userId);
};

KickPlayer.prototype.Keep = function (e) {
	e.preventDefault();

	var userId = $(this).attr('data-userId');

	ArmedCards.Game.KickPlayer.Vote(false, userId);

	ArmedCards.Game.KickPlayer.RemoveAlert(userId);
};

KickPlayer.prototype.RemoveAlert = function (userId) {
    ArmedCards.Game.ViewModels.GameVotesToKick.RemoveVote(userId);
	//$('#alert-vote-{0}'.format(userId)).remove();
};

KickPlayer.prototype.Vote = function (vote, userId) {
	var data = {
		GameID: $('#Game_GameID').val(),
		KickUserId: userId,
		Kick: vote
	};

	$.connection.ArmedCardsHub.server.VoteToKick(data).done(ArmedCards.Game.KickPlayer.VoteCasted);
};

KickPlayer.prototype.VoteCasted = function (response) {
    if (!response.AllVotesCasted) {
        var options = {
            "positionClass": "toast-bottom-full-width",
            "fadeIn": 300,
            "fadeOut": 500,
            "timeOut": 5000,
            "extendedTimeOut": 0,
            "newestOnTop": false
        };

        toastr.info(response.Content, response.Title, options);
    }
};

KickPlayer.prototype.Init = function () {
	$('#gameLobby')
		.off({
			click: ArmedCards.Game.KickPlayer.Kick
		}, '[name="kickPlayer"]')
		.on({
			click: ArmedCards.Game.KickPlayer.Kick
		}, '[name="kickPlayer"]');

	$('#alert-container')
		.off({
			click: ArmedCards.Game.KickPlayer.Kick
		}, '[name="kickPlayer"]')
		.on({
			click: ArmedCards.Game.KickPlayer.Kick
		}, '[name="kickPlayer"]');

	$('#alert-container')
		.off({
			click: ArmedCards.Game.KickPlayer.Keep
		}, '[name="keepPlayer"]')
		.on({
			click: ArmedCards.Game.KickPlayer.Keep
		}, '[name="keepPlayer"]');
};

$.Topic("beforeHubStart").subscribe(ArmedCards.Game.KickPlayer.Init);