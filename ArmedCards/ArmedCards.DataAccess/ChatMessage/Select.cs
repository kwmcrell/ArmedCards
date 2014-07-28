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
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ArmedCards.Library.Extensions;
using System.Data.Common;
using System.Data;

namespace ArmedCards.DataAccess.ChatMessage
{
    /// <summary>
    /// Implementation of <seealso cref="Base.ISelect"/>
    /// </summary>
    public class Select : Base.ISelect
    {
        private Database _db;

        /// <summary>
        /// Dependency Injected Constructor
        /// </summary>
        /// <param name="db">Database</param>
        public Select(Database db)
        {
            this._db = db;
        }

        /// <summary>
        /// Select chat messages that match the provided <paramref name="filter"/>
        /// </summary>
        /// <param name="filter">The filter used to chat messages</param>
        /// <returns>List of chat messages</returns>
        public List<Entities.ChatMessage> Execute(Entities.Filters.ChatMessage.Select filter)
        {
            List<Entities.ChatMessage> messages = new List<Entities.ChatMessage>();

            using (DbCommand cmd = _db.GetStoredProcCommand("ChatMessage_Select"))
            {
                _db.AddInParameter(cmd, "@GameID", DbType.Int32, filter.GameID);
                _db.AddInParameter(cmd, "@Global", DbType.Boolean, filter.Global);

                using(IDataReader idr = _db.ExecuteReader(cmd))
                {
                    while(idr.Read())
                    {
                        messages.Add(new Entities.ChatMessage(idr, filter.OffsetHours));
                    }
                }
            }

            return messages;
        }
    }
}
