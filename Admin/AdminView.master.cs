using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Admin_AdminView : MasterPage
{
    protected void Page_Load( object sender, EventArgs e )
    {
       
    }

    protected void LogOutButtonClicked( object sender, EventArgs e )
    {
        FormsAuthentication.SignOut();
        Response.Redirect( "Default.aspx" );
    }
}