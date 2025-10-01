<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="leave.aspx.cs" Inherits="EMPS_PORTAL.Admin.leave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <div class="card">
            <h2>Leave Records</h2>
            <%--<table border="1" width="100%" cellpadding="10"
                style="border-collapse: collapse; font-family: Arial, sans-serif; text-align: center;">
                <tr style="background-color: #4CAF50; color: white;">
                    <th style="padding: 10px; border: 1px solid #333;">Employee</th>
                    <th style="padding: 10px; border: 1px solid #333;">Department</th>
                    <th style="padding: 10px; border: 1px solid #333;">Type</th>
                    <th style="padding: 10px; border: 1px solid #333;">Status</th>
                    <th style="padding: 10px; border: 1px solid #333;">Action</th>
                </tr>
                <tr style="background-color: #f9f9f9;">
                    <td style="padding: 10px; border: 1px solid #333;">Riya Sharma</td>
                    <td style="padding: 10px; border: 1px solid #333;">HR</td>
                    <td style="padding: 10px; border: 1px solid #333;">Sick Leave</td>
                    <td style="padding: 10px; border: 1px solid #333; color: green; font-weight: bold;">Approve</td>
                    <td style="padding: 10px; border: 1px solid #333;">
                        <button style="background-color: green; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Approve</button>
                        <button style="background-color: red; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Reject</button>
                        <button style="background-color: #2196F3; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">View</button>
                    </td>
                </tr>
                <tr style="background-color: #fff;">
                    <td style="padding: 10px; border: 1px solid #333;">Aman Verma</td>
                    <td style="padding: 10px; border: 1px solid #333;">IT</td>
                    <td style="padding: 10px; border: 1px solid #333;">Annual Leave</td>
                    <td style="padding: 10px; border: 1px solid #333; color: red; font-weight: bold;">Reject</td>
                    <td style="padding: 10px; border: 1px solid #333;">
                        <button style="background-color: green; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Approve</button>
                        <button style="background-color: red; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Reject</button>
                        <button style="background-color: #2196F3; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">View</button>
                    </td>
                </tr>
            </table>--%>

            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                CssClass="styled-grid"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged"
                OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Id">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EmployeeId">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Empid") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Leave Type">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="StartingDate">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("S_date") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EndingDate">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("E_date") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reson">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Reson") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandName="apr"
                                CommandArgument='<%# Eval("Id") %>' CssClass="btn-approve">Approve</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CommandName="rej"
                                Text="Reject" CommandArgument='<%# Eval("Id") %>' CssClass="btn-reject"></asp:LinkButton>
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
            /* Grid styling */
            .styled-grid {
                width: 100%;
                border-collapse: collapse;
                font-family: Arial, sans-serif;
                margin-top: 15px;
                background-color: #f9f9f9;
            }

                .styled-grid th {
                    background: linear-gradient(90deg, #4b49ac, #6c63ff);
                    color: white;
                    padding: 10px;
                    text-align: center;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.2);
                }

                .styled-grid td {
                    border: 1px solid #ddd;
                    padding: 8px;
                    text-align: center;
                }

                .styled-grid tr:nth-child(even) {
                    background-color: #f2f2f2;
                }

                .styled-grid tr:hover {
                    background-color: #e6ffe6;
                }

            /* Buttons */
            .btn-approve {
                color: white;
                background-color: #28a745;
                padding: 5px 10px;
                border-radius: 4px;
                text-decoration: none;
            }

                .btn-approve:hover {
                    background-color: #218838;
                }

            .btn-reject {
                color: white;
                background-color: #dc3545;
                padding: 5px 10px;
                border-radius: 4px;
                text-decoration: none;
            }

                .btn-reject:hover {
                    background-color: #c82333;
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


