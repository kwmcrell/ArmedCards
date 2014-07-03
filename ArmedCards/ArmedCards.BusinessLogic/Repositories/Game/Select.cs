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
using DAL = ArmedCards.DataAccess.Game;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.BusinessLogic.Repositories.Game
{
    /// <summary>
    /// Implementation of ISelect
    /// </summary>
    public class Select : Base.ISelect
    {
        private DAL.Base.ISelect _selectGame;
        private GamePlayer.Base.ISelect _selectGamePlayerREPO;
		private AS.Deck.Base.ISelect _selectDeck;
		private AS.GameRound.Base.ISelect _selectGameRound;

        public Select(DAL.Base.ISelect selectGame,
                      GamePlayer.Base.ISelect selectGamePlayerREPO,
					  AS.Deck.Base.ISelect selectDeck,
					  AS.GameRound.Base.ISelect selectGameRound)
        {
            this._selectGame = selectGame;
            this._selectGamePlayerREPO = selectGamePlayerREPO;
			this._selectDeck = selectDeck;
			this._selectGameRound = selectGameRound;
        }

        /// <summary>
        /// Selects all games based on supplied filter
        /// </summary>
        /// <param name="filter">Filter used to select games</param>
        /// <returns>A list of games that satisfy the supplied filter</returns>
        public List<Entities.Game> Execute(Entities.Filters.Game.SelectAll filter)
        {
            List<Entities.Game> games = _selectGame.Execute(filter);

            //Entities.Filters.Deck.SelectByGameID deckFilter = new Entities.Filters.Deck.SelectByGameID();
            //deckFilter.GameIDs.AddRange(games.Select(x => x.GameID));

            //List<Entities.Deck> decks =  _selectDeck.Execute(deckFilter);

            //foreach (Entities.Game game in games)
            //{
            //    game.GameDecks = decks.Where(x => x.GameID == game.GameID && x.DeckID != 1).ToList();
            //}

            return games;
        }

        /// <summary>
        /// Selects a game based on supplied filter
        /// </summary>
        /// <param name="filter">Filter used to select game</param>
        /// <returns>A game that satisfy the supplied filter</returns>
        public Entities.Game Execute(Entities.Filters.Game.Select filter)
        {
            Entities.Game game = _selectGame.Execute(filter);

            Entities.Filters.GamePlayer.Select playerFilter = new Entities.Filters.GamePlayer.Select();
            playerFilter.GameID = filter.GameID;
			playerFilter.SelectCards = filter.DataToSelect.HasFlag(Entities.Enums.Game.Select.GamePlayerCards);

            List<Entities.GamePlayer> allPlayers = _selectGamePlayerREPO.Execute(playerFilter);

            game.Players = allPlayers.Where(x => x.PlayerType == Entities.Enums.GamePlayerType.Player).ToList();
            game.Spectators = allPlayers.Where(x => x.PlayerType == Entities.Enums.GamePlayerType.Spectator).ToList();

			Entities.Filters.Deck.SelectByGameID deckFilter = new Entities.Filters.Deck.SelectByGameID();
			deckFilter.GameIDs.Add(game.GameID);

			game.GameDecks = _selectDeck.Execute(deckFilter);

			if (filter.DataToSelect.HasFlag(Entities.Enums.Game.Select.Rounds))
			{
				game.Rounds.Add(_selectGameRound.Execute(game.GameID, true));
			}

            return game;
        }
    }
}
