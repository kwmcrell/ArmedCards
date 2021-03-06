﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace ArmedCards.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute("Robots.txt",
                "robots.txt",
                new { controller = "Home", action = "Robots" });

            routes.MapRoute(
                name: "Game_NoAction",
                url: "Game/{id}",
                defaults: new { controller = "Game", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "ValidatePassphrase_NoAction",
                url: "ValidatePassphrase/{id}",
                defaults: new { controller = "ValidatePassphrase", action = "Index", id = UrlParameter.Optional }
            );

			routes.MapRoute(
				name: "Profile_ChangeDisplayName",
				url: "Profile/ChangeDisplayName",
				defaults: new { controller = "Profile", action = "ChangeDisplayName" }
			);

			routes.MapRoute(
				name: "Profile_Id",
				url: "Profile/{id}",
				defaults: new { controller = "Profile", action = "Index", id = UrlParameter.Optional }
			);

            routes.MapRoute(
                name: "ChangeLog",
                url: "ChangeLog",
                defaults: new { controller = "Home", action = "ChangeLog", id = UrlParameter.Optional }
            );

	    routes.MapRoute(
                name: "HowToPlay",
                url: "HowToPlay",
                defaults: new { controller = "Home", action = "HowToPlay", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
