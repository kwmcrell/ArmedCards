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
	/// Link record between a GamePlayer and a Card
	/// </summary>
	public class GamePlayerCard
	{
		public GamePlayerCard()
		{

		}

		public GamePlayerCard(Entities.Card card, Int32 gameID, Int32 userId)
		{
			this.Card = card;
			this.CardID = card.CardID;
			this.GameID = gameID;
			this.UserId = userId;
		}

		public GamePlayerCard(IDataReader idr)
		{
			this.CardID = idr.GetValueByName<Int32>("CardID");
			this.GameID = idr.GetValueByName<Int32>("GameID");
			this.UserId = idr.GetValueByName<Int32>("UserId");

			this.Card = new Card(idr);
		}

		/// <summary>
		/// The User Id for the player
		/// </summary>
		public Int32 UserId { get; set; }

		/// <summary>
		/// The card ID
		/// </summary>
		public Int32 CardID { get; set; }

		/// <summary>
		/// The actual card
		/// </summary>
		public Card Card { get; set; }

		/// <summary>
		/// The game ID
		/// </summary>
		public Int32 GameID { get; set; }
	}
}
