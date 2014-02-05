using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;
using WebMatrix.WebData;
using AS = ArmedCards.BusinessLogic.AppServices;
using Microsoft.Practices.Unity;
using System.Threading.Tasks;

namespace ArmedCards.Web.Hubs
{
    [HubName("ArmedCardsHub")]
    [Extensions.ArmedCardsAuthorize]
    public class ArmedCards : Hub
    {
        private const string GLOBAL = "Global";

        /// <summary>
        /// Send a global chat message to all connections
        /// </summary>
        /// <param name="message">Message to send</param>
        [HubMethodName("SendMessage")]
        public void SendMessage(Models.Hub.ChatMessage message)
        {
            message.SentBy = Context.User.Identity.Name;
            message.DateSent = String.Format("{0} UTC", DateTime.UtcNow.ToString());

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

            Models.Hub.Lobby lobby = new Models.Hub.Lobby
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
			AS.ActiveConnection.Base.IDelete _deleteConnection = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IDelete>();

			Entities.Filters.ActiveConnection.Delete filter = new Entities.Filters.ActiveConnection.Delete
			{
				ActiveConnectionID = Context.ConnectionId
			};

			Entities.ActiveConnection connection = _deleteConnection.Execute(filter);

			Clients.All.RemoveConnection(connection);
		}

        [HubMethodName("PlayCard")]
        public void PlayCard(Models.Hub.Messages.PlayCard message)
        {
            AS.GamePlayerCard.Base.IPlay _playCard = UnityConfig.Container.Resolve<AS.GamePlayerCard.Base.IPlay>();

            Entities.ActionResponses.PlayCard response = _playCard.Execute(message.CardIDs, message.GameID, WebSecurity.CurrentUserId,
                                                                            Helpers.HubActions.CardPlayed);
        }

        [HubMethodName("StartGame")]
        public void StartGame(Int32 gameID)
        {
            AS.Game.Base.IStart _startGame = UnityConfig.Container.Resolve<AS.Game.Base.IStart>();

            Entities.User user = new Entities.User
            {
                UserId = WebSecurity.CurrentUserId,
                DisplayName = WebSecurity.CurrentUserName
            };

            _startGame.Execute(gameID, user, Helpers.HubActions.UpdateGameView);
        }

        [HubMethodName("PickWinner")]
        public void PickWinner(Models.Hub.Messages.PlayCard message)
        {
            AS.GameRound.Base.IComplete _completeRound = UnityConfig.Container.Resolve<AS.GameRound.Base.IComplete>();

            _completeRound.Execute(message.GameID, message.CardIDs, WebSecurity.CurrentUserId, Helpers.HubActions.WinnerSelected);
        }

        [HubMethodName("VoteToKick")]
        public Models.Hub.Messages.VoteToKickResult VoteToKick(Models.Hub.Messages.VoteToKick message)
        {
            Entities.GamePlayerKickVote vote = new Entities.GamePlayerKickVote();
            vote.GameID = message.GameID;
            vote.KickUserId = message.KickUserId;
            vote.VotedUserId = WebSecurity.CurrentUserId;
            vote.Vote = message.Kick;

            Entities.ActionContainers.KickPlayer container = new Entities.ActionContainers.KickPlayer();
            container.AlertUserOfVote = Helpers.HubActions.AlertUsersVote;
            container.AlertUsersOfResult = Helpers.HubActions.AlertUserOfResult;

            container.LeaveGameContainer.CommanderLeft = Helpers.HubActions.CommanderLeft;
            container.LeaveGameContainer.UpdateGameView = Helpers.HubActions.UpdateGameView;
            container.LeaveGameContainer.WaitingAction = Helpers.HubActions.SendWaitingMessage;

            AS.GamePlayerKickVote.Base.IInsert _insert = UnityConfig.Container.Resolve<AS.GamePlayerKickVote.Base.IInsert>();

            Entities.ActionResponses.VoteToKick response = _insert.Execute(vote, container);

            return new Models.Hub.Messages.VoteToKickResult
            {
                Content = String.Format("Votes To Kick: {0} <br/> Votes To Stay: {1}",
                                            response.VotesToKick,
                                            response.VotesToStay),
                Title = String.Format("Voted to {0} {1}.", (message.Kick ? "kick" : "keep"), response.KickUser.DisplayName)
            };
        }

		#region "Private Methods"

        private List<Entities.ActiveConnection> GetConnections(String groupName, Entities.Enums.ConnectionType connectionType)
        {
            AS.ActiveConnection.Base.ISelect _selectConnections = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.ISelect>();

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
            Int32 userId = WebSecurity.CurrentUserId;

            if (userId > 0)
            {
                AS.ActiveConnection.Base.IInsert _insertConnection = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IInsert>();

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