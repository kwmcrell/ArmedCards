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

namespace ArmedCards.BusinessLogic.AppServices.Hub.Base
{
	/// <summary>
	/// Interface for sending a message over a hub
	/// </summary>
	public interface ISendMessage
	{
		/// <summary>
		/// Send a message to a hub group
		/// Used to send the following messages:
		/// 1. Update Waiting Header
		/// 2. UpdateGameView
		/// 3. UpdateLobby
		/// </summary>
		/// <param name="game">The current game</param>
		/// <param name="action">The action to fire</param>
		void Execute(Entities.Game game, Action<Entities.ActiveConnection, Entities.Game> action);

		/// <summary>
		/// Send a message to a hub group
		/// 1. Winner Selected
		/// </summary>
		/// <param name="game">The current game</param>
		/// <param name="round">The current round</param>
		/// <param name="action">The action to fire</param>
		void Execute(Entities.Game game, Entities.GameRound round,
		 			 Action<Entities.ActiveConnection, Entities.Game, List<IGrouping<Int32, Entities.GameRoundCard>>> action);

		/// <summary>
		/// Send a message to a hub group
		/// Used to send the following messages:
		/// 1. Commander leaves game
		/// </summary>
		/// <param name="game">The current game</param>
		/// <param name="commanderName">Name of the commander that left</param>
		/// <param name="action">The action to fire</param>
		void Execute(Entities.Game game, String commanderName, Action<Entities.ActiveConnection, Entities.Game, String> action);

		/// <summary>
		/// Send a message to a hub group
		/// Used to send the following messages:
		/// 1. AlertUserOfResult
		/// </summary>
		/// <param name="gameID">The ID of the game</param>
		/// <param name="kickedUser">The user being voted on</param>
		/// <param name="votesToKick">The number of votes to kick</param>
		/// <param name="votesNotToKick">The number of votes not to kick</param>
		/// <param name="isKicked">Is kicked</param>
		/// <param name="action">The action to fire</param>
		void Execute(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, Boolean isKicked,
							Action<Entities.ActiveConnection, Entities.User, Int32, Int32, Boolean> action);

		/// <summary>
		/// Send message to hub group
		/// Used to send the following messages:
		/// 1. AlertUsersVote
		/// </summary>
		/// <param name="gameID">The ID of the game</param>
		/// <param name="kickedUser">The user being voted on</param>
		/// <param name="votesToKick">The number of votes to kick</param>
		/// <param name="votesNotToKick">The number of votes not to kick</param>
		/// <param name="alreadyVoted">List of user Ids that have already voted</param>
		/// <param name="action">The action to fire</param>
		void Execute(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, List<Int32> alreadyVoted,
							Action<Entities.ActiveConnection, Entities.User, Int32, Int32> action);
	}
}
