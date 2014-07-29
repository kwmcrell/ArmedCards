using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.Web.Controllers
{
    /// <summary>
    /// Controller responsible for handling creating a game
    /// </summary>
    [Authentication.Extensions.ArmedCardsAuthorize]
    public class ChatMessageController : Extensions.ArmedCardsController
    {
        private AS.ChatMessage.Base.ISelect _select;

        public ChatMessageController(AS.ChatMessage.Base.ISelect select)
        {
            this._select = select;
        }

        [HttpGet]
        public JsonResult View(Int32? gameID = null, Boolean? global = null, Int32? offsetHours = null)
        {
            Entities.Filters.ChatMessage.Select filter = new Entities.Filters.ChatMessage.Select(gameID, global, offsetHours);

            List<Entities.ChatMessage> messages = _select.Execute(filter);

            return Json(new { Messages = messages }, JsonRequestBehavior.AllowGet);
        }
	}
}