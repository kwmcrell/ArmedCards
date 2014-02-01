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
using REPO = ArmedCards.BusinessLogic.Repositories;

namespace ArmedCards.BusinessLogic.DomainServices.Game
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ILeave"/>
	/// </summary>
	public class Leave : Base.ILeave
	{
		private REPO.Game.Base.ILeave _leaveGame;

		public Leave(REPO.Game.Base.ILeave leaveGame)
		{
			this._leaveGame = leaveGame;
		}

		/// <summary>
		/// Removes a player from the game
		/// </summary>
		/// <param name="gameID">The ID of the game to leave</param>
		/// <param name="user">The user leaving the game</param>
        /// <param name="playerType">Type of player leaving</param>
        public void Execute(Int32 gameID, Entities.User user, Entities.Enums.GamePlayerType playerType)
		{
			_leaveGame.Execute(gameID, user, playerType);
		}
	}
}
