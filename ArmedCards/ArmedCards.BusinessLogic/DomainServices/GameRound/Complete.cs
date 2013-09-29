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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.DomainServices.GameRound
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IComplete"/>
	/// </summary>
	public class Complete : Base.IComplete
	{
		private AS.GameRound.Base.ISelect _selectGameRound;
		private AS.GameRoundCard.Base.IUpdate _updateGameRoundCard;
		private AS.GameRound.Base.IStart _startGameRoud;
		private AS.Game.Base.ISelect _selectGame;
		private AS.GamePlayer.Base.IUpdate _updateGamePlayer;

		public Complete(AS.GameRound.Base.ISelect selectGameRound,
						AS.GameRoundCard.Base.IUpdate updateGameRoundCard,
						AS.GameRound.Base.IStart startGameRoud,
						AS.Game.Base.ISelect selectGame,
						AS.GamePlayer.Base.IUpdate updateGamePlayer)
		{
			this._selectGameRound = selectGameRound;
			this._updateGameRoundCard = updateGameRoundCard;
			this._startGameRoud = startGameRoud;
			this._selectGame = selectGame;
			this._updateGamePlayer = updateGamePlayer;
		}

		/// <summary>
		/// Complete the current round
		/// </summary>
		/// <param name="gameID">The ID of the game that contains the round</param>
		/// <param name="cardIDs">The IDs of the winning cards</param>
		/// <param name="userId">The user Id trying to complete the round</param>
		public void Execute(Int32 gameID, List<Int32> cardIDs, Int32 userId)
		{
			Entities.GameRound currentRound = _selectGameRound.Execute(gameID, true);

			//Validate that the user trying to complete the round is in fact the commander
			if (currentRound.IsCommander(userId))
			{
				//Validate that select cards were actually played during the round
				List<Int32> invalidWinners = currentRound.ValidateWinnerSelection(cardIDs);

				if (invalidWinners.Count == 0)
				{
					Entities.User newCommander = currentRound.Answers.Find(x => x.Card_CardID == cardIDs.First()).PlayedBy;

					//Update cards as winners
					Entities.Filters.GameRoundCard.UpdateWinner cardfilter = new Entities.Filters.GameRoundCard.UpdateWinner();
					cardfilter.CardIDs = cardIDs;
					cardfilter.GameID = gameID;

					_updateGameRoundCard.Execute(cardfilter);

					//Update player points
					Entities.Filters.GamePlayer.UpdatePoints playerFilter = new Entities.Filters.GamePlayer.UpdatePoints();
					playerFilter.GameID = gameID;
					playerFilter.UserId = newCommander.UserId;

					_updateGamePlayer.Execute(playerFilter);

					//Start round
					Entities.Filters.Game.Select gameFilter = new Entities.Filters.Game.Select();
					gameFilter.GameID = gameID;

					Entities.Game game = _selectGame.Execute(gameFilter);

					_startGameRoud.Execute(game, newCommander);
				}
			}
		}
	}
}
