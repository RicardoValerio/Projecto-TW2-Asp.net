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



    <%-- END EXPERIENCIA --%>


    <%-- START FORMAÇÃO --%>
    <h2>User Formação</h2>
    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridViewFormacao" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingFormacao" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundFormacao" OnRowEditing="OnRowEditingFormacao" OnRowCancelingEdit="OnRowCancelingEditFormacao"
        OnRowUpdating="OnRowUpdatingFormacao" OnRowDeleting="OnRowDeletingFormacao" EmptyDataText="No records has been added." >
        <Columns>

            <asp:TemplateField HeaderText="Data Inicio" ItemStyle-Width="140">

                <ItemTemplate>
                    <asp:Label  ID="lblDataInicio" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox  ID="txtDataInicio" runat="server" Text='<%# Eval("Data_Inicio", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

            </asp:TemplateField>
                    <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Data Fim" ItemStyle-Width="140">

                <ItemTemplate>
                    <asp:Label ID="lblDataFim" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtDataFim" runat="server" Text='<%# Eval("Data_Fim", "{0:d}") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

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
            <asp:TemplateField HeaderText="Entidade" ItemStyle-Width="140">

                <ItemTemplate>
                    <asp:Label ID="lblEntidade" runat="server" Text='<%# Eval("Entidade") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtEntidade" runat="server" Text='<%# Eval("Entidade") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

            </asp:TemplateField>
            <%--------------------------------------------------------%>
            <asp:TemplateField HeaderText="Tipo Curso" ItemStyle-Width="140">

                <ItemTemplate>
                    <asp:Label ID="lblTipo_Curso" runat="server" Text='<%# Eval("Tipo") %>'></asp:Label>
                </ItemTemplate>

                <EditItemTemplate>
                    <asp:TextBox ID="txtTipo_Curso" runat="server" Text='<%# Eval("Tipo") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>

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
                <asp:TextBox ID="TBDataInicio1" runat="server" Width="20px" Height="35px" />
                <asp:TextBox ID="TBDataInicio2" runat="server" Width="20px" Height="35px" />
                <asp:TextBox ID="TBDataInicio3" runat="server" Width="70px" Height="35px" />
            </td>

            <td style="width: 150px">Data Fim:<br />
                <asp:TextBox ID="TBDataFim1" runat="server" Width="20px" Height="35px" />
                <asp:TextBox ID="TBDataFim2" runat="server" Width="20px" Height="35px" />
                <asp:TextBox ID="TBDataFim3" runat="server" Width="70px" Height="35px" />
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
    <%-- END CERTIFICADOS --%>

    <%-- START PUBLICAÇÕES --%>
    <%-- END PUBLICAÇÕES --%>
</asp:Content>

