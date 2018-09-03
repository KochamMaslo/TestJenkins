<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Map.aspx.cs" Inherits="Application.Map" GoogleMapsApi="true" MobileExtension="true" Theme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head runat="server">
    <title><asp:Localize runat="server" meta:resourcekey="Title" /></title>
</head>
<body id="simple">
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
        <Scripts>
            <asp:ScriptReference Assembly="Intergraph.WebSolutions.Core.WebClient.Controls" Name="Intergraph.WebSolutions.Core.WebClient.Controls.ScriptResources.ScriptTranslate.js" /> 
            <asp:ScriptReference Path="js/MapConfig.js" />
            <asp:ScriptReference Path="js/Tools.js" />
            <asp:ScriptReference Assembly="Application" Name="Application.ScriptResources.ScriptTranslate.js" />
            <asp:ScriptReference Path="js/API.min.js" />
            <asp:ScriptReference Path="js/StyleConfig.js" />
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
    <wc_core:MapControlContainer ID="MainMapControlContainer" runat="server" NavigatorVerticalSwap="true" MapStateId="map"/>
    <wc_core:MapStateSwitcherLightControl ID="MainMapStateSwitcher" runat="server" MapStateId="map" CssClass="buttons" ButtonMinWidth="100"/>
    <wc_core:ImmediateNotificationControl ID="ImmediateNotification" runat="server" Timeout="10000"/>
    <wc_core:FeatureInfoLightControl runat="server" MapStateId="map" />
    <div id="tools"></div>
    </form>
</body>
</html>
