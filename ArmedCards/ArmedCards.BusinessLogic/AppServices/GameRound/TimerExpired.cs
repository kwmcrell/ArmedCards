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
using Microsoft.Practices.Unity;

namespace ArmedCards.BusinessLogic.AppServices.GameRound
{
    /// <summary>
    /// Implements <see cref="Base.ITimerExpired"/>
    /// </summary>
    public class TimerExpired : Base.ITimerExpired
    {
        private AppServices.Game.Base.ISelect _selectGame;
        private AppServices.GamePlayerCard.Base.IPlay _playCard;
        private AppServices.Hubs.Base.ISendMessage _sendMessage;
        private AppServices.GamePlayer.Base.IUpdate _updateGamePlayer;

        public TimerExpired(AppServices.Game.Base.ISelect selectGame,
                            AppServices.GamePlayerCard.Base.IPlay playCard,
                            AppServices.Hubs.Base.ISendMessage sendMessage,
                            AppServices.GamePlayer.Base.IUpdate updateGamePlayer)
        {
            this._selectGame = selectGame;
            this._playCard = playCard;
            this._sendMessage = sendMessage;
            this._updateGamePlayer = updateGamePlayer;
        }

        /// <summary>
        /// Play cards for all players that have yet to play
        /// </summary>
        /// <param name="gameID">The game ID</param>
        public void Execute(int gameID)
        {
            Entities.Filters.Game.Select gameFilter = new Entities.Filters.Game.Select();
            gameFilter.DataToSelect = Entities.Enums.Game.Select.GamePlayerCards | Entities.Enums.Game.Select.Rounds;
            gameFilter.GameID = gameID;

            Entities.Game game = _selectGame.Execute(gameFilter);

            Entities.GameRound round = game.CurrentRound();

            List<Entities.GamePlayer> players = game.Players.Where(x => !round.HasAnswer(x.User.UserId) &&
                                                                        game.IsCurrentPlayer(x.User.UserId) &&
                                                                        !game.IsCurrentCommander(x.User.UserId))
                                                            .Select(x => x).ToList();

            Int32 selectCount = 1 + (Int32)round.Question.Instructions;

            Random rdm = new Random();

            List<Int32> cardIDs = null;
            Entities.ActionResponses.PlayCard response = null;

            foreach (Entities.GamePlayer player in players)
            {
                cardIDs = player.Hand.OrderBy(x => rdm.Next()).Take(selectCount).Select(x => x.CardID).ToList();
                response = _playCard.Execute(cardIDs, gameID, player.User.UserId, true);

                if (response.AutoPlayedSuccess)
                {
                    if (player.IdlePlayCount + 1 == 3)
                    {
                        //Player is forced to leave game now
                        UnityConfig.Container.Resolve<AppServices.Game.Base.ILeave>().Execute(gameID, player.User, Entities.Enums.GamePlayerType.Player, true);
                    }
                    else
                    {
                        Entities.Filters.GamePlayer.UpdateIdlePlayCount idlePlayCount =
                            new Entities.Filters.GamePlayer.UpdateIdlePlayCount
                            {
                                GameID = gameID,
                                UserId = player.User.UserId
                            };

                        _updateGamePlayer.Execute(idlePlayCount);
                    }
                }
            }
        }
    }
}
