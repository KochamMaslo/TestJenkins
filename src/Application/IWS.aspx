<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="IWS.aspx.cs" Inherits="Application.IWS" GoogleMapsApi="true" VirtualEarthApi="true"  Theme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head runat="server">
    <title><asp:Localize runat="server" meta:resourcekey="Title" /></title>
</head>
<body>
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
        <Scripts>
            <asp:ScriptReference Path="js/MapConfig.js" />
            <asp:ScriptReference Path="js/LayoutHelper.js" />
            <asp:ScriptReference Path="js/API.min.js" />
            <asp:ScriptReference Path="js/StyleConfig.js" />
            <asp:ScriptReference Path="js/Scrollbar.js" />
        </Scripts>
    </asp:ScriptManager>
    
    <wc_core:LoadingIndicator runat="server">
        <Content>
            <div id="splash">
	             <div id="splash_bg">
	                <div id="splash_title"><asp:Localize ID="Localize2" runat="server" meta:resourcekey="Title" /></div>
                </div>
	            <div id="splash_wait"><asp:Localize runat="server" meta:resourceKey="SplashText" /></div>
	            <img width="16" height="16" src="img/ajax-loader.gif" alt="ajax-loader"></img>
            </div>
        </Content>
    </wc_core:LoadingIndicator>
    
    <ext:ViewPort ID="ViewPort1" runat="server">
        <LayoutConfig Type="Border" />
        <Items>
            <ext:Panel ID="Banner" runat="server" Region="North" SkinID="Banner">
                <Content>
                    <h1><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></h1>
                    <div id="powered_by">Powered by <span>Intergraph</span></div>
                    <div id="part_of"><span>Hexagon</span></div>
                </Content>
            </ext:Panel> 
            <ext:Panel ID="Panel1" runat="server" Region="Center">
                <LayoutConfig Type="Border" />
                <Items>
                    <ext:Panel ID="MapContainer" runat="server" region="Center" SkinID="MapContainer">
                        <TopToolbar>
                            <wc_core:MapToolbar ID="MapToolbar" runat="server" />                                          
                        </TopToolbar>
                        <Content>
                            <wc_core:MapControlContainer ID="MapControlContainer" runat="server" MapStateId="map" NavigatorVerticalSwap="true" SwapCoordinates="true" OverrideContextMenu="false" />
                            <wc_core:MapStateSwitcherControl ID="MapStateSwitcher" runat="server" MapStateId="map" />
                            <wc_core:ImmediateNotificationControl ID="ImmediateNotification" runat="server" Timeout="10000" />
                        </Content>
                    </ext:Panel>
                    <ext:Panel ID="Sidebar" runat="server" SkinID="Sidebar">
                        <LayoutConfig Type="Accordion"/>
                        <Items>
                            <ext:Panel runat="server" meta:resourcekey="MapContent" ID="MapContentCont" Cls="mwnt-sidebar-mapcontent-panel">
                                <LayoutConfig Type="Fit" />
                                <Items>
                                    <ext:TabPanel ID="MapContent" runat="server">
                                        <Items>
                                            <wc_core:MapLegendControl ID="MapContentLayers" runat="server" MapStateId="map" Mode="Layers" meta:resourcekey="Layers" />
                                            <wc_core:MapLegendControl ID="MapContentServices" runat="server" MapStateId="map" Mode="Services" meta:resourcekey="DataSources" />
                                            <wc_core:MapLegendControl ID="MapContentCategorized" runat="server" MapStateId="map" Mode="Categorized" meta:resourcekey="Categories" />
                                        </Items>
                                    </ext:TabPanel>
                                </Items>
                            </ext:Panel>
                            <wc_core:View3DPanel MapStateId="map" ID="View3DPanel" runat="server" meta:resourcekey="View3D" >
                                <LayoutConfig Type="Anchor" />
                                <Items>
                                    <wc_core:DynamicShadowControl MapStateId="map" runat="server" ID="ShadowControl" />
                                    <wc_core:ObjectsAndFeaturesControl MapStateId="map" runat="server" ID="ObjectsAndFeaturesControl"/>
                                    <wc_core:View3DModePanel MapStateId="map" runat="server" ID="View3DModePanel"/>
                                </Items>
                            </wc_core:View3DPanel>
                            <wc_core:SettingsPanel ID="SettingsPanel" runat="server" MapStateId="map" meta:resourcekey="Settings" />
                        </Items>
                    </ext:Panel>
                </Items>                
            </ext:Panel>
        </Items>
    </ext:ViewPort>

    <div id="language_chooser"><wc_core:LanguageSelector runat="server" ID="LanguageSelector1"/></div>
    <div id="banner_collapse"><div id="banner_collapse_tool"></div></div>

    <wc_core:FeatureInfoControl runat="server" MapStateId="map" DataViewPageSize="20" EditMode="true" ConstrainHeader="true"/>    

    <ext:Window ID="DataSourcesWindow" runat="server" meta:resourcekey="DataSourcesWindow" ConstrainHeader="true" Cls="mwnt-data-sources-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapServicesManagerControl runat="server" />
        </Items>
    </ext:Window>    

    <ext:Window ID="NewDataSourceWindow" SkinID="NewDataSourceWindow" runat="server" meta:resourcekey="NewDataSourceWindow" ConstrainHeader="true" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:AddNewMapServiceControl ID="AddNewMapServiceControl1" runat="server" MapStateId="map" WindowId="ChooseLayersWindow" HideWindowEventName="newLegendItemAdded" />
        </Items>
    </ext:Window>

    <ext:Window ID="LegendWindow" runat="server" meta:resourcekey="LegendWindow" ConstrainHeader="true" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:LegendControl ID="LegendControl" runat="server" MapStateId="map"/>
        </Items>
    </ext:Window>

    <ext:Window ID="CategoryWindow" runat="server" meta:resourcekey="CategoryWindow" ConstrainHeader="true" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:CategoryControl ID="CategoryControl" runat="server" MapStateId="map"/>
        </Items>
    </ext:Window>

    <ext:Window ID="ChooseLayersWindow" runat="server" meta:resourcekey="ChooseLayersWindow" ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <ext:TabPanel runat="server">
                <Items>
                    <wc_core:LegendControl ID="Legend2Control" runat="server" MapStateId="map" meta:resourcekey="LegendWindow" UseMapServiceFilter="true" />
                    <wc_core:CategoryControl ID="Category2Control" runat="server" MapStateId="map" meta:resourcekey="CategoryWindow" UseMapServiceFilter="true" />
                </Items>
            </ext:TabPanel>
        </Items>
    </ext:Window>

    <ext:Window ID="NotificationHistoryWindow" SkinID="NotificationHistoryWindow" runat="server" meta:resourcekey="NotificationHistoryWindow" ConstrainHeader="true" Cls="mwnt-notifications-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:NotificationHistoryControl ID="NotificationHistoryControl" runat="server" />
        </Items>
    </ext:Window>

    <wc_core:PreviewMapWindow ID="PreviewMapWindow" runat="server" 
        MapStateId="preview" ControllingMapStateId="map" Mode="Dynamic" DynamicModeZoomFactor="1" meta:resourcekey="PreviewMapWindow" ConstrainHeader="true" Cls="mwnt-preview-map-window"/>

    <ext:Window ID="UserMapsWindow" runat="server" meta:resourcekey="UserMapsWindow" ConstrainHeader="true" SkinID="UserMapsWindow" Cls="mwnt-user-maps-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapStorageControl runat="server" MapStateId="map" EnableDownload="true" />
        </Items>
    </ext:Window>    

    <ext:Window ID="ScaleBandWindow" runat="server" meta:resourcekey="ScaleBandWindow" ConstrainHeader="true" Cls="mwnt-scale-band-window">
        <LayoutConfig Type="Fit" />
            <Items>
                <wc_core:ScaleBandControl runat="server" MapStateId="map" />
            </Items>
    </ext:Window>

    <wc_core:WebBrowser runat="server" MapStateId="map" meta:resourcekey="WebBrowser" ConstrainHeader="true" ID="WebBrowser1"/>
    
    <ext:Window ID="AboutWindow" runat="server" meta:resourcekey="About" ConstrainHeader="true" SkinID="AboutWindow" Cls="mwnt-about-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <sdi:AboutControl runat="server" MapStateId="map" meta:resourcekey="AboutControl" />
        </Items>
    </ext:Window>

    <ext:Window ID="ScaleBandEditWindow" runat="server" SkinID="ScaleBandEditWindow" Resizable="false" Modal="true" ConstrainHeader="true" Cls="mwnt-scale-band-edit-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:ScaleBandEditControl id="ScaleBandEditControl" runat="server" />
        </Items>
    </ext:Window>
    
    <ext:Window ID="AuthenticationWindow" SkinID="AuthenticationWindow" runat="server" Modal="true" ConstrainHeader="true" Cls="mwnt-auth-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:AuthenticationControl ID="AuthenticationControl" runat="server" />
        </Items>
    </ext:Window>
    
    <ext:Window ID="StyleWindow" runat="server" meta:resourcekey="StyleWindow" Modal="true" ConstrainHeader="true" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:StyleControl id="StyleControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>
    </form>
</body>
</html>
