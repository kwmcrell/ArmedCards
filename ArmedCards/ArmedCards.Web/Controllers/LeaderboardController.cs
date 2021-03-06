﻿/*
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
using ACAS = ArmedCards.BusinessLogic.AppServices.Leaderboard;

namespace ArmedCards.Web.Controllers
{
    /// <summary>
    /// Controller responsible for rendering the leaderboard
    /// </summary>
    public class LeaderboardController : Extensions.ArmedCardsController
    {
        private ACAS.Base.ISelect _selectLeaderboard;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="selectLeaderboard"></param>
        public LeaderboardController(ACAS.Base.ISelect selectLeaderboard)
        {
            this._selectLeaderboard = selectLeaderboard;
        }

        /// <summary>
        /// Render the leaderboard view
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            Entities.Models.Leaderboard.Index viewModel = new Entities.Models.Leaderboard.Index();
            viewModel.CurrentUserId = Authentication.Security.CurrentUserId;
            viewModel.Leaderboards =  _selectLeaderboard.Execute(viewModel.CurrentUserId);

            return View(viewModel);
        }
    }
}
