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
using System.Net.Http;

namespace ArmedCards.Web.Controllers.Game.Board
{
	/// <summary>
	/// Controller to handle voting to kick a player
	/// </summary>
    public class KickPlayerController : Extensions.ArmedCardsController
	{
		private AS.GamePlayerKickVote.Base.IInsert _insert;
		private AS.Hub.Base.ISendMessage _sendMessage;
		private AS.GamePlayerKickVote.Base.ICheckVotes _checkVotes;
		private TaskFactory _taskFactory;

		public KickPlayerController(AS.GamePlayerKickVote.Base.IInsert insert,
									AS.Hub.Base.ISendMessage sendMessage,
									AS.GamePlayerKickVote.Base.ICheckVotes checkVotes)
		{
			this._insert = insert;
			this._sendMessage = sendMessage;
			this._checkVotes = checkVotes;
			this._taskFactory = new TaskFactory();
		}

		[HttpPost]
		[Extensions.ArmedCardsAuthorize]
		public ActionResult Vote(Int32 kickUserId, Int32 gameID, Boolean voteToKick)
		{
			Entities.GamePlayerKickVote vote = new Entities.GamePlayerKickVote();
			vote.GameID = gameID;
			vote.KickUserId = kickUserId;
			vote.VotedUserId = WebSecurity.CurrentUserId;
			vote.Vote = voteToKick;

			Entities.ActionContainers.VoteToKick container = new Entities.ActionContainers.VoteToKick();
			container.CheckVotes = HandleWait;

			String siteHost = String.Format("{0}://{1}", Request.Url.Scheme, Request.Url.Host);

			if (siteHost.ToLower().Contains("localhost"))
			{
				siteHost += string.Format(":{0}", Request.Url.Port);
			}

			container.AlertUserOfVote = Helpers.HubActions.AlertUsersVote;
			Entities.ActionResponses.VoteToKick response = _insert.Execute(vote, siteHost, container);

			String message = String.Format("Votes To Kick: {0} <br/> Votes To Stay: {1}", 
											response.VotesToKick,
											response.VotesToStay);

			String title = String.Format("Voted to {0} {1}.", (voteToKick ? "kick" : "keep"), response.KickUser.DisplayName);

			return Json(new { message = message, title = title });
		}

		private async void HandleWait(Int32 gameID, Int32 kickUserId, String siteHost)
		{
			await Task.Delay(30000);

			HttpClient client = new HttpClient();

			Int64 combinedIds = kickUserId + gameID;

			String accessKey = Convert.ToBase64String(MachineKey.Protect(Encoding.ASCII.GetBytes((combinedIds).ToString()),  "VoteHandler"));

			String queryString = String.Format("?kickUserId={0}&gameID={1}&accessKey={2}", kickUserId.ToString(), gameID.ToString(), HttpUtility.UrlEncode(accessKey));

			string result = client.PostAsJsonAsync(String.Format("{0}/KickPlayer/HandleVoteTimer{1}", siteHost, queryString), new StringContent("")).Result.Content.ReadAsStringAsync().Result;
		}

		[HttpPost]
		public void HandleVoteTimer(Int32 kickUserId, Int32 gameID, String accessKey)
		{
			Byte[] uprotected = MachineKey.Unprotect(Convert.FromBase64String(accessKey), "VoteHandler");

			String unprotectedKey = Encoding.ASCII.GetString(uprotected);

			if (unprotectedKey == (kickUserId + gameID).ToString())
			{
				Entities.ActionContainers.KickPlayer kickPlayerContainer = new Entities.ActionContainers.KickPlayer();
				kickPlayerContainer.LeaveGameContainer.CommanderLeft = Helpers.HubActions.CommanderLeft;
				kickPlayerContainer.LeaveGameContainer.UpdateGameView = Helpers.HubActions.UpdateGameView;
				kickPlayerContainer.LeaveGameContainer.WaitingAction = Helpers.HubActions.SendWaitingMessage;

				kickPlayerContainer.AlertUsersOfResult = Helpers.HubActions.AlertUserOfResult;

				_checkVotes.Execute(gameID, kickUserId, kickPlayerContainer);
			}
		}
	}
}
