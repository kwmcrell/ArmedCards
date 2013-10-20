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
using DAL = ArmedCards.DataAccess.GamePlayerKickVote;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.Repositories.GamePlayerKickVote
{
	/// <summary>
	/// Implements <seealso cref="Base.ISelect"/>
	/// </summary>
	public class Select: Base.ISelect
	{
		private DAL.Base.ISelect _select;
		private AS.User.Base.ISelect _selectUser;

		public Select(DAL.Base.ISelect select, AS.User.Base.ISelect selectUser)
		{
			this._select = select;
			this._selectUser = selectUser;
		}

		/// <summary>
		/// Select all the votes based on <paramref name="filter"/>
		/// </summary>
		/// <param name="filter">Filter used to select votes to kick</param>
		/// <param name="totalPlayers">The total number of players in the game</param>
		/// <returns>The list of votes</returns>
		public List<Entities.GamePlayerKickVote> Execute(Entities.Filters.GamePlayerKickVote.Select filter, out Int32 totalPlayers)
		{
			return _select.Execute(filter, out totalPlayers);
		}

		/// <summary>
		/// Select all the votes based on <paramref name="filter"/>
		/// </summary>
		/// <param name="filter">Filter used to select votes to kick</param>
		/// <returns>The list of votes</returns>
		public List<Entities.GamePlayerKickVote> Execute(Entities.Filters.GamePlayerKickVote.SelectForGame filter)
		{
			List<Entities.GamePlayerKickVote> votesToKick = _select.Execute(filter);

			List<Int32> userIds = votesToKick.Select(x => x.KickUserId).Distinct().ToList();

			List<Entities.User> users = _selectUser.Execute(userIds);

			foreach (Entities.GamePlayerKickVote vote in votesToKick)
			{
				vote.KickUser = users.Find(x => x.UserId == vote.KickUserId);
			}

			return votesToKick;
		}
	}
}
