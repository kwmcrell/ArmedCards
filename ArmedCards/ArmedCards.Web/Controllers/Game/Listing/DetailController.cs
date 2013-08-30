using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AS = ArmedCards.BusinessLogic.AppServices.Game;

namespace ArmedCards.Web.Controllers.Game.Listing
{
    public class DetailController : Extensions.ArmedCardsController
    {
        private AS.Base.ISelect _selectGame;

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
            Models.Game.Listing.Detail model = new Models.Game.Listing.Detail();

            Entities.Filters.Game.Select filter = new Entities.Filters.Game.Select();
            filter.GameID = id;

            model.Game = _selectGame.Execute(filter);

            return PartialView("~/Views/Game/Listing/Detail.cshtml", model);
        }

    }
}
