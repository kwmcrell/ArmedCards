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
using ArmedCards.Library.Extensions;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.DomainServices.Card
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IShuffle"/>
	/// </summary>
	public class Shuffle : Base.IShuffle
	{
		private AS.Card.Base.ISelect _selectCard;

		public Shuffle(AS.Card.Base.ISelect selectCard)
		{
			this._selectCard = selectCard;
		}

		/// <summary>
		/// Get cards shuffle and seperate into questions and answers
		/// </summary>
		/// <param name="game">The game to get cards for</param>
		/// <param name="questions">A list of question cards</param>
		/// <param name="answers">A list of answer cards</param>
		public void Execute(Entities.Game game, out List<Entities.Card> questions, out List<Entities.Card> answers)
		{
			Entities.Filters.Card.SelectForDeal filter = new Entities.Filters.Card.SelectForDeal();
			filter.GameID = game.GameID;

			List<Entities.Card> cards = _selectCard.Execute(filter);

			cards.Shuffle();

			questions = cards.Where(x => x.Type == Entities.Enums.Card.CardType.Question).ToList();
			answers = cards.Where(x => x.Type == Entities.Enums.Card.CardType.Answer).ToList();

			questions.Shuffle();
			answers.Shuffle();
		}
	}
}
