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
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Transactions;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace ArmedCards.Web.Controllers
{
    /// <summary>
    /// Controller responsible for handling creation of a player and login/logoff
    /// </summary>
    [Authentication.Extensions.ArmedCardsAuthorize]
    public class AccountController : Extensions.ArmedCardsController
    {
        private readonly BusinessLogic.AppServices.User.Base.IInsert _insertUser;
        private readonly BusinessLogic.AppServices.User.Base.IUpdate _updateUser;
        private readonly Library.Helpers.RegexUtilities _regexUtil;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="insertUser"></param>
        public AccountController(BusinessLogic.AppServices.User.Base.IInsert insertUser, BusinessLogic.AppServices.User.Base.IUpdate updateUser)
        {
            this._insertUser = insertUser;
            this._updateUser = updateUser;
            this._regexUtil = new Library.Helpers.RegexUtilities();
        }

        #region "Log Off"

        /// <summary>
        /// Log off the user
        /// </summary>
        /// <param name="returnUrl">Url to return the user to</param>
        /// <returns>A redirect</returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff(string returnUrl)
        {
            if (string.IsNullOrWhiteSpace(returnUrl))
            {
                returnUrl = "/";
            }

            Authentication.Security.Logout();

            return Redirect(returnUrl);
        }

        #endregion "Log Off"

        #region "External Logins"
        
        /// <summary>
        /// Call the external log in provider
        /// </summary>
        /// <param name="provider">The provider to call</param>
        /// <param name="returnUrl">The url to redirect after log in action complete</param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLogin(string provider, string returnUrl)
        {
            return new Authentication.Extensions.ExternalLoginResult(provider, Url.Action("ExternalLoginCallback", new { ReturnUrl = returnUrl }));
        }

        /// <summary>
        /// Method called once the external provider once their side of things are complete.  Reguardless of success.
        /// </summary>
        /// <param name="returnUrl">The url to redirect the user to if log in successful</param>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult ExternalLoginCallback(string returnUrl)
        {
            Authentication.Results.AuthResult result = Authentication.OAuthSecurity.VerifyAuthentication(Url.Action("ExternalLoginCallback", new { ReturnUrl = returnUrl }));
			
			if (result.IsSuccessful)
			{
                if (Authentication.OAuthSecurity.Login(result.Provider, result.ProviderUserId, createPersistentCookie: false))
				{
                    if(result.ExtraData.ContainsKey("email"))
                    {
                        string key = string.Format("TempUserEmailAddress");

                        Session.Add(key, MachineKey.Protect(Encoding.ASCII.GetBytes(result.ExtraData["email"]), Session.SessionID));

                        return RedirectToAction("UpdatePicture", "Account", new { returnUrl = returnUrl });
                    }

					return RedirectToLocal(returnUrl);
				}

				if (!User.Identity.IsAuthenticated)
				{
					// User is new, ask for their desired membership name
                    string loginData = Authentication.OAuthSecurity.SerializeProviderUserId(result.Provider, result.ProviderUserId);

					Authentication.Models.Account.RegisterExternalLogin model = new Authentication.Models.Account.RegisterExternalLogin
					{
						UserName = "",
						ExternalLoginData = loginData,
                        ProviderDisplayName = Authentication.OAuthSecurity.GetOAuthClientDataDisplayName(result.Provider),
						ReturnUrl = returnUrl,
                        UserEmail = result.ExtraData["email"]
					};

					return View("ExternalLoginConfirmation", model);
				}
			}

            return RedirectToAction("ExternalLoginFailure");
        }

        /// <summary>
        /// Action to call after the user has selected their username the first time the have logged in
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult ExternalLoginConfirmation(Authentication.Models.Account.RegisterExternalLogin model)
        {
            string provider = null;
            string providerUserId = null;

            if (User.Identity.IsAuthenticated || !Authentication.OAuthSecurity.TryDeserializeProviderUserId(model.ExternalLoginData, out provider, out providerUserId))
            {
                return RedirectToAction("Manage");
            }

            if (ModelState.IsValid)
            {
                Entities.User user = new Entities.User { DisplayName = model.UserName,
                                                         PictureUrl = String.Format("https://secure.gravatar.com/avatar/{0}?r=pg", CalculateMD5Hash(model.UserEmail))
													   };

                // Insert name into the profile table
                _insertUser.Execute(user);

                // Check if user already exists
                if (user.UserId > 0)
                {
                    Authentication.OAuthSecurity.CreateOrUpdateAccount(provider, providerUserId, model.UserName);
                    Authentication.OAuthSecurity.Login(provider, providerUserId, createPersistentCookie: false);

                    return RedirectToLocal(model.ReturnUrl);
                }
                else
                {
                    ModelState.AddModelError("UserName", "User name already exists. Please enter a different user name.");
                }
            }

            return View(model);
        }

        /// <summary>
        /// Render the external login failed screen
        /// </summary>
        /// <returns></returns>
        [AllowAnonymous]
        public ActionResult ExternalLoginFailure()
        {
            return View();
        }

        /// <summary>
        /// Get the list of external logins available
        /// </summary>
        /// <param name="returnUrl">Url to redirect the user to as soon as log in has occured</param>
        /// <returns></returns>
        [AllowAnonymous]
        [ChildActionOnly]
        public ActionResult ExternalLoginsList(string returnUrl)
        {
            Authentication.Models.Account.ExternalLoginList model = new Authentication.Models.Account.ExternalLoginList
            {
                ReturnUrl = returnUrl,
                Logins = Authentication.OAuthSecurity.GetLogins()
            };

            return PartialView("~/Views/Account/_LoginModal.cshtml", model);
        }
        #endregion "External Logins"

        #region Helpers

        public ActionResult UpdatePicture(string returnUrl)
        {
            string userEmail = null;

            if (Session["TempUserEmailAddress"] != null)
            {
                userEmail = Encoding.ASCII.GetString(MachineKey.Unprotect((Session["TempUserEmailAddress"] as Byte[]), Session.SessionID));

                Session.Remove("TempUserEmailAddress");
            }

            if (!string.IsNullOrWhiteSpace(userEmail) && _regexUtil.IsValidEmail(userEmail))
            {
                _updateUser.Execute(Authentication.Security.CurrentUserId, String.Format("https://secure.gravatar.com/avatar/{0}?r=pg", CalculateMD5Hash(userEmail)));
            }

            return RedirectToLocal(returnUrl);
        }

        private ActionResult RedirectToLocal(string returnUrl)
        {
            if (Url.IsLocalUrl(returnUrl))
            {
                return Redirect(returnUrl);
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        private string CalculateMD5Hash(string input)
        {
            // step 1, calculate MD5 hash from input
            MD5 md5 = System.Security.Cryptography.MD5.Create();
            byte[] inputBytes = System.Text.Encoding.Default.GetBytes(input.Trim().ToLower());
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString().ToLower();
        }

        private string ErrorCodeToString(MembershipCreateStatus createStatus)
        {
            // See http://go.microsoft.com/fwlink/?LinkID=177550 for
            // a full list of status codes.
            switch (createStatus)
            {
                case MembershipCreateStatus.DuplicateUserName:
                    return "User name already exists. Please enter a different user name.";

                case MembershipCreateStatus.DuplicateEmail:
                    return "A user name for that e-mail address already exists. Please enter a different e-mail address.";

                case MembershipCreateStatus.InvalidPassword:
                    return "The password provided is invalid. Please enter a valid password value.";

                case MembershipCreateStatus.InvalidEmail:
                    return "The e-mail address provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidAnswer:
                    return "The password retrieval answer provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidQuestion:
                    return "The password retrieval question provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.InvalidUserName:
                    return "The user name provided is invalid. Please check the value and try again.";

                case MembershipCreateStatus.ProviderError:
                    return "The authentication provider returned an error. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                case MembershipCreateStatus.UserRejected:
                    return "The user creation request has been canceled. Please verify your entry and try again. If the problem persists, please contact your system administrator.";

                default:
                    return "An unknown error occurred. Please verify your entry and try again. If the problem persists, please contact your system administrator.";
            }
        }

        #endregion
    }
}
