<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="AdminEssentials.aspx.cs" Inherits="Application.AdminEssentials"
    GoogleMapsApi="true" VirtualEarthApi="true" Theme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></title>
</head>
<body>
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript> 
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
        <Scripts>
            <asp:ScriptReference Path="js/MapConfig.js" />
            <asp:ScriptReference Path="js/LayoutHelper.js" />
            <asp:ScriptReference Path="js/AdminEssentialsHelper.js" />
            <asp:ScriptReference Path="js/Scrollbar.js" />
        </Scripts>
    </asp:ScriptManager>
    <wc_core:LoadingIndicator ID="LoadingIndicator1" runat="server">
        <Content>
            <div id="splash">
                 <div id="splash_bg">
	                <div id="splash_title"><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></div>
                </div>
                <div id="splash_wait">
                    <asp:Localize ID="Localize2" runat="server" meta:resourceKey="SplashText" /></div>
                <img width="16" height="16" src="img/ajax-loader.gif" alt="ajax-loader"></img>
            </div>
        </Content>
    </wc_core:LoadingIndicator>
    <ext:Viewport ID="Viewport1" runat="server">
        <LayoutConfig Type="Border" />
        <Items>
            <ext:Panel ID="Panel1" runat="server" Region="Center">
                <LayoutConfig Type="Border" />
                    <Items>
                        <ext:Panel ID="MainPanel" runat="server" Region="Center">
                        <LayoutConfig Type="Border" />
                        <Items>
                            <ext:Panel ID="MapContainer" runat="server" Region="Center" SkinID="MapContainer">
                            <TopToolbar>
                                <wc_core:MapToolbar ID="MapToolbar" runat="server" />
                            </TopToolbar>
                            <Content>
                                <wc_core:MapControlContainer ID="MapControlContainer" runat="server" MapStateId="map" NavigatorVerticalSwap="true" SwapCoordinates="true" OverrideContextMenu="false" />
                                <wc_core:MapStateSwitcherControl ID="MapStateSwitcher" runat="server" MapStateId="map" />
                                <wc_core:ImmediateNotificationControl ID="ImmediateNotification" runat="server" Timeout="10000" />
                            </Content>
                        </ext:Panel>
                        </Items>
                        </ext:Panel>
                        <ext:Panel ID="Sidebar" runat="server" SkinID="AdminSidebar" Collapsible="true" Collapsed="false" Floatable="false">
                            <LayoutConfig Type="Anchor"/>
                            <Items>
                                <ext:Panel ID="SidePanel" runat="server" Anchor="100%, 70%" SkinID="SidebarClass" ActiveItemIndex="1">
                                    <LayoutConfig Type="Accordion" />
                                    <Items>
                                        <ext:Panel ID="MapCont" runat="server" meta:resourcekey="MapContent" Cls="mwnt-sidebar-mapcontent-panel mapcontent-admin">
                                            <LayoutConfig Type="Fit" />
                                            <Items>
                                                <ext:TabPanel ID="MapContent" runat="server" >
                                                    <Items>
                                                        <wc_core:MapLegendControl ID="MapContentLayers" runat="server" MapStateId="map"
                                                            Mode="Layers" meta:resourcekey="Layers" />
                                                        <wc_core:MapLegendControl ID="MapContentServices" Hidden="True"  runat="server" MapStateId="map"
                                                            Mode="Services" meta:resourcekey="DataSources" />
                                                        <wc_core:MapLegendControl ID="MapContentCategorized" Hidden="True" runat="server" MapStateId="map"
                                                            Mode="Categorized" meta:resourcekey="Categories" />
                                                    </Items>
                                                </ext:TabPanel>
                                            </Items>
                                        </ext:Panel>
                                        <wc_core:MapStorageControl ShowWindowControlButtons="true" EnableAdminMode="true" runat="server" ID="MapStoragePanel" MapStateId="map" meta:resourceKey="UserMapsWindow" />                                                              
                                    </Items>
                                </ext:Panel>
                                <ext:Panel ID="Panel6" runat="server" Anchor="100%, 30%">
                                    <LayoutConfig Type="Fit" />
                                    <Items>
                                        <wc_core:PreviewMapPanel ID="PreviewMapPanel" runat="server"
                                        MapStateId="preview" ControllingMapStateId="map" Mode="Dynamic" DynamicModeZoomFactor="3" ZoomWithinMapRange="true" meta:resourcekey="PreviewMapWindow" ConstrainHeader="true" Cls="mwnt-preview-map-window"/>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
        </Items>
    </ext:Viewport>
    <iframe id="sidebarShim"></iframe>
    <wc_core:FeatureInfoControl ID="FeatureInfoControl1" runat="server" MapStateId="map"
        DataViewPageSize="20" EditMode="true" ConstrainHeader="true" />
    <ext:Window ID="DataSourcesWindow" runat="server" meta:resourcekey="DataSourcesWindow" Cls="mwnt-data-sources-window"
        ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapServicesManagerControl ID="MapServicesManagerControl1" runat="server" />
        </Items>
    </ext:Window>
    <ext:Window ID="NewDataSourceWindow" SkinID="NewDataSourceWindow" runat="server"
        meta:resourcekey="NewDataSourceWindow" ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:AddNewMapServiceControl ID="AddNewMapServiceControl1" runat="server" MapStateId="map"                
                WindowId="ChooseLayersWindow" HideWindowEventName="newLegendItemAdded" EnableAdminMode="true" />
        </Items>
    </ext:Window>
    <ext:Window ID="LegendWindow" runat="server" meta:resourcekey="LegendWindow" ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:LegendControl ID="LegendControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>
    <ext:Window ID="CategoryWindow" runat="server" meta:resourcekey="CategoryWindow"
        ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:CategoryControl ID="CategoryControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>
    <ext:Window ID="NotificationHistoryWindow" SkinID="NotificationHistoryWindow" runat="server" meta:resourcekey="NotificationHistoryWindow" ConstrainHeader="true" Cls="mwnt-notifications-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:NotificationHistoryControl ID="NotificationHistoryControl" runat="server" />
        </Items>
    </ext:Window>
    <ext:Window ID="InstancesWindow" SkinID="InstancesWindow" runat="server" meta:resourcekey="InstancesWindow" ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:InstancesControl ID="InstancesControl" runat="server" />
        </Items>
    </ext:Window>
    <ext:Window ID="ChooseLayersWindow" runat="server" meta:resourcekey="ChooseLayersWindow"
        ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <ext:TabPanel ID="TabPanel2" runat="server">
                <Items>
                    <wc_core:LegendControl ID="Legend2Control" runat="server" MapStateId="map" meta:resourcekey="LegendWindow"
                        UseMapServiceFilter="true" />
                    <wc_core:CategoryControl ID="Category2Control" runat="server" MapStateId="map" meta:resourcekey="CategoryWindow"
                        UseMapServiceFilter="true" />
                </Items>
            </ext:TabPanel>
        </Items>
    </ext:Window>
    <ext:Window ID="ScaleBandWindow" runat="server" meta:resourcekey="ScaleBandWindow"
        ConstrainHeader="true" Cls="mwnt-scale-band-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:ScaleBandControl ID="ScaleBandControl1" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>
    <wc_core:WebBrowser ID="WebBrowser1" MapStateId="map" runat="server" meta:resourcekey="WebBrowser"
        ConstrainHeader="true" />
    <ext:Window ID="ScaleBandEditWindow" runat="server" SkinID="ScaleBandEditWindow"
        Resizable="false" Modal="true" ConstrainHeader="true" Cls="mwnt-scale-band-edit-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:ScaleBandEditControl ID="ScaleBandEditControl" runat="server" />
        </Items>
    </ext:Window>
    <ext:Window ID="AuthenticationWindow" SkinID="AuthenticationWindow" runat="server"
        Modal="true" ConstrainHeader="true" Cls="mwnt-auth-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:AuthenticationControl ID="AuthenticationControl" runat="server" />
        </Items>
    </ext:Window>
    <ext:Window ID="StyleWindow" runat="server" meta:resourcekey="StyleWindow" Modal="true"
        ConstrainHeader="true">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:StyleControl ID="StyleControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>
    <ext:Window ID="InsertFeatureWindowAttributes" SkinID="InsertFeatureWindowAttributes" runat="server" meta:resourcekey="InsertFeatureWindowAttributes" ConstrainHeader="true" Resizable="false">
        <LayoutConfig Type="Fit" />
    </ext:Window>
    <wc_core:FeatureClassDefinition ID="FeatureClassDefinition1" runat="server" MapStateId="test" />
    </form>
</body>
</html>
