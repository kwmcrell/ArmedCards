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

namespace ArmedCards.BusinessLogic.AppServices.Hubs.Base
{
	/// <summary>
	/// Interface for sending a message over a hub
	/// </summary>
	public interface ISendMessage
	{
        /// <summary>
        /// Update the waiting screen for the game
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        void UpdateWaiting(Entities.Game game, Boolean sendToSpectators);

        /// <summary>
        /// Update most of the game view
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        void UpdateGame(Entities.Game game, Boolean sendToSpectators);

        /// <summary>
        /// Update the lobby
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        void UpdateLobby(Entities.Game game, Boolean sendToSpectators);

        /// <summary>
        /// Update the game view when a card is played
        /// </summary>
        /// <param name="game">The game to update</param>
        /// <param name="sendToSpectators">Should this update go to the spectators</param>
        void CardPlayed(Entities.Game game, Boolean sendToSpectators);

		/// <summary>
		/// Update the game view when the commander has selected the winner of the round
		/// </summary>
		/// <param name="game">The game to update</param>
		/// <param name="round">The game's current round</param>
		/// <param name="sendToSpectators">Should this update go to spectators</param>
		void SendWinnerSelected(Entities.Game game, Entities.GameRound round, Boolean sendToSpectators);

		/// <summary>
		/// Alert the users that the round has been lost because the commander has left
		/// </summary>
		/// <param name="game">The game</param>
		/// <param name="commanderName">The commander's name</param>
		void CommanderLeft(Entities.Game game, String commanderName);

		/// <summary>
		/// Alert the users a vote to kick has completed
		/// </summary>
		/// <param name="gameID">The game ID</param>
		/// <param name="kickedUser">The user that was being voted on</param>
		/// <param name="votesToKick">The number of votes to kick</param>
		/// <param name="votesNotToKick">The number votes not to kick</param>
		/// <param name="isKicked">Was the user kicked based on the votes</param>
		void VoteComplete(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, Boolean isKicked);

		/// <summary>
		/// Alert the users a vote to kick has been placed
		/// </summary>
		/// <param name="gameID">The game ID</param>
        /// <param name="kickedUser">The user that was being voted on</param>
        /// <param name="votesToKick">The number of votes to kick</param>
        /// <param name="votesNotToKick">The number votes not to kick</param>
		/// <param name="alreadyVoted">UserIds for users that have already voted</param>
		void Voted(Int32 gameID, Entities.User kickedUser, Int32 votesToKick, Int32 votesNotToKick, List<Int32> alreadyVoted);
	}
}
