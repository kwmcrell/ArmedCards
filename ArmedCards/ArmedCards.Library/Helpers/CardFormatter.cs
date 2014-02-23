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
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ArmedCards.Library.Helpers
{
    /// <summary>
    /// Class responsible for generating html tags for cards
    /// </summary>
	public static class CardFormatter
	{
        /// <summary>
        /// Replace the stored blank with a span blank
        /// </summary>
        /// <param name="cardContext">The card's content</param>
        /// <returns></returns>
		public static String ReplaceBlankWithHtml(String cardContext)
		{
			TagBuilder blankSpan = new TagBuilder("span");
			blankSpan.AddCssClass("blank");

			return cardContext.Replace("_____", blankSpan.ToString());
		}

        /// <summary>
        /// Get card branding
        /// </summary>
        /// <returns></returns>
		public static String GetBrandingHtml()
		{
			TagBuilder brandDiv = new TagBuilder("div");
			brandDiv.AddCssClass("branding");
			brandDiv.InnerHtml = "Armed Cards!#&amp;?";

			return brandDiv.ToString();
		}

        /// <summary>
        /// Get pick order div
        /// </summary>
        /// <returns></returns>
        public static String PickOrder()
        {
            TagBuilder brandDiv = new TagBuilder("div");
            brandDiv.Attributes.Add("name", "pickOrder");

            return brandDiv.ToString();
        }

        /// <summary>
        /// Get pick 2 instructions
        /// </summary>
        /// <param name="innerHtml">Instructions</param>
        /// <returns></returns>
        public static String Pick2Instructions(String innerHtml)
        {
            TagBuilder brandDiv = new TagBuilder("div");
            brandDiv.AddCssClass("pickTwo");
            brandDiv.InnerHtml = innerHtml;

            return brandDiv.ToString();
        }
	}
}
