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

using System.Web;
using System.Web.Optimization;

namespace ArmedCards.Web
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js",
                        "~/Scripts/Core/jQueryTopic.js",
                        "~/Scripts/Core/Utilities.js",
                        "~/Scripts/jquery.signalR-1.1.3.js"));

            bundles.Add(new StyleBundle("~/bundles/Styles").Include(
                "~/Content/Home.css",
                "~/Content/toastr.css"));

            bundles.Add(new ScriptBundle("~/bundles/toastr").Include(
                        "~/Scripts/toastr.js"));

            bundles.Add(new ScriptBundle("~/bundles/Core/Login").Include(
                        "~/Scripts/Core/Login/LoginPartial.js",
                        "~/Scripts/Core/Login/LoginModal.js"));

            bundles.Add(new ScriptBundle("~/bundles/Game/CreateGame").Include(
                        "~/Scripts/Game/CreateGame.js"));

            bundles.Add(new ScriptBundle("~/bundles/Game/Listing").Include(
                        "~/Scripts/Game/Listing/Listing.js",
                        "~/Scripts/Game/Listing/Detail.js"));

			bundles.Add(new ScriptBundle("~/bundles/Game/Board").Include(
						"~/Scripts/Game/Board/Waiting.js",
						"~/Scripts/Game/Board/Sidebar.js",
						"~/Scripts/Game/Board/State.js",
						"~/Scripts/Game/Board/Common.js",
						"~/Scripts/Game/Board/Hand.js",
						"~/Scripts/Game/Board/Commander.js"));

            bundles.Add(new ScriptBundle("~/bundles/Core/Hub").Include(
                        "~/Scripts/jquery.signalR-1.1.3.js",
                        "~/Scripts/Core/Hub.js",
                         "~/Scripts/Core/Chat.js"));

			bundles.Add(new ScriptBundle("~/bundles/Core/Profile").Include(
						"~/Scripts/Core/Profile/Profile.js"));

			bundles.Add(new ScriptBundle("~/bundles/GreenSock")
				   .IncludeDirectory("~/Scripts/GreenSock", "*.js", true));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));
        }
    }
}