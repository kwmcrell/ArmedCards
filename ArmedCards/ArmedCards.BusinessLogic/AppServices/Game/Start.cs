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

namespace ArmedCards.BusinessLogic.AppServices.Game
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IStart"/>
	/// </summary>
	public class Start : Base.IStart
	{
		private Base.ISelect _selectGame;
		private GameRound.Base.IStart _startRound;
		private Hubs.Base.ISendMessage _sendMessage;

		public Start(Base.ISelect selectGame, GameRound.Base.IStart startRound,
					 Hubs.Base.ISendMessage sendMessage)
		{
			this._selectGame = selectGame;
			this._startRound = startRound;
			this._sendMessage = sendMessage;
		}

		/// <summary>
		/// Starts a game if certain requirements are met
		/// </summary>
		/// <param name="gameID">The ID for the game to start</param>
		/// <param name="commander">The commander for the first round</param>
		/// <returns>The started game</returns>
		public Entities.Game Execute(Int32 gameID, Entities.User commander)
		{
			Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
			filter.GameID = gameID;
            filter.DataToSelect = Entities.Enums.Game.Select.GamePlayerCards;

			Entities.Game game = _selectGame.Execute(filter);

			Entities.GamePlayer host = game.Players.First();

			if (game.IsCurrentCommander(commander.UserId))
			{
				Boolean successful = _startRound.Execute(game, commander);

				if (successful)
				{
                    _sendMessage.UpdateGame(game, true);
				}
			}

			return game;
		}
	}
}
