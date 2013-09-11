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

		public Join(Base.IValidatePassphrase validatePassphrase, REPO.Game.Base.IJoin joinGame)
        {
            this._validatePassphrase = validatePassphrase;
			this._joinGame = joinGame;
        }

        /// <summary>
        /// Join a game
        /// </summary>
        /// <param name="gameID">The game to join</param>
        /// <param name="userId">The current user id</param>
        /// <param name="passphrase">The passphrase for the game</param>
        /// <returns>The response to a join request</returns>
        public Entities.JoinResponse Execute(Entities.Game game, int userId, string passphrase)
        {
            Entities.JoinResponse response = new Entities.JoinResponse();

			if (game.IsCurrentPlayer(userId) == false)
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
					Boolean successful = _joinGame.Execute(game, userId);

					if (successful == false)
					{
						response.Result |= Entities.Enums.Game.JoinResponseCode.FullGame;
					}
				}
			}
			else
			{
				response.Result |= Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer;
			}

			if (response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.Successful) ||
				response.Result.HasFlag(Entities.Enums.Game.JoinResponseCode.SuccessfulAlreadyPlayer))
			{
				response.Game = game;
			}

            return response;
        }
    }
}
