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

namespace ArmedCards.DataAccess.ActiveConnection
{
    /// <summary>
    /// The implementation for inserting a active connection
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
        /// Insert a active connection
        /// </summary>
        /// <param name="connection">The connection to insert</param>
        public void Execute(Entities.ActiveConnection connection)
        {
            using (DbCommand cmd = db.GetStoredProcCommand("ActiveConnection_Insert"))
            {
                db.AddInParameter(cmd, "@ActiveConnectionID", DbType.String, connection.ActiveConnectionID);
                db.AddInParameter(cmd, "@GroupName", DbType.String, connection.GroupName);
                db.AddInParameter(cmd, "@User_UserId", DbType.Int32, connection.User_UserId);
                db.AddInParameter(cmd, "@ConnectionType", DbType.Int32, connection.ConnectionType);

                db.ExecuteScalar(cmd);
            }
        }
    }
}
