using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using ACAS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.Web.Controllers.Game
{
    [Extensions.ArmedCardsAuthorize]
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
        public ActionResult Index(Models.Game.CreateGame model)
        {
            if (ModelState.IsValid)
            {
                model.Game.GameCreator_UserId = WebSecurity.CurrentUserId;

                _insertGame.Execute(model.Game);

                return Redirect("/");
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
            Models.Game.CreateGame model = new Models.Game.CreateGame();

            return View("~/Views/CreateGame/CreateGame.cshtml", model);
        }
    }
}
