using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ArmedCards.Web.Controllers.Game.Listing
{
    public class GameListingController : Extensions.ArmedCardsController
    {
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

            return View("~/Views/Game/Listing/GameListing.cshtml", model);
        }

    }
}
