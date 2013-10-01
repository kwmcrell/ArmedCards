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

using Microsoft.Practices.EnterpriseLibrary.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using Microsoft.Practices.Unity;
using AS = ArmedCards.BusinessLogic.AppServices;
using ArmedCards.Web.Models;
using System.Data.Entity.Infrastructure;
using WebMatrix.WebData;
using System.Configuration;
using System.Web.Configuration;

namespace ArmedCards.Web
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
			DatabaseFactory.SetDatabaseProviderFactory(new DatabaseProviderFactory());

			Entities.MachineKey key;

			BusinessLogic.Repositories.ProviderInfo.Base.ISelect _select
				= new BusinessLogic.Repositories.ProviderInfo.Select();

			List<Entities.ProviderInfo> providers = _select.Execute(out key);

			HandleMachineKey(key);

            RouteTable.Routes.MapHubs();

            AreaRegistration.RegisterAllAreas();
            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth(providers);

            UnityConfig.InitContainer();
            ControllerBuilder.Current.SetControllerFactory(typeof(ArmedCards.Web.UnityControllerFactory));

			// Ensure ASP.NET Simple Membership is initialized only once per app start
			DatabaseInitialize();

            AS.ActiveConnection.Base.IDelete _deleteActiveConnection = UnityConfig.Container.Resolve<AS.ActiveConnection.Base.IDelete>();

            Entities.Filters.ActiveConnection.DeleteAll filter = new Entities.Filters.ActiveConnection.DeleteAll();
            _deleteActiveConnection.Execute(filter);
        }

		private static void HandleMachineKey(Entities.MachineKey key)
		{
			Configuration config = WebConfigurationManager.OpenWebConfiguration("~");

			MachineKeySection machineKey = config.GetSection("system.web/machineKey") as MachineKeySection;

			if (machineKey != null)
			{
				machineKey.ValidationKey = key.ValidationKey;
				machineKey.DecryptionKey = key.DecryptionKey;
				machineKey.Validation = (MachineKeyValidation)key.Validation;
				machineKey.Decryption = key.Decryption;

				config.Save();
			}
		}

		private void DatabaseInitialize()
		{
			System.Data.Entity.Database.SetInitializer<UsersContext>(null);

			try
			{
				using (var context = new UsersContext())
				{
					if (!context.Database.Exists())
					{
						// Create the SimpleMembership database without Entity Framework migration schema
						((IObjectContextAdapter)context).ObjectContext.CreateDatabase();
					}
				}

				WebSecurity.InitializeDatabaseConnection("DefaultConnection", "UserProfile", "UserId", "UserName", autoCreateTables: true);
			}
			catch (Exception ex)
			{
				throw new InvalidOperationException("The ASP.NET Simple Membership database could not be initialized. For more information, please see http://go.microsoft.com/fwlink/?LinkId=256588", ex);
			}
		}
    }
}