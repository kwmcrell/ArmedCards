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
using ArmedCards.Library.Extensions;

namespace ArmedCards.DataAccess.GamePlayerKickVote
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IInsert"/>
	/// </summary>
	public class Insert : Base.IInsert
	{
		private Database _db;

		public Insert(Database db)
		{
			this._db = db;
		}

		/// <summary>
		/// Insert a vote to kick a user <paramref name="vote"/>
		/// </summary>
		/// <param name="vote">The user's vote to kick</param>
		/// <returns></returns>
		public Entities.ActionResponses.VoteToKick Execute(Entities.GamePlayerKickVote vote)
		{
			using (DbCommand cmd = _db.GetStoredProcCommand("GamePlayerKickVote_Insert"))
			{
				Entities.ActionResponses.VoteToKick response = new Entities.ActionResponses.VoteToKick();

				_db.AddInParameter(cmd, "@GameID", DbType.Int32, vote.GameID);
				_db.AddInParameter(cmd, "@KickUserId", DbType.Int32, vote.KickUserId);
				_db.AddInParameter(cmd, "@VotedUserId", DbType.Int32, vote.VotedUserId);
				_db.AddInParameter(cmd, "@Vote", DbType.Boolean, vote.Vote);

				_db.AddOutParameter(cmd, "@VotesToStay", DbType.Int32, sizeof(Int32));
				_db.AddOutParameter(cmd, "@VotesToKick", DbType.Int32, sizeof(Int32));

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
						response.AlreadyVoted.Add(idr.GetValueByName<Int32>("VotedUserId"));
					}
				}

				response.VotesToKick = Int32.Parse(_db.GetParameterValue(cmd, "@VotesToKick").ToString());
				response.VotesToStay = Int32.Parse(_db.GetParameterValue(cmd, "@VotesToStay").ToString());

				return response;
			}
		}
	}
}
