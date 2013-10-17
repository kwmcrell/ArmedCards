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
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.DomainServices.GamePlayerKickVote
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ICheckVotes"/>
	/// </summary>
	public class CheckVotes : Base.ICheckVotes
	{
		private AS.Game.Base.ILeave _leaveGame;
		private AS.User.Base.ISelect _selectUser;
		private AS.GamePlayerKickVote.Base.ISelect _selectVotes;

		public CheckVotes(AS.Game.Base.ILeave leaveGame, AS.User.Base.ISelect selectUser, AS.GamePlayerKickVote.Base.ISelect selectVotes)
		{
			this._leaveGame = leaveGame;
			this._selectUser = selectUser;
			this._selectVotes = selectVotes;
		}

		/// <summary>
		/// Check to see if the user has enough votes to be kicked
		/// </summary>
		/// <param name="gameID">The ID of the game the user belongs to</param>
		/// <param name="kickUserId">The ID of the user to kick</param>
		/// <param name="leaveGameContainer">Object containing all actions needed for leaving a game</param>
		public void Execute(Int32 gameID, Int32 kickUserId, Entities.ActionContainers.LeaveGame leaveGameContainer)
		{
			Entities.Filters.GamePlayerKickVote.Select filter = new Entities.Filters.GamePlayerKickVote.Select();
			filter.GameID = gameID;
			filter.KickUserId = kickUserId;

			Int32 totalPlayers = 0;

			List<Entities.GamePlayerKickVote> votes = _selectVotes.Execute(filter, out totalPlayers);

			Int32 votedToKick = votes.Count(x => x.Vote);
			Int32 votedNotToKick = votes.Count(x => !x.Vote);

			Int32 notVoted = totalPlayers - votedToKick - votedNotToKick;

			votedNotToKick += notVoted;

			if (votedToKick >= votedNotToKick)
			{
				Entities.User kickedUser = _selectUser.Execute(kickUserId);

				_leaveGame.Execute(gameID, kickedUser, leaveGameContainer);
			}
		}
	}
}
