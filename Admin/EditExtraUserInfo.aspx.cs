using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;
using System.Collections.Generic;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class Admin_EditExtraUserInfo : System.Web.UI.Page
{
    public int UserId;
    public String user_image;
    public String user_sumario;

    protected void Page_Load( object sender, EventArgs e )
    {
        if ( !this.IsPostBack ) {
            if ( !( Request.QueryString.Count > 0 ) ) {
                Response.Redirect( "Users.aspx" );
            } else {

                this.UserId = Convert.ToInt32( Request.QueryString["UserId"] );
                //Response.Write("UserId na URL é: " + Request.QueryString["UserId"]);

                // verificar se o USERID passado existe na base de dados
                if ( DatabaseHasUser() ) {
                    //System.Diagnostics.Debug.WriteLine( "USER EXISTE!" );

                    // se existe fazer isto:
                    // ir buscar o nome da imagem relativa ao id do user 
                    SetUserImage();
                    SetUserSumario();
                    // fazer o bind de todas as tables
                    this.BindGridSkills();
                    this.BindGridFormacao();

                } else {
                    // se não existir fazer aqueloutro:
                    //System.Diagnostics.Debug.WriteLine( "USER NÃO EXISTE!" );
                    Response.Redirect( "Users.aspx" );
                }

            }
        } else {
            this.UserId = Convert.ToInt32( Request.QueryString["UserId"] );
            SetUserImage();
            SetUserSumario();
        }

    }

    private void SetUserSumario()
    {
        string strCon = System.Web
               .Configuration
               .WebConfigurationManager
               .ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;

        SqlConnection sqlConnection1 = new SqlConnection( strCon );
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;

        cmd.CommandText = "SELECT Sumario FROM Users WHERE ID_User = " + this.UserId;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = sqlConnection1;
        sqlConnection1.Open();

        reader = cmd.ExecuteReader();
        // Data is accessible through the DataReader object here.
        reader.Read();
        this.user_sumario = (String)reader.GetValue( 0 );
        System.Diagnostics.Debug.WriteLine( this.user_sumario );
        sqlConnection1.Close();
    }
    private void SetUserImage()
    {
        string strCon = System.Web
           .Configuration
           .WebConfigurationManager
           .ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;

        SqlConnection sqlConnection1 = new SqlConnection( strCon );
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;

        cmd.CommandText = "SELECT Img_perfil FROM Users WHERE ID_User = " + this.UserId;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = sqlConnection1;
        sqlConnection1.Open();

        reader = cmd.ExecuteReader();
        // Data is accessible through the DataReader object here.
        reader.Read();
        this.user_image = (String)reader.GetValue( 0 );
        System.Diagnostics.Debug.WriteLine( this.user_image );
        sqlConnection1.Close();

    }

    private Boolean DatabaseHasUser()
    {
        string strCon = System.Web
                          .Configuration
                          .WebConfigurationManager
                          .ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;

        SqlConnection sqlConnection1 = new SqlConnection( strCon );
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;

        cmd.CommandText = "SELECT * FROM Users WHERE ID_User = " + this.UserId;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = sqlConnection1;
        sqlConnection1.Open();

        reader = cmd.ExecuteReader();
        // Data is accessible through the DataReader object here.
        Boolean userExists = reader.HasRows;
        sqlConnection1.Close();

        return userExists;

    }

    private string GetSHA1HashData( string data )
    {
        //create new instance of md5
        SHA1 sha1 = SHA1.Create();

        //convert the input text to array of bytes
        byte[] hashData = sha1.ComputeHash( Encoding.Default.GetBytes( data ) );

        //create new instance of StringBuilder to save hashed data
        StringBuilder returnValue = new StringBuilder();

        //loop for each byte and add it to StringBuilder
        for ( int i = 0; i < hashData.Length; i++ ) {
            returnValue.Append( hashData[i].ToString() );
        }

        // return hexadecimal string
        return returnValue.ToString();
    }

    private String UploadedImageHasValidExtension()
    {
        string fileExtension = FileUpload1.PostedFile.ContentType;

        switch ( fileExtension ) {
            case "image/jpeg":
            fileExtension = ".jpg";

            break;
            case "image/png":
            fileExtension = ".png";
            break;
            default:
            fileExtension = "nonValid";
            break;
        }

        return fileExtension;
    }

    protected void UploadUserImage( object sender, EventArgs e )
    {
        if ( FileUpload1.HasFile ) {

            String fileExtension = UploadedImageHasValidExtension();
            if ( fileExtension == "nonValid" ) {
                LabelErroUploadImagem.Style.Remove( "display" );
                return;
            }

            string fileName = Path.GetFileName( FileUpload1.PostedFile.FileName );
            fileName = GetSHA1HashData( Convert.ToString( TimeSpan.FromTicks( DateTime.Now.ToUniversalTime().Ticks ) ) + fileName );
            fileName = fileName.Substring( 0, 40 );
            fileName = fileName + fileExtension;

            System.Diagnostics.Debug.WriteLine( "Imagem velha: " + this.user_image );
            System.Diagnostics.Debug.WriteLine( "Tamanho da imagem velha: " + this.user_image.Length );

            System.Diagnostics.Debug.WriteLine( "Nova imagem inserida: " + fileName );
            System.Diagnostics.Debug.WriteLine( "Tamanho da Nova imagem inserida: " + fileName.Length );

            FileUpload1.PostedFile.SaveAs( Server.MapPath( "~/Content/UserImages/" ) + fileName );

            //update tabela user, campo userImage
            string strCon = System.Web
          .Configuration
          .WebConfigurationManager
          .ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;

            SqlConnection sqlConnection1 = new SqlConnection( strCon );
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "UPDATE Users SET Img_perfil = '" + fileName + "' WHERE ID_User = " + this.UserId;
            cmd.CommandType = CommandType.Text;
            cmd.Connection = sqlConnection1;
            sqlConnection1.Open();
            cmd.ExecuteNonQuery();
            sqlConnection1.Close();


            // remover foto antiga na pasta do servidor cujo nome está em this.user_image
            if ( this.user_image != "default.png" ) {
                File.Delete( Server.MapPath( "~/Content/UserImages/" + this.user_image ) );
            }

            Response.Redirect( Request.Url.AbsoluteUri );

        } else {
            LabelErroUploadImagem.Style.Remove( "display" );
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
                        GridViewSkills.DataSource = dt;
                        GridViewSkills.DataBind();
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
        GridViewSkills.EditIndex = e.NewEditIndex;
        this.BindGridSkills();
    }

    protected void OnRowUpdatingSkills( object sender, GridViewUpdateEventArgs e )
    {
        GridViewRow row = GridViewSkills.Rows[e.RowIndex];
        int IdSkill = Convert.ToInt32( GridViewSkills.DataKeys[e.RowIndex].Values[0] );
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
        GridViewSkills.EditIndex = -1;
        this.BindGridSkills();
    }

    protected void OnRowCancelingEditSkills( object sender, EventArgs e )
    {
        GridViewSkills.EditIndex = -1;
        this.BindGridSkills();
    }

    protected void OnRowDeletingSkills( object sender, GridViewDeleteEventArgs e )
    {
        int IdSkill = Convert.ToInt32( GridViewSkills.DataKeys[e.RowIndex].Values[0] );
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
        if ( e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridViewSkills.EditIndex ) {
            ( e.Row.Cells[2].Controls[2] as LinkButton ).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
        }
    }

    protected void OnPagingSkills( object sender, GridViewPageEventArgs e )
    {
        this.BindGridSkills();
        GridViewSkills.PageIndex = e.NewPageIndex;
        GridViewSkills.DataBind();

    }

    //END SKILLS

    //START EXPERIENCIA

    //END EXPERIENCIA

    //START FORMAÇÃO
    private void BindGridFormacao()
    {
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Formacao_CRUD" ) ) {
                cmd.Parameters.AddWithValue( "@Action", "SELECT" );
                cmd.Parameters.AddWithValue( "@ID_User", this.UserId );

                using ( SqlDataAdapter sda = new SqlDataAdapter() ) {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Connection = con;
                    sda.SelectCommand = cmd;
                    using ( DataTable dt = new DataTable() ) {
                        sda.Fill( dt );
                        GridViewFormacao.DataSource = dt;
                        GridViewFormacao.DataBind();
                    }
                }
            }
        }
    }

    protected void InsertFormacao( object sender, EventArgs e )
    {
        string skill = DBNomeDaSkill.SelectedValue;

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Formacao_CRUD" ) ) {
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
        this.BindGridFormacao();
    }

    protected void OnRowEditingFormacao( object sender, GridViewEditEventArgs e )
    {
        GridViewFormacao.EditIndex = e.NewEditIndex;
        this.BindGridFormacao();
    }

    protected void OnRowUpdatingFormacao( object sender, GridViewUpdateEventArgs e )
    {
        GridViewRow row = GridViewFormacao.Rows[e.RowIndex];
        int IdSkill = Convert.ToInt32( GridViewFormacao.DataKeys[e.RowIndex].Values[0] );
        string nomeSkill = ( row.FindControl( "txtNomeSkill" ) as TextBox ).Text;
        string descricaoSkill = ( row.FindControl( "txtDescricaoSkill" ) as TextBox ).Text;

        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Formacao_CRUD" ) ) {
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
        GridViewFormacao.EditIndex = -1;
        this.BindGridFormacao();
    }

    protected void OnRowCancelingEditFormacao( object sender, EventArgs e )
    {
        GridViewFormacao.EditIndex = -1;
        this.BindGridFormacao();
    }

    protected void OnRowDeletingFormacao( object sender, GridViewDeleteEventArgs e )
    {
        int IdSkill = Convert.ToInt32( GridViewFormacao.DataKeys[e.RowIndex].Values[0] );
        string constr = ConfigurationManager.ConnectionStrings["TW2ProjectConnectionString"].ConnectionString;
        using ( SqlConnection con = new SqlConnection( constr ) ) {
            using ( SqlCommand cmd = new SqlCommand( "Formacao_CRUD" ) ) {
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
        this.BindGridFormacao();
    }

    protected void OnRowDataBoundFormacao( object sender, GridViewRowEventArgs e )
    {
        if ( e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridViewFormacao.EditIndex ) {
            ( e.Row.Cells[5].Controls[2] as LinkButton ).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
        }
    }

    protected void OnPagingFormacao( object sender, GridViewPageEventArgs e )
    {
        this.BindGridFormacao();
        GridViewFormacao.PageIndex = e.NewPageIndex;
        GridViewFormacao.DataBind();

    }

    //END FORMAÇÃO

    //START CERTIFICADOS
    //END CERTIFICADOS

    //START PUBLICAÇÕES
    //END PUBLICAÇÕES

}