using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ServiceModel;
using Intergraph.WebSolutions.Core.WebClient.Controls.Map;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapServices;
using Intergraph.WebSolutions.Core.WebClient.Controls.MapToolbar;
using Microsoft.IdentityModel.Protocols.WSTrust;
using System.ServiceModel.Security;
using Microsoft.IdentityModel.SecurityTokenService;
using System.IdentityModel.Tokens;
using System.ComponentModel;
using System.Web.Caching;
using Microsoft.IdentityModel.Tokens;
using System.Web.Services.Description;
using Intergraph.WebSolutions.Core.WebClient.Platform.Configuration;
using Intergraph.WebSolutions.Core.WebClient.Platform.Security;
using Intergraph.WebSolutions.Core.WebClient.Controls.Configuration;
using Panel = ExtJS.Controls.Panel;
using System.Web.Configuration;
using System.Web.Security;
using Intergraph.WebSolutions.Core.Common.STSServiceContracts;

namespace Application
{
    public partial class LoginForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Login.Attributes.Add("onclick","switchLoadingIndicatorVisibility()");
        }


        /// <summary>
        /// Action after clicking login button.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Login_Click(object sender, EventArgs e)
        {
            this.ErrorInfo.Text = String.Empty;
            bool persistent = false;
            // Authorization using portal's membership provider when STS authentication is inactive.
            AuthorizationSection section = (AuthorizationSection)WebConfigurationManager.GetSection("system.web/authorization");
            foreach (System.Web.Configuration.AuthorizationRule entry in section.Rules)
            {
                if (entry.Action == System.Web.Configuration.AuthorizationRuleAction.Allow && entry.Users.Contains("*"))
                {
                    try
                    {
                        if (Membership.ValidateUser(UsernameTextBox.Text, PasswordTextBox.Text))
                        {

                            if (RememberCheckbox.Checked)
                                persistent = true;
                            System.Web.Security.FormsAuthentication.RedirectFromLoginPage(UsernameTextBox.Text, persistent);
                            return;
                        }
                    }
                    catch (Exception)
                    {
                        this.ErrorInfo.Text = GetLocalResourceObject("AuthenticationError.Text").ToString();
                        return;
                    }
                }
            }

            SecurityToken Token = null;
            try
            {
                Token = SecurityTokenStore.GetTokenFromUsername(UsernameTextBox.Text, PasswordTextBox.Text);
                if (Token != null)
                {
                    SecurityTokenStore.StoreToken(Token, UsernameTextBox.Text);
                    if (RememberCheckbox.Checked)
                        persistent = true;
                    System.Web.Security.FormsAuthentication.RedirectFromLoginPage(UsernameTextBox.Text, persistent);
                }   
            }
            catch (Exception ex)
            {
                this.ErrorInfo.Text = GetLocalResourceObject("AuthenticationError.Text").ToString();
                if (ex.InnerException != null)
                {
                    switch (ex.InnerException.Message)
                    {
                        case STSConstants.InvalidUsernameOrPassword:
                            this.ErrorInfo.Text = GetLocalResourceObject("IncorrectCredentials.Text").ToString();
                            break;
                        case STSConstants.PasswordExpired:
                            this.ErrorInfo.Text = GetLocalResourceObject("AuthorizationError.Text").ToString();
                            break;
                        case STSConstants.AccountSuspended:
                            this.ErrorInfo.Text = GetLocalResourceObject("AccountSuspended.Text").ToString();
                            break;
                        case STSConstants.ID3242:
                            this.ErrorInfo.Text = GetLocalResourceObject("IncorrectCredentials.Text").ToString();
                            break;
                        default :
                            this.ErrorInfo.Text = GetLocalResourceObject("AuthenticationError.Text").ToString();
                            break;
                    }
                }
            }
        }

    }
}
