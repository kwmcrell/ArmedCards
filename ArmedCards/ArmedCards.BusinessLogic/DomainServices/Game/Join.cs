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
using REPO = ArmedCards.BusinessLogic.Repositories;

namespace ArmedCards.BusinessLogic.DomainServices.Game
{
    /// <summary>
    /// Implementation of IJoin
    /// </summary>
    public class Join : Base.IJoin
    {
        private Base.IValidatePassphrase _validatePassphrase;
		private REPO.Game.Base.IJoin _joinGame;
		private AS.GameRound.Base.IStart _startRound;

		public Join(Base.IValidatePassphrase validatePassphrase, REPO.Game.Base.IJoin joinGame,
					AS.GameRound.Base.IStart _startRound)
        {
            this._validatePassphrase = validatePassphrase;
			this._joinGame = joinGame;
			this._startRound = _startRound;
        }

        /// <summary>
        /// Join a game
        /// </summary>
        /// <param name="gameID">The game to join</param>
        /// <param name="user">The current user</param>
        /// <param name="passphrase">The passphrase for the game</param>
        /// <param name="playerType">Type of player joining</param>
        /// <returns>The response to a join request</returns>
        public Entities.JoinResponse Execute(Entities.Game game, Entities.User user, String passphrase, Entities.Enums.GamePlayerType playerType)
        {
            Entities.JoinResponse response = new Entities.JoinResponse();

			Boolean wasWaiting = game.IsWaiting();

            if(playerType == Entities.Enums.GamePlayerType.Spectator)
            {
                AsSpectator(game, user, passphrase, response);
            }
            else
            {
                AsPlayer(game, user, passphrase, response, wasWaiting);
            }

            return response;
        }

        private void AsPlayer(Entities.Game game, Entities.User user, String passphrase, Entities.JoinResponse response, Boolean wasWaiting)
        {
            if (game.IsCurrentPlayer(user.UserId) == false)
            {
                if (_validatePassphrase.Execute(game, passphrase) == false)
                {
                    response.Result |= Entities.Enums.Game.JoinResponseCode.BadPassphrase;
                }
                else if (game.IsFull())
                {
                    response.Result |= Entities.Enums.Game.JoinResponseCode.FullGame;
                }
                else
                {
                    Boolean successful = _joinGame.Execute(game, user, Entities.Enums.GamePlayerType.Player);

                    if (successful == false)
                    {
                        response.Result |= Entities.Enums.Game.JoinResponseCode.FullGame;
                    }
                    else
                    {
                        if (wasWaiting && !game.IsWaiting())
                        {
                            Entities.User newCommander = game.NextCommander(null);

                            if (newCommander != null)
                            {
                                if (_startRound.Execute(game, game.NextCommander(null)) == true)
                                {
                                    response.Result |= Entities.Enums.Game.JoinResponseCode.NewRoundStart;
                                }
                            }
                            else
                            {
                                response.Result |= Entities.Enums.Game.JoinResponseCode.WaitingOnWinnerSelection;
                            }
                        }
                    }
                }
            }
            else
            {
                response.Result |= Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer;
            }

            if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.BadPassphrase) == false &&
                response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.FullGame) == false)
            {
                response.Game = game;
            }
        }

        private void AsSpectator(Entities.Game game, Entities.User user, String passphrase, Entities.JoinResponse response)
        {
            if (game.IsCurrentSpectator(user.UserId) == false)
            {
                if (_validatePassphrase.Execute(game, passphrase) == false)
                {
                    response.Result |= Entities.Enums.Game.JoinResponseCode.BadPassphrase;
                }
                else if (game.MaxSpectatorsReached())
                {
                    response.Result |= Entities.Enums.Game.JoinResponseCode.SpectatorsFull;
                }
                else
                {
                    Boolean successful = _joinGame.Execute(game, user, Entities.Enums.GamePlayerType.Spectator);

                    if (successful == false)
                    {
                        response.Result |= Entities.Enums.Game.JoinResponseCode.SpectatorsFull;
                    }
                }
            }
            else
            {
                response.Result |= Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer;
            }

            if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.BadPassphrase) == false &&
                response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.FullGame) == false)
            {
                response.Game = game;
            }
        }
    }
}
