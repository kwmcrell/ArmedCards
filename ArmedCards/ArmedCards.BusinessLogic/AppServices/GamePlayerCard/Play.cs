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
using DS = ArmedCards.BusinessLogic.DomainServices;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.AppServices.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IPlay"/>
	/// </summary>
	public class Play : Base.IPlay
	{
		private DS.GamePlayerCard.Base.IPlay _playCard;
		private AS.Game.Base.ISelect _selectGame;
		private AS.Hub.Base.ISendMessage _sendMessage;
		private AS.Game.Base.IUpdate _updateGame;

		public Play(DS.GamePlayerCard.Base.IPlay playCard,
					AS.Game.Base.ISelect selectGame,
					AS.Hub.Base.ISendMessage sendMessage,
					AS.Game.Base.IUpdate updateGame)
		{
			this._playCard = playCard;
			this._selectGame = selectGame;
			this._sendMessage = sendMessage;
			this._updateGame = updateGame;
		}

		/// <summary>
		/// Play a list of cards from a user's hand
		/// </summary>
		/// <param name="cardIDs">The card IDs the user has selected </param>
		/// <param name="gameID">The game ID in which the user wants to play the card</param>
		/// <param name="userId">The user Id</param>
		/// <param name="playedAction">Action to send to all active players</param>
		/// <returns>PlayCard action result containing any errors and the round the card was played.</returns>
		public Entities.ActionResponses.PlayCard Execute(List<Int32> cardIDs, Int32 gameID, Int32 userId,
														 Action<Entities.ActiveConnection, Entities.Game> playedAction)
		{
			Entities.ActionResponses.PlayCard response = _playCard.Execute(cardIDs, gameID, userId);

			if (response.ResponseCode == Entities.ActionResponses.Enums.PlayCardResponseCode.Success)
			{
				Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
				filter.DataToSelect = Entities.Enums.Game.Select.GamePlayerCards;
				filter.GameID = gameID;

				Entities.Game game = _selectGame.Execute(filter);

				game.Rounds.Add(response.CurrentRound);

				_sendMessage.Execute(game, playedAction, true);
				_updateGame.Execute(game.GameID, DateTime.UtcNow, null);
			}

			return response;
		}
	}
}
