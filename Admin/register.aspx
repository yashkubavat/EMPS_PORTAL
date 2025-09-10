<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="EMPS_PORTAL.Admin.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        .register-box {
            width: 400px;
            margin: 80px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
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
            <div class="register-box">
                <h2>Admin Registration</h2>
                <%--<form>
                    <input type="text" placeholder="Full Name" required><br>
                    <input type="email" placeholder="Email" required><br>
                    <input type="text" placeholder="Username" required><br>
                    <input type="password" placeholder="Password" required><br>
                    <button class="btn">Register</button>
                </form>--%>

                <label for="fullName">Full Name *</label>
                <asp:TextBox ID="txtun" name="fullName" placeholder="Enter your full name" runat="server"></asp:TextBox><br />

                <label for="Email">Email *</label>
                <asp:TextBox ID="txtem" name="fullName" placeholder="Enter your email" runat="server"></asp:TextBox><br />

                <label for="password">Password *</label>
                <asp:TextBox ID="txtpass" name="fullName" placeholder="Enter your password" runat="server"></asp:TextBox><br />
                <asp:Button ID="Button1" class="btn" runat="server" Text="Register" OnClick="Button1_Click" />
                <p>You have an account? <a href="index.aspx">Login</a></p>

            </div>
        </div>
    </form>
</body>
</html>
