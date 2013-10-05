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
using WebMatrix.WebData;
using AS = ArmedCards.BusinessLogic.AppServices;

namespace ArmedCards.Web.Controllers
{
	[Extensions.ArmedCardsAuthorize]
	public class ProfileController : Extensions.ArmedCardsController
    {
		private AS.User.Base.ISelect _selectUser;

		public ProfileController(AS.User.Base.ISelect selectUser)
		{
			this._selectUser = selectUser;
		}
		
		[HttpGet]
        public ActionResult Index(int id)
        {
			Entities.User viewedProfile = _selectUser.Execute(id);

			Models.Profile.Profile model = new Models.Profile.Profile();
			model.ViewedProfile = viewedProfile;
			model.MyProfile = viewedProfile.UserId == WebSecurity.CurrentUserId;

			return View(model);
        }

		[HttpGet]
		public ActionResult ChangeDisplayName()
		{
			Models.Profile.ChangeDisplayName model = new Models.Profile.ChangeDisplayName();
			model.DisplayName = WebSecurity.CurrentUserName;

			return View(model);
		}

    }
}
