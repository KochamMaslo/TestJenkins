<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoScript.aspx.cs" Inherits="Application.NoScript" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><asp:Localize ID="Localize5" runat="server" meta:resourcekey="Title" /></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </asp:ScriptManager>
    <div id="nojs" style="position: absolute;left: 50%;top: 50%;margin-left: -246px;margin-top: -160px;"><asp:Localize ID="Localize4" runat="server" meta:resourcekey="NoJavascript" /></div>
    </form>
</body>
</html>
