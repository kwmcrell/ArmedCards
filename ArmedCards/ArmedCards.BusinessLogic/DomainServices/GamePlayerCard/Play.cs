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
using DS = ArmedCards.BusinessLogic.DomainServices;

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IPlay"/>
	/// </summary>
	public class Play : Base.IPlay
	{
		private AS.GamePlayerCard.Base.ISelect _selectGamePlayerCard;
		private AS.GameRound.Base.ISelect _selectGameRound;
		private AS.GameRoundCard.Base.IInsert _insertGameRoundCard;

		public Play(AS.GamePlayerCard.Base.ISelect selectGamePlayerCard,
					AS.GameRound.Base.ISelect selectGameRound,
					AS.GameRoundCard.Base.IInsert insertGameRoundCard)
		{
			this._selectGamePlayerCard = selectGamePlayerCard;
			this._selectGameRound = selectGameRound;
			this._insertGameRoundCard = insertGameRoundCard;
		}

		/// <summary>
		/// Play a list of cards from a user's hand
		/// </summary>
		/// <param name="cardIDs">The card IDs the user has selected </param>
		/// <param name="gameID">The game ID in which the user wants to play the card</param>
		/// <param name="userId">The user Id</param>
		/// <returns>PlayCard action result containing any errors and the round the card was played.</returns>
		public Entities.ActionResponses.PlayCard Execute(List<Int32> cardIDs, Int32 gameID, Int32 userId)
		{
			Entities.ActionResponses.PlayCard playResponse = new Entities.ActionResponses.PlayCard();

			List<Entities.GamePlayerCard> cards = _selectGamePlayerCard.Execute(gameID, userId);

			//Check that the user did not play cards they do not have
			List<Int32> missedIds = CheckHand(cards, cardIDs);

			if (missedIds.Count == 0)
			{
				Entities.GameRound round = _selectGameRound.Execute(gameID, false);

				//Validate the correct number of cards were played
				if (round.ValidateCardPlayedCount(cardIDs.Count))
				{
					//Create GameRoundCards for played cards
					List<Entities.GameRoundCard> playedCards = CreateRoundCards(cardIDs, userId, round.GameRoundID, gameID);

					//Insert playedCards
					_insertGameRoundCard.Execute(playedCards);

					//Select round with game cards
					round = _selectGameRound.Execute(gameID, true);

					playResponse.CurrentRound = round;
					playResponse.ResponseCode = Entities.ActionResponses.Enums.PlayCardResponseCode.Success;
				}
				else
				{
					playResponse.ResponseCode = Entities.ActionResponses.Enums.PlayCardResponseCode.InvalidNumberOfCardsPlayed;
				}
			}
			else
			{
				playResponse.ResponseCode = Entities.ActionResponses.Enums.PlayCardResponseCode.InvalidCardPlayed;
			}

			return playResponse;
		}

		private List<Entities.GameRoundCard> CreateRoundCards(List<Int32> cardIDs, Int32 userId, 
															  Int32 gameRoundID, Int32 gameID)
		{
			DateTime datePlayed = DateTime.UtcNow;

			List<Entities.GameRoundCard> playedCards = new List<Entities.GameRoundCard>();

			foreach (Int32 cardID in cardIDs)
			{
				playedCards.Add(new Entities.GameRoundCard
				{
					Card_CardID = cardID,
					DatePlayed = datePlayed,
					GameRound_GameRoundID = gameRoundID,
					Game_GameID = gameID,
					PlayedBy_UserId = userId,
					PlayOrder = (Int16)cardIDs.IndexOf(cardID)
				});
			}

			return playedCards;
		}

		/// <summary>
		/// Check to see if the player has <paramref name="cardIDs"/> in their hand
		/// </summary>
		/// <param name="cardIDs">List of card IDs to check if present in player's hand</param>
		/// <returns>Any ids that were not found in the player's hand</returns>
		private List<Int32> CheckHand(List<Entities.GamePlayerCard> cards, List<Int32> cardIDs)
		{
			List<Int32> missingIds = new List<int>();

			Int32 indexOf = -1;

			foreach (Int32 cardID in cardIDs)
			{
				indexOf = cards.FindIndex(x => x.CardID == cardID);

				if (indexOf < 0)
				{
					missingIds.Add(cardID);
				}
			}

			return missingIds;
		}
	}
}
