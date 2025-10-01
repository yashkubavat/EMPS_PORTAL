<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="overview.aspx.cs" Inherits="EMPS_PORTAL.Admin.overview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <div class="card">
            <h2>Employee OverView</h2>
            <%--<form>
                <input type="text" placeholder="Full Name"><br>
                <br>
                <input type="text" placeholder="Department"><br>
                <br>
                <input type="number" placeholder="Salary"><br>
                <br>
                <button class="btn">Add Employee</button>
            </form>--%>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="employee-grid">
                <Columns>
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("Image") %>' CssClass="emp-image" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Id">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
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
                    <asp:TemplateField HeaderText="Salary">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("Net_pay") %>'></asp:Label>
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
            /* GridView Container */
            .employee-grid {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                font-family: Arial, sans-serif;
                font-size: 14px;
                text-align: center;
                background-color: #f9f9f9;
                box-shadow: 0px 2px 10px rgba(0,0,0,0.1);
            }

                /* Table Header */
                .employee-grid th {
                    background: linear-gradient(90deg, #4b49ac, #6c63ff);
                    color: white;
                    padding: 12px;
                    text-transform: uppercase;
                    font-weight: bold;
                    border: 1px solid #ddd;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
                }

                /* Table Rows */
                .employee-grid td {
                    padding: 10px;
                    border: 1px solid #ddd;
                    color: #333;
                }

                /* Alternate Row Color */
                .employee-grid tr:nth-child(even) {
                    background-color: #f2f2f2;
                }

                /* Hover Effect */
                .employee-grid tr:hover {
                    background-color: #eaf4ff;
                    cursor: pointer;
                    transition: 0.3s;
                }

            /* Employee Image */
            .emp-image {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 50%;
                border: 2px solid #007BFF;
                box-shadow: 0px 2px 6px rgba(0,0,0,0.2);
            }

            /* Salary Highlight */
            .employee-grid td:last-child {
                font-weight: bold;
                color: #28a745;
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


