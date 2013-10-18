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
using DS = ArmedCards.BusinessLogic.DomainServices.GamePlayerKickVote;

namespace ArmedCards.BusinessLogic.AppServices.GamePlayerKickVote
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ICheckVotes"/>
	/// </summary>
	public class CheckVotes : Base.ICheckVotes
	{
		private Game.Base.ILeave _leaveGame;
		private User.Base.ISelect _selectUser;
		private DS.Base.ICheckVotes _checkVotes;
		private Hub.Base.ISendMessage _sendMessage;

		public CheckVotes(Game.Base.ILeave leaveGame, User.Base.ISelect selectUser, DS.Base.ICheckVotes checkVotes,
						  Hub.Base.ISendMessage sendMessage)
		{
			this._leaveGame = leaveGame;
			this._selectUser = selectUser;
			this._checkVotes = checkVotes;
			this._sendMessage = sendMessage;
		}
		
		/// <summary>
		/// Check to see if the user has enough votes to be kicked
		/// </summary>
		/// <param name="gameID">The ID of the game the user belongs to</param>
		/// <param name="kickUserId">The ID of the user to kick</param>
		/// <param name="kickPlayerContainer">Object containing all the actions for kick vote</param>
		public void Execute(Int32 gameID, Int32 kickUserId, Entities.ActionContainers.KickPlayer kickPlayerContainer)
		{
			Int32 votedToKick = 0;
			Int32 votedNotToKick = 0;

			_checkVotes.Execute(gameID, kickUserId, out votedToKick, out votedNotToKick);

			Boolean kickUser = votedToKick > votedNotToKick;
			
			Entities.User kickedUser = _selectUser.Execute(kickUserId);

			_sendMessage.Execute(gameID, kickedUser, votedToKick, votedNotToKick, kickUser, kickPlayerContainer.AlertUsersOfResult);
			
			if (kickUser)
			{
				_leaveGame.Execute(gameID, kickedUser, kickPlayerContainer.LeaveGameContainer);
			}
		}
	}
}
