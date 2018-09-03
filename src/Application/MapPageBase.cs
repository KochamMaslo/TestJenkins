using System;
using Intergraph.Portal.Core.Platform;
using Intergraph.WebSolutions.Core.WebClient.Application;
using Intergraph.WebSolutions.Core.WebClient.Controls.Map;
using Intergraph.WebSolutions.Core.WebClient.Platform;
using Intergraph.WebSolutions.Core.WebClient.Platform.ClientScript;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapToolbar;
using Intergraph.WebSolutions.Core.WebClient.Platform.Configuration;
using Intergraph.GeoMedia.Web.SDI.Common.Tools;

namespace Application
{
    public abstract class MapPageBase : MapPage
    {
        protected abstract MapControlContainer MapControlContainer { get; }
        protected abstract IMapStateSwitcher MapStateSwitcher { get; }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            if (!string.IsNullOrEmpty(this.Request["navigator"]))
                this.MapControlContainer.DisableNavigator = this.Request["navigator"] == "false";
            
            if (!string.IsNullOrEmpty(this.Request["coords"]))
                this.MapControlContainer.DisableCoords = this.Request["coords"] == "false";

            if (!string.IsNullOrEmpty(this.Request["crosshair"]))
                this.MapControlContainer.DisableCrosshair = this.Request["crosshair"] == "false";

            if (!string.IsNullOrEmpty(this.Request["scalebar"]))
                this.MapControlContainer.DisableScaleBar = this.Request["scalebar"] == "false";

            if (this.MapStateSwitcher != null && !string.IsNullOrEmpty(this.Request["switcher"]))
                this.MapStateSwitcher.Visible = this.Request["switcher"] != "false";

            ClientScriptTools.EnsureScriptPresent(this.Page, typeof(API));
        }

        protected void AddWorkflowManagerToMapToolbar(MapToolbar toolbar, string mapStateId)
        {
            if (WebClientPlatformConfiguration.Instance.UI.WorkflowManager.Enabled)
            {
                WebClientPlatformConfiguration.Instance.UI.WorkflowManager.Workflows.ForEach(k => toolbar.Add(new EventToolbarButton
                {
                    EventName = "showWebBrowser",
                    EventArgs = new
                    {
                        title = k.Name,
                        link = k.Target,
                        popup = true,
                        width = 500,
                        height = 600
                    }.ToJSON(),
                    Text = k.Name,
                    MapToolbarCategoryId = MapToolbarCategory.WorkflowManager,
                    MapStateId = mapStateId,
                    Hidden = false
                }));
            }
        }
    }
}