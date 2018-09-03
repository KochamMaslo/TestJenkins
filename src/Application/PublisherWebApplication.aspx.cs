using System;
using System.Web;

namespace Application
{
    public partial class PublisherWebApplication : System.Web.UI.Page
    {
        protected override void OnLoad(EventArgs e)
        {
            var defaultDocument = "GWMPub.aspx";
            var queryString = HttpContext.Current.Request.QueryString;
            if (queryString.Count > 0)
                defaultDocument += "?" + queryString;
            Response.Redirect(defaultDocument);
            base.OnLoad(e);
        }
    }
}