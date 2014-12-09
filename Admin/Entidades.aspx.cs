using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Admin_Entidades : System.Web.UI.Page
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
            using ( SqlCommand cmd = new SqlCommand( "Entidades_CRUD" ) ) {
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
        string nomeEntidade = TBnome.Text;
        string descricaoEntidade = TBdescricao.Text;
        TBnome.Text = "";
        TBdescricao.Text = "";
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Entidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "INSERT" );
                cmd.Parameters.AddWithValue( "@Nome", nomeEntidade );
                cmd.Parameters.AddWithValue( "@Descricao", descricaoEntidade );
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
        int IdEntidade = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string nomeEntidade = ( row.FindControl( "txtNome" ) as TextBox ).Text;
        string descricaoEntidade = ( row.FindControl( "txtDescricao" ) as TextBox ).Text;
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Entidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "UPDATE" );
                cmd.Parameters.AddWithValue( "@ID_Entidade", IdEntidade );
                cmd.Parameters.AddWithValue( "@Nome", nomeEntidade );
                cmd.Parameters.AddWithValue( "@Descricao", descricaoEntidade );
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
        int IdEntidade = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Entidades_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "DELETE" );
                cmd.Parameters.AddWithValue( "@ID_Entidade", IdEntidade );
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

    protected void OnPaging( object sender, GridViewPageEventArgs e )
    {
        this.BindGrid();
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();

    }

    protected void searchInTableDescricao_Click( object sender, EventArgs e )
    {
        String nome = nomeSearch.Text;
        String descricao = descricaoSearch.Text;
        String operadorLogico = DropDownList1.SelectedValue;



    }
}