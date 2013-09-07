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
    /// Object that defines a deck
    /// </summary>
    public class Deck
    {
		public Deck(IDataReader idr)
			:this()
		{
			DeckID				= idr.GetValueByName<Int32>("DeckID");
			Title				= idr.GetValueByName<String>("Title");
			IsPrivate			= idr.GetValueByName<Boolean>("IsPrivate");
			Type				= idr.GetValueByName<Enums.DeckType>("Type");
			CreatedBy_UserId	= idr.GetValueByName<Int32>("CreatedBy_UserId");
			GameID				= idr.GetValueByName<Int32>("GameID");
		}

		public Deck()
		{
			Cards = new List<Card>();
		}

        /// <summary>
        /// The Deck ID
        /// </summary>
        public Int32 DeckID { get; set; }

        /// <summary>
        /// The type of deck
        /// </summary>
        public Enums.DeckType Type { get; set; }

        /// <summary>
        /// The title of the deck
        /// </summary>
        public String Title { get; set; }

        /// <summary>
        /// Is the deck private
        /// </summary>
        public Boolean IsPrivate { get; set; }

        /// <summary>
        /// The user id for the creator
        /// </summary>
        public Int32 CreatedBy_UserId { get; set; }

		/// <summary>
		/// The game ID for which the deck belongs
		/// </summary>
		public Int32 GameID { get; set; }

		/// <summary>
		/// List of cards the deck contains
		/// </summary>
		public List<Card> Cards { get; set; }
    }
}
