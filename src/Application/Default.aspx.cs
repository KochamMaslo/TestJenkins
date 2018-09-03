using System;
using System.Configuration;
using System.Web;
using System.Web.Configuration;
using System.Xml.Linq;
using Intergraph.WebSolutions.Core.Common.Adapters.System.IO;


namespace Application
{
    public partial class Default : System.Web.UI.Page
    {
        private readonly IFile _f = new FileProxy();

        protected override void OnLoad(EventArgs e)
        {
            var defaultDocument = "Full.aspx";

            try
            {
                var text = _f.ReadAllText(Server.MapPath("~/web.config"));
                var cfg = XDocument.Parse(text);

                defaultDocument = cfg
                    .Element("configuration")
                    .Element("system.webServer")
                    .Element("defaultDocument")
                    .Element("files")
                    .Element("add")
                    .Attribute("value").Value;
            }
            catch(NullReferenceException)
            {
            }

            var queryString = HttpContext.Current.Request.QueryString;
            
            if (queryString.Count > 0)
                defaultDocument += "?" + queryString;

            Response.Redirect(defaultDocument);
            base.OnLoad(e);
        }
    }
}