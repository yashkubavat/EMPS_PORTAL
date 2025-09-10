<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EMPS_PORTAL.Admin.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .login-box {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: linear-gradient(135deg, #e0e7ff, #f4f6f9);
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }

        input {
            width: 90%;
            padding: 10px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="login-box">
                <h2>Admin Login</h2>
                <%--<form>
                    <input type="text" placeholder="Username" required><br>
                    <input type="password" placeholder="Password" required><br>
                    <a href="dashboard.html" button class="btn">Login</a>

                </form>--%>
                <label for="Email">Email *</label>
                <asp:TextBox ID="txtem" name="fullName" placeholder="Enter your email" runat="server"></asp:TextBox><br />

                <label for="password">Password *</label>
                <asp:TextBox ID="txtpass" name="fullName" placeholder="Enter your password" runat="server"></asp:TextBox><br />
                <asp:Button ID="Button1" class="btn" runat="server" Text="Login" OnClick="Button1_Click" />
                <p>Don't have an account? <a href="register.aspx">Register</a></p>
            </div>
        </div>
    </form>
</body>
</html>
