<%@ Page Title="Edit User Extra Info" Language="C#" MasterPageFile="~/Admin/MainAdminView.Master" AutoEventWireup="true" CodeFile="EditExtraUserInfo.aspx.cs" Inherits="Admin_EditExtraUserInfo" %>

<asp:Content ContentPlaceHolderID="EditUserExtraInfo_BreadCrumb" runat="server">
    <ol class="breadcrumb">
        <li><a href="Users.aspx">Users</a></li>
        <li><a href="#">Edit Extra User Info</a></li>
        <li class="active">User Id: <%= UserId %> </li>
    </ol>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">

        <h2><%: Title %></h2>
        <hr />
        <div class="col-md-4">
            <img src="../Content/UserImages/<%= user_image %>" height="200" width="200" alt="User Image" />
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server"  accept="image/png,image/jpeg" />
                <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="UploadUserImage" />
                <asp:Label style="color:red; display:none;" ID="LabelErroUploadImagem" runat="server" Text="apenas pode fazer upload de imagens (jpg/png)"></asp:Label>
            </div>

        </div>
        <div class="col-md-8">
            <p><%= user_sumario %></p>
        </div>
    </div>

    <hr />
    <%-- START SKILLS --%>
    <h2>User Skills</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewSkills" AllowPaging="True" PageSize="5" DataKeyNames="ID_Skill" OnPageIndexChanging="OnPagingSkills" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundSkills" OnRowEditing="OnRowEditingSkills" OnRowCancelingEdit="OnRowCancelingEditSkills"
        OnRowUpdating="OnRowUpdatingSkills" OnRowDeleting="OnRowDeletingSkills" EmptyDataText="No records has been added.">
        <Columns>
            <asp:TemplateField HeaderText="Nome" ItemStyle-Width="140">
                <ItemTemplate>
                    <asp:Label ID="lblNome" runat="server" Text='<%# Eval("Nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNomeSkill" runat="server" Text='<%# Eval("Nome") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="140">
                <ItemTemplate>
                    <asp:Label ID="lblDescricao" runat="server" Text='<%# Eval("Descricao") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescricaoSkill" runat="server" Text='<%# Eval("Descricao") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>
            </asp:TemplateField>


            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="User_Skills_CRUD" SelectCommandType="StoredProcedure" InsertCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" UpdateCommand="User_Skills_CRUD" InsertCommand="User_Skills_CRUD" DeleteCommand="User_Skills_CRUD">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter Name="ID_Skill" Type="Int32" />
            <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="Nome_Skill" Type="String" />
            <asp:Parameter Name="Descricao_Skill" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter DefaultValue="UPDATE" Name="Action" Type="String" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter Name="ID_Skill" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            <td style="width: 150px">Skills:<br />
                <%--<asp:TextBox ID="TBnome" runat="server" Width="300px" Height="35px" />--%>
                <asp:DropDownList ID="DBNomeDaSkill" runat="server" DataSourceID="SqlDataSource2" DataValueField="ID_Skill" DataTextField="Nome"></asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="SELECT [ID_Skill], [Nome] FROM [Skills]"></asp:SqlDataSource>
            </td>
            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="btnAdd" runat="server" Text="Add" OnClick="InsertSkills" />
            </td>
        </tr>
    </table>

    <hr />
    <%-- END SKILLS --%>

    <%-- START EXPERIENCIA --%>
           <h2>User Experiências</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewExperiencias" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingExperiencias" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundExperiencias" OnRowEditing="OnRowEditingExperiencias" OnRowCancelingEdit="OnRowCancelingEditExperiencias"
        OnRowUpdating="OnRowUpdatingExperiencias" OnRowDeleting="OnRowDeletingExperiencias" EmptyDataText="No records has been added." >
        <Columns>

            <asp:TemplateField HeaderText="Empregador" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label  ID="lblEmpregador" runat="server" Text='<%# Eval("Empregador") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox  ID="txtEmpregador" runat="server" Text='<%# Eval("Empregador") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Função" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblFuncao_Experiencia" runat="server" Text='<%# Eval("Funcao") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtFuncao_Experiencia" runat="server" Text='<%# Eval("Funcao") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Data Início" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblData_Inicio_Experiencia" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtData_Inicio_Experiencia" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Data Fim" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblData_Fim_Experiencia" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtData_Fim_Experiencia" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblDescricao_Experiencia" runat="server" Text='<%# Eval("Descricao") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtDescricao_Experiencia" runat="server" Text='<%# Eval("Descricao") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
            
            
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>


        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="Experiencia_CRUD" SelectCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" UpdateCommand="Experiencia_CRUD" InsertCommand="Experiencia_CRUD">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter Name="ID_Empregador" Type="Int32" />
            <asp:Parameter Name="ID_Funcao" Type="Int32" />
            <asp:Parameter DbType="Date" Name="Data_Inicio" />
            <asp:Parameter DbType="Date" Name="Data_Fim" />
            <asp:Parameter Name="Descricao" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            
            <td style="width: 150px">Nome de Empregador:<br />
                <asp:TextBox ID="TB_NomeEmpregador" runat="server" />
            </td>

            <td style="width: 150px">Nome da Função:<br />
                <asp:TextBox ID="TB_NomeFuncao" runat="server" />
            </td>

            <td style="width: 150px">Data Início:<br />
                <asp:TextBox ID="TB_DataInicio_Experiencia" CssClass="datepicker" runat="server" Width="150px" Height="35px" />
            </td>
            <td style="width: 150px">Data Fim:<br />
                <asp:TextBox ID="TB_DataFim_Experiencia" CssClass="datepicker" runat="server" Width="150px" Height="35px" />
            </td>
            
            <td style="width: 150px">Descrição:<br />
                <asp:TextBox ID="TB_Descricao_Experiencia" runat="server" />
            </td>

            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="Button4" runat="server" Text="Add" OnClick="InsertExperiencias" />
            </td>
        </tr>
    </table>

    <hr />
    <%-- END EXPERIENCIA --%>


    <%-- START FORMAÇÃO --%>
    <h2>User Formação</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewFormacao" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingFormacao" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundFormacao" OnRowEditing="OnRowEditingFormacao" OnRowCancelingEdit="OnRowCancelingEditFormacao"
        OnRowUpdating="OnRowUpdatingFormacao" OnRowDeleting="OnRowDeletingFormacao" EmptyDataText="No records has been added." >
        <Columns>

            <asp:TemplateField HeaderText="Data Inicio" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label  ID="lblDataInicio" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox  ID="txtDataInicio" CssClass="datepicker" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Data Fim" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblDataFim" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtDataFim" CssClass="datepicker" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                     <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Curso" ItemStyle-Width="140">

                <ItemTemplate>
                    <asp:Label ID="lblCurso" runat="server" Text='<%# Eval("Curso") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtCurso" runat="server" Text='<%# Eval("Curso") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

            </asp:TemplateField>
            <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Entidade" ItemStyle-Width="120">

                <ItemTemplate>
                    <asp:Label ID="lblEntidade" runat="server" Text='<%# Eval("Entidade") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtEntidade" runat="server" Text='<%# Eval("Entidade") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

            </asp:TemplateField>
            <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Tipo Curso" ItemStyle-Width="110">

                <ItemTemplate>
                    <asp:Label ID="lblTipo_Curso" runat="server" Text='<%# Eval("Tipo") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtTipo_Curso" runat="server" Text='<%# Eval("Tipo") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="110px"></ItemStyle>

            </asp:TemplateField>

            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>


        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" DeleteCommandType="StoredProcedure" SelectCommand="Formacao_CRUD" SelectCommandType="StoredProcedure" UpdateCommandType="StoredProcedure" InsertCommandType="StoredProcedure" UpdateCommand="Formacao_CRUD">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter Name="ID_Curso" Type="Int32" />
            <asp:Parameter DbType="Date" Name="Data_Inicio" />
            <asp:Parameter DbType="Date" Name="Data_Fim" />
        </SelectParameters>
    </asp:SqlDataSource>

    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            
            <td style="width: 150px">Data Inicio:<br />
                <asp:TextBox ID="TBDataInicio1" CssClass="datepicker" runat="server" />
            </td>

            <td style="width: 150px">Data Fim:<br />
                <asp:TextBox ID="TBDataFim1" CssClass="datepicker" runat="server" />
            </td>

            <td style="width: 150px">Curso:<br />
                <asp:TextBox ID="TBCurso" runat="server" Width="150px" Height="35px" />
            </td>

            <td style="width: 150px">Entidade:<br />
                <asp:TextBox ID="TBEntidade" runat="server" Width="150px" Height="35px" />
            </td>

            <asp:SqlDataSource ID="SqlDataSourceTiposCurso" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="SELECT * FROM Tipo_Curso"></asp:SqlDataSource>

            <td style="width: 150px">Tipo de Curso:<br />
                <asp:DropDownList ID="DDLTipoCurso" runat="server" DataSourceID="SqlDataSourceTiposCurso" DataTextField="Tipo" DataValueField="ID_Tipo"></asp:DropDownList>
            </td>

            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="Button1" runat="server" Text="Add" OnClick="InsertFormacao" />
            </td>
        </tr>
    </table>

    <hr />
    <%-- END FORMAÇÃO --%>


    <%-- START CERTIFICADOS --%>
       <h2>User Certificados</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewCertificados" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingCertificados" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundCertificados" OnRowEditing="OnRowEditingCertificados" OnRowCancelingEdit="OnRowCancelingEditCertificados"
        OnRowUpdating="OnRowUpdatingCertificados" OnRowDeleting="OnRowDeletingCertificados" EmptyDataText="No records has been added." >
        <Columns>

            <asp:TemplateField HeaderText="Nome de Certificado" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label  ID="lblCertificadoNome" runat="server" Text='<%# Eval("Certificado") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox  ID="txtCertificadoNome" runat="server" Text='<%# Eval("Certificado") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Entidade" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblEntidadeNome" runat="server" Text='<%# Eval("Entidade") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtEntidadeNome" runat="server" Text='<%# Eval("Entidade") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
            
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>


        </Columns>
    </asp:GridView>



    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="Certificacao_CRUD" SelectCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" InsertCommand="Certificacao_CRUD" DeleteCommand="Certificacao_CRUD" UpdateCommandType="StoredProcedure" UpdateCommand="Certificacao_CRUD">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:QueryStringParameter Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter DefaultValue="" Name="ID_Certificado" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>



    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            
            <td style="width: 150px">Nome de Certificados:<br />
                <asp:TextBox ID="TbNomeCertificado" runat="server" />
            </td>

            <td style="width: 150px">Nome da Entidade:<br />
                <asp:TextBox ID="TbNomeEntidade" runat="server" />
            </td>

            <td style="width: 150px">Certificação:<br />
                <asp:TextBox ID="TbCertificao" runat="server" Width="150px" Height="35px" />
            </td>

            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="Button2" runat="server" Text="Add" OnClick="InsertCertificados" />
            </td>
        </tr>
    </table>

    <hr />
    <%-- END CERTIFICADOS --%>

    <%-- START PUBLICAÇÕES --%>
       <h2>User Publicações</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewPublicacoes" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingPublicacoes" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundPublicacoes" OnRowEditing="OnRowEditingPublicacoes" OnRowCancelingEdit="OnRowCancelingEditPublicacoes"
        OnRowUpdating="OnRowUpdatingPublicacoes" OnRowDeleting="OnRowDeletingPublicacoes" EmptyDataText="No records has been added." >
        <Columns>

            <asp:TemplateField HeaderText="Titulo da Publicação" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label  ID="lblPublicacaoTitulo" runat="server" Text='<%# Eval("Titulo") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox  ID="txtPublicacaoTitulo" runat="server" Text='<%# Eval("Titulo") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Data" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblDataPublicacao" runat="server" Text='<%# Eval("Data", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtDataPublicacao" runat="server" Text='<%# Eval("Data", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="90">

                <ItemTemplate>
                    <asp:Label ID="lblDescricaoPublicacao" runat="server" Text='<%# Eval("Descricao") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtDescricaoPublicacao" runat="server" Text='<%# Eval("Descricao") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="90px"></ItemStyle>

            </asp:TemplateField>
            
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>


        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="Autores_CRUD" SelectCommandType="StoredProcedure" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" DeleteCommand="Autores_CRUD" InsertCommand="Autores_CRUD" UpdateCommandType="StoredProcedure" UpdateCommand="Autores_CRUD">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:Parameter DefaultValue="" Name="ID_Publicacao" Type="Int32" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            
            <td style="width: 150px">Titulo de Publicação:<br />
                <asp:TextBox ID="TBTituloDescricao_a_Inserir" runat="server" />
            </td>

            <td style="width: 150px">Data da Publicação:<br />
                <asp:TextBox ID="TBDataDescricao_a_Inserir" CssClass="datepicker" runat="server" />
            </td>

            <td style="width: 150px">Descrição:<br />
                <asp:TextBox ID="TBDescricaoPublicao_a_Inserir" runat="server" Width="150px" Height="35px" />
            </td>

            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="Button3" runat="server" Text="Add" OnClick="InsertPublicacoes" />
            </td>
        </tr>
    </table>

    <hr />
    <%-- END PUBLICAÇÕES --%>
</asp:Content>

