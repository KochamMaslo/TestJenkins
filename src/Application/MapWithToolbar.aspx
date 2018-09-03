<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapWithToolbar.aspx.cs" Inherits="Application.MapWithToolbar" GoogleMapsApi="true" VirtualEarthApi="true" Theme="Default" %>

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
            <asp:ScriptReference Path="js/API.min.js" />
            <asp:ScriptReference Path="js/StyleConfig.js" />
            <asp:ScriptReference Path="js/Scrollbar.js" />
        </Scripts>
    </asp:ScriptManager>
    <wc_core:LoadingIndicator runat="server">
        <Content>
            <div id="splash">
	             <div id="splash_bg">
	                <div id="splash_title"><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></div>
                </div>
	            <div id="splash_wait"><asp:Localize runat="server" meta:resourceKey="SplashText" /></div>
	            <img width="16" height="16" src="img/ajax-loader.gif" alt="ajax-loader"></img>
            </div>
        </Content>
    </wc_core:LoadingIndicator>
    <ext:Viewport runat="server">
        <LayoutConfig type="Fit" />
        <Items>
            <ext:Panel ID="MapContainer" SkinID="MapWithToolbarMapContainer" runat="server">
                <TopToolbar>
                    <wc_core:MapToolbar ID="MapToolbar" runat="server" />                                          
                </TopToolbar>
                <Content>
                    <wc_core:MapControlContainer ID="MapControlContainer" runat="server" MapStateId="map" NavigatorVerticalSwap="true" SwapCoordinates="true"/>
                    <wc_core:MapStateSwitcherControl ID="MapStateSwitcher" runat="server" MapStateId="map" />
                    <wc_core:ImmediateNotificationControl ID="ImmediateNotification" runat="server" Timeout="10000" />
                </Content>
            </ext:Panel>
        </Items>
    </ext:Viewport>
    <wc_core:FeatureInfoControl runat="server" MapStateId="map" DataViewPageSize="20"  />    
    <ext:Window ID="DataSourcesWindow" runat="server" meta:resourcekey="DataSourcesWindow" ConstrainHeader="true" Cls="mwnt-data-sources-window" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapServicesManagerControl runat="server" />
        </Items>
    </ext:Window>    
    <ext:Window ID="NewDataSourceWindow" runat="server" meta:resourcekey="NewDataSourceWindow" ConstrainHeader="true" >
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
    <wc_core:PreviewMapWindow ID="PreviewMapWindow" runat="server" 
        MapStateId="preview" ControllingMapStateId="map" Mode="Dynamic" DynamicModeZoomFactor="1" ZoomWithinMapRange="true" meta:resourcekey="PreviewMapWindow" ConstrainHeader="true" Cls="mwnt-preview-map-window"/>
    <ext:Window ID="UserMapsWindow" runat="server" meta:resourcekey="UserMapsWindow" ConstrainHeader="true" SkinID="UserMapsWindow" Cls="mwnt-user-maps-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapStorageControl runat="server" MapStateId="map" EnableDownload="false" />
        </Items>
    </ext:Window>
    <ext:Window ID="ScaleBandWindow" runat="server" meta:resourcekey="ScaleBandWindow" ConstrainHeader="true" Cls="mwnt-scale-band-window">
        <LayoutConfig Type="Fit" />
            <Items>
                <wc_core:ScaleBandControl ID="ScaleBandControl1" runat="server" MapStateId="map" />
            </Items>
    </ext:Window>
    <wc_core:WebBrowser runat="server" MapStateId="map" meta:resourcekey="WebBrowser" ConstrainHeader="true" ID="WebBrowser1"/>
    <ext:Window ID="WMCActionWindow" runat="server" Title="WMC" ConstrainHeader="true" Cls="mwnt-wmc-action-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wmc:WMCActionControl runat="server" MapStateId="map" ID="WMCActionControl" />
        </Items>
    </ext:Window>
    
    <ext:Window ID="AboutWindow" runat="server" meta:resourcekey="About" ConstrainHeader="true" SkinID="AboutWindow" Cls="mwnt-about-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <sdi:AboutControl runat="server" MapStateId="map" meta:resourcekey="AboutControl" />
        </Items>
    </ext:Window>

    <ext:Window ID="ScaleBandEditWindow" runat="server" SkinID="ScaleBandEditWindow" Resizable="false" Modal="true" Cls="mwnt-scale-band-edit-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:ScaleBandEditControl id="ScaleBandEditControl" runat="server" />
        </Items>
    </ext:Window>
    
    <ext:Window ID="StyleWindow" runat="server" meta:resourcekey="StyleWindow" Modal="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:StyleControl id="StyleControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>

    </form>
</body>
</html>
