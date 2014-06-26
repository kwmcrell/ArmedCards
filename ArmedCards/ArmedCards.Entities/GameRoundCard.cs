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
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;

namespace ArmedCards.Entities
{
	/// <summary>
	/// Class that defines a card played during a round
	/// </summary>
	public class GameRoundCard
	{
		public GameRoundCard()
		{
			PlayOrder = 1;
			Winner = false;
			PlayedBy = new User();
		}

		public GameRoundCard(Card card, Int32 userId, Int32 gameRoundID, Int32 gameID)
			:this()
		{
			Card = card;
			Card_CardID = card.CardID;
			DatePlayed = DateTime.UtcNow;
			PlayedBy_UserId = userId;
			GameRound_GameRoundID = gameRoundID;
			Game_GameID = gameID;
		}

		public GameRoundCard(IDataReader idr)
		{
			Card_CardID = idr.GetValueByName<Int32>("CardID");
			DatePlayed = idr.GetValueByName<DateTime>("DatePlayed");
			Game_GameID = idr.GetValueByName<Int32>("Game_GameID");
			GameRound_GameRoundID = idr.GetValueByName<Int32>("GameRound_GameRoundID");
			GameRoundCardID = idr.GetValueByName<Int32>("GameRoundCardID");
			PlayedBy_UserId = idr.GetValueByName<Int32>("PlayedBy_UserId");
			PlayOrder = idr.GetValueByName<Int16>("PlayOrder");
			Winner = idr.GetValueByName<Boolean>("Winner");
            AutoPlayed = idr.GetValueByName<Boolean>("AutoPlayed");

			PlayedBy = new User(idr);
			Card = new Card(idr);
		}

		/// <summary>
		/// The ID for this card
		/// </summary>
		public Int32 GameRoundCardID { get; set; }

		/// <summary>
		/// The date the card was played
		/// </summary>
		public DateTime DatePlayed { get; set; }

		/// <summary>
		/// Played By UserId
		/// </summary>
		public Int32 PlayedBy_UserId { get; set; }

		/// <summary>
		/// Played By User
		/// </summary>
		public User PlayedBy { get; set; }

		/// <summary>
		/// The CardID for the played card
		/// </summary>
		public Int32 Card_CardID { get; set; }

		/// <summary>
		/// The Card played
		/// </summary>
		public Card Card { get; set; }

		/// <summary>
		/// The ID for the round the card was played
		/// </summary>
		public Int32 GameRound_GameRoundID { get; set; }

		/// <summary>
		/// The ID for the game it was played in
		/// </summary>
		public Int32 Game_GameID { get; set; }

		/// <summary>
		/// The winner of the round
		/// </summary>
		public Boolean Winner { get; set; }

		/// <summary>
		/// The order in which the card was played
		/// </summary>
		public Int16 PlayOrder { get; set; }

        /// <summary>
        /// Was this card played because a player was idle
        /// </summary>
        public Boolean AutoPlayed { get; set; }
	}
}
