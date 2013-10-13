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

using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebMatrix.WebData;
using AS = ArmedCards.BusinessLogic.AppServices;
using System.Threading.Tasks;

namespace ArmedCards.Web.Controllers.Game.Board
{
	/// <summary>
	/// Controller to handle voting to kick a player
	/// </summary>
	[Extensions.ArmedCardsAuthorize]
    public class KickPlayerController : Extensions.ArmedCardsController
	{
		private AS.GamePlayerKickVote.Base.IInsert _insert;

		public KickPlayerController(AS.GamePlayerKickVote.Base.IInsert insert)
		{
			this._insert = insert;
		}

		[HttpPost]
		public ActionResult Vote(Int32 kickUserId, Int32 gameID, Boolean voteToKick)
		{
			Int32 otherVoteCounts = _insert.Execute(gameID, kickUserId, WebSecurity.CurrentUserId, voteToKick);

			if (otherVoteCounts == 0 && voteToKick)
			{
				Task.Factory.StartNew(() => CheckVotes(gameID, kickUserId));
			}

			return null;
		}

		private async void CheckVotes(Int32 gameID, Int32 kickUserId)
		{
			Int32 delay = 30000;

			await Task.Delay(delay);
		}
	}
}
