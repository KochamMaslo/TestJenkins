<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="GWMPub.aspx.cs" Inherits="Application.GeomediaWebMapPublisherApplication" 
    GoogleMapsApi="true" VirtualEarthApi="true" Theme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
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
            <asp:ScriptReference Path="js/StyleConfig.js" />
            <asp:ScriptReference Path="js/Scrollbar.js" />
        </Scripts>
    </asp:ScriptManager>
    
    <wc_core:LoadingIndicator ID="LoadingIndicator1" runat="server">
        <Content>
            <div id="splash">
	             <div id="splash_bg">
	                <div id="splash_title"><asp:Localize ID="Localize2" runat="server" meta:resourcekey="Title" /></div>
                </div>
	            <div id="splash_wait"><asp:Localize ID="Localize3" runat="server" meta:resourceKey="SplashText" /></div>
	            <img width="16" height="16" src="img/ajax-loader.gif" alt="ajax-loader"></img>
            </div>
        </Content>
    </wc_core:LoadingIndicator>
    
    <ext:ViewPort ID="ViewPort1" runat="server">
        <LayoutConfig Type="Border" />
        <Items>
            <ext:Panel ID="Banner" runat="server" Region="North" SkinID="Banner">
                <Content>
                    <h1><asp:Localize ID="Localize5" runat="server" meta:resourcekey="Title" /></h1>
                    <div id="powered_by"></div>
                    <div id="part_of"><span>Hexagon</span></div>
                </Content>
            </ext:Panel> 
            <ext:Panel ID="Panel1" runat="server" Region="Center">
                <LayoutConfig Type="Fit" />
                <Items>
                    <ext:Panel ID="Panel2" runat="server">
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
                            <%-- DataPanel docked into the layout. Please mind that SimpleQueryControl instantiated within SimpleQueryWindow defined below will use the full ID combined from ViewPort1_Panel1_Panel2_DataPanel --%>
                            <wc_core:DataPanel ID="DataPanel" runat="server" PageSize="20" ClipboardPageSize="10" meta:resourcekey="DataWindow" MapStateId="map" Height="250" Region="South" Collapsible="true" Floatable="false" CategoryControlWidth="250" SkinID="DocDataWindow" Collapsed="true"/>
                            <ext:Panel ID="Sidebar" runat="server" SkinID="PwaSidebar">
                                <LayoutConfig Type="Anchor"/>
                                <Items>
                                    <ext:Panel ID="InnerSidebar" runat="server" Anchor="100%, 60%" SkinID="SidebarClass">
                                        <LayoutConfig Type="Accordion" />
                                        <Items>
                                            <ext:Panel ID="Panel3" runat="server" meta:resourcekey="MapContent">
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
                                    <ext:Panel ID="Panel6" runat="server" Anchor="100%, 40%">
                                        <LayoutConfig Type="Fit" />
                                        <Items>
                                            <wc_core:PreviewMapPanel ID="PreviewMapPanel" runat="server"
                                            MapStateId="preview" ControllingMapStateId="map" Mode="Dynamic" DynamicModeZoomFactor="1" ZoomWithinMapRange="true" meta:resourcekey="PreviewMapWindow" ConstrainHeader="true" Cls="mwnt-preview-map-window"/>
                                        </Items>
                                    </ext:Panel>
                                </Items>
                            </ext:Panel>
                        </Items>
                    </ext:Panel>
                </Items>
            </ext:Panel>
        </Items>
    </ext:ViewPort>

    <div id="banner_collapse"><div id="banner_collapse_tool"></div></div>
    <%--<wc_core:FeatureInfoControl runat="server" MapStateId="map" DataViewPageSize="20" EditMode="true" ConstrainHeader="true"/>   --%>
     
    <%-- DataPanel as floating window. To use it, comment out the docked DataPanel and change DataWindowId in SimpleQueryControl to "DataWindow" %> 
    <%-- <wc_core:DataWindow ID="DataWindow" runat="server" PageSize="20" ClipboardPageSize="10" meta:resourcekey="DataWindow" ConstrainHeader="true" MapStateId="map"/> --%>
    <ext:Window ID="SimpleQueryWindow" SkinID="SimpleQueryWindow" ConstrainHeader="true" meta:resourcekey="Queries" runat="server" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:SimpleQueryControl runat="server" ID="SimpleQueryPanel" Title="" MapStateId="map" DataWindowId="ViewPort1_Panel1_Panel2_DataPanel" DisplayMode="Show" StatusMode="CheckAll"/>
            <%-- <wc_core:SimpleQueryControl runat="server" ID="SimpleQueryControl1" Title="" MapStateId="map" DataWindowId="DataWindow" DisplayMode="Show" StatusMode="CheckAll"/> --%>
        </Items>
    </ext:Window>
    
    <ext:Window ID="StyleWindow" runat="server" meta:resourcekey="StyleWindow" Modal="true" ConstrainHeader="true" >
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:StyleControl id="StyleControl" runat="server" MapStateId="map" />
        </Items>
    </ext:Window>

    <ext:Window ID="DataSourcesWindow" runat="server" meta:resourcekey="DataSourcesWindow" ConstrainHeader="true" Cls="mwnt-data-sources-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapServicesManagerControl ID="MapServicesManagerControl1" runat="server" />
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
            <ext:TabPanel ID="TabPanel1" runat="server">
                <Items>
                    <wc_core:LegendControl ID="Legend2Control" runat="server" MapStateId="map" meta:resourcekey="LegendWindow" UseMapServiceFilter="true" />
                    <wc_core:CategoryControl ID="Category2Control" runat="server" MapStateId="map" meta:resourcekey="CategoryWindow" UseMapServiceFilter="true" />
                </Items>
            </ext:TabPanel>
        </Items>
    </ext:Window>
    
    <wc_core:WebBrowser ID="WebBrowser1" MapStateId="map" runat="server" meta:resourcekey="WebBrowser" ConstrainHeader="true" />
    
    <ext:Window ID="AboutWindow" runat="server" meta:resourcekey="About" ConstrainHeader="true" SkinID="AboutWindow" Cls="mwnt-about-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <sdi:AboutControl ID="AboutControl" runat="server" MapStateId="map" meta:resourcekey="AboutControl" />
        </Items>
    </ext:Window>

    <ext:Window ID="AuthenticationWindow" SkinID="AuthenticationWindow" runat="server" Modal="true" ConstrainHeader="true" Cls="mwnt-auth-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:AuthenticationControl ID="AuthenticationControl" runat="server" />
        </Items>
    </ext:Window>

    <ext:Window ID="NotificationHistoryWindow" SkinID="NotificationHistoryWindow" runat="server" meta:resourcekey="NotificationHistoryWindow" ConstrainHeader="true" Cls="mwnt-notifications-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:NotificationHistoryControl ID="NotificationHistoryControl" runat="server" />
        </Items>
    </ext:Window>
    
    <ext:Window ID="UserMapsWindow" runat="server" meta:resourcekey="UserMapsWindow" ConstrainHeader="true" SkinID="UserMapsWindow" Cls="mwnt-user-maps-window">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:MapStorageControl ID="MapStorageControl1" runat="server" MapStateId="map" EnableDownload="true" />
        </Items>
    </ext:Window>    

    
    <wc_core:PrintingWindow ID="PrintingWindow" runat="server" MapStateId="map" meta:resourcekey="PrintingWindow" ConstrainHeader="true" Cls="mwnt-printing-window"/>
    <wc_core:FeatureInfoControl ID="FeatureInfoControl1" runat="server" MapStateId="map" DataViewPageSize="20" EditMode="true" ConstrainHeader="true"/>  
    <wc_core:FeatureClassDefinition ID="FeatureClassDefinition1" runat="server" MapStateId="test" />
    
    </form>
</body>
</html>