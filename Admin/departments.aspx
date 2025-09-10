<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Site2.Master" AutoEventWireup="true" CodeBehind="departments.aspx.cs" Inherits="EMPS_PORTAL.Admin.departments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <div class="main">
    <a class="btn" href="#">+ Add Department</a>
    <div class="card">
      <h2>Departments List</h2>
      <ul>
        <li>HR</li>
        <li>IT</li>
        <li>Finance</li>
        <li>Marketing</li>
      </ul>
    </div>
  </div>
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8"><title>Admin Dashboard</title>
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


