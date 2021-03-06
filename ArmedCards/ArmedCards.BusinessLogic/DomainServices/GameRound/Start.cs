﻿/*
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

namespace ArmedCards.BusinessLogic.DomainServices.GameRound
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IStart"/>
	/// </summary>
	public class Start : Base.IStart
	{
		private AS.GameRound.Base.IInsert _insertGameRound;
		private AS.GamePlayerCard.Base.IDeal _dealCards;

		public Start(AS.GameRound.Base.IInsert insertGameRound,
					 AS.GamePlayerCard.Base.IDeal dealCards)
		{
			this._insertGameRound = insertGameRound;
			this._dealCards = dealCards;
		}

		/// <summary>
		/// Starts a round if certain requirements are met
		/// </summary>
		/// <param name="game">The game to start a new round for</param>
		/// <param name="commander">The new round's commander</param>
		/// <returns>If a round was successfully started</returns>
		public Boolean Execute(Entities.Game game, Entities.User commander)
		{
			Boolean successful = false;

			//Check to make sure game still has required number of players
			if (game.HasRequiredNumberOfPlayers())
			{
				//Check to make sure the game has not been ended.
				if (game.GameOver.HasValue == false && !game.HasWinner())
				{
					Entities.GameRound round = _insertGameRound.Execute(game.GameID, commander);

					successful = round.GameRoundID > 0;

					if (successful)
					{
						game.Rounds.Add(round);

						game.RoundCount++;

						//Deal Cards
						_dealCards.Execute(game);
					}
				}
			}

			return successful;
		}
	}
}
