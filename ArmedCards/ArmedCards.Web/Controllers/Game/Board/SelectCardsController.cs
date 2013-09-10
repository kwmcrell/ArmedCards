using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AS = ArmedCards.BusinessLogic.AppServices.Game;

namespace ArmedCards.Web.Controllers.Game.Board
{
	[Extensions.ArmedCardsAuthorize]
    public class SelectCardsController : Extensions.ArmedCardsController
    {
		private AS.Base.ISelectCards _selectCards;

		public SelectCardsController(AS.Base.ISelectCards selectCards)
		{
			this._selectCards = selectCards;
		}

		[HttpPost]
		public ActionResult Index(int id)
        {
			List<Entities.Card> cards = new List<Entities.Card>(); //_selectCards.Execute(id);

			List<Entities.Card> answers = cards.Where(x => x.Type == Entities.Enums.Card.CardType.Answer).ToList();
			List<Entities.Card> questions = cards.Where(x => x.Type == Entities.Enums.Card.CardType.Question).ToList();

			return Json(new
			{
				Answers = answers,
				Questions = questions
			});
        }

    }
}
