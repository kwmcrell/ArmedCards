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
using ACAS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.Web.Controllers.Game
{
    [Authentication.Extensions.ArmedCardsAuthorize]
    public class CreateGameController : Extensions.ArmedCardsController
    {
        private readonly ACAS.Game.Base.IInsert _insertGame;

        public CreateGameController(ACAS.Game.Base.IInsert insertGame)
        {
            this._insertGame = insertGame;
        }

        /// <summary>
        /// Post action to create a game
        /// </summary>
        /// <param name="model">The model that contains the game to create</param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult Index(Entities.Models.Game.CreateGame model)
        {
            if (ModelState.IsValid)
            {
                model.Game.GameCreator_UserId = Authentication.Security.CurrentUserId;
                model.Game.GameDeckIDs.Add(1);

                _insertGame.Execute(model.Game);

                return Redirect(Url.RouteUrl("Game_NoAction", new { id = model.Game.GameID }));
            }
            else
            {
                return View("~/Views/CreateGame/CreateGame.cshtml", model);
            }
        }

        /// <summary>
        /// Get action to view the Create Game view
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Index()
        {
            Entities.Models.Game.CreateGame model = new Entities.Models.Game.CreateGame();

            return View("~/Views/CreateGame/CreateGame.cshtml", model);
        }
    }
}
