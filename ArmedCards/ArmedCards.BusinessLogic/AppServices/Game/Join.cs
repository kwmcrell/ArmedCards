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
using DS = ArmedCards.BusinessLogic.DomainServices.Game;

namespace ArmedCards.BusinessLogic.AppServices.Game
{
    /// <summary>
    /// Implementation of IJoin
    /// </summary>
    public class Join : Base.IJoin
    {
        private DS.Base.IJoin _joinGame;
        private Base.ISelect _selectGame;
        private Hubs.Base.ISendMessage _sendMessage;

        public Join(DS.Base.IJoin joinGame, Base.ISelect selectGame,
                    Hubs.Base.ISendMessage sendMessage)
        {
            this._joinGame = joinGame;
            this._selectGame = selectGame;
			this._sendMessage = sendMessage;
        }

        /// <summary>
        /// Join a game
        /// </summary>
        /// <param name="gameID">The id of the game to join</param>
        /// <param name="user">The current user</param>
        /// <param name="passphrase">The passphrase for the game</param>
        /// <param name="playerType">Type of player joining</param>
        /// <returns>The response to a join request</returns>
		public Entities.JoinResponse Execute(Int32 gameID, Entities.User user, String passphrase,
                                            Entities.Enums.GamePlayerType playerType)
        {
            Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
            filter.GameID = gameID;
			filter.DataToSelect |= Entities.Enums.Game.Select.Rounds;
			filter.DataToSelect |= Entities.Enums.Game.Select.GamePlayerCards;

            Entities.Game game = _selectGame.Execute(filter);

			Entities.JoinResponse response = _joinGame.Execute(game, user, passphrase,playerType);

            if (response.Game != null)
            {
                if (response.Game.IsWaiting() &&
                        response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer) == false)
                {
                    _sendMessage.UpdateWaiting(response.Game, true);
                }
                else if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.NewRoundStart) == true)
                {
                    _sendMessage.UpdateGame(response.Game, true);
                }
                else
                {
                    _sendMessage.UpdateLobby(response.Game, true);
                }
            }

			return response;
        }
    }
}
