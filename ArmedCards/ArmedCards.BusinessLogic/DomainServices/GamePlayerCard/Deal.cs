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
using ArmedCards.Library.Extensions;
using DS = ArmedCards.BusinessLogic.DomainServices;

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IDeal"/>
	/// </summary>
	public class Deal :	Base.IDeal
	{
		private DS.Card.Base.IShuffle _shuffleCards;
		private DS.Card.Base.IExcludeCurrentHands _excludeCurrentHands;
		private DS.Card.Base.IExcludeByCount _excludeByCount;
		private Base.ICalculateDrawCount _calculateDrawCount;
		private Base.ICreateHand _createHand;
		private DS.GameRoundCard.Base.IInsert _insertGameRoundCard;

		public Deal(DS.Card.Base.IShuffle shuffleCards,
					DS.Card.Base.IExcludeCurrentHands excludeCurrentHands,
					DS.Card.Base.IExcludeByCount excludeByCount,
					Base.ICalculateDrawCount calculateDrawCount,
					Base.ICreateHand createHand,
					DS.GameRoundCard.Base.IInsert insertGameRoundCard)
		{
			this._shuffleCards = shuffleCards;
			this._excludeCurrentHands = excludeCurrentHands;
			this._excludeByCount = excludeByCount;
			this._calculateDrawCount = calculateDrawCount;
			this._createHand = createHand;
			this._insertGameRoundCard = insertGameRoundCard;
		}

		/// <summary>
		/// Handle dealing cards to players in <paramref name="game"/>
		/// </summary>
		/// <param name="game">The game to deal cards for</param>
		public void Execute(Entities.Game game)
		{
			List<Entities.Card> questions;
			List<Entities.Card> answers;
			_shuffleCards.Execute(game, out questions, out answers);

			IEnumerable<Entities.Card> filteredQuestions = _excludeByCount.Execute(questions, game.QuestionShuffleCount);

			Entities.GameRoundCard dealtQuestion = CreateQuestion(filteredQuestions, game);

			IEnumerable<Entities.Card> filteredAnswers = _excludeCurrentHands.Execute(answers);

			Dictionary<Int32, Int32> drawCount = _calculateDrawCount.Execute(dealtQuestion.Card, game.Players);

			Boolean needMoreQuestions = dealtQuestion == null;
			Boolean needMoreAnswers = drawCount.Values.Sum() > filteredAnswers.Count();

			if (needMoreQuestions || needMoreAnswers)
			{
				//Update reshuffle counts
				filteredQuestions = _excludeByCount.Execute(questions, ++game.QuestionShuffleCount);

				//Reselect question card
				dealtQuestion = CreateQuestion(filteredQuestions, game);

				drawCount = _calculateDrawCount.Execute(dealtQuestion.Card, game.Players);
			}

			_insertGameRoundCard.Execute(new List<Entities.GameRoundCard> { dealtQuestion });
			game.CurrentRound().Question = dealtQuestion.Card;

			_createHand.Execute(filteredAnswers.ToList(), drawCount, game);
		}

		#region "Create Cards"

		private Entities.GameRoundCard CreateQuestion(IEnumerable<Entities.Card> cards, Entities.Game game)
		{
			Entities.Card card = cards.FirstOrDefault();

			Entities.GameRoundCard question = null;

			if (card != null)
			{
				Entities.GameRound round = game.CurrentRound();

				question = new Entities.GameRoundCard(card, round.CardCommander.UserId, round.GameRoundID, game.GameID);
			}

			return question;
		}

		#endregion "Create Cards"
	}
}
