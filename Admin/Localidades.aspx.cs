using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Admin_Localidades : System.Web.UI.Page
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
            using ( SqlCommand cmd = new SqlCommand( "Localidades_CRUD" ) ) {
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
        string nomeLocalidade = TBLocalidade.Text;
        TBLocalidade.Text = "";
        string IdPais = DDLPais.Text;
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Localidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "INSERT" );
                cmd.Parameters.AddWithValue( "@Nome_Localidade", nomeLocalidade );
                cmd.Parameters.AddWithValue( "@ID_Pais", IdPais );
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGrid();
    }

    protected void OnRowEditing( object sender, GridViewEditEventArgs e )
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGrid();
    }

    protected void OnRowUpdating( object sender, GridViewUpdateEventArgs e )
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int IdLocalidade = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string nomeLocalidade = ( row.FindControl( "txtLocalidade" ) as TextBox ).Text;
        int IdPais = Convert.ToInt32( ( row.FindControl( "txtPais" ) as DropDownList ).SelectedValue );

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Localidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "UPDATE" );
                cmd.Parameters.AddWithValue( "@ID_Localidade", IdLocalidade );
                cmd.Parameters.AddWithValue( "@Nome_Localidade", nomeLocalidade );
                cmd.Parameters.AddWithValue( "@ID_Pais", IdPais );
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
        int IdSkill = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Localidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "DELETE" );
                cmd.Parameters.AddWithValue( "@ID_Localidade", IdSkill );
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
            ( e.Row.Cells[2].Controls[2] as LinkButton ).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
        }
    }
}