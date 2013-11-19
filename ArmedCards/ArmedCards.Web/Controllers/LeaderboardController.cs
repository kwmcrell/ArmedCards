using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebMatrix.WebData;
using ACAS = ArmedCards.BusinessLogic.AppServices.Leaderboard;

namespace ArmedCards.Web.Controllers
{
    public class LeaderboardController : Extensions.ArmedCardsController
    {
        private ACAS.Base.ISelect _selectLeaderboard;

        public LeaderboardController(ACAS.Base.ISelect selectLeaderboard)
        {
            this._selectLeaderboard = selectLeaderboard;
        }

        public ActionResult Index()
        {
            Models.Leaderboard.Index viewModel = new Models.Leaderboard.Index();
            viewModel.CurrentUserId = WebSecurity.CurrentUserId;
            viewModel.Leaderboards =  _selectLeaderboard.Execute(viewModel.CurrentUserId);

            return View(viewModel);
        }
    }
}
