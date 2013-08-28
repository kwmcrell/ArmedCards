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
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ArmedCards.Web.Extensions.Html
{
    /// <summary>
    /// Class containing Checkbox Renders
    /// </summary>
    public static class Checkbox
    {
        /// <summary>
        /// Renders a label and checkbox
        /// </summary>
        /// <typeparam name="TModel">The Model Type</typeparam>
        /// <param name="helper">The HtmlHelper</param>
        /// <param name="model">The Model</param>
        /// <param name="selector">The lambda expression to select the property of the model</param>
        /// <param name="labelText">The text for the label</param>
        /// <param name="labelClasses">The classes to be applied to the label</param>
        /// <returns>A checkbox input and label</returns>
        public static MvcHtmlString CheckboxFor<TModel>(this HtmlHelper helper, TModel model, Expression<Func<TModel, Boolean>> selector, string labelText, string labelClasses)
        {
            string id = selector.Body.ToString();

            int indexOf = id.IndexOf('.') + 1;

            id = id.Substring(indexOf);

            string name = id;

            id = id.Replace('.', '_');

            StringBuilder completeElement = new StringBuilder();

            TagBuilder inputBuilder = BuildInput(id, name);

            TagBuilder labelBuilder = BuildLabel(labelText, labelClasses, id);

            completeElement.AppendLine(inputBuilder.ToString());
            completeElement.AppendLine(labelBuilder.ToString());

            return new MvcHtmlString(completeElement.ToString());
        }

        private static TagBuilder BuildLabel(string labelText, string labelClasses, string id)
        {
            StringBuilder spanStringBuilder = new StringBuilder();

            TagBuilder labelBuilder = new TagBuilder("label");
            TagBuilder spanBuilder = new TagBuilder("span");

            labelBuilder.Attributes.Add("for", id);

            labelBuilder.AddCssClass(labelClasses);

            spanBuilder.AddCssClass("fakeCheck");

            spanStringBuilder.AppendLine(spanBuilder.ToString());

            spanBuilder = new TagBuilder("span");
            spanBuilder.AddCssClass("realLabel");

            spanBuilder.SetInnerText(labelText);

            spanStringBuilder.AppendLine(spanBuilder.ToString());

            labelBuilder.InnerHtml = spanStringBuilder.ToString();
            return labelBuilder;
        }

        private static TagBuilder BuildInput(string id, string name)
        {
            TagBuilder inputBuilder = new TagBuilder("input");

            inputBuilder.Attributes.Add("type", "checkbox");

            inputBuilder.Attributes.Add("id", id);
            inputBuilder.Attributes.Add("name", name);

            inputBuilder.Attributes.Add("value", "true");

            return inputBuilder;
        }
    }
}
