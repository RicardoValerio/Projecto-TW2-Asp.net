using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace WebSiteTutorial
{
    public static class RouteConfig
    {
        public static void RegisterRoutes( RouteCollection routes )
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls( settings );

            // route para quando for chamado apenas o domínio da aplicação,
            // ser automaticamente associado o ficheiro Login.aspx como default
            routes.MapPageRoute(
                                   "Login",
                                   string.Empty,
                                   "~/Login.aspx"
                               );
        }
    }
}