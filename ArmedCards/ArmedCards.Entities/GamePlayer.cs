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
    /// Class that descibes a player in a game
    /// </summary>
    public class GamePlayer
    {
        public GamePlayer(IDataReader idr)
			:this()
        {
            GameID  = idr.GetValueByName<Int32>("GameID");
            User    = new User(idr);
            Points  = idr.GetValueByName<Int32>("Points");
			CardCount = idr.GetValueByName<Int32>("CardCount");

			if (idr.HasColumn("Title"))
			{
				Game = new Game(idr);
			}

            PlayerType = (Enums.GamePlayerType)idr.GetValueByName<Int32>("Type");
        }

        public GamePlayer()
        {
            User = new User();
			Hand = new List<GamePlayerCard>();
            PlayerType = Enums.GamePlayerType.Player;
        }

        /// <summary>
        /// The game ID for the player
        /// </summary>
        public Int32 GameID { get; set; }

        /// <summary>
        /// The full user
        /// </summary>
        public User User { get; set; }

        /// <summary>
        /// Number of points the user has
        /// </summary>
        public Int32 Points { get; set; }

		/// <summary>
		/// Number of cards in player's hand
		/// </summary>
		public Int32 CardCount { get; set; }

		/// <summary>
		/// List of cards in player's hand
		/// </summary>
		public List<Entities.GamePlayerCard> Hand { get; set; }

		/// <summary>
		/// The game the user belongs to
		/// </summary>
		public Entities.Game Game { get; set; }

		/// <summary>
		/// Check to see if the player has <paramref name="cardIDs"/> in their hand
		/// </summary>
		/// <param name="cardIDs">List of card IDs to check if present in player's hand</param>
		/// <returns>Any ids that were not found in the player's hand</returns>
		public List<Int32> CheckHand(List<Int32> cardIDs)
		{
			List<Int32> missingIds = new List<int>();

			Int32 indexOf = -1;

			foreach (Int32 cardID in cardIDs)
			{
				indexOf = Hand.FindIndex(x => x.CardID == cardID);

				if (indexOf < 0)
				{
					missingIds.Add(cardID);
				}
			}

			return missingIds;
		}

        /// <summary>
        /// The type of player
        /// </summary>
        public Enums.GamePlayerType PlayerType { get; set; }
    }
}