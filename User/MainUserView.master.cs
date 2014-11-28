using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

public partial class User_MainUserView : System.Web.UI.MasterPage
{
    protected void Page_Load( object sender, EventArgs e )
    {
        if ( Session["Perfil"] != "User" ) {
            Response.Redirect( "~/ErrorPage.aspx", true);
        }
    }

    protected void LogOutButtonClicked( object sender, EventArgs e )
    {
        FormsAuthentication.SignOut();
        Session.Clear();
        Response.Redirect( "~/Login.aspx" );
    }
}
