using System;
using System.Collections.Generic;
using System.Web.UI;
using AjaxControlToolkit;
using ExtJS.Controls;
using Intergraph.WebSolutions.Core.WebClient.Controls.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Controls.Map;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapServices;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapToolbar;
using Intergraph.WebSolutions.Core.WebClient.MapManager.MapContent;

namespace Application
{
    public partial class Map : MapPageBase, IConfigurableForm
    {


        protected override MapControlContainer MapControlContainer
        {
            get { return this.MainMapControlContainer; }
        }

        protected override IMapStateSwitcher MapStateSwitcher
        {
            get { return this.MainMapStateSwitcher; }
        }

        protected override string MainMapStateId
        {
            get { return "map"; }
        }

        protected override IDictionary<string, IMapControlContainer> MapStateIds
        {
            get
            {
                return new Dictionary<string, IMapControlContainer>
                    {
                        {"map", this.MainMapControlContainer}
                    };
            }
        }

        protected override void OnLoadComplete(EventArgs e)
        {
            base.OnLoadComplete(e);
            var cfg = ApplicationConfigurationManager.CurrentOrDefault;
            if (cfg != null)
            {
                IConfigurableForm form = (IConfigurableForm)this;
                if (!cfg.LayoutConfigurations.ContainsKey(form.Path))
                {
                    cfg.LayoutConfigurations[form.Path] = new LayoutConfiguration();
                }
                cfg.Apply(this);
            }
        }

        Panel IConfigurableForm.Sidebar
        {
            get { return null; }
        }

        Panel IConfigurableForm.MapContentPanel
        {
            get { return null; }
        }

        MapToolbar IConfigurableForm.MapToolbar
        {
            get { return null; }
        }
            
        IEnumerable<ClientTool> IConfigurableForm.ClientTools
        {
            get
            {
                yield return new ClientTool("zoom_in", GetLocalResourceObject("ZoomIn").ToString());
                yield return new ClientTool("zoom_out", GetLocalResourceObject("ZoomOut").ToString());
                yield return new ClientTool("zoom_rect", GetLocalResourceObject("ZoomRect").ToString());
                yield return new ClientTool("fit_all", GetLocalResourceObject("FitAll").ToString());
                yield return new ClientTool("feature_info", GetLocalResourceObject("FeatureInfo").ToString());
                yield return new ClientTool("reset_north", GetLocalResourceObject("ResetNorth").ToString());
            }
        }

        IMapStateSwitcher IConfigurableForm.MapStateSwitcher
        {
            get { return this.MainMapStateSwitcher; }
        }

        AddNewMapServiceControl IConfigurableForm.NewMapServiceControl
        {
            get { return null; }
        }

        string IConfigurableForm.Path
        {
            get { return "Map.aspx"; }
        }
    }
}