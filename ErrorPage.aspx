<%@ Page Title="ErrorPage" Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="ErrorPage" %>

<!DOCTYPE html>

<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title><%: Page.Title %> - Projecto de TW2</title>

    <asp:PlaceHolder runat="server">
        <%: Scripts.Render("~/bundles/modernizr") %>
    </asp:PlaceHolder>
    <webopt:BundleReference runat="server" Path="~/Content/css" />
    <link href="Content/Assets/favicon.ico" rel="shortcut icon" type="image/x-icon" />
    <style>
        body {
            background-image: url(Content/Assets/bg.png);
            background-repeat: no-repeat;
        }

        .error-template {
            padding: 40px 15px;
            text-align: center;
            color: white;
        }

        .error-actions {
            margin-top: 15px;
            margin-bottom: 15px;
        }

            .error-actions .btn {
                margin-right: 10px;
            }
    </style>
</head>
<body>


    <form id="form2" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="error-template">
                        <h1>Oops!</h1>
                        <h2>404 Not Found</h2>
                        <div class="error-details">
                            Sorry, an error has occured, Requested page not found!
                        </div>
                        <div class="error-actions">
                            <a style="background-color: red;"
   <% 
       
        if ( Session.Count > 0 ) {
            if ( Session["Perfil"].ToString() == "Admin" ) { %>
                       href="Admin"
           <% } else if ( Session["Perfil"].ToString() == "User" ) { %>
                       href="User"
           <% }
        } else { %>
                       href="Login.aspx"
       <% } %>
                                class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-home"></span>
                                Take Me Back </a><a href="mailto:admin@twproject.pt" class="btn btn-default btn-lg"><span class="glyphicon glyphicon-envelope"></span>Contact Support </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>

</body>
</html>
