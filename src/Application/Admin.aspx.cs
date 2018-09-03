using System;
using System.Collections.Generic;
using System.Web;
using ExtJS.Controls;
using Intergraph.Portal.Core.MapManager.Licensing;
using Intergraph.Portal.Core.Platform;
using Intergraph.WebSolutions.Core.WebClient.Controls.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Controls.Layout;
using Intergraph.WebSolutions.Core.WebClient.Controls.Map;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapServices;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapToolbar;
using Intergraph.WebSolutions.Core.WebClient.MapManager.MapContent;
using LicenseManager = Intergraph.Portal.Core.MapManager.Licensing.LicenseManager;


namespace Application
{
    public partial class Admin : MapPageBase, IConfigurableForm
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
                        {"map", this.MapControlContainer},
                        {"preview", this.PreviewMapPanel.PreviewMap}
                    };
            }
        }

        protected override IDictionary<string, object> GetClientMapInfoItems()
        {
            return new Dictionary<string, object>
                {

                    {"sidebarId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.Sidebar.ExtComponentId))},
                    {"searchId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.TabPabelSearchResult.ExtComponentId))}
                };
        }

        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            this.SetUpMapToolbar();
            this.SetUpButtons();
        }

        protected override void OnPreInit(EventArgs e)
        {

            if (IsProperLicenseAvailable())
            {
                base.OnPreInit(e);
            }
            else
            {
                RedirectToAdminEssentialsLayout();
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
                    cfg.SetAppolloInitialMapContent(this);
                }
                cfg.Apply(this);
            }
        }

        private bool IsProperLicenseAvailable()
        {
            return LicenseManager.IsLicensingEnabled() && LicenseManager.IsLicenseValid(LicenseLevels.ANY_BUT_ESS);
        }

        private void RedirectToAdminEssentialsLayout()
        {
            var defaultDocument = "AdminEssentials.aspx";
            var queryString = HttpContext.Current.Request.QueryString;
            if (queryString.Count > 0)
                defaultDocument += "?" + queryString;
            Response.Redirect(defaultDocument);
        }

        private void SetUpMapToolbar()
        {
            var t = this.MapToolbar;
            const string categoryId = "Default0";

            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false,
                MapToolbarButtonType.Switch3D, MapToolbarButtonType.ZoomIn, MapToolbarButtonType.ZoomOut, MapToolbarButtonType.ZoomRect, MapToolbarButtonType.FitAll, MapToolbarButtonType.ResetNorth));
            t.Add("Fancy0", new ToolbarMapZoomHistoryControl { MapStateId = this.MainMapStateId });

            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.DataSourcesWindow, ShowWindowToolbarButtonType.ViewMapServices));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NewDataSourceWindow, ShowWindowToolbarButtonType.AddMapService));
            t.Add(categoryId, new Separator());
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.LegendWindow, ShowWindowToolbarButtonType.AddLegends));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.CategoryWindow, ShowWindowToolbarButtonType.AddFeatureClasses));
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ClearMap));
            t.Add(categoryId, new Separator());
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.ScaleBandWindow, ShowWindowToolbarButtonType.ScaleBandsConfiguration));
            t.Add(categoryId, ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NotificationHistoryWindow, ShowWindowToolbarButtonType.MessageLog));
            t.Add(categoryId, new ToolbarMapScaleControl { MapStateId = this.MainMapStateId });
            t.Add(categoryId, new CoordinateSystemSelectTool { MapStateId = this.MainMapStateId });
            t.AddRange(categoryId, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.CreateCloudApplication));
        
        }

        private void SetUpButtons()
        {
            this.LegendWindow.Buttons.Add(this.LegendControl.GetExecuteButton());
            this.CategoryWindow.Buttons.Add(this.CategoryControl.GetExecuteButton());
            this.Legend2Control.Buttons.Add(this.Legend2Control.GetExecuteButton());
            this.Category2Control.Buttons.Add(this.Category2Control.GetExecuteButton());
            this.ScaleBandEditWindow.Buttons.Add(this.ScaleBandEditControl.GetApplyButton());
            this.ScaleBandEditWindow.Buttons.Add(this.ScaleBandEditControl.GetCancelButton());
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
            get { return "Admin.aspx"; }
        }
    }
}
