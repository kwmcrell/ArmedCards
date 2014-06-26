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
using System.Runtime.Caching;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using DS = ArmedCards.BusinessLogic.DomainServices.GameRound;
using Microsoft.Practices.Unity;


namespace ArmedCards.BusinessLogic.AppServices.GameRound
{
	/// <summary>
	/// Implementation of <seealso cref="Base.IStart"/>
	/// </summary>
	public class Start : Base.IStart
	{
		private DS.Base.IStart _startRound;
		private Game.Base.IUpdate _updateGame;

		public Start(DS.Base.IStart startRound,
					 Game.Base.IUpdate updateGame)
		{
			this._startRound = startRound;
			this._updateGame = updateGame;
		}

		/// <summary>
		/// Starts a round if certain requirements are met
		/// </summary>
		/// <param name="game">The game to start a new round for</param>
		/// <param name="commander">The new round's commander</param>
		/// <returns>If a round was successfully started</returns>
		public Boolean Execute(Entities.Game game, Entities.User commander)
		{
			Boolean started = _startRound.Execute(game, commander);

            if (started && game.SecondsToPlay > 0)
            {
                CancellationTokenSource token = new CancellationTokenSource();

                MemoryCache.Default.Add(game.RoundTimerKey, token, DateTimeOffset.Now.AddSeconds(15 + game.SecondsToPlay));

                Task.Delay(((game.SecondsToPlay + 15) * 1000), token.Token).ContinueWith((delayedTask) =>
                {
                    UnityConfig.Container.Resolve<AppServices.GameRound.Base.ITimerExpired>().Execute(game.GameID);
                }, TaskContinuationOptions.OnlyOnRanToCompletion);
            }

			_updateGame.Execute(game.GameID, DateTime.UtcNow, null);
			
			return started;
		}
	}
}
