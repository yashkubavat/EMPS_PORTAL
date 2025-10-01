<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="salary.aspx.cs" Inherits="EMPS_PORTAL.Admin.salary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <asp:Button ID="Button1" class="btn" runat="server" Text="Pay Salary" OnClick="Button1_Click" />
        <div class="card">
            <h2>Salary Records</h2>
            <%--<table border="1" width="100%" cellpadding="10">
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
            </table>--%>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="custom-grid">
                <Columns>
                    <asp:TemplateField HeaderText="Id">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Employee Name">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("E_Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Employee Id">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("E_Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Department">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("E_Department") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Periode">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Pay_Period") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Date">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Pay_Date") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Bassic Salary">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("Bassic_Salary") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="HA">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("HA") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Other earning">
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("Other_Ern") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Leave Deduction">
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("Leave_Deduction") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Net Pay">
                        <ItemTemplate>
                            <asp:Label ID="Label11" runat="server" Text='<%# Eval("Net_Pay") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Method">
                        <ItemTemplate>
                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("Pay_Method") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Pay Details">
                        <ItemTemplate>
                            <asp:Label ID="Label13" runat="server" Text='<%# Eval("Pay_Details") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
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
        <style>
            /* GridView Style */
            .custom-grid {
                width: 100%;
                border-collapse: collapse;
                font-family: Arial, sans-serif;
                font-size: 14px;
                margin-top: 15px;
            }

                .custom-grid th {
                    background: linear-gradient(90deg, #4b49ac, #6c63ff);
                    color: white;
                    padding: 10px;
                    border: 1px solid #ddd;
                    text-align: left;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
                }

                .custom-grid td {
                    padding: 8px;
                    border: 1px solid #ddd;
                }

                .custom-grid tr:nth-child(even) {
                    background-color: #f9f9f9;
                }

                .custom-grid tr:nth-child(odd) {
                    background-color: #ffffff;
                }

                .custom-grid tr:hover {
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

