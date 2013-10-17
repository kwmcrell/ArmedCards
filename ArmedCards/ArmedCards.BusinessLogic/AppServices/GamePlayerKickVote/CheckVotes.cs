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
		private DS.Base.ICheckVotes _checkVotes;

		public CheckVotes(DS.Base.ICheckVotes checkVotes)
		{
			this._checkVotes = checkVotes;
		}
		
		/// <summary>
		/// Check to see if the user has enough votes to be kicked
		/// </summary>
		/// <param name="gameID">The ID of the game the user belongs to</param>
		/// <param name="kickUserId">The ID of the user to kick</param>
		/// <param name="leaveGameContainer">Object containing all actions needed for leaving a game</param>
		public async void Execute(Int32 gameID, Int32 kickUserId, Entities.ActionContainers.LeaveGame leaveGameContainer)
		{
			Int32 delay = 30000;

			await Task.Delay(delay);

			_checkVotes.Execute(gameID, kickUserId, leaveGameContainer);
		}
	}
}
