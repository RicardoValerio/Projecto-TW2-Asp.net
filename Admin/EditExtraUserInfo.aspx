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
        <div class="col-md-3">
            <img src="http://demo.dnnrox.com/Portals/_default/Skins/Flatna2/img/icons/user@2x.png" alt="User Image" />
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server" />
            </div>

        </div>
        <div class="col-md-9">
            <p>Navbars are responsive meta components that serve as navigation headers for your application or site. They begin collapsed (and are toggleable) in mobile views and become horizontal as the available viewport width increases.

Justified navbar nav links are currently not supported.
Overflowing content

Since Bootstrap doesn't know how much space the content in your navbar needs, you might run into issues with content wrapping into a second row. To resolve this, you can:

    Reduce the amount or width of navbar items.
    Hide certain navbar items at certain screen sizes using responsive utility classes.
    Change the point at which your navbar switches between collapsed and horizontal mode. Customize the @grid-float-breakpoint variable or add your own media query.
</p>
        </div>
    </div>

    <hr />
<%-- START SKILLS --%>

    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridView1" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPagingSkills" AllowSorting="True" runat="server" AutoGenerateColumns="False"
        OnRowDataBound="OnRowDataBoundSkills" OnRowEditing="OnRowEditingSkills" OnRowCancelingEdit="OnRowCancelingEditSkills"
        OnRowUpdating="OnRowUpdatingSkills" OnRowDeleting="OnRowDeletingSkills" EmptyDataText="No records has been added.">
        <Columns>
            <asp:TemplateField HeaderText="Nome" ItemStyle-Width="140">
                <ItemTemplate>
                    <asp:Label ID="lblNome" runat="server" Text='<%# Eval("Nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNome" runat="server" Text='<%# Eval("Nome") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="140">
                <ItemTemplate>
                    <asp:Label ID="lblDescricao" runat="server" Text='<%# Eval("Descricao") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescricao" runat="server" Text='<%# Eval("Descricao") %>'></asp:TextBox>
                </EditItemTemplate>

                <ItemStyle Width="140px"></ItemStyle>
            </asp:TemplateField>
           
           
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="User_Skills_CRUD" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="SELECT" Name="Action" Type="String" />
            <asp:QueryStringParameter DefaultValue="" Name="ID_User" QueryStringField="UserId" Type="Int32" />
            <asp:Parameter Name="ID_Skill" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            <td style="width: 150px">Nome:<br />
                <asp:TextBox ID="TBnome" runat="server" Width="300px" Height="35px" />
            </td>
            <td style="width: 150px">Descrição:<br />
                <asp:TextBox ID="TBdescricao" runat="server" Width="300px" Height="35px" />
            </td>
            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="btnAdd" runat="server" Text="Add" OnClick="InsertSkills" />
            </td>
        </tr>
    </table>

<%-- END SKILLS --%>

<%-- START EXPERIENCIA --%>
<%-- END EXPERIENCIA --%>


<%-- START FORMAÇÃO --%>
<%-- END FORMAÇÃO --%>


<%-- START CERTIFICADOS --%>
<%-- END CERTIFICADOS --%>

<%-- START PUBLICAÇÕES --%>
<%-- END PUBLICAÇÕES --%>


</asp:Content>

