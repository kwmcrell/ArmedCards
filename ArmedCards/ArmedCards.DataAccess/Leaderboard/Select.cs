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
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.DataAccess.Leaderboard
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
        /// Select the user boards, if <paramref name="userId"/> is not null it will select the user's placement in the leaderboard
        /// as well as the top 10
        /// </summary>
        /// <param name="userId">The current logged in user</param>
        /// <returns>Dictionary containing at least the top 10 users and if <paramref name="userId"/> not null it returns the user
        ///          placement as well
        /// </returns>
        public Dictionary<Entities.Enums.LeaderboardType, List<Entities.LeaderboardRecord>> Execute(Int32? userId)
        {
            Dictionary<Entities.Enums.LeaderboardType, List<Entities.LeaderboardRecord>> retVal = 
                new Dictionary<Entities.Enums.LeaderboardType, List<Entities.LeaderboardRecord>>();

            using (DbCommand cmd = _db.GetStoredProcCommand("Leaderboard_Select"))
            {
                if(userId.HasValue && userId.Value > 0)
                {
                    _db.AddInParameter(cmd, "@UserId", DbType.Int32, userId.Value);
                }

                using (IDataReader idr = _db.ExecuteReader(cmd))
                {
                    List<Entities.LeaderboardRecord> top10 = new List<Entities.LeaderboardRecord>();

                    while (idr.Read())
                    {
                        top10.Add(new Entities.LeaderboardRecord(idr));
                    }

                    retVal.Add(Entities.Enums.LeaderboardType.Top10, top10);

                    if (userId.HasValue && userId.Value > 0)
                    {
                        List<Entities.LeaderboardRecord> personal = new List<Entities.LeaderboardRecord>();

                        idr.NextResult();

                        while (idr.Read())
                        {
                            personal.Add(new Entities.LeaderboardRecord(idr));
                        }

                        retVal.Add(Entities.Enums.LeaderboardType.CurrentUser, personal);
                    }
                }
            }

            return retVal;
        }
    }
}
