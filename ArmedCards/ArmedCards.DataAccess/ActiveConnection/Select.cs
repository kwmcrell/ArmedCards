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
using ArmedCards.Library.Extensions;

namespace ArmedCards.DataAccess.ActiveConnection
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
        /// Return all active connections that match the filter
        /// </summary>
        /// <param name="filter">The filter used to select active connections</param>
        /// <returns>A list of active connections</returns>
        public List<Entities.ActiveConnection> Execute(Entities.Filters.ActiveConnection.SelectAll filter)
        {
            List<Entities.ActiveConnection> activeConnections = new List<Entities.ActiveConnection>();

            using (DbCommand cmd = _db.GetStoredProcCommand("ActiveConnection_Select"))
            {
                if (!String.IsNullOrWhiteSpace(filter.GroupName))
                {
                    _db.AddInParameter(cmd, "@GroupName", DbType.String, filter.GroupName);
                }

                if (filter.ExcludeUsers != null && filter.ExcludeUsers.Count > 0)
                {
                    _db.AddInParameter(cmd, "@ExcludeUserIds", DbType.Xml, filter.ExcludeUsers.ConvertCollectionToXML());
                }

                if (filter.ConnectionType > 0)
                {
                    _db.AddInParameter(cmd, "@ConnectionType", DbType.Int32, filter.ConnectionType);
                }

                using (IDataReader idr = _db.ExecuteReader(cmd))
                {
                    Entities.ActiveConnection connection = null;

                    while (idr.Read())
                    {
                        connection = new Entities.ActiveConnection(idr);

                        activeConnections.Add(connection);
                    }
                }
            }

            return activeConnections;
        }

        /// <summary>
        /// Return active connection that match the filter
        /// </summary>
        /// <param name="filter">The filter used to select a active connection</param>
        /// <returns>A active connection</returns>
        public Entities.ActiveConnection Execute(Entities.Filters.ActiveConnection.Select filter)
        {
            Entities.ActiveConnection connection = null;

            using (DbCommand cmd = _db.GetStoredProcCommand("ActiveConnection_SelectById"))
            {
                _db.AddInParameter(cmd, "@ActiveConnectionID", DbType.String, filter.ActiveConnectionID);

                _db.AddInParameter(cmd, "@UserId", DbType.Int32, filter.UserId);

                using (IDataReader idr = _db.ExecuteReader(cmd))
                {
                    while (idr.Read())
                    {
                        connection = new Entities.ActiveConnection(idr);
                    }
                }
            }

            return connection;
        }
    }
}
