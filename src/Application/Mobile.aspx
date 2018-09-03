<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Mobile.aspx.cs" Inherits="Application.Mobile" GoogleMapsApi="true" MobileExtension="true" Theme="Mobile" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html id="Html1" xmlns="http://www.w3.org/1999/xhtml" runat="server">
<head id="Head1" runat="server">
    <title><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</head>
<body id="simple">
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
        <Scripts>
            <asp:ScriptReference Assembly="Intergraph.WebSolutions.Core.WebClient.Controls" Name="Intergraph.WebSolutions.Core.WebClient.Controls.ScriptResources.ScriptTranslate.js" /> 
            <asp:ScriptReference Path="js/MapConfig.js" />
            <asp:ScriptReference Path="js/Mobile.js" />
            <asp:ScriptReference Assembly="Application" Name="Application.ScriptResources.ScriptTranslate.js" />
            <asp:ScriptReference Path="js/API.min.js" />
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
    <wc_core:MapControlContainer ID="MainMapControlContainer" runat="server" MapStateId="map" DisableNavigator="true" DisableCoords="true"/>
    <wc_core:MapStateSwitcherLightControl ID="MainMapStateSwitcher" runat="server" MapStateId="map" Mode="ComboBox"/>
    <wc_core:FeatureInfoLightControl ID="FeatureInfoLightControl1" runat="server" MapStateId="map" FullPage="true"/>
    <div id="tools"></div>
    </form>
</body>
</html>
