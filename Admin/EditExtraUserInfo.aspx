<%@ Page Title="Edit User Extra Info" Language="C#" MasterPageFile="~/Admin/MainAdminView.Master" AutoEventWireup="true" CodeFile="EditExtraUserInfo.aspx.cs" Inherits="Admin_EditExtraUserInfo" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridView1" AllowPaging="True" AllowSorting="True" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_User"
        OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added.">
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
            <asp:TemplateField HeaderText="Email" ItemStyle-Width="140">
                <ItemTemplate>
                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Mail") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("Mail") %>'></asp:TextBox>
                </EditItemTemplate>

<ItemStyle Width="140px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pais" ItemStyle-Width="100">
                <ItemTemplate>
                    <asp:Label ID="lblPais" runat="server" Text='<%# Eval("Pais") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPais" runat="server" Text='<%# Eval("Pais") %>'></asp:TextBox>
                </EditItemTemplate>

<ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Localidade" ItemStyle-Width="100">
                <ItemTemplate>
                    <asp:Label ID="lblLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:TextBox>
                </EditItemTemplate>

<ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons" >
<ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

<ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>
        </Columns>
    </asp:GridView>

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
                <asp:Button class="btn btn-success" ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
            </td>
        </tr>
    </table>
</asp:Content>

