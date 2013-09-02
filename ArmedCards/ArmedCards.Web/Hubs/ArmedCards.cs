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
        [HubMethodName("SendGlobalMessage")]
        public void SendGlobalMessage(Models.Hub.GlobalMessage message)
        {
            message.SentBy = Context.User.Identity.Name;
            message.DateSent = string.Format("{0} UTC", DateTime.UtcNow.ToString());

            Clients.All.BroadcastGlobalMessage(message);
        }

        /// <summary>
        /// Join the global chat
        /// </summary>
        [HubMethodName("JoinGloabl")]
        public void JoinGlobal()
        {
            InsertConnection(GLOBAL);

            Models.Hub.Lobby lobby = new Models.Hub.Lobby
            {
                ActiveConnections = GetConnections(GLOBAL)
            };

            Clients.All.UpdateLobby(lobby);
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

        private void Disconnect()
        {
            AS.ActiveConnection.Base.IDelete _deleteConnection = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IDelete>();

            Entities.Filters.ActiveConnection.Delete filter = new Entities.Filters.ActiveConnection.Delete
            {
                ActiveConnectionID = Context.ConnectionId
            };

            Entities.ActiveConnection connection = _deleteConnection.Execute(filter);

            Clients.All.RemoveConnection(connection);
        }

        private List<Entities.ActiveConnection> GetConnections(string groupName)
        {
            AS.ActiveConnection.Base.ISelect _selectConnections = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.ISelect>();

            Entities.Filters.ActiveConnection.SelectAll filter = new Entities.Filters.ActiveConnection.SelectAll();

            List<Entities.ActiveConnection> connections = _selectConnections.Execute(filter);

            return connections;
        }

        private void InsertConnection(string groupName)
        {
            int userId = WebSecurity.CurrentUserId;

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
    }
}