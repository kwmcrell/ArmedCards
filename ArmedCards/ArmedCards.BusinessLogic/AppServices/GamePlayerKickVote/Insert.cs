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
using DS = ArmedCards.BusinessLogic.DomainServices.GamePlayerKickVote;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.AppServices.GamePlayerKickVote
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IInsert"/>
	/// </summary>
	public class Insert : Base.IInsert
	{
		private DS.Base.IInsert _insert;

		public Insert(DS.Base.IInsert insert)
		{
			this._insert = insert;
		}

		/// <summary>
		/// Insert a vote to kick a user
		/// </summary>
		/// <param name="userVote">The user's vote</param>
		/// <param name="siteHost">The website host name</param>
		/// <returns></returns>
		public Entities.ActionResponses.VoteToKick Execute(Entities.GamePlayerKickVote userVote, String siteHost)
		{
			Entities.ActionResponses.VoteToKick response = _insert.Execute(userVote);

			if (response.TotalVotes == 1 &&
				response.ResponseCode == Entities.ActionResponses.Enums.VoteToKick.VoteSuccessful &&
				userVote.Vote)
			{
				Task.Factory.StartNew(() => userVote.ExecuteCheckVotes(siteHost));
			}

			return response;
		}
	}
}