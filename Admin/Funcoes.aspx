<%@ Page Title="Funções" Language="C#" MasterPageFile="~/Admin/AdminView.Master" AutoEventWireup="true" CodeFile="Funcoes.aspx.cs" Inherits="Admin_Funcoes" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridView1" runat="server" AllowPaging="true" AutoGenerateColumns="False" DataKeyNames="ID_Funcao"
        OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added.">
        <Columns>
            <asp:TemplateField HeaderText="Nome" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblFuncaoNome" runat="server" Text='<%# Eval("Nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtFuncaoNome" runat="server" Text='<%# Eval("Nome") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons" />
        </Columns>
    </asp:GridView>
    <hr />

    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            <td style="width: 150px">Nome:<br />
                <asp:TextBox ID="TBnome" runat="server" Width="500px" Height="35px" />
            </td>
            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />

            </td>
        </tr>
    </table>
</asp:Content>

