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

using Hangfire;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.Web.Controllers.Game.Board
{
    /// <summary>
    /// Controller responsible for joining a game either playing or spectating
    /// </summary>
    [Authentication.Extensions.ArmedCardsAuthorize]
    public class GameController : Extensions.ArmedCardsController
    {
        private AS.Game.Base.IJoin _joinGame;
		private AS.Hubs.Base.ISendMessage _sendMessage;
		private AS.User.Base.ISelect _selectUser;
		private AS.GamePlayerKickVote.Base.ISelect _selectKickVotes;
        private AS.GameRound.Base.ISelect _selectGameRounds;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="joinGame"></param>
        /// <param name="sendMessage"></param>
        /// <param name="selectUser"></param>
        /// <param name="selectKickVotes"></param>
        public GameController(AS.Game.Base.IJoin joinGame, AS.Hubs.Base.ISendMessage sendMessage,
								AS.User.Base.ISelect selectUser, AS.GamePlayerKickVote.Base.ISelect selectKickVotes,
                                AS.GameRound.Base.ISelect selectGameRounds)
        {
            this._joinGame = joinGame;
			this._sendMessage = sendMessage;
			this._selectUser = selectUser;
			this._selectKickVotes = selectKickVotes;
            this._selectGameRounds = selectGameRounds;
        }

        /// <summary>
        /// Play the game
        /// </summary>
        /// <param name="id">The id of the game the player wants to join</param>
        /// <returns>The game view if the player was able to join</returns>
        [HttpGet]
        public ActionResult Index(Int32 id)
        {
			String key = String.Format("Game_{0}_Passphrase", id);
            String leaveGameJobIdKey = String.Format("LeaveGame_{0}_JobId", id);
			String passphrase = String.Empty;
            String jobId = String.Empty;
            Int32 currentUserId = Authentication.Security.CurrentUserId;

            if (Session[key] != null)
            {
                passphrase = Encoding.ASCII.GetString(MachineKey.Unprotect((Session[key] as Byte[]), Session.SessionID));
            }

            if (Session[leaveGameJobIdKey] != null)
            {
                jobId = Encoding.ASCII.GetString(MachineKey.Unprotect((Session[leaveGameJobIdKey] as Byte[]), Session.SessionID));

                BackgroundJob.Delete(jobId);

                Session.Remove(leaveGameJobIdKey);
            }

			Entities.User user = _selectUser.Execute(currentUserId);

			Entities.JoinResponse response = _joinGame.Execute(id, user, passphrase, Entities.Enums.GamePlayerType.Player);

            if(response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.GameOver))
            {
                return Redirect("/GameListing");
            }

			if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.BadPassphrase) == false &&
				response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.FullGame) == false)
			{
                Entities.Filters.GamePlayerKickVote.SelectForGame kickVoteFilter = new Entities.Filters.GamePlayerKickVote.SelectForGame();
                kickVoteFilter.GameID = id;

                List<Entities.GamePlayerKickVote> votes = _selectKickVotes.Execute(kickVoteFilter);
                IEnumerable<IGrouping<Int32, Entities.GamePlayerKickVote>> grouped = votes.GroupBy(x => x.KickUserId);

                Entities.Models.Game.Board.VoteToKick kickModel = null;

                List<Entities.Models.Game.Board.VoteToKick> votesToKick = new List<Entities.Models.Game.Board.VoteToKick>();

                foreach (IGrouping<Int32, Entities.GamePlayerKickVote> group in grouped)
                {
                    if (group.FirstOrDefault(x => x.VotedUserId == currentUserId) == null)
                    {
                        kickModel = new Entities.Models.Game.Board.VoteToKick(group.First().KickUser,
                                                                     group.Count(x => x.Vote),
                                                                     group.Count(x => !x.Vote));

                        votesToKick.Add(kickModel);
                    }
                }

                List<Entities.GameRound> completedRounds = _selectGameRounds.Execute(new Entities.Filters.GameRound.SelectCompleted(id));

                Entities.Models.Game.Board.GameBoard model = new Entities.Models.Game.Board.GameBoard(response.Game, currentUserId, 
                                                                                                        Entities.Enums.GamePlayerType.Player,
                                                                                                        votesToKick,
                                                                                                        completedRounds);

                return View("~/Views/Game/Board/Index.cshtml", model);
            }
            else
            {
                return Redirect(Url.Action("Index", "GameListing", new { id = id }));
            }
		}

        /// <summary>
        /// Spectate the game
        /// </summary>
        /// <param name="id">The id of the game the player wants to spectate</param>
        /// <returns>The spectator view if the spectator was able to join</returns>
        [HttpGet]
        public ActionResult Spectate(Int32 id)
        {
            String key = String.Format("Game_{0}_Passphrase", id);
            String passphrase = String.Empty;
            Int32 currentUserId = Authentication.Security.CurrentUserId;

            if (Session[key] != null)
            {
                passphrase = Encoding.ASCII.GetString(MachineKey.Unprotect((Session[key] as Byte[]), Session.SessionID));
            }

            Entities.User user = _selectUser.Execute(currentUserId);

            Entities.JoinResponse response = _joinGame.Execute(id, user, passphrase, Entities.Enums.GamePlayerType.Spectator);

            if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.GameOver))
            {
                return Redirect("/GameListing");
            }

            if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.BadPassphrase) == false &&
                response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.SpectatorsFull) == false)
            {
                Entities.Models.Game.Board.GameBoard model = new Entities.Models.Game.Board.GameBoard(response.Game, currentUserId, Entities.Enums.GamePlayerType.Spectator);

                return View("~/Views/Game/Board/Index.cshtml", model);
            }
            else
            {
                return Redirect(Url.Action("Index", "GameListing", new { id = id }));
            }
        }
	}
}
