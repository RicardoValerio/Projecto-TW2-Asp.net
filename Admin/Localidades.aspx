<%@ Page Title="Localidades" Language="C#" MasterPageFile="~/Admin/MainAdminView.Master" AutoEventWireup="true" CodeFile="Localidades.aspx.cs" Inherits="Admin_Localidades" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:GridView class="table" style="margin: 0 auto;" ID="GridView1" runat="server" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="False" DataKeyNames="ID_Localidade"
        OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added.">
        <Columns>
            <asp:TemplateField HeaderText="Localidade" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="País" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblPais" runat="server" Text='<%# Eval("Nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <%--<asp:TextBox ID="txtPais" runat="server" Text='<%# Eval("ID_Pais") %>'></asp:TextBox>--%>
                    <asp:DropDownList ID="txtPais" runat="server" DataSourceID="SqlDataSource2" DataTextField="Nome" DataValueField="ID_Pais"></asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons" />
        </Columns>
    </asp:GridView>
    <hr />

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="SELECT * FROM Paises"></asp:SqlDataSource>
    <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
        <tr>
            <td style="width: 150px">Localidade:<br />
                <asp:TextBox ID="TBLocalidade" runat="server" Width="300px" Height="35px" />
            </td>
            <td style="width: 150px">País:<br />
                <%--<asp:TextBox ID="TBPais" runat="server" Width="300px" Height="35px" />--%>
                <asp:DropDownList ID="DDLPais" runat="server" DataSourceID="SqlDataSource2" DataTextField="Nome" DataValueField="ID_Pais"></asp:DropDownList>
            </td>
            <td style="width: 100px">
                <asp:Button class="btn btn-success" ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
            </td>
        </tr>
    </table>
</asp:Content>

