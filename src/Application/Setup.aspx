<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Setup.aspx.cs" Inherits="Application.Setup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title></title>
</head>
<body>
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript>
    <form id="form1" runat="server">
    <asp:ScriptManager runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true" />
    <ext:Viewport runat="server">
        <LayoutConfig Type="Fit" />
        <Items>
            <wc_core:ApplicationConfigurationControl runat="server">
                <Forms>
                    <wc_core:FormReference Path="Full.aspx" />
                    <wc_core:FormReference Path="MapWithRibbon.aspx" />
                    <wc_core:FormReference Path="Map.aspx" />
                    <wc_core:FormReference Path="Mobile.aspx" />
                </Forms>
            </wc_core:ApplicationConfigurationControl>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
