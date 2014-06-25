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
using System.Threading.Tasks;

namespace ArmedCards.BusinessLogic.AppServices.Hubs
{
	/// <summary>
	/// Implementation of ISendMessage
	/// </summary>
	public class SendMessage : Base.ISendMessage
	{
		private readonly ActiveConnection.Base.ISelect _selectActiveConnection;
        private readonly IHubContext _hub;
		
        public SendMessage(ActiveConnection.Base.ISelect selectActiveConnection)
        {
			this._selectActiveConnection = selectActiveConnection;
            this._hub = GlobalHost.ConnectionManager.GetHubContext<BusinessLogic.AppServices.Hubs.ArmedCards>();
        }

        /// <summary>
        /// Update the waiting screen for the game
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        public void UpdateWaiting(Entities.Game game, Boolean sendToSpectators)
        {
            Execute(game, Entities.Enums.Hubs.Actions.UpdateWaiting, sendToSpectators);
        }

        /// <summary>
        /// Update most of the game view
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        public void UpdateGame(Entities.Game game, Boolean sendToSpectators)
        {
            Execute(game, Entities.Enums.Hubs.Actions.UpdateGameView, sendToSpectators);
        }

        /// <summary>
        /// Update most of the game view
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        /// <param name="forcedToLeaveUserId">The player was forced to leave</param>
        public void UpdateGame(Entities.Game game, Boolean sendToSpectators, Int32? forcedToLeaveUserId)
        {
            Entities.ActiveConnection excluded = Execute(game, Entities.Enums.Hubs.Actions.UpdateGameView, sendToSpectators, forcedToLeaveUserId);

            if(excluded != null)
            {
                _hub.Clients.Client(excluded.ActiveConnectionID).ForceLeave();
                _hub.Groups.Remove(excluded.ActiveConnectionID, excluded.GroupName);
            }
        }

        /// <summary>
        /// Update the lobby
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        public void UpdateLobby(Entities.Game game, Boolean sendToSpectators)
        {
            Execute(game, Entities.Enums.Hubs.Actions.UpdateLobby, sendToSpectators);
        }

        /// <summary>
        /// Update the game view when a card is played
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        public void CardPlayed(Entities.Game game, Boolean sendToSpectators)
        {
            Execute(game, Entities.Enums.Hubs.Actions.CardPlayed, sendToSpectators);
        }

        /// <summary>
        /// Update the game view when the commander has selected the winner of the round
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="round">The game's current round</param>
        /// <param name="sendToSpectators">Should this update go to spectators</param>
        public void SendWinnerSelected(Entities.Game game, Entities.GameRound round, Boolean sendToSpectators)
		{
			Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();
			filter.GroupName = String.Format("Game_{0}", game.GameID);

			List<Entities.ActiveConnection> connections = _selectActiveConnection.Execute(filter);

            SendWinnerSelected(game, round, connections.Where(x => x.ConnectionType == Entities.Enums.ConnectionType.GamePlayer), game.Players);

            if(sendToSpectators)
            {
                SendWinnerSelected(game, round, connections.Where(x => x.ConnectionType == Entities.Enums.ConnectionType.GameSpectator), game.Spectators);
            }
		}

        /// <summary>
        /// Alert the users that the round has been lost because the commander has left
        /// </summary>
        /// <param name="game">The game</param>
        /// <param name="commanderName">The commander's name</param>
        public void CommanderLeft(Entities.Game game, String commanderName)
		{
			Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();
			filter.GroupName = String.Format("Game_{0}", game.GameID);

			List<Entities.ActiveConnection> connections = _selectActiveConnection.Execute(filter);

			Entities.GamePlayer sendToPlayer = null;

			foreach (Entities.ActiveConnection connection in connections)
			{
				sendToPlayer = game.Players.FirstOrDefault(player => player.User.UserId == connection.User_UserId);

				if (sendToPlayer != null)
				{
                    Entities.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

                    _hub.Clients.Client(connection.ActiveConnectionID)
                                       .CommanderLeft(model, GetGameLobbyViewModel(connection, game), commanderName, game.IsWaiting());
				}
			}
		}

        /// <summary>
        /// Alert the users a vote to kick has completed
        /// </summary>
        /// <param name="gameID">The game ID</param>
        /// <param name="kickedUser">The user that was being voted on</param>
        /// <param name="votesToKick">The number of votes to kick</param>
        /// <param name="votesNotToKick">The number votes not to kick</param>
        /// <param name="isKicked">Was the user kicked based on the votes</param>
        public void VoteComplete(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, Boolean isKicked)
		{
			Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();
			filter.GroupName = String.Format("Game_{0}", gameID);

			List<Entities.ActiveConnection> connections = _selectActiveConnection.Execute(filter);

			foreach (Entities.ActiveConnection connection in connections)
			{
                String message;
                String title = "Kick Player Results";

                String userSpan = String.Format("<span class='{0}'>{1}</span>",
                                                                    "loggedIn",
                                                                    String.Format("<img src='{0}' /> {1}", kickedUser.PictureUrl, kickedUser.DisplayName));

                if (isKicked)
                {
                    message = "{0} was kicked. <br /> Votes To Kick: {1} <br/> Votes To Stay: {2}";
                }
                else
                {
                    message = "{0} was not kicked. <br /> Votes To Kick: {1} <br/> Votes To Stay: {2}";
                }

                _hub.Clients.Client(connection.ActiveConnectionID)
                                   .VoteToKickResults(String.Format(message, userSpan, votesToKick, votesNotToKick),
                                                        title,
                                                        (isKicked && kickedUser.UserId == connection.User_UserId),
                                                        kickedUser.UserId);
			}
		}

        /// <summary>
        /// Alert the users a vote to kick has been placed
        /// </summary>
        /// <param name="gameID">The game ID</param>
        /// <param name="kickedUser">The user that was being voted on</param>
        /// <param name="votesToKick">The number of votes to kick</param>
        /// <param name="votesNotToKick">The number votes not to kick</param>
        /// <param name="alreadyVoted">UserIds for users that have already voted</param>
        public void Voted(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, List<Int32> alreadyVoted)
		{
			List<Entities.ActiveConnection> connections = GetConnections(gameID, alreadyVoted);

			foreach (Entities.ActiveConnection connection in connections.Where(x => x.ConnectionType == Entities.Enums.ConnectionType.GamePlayer))
			{
                Entities.Models.Game.Board.VoteToKick model = new Entities.Models.Game.Board.VoteToKick(kickedUser, votesToKick, votesNotToKick);

                _hub.Clients.Client(connection.ActiveConnectionID).AlertUsersVote(model);
			}
		}

        #region "Private Action Helpers"

        private Entities.ActiveConnection Execute(Entities.Game game, Entities.Enums.Hubs.Actions action, Boolean sendToSpectators, 
                                                    Int32? excludedPlayerId = null)
        {
            Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();
            filter.GroupName = String.Format("Game_{0}", game.GameID);

            List<Entities.ActiveConnection> connections = _selectActiveConnection.Execute(filter);

            Entities.ActiveConnection excludedConnection = null;

            if(excludedPlayerId.HasValue)
            {
                excludedConnection = connections.DefaultIfEmpty(null).FirstOrDefault(x => x.User_UserId == excludedPlayerId);
            }

            ExecuteAction(game, action, connections.Where(x => x.ConnectionType == Entities.Enums.ConnectionType.GamePlayer), game.Players);

            if (sendToSpectators)
            {
                ExecuteAction(game, action, connections.Where(x => x.ConnectionType == Entities.Enums.ConnectionType.GameSpectator), game.Spectators);
            }

            return excludedConnection;
        }

        private void ExecuteAction(Entities.Game game, Entities.Enums.Hubs.Actions action, IEnumerable<Entities.ActiveConnection> connections,
                                   List<Entities.GamePlayer> users)
        {
            Entities.GamePlayer sendToPlayer = null;

            foreach (Entities.ActiveConnection connection in connections)
            {
                sendToPlayer = users.FirstOrDefault(player => player.User.UserId == connection.User_UserId);

                if (sendToPlayer != null)
                {
                    if (action == Entities.Enums.Hubs.Actions.UpdateWaiting)
                    {
                        _hub.Clients.Client(connection.ActiveConnectionID)
                                   .UpdateWaiting(Entities.Models.Helpers.WaitingHeader.Build(game, connection.User_UserId, GetPlayerType(connection)),
                                                  GetGameLobbyViewModel(connection, game));
                    }
                    else if (action == Entities.Enums.Hubs.Actions.UpdateGameView)
                    {
                        Entities.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

                        _hub.Clients.Client(connection.ActiveConnectionID)
                                           .UpdateGameView(model, GetGameLobbyViewModel(connection, game));
                    }
                    else if (action == Entities.Enums.Hubs.Actions.UpdateLobby)
                    {
                        _hub.Clients.Client(connection.ActiveConnectionID)
                               .UpdateLobbyView(GetGameLobbyViewModel(connection, game));
                    }
                    else if (action == Entities.Enums.Hubs.Actions.CardPlayed)
                    {
                        Entities.Models.Game.Board.GameBoard model = new Entities.Models.Game.Board.GameBoard(game, connection.User_UserId, GetPlayerType(connection));

                        _hub.Clients.Client(connection.ActiveConnectionID)
                                           .UpdateAnswers(model.AnswersViewModel, !model.ShowHand);
                    }
                }
            }
        }


        private void SendWinnerSelected(Entities.Game game, Entities.GameRound round,
                                            IEnumerable<Entities.ActiveConnection> connections,
                                            List<Entities.GamePlayer> users)
        {
            Entities.GamePlayer sendToPlayer = null;

            foreach (Entities.ActiveConnection connection in connections)
            {
                sendToPlayer = users.FirstOrDefault(player => player.User.UserId == connection.User_UserId);

                if (sendToPlayer != null)
                {

                    Entities.Models.Game.Board.GameBoard model = GetGameBoardModal(connection, game);

                    Entities.Models.Game.Board.Answers answersModel = new Entities.Models.Game.Board.Answers(true, model.IsCommander, false,
                                                                                               false, false, true, round.GroupedAnswers());

                    //The round history tab repurposed this to be the winner of the round when the page is loaded
                    //so setting this here so that when pushed into the observable array it will look correct
                    round.CardCommander = round.Winner();

                    _hub.Clients.Client(connection.ActiveConnectionID)
                                       .WinnerSelected(answersModel, model, game.IsWaiting(), game.HasWinner(), round);
                }
            }
        }

        #endregion "Private Action Helpers"

        #region "Private Helpers"

        /// <summary>
        /// Get a gameboard model
        /// </summary>
        /// <param name="connection">The connection the message is being sent to</param>
        /// <param name="game">The game to render the view for</param>
        /// <param name="commanderLeft">Commander left game</param>
        /// <returns></returns>
        private Entities.Models.Game.Board.GameBoard GetGameBoardModal(Entities.ActiveConnection connection, Entities.Game game)
        {
            return new Entities.Models.Game.Board.GameBoard(game, connection.User_UserId, GetPlayerType(connection));
        }

        private Entities.Enums.GamePlayerType GetPlayerType(Entities.ActiveConnection connection)
        {
            return connection.ConnectionType == Entities.Enums.ConnectionType.GamePlayer ?
                                    Entities.Enums.GamePlayerType.Player :
                                    Entities.Enums.GamePlayerType.Spectator;
        }

        private Entities.Models.Game.Board.Lobby GetGameLobbyViewModel(Entities.ActiveConnection connection, Entities.Game game)
        {
            return new Entities.Models.Game.Board.Lobby(GetPlayerType(connection), game.Players, game.MaxNumberOfSpectators > 0, game.Spectators);
        }

        private List<Entities.ActiveConnection> GetConnections(Int32 gameID, List<Int32> exclude)
        {
            Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();
            filter.GroupName = String.Format("Game_{0}", gameID);
            filter.ExcludeUsers = exclude;

            List<Entities.ActiveConnection> connections = _selectActiveConnection.Execute(filter);

            return connections;
        }

        #endregion "Private Helpers"
	}
}
