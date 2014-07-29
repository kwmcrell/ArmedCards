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
    /// Implementation of <seealso cref="Base.IInsert"/>
    /// </summary>
    public class Insert : Base.IInsert
    {
        private Database db;

        /// <summary>
        /// Dependency Injected Constructor
        /// </summary>
        /// <param name="db">Database</param>
        public Insert(Database db)
        {
            this.db = db;
        }

        /// <summary>
        /// Insert a chat message
        /// </summary>
        /// <param name="message">The message to insert</param>
        public void Execute(Entities.ChatMessage message)
        {
            using (DbCommand cmd = db.GetStoredProcCommand("ChatMessage_Insert"))
            {
                db.AddInParameter(cmd, "@SentByUserId", DbType.Int32, message.SentByUserId);
                db.AddInParameter(cmd, "@SentByUserName", DbType.String, message.SentBy.HTMLEncode());
                db.AddInParameter(cmd, "@Message", DbType.String, message.Message.HTMLEncode());
                db.AddInParameter(cmd, "@DateSent", DbType.DateTime, message.SentDate);
                db.AddInParameter(cmd, "@GameID", DbType.Int32, message.GameID);
                db.AddInParameter(cmd, "@Global", DbType.Boolean, message.Global);
                db.AddInParameter(cmd, "@ConnectionType", DbType.Int32, message.ConnectionType);

                db.ExecuteScalar(cmd);
            }
        }
    }
}
