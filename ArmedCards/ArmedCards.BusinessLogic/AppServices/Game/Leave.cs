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
using DS = ArmedCards.BusinessLogic.DomainServices;

namespace ArmedCards.BusinessLogic.AppServices.Game
{
	/// <summary>
	/// Implementation of <seealso cref="Base.ILeave"/>
	/// </summary>
	public class Leave : Base.ILeave
	{
		private DS.Game.Base.ILeave _leaveGame;
		private Game.Base.ISelect _selectGame;
        private Hubs.Base.ISendMessage _sendMessage;
		private GameRound.Base.IStart _startRound;
		private GameRound.Base.IDelete _deleteRound;
		private Base.IUpdate _updateGame;

		public Leave(DS.Game.Base.ILeave leaveGame, 
					 Game.Base.ISelect selectGame,
                     Hubs.Base.ISendMessage sendMessage,
					 GameRound.Base.IStart startRound,
					 GameRound.Base.IDelete deleteRound,
					 Base.IUpdate updateGame)
		{
			this._leaveGame = leaveGame;
			this._selectGame = selectGame;
			this._sendMessage = sendMessage;
			this._startRound = startRound;
			this._deleteRound = deleteRound;
			this._updateGame = updateGame;
		}

		/// <summary>
		/// Removes a player from the game
		/// </summary>
		/// <param name="gameID">The ID of the game to leave</param>
		/// <param name="user">The user leaving the game</param>
        /// <param name="playerType">Type of player leaving</param>
        public void Execute(Int32 gameID, Entities.User user, Entities.Enums.GamePlayerType playerType)
		{
			Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
			filter.GameID = gameID;
            filter.DataToSelect = Entities.Enums.Game.Select.Rounds | Entities.Enums.Game.Select.GamePlayerCards;

			Entities.Game game = _selectGame.Execute(filter);

			Boolean wasWaiting = game.IsWaiting();

			Boolean wasCurrentCommander = game.IsCurrentCommander(user.UserId) && playerType == Entities.Enums.GamePlayerType.Player;

            Entities.GamePlayer player = null;

            if (playerType == Entities.Enums.GamePlayerType.Player)
            {
                player = game.Players.Find(x => x.User.UserId == user.UserId);
                game.Players.Remove(player);
                game.PlayerCount--;
            }
            else
            {
                player = game.Spectators.Find(x => x.User.UserId == user.UserId);

                game.Spectators.Remove(player);
                game.SpectatorCount--;
            }

			if (wasCurrentCommander)
			{
				if (game.HasRounds())
				{
					Entities.GameRound current = game.CurrentRound();

					game.Rounds.Remove(current);
					game.RoundCount--;

					Entities.Filters.GameRound.Delete deleteRoundFilter = new Entities.Filters.GameRound.Delete();
					deleteRoundFilter.GameRoundID = current.GameRoundID;

					_deleteRound.Execute(deleteRoundFilter);
				}
			
				Boolean started = _startRound.Execute(game, game.NextCommander(null));

                _sendMessage.CommanderLeft(game, user.DisplayName);
			}
			else if (game.IsWaiting() && wasWaiting)
			{
                _sendMessage.UpdateWaiting(game, true);
			}
			else
			{
				if (game.HasRounds())
				{
					Entities.GameRound current = game.CurrentRound();
					current.CurrentPlayerCount--;
				}

                _sendMessage.UpdateGame(game, true);
			}

			_leaveGame.Execute(gameID, user, playerType);

			if (game.PlayerCount == 0)
			{
				DateTime now = DateTime.UtcNow;

				_updateGame.Execute(gameID, now, now);
			}
		}
	}
}
