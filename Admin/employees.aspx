<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="employees.aspx.cs" Inherits="EMPS_PORTAL.Admin.employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <%--<a class="btn" href="#">+ Add Employee</a>--%>
        <div class="card">
            <h2>Employee List</h2>
            <%-- <table border="1" width="100%" cellpadding="10">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Department</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>Riya Sharma</td>
                    <td>HR</td>
                    <td><a href="#">Edit</a> | <a href="#">Delete</a></td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>Aman Verma</td>
                    <td>IT</td>
                    <td><a href="#">Edit</a> | <a href="#">Delete</a></td>
                </tr>
            </table>--%>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="employee-grid">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Image") %>' CssClass="emp-image" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Department">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Mobile">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Mobile") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Gender") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="assets/css/style.css">
        <style>
            /* Grid container */
            .employee-grid {
                width: 100%;
                border-collapse: collapse;
                font-family: Arial, sans-serif;
                font-size: 14px;
                margin-top: 15px;
            }

                /* Header styling */
                .employee-grid th {
                    background: linear-gradient(90deg, #4b49ac, #6c63ff);
                    color: #fff;
                    padding: 10px;
                    text-align: left;
                    border: 1px solid #ddd;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
                }

                /* Table cell styling */
                .employee-grid td {
                    padding: 10px;
                    border: 1px solid #ddd;
                    vertical-align: middle;
                }

                /* Employee image */
                .employee-grid .emp-image {
                    width: 50px;
                    height: 50px;
                    border-radius: 50%; /* circular profile */
                    object-fit: cover;
                    border: 2px solid #007BFF;
                }

                /* Alternating row background */
                .employee-grid tr:nth-child(even) {
                    background-color: #f9f9f9;
                }

                .employee-grid tr:nth-child(odd) {
                    background-color: #ffffff;
                }

                /* Hover effect */
                .employee-grid tr:hover {
                    background-color: #f1f1f1;
                    transition: 0.3s;
                }
        </style>
    </head>
    <body>
        <header>
            <h1>Employee Management Dashboard</h1>
        </header>
        <nav>
            <a href="dashboard.aspx">Dashboard</a> <a href="employees.aspx">Employees</a> <a href="departments.aspx">Departments</a> <a href="salary.aspx">Salary</a> <a href="leave.aspx">Leave</a> <a href="overview.aspx">Employee Overview</a> <a href="logout.aspx">Logout</a>
        </nav>
</asp:Content>


