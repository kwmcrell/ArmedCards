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

namespace ArmedCards.Web.Controllers.Game.Board
{
    [Extensions.ArmedCardsAuthorize]
    public class GameController : Extensions.ArmedCardsController
    {
        private AS.Game.Base.IJoin _joinGame;
		private AS.Hub.Base.ISendMessage _sendMessage;

		public GameController(AS.Game.Base.IJoin joinGame, AS.Hub.Base.ISendMessage sendMessage)
        {
            this._joinGame = joinGame;
			this._sendMessage = sendMessage;
        }

        [HttpGet]
        public ActionResult Index(Int32 id)
        {
			String key = String.Format("Game_{0}_Passphrase", id);
			String passphrase = String.Empty;

            if (Session[key] != null)
            {
                passphrase = Encoding.ASCII.GetString(MachineKey.Unprotect((Session[key] as Byte[]), Session.SessionID));
                Session.Remove(key);
            }

			Entities.User user = new Entities.User
			{
				UserId = WebSecurity.CurrentUserId,
				DisplayName = WebSecurity.CurrentUserName
			};

			Entities.JoinResponse response = _joinGame.Execute(id, user, passphrase);

			if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.Successful) ||
				response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer))
            {
                Models.Game.Board.GameBoard model = new Models.Game.Board.GameBoard();
                model.Game = response.Game;
                model.UserId = WebSecurity.CurrentUserId;

				if (model.Game.IsWaiting() && 
					response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer) == false)
				{
					_sendMessage.Execute(model.Game, Helpers.HubActions.SendWaitingMessage);
				}

                return View("~/Views/Game/Board/Index.cshtml", model);
            }
            else
            {
                return Redirect(Url.Action("Index", "GameListing", new { id = id }));
            }
		}
	}
}
