using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Admin_EditExtraUserInfo : System.Web.UI.Page
{
    public int UserId;

    protected void Page_Load( object sender, EventArgs e )
    {
        if ( !this.IsPostBack ) {
            if ( !( Request.QueryString.Count > 0 ) ) {
                Response.Redirect( "Users.aspx" );
            } else {

                this.UserId = Convert.ToInt32( Request.QueryString["UserId"] );
                //Response.Write("UserId na URL é: " + Request.QueryString["UserId"]);


                // verificar se o USERID passado existe na base de dados
                // se existe fazer isto:
                this.BindGridSkills();
                // se não existir fazer aqueloutro:
            }
        } else {
            this.UserId = Convert.ToInt32( Request.QueryString["UserId"] );
        }

    }

    //START SKILLS
    private void BindGridSkills()
    {
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "User_Skills_CRUD" ) ) {
                cmd.Parameters.AddWithValue( "@Action", "SELECT" );
                cmd.Parameters.AddWithValue( "@ID_User", this.UserId );
                cmd.Parameters.AddWithValue( "@Nome_Skill", "" );
                cmd.Parameters.AddWithValue( "@Descricao_Skill", "" );
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

    protected void InsertSkills( object sender, EventArgs e )
    {
        string skill = DBNomeDaSkill.SelectedValue;

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "User_Skills_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "INSERT" );
                cmd.Parameters.AddWithValue( "@ID_User", 1 );
                cmd.Parameters.AddWithValue( "@ID_Skill", skill );
                cmd.Parameters.AddWithValue( "@Nome_Skill", "" );
                cmd.Parameters.AddWithValue( "@Descricao_Skill", "" );
 
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGridSkills();
    }

    protected void OnRowEditingSkills( object sender, GridViewEditEventArgs e )
    {
        GridView1.EditIndex = e.NewEditIndex;
        this.BindGridSkills();
    }

    protected void OnRowUpdatingSkills( object sender, GridViewUpdateEventArgs e )
    {
        GridViewRow row = GridView1.Rows[e.RowIndex];
        int IdSkill = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string nomeSkill = ( row.FindControl( "txtNomeSkill" ) as TextBox ).Text;
        string descricaoSkill = ( row.FindControl( "txtDescricaoSkill" ) as TextBox ).Text;

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "User_Skills_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "UPDATE" );
                cmd.Parameters.AddWithValue( "@ID_Skill", IdSkill );
                cmd.Parameters.AddWithValue( "@Nome_Skill", nomeSkill );
                cmd.Parameters.AddWithValue( "@Descricao_Skill", descricaoSkill );
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        GridView1.EditIndex = -1;
        this.BindGridSkills();
    }

    protected void OnRowCancelingEditSkills( object sender, EventArgs e )
    {
        GridView1.EditIndex = -1;
        this.BindGridSkills();
    }

    protected void OnRowDeletingSkills( object sender, GridViewDeleteEventArgs e )
    {
        int IdSkill = Convert.ToInt32( GridView1.DataKeys[e.RowIndex].Values[0] );
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "User_Skills_CRUD" ) ) {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue( "@Action", "DELETE" );
                cmd.Parameters.AddWithValue( "@ID_User", this.UserId );
                cmd.Parameters.AddWithValue( "@ID_Skill", IdSkill );
                cmd.Parameters.AddWithValue( "@Nome_Skill", "" );
                cmd.Parameters.AddWithValue( "@Descricao_Skill", "" );
                cmd.Connection = con;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        this.BindGridSkills();
    }

    protected void OnRowDataBoundSkills( object sender, GridViewRowEventArgs e )
    {
        if ( e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex ) {
            ( e.Row.Cells[2].Controls[2] as LinkButton ).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
        }
    }

    protected void OnPagingSkills( object sender, GridViewPageEventArgs e )
    {
        this.BindGridSkills();
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataBind();

    }

    //END SKILLS

    //START EXPERIENCIA
    
    //END EXPERIENCIA

    //START FORMAÇÃO
    //END FORMAÇÃO

    //START CERTIFICADOS
    //END CERTIFICADOS

    //START PUBLICAÇÕES
    //END PUBLICAÇÕES

}