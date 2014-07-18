using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;
using System.Configuration;
using Hangfire;
using Hangfire.SqlServer;
using Hangfire.Dashboard;
using AS = ArmedCards.BusinessLogic.AppServices;
using Microsoft.Practices.Unity;

[assembly: OwinStartup(typeof(ArmedCards.Web.Startup))]
namespace ArmedCards.Web
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.MapSignalR();

            app.UseHangfire(config =>
            {
                config.UseAuthorizationFilters(new AuthorizationFilter
                {
                    Roles = "Admin"
                });

                config.UseActivator(new Extensions.UnityJobActivator(BusinessLogic.UnityConfig.Container));

                config.UseSqlServerStorage(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);

                config.UseServer();
            });

            AS.ChatMessage.Base.IDelete _deleteChatMessages = BusinessLogic.UnityConfig.Container.Resolve<AS.ChatMessage.Base.IDelete>();

            RecurringJob.AddOrUpdate("DeleteChatMessages", () => _deleteChatMessages.Execute(), Cron.Hourly());
        }
    }
}
