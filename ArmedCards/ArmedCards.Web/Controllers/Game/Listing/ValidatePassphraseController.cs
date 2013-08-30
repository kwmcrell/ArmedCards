using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using AS = ArmedCards.BusinessLogic.AppServices.Game;

namespace ArmedCards.Web.Controllers.Game.Listing
{
    public class ValidatePassphraseController : Extensions.ArmedCardsController
    {
        private AS.Base.IValidatePassphrase _validatePassphrase;

        public ValidatePassphraseController(AS.Base.IValidatePassphrase validatePassphrase)
        {
            this._validatePassphrase = validatePassphrase;
        }

        /// <summary>
        /// Validates the user supplied passphrase
        /// </summary>
        /// <param name="id">The game ID to retrieve the game</param>
        /// <param name="passphrase">The user supplied passphrase</param>
        /// <returns>If the passphrase was validated</returns>
        [HttpPost]
        public JsonResult Index(int id, string passphrase)
        {
            return Json(Convert.ToInt32(_validatePassphrase.Execute(id, passphrase)));
        }

    }
}
