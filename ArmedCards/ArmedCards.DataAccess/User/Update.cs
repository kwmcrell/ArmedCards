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

namespace ArmedCards.DataAccess.User
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IUpdate"/>
	/// </summary>
	public class Update : Base.IUpdate
	{
		private Database _db;

		public Update(Database db)
		{
			this._db = db;
		}

		/// <summary>
		/// Update a user's display name based on <paramref name="filter"/>
		/// </summary>
		/// <param name="filter">Contains new and old display names</param>
		/// <returns></returns>
		public Entities.OAMembership Execute(Entities.Filters.User.UpdateDisplayName filter)
		{
			Entities.OAMembership membershipData = null;

			using (DbCommand cmd = _db.GetStoredProcCommand("User_UpdateDisplayName"))
			{
				_db.AddInParameter(cmd, "@UserId", DbType.Int32, filter.UserId);
				_db.AddInParameter(cmd, "@NewDisplayName", DbType.String, filter.NewDisplayName);
				_db.AddInParameter(cmd, "@OldDisplayName", DbType.String, filter.OldDisplayName);

				using (IDataReader idr = _db.ExecuteReader(cmd))
				{
					while (idr.Read())
					{
						membershipData = new Entities.OAMembership(idr);
					}
				}
			}

			return membershipData;
		}

        /// <summary>
        /// Update a user's display name
        /// </summary>
        /// <param name="userId">The ID of the user changing their picture Url</param>
        /// <returns></returns>
        public async Task Execute(Int32 userId, String pictureUrl)
        {
            await Task.Run(() =>
            {
                using (DbCommand cmd = _db.GetStoredProcCommand("User_UpdatePictureUrl"))
                {
                    _db.AddInParameter(cmd, "@UserId", DbType.Int32, userId);
                    _db.AddInParameter(cmd, "@PictureUrl", DbType.String, pictureUrl);

                    _db.ExecuteScalar(cmd);
                }
            });
        }
	}
}
