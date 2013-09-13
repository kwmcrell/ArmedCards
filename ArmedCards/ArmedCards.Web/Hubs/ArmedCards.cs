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
        public void Join(Int32? gameID)
        {
			String groupName = GLOBAL;

			if (gameID.HasValue)
			{
				groupName = String.Format("Game_{0}", gameID.Value);
			}

			InsertConnection(groupName);

            Models.Hub.Lobby lobby = new Models.Hub.Lobby
            {
				ActiveConnections = GetConnections(groupName)
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

		#region "Private Methods"

        private List<Entities.ActiveConnection> GetConnections(String groupName)
        {
            AS.ActiveConnection.Base.ISelect _selectConnections = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.ISelect>();

            Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();

			if (groupName != GLOBAL)
			{
				filter.GroupName = groupName;
			}

            List<Entities.ActiveConnection> connections = _selectConnections.Execute(filter);

            return connections;
        }

        private void InsertConnection(String groupName)
        {
            Int32 userId = WebSecurity.CurrentUserId;

            if (userId > 0)
            {
                AS.ActiveConnection.Base.IInsert _insertConnection = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IInsert>();

                Entities.ActiveConnection connection = new Entities.ActiveConnection
                {
                    ActiveConnectionID = Context.ConnectionId,
                    GroupName = groupName,
                    User_UserId = userId
                };

                _insertConnection.Execute(connection);
            }
		}

		#endregion "Private Methods"
	}
}