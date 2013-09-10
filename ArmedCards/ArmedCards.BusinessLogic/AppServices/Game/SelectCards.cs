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
	/// Implementation of ISelectCards
	/// </summary>
	public class SelectCards : Base.ISelectCards
	{
		private Base.ISelect _selectGame;
		private DS.Base.ISelectCards _selectGameCards;

		public SelectCards(Base.ISelect selectGame, DS.Base.ISelectCards selectGameCards)
		{
			this._selectGame = selectGame;
			this._selectGameCards = selectGameCards;
		}

		/// <summary>
		/// Select cards for a certain game
		/// </summary>
		/// <param name="gameID">The game ID</param>
		/// <returns>List of cards that belong to the game's decks</returns>
		public List<Entities.Card> Execute(int gameID)
		{
			Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
			filter.GameID = gameID;

			Entities.Game game = _selectGame.Execute(filter);

			return Execute(game);
		}

		/// <summary>
		/// Select cards for a certain game
		/// </summary>
		/// <param name="gameID">The game</param>
		/// <returns>List of cards that belong to the game's decks</returns>
		public List<Entities.Card> Execute(Entities.Game game)
		{
			return _selectGameCards.Execute(game);
		}
	}
}
