using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load( object sender, EventArgs e )
    {

    }

    protected void SignIn( object sender, EventArgs e )
    {
        if ( TBinputEmail.Text == "A" && TBinputPassword.Text == "B" ) {
            // se o segundo parametro for verdadeiro é criado um cookie mas não é necessário
            FormsAuthentication.RedirectFromLoginPage( TBinputEmail.Text, true );
            //FormsAuthentication.SetAuthCookie( TBinputEmail.Text, false );
            // se for Admin redirecciona para
            //Response.Redirect( "~/Admin", true );
            // se for User:    Response.Redirect( "~/Admin", true );
        } else {
            Response.Write( "USER ou PASS erradas!" );
        }
    }
}
