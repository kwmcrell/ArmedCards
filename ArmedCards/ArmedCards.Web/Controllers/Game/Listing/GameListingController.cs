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
        public ActionResult Index(bool? showLogIn)
        {
            if (showLogIn.HasValue)
            {
                TempData["showLogin"] = showLogIn.Value;
            }

            Models.Game.Listing.Listing model = new Models.Game.Listing.Listing();
            model.Games = _selectGame.Execute(new Entities.Filters.Game.SelectAll());

            return View("~/Views/Game/Listing/GameListing.cshtml", model);
        }

    }
}
