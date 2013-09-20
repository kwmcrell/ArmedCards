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

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ICalculateDrawCount"/>
	/// </summary>
	public class CalculateDrawCount : Base.ICalculateDrawCount
	{
		private const Int32 HAND_SIZE = 10;

		/// <summary>
		/// Calculate the number of cards each player needs to draw in order to have a full hand
		/// </summary>
		/// <param name="question">The question card for the round</param>
		/// <param name="players">List of players in the game</param>
		/// <returns>A Dictionary that uses UserId as keys and number of cards needed as values</returns>
		public Dictionary<Int32, Int32> Execute(Entities.Card question, List<Entities.GamePlayer> players)
		{
			Dictionary<Int32, Int32> drawCount = new Dictionary<Int32, Int32>();

			foreach (Entities.GamePlayer player in players)
			{
				drawCount.Add(player.User.UserId, Execute(question, player.CardCount));
			}

			return drawCount;
		}

		/// <summary>
		/// Calculates the number of cards needed for a single player
		/// </summary>
		/// <param name="question">The question card</param>
		/// <param name="playerCardCount">The number of cards the player currently has</param>
		/// <returns>The number of cards the current player needs in order to have a valid hand</returns>
		private Int32 Execute(Entities.Card question, Int32 playerCardCount)
		{
			Int32 numberToDraw = HAND_SIZE - playerCardCount;

			if (question == null || question.Instructions == Entities.Enums.Card.Instructions.Draw2Pick3)
			{
				numberToDraw += 2;
			}

			return numberToDraw;
		}
	}
}
