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
using DS = ArmedCards.BusinessLogic.DomainServices.GameRound;

namespace ArmedCards.BusinessLogic.AppServices.GameRound
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IComplete"/>
	/// </summary>
	public class Complete : Base.IComplete
	{
		private DS.Base.IComplete _completeGameRound;
		private Hub.Base.ISendMessage _sendMessage;
		private Game.Base.IUpdate _updateGame;

		public Complete(DS.Base.IComplete completeGameRound,
						Hub.Base.ISendMessage sendMessage,
						Game.Base.IUpdate updateGame)
		{
			this._completeGameRound = completeGameRound;
			this._sendMessage = sendMessage;
			this._updateGame = updateGame;
		}

		/// <summary>
		/// Complete the current round
		/// </summary>
		/// <param name="gameID">The ID of the game that contains the round</param>
		/// <param name="cardIDs">The IDs of the winning cards</param>
		/// <param name="userId">The user Id trying to complete the round</param>
		/// <param name="winnerSelected">Action to update game players</param>
		public void Execute(Int32 gameID, List<Int32> cardIDs, Int32 userId,
			Action<Entities.ActiveConnection, Entities.Game, List<IGrouping<Int32, Entities.GameRoundCard>>> winnerSelected)
		{
			Entities.ActionResponses.RoundComplete response = _completeGameRound.Execute(gameID, cardIDs, userId);

			if (response.CompletedRound != null && response.Game != null)
			{
				_sendMessage.Execute(response.Game, response.CompletedRound, winnerSelected);
				
				DateTime playedLast = DateTime.UtcNow;
				DateTime? gameOver = null;

				if(response.Game.HasWinner())
				{
					gameOver = playedLast;
				}

				_updateGame.Execute(gameID, playedLast, gameOver);
			}
		}
	}
}
