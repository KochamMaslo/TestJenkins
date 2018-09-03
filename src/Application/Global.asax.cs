using System;
using System.Linq;
using System.Globalization;
using System.Threading;
using System.Web;
using Intergraph.Portal.Core.ApplicationBase.ServiceHost;
using Intergraph.WebSolutions.Core.WebClient.Controls.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Platform;
using log4net;

namespace Application
{
    public class Global : ServiceStackWindsorGlobalApplicationBase
    {
        private static readonly ILog logger = LogManager.GetLogger(typeof (Global));

        private static readonly string[] KnownDevices = new[] {"android", "iphone", "ipad"};
        private static readonly string[] HeavyLayouts = new[] {"/full.aspx", "/apollo.aspx", "/apollopro.aspx", "/gwmpub.aspx", "/gwmpubpro.aspx", "/mapwithribbon.aspx", "/mapwithtoolbar.aspx"};
        private static readonly string[] ToSkip = new []{"webclient.ashx","scriptresource.axd", "webresource.axd"};
        private const string LiteLayout = "~/Mobile.aspx";

        protected override void Application_Start(object sender, EventArgs e)
        {
            logger.Info("Starting application...");
            base.Application_Start(sender, e);
            ExtCssThemeHelper.SetTheme();
        }

        protected override void Application_BeginRequest(Object sender, EventArgs e)
        {
            UpdateCulture();
            UpdateLayout();

            base.Application_BeginRequest(sender, e);
        }

        private void UpdateLayout()
        {
            var originalPath = HttpContext.Current.Request.Path.ToLower();
            if (ToSkip.Any(originalPath.Contains))
                return;

            var strUserAgent = (Request.UserAgent ?? "").ToLower();
            var queryString = HttpContext.Current.Request.QueryString;

            var isMobile = HttpContext.Current.Request.Browser.IsMobileDevice || KnownDevices.Any(strUserAgent.Contains);
            if (HeavyLayouts.Any(originalPath.Contains) && isMobile)
            {
                var redirectTo = LiteLayout;
                if (queryString.Count > 0)
                    redirectTo += "?" + queryString;
                Response.Redirect(redirectTo);
            }
        }

        private void UpdateCulture()
        {
            try
            {
                string lngCode = null;
                if (Request.Cookies["lngCode"] != null)
                    lngCode = Server.HtmlEncode(Request.Cookies["lngCode"].Value);
                if (string.IsNullOrEmpty(lngCode))
                {
                    var languages = HttpContext.Current.Request.UserLanguages;
                    if (languages != null && languages.Length > 0)
                        lngCode = languages[0];
                    else
                        return;
                }

                if (lngCode == "zh-CHS") { lngCode = "zh-CN"; }
                if (lngCode == "zh-CHT") { lngCode = "zh-HK"; }

                logger.DebugFormat("language code: {0} \"{1}\"",Request.Url, lngCode);

                CultureInfo culture = CultureInfo.CreateSpecificCulture(lngCode);
                Thread.CurrentThread.CurrentCulture = culture;
                Thread.CurrentThread.CurrentUICulture = culture;
            }
            catch (ArgumentException)
            {
            }
        }
    }
}
