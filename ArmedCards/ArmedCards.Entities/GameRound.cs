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
using System.Data;

namespace ArmedCards.Entities
{
    /// <summary>
    /// The object that defines a round in a game
    /// </summary>
    public class GameRound
    {
		public GameRound(IDataReader idr)
			: this()
        {
			GameRoundID			= idr.GetValueByName<Int32>("GameRoundID");
			Started				= idr.GetValueByName<DateTime>("Started");
            GameID				= idr.GetValueByName<Int32>("Game_GameID");
			CurrentPlayerCount	= idr.GetValueByName<Int32>("CurrentPlayers");
			PlayedCount			= idr.GetValueByName<Int32>("Played");

			CardCommander		= new User(idr);
			Question			= new Card(idr);
        }

		public GameRound()
		{
			CardCommander = new User();
			CardsPlayed = new List<GameRoundCard>();
		}

		/// <summary>
		/// Game round ID
		/// </summary>
		public Int32 GameRoundID { get; set; }

		/// <summary>
		/// DateTime that the round was started
		/// </summary>
		public DateTime Started { get; set; }

		/// <summary>
		/// The ID of the game the round belongs to
		/// </summary>
		public Int32 GameID { get; set; }

		/// <summary>
		/// The round's card commander
		/// </summary>
		public User CardCommander { get; set; }

		/// <summary>
		/// The question for the round
		/// </summary>
		public Card Question { get; set; }

		/// <summary>
		/// List of cards played during the round
		/// </summary>
		public List<GameRoundCard> CardsPlayed { get; set; }

		/// <summary>
		/// Current player count
		/// </summary>
		public Int32 CurrentPlayerCount { get; set; }

		/// <summary>
		/// Number of players that have answered
		/// </summary>
		public Int32 PlayedCount { get; set; }

		/// <summary>
		/// Validate the right number of cards were played for the question
		/// </summary>
		/// <param name="cardsCount">The number of cards played</param>
		/// <returns>If the proper number of cards were played</returns>
		public Boolean ValidateCardPlayedCount(Int32 cardsCount)
		{
			return ((Int32)Question.Instructions + 1) == cardsCount;
		}

		private List<GameRoundCard> _answers;

		/// <summary>
		/// Answers for the round
		/// </summary>
		public List<GameRoundCard> Answers
		{
			get
			{
				return _answers ?? (_answers = CardsPlayed.Where(x => x.Card.Type == Enums.Card.CardType.Answer).ToList());
			}
		}

		/// <summary>
		/// Check to see if user has answered the question already
		/// </summary>
		/// <param name="userId">The user Id to check</param>
		/// <returns>If the user has already answered the question</returns>
		public Boolean HasAnswer(Int32 userId)
		{
			Int32 indexOf = Answers.FindIndex(x => x.PlayedBy_UserId == userId);

			if (indexOf >= 0)
			{
				return true;
			}

			return false;
		}

		/// <summary>
		/// Determine if the user is the card commander
		/// </summary>
		/// <param name="userId">The user Id to check</param>
		/// <returns></returns>
		public Boolean IsCommander(Int32 userId)
		{
			return CardCommander.UserId == userId;
		}

		/// <summary>
		/// Validate that the selected winner was in fact played during the round
		/// </summary>
		/// <param name="cardIDs">The IDs of winning cards</param>
		/// <returns>Any IDs that were not actually played during the round</returns>
		public List<Int32> ValidateWinnerSelection(List<Int32> cardIDs)
		{
			List<Int32> invalidCardIDs = new List<Int32>();

			Int32 indexOf = -1;

			foreach (Int32 cardID in cardIDs)
			{
				indexOf = Answers.FindIndex(x => x.Card_CardID == cardID);

				if (indexOf < 0)
				{
					invalidCardIDs.Add(cardID);
				}
				else
				{
					Answers[indexOf].Winner = true;
				}
			}

			return invalidCardIDs;
		}

		/// <summary>
		/// Return grouped answers based on who played them
		/// </summary>
		/// <returns></returns>
		public List<IGrouping<Int32, Entities.GameRoundCard>> GroupedAnswers()
		{
			return Answers.GroupBy(x => x.PlayedBy_UserId).ToList();
		}

		/// <summary>
		/// Get the next commander based round winner
		/// </summary>
		/// <returns></returns>
		public Entities.User Winner()
		{
			Entities.GameRoundCard card = Answers.Find(x => x.Winner);

			if (card != null)
			{
				return card.PlayedBy;
			}

			return null;
		}
    }
}
