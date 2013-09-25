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
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.DataAccess.GamePlayerCard
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ISelect"/>
	/// </summary>
	public class Select : Base.ISelect
	{
		private Database _db;

		public Select(Database db)
		{
			this._db = db;
		}

		/// <summary>
		/// Selects game player cards base on supplied filter
		/// </summary>
		/// <param name="filter">Filter used to select game player cards</param>
		/// <returns>A list of game player cards that satisfy the supplied filter</returns>
		public List<Entities.GamePlayerCard> Execute(Entities.Filters.GamePlayerCard.Select filter)
		{
			List<Entities.GamePlayerCard> playerCards = new List<Entities.GamePlayerCard>();

			using (DbCommand cmd = _db.GetStoredProcCommand("GamePlayerCard_Select"))
			{
				_db.AddInParameter(cmd, "@GameID", DbType.Int32, filter.GameID);

				if (filter.UserId.HasValue)
				{
					_db.AddInParameter(cmd, "@UserId", DbType.Int32, filter.UserId.Value);
				}

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
						playerCards.Add(new Entities.GamePlayerCard(idr));
					}
				}
			}

			return playerCards;
		}
	}
}
