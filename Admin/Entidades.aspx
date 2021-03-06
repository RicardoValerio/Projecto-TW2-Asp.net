﻿<%@ Page Title="Entidades" Language="C#" MasterPageFile="~/Admin/MainAdminView.Master" AutoEventWireup="true" CodeFile="Entidades.aspx.cs" Inherits="Admin_Entidades" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: Title %></h2>

    <asp:TextBox ID="nomeSearch" runat="server"></asp:TextBox>
    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem>OR</asp:ListItem>
        <asp:ListItem>AND</asp:ListItem>
    </asp:DropDownList>
    <asp:TextBox ID="descricaoSearch" runat="server" ></asp:TextBox>

    <asp:Button ID="searchInTableDescricao" runat="server" Text="Button" OnClick="searchInTableDescricao_Click" />

    <asp:GridView class="table" Style="margin: 0 auto;" ID="GridView1" runat="server" AllowPaging="True" PageSize="5" OnPageIndexChanging="OnPaging" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID_Entidade"
        OnRowDataBound="OnRowDataBound" OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit" 
        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added.">
        <Columns>
            <asp:TemplateField HeaderText="Nome" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblNome" runat="server" Text='<%# Eval("Nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNome" runat="server" Text='<%# Eval("Nome") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Descrição" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblDescricao" runat="server" Text='<%# Eval("Descricao") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtDescricao" runat="server" Text='<%# Eval("Descricao") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" ControlStyle-CssClass="btn updadeDeleteButtons" />

            <asp:HyperLinkField HeaderStyle-Width="50" ControlStyle-CssClass="btn userEditExtraInfo" HeaderText="" NavigateUrl="EditExtraUserInfo" Text="Extra Info" DataNavigateUrlFields="ID_Entidade" DataNavigateUrlFormatString="EditExtraEntidadeInfo.aspx?EntidadeId={0}" />      
    
                </Columns>
    </asp:GridView>


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
                <%--<button type="button" class="btn btn-success btn-sm" ID="btnAdd" runat="server" OnClick="Insert">
                    <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>Add
                </button>--%>

            </td>
        </tr>
    </table>
</asp:Content>

