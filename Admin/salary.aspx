<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="salary.aspx.cs" Inherits="EMPS_PORTAL.Admin.salary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <asp:Button ID="Button1" class="btn" runat="server" Text="Pay Salary" OnClick="Button1_Click" />
        <div class="card">
            <h2>Salary Records</h2>
            <table border="1" width="100%" cellpadding="10">
                <tr>
                    <th>Employee</th>
                    <th>Department</th>
                    <th>Salary</th>
                    <th>Status</th>
                </tr>
                <tr>
                    <td>Riya Sharma</td>
                    <td>HR</td>
                    <td>₹45,000</td>
                    <td>Paid</td>
                </tr>
                <tr>
                    <td>Aman Verma</td>
                    <td>IT</td>
                    <td>₹60,000</td>
                    <td>Pending</td>
                </tr>
            </table>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:TemplateField HeaderText="Id"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Employee Name"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Employee Id"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Department"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Periode"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Date"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Bassic Salary"></asp:TemplateField>
                    <asp:TemplateField HeaderText="HA"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Other earning"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Leave Deduction"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Pay"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Method"></asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Details"></asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="assets/css/style.css">
    </head>
    <body>
        <header>
            <h1>Employee Management Dashboard</h1>
        </header>
        <nav>
            <a href="dashboard.aspx">Dashboard</a> <a href="employees.aspx">Employees</a> <a href="departments.aspx">Departments</a> <a href="salary.aspx">Salary</a> <a href="leave.aspx">Leave</a> <a href="overview.aspx">Employee Overview</a> <a href="logout.aspx">Logout</a>
        </nav>
</asp:Content>

