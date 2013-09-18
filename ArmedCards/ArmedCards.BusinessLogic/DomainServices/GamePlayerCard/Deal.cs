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
		private const Int32 HAND_SIZE = 10;

		private DS.Card.Base.IShuffle _shuffleCards;
		private Base.IExcludeCurrentHands _excludeCurrentHands;

		public Deal(DS.Card.Base.IShuffle shuffleCards,
					Base.IExcludeCurrentHands excludeCurrentHands)
		{
			this._shuffleCards = shuffleCards;
			this._excludeCurrentHands = excludeCurrentHands;
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

			Entities.GamePlayerCard dealtQuestion = CreateQuestion(questions , game);

			IEnumerable<Entities.Card> filteredAnswers = _excludeCurrentHands.Execute(game, answers);

			Dictionary<Int32, Int32> numbersToDraw = CalculateNumbersToDraw(answers, dealtQuestion, game);

			Boolean needMoreQuestions = dealtQuestion == null;
			Boolean needMoreAnswers = numbersToDraw.Values.Sum() > answers.Count();

			if (needMoreQuestions || needMoreAnswers)
			{
				//Update reshuffle counts
				
				//Reselect question card
				dealtQuestion = CreateQuestion(questions , game);

				numbersToDraw = CalculateNumbersToDraw(answers, dealtQuestion, game);
			}

			List<Entities.GamePlayerCard> dealtAnswers = CreatePlayerHands(answers, numbersToDraw, game);
		}

		#region "Calculate number of cards needed per player"

		private Dictionary<Int32, Int32> CalculateNumbersToDraw(List<Entities.Card> answers, Entities.Card question,
															Entities.Game game)
		{
			Dictionary<Int32, Int32> numberToDraw = new Dictionary<Int32, Int32>();

			foreach (Entities.GamePlayer player in game.Players)
			{
				numberToDraw.Add(player.User.UserId, CalculateNumberToDraw(question, player.CardCount));
			}

			return numberToDraw;
		}

		private Int32 CalculateNumberToDraw(Entities.Card question, Int32 playerCardCount)
		{
			Int32 numberToDraw = HAND_SIZE - playerCardCount;

			if (question == null || question.Instructions == Entities.Enums.Card.Instructions.Draw2Pick3)
			{
				numberToDraw += 2;
			}

			return numberToDraw;
		}

		#endregion "Calculate number of cards needed per player"

		#region "Create Cards"

		private Entities.GamePlayerCard CreateQuestion(List<Entities.Card> cards, Entities.Game game)
		{
			Entities.Card card = cards.FirstOrDefault();

			Entities.GamePlayerCard question = CreateGamePlayerCard(card, game.GameID, game.DetermineCommander().UserId);

			return question;
		}

		private Entities.GamePlayerCard CreateGamePlayerCard(Entities.Card card, Int32 gameID, Int32 userId)
		{
			Entities.GamePlayerCard playerCard = null;

			if (card != null)
			{
				playerCard = new Entities.GamePlayerCard(card);
				playerCard.GameID = gameID;
				playerCard.UserId = userId;
			}

			return playerCard;
		}

		#endregion "Create Cards"

		#region "Create Hands"

		private List<Entities.GamePlayerCard> CreatePlayerHands(List<Entities.Card> answers,
																Dictionary<Int32, Int32> numbersToDraw,
																Entities.Game game)
		{
			List<Entities.GamePlayerCard> dealtAnswers = new List<Entities.GamePlayerCard>();
			List<Entities.Card> answersToRemove = new List<Entities.Card>();

			Int32 drawCount = 0;

			foreach (Entities.GamePlayer player in game.Players)
			{
				drawCount = 0;

				numbersToDraw.TryGetValue(player.User.UserId, out drawCount);

				player.Hand.AddRange(CreateHand(drawCount, game.GameID, player.User.UserId, answers, out answersToRemove));
			}

			return dealtAnswers;
		}

		private List<Entities.GamePlayerCard> CreateHand(Int32 drawCount,
														 Int32 userId,
														 Int32 gameID,
														 List<Entities.Card> answers,
														 out List<Entities.Card> answersToRemove)
		{
			List<Entities.GamePlayerCard> hand = new List<Entities.GamePlayerCard>();

			answersToRemove = answers.Take(drawCount).ToList();

			foreach (Entities.Card card in answersToRemove)
			{
				hand.Add(CreateGamePlayerCard(card, gameID, userId));
			}

			return hand;
		}

		#endregion "Create Hands"
	}
}
