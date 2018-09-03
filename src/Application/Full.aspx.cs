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
    public partial class Full : MapPageBase, IConfigurableForm
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
                        {"preview", this.PreviewMapWindow.PreviewMap}
                    };
            }
        }

        protected override IDictionary<string, object> GetClientMapInfoItems()
        {
            return new Dictionary<string, object>
                {
                    {"bannerId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.Banner.ExtComponentId))},
                    {"sidebarId", String.Format("\"{0}\"", ClientScriptTools.Escape(this.Sidebar.ExtComponentId))}
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
            if (cfg != null) {
                IConfigurableForm form = (IConfigurableForm) this;
                if (!cfg.LayoutConfigurations.ContainsKey(form.Path)) {
                    cfg.LayoutConfigurations[form.Path] = new LayoutConfiguration();
                }
                cfg.Apply(this);
            }
        }

        private void SetUpMapToolbar()
        {
            var t = this.MapToolbar;

            t.AddRange("Fancy0", MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false,
                MapToolbarButtonType.Switch3D, MapToolbarButtonType.ZoomIn, MapToolbarButtonType.ZoomOut, MapToolbarButtonType.ZoomRect, MapToolbarButtonType.FitAll, MapToolbarButtonType.ResetNorth));

            t.Add("Fancy0", new ToolbarMapZoomHistoryControl { MapStateId = this.MainMapStateId });
            t.AddRange(MapToolbarCategory.Tools, MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false,
                MapToolbarButtonType.FeatureInfo));

            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.ScaleBandWindow, ShowWindowToolbarButtonType.ScaleBandsConfiguration));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.PreviewMapWindow, ShowWindowToolbarButtonType.PreviewWindow));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.UserMapsWindow, ShowWindowToolbarButtonType.MapStorage));
            t.Add(MapToolbarCategory.Tools, new PrintingButton { Window = this.PrintingWindow });
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.DataWindow, ShowWindowToolbarButtonType.DataWindow));
            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.Geolocation, MapToolbarButtonType.DirectLink));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.DynamicObjectViewWindow, ShowWindowToolbarButtonType.DynamicObjectView));
            t.Add(new ShowWindowToolbarButton() { Window = this.WMCActionWindow, ToolTip = GetLocalResourceObject("WMC.ToolTip").ToString(), IconClassName = "wc_map_tb_wmc mwnt-wmc-action-button", MapToolbarCategoryId = MapToolbarCategory.Tools });
            t.Add(new ShowWindowToolbarButton() { Window = this.AboutWindow, ToolTip = GetLocalResourceObject("About.ToolTip").ToString(), IconClassName = "wc_map_tb_abo mwnt-about-window-button", MapToolbarCategoryId = MapToolbarCategory.Tools });
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NotificationHistoryWindow, ShowWindowToolbarButtonType.MessageLog));

            t.Add(MapToolbarCategory.Tools, new Separator());
            t.Add(new ToolbarMapScaleControl { MapStateId = this.MainMapStateId });

            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false,
                MapToolbarButtonType.MeasurePoint, MapToolbarButtonType.MeasureDistance, MapToolbarButtonType.MeasureArea, MapToolbarButtonType.MeasureClear, MapToolbarButtonType.MeasureShowHide));

            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.DataSourcesWindow, ShowWindowToolbarButtonType.ViewMapServices));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.NewDataSourceWindow, ShowWindowToolbarButtonType.AddMapService));
            t.Add(MapToolbarCategory.Services, new Separator());
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.LegendWindow, ShowWindowToolbarButtonType.AddLegends));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.CategoryWindow, ShowWindowToolbarButtonType.AddFeatureClasses));
            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.ClearMap));

            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.SelectByPoint, MapToolbarButtonType.SelectByLine, MapToolbarButtonType.SelectByArea, MapToolbarButtonType.SelectByBbox));
            t.Add(MapToolbarCategory.Selection, new Separator());
            t.AddRange(SelectedFeaturesButton.GetSelectedFeaturesButtons(SelectedFeaturesAction.AddToClipboard, SelectedFeaturesAction.Clear));
            
            t.Add(new LiveSearchControl
            {
                MapStateId = this.MainMapStateId,
                HasSearchMenu = WebClientPlatformConfiguration.Instance.Search.LiveSearch.HasSearchMenu,
                EntryPointCode = WebClientPlatformConfiguration.Instance.Search.LiveSearch.EntryPointCode,
                ZoomScaleDenominator = WebClientPlatformConfiguration.Instance.Search.LiveSearch.ZoomScaleDenominator
            });

            t.MapToolbarCategories.Add(TimeDimensionControl.ToolbarCategory, new MapToolbarCategory(TimeDimensionControl.ToolbarCategory, GetLocalResourceObject("Time.TimeTabTitle").ToString()));
            t.Add(TimeDimensionControl.ToolbarCategory, new TimeDimensionControl
            {
                MapStateId = this.MainMapStateId
            });

            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.RedliningWindow, ShowWindowToolbarButtonType.InsertFeature));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.InsertTextWindow, ShowWindowToolbarButtonType.InsertText));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.SnapWindow, ShowWindowToolbarButtonType.Snap));
            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.EditGeometry));
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.ContinueGeometryWindow, ShowWindowToolbarButtonType.ContinueGeometry));
            t.AddRange(MapToolbarButton.GetMapToolbarButtons(this.MainMapStateId, false, MapToolbarButtonType.MoveGeometry, MapToolbarButtonType.RemoveGeometryPart, MapToolbarButtonType.RemoveSelectedFeatures));
            t.Add(MapToolbarCategory.Edit, new Separator());
            t.Add(ShowWindowToolbarButton.GetShowWindowToolbarButton(this.InsertMarkerAnnotationWindow, ShowWindowToolbarButtonType.InsertMarkerAnnotation));
            t.Add(new MembershipControl());

            t.MapToolbarCategories.Add(QualityMonitorButton.CategoryId, new MapToolbarCategory(QualityMonitorButton.CategoryId, GetLocalResourceObject("QM.TabTitle").ToString()));
            t.Add(new ShowWindowToolbarButton() { Window = this.QualityMonitorWindow, ButtonType = ShowWindowToolbarButtonType.QualityMonitorWindow, ToolTip = GetLocalResourceObject("QM.ShowDataWindowTooltip").ToString(), IconClassName = "qm_show_btn wmnt-quality-monitor-show-btn", MapToolbarCategoryId = QualityMonitorButton.CategoryId });


            t.Add(new QualityMonitorButton { AllowDepress = true, ToolTip = GetLocalResourceObject("QM.ShowMapLayerTooltip").ToString(), IconClassName = "qm_show_map_btn wmnt-quality-monitor-btn", MapToolbarCategoryId = QualityMonitorButton.CategoryId, EnableToggle = true, ToggleHandler = "handler", Hidden = true });
            t.Add(new ShowWindowToolbarButton() { Window = this.QualityMonitorAdminWindow, ButtonType = ShowWindowToolbarButtonType.QualityMonitorAdminWindow, ToolTip = GetLocalResourceObject("QM.ShowAdminWindowTooltip").ToString(), IconClassName = "qm_show_admin_btn wmnt-quality-monitor-show-admin-btn", MapToolbarCategoryId = QualityMonitorButton.CategoryId, Hidden = true });

            t.Add(MapToolbarCategory.Tools, new LanguageSelector());
            AddWorkflowManagerToMapToolbar(this.MapToolbar, this.MainMapStateId);
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
            get { return "Full.aspx"; }
        }
    }
}
