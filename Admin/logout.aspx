<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="EMPS_PORTAL.Admin.logout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Logout</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <header>
                <h1>Logout</h1>
            </header>
            <div class="main">
                <div class="card">
                    <h2>You have been logged out successfully.</h2>
                    <%--<a class="btn" href="index.aspx">Login Again</a>--%>
                    <asp:Button ID="Button1" runat="server" class="btn" Text="Login Again" OnClick="Button1_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
