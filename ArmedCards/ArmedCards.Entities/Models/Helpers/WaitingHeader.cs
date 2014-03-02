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
using System.Web.Mvc;

namespace ArmedCards.Entities.Models.Helpers
{
    /// <summary>
    /// Class used to build the waiting header
    /// </summary>
    public static class WaitingHeader
    {
        public static String Build(Entities.Game game, Int32 currentUserId, Entities.Enums.GamePlayerType playerType)
        {
            String waitingOnPlayers = "{0} is waiting for {1} more {2}...";
            String commanderStartGame = "{0} can be started. {1}";
            String waitingOnHost = "{0} waiting on commander to start game...";

            String headerText = String.Empty;

            if (game.HasRequiredNumberOfPlayers() == false)
            {
                Int32 shortNumberOfPlayers = game.NumberOfPlayersNeededToStart();

                headerText = string.Format(waitingOnPlayers,
                                       game.Title,
                                       shortNumberOfPlayers.ToString(),
                                       shortNumberOfPlayers == 1 ? "player" : "players");
            }
            else
            {
                if(game.IsCurrentCommander(currentUserId) && playerType == Entities.Enums.GamePlayerType.Player)
                {
                    TagBuilder startGame = new TagBuilder("a");
                    startGame.AddCssClass("button");
                    startGame.AddCssClass("startGameButton");
                    startGame.InnerHtml = "Start";
                    startGame.Attributes.Add("style", "font-size: .8em; cursor: pointer;");

                    headerText = string.Format(commanderStartGame, game.Title, startGame.ToString());
                }
                else
                {
                    headerText = string.Format(waitingOnHost, game.Title);
                }
            }

            return headerText;
        }
    }
}
