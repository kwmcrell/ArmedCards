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
using System.Web;
using System.Web.Mvc;
using AS = ArmedCards.BusinessLogic.AppServices.Game;

namespace ArmedCards.Web.Controllers.Game.Listing
{
    /// <summary>
    /// Controller responsible for displaying game details when a user selects a game from the listing screen
    /// </summary>
    public class DetailController : Extensions.ArmedCardsController
    {
        private AS.Base.ISelect _selectGame;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="selectGame"></param>
        public DetailController(AS.Base.ISelect selectGame)
        {
            this._selectGame = selectGame;
        }

        /// <summary>
        /// Returns the game detail view for the game that matches <paramref name="id"/>
        /// </summary>
        /// <param name="id">The game ID</param>
        /// <returns>The details of the selected game</returns>
        [HttpGet]
        public ActionResult Index(int id)
        {
            Entities.Models.Game.Listing.Detail model = new Entities.Models.Game.Listing.Detail();

            Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
            filter.GameID = id;

            model.Game = _selectGame.Execute(filter);

            if(model.Game.GameDecks != null)
            {
                model.Game.GameDecks.RemoveAll(x => x.DeckID == 1);
            }

            return PartialView("~/Views/Game/Listing/Detail.cshtml", model);
        }

    }
}
