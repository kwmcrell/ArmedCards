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
using DS = ArmedCards.BusinessLogic.DomainServices.GamePlayerCard;

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ICreateHand"/>
	/// </summary>
	public class CreateHand : Base.ICreateHand
	{
		private DS.Base.IInsert _insertPlayerCard;

		public CreateHand(DS.Base.IInsert insertPlayerCard)
		{
			this._insertPlayerCard = insertPlayerCard;
		}

		/// <summary>
		/// Create hands for all players in the game
		/// </summary>
		/// <param name="answers">List of answers that can be dealt</param>
		/// <param name="drawCount">Dictionary for the number of cards needed for each player</param>
		/// <param name="game">The current game</param>
		public void Execute(List<Entities.Card> answers, Dictionary<Int32, Int32> numbersToDraw, Entities.Game game)
		{
			List<Entities.GamePlayerCard> dealtAnswers = new List<Entities.GamePlayerCard>();

			Int32 drawCount = 0;

			foreach (Entities.GamePlayer player in game.Players)
			{
				drawCount = 0;

				numbersToDraw.TryGetValue(player.User.UserId, out drawCount);

				List<Entities.GamePlayerCard> hand = Execute(drawCount, player.User.UserId, game.GameID, answers);

				player.Hand.AddRange(hand);

				dealtAnswers.AddRange(hand);
			}

			_insertPlayerCard.Execute(dealtAnswers);
		}

		private List<Entities.GamePlayerCard> Execute(Int32 drawCount, Int32 userId, Int32 gameID,
															 List<Entities.Card> answers)
		{
			IEnumerable<Entities.GamePlayerCard> hand =
				answers.Take(drawCount).Select(card => new Entities.GamePlayerCard(card, gameID, userId));

			answers.RemoveRange(0, drawCount);

			return hand.ToList();
		}
	}
}
