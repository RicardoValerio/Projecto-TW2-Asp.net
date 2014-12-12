using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class Users : System.Web.UI.Page
{
    protected void Page_Load( object sender, EventArgs e )
    {
        if ( !this.IsPostBack ) {
            this.BindGrid();
        }
    }

    private void BindGrid()
    {
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Users_CRUD" ) ) {
                cmd.Parameters.AddWithValue( "@Action", "SELECT" );
                using ( SqlDataAdapter sda = new SqlDataAdapter() ) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using ( DataTable dt = new DataTable() ) {
                        sda.Fill( dt );
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
        }
    }

    protected void Insert( object sender, EventArgs e )
    {
        string nome = TBnome.Text;
        string email = TBEmail.Text;
        string pais = TBPais.Text;
        string localidade = TBLocalidade.Text;
        string password = TBPassword.Text;

        TBnome.Text = "";
        TBEmail.Text = "";
        TBPais.Text = "";
        TBLocalidade.Text = "";
        TBLocalidadeInserida.Text = "";

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Users_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "INSERT" );
                cmd.Parameters.AddWithValue( "@Nome", nome );
                cmd.Parameters.AddWithValue( "@Mail", email );
                cmd.Parameters.AddWithValue( "@Password", Sha1(Salt(password)) );

                cmd.Parameters.AddWithValue( "@Pais", pais );
                cmd.Parameters.AddWithValue( "@Localidade", localidade );
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }

    public string Salt( string text )
    {
        return
          "zu5QnKrH4NJfOgV2WWqV5Oc1l" +
          text +
          "1DMuByokGSDyFPQ0DbXd9rAgW";
    }

    public string Sha1( string text )
    {
        byte[] clear = Encoding.UTF8.GetBytes( text );
        byte[] hash = new SHA1CryptoServiceProvider().ComputeHash( clear );
        return BitConverter.ToString( hash ).Replace( "-", "" ).ToLower();
    }

    protected void OnRowEditing( object sender, GridViewEditEventArgs e )
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }

    protected void OnRowUpdating( object sender, GridViewUpdateEventArgs e )
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int IdUser = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string nome = ( row.FindControl( "txtNome" ) as TextBox ).Text;
        string email = ( row.FindControl( "txtEmail" ) as TextBox ).Text;
        string localidade = ( row.FindControl( "txtLocalidade" ) as DropDownList ).SelectedValue;


        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Users_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "UPDATE" );
                cmd.Parameters.AddWithValue( "@ID_User", IdUser );
                cmd.Parameters.AddWithValue( "@Nome", nome );
                cmd.Parameters.AddWithValue( "@Mail", email );
                cmd.Parameters.AddWithValue( "@Localidade", localidade );

                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void OnRowCancelingEdit( object sender, EventArgs e )
    {
        GridView1.EditIndex = -1;
        this.BindGrid();
    }

    protected void OnRowDeleting( object sender, GridViewDeleteEventArgs e )
    {
        int IdUser = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Users_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "DELETE" );
                cmd.Parameters.AddWithValue( "@ID_User", IdUser );
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }

    protected void OnRowDataBound( object sender, GridViewRowEventArgs e )
    {
        if ( e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex ) {
            ( e.Row.Cells[4].Controls[2] as LinkButton ).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
        }
    }

    protected void OnPaging( object sender, GridViewPageEventArgs e )
    {
        this.BindGrid();
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();

    }
}