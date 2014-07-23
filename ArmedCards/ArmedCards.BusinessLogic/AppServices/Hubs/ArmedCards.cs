using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using AS = ArmedCards.BusinessLogic.AppServices;
using Microsoft.Practices.Unity;
using System.Threading.Tasks;

namespace ArmedCards.BusinessLogic.AppServices.Hubs
{
    [HubName("ArmedCardsHub")]
    [Authentication.Extensions.ArmedCardsAuthorize]
    public class ArmedCards : Hub
    {
        private const string GLOBAL = "Global";

        private AS.ChatMessage.Base.IInsert _insert;

        public ArmedCards()
        {
            this._insert = BusinessLogic.UnityConfig.Container.Resolve<AS.ChatMessage.Base.IInsert>();
        }

        /// <summary>
        /// Send a global chat message to all connections
        /// </summary>
        /// <param name="message">Message to send</param>
        [HubMethodName("SendMessage")]
        public void SendMessage(Entities.ChatMessage message)
        {
            message.SentByUserId = Authentication.Security.CurrentUserId;
            message.SentBy = Authentication.Security.CurrentUserName;
            message.SentDate = DateTime.UtcNow;
            message.DateSent = message.SentDate.ToLongTimeString();

            _insert.Execute(message);

			if (message.Global)
			{
				Clients.All.BroadcastGlobalMessage(message);
			}
			else
			{
				Clients.Group(String.Format("Game_{0}", message.GameID.Value)).BroadcastGameMessage(message);
			}
        }

        /// <summary>
        /// Join the global chat
        /// </summary>
        [HubMethodName("Join")]
        public void Join(Int32? gameID, Entities.Enums.ConnectionType connectionType)
        {
			String groupName = GLOBAL;

			if (gameID.HasValue)
			{
				groupName = String.Format("Game_{0}", gameID.Value);
			}

            InsertConnection(groupName, connectionType);

            Entities.Models.Hub.Lobby lobby = new Entities.Models.Hub.Lobby
            {
                ActiveConnections = GetConnections(groupName, connectionType)
            };

			if (gameID.HasValue)
			{
				this.Groups.Add(Context.ConnectionId, groupName);
				Clients.Group(groupName).UpdateLobby(lobby);
			}
			else
			{
				Clients.All.UpdateLobby(lobby);
			}
        }

        /// <summary>
        /// Handles on disconnected
        /// </summary>
        /// <returns></returns>
        public override Task OnDisconnected()
        {
            Disconnect();

            return base.OnDisconnected();
        }

		/// <summary>
		/// Handles Armed Cards Disconnect
		/// </summary>
		[HubMethodName("Disconnect")]
		public void Disconnect()
		{
            AS.ActiveConnection.Base.IDelete _deleteConnection = BusinessLogic.UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IDelete>();

			Entities.Filters.ActiveConnection.Delete filter = new Entities.Filters.ActiveConnection.Delete
			{
				ActiveConnectionID = Context.ConnectionId
			};

			Entities.ActiveConnection connection = _deleteConnection.Execute(filter);

            /*if(connection.ConnectionType != Entities.Enums.ConnectionType.GlobalChat)
            {
                Int32 gameID = Convert.ToInt32(connection.GroupName.Replace("Game_", ""));

                Entities.User user = new Entities.User { UserId = connection.User_UserId, DisplayName = connection.UserName };

                Entities.Enums.GamePlayerType playerType = 
                    connection.ConnectionType == Entities.Enums.ConnectionType.GamePlayer ?
                            Entities.Enums.GamePlayerType.Player :
                            Entities.Enums.GamePlayerType.Spectator;

                AS.Game.Base.ILeave _leaveGame = BusinessLogic.UnityConfig.Container.Resolve<AS.Game.Base.ILeave>();

                _leaveGame.Execute(gameID, user, playerType);
            }*/

			Clients.All.RemoveConnection(connection);
		}

        [HubMethodName("PlayCard")]
        public void PlayCard(Entities.Models.Hub.Messages.PlayCard message)
        {
            AS.GamePlayerCard.Base.IPlay _playCard = BusinessLogic.UnityConfig.Container.Resolve<AS.GamePlayerCard.Base.IPlay>();

            Entities.ActionResponses.PlayCard response = _playCard.Execute(message.CardIDs, message.GameID, Authentication.Security.CurrentUserId);
        }

        [HubMethodName("StartGame")]
        public void StartGame(Int32 gameID)
        {
            AS.Game.Base.IStart _startGame = BusinessLogic.UnityConfig.Container.Resolve<AS.Game.Base.IStart>();

            Entities.User user = new Entities.User
            {
                UserId = Authentication.Security.CurrentUserId,
                DisplayName = Authentication.Security.CurrentUserName
            };

            _startGame.Execute(gameID, user);
        }

        [HubMethodName("PickWinner")]
        public void PickWinner(Entities.Models.Hub.Messages.PlayCard message)
        {
            AS.GameRound.Base.IComplete _completeRound = BusinessLogic.UnityConfig.Container.Resolve<AS.GameRound.Base.IComplete>();

            _completeRound.Execute(message.GameID, message.CardIDs, Authentication.Security.CurrentUserId);
        }

        [HubMethodName("VoteToKick")]
        public Entities.Models.Hub.Messages.VoteToKickResult VoteToKick(Entities.Models.Hub.Messages.VoteToKick message)
        {
            Entities.GamePlayerKickVote vote = new Entities.GamePlayerKickVote();
            vote.GameID = message.GameID;
            vote.KickUserId = message.KickUserId;
            vote.VotedUserId = Authentication.Security.CurrentUserId;
            vote.Vote = message.Kick;

            AS.GamePlayerKickVote.Base.IInsert _insert = BusinessLogic.UnityConfig.Container.Resolve<AS.GamePlayerKickVote.Base.IInsert>();

            Entities.ActionResponses.VoteToKick response = _insert.Execute(vote);

            return new Entities.Models.Hub.Messages.VoteToKickResult
            {
                Content = String.Format("Votes To Kick: {0} <br/> Votes To Stay: {1}",
                                            response.VotesToKick,
                                            response.VotesToStay),
                Title = String.Format("Voted to {0} {1}.", (message.Kick ? "kick" : "keep"), response.KickUser.DisplayName),
                AllVotesCasted = response.AllVotesCasted
            };
        }

        [HubMethodName("RefreshGameView")]
        public void RefreshGameView(Int32 gameID, Entities.Enums.ConnectionType connectionType)
        {
            Join(gameID, connectionType);

            AS.GameRound.Base.ISelect _selectGameRound = BusinessLogic.UnityConfig.Container.Resolve<AS.GameRound.Base.ISelect>();
            AS.Game.Base.ISelect _selectGame = BusinessLogic.UnityConfig.Container.Resolve<AS.Game.Base.ISelect>();
            AS.GamePlayerKickVote.Base.ISelect _selectVotes = BusinessLogic.UnityConfig.Container.Resolve<AS.GamePlayerKickVote.Base.ISelect>();
            AS.ActiveConnection.Base.ISelect _selectConnection = BusinessLogic.UnityConfig.Container.Resolve<AS.ActiveConnection.Base.ISelect>();

            Int32 currentUserId = Authentication.Security.CurrentUserId;
            Entities.ActiveConnection connection = _selectConnection.Execute(new Entities.Filters.ActiveConnection.Select(Context.ConnectionId, currentUserId));

            Entities.Filters.GamePlayerKickVote.SelectForGame kickVoteFilter = new Entities.Filters.GamePlayerKickVote.SelectForGame();
            kickVoteFilter.GameID = gameID;

            List<Entities.GamePlayerKickVote> votes = _selectVotes.Execute(kickVoteFilter);
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

            List<Entities.GameRound> completedRounds = _selectGameRound.Execute(new Entities.Filters.GameRound.SelectCompleted(gameID));

            Entities.Game game = _selectGame.Execute(new Entities.Filters.Game.Select
            {
                GameID = gameID,
                DataToSelect = Entities.Enums.Game.Select.GamePlayerCards | Entities.Enums.Game.Select.Rounds
            });

            Entities.Enums.GamePlayerType playerType = (connection != null && connection.ConnectionType == Entities.Enums.ConnectionType.GamePlayer) ?
                Entities.Enums.GamePlayerType.Player :
                Entities.Enums.GamePlayerType.Spectator;

            Entities.Models.Game.Board.GameBoard model = 
                new Entities.Models.Game.Board.GameBoard(game, 
                                                         currentUserId,
                                                         playerType,
                                                         votesToKick,
                                                         completedRounds);

            Clients.Client(Context.ConnectionId).UpdateGameView(model, model.LobbyViewModel);                                           
        }

		#region "Private Methods"

        private List<Entities.ActiveConnection> GetConnections(String groupName, Entities.Enums.ConnectionType connectionType)
        {
            AS.ActiveConnection.Base.ISelect _selectConnections = BusinessLogic.UnityConfig.Container.Resolve<AS.ActiveConnection.Base.ISelect>();

            Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();

			if (groupName != GLOBAL)
			{
				filter.GroupName = groupName;
			}

            filter.ConnectionType = connectionType;

            List<Entities.ActiveConnection> connections = _selectConnections.Execute(filter).GroupBy(con => con.User_UserId)
                                                                                            .Select(con2 => con2.First())
                                                                                            .ToList();

            return connections;
        }

        private void InsertConnection(String groupName, Entities.Enums.ConnectionType connectionType)
        {
            Int32 userId = Authentication.Security.CurrentUserId;

            if (userId > 0)
            {
                AS.ActiveConnection.Base.IInsert _insertConnection = BusinessLogic.UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IInsert>();

                Entities.ActiveConnection connection = new Entities.ActiveConnection
                {
                    ActiveConnectionID = Context.ConnectionId,
                    GroupName = groupName,
                    User_UserId = userId,
                    ConnectionType = connectionType
                };

                _insertConnection.Execute(connection);
            }
		}

		#endregion "Private Methods"
	}
}