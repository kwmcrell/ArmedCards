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
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ArmedCards.Web.Helpers
{
    /// <summary>
    /// Class that defines Actions to send to the SendMessage App Service
    /// </summary>
    public static class HubActions
    {
        /// <summary>
        /// Sends an update for the waiting screen
        /// </summary>
        /// <param name="connection">Connection to send to</param>
        /// <param name="game">The current game</param>
        public static void SendWaitingMessage(Entities.ActiveConnection connection, Entities.Game game)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            hub.Clients.Client(connection.ActiveConnectionID)
                       .UpdateWaiting(Helpers.WaitingHeader.Build(game, connection.User_UserId, GetPlayerType(connection)), GetGameLobbyViewModel(connection, game));
        }

        /// <summary>
        /// Sends an update for a card played in the round
        /// </summary>
        /// <param name="connection">Connection to send to</param>
        /// <param name="game">The current game</param>
        public static void CardPlayed(Entities.ActiveConnection connection, Entities.Game game)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            Models.Game.Board.GameBoard model = new Models.Game.Board.GameBoard(game, connection.User_UserId, GetPlayerType(connection));

            hub.Clients.Client(connection.ActiveConnectionID)
                               .UpdateAnswers(model.AnswersViewModel, !model.ShowHand);
        }

        /// <summary>
        /// Sends an update that a winnder has been selected
        /// </summary>
        /// <param name="connection">Connection to send to</param>
        /// <param name="game">The current game</param>
        /// <param name="answers">The grouped answers</param>
        public static void WinnerSelected(Entities.ActiveConnection connection, Entities.Game game,
                                          List<IGrouping<Int32, Entities.GameRoundCard>> answers)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            Web.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

            Web.Models.Game.Board.Answers answersModel = new Models.Game.Board.Answers(true, model.IsCommander, false,
                                                                                       false, false, true, answers);

            hub.Clients.Client(connection.ActiveConnectionID)
                               .WinnerSelected(answersModel, model, game.IsWaiting(), game.HasWinner());
        }

        /// <summary>
        /// Update Game View after a player has joined and restarted the game
        /// </summary>
        /// <param name="connection">The connection to send to</param>
        /// <param name="game">The current game</param>
        public static void UpdateGameView(Entities.ActiveConnection connection, Entities.Game game)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            Web.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

            hub.Clients.Client(connection.ActiveConnectionID)
                               .UpdateGameView(model, GetGameLobbyViewModel(connection, game));
        }

        /// <summary>
        /// Update lobby view after a player has joined/left a game
        /// </summary>
        /// <param name="connection">The connection to send to</param>
        /// <param name="game">The current game</param>
        public static void UpdateLobby(Entities.ActiveConnection connection, Entities.Game game)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            hub.Clients.Client(connection.ActiveConnectionID)
                               .UpdateLobbyView(GetGameLobbyViewModel(connection, game));
        }

        public static void CommanderLeft(Entities.ActiveConnection connection, Entities.Game game, String commanderName)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            Web.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

            hub.Clients.Client(connection.ActiveConnectionID)
                               .CommanderLeft(model, GetGameLobbyViewModel(connection, game), commanderName, game.IsWaiting());
        }

        /// <summary>
        /// Alert users of a vote to kick results
        /// </summary>
        /// <param name="connection">The connection to send to</param>
        /// <param name="kickedUser">The user being voted on</param>
        /// <param name="votesToKick">The number of votes to kick</param>
        /// <param name="votesNotToKick">The number of votes not to kick</param>
        /// <param name="isKicked">Is kicked</param>
        public static void AlertUserOfResult(Entities.ActiveConnection connection, Entities.User kickedUser,
                                             Int32 votesToKick, Int32 votesNotToKick, Boolean isKicked)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            String message;
            String title = "Kick Player Results";

            TagBuilder userSpan = new TagBuilder("span");
            userSpan.AddCssClass("loggedIn");
            userSpan.InnerHtml = String.Format("<img src='{0}' /> {1}", kickedUser.PictureUrl, kickedUser.DisplayName);

            if (isKicked)
            {
                message = "{0} was kicked. <br /> Votes To Kick: {1} <br/> Votes To Stay: {2}";
            }
            else
            {
                message = "{0} was not kicked. <br /> Votes To Kick: {1} <br/> Votes To Stay: {2}";
            }

            hub.Clients.Client(connection.ActiveConnectionID)
                               .VoteToKickResults(String.Format(message, userSpan.ToString(), votesToKick, votesNotToKick),
                                                    title,
                                                    (isKicked && kickedUser.UserId == connection.User_UserId),
                                                    kickedUser.UserId);
        }

        /// <summary>
        /// Action used to alert users someone has called a vote to kick a user
        /// </summary>
        /// <param name="connection">The connection to send to</param>
        /// <param name="kickUser">The potential user to kick</param>
        /// <param name="votesToKick">Number of users to voted kick</param>
        /// <param name="votesNotToKick">Number of users voted not to kick</param>
        public static void AlertUsersVote(Entities.ActiveConnection connection, Entities.User kickUser,
                                            Int32 votesToKick, Int32 votesNotToKick)
        {
            IHubContext hub = GlobalHost.ConnectionManager.GetHubContext<Hubs.ArmedCards>();

            Models.Game.Board.VoteToKick model = new Models.Game.Board.VoteToKick(kickUser, votesToKick, votesNotToKick);

            hub.Clients.Client(connection.ActiveConnectionID).AlertUsersVote(model);
        }

        #region "Private Helpers"

        /// <summary>
        /// Get a gameboard model
        /// </summary>
        /// <param name="connection">The connection the message is being sent to</param>
        /// <param name="game">The game to render the view for</param>
        /// <param name="commanderLeft">Commander left game</param>
        /// <returns></returns>
        private static Models.Game.Board.GameBoard GetGameBoardModal(Entities.ActiveConnection connection, Entities.Game game)
        {
            return new Models.Game.Board.GameBoard(game, connection.User_UserId, GetPlayerType(connection));
        }

        private static Entities.Enums.GamePlayerType GetPlayerType(Entities.ActiveConnection connection)
        {
            return connection.ConnectionType == Entities.Enums.ConnectionType.GamePlayer ?
                                    Entities.Enums.GamePlayerType.Player :
                                    Entities.Enums.GamePlayerType.Spectator;
        }

        private static Web.Models.Game.Board.Lobby GetGameLobbyViewModel(Entities.ActiveConnection connection, Entities.Game game)
        {
            return new Web.Models.Game.Board.Lobby(GetPlayerType(connection), game.Players, game.MaxNumberOfSpectators > 0, game.Spectators);
        }

        #endregion "Private Helpers"
    }
}
