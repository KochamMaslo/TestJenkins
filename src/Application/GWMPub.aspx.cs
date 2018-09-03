using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens;
using System.Web;
using System.Web.Configuration;
using ExtJS.Controls;
using Intergraph.Geomedia.Web.SDI.QualityMonitor.Client;
using Intergraph.Portal.Core.Platform;
using Intergraph.WebSolutions.Core.WebClient.Controls.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Controls.LanguageSelector;
using Intergraph.WebSolutions.Core.WebClient.Controls.Layout;
using Intergraph.WebSolutions.Core.WebClient.Controls.Map;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapServices;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapToolbar;
using Intergraph.WebSolutions.Core.WebClient.MapManager.MapContent;
using Intergraph.WebSolutions.Core.WebClient.MapManager.Security;
using Intergraph.WebSolutions.Core.WebClient.Platform.ClientScript;
using Intergraph.WebSolutions.Core.WebClient.Platform.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Printing.Controls;
using System.ComponentModel;
using System.Threading;
using Intergraph.WebSolutions.Core.WebClient.Platform.Security;
using System.Web.Security;

namespace Application
{
    public partial class GeomediaWebMapPublisherApplication : MapPageBase, IConfigurableForm
    {
        private MapControlContainer _mapControlContainer;
        private MapStateSwitcherControl _mapStateSwitcher;

        private MapControlContainer mapControlContainer
        {
            get
            {
                if (this._mapControlContainer == null)
                    this._mapControlContainer = (MapControlContainer)this.MapContainer.Controls[0].FindControl("MapControlContainer");
                return this._mapControlContainer;
            }
        }

        private MapStateSwitcherControl mapStateSwitcher
        {
            get
            {
                if (this._mapStateSwitcher == null)
                    this._mapStateSwitcher = (MapStateSwitcherControl)this.MapContainer.Controls[0].FindControl("MapStateSwitcher");
                return this._mapStateSwitcher;
            }
        }

        protected override MapControlContainer MapControlContainer
        {
            get { return this.mapControlContainer; }
        }

        protected override IMapStateSwitcher MapStateSwitcher
        {
            get { return this.mapStateSwitcher; }
        }

        protected override string MainMapStateId
        {
            get { return "map"; }
        }

        protected override string PreviewMapStateId
        {
            get { return "preview"; }
        }

        protected override IDictionary<string, IMapControlContainer> MapStateIds
        {
            get
            {
                return new Dictionary<string, IMapControlContainer>
                    {
                        {"map", this.mapControlContainer},
                        {"preview", this.PreviewMapPanel.PreviewMap}
                    };
            }
        }

        protected override IDictionary<string, object> GetClientMapInfoItems()
        {
            return new Dictionary<string, object>
                {
                    {"bannerId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.Banner.ExtComponentId))},
                    {"sidebarId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.Sidebar.ExtComponentId))},
                    {"dataPanelId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.DataPanel.ExtComponentId))}
                };
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            this.SetUpMapToolbar();
            this.SetUpButtons();
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

        private void SetUpMapToolbar()
        {
            //var t = this.MapContainer.TopToolbar;
            var t = this.MapToolbar;

            const string categoryId = "Default0";
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.Switch3D));
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ZoomIn));
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ZoomOut));
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ZoomRect));
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.FitAll));
            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ResetNorth));
            t.Add("Fancy0", new ToolbarMapZoomHistoryControl { MapStateId = this.MainMapStateId });

            t.Add(categoryId, new LiveSearchControl
            {
                MapStateId = this.MainMapStateId,
                HasSearchMenu = WebClientPlatformConfiguration.Instance.Search.LiveSearch.HasSearchMenu,
                EntryPointCode = WebClientPlatformConfiguration.Instance.Search.LiveSearch.EntryPointCode,
                ZoomScaleDenominator = WebClientPlatformConfiguration.Instance.Search.LiveSearch.ZoomScaleDenominator
            }
            );

            t.Add(categoryId, new Separator());
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.FeatureInfo));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.SimpleQueryWindow, ShowWindowToolbarButtonType.QueryWindow));

            t.Add(categoryId, new Separator());
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MeasurePoint));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MeasureDistance));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MeasureArea));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MeasureClear));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MeasureShowHide));

            t.Add(categoryId, new Separator());
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.SelectByPoint));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.SelectByLine));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.SelectByArea));
            t.AddRange(categoryId, SelectedFeaturesButton.GetSelectedFeaturesButtons(SelectedFeaturesAction.AddToClipboard));

            t.Add(categoryId, new Separator());
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.DataSourcesWindow, ShowWindowToolbarButtonType.ViewMapServices));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NewDataSourceWindow, ShowWindowToolbarButtonType.AddMapService));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.LegendWindow, ShowWindowToolbarButtonType.AddLegends));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.CategoryWindow, ShowWindowToolbarButtonType.AddFeatureClasses));

            t.Add(categoryId, new Separator());
            t.Add(categoryId, new PrintingButton { Window = this.PrintingWindow });
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.UserMapsWindow, ShowWindowToolbarButtonType.MapStorage));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NotificationHistoryWindow, ShowWindowToolbarButtonType.MessageLog));
            t.Add(categoryId, new ShowWindowToolbarButton() { Window = this.AboutWindow, ToolTip = GetLocalResourceObject("About.ToolTip").ToString(), IconClassName = "wc_map_tb_abo mwnt-about-window-button", MapToolbarCategoryId = MapToolbarCategory.Tools });

            t.Add(categoryId, new ToolbarMapScaleControl { MapStateId = this.MainMapStateId });
        }

        private void SetUpButtons()
        {
            this.LegendWindow.Buttons.Add(this.LegendControl.GetExecuteButton());
            this.CategoryWindow.Buttons.Add(this.CategoryControl.GetExecuteButton());
            this.Legend2Control.Buttons.Add(this.Legend2Control.GetExecuteButton());
            this.Category2Control.Buttons.Add(this.Category2Control.GetExecuteButton());
            //this.ScaleBandEditWindow.Buttons.Add(this.ScaleBandEditControl.GetApplyButton());
            //this.ScaleBandEditWindow.Buttons.Add(this.ScaleBandEditControl.GetCancelButton());
            this.AuthenticationWindow.Buttons.Add(this.AuthenticationControl.GetApplyButton());
            this.AuthenticationWindow.Buttons.Add(this.AuthenticationControl.GetCancelButton());
            this.StyleWindow.Buttons.Add(this.StyleControl.GetApplyButton());
            this.StyleWindow.Buttons.Add(this.StyleControl.GetCancelButton());
        }

        Panel IConfigurableForm.Sidebar
        {
            get { return this.Sidebar; }
        }

        Panel IConfigurableForm.MapContentPanel
        {
            get { return this.MapContent; }
        }

        MapToolbar IConfigurableForm.MapToolbar
        {
            get { return this.MapToolbar; }
        }

        IEnumerable<ClientTool> IConfigurableForm.ClientTools
        {
            get { return null; }
        }

        IMapStateSwitcher IConfigurableForm.MapStateSwitcher
        {
            get { return MapStateSwitcher; }
        }

        AddNewMapServiceControl IConfigurableForm.NewMapServiceControl
        {
            get { return this.AddNewMapServiceControl1; }
        }

        string IConfigurableForm.Path
        {
            get { return "GWMPub.aspx"; }
        }
    }
}