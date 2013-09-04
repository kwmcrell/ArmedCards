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
    public class GameListingController : Extensions.ArmedCardsController
    {
        AS.Base.ISelect _selectGame;

        public GameListingController(AS.Base.ISelect selectGame)
        {
            this._selectGame = selectGame;
        }

        /// <summary>
        /// Action to return a listing of available games.
        /// </summary>
        /// <param name="showLogIn">Should the show login modal appear</param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Index(int? id, bool? showLogIn)
        {
            Models.Game.Listing.Listing model = new Models.Game.Listing.Listing();

            if (showLogIn.HasValue)
            {
                TempData["showLogin"] = showLogIn.Value;
            }

            if (id.HasValue)
            {
                model.GameToShow = id.Value;
            }

            model.Games = _selectGame.Execute(new Entities.Filters.Game.SelectAll());

            return View("~/Views/Game/Listing/GameListing.cshtml", model);
        }

    }
}
