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

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ArmedCards.BusinessLogic.AppServices.Hub
{
	/// <summary>
	/// Implementation of ISendMessage
	/// </summary>
	public class SendMessage : Base.ISendMessage
	{
		private readonly ActiveConnection.Base.ISelect _selectActiveConnection;

		public SendMessage(ActiveConnection.Base.ISelect selectActiveConnection)
        {
			this._selectActiveConnection = selectActiveConnection;
        }

		/// <summary>
		/// Send a message to a hub group
		/// </summary>
		/// <param name="game">The current game</param>
		/// <param name="action">The action to fire</param>
		public void Execute(Entities.Game game, Action<Entities.ActiveConnection, Entities.Game, Entities.GamePlayer> action)
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
					action(connection, game, sendToPlayer);
				}
			}
		}
	}
}
