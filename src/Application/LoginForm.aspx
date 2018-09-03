<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="Application.LoginForm" Theme="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title><asp:Localize runat="server" meta:resourcekey="Title" /></title>
    <script type="text/javascript">
        function switchLoadingIndicatorVisibility() {
            var loader = document.getElementById("loader");
            var error = document.getElementById("ErrorInfo");
            if (loader.style.display == "none") {
                loader.style.display = "block";
                error.style.display = "none";
            }
            else {
                loader.style.display = "none";
                error.style.display = "block";
            }
        }
    </script>
</head>
<body>
    <noscript><meta http-equiv="REFRESH" content="0;URL='noscript.aspx'"></noscript>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true"></asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" class="login-background" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div align="center" style="margin-top:5%;margin-left:auto; margin-right:auto;height:10px;">
            <asp:Label ID="ErrorInfo" style="font-family:Tahoma" Font-Size="12px" runat="server" Font-Bold="true" ForeColor="#1100FF"><asp:Localize ID="Localize5" runat="server" /></asp:Label>
            <div id="loader" style="display:none;">
                <img width="16" height="16" src="img/ajax-loader.gif" alt="ajax-loader"></img><asp:Localize ID="Localize7" runat="server" meta:resourceKey="Busy" />
            </div>
        </div>
        <div align="center">
            <div id="splash">
	            <div id="splash_bg">
	                <div id="splash_title"><asp:Localize ID="Localize1" runat="server" meta:resourcekey="Title" /></div>
                </div>
                <asp:Panel ID="Panel1" runat="server" class="login-form">
                        <div align="center" style="margin-top:26px;">
                            <table>
                            <tr>
                            <td colspan="2"><asp:Label CssClass="login-label" ID="Label12" runat="server">
                                <asp:Localize ID="Localize2" runat="server" meta:resourcekey="Username" />
                            </asp:Label></td>
                            <td></td>
                            </tr>
                            <tr>
                            <td colspan="2"><asp:TextBox CssClass="text-input" ID="UsernameTextBox" runat="server" /></td>
                            <td></td>
                            </tr>
                            <tr>
                            <td colspan="2"><asp:Label CssClass="login-label" ID="Label2" runat="server" >
                                 <asp:Localize ID="Localize3" runat="server" meta:resourcekey="Password" />
                            </asp:Label></td>
                            <td></td>
                            </tr>
                            <tr>
                            <td colspan="2"><asp:TextBox CssClass="text-input" ID="PasswordTextBox" TextMode="Password" runat="server" /></td>
                            <td></td>
                            </tr>
                            <tr>
                            <td><asp:CheckBox runat="server" ID="RememberCheckbox" /><asp:Label ID="Label1" runat="server"  CssClass="remember-label"><asp:Localize ID="Localize4" runat="server" meta:resourcekey="RememberMe" /></asp:Label></td>
                            <td><asp:Button CssClass="input-button" ID="Login" runat="server" meta:resourcekey="Login" OnClick="Login_Click" /></td>
                            </tr>
                            </table>
                        </div>
                    </asp:Panel>
	            </div>
            </div>
        </div>
    </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
