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
using DS = ArmedCards.BusinessLogic.DomainServices.User;

namespace ArmedCards.BusinessLogic.AppServices.User
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ISelect"/>
	/// </summary>
	public class Select : Base.ISelect
	{
		private DS.Base.ISelect _select;

		public Select(DS.Base.ISelect select)
		{
			this._select = select;
		}

		/// <summary>
		/// Select a user
		/// </summary>
		/// <param name="userId">The Id of the user to select</param>
		/// <returns>The user matching <paramref name="userId"/></returns>
		public Entities.User Execute(Int32 userId)
		{
			Entities.Filters.User.Select filter = new Entities.Filters.User.Select();
			filter.UserIds.Add(userId);

			return _select.Execute(filter).FirstOrDefault();
		}

		/// <summary>
		/// Select a users
		/// </summary>
		/// <param name="userIds">List of Ids of the users to select</param>
		/// <returns></returns>
		public List<Entities.User> Execute(List<Int32> userIds)
		{
			Entities.Filters.User.Select filter = new Entities.Filters.User.Select();
			filter.UserIds.AddRange(userIds);

			return _select.Execute(filter);
		}
	}
}
