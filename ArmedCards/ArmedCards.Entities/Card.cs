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
	/// Object that defines a card
	/// </summary>
    public class Card
    {
		public Card(IDataReader idr)
		{
			CardID				= idr.GetValueByName<Int32>("CardID");
			Content				= idr.GetValueByName<String>("Content");
			Instructions		= idr.GetValueByName<Enums.Card.Instructions>("Instructions");
			Type				= idr.GetValueByName<Enums.Card.CardType>("Type");
			CreatedBy_UserId	= idr.GetValueByName<Int32>("CreatedBy_UserId");
		}

		/// <summary>
		/// The card ID
		/// </summary>
		public Int32 CardID { get; set; }

		/// <summary>
		/// Text the card contains
		/// </summary>
		public String Content { get; set; }

		/// <summary>
		/// The type of card
		/// </summary>
		public Enums.Card.CardType Type { get; set; }

		/// <summary>
		/// The instructions for the cards
		/// </summary>
		public Enums.Card.Instructions Instructions { get; set; }

		/// <summary>
		/// Created by User ID
		/// </summary>
		public Int32 CreatedBy_UserId { get; set; }
    }
}
