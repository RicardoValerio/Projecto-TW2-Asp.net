<%@ Page Title="Users" Language="C#" MasterPageFile="~/Admin/MainAdminView.Master" AutoEventWireup="true" CodeFile="Users.aspx.cs" Inherits="Users" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridView1" AllowPaging="True" AllowSorting="True" PageSize="5" OnPageIndexChanging="OnPaging" runat="server" AutoGenerateColumns="False" DataKeyNames="ID_User"
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
                <%--<EditItemTemplate>
                    <asp:TextBox ID="txtPais" runat="server" Text='<%# Eval("Pais") %>'></asp:TextBox>
                </EditItemTemplate>--%>

                <ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Localidade" ItemStyle-Width="100">
                <ItemTemplate>
                    <asp:Label ID="lblLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <%--<asp:TextBox ID="txtLocalidade" runat="server" Text='<%# Eval("Nome_Localidade") %>'></asp:TextBox>--%>
                    <asp:DropDownList ID="txtLocalidade" runat="server" DataSourceID="SqlDataSource3" DataTextField="Nome_Localidade" DataValueField="ID_Localidade"></asp:DropDownList>
                </EditItemTemplate>

                <ItemStyle Width="100px"></ItemStyle>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons">
                <ControlStyle CssClass="btn updadeDeleteButtons"></ControlStyle>

                <ItemStyle Width="150px"></ItemStyle>
            </asp:CommandField>
            <asp:HyperLinkField HeaderStyle-Width="50" ControlStyle-CssClass="btn userEditExtraInfo" HeaderText="" NavigateUrl="EditExtraUserInfo" Text="Extra Info" DataNavigateUrlFields="ID_User" DataNavigateUrlFormatString="EditExtraUserInfo.aspx?UserId={0}" />
        </Columns>
    </asp:GridView>

    <hr />

     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:TW2ProjectConnectionString %>" SelectCommand="SELECT * FROM Localidades"></asp:SqlDataSource>

    <div>
        <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">

            <td style="width: 150px">Nome:<br />
                <asp:TextBox onkeydown="return (event.keyCode!=13);" ID="TBnome" runat="server" Width="300px" Height="35px" />
            </td>
            <td style="width: 150px">Email:<br />
                <asp:TextBox onkeydown="return (event.keyCode!=13);" ID="TBEmail" runat="server" Width="300px" Height="35px" />
            </td>
        </table>
        <table class="table" border="1" style="margin: 0 auto; border-collapse: collapse">
            <tr>

                <td style="width: 150px">Insira Localidade:<br />
                    <asp:TextBox onblur="disableEnableAddButton()" onkeydown="return (event.keyCode!=13);" ID="TBLocalidadeInserida" runat="server" Width="300px" Height="35px" />
                </td>
                <td style="display: none;">Localidade:<br />
                    <asp:TextBox onkeydown="return (event.keyCode!=13);" ID="TBLocalidade" Text="Garbage" runat="server" Width="300px" Height="35px" />
                </td>
                <td style="display: none;">Pais:<br />
                    <asp:TextBox onkeydown="return (event.keyCode!=13);" ID="TBPais" runat="server" Width="300px" Height="35px" />
                </td>
                <td style="width: 150px">Insira Password:<br />
                    <asp:TextBox onblur="disableEnableAddButton()" onkeydown="return (event.keyCode!=13);" ID="TBPassword" runat="server" Width="300px" Height="35px" TextMode="Password" />
                </td>
            </tr>
        </table>
        <br />
        <p style="color:red;" id="ErroLocalidaNaoExiste"></p>

        <label style="width: 100px">
            <asp:Button class="btn btn-success" ID="btnAdd" runat="server" disabled Text="Add" OnClick="Insert" />
        </label>


        <script>
            var disableEnableAddButton = setInterval(function () {
                if ($('#MainContent_TBLocalidade').val() === "Garbage") {
                    $('#MainContent_btnAdd').attr('disabled', true);
                }
                else if ($('#MainContent_TBLocalidade').val() !== "" && $('#MainContent_TBLocalidade').val() !== "Garbage") {
                    $('#MainContent_btnAdd').removeAttr('disabled');
                    $('#ErroLocalidaNaoExiste').html("");
                } else {
                    $('#MainContent_btnAdd').attr('disabled', true);
                    $('#ErroLocalidaNaoExiste').html("introduza uma localidade válida");
                }
            }, 500);
        </script>
</asp:Content>


