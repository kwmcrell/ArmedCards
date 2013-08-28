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
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;

namespace ArmedCards.Library.Extensions
{
    /// <summary>
    /// Class that contains all string extensions
    /// </summary>
    public static class StringExtension
    {
        /// <summary>
        /// Compiled regular expression for performance.
        /// </summary>
        static Regex _htmlRegex = new Regex("<[^>]*>", RegexOptions.Compiled);

        /// <summary>
        /// Remove HTML from the string
        /// </summary>
        /// <param name="str">The string in which to remove the HTML</param>
        /// <returns>A processed string</returns>
        public static string RemoveHtml(this string str)
        {
            return _htmlRegex.Replace(str, string.Empty);
        }

        /// <summary>
        /// Encode HTML in a string
        /// </summary>
        /// <param name="str">String to encode</param>
        /// <returns>A processed string</returns>
        public static string HTMLEncode(this string str)
        {
            return HttpUtility.HtmlEncode(str);
        }

        /// <summary>
        /// Decode HTML in a string
        /// </summary>
        /// <param name="str">String to decode</param>
        /// <returns>A processed string</returns>
        public static string HTMLDecode(this string str)
        {
            return HttpUtility.HtmlDecode(str);
        }

        /// <summary>
        /// Decode and Remove html
        /// </summary>
        /// <param name="str">String to decode and remove html from</param>
        /// <returns>A processed string</returns>
        public static string HTMLDecodeAndRemove(this string str)
        {
            return str.HTMLDecode().RemoveHtml();
        }
    }
}
