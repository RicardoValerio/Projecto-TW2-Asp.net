<%@ Page Title="Login" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

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
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #eee;
            /*just for fun*/
            background: url(../Content/Assets/bg.png);
            background-repeat: no-repeat;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }

            .form-signin .form-signin-heading,
            .form-signin .checkbox {
                margin-bottom: 10px;
            }

            .form-signin .checkbox {
                font-weight: normal;
            }

            .form-signin .form-control {
                position: relative;
                height: auto;
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
                padding: 10px;
                font-size: 16px;
            }

                .form-signin .form-control:focus {
                    z-index: 2;
                }

            .form-signin input[type="email"] {
                margin-bottom: -1px;
                border-bottom-right-radius: 0;
                border-bottom-left-radius: 0;
            }

            .form-signin input[type="password"] {
                margin-bottom: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            }

        /* just dor fun*/
        #Button1 {
            background-color: #DB8F39;
            border-color: #DB8F39;
        }

            #Button1:hover {
                background-color: #DB8F39;
                border-color: #DB8F39;
            }
    </style>
</head>
<body>

    <div class="container">

        <form runat="server" class="form-signin" role="form">
            <h2 style="color:white;" class="form-signin-heading">Please sign in</h2>

            <%--<label for="TBinputEmail" class="sr-only">Email address</label>
            <input type="email" id="TBinputEmail" class="form-control" placeholder="Email address" required autofocus>--%>

            <asp:Label for="TBinputEmail" class="sr-only" ID="Label1" runat="server" Text="Email Address"></asp:Label>
            <asp:TextBox type="text" class="form-control" placeholder="Email address" required="required" autofocus="autofocus" ID="TBinputEmail" runat="server"></asp:TextBox>


            <%--<label for="inputPassword" class="sr-only">Password</label>
            <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>--%>

            <asp:Label for="TBinputPassword" class="sr-only" ID="Label2" runat="server" Text="Password"></asp:Label>
            <asp:TextBox type="password" class="form-control" placeholder="Password" required="required" ID="TBinputPassword" runat="server"></asp:TextBox>

            <%--<button style="width:94%;" class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>--%>
            <asp:Button Style="width: 94%;" class="btn btn-lg btn-primary btn-block" ID="Button1" runat="server" OnClick="SignIn" Text="Sign In" />

            <div runat="server" id="ErrorAlert" style="display: none; width: 279px; margin-left: 1px; margin-top: 60px; text-align: center; font-weight: bolder;" class="alert alert-danger" role="alert">
                <asp:Label ID="ErrorMessage" runat="server" Text="UserEmail OU Pass Erradas"></asp:Label>
            </div>

        </form>


    </div>

</body>
</html>
