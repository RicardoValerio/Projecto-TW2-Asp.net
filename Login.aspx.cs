using System;
using System.Configuration;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data.SqlClient;
using System.Security.Cryptography;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load( object sender, EventArgs e )
    {
        
    }

    protected void SignIn( object sender, EventArgs e )
    {
        if ( ValidateUserAdmin( TBinputEmail.Text, TBinputPassword.Text ) ) {
            Session["Perfil"] = "Admin";
            Response.Redirect( "~/Admin/", true );

        } else
            if ( ValidateUser( TBinputEmail.Text, TBinputPassword.Text ) ) {
                Session["Perfil"] = "User";
                Response.Redirect( "~/User/", true );
            } else
                //lblMsg.Text = "Incorrect";
                ErrorAlert.Style.Remove( "display" );
    }

    /// <summary>
    /// Filter out the fat fingers who get their passwords wrong
    /// </summary>
    bool ValidateUserAdmin( string user, string pass )
    {
        string connStr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection conn = new SqlConnection( connStr ) ) {
            conn.Open();
            string sql = "select Mail from Users where Mail = @email and password = @password and Admin = 1";
            SqlCommand cmd = new SqlCommand( sql, conn );
            cmd.Parameters.AddWithValue( "@email", user );
            cmd.Parameters.AddWithValue( "@password", Sha1( Salt( pass ) ) );
            return cmd.ExecuteScalar() is string;
        }
    }
    bool ValidateUser( string user, string pass )
    {
        string connStr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection conn = new SqlConnection( connStr ) ) {
            conn.Open();
            string sql = "select Mail from Users where Mail = @email";
            SqlCommand cmd = new SqlCommand( sql, conn );
            cmd.Parameters.AddWithValue( "@email", user );
            cmd.Parameters.AddWithValue( "@password", Sha1( Salt( pass ) ) );
            return cmd.ExecuteScalar() is string;
        }
    }
    /// <summary>
    /// Salt the hell out of a string before hashing it
    /// </summary>
    public string Salt( string text )
    {
        return
          "zu5QnKrH4NJfOgV2WWqV5Oc1l" +
          text +
          "1DMuByokGSDyFPQ0DbXd9rAgW";
    }

    /// <summary>
    /// One-way hash the password, so the DBA can't see the inevitable swear words in the password column
    /// </summary>
    public string Sha1( string text )
    {
        byte[] clear = Encoding.UTF8.GetBytes( text );
        byte[] hash = new SHA1CryptoServiceProvider().ComputeHash( clear );
        return BitConverter.ToString( hash ).Replace( "-", "" ).ToLower();
    }
}
