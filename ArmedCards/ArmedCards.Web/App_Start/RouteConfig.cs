using System;
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

            routes.MapRoute(
                name: "Game_NoAction",
                url: "Game/{id}",
                defaults: new { controller = "Game", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "GameList_NoAction",
                url: "GameListing/{id}",
                defaults: new { controller = "GameListing", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}