﻿/*
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
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;
using System.Data.Common;
using System.Data;

namespace ArmedCards.DataAccess.Deck
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
		/// Select decks base on provided filter
		/// </summary>
		/// <param name="filter">The filter used to select decks</param>
		/// <returns>A filtered list of decks</returns>
		public List<Entities.Deck> Execute(Entities.Filters.Deck.SelectByGameID filter)
		{
			List<Entities.Deck> decks = new List<Entities.Deck>();

            using (DbCommand cmd = _db.GetStoredProcCommand("Deck_SelectByGameID"))
			{
				_db.AddInParameter(cmd, "@GameIDs", DbType.Xml, filter.GameIDs.ConvertCollectionToXML());

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
                        decks.Add(new Entities.Deck(idr));
					}
				}
			}

            return decks;
		}

        /// <summary>
        /// Select decks base on provided filter
        /// </summary>
        /// <param name="filter">The filter used to select decks</param>
        /// <returns>A filtered list of decks</returns>
        public List<Entities.Deck> Execute(Entities.Filters.Deck.Select filter)
        {
            List<Entities.Deck> decks = new List<Entities.Deck>();

            using (DbCommand cmd = _db.GetStoredProcCommand("Deck_Select"))
            {
                using (IDataReader idr = _db.ExecuteReader(cmd))
                {
                    while (idr.Read())
                    {
                        decks.Add(new Entities.Deck(idr));
                    }
                }
            }

            return decks;
        }
	}
}
