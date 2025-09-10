<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="employees.aspx.cs" Inherits="EMPS_PORTAL.Admin.employees" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="main">
        <a class="btn" href="#">+ Add Employee</a>
        <div class="card">
            <h2>Employee List</h2>
            <table border="1" width="100%" cellpadding="10">
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
            </table>
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
    </head>
    <body>
        <header>
            <h1>Employee Management Dashboard</h1>
        </header>
        <nav>
            <a href="dashboard.aspx">Dashboard</a> <a href="employees.aspx">Employees</a> <a href="departments.aspx">Departments</a> <a href="salary.aspx">Salary</a> <a href="leave.aspx">Leave</a> <a href="overview.aspx">Employee Overview</a> <a href="logout.aspx">Logout</a>
        </nav>
</asp:Content>


