using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using Microsoft.AspNet.SignalR.Hubs;

namespace ArmedCards.Web.Hubs
{
    [HubName("ArmedCardsHub")]
    public class ArmedCards : Hub
    {
        /// <summary>
        /// Send a global chat message to all connections
        /// </summary>
        /// <param name="message">Message to send</param>
        [HubMethodName("SendGlobalMessage")]
        public void SendGlobalMessage(string message)
        {
            var json = new
            {
                SentBy = Context.User.Identity.Name,
                Message = message
            };

            Clients.All.BroadcastGlobalMessage(json);
        }
    }
}