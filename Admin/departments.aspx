<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="departments.aspx.cs" Inherits="EMPS_PORTAL.Admin.departments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <%--<a class="btn" href="#">+ Add Department</a>--%>
        <div class="card">
            <h2>Add Departments</h2>
            <form style="display: grid; grid-template-columns: repeat(auto-fit,minmax(280px,1fr)); gap: 15px; margin-top: 15px;">
                <div class="form-group" style="display: flex; flex-direction: column;">
                    <label for="deptName" style="font-weight: bold; margin-bottom: 6px; font-size: 0.9rem;">Department Name *</label>
                    <%--<input type="text" id="deptName" placeholder="e.g., Human Resources" required
                        <%--style="padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 0.95rem;">--%>
                    <asp:TextBox ID="txtdpt" Style="padding: 10px; border: 1px solid #ccc; border-radius: 6px; font-size: 0.95rem;" runat="server"></asp:TextBox>
                </div>
                <br />
                <%--<button type="submit" class="btn-primary"
                    style="padding: 10px 16px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; font-size: 0.95rem; background: #4f46e5; color: #fff;">
                    Save Department
                </button>--%>
                <asp:Button ID="Button1" Style="padding: 10px 16px; border: none; border-radius: 6px; font-weight: bold; cursor: pointer; font-size: 0.95rem; background: #4f46e5; color: #fff;" runat="server" Text="Add Department" OnClick="Button1_Click" />
        </div>
        </form>
    </div>
    </div>
    <div class="main">
        <div class="card">
            <h2>Departments List</h2>
            <asp:DataList ID="DataList1" runat="server" RepeatColumns="3" CellPadding="10" CellSpacing="15"
                RepeatDirection="Horizontal"
                Style="display: grid; grid-template-columns: repeat(3,1fr); gap: 20px; padding: 20px;" OnItemCommand="DataList1_ItemCommand" OnSelectedIndexChanged="DataList1_SelectedIndexChanged">
                <ItemTemplate>
                    <div style="background: #fff; border: 1px solid #e5e7eb; border-radius: 10px; padding: 15px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); text-align: center;">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("D_Name") %>'
                            Style="font-weight: bold; font-size: 1rem; color: #4f46e5; display: block; margin-bottom: 10px;"></asp:Label>
                        <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="remove"
                            Style="display: inline-block; background: #ef4444; color: #fff; padding: 8px 14px; border-radius: 6px; text-decoration: none; font-size: 0.9rem; font-weight: bold;">
                Remove
                        </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:DataList>

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


