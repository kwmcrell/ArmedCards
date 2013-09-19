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

using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;
using System.Data.Common;

namespace ArmedCards.DataAccess.Card
{
	/// <summary>
	/// Implementation of ISelect
	/// </summary>
    public class Select : Base.ISelect
    {
		private Database _db;

		public Select(Database db)
		{
			this._db = db;
		}

		/// <summary>
		/// Select cards based on a filter
		/// </summary>
		/// <param name="filter">The filter used to select cards</param>
		/// <returns>A filtered list of cards</returns>
		public List<Entities.Card> Execute(Entities.Filters.Card.Select filter)
		{
			List<Entities.Card> cards = new List<Entities.Card>();

			using (DbCommand cmd = _db.GetStoredProcCommand("Card_Select"))
			{
				_db.AddInParameter(cmd, "@DeckIDs", DbType.Xml, filter.DeckIDs.ConvertCollectionToXML());

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
						cards.Add(new Entities.Card(idr));
					}
				}
			}

			return cards;
		}

		/// <summary>
		/// Select cards based on a filter
		/// </summary>
		/// <param name="filter">The filter used to select cards</param>
		/// <returns>A filtered list of cards</returns>
		public List<Entities.Card> Execute(Entities.Filters.Card.SelectForDeal filter)
		{
			List<Entities.Card> cards = new List<Entities.Card>();

			using (DbCommand cmd = _db.GetStoredProcCommand("Card_SelectForDeal"))
			{
				_db.AddInParameter(cmd, "@GameID", DbType.Int32, filter.GameID);

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
						cards.Add(new Entities.Card(idr));
					}
				}
			}

			return cards;
		}
	}
}
