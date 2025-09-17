<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="leave.aspx.cs" Inherits="EMPS_PORTAL.leave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <main class="main-content">
        <div class="content-wrapper">
            <!-- Leave Management Section -->
            <section class="content-section active" id="leaveSection">
                <div class="section-header">
                    <h2>Leave Management</h2>
                    <%--<button class="btn btn-primary" id="requestLeaveBtn">
                        <i class="fas fa-plus"></i>
                        Request Leave
                    </button>--%>
                    <%--<i class="fas fa-plus"></i>--%>
                    <asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Request Leave" OnClientClick="Button1_Click" OnClick="Button1_Click1" />
                </div>

                <!-- Leave Balance Summary -->
                <div class="leave-summary">
                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-calendar-day"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Annual Leave</h3>
                            <div class="balance-info">
                                <span class="balance-used">15 used</span>
                                <span class="balance-remaining">10 remaining</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 60%"></div>
                            </div>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-heartbeat"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Sick Leave</h3>
                            <div class="balance-info">
                                <span class="balance-used">3 used</span>
                                <span class="balance-remaining">7 remaining</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 30%"></div>
                            </div>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-briefcase"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Personal Leave</h3>
                            <div class="balance-info">
                                <span class="balance-used">2 used</span>
                                <span class="balance-remaining">3 remaining</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: 40%"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Leave History -->
                <div class="leave-content">
                    <div class="leave-history">
                        <h3>Leave History</h3>
                        <div class="leave-list" id="leaveList">
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                                CssClass="white-grid"
                                OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="Leave Type">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <!-- Leave items will be populated by JavaScript -->
                        </div>
                    </div>

                    <!-- Upcoming Leaves -->
                   <%-- <div class="upcoming-leaves">
                        <h3>Leaves</h3>
                        <div class="upcoming-list" id="upcomingList">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
                                CssClass="white-grid"
                                OnRowCommand="GridView1_RowCommand">
                                <Columns>
                                    <asp:TemplateField HeaderText="Leave Type">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("Type") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <!-- Upcoming leaves will be populated by JavaScript -->
                        </div>
                    </div>--%>
                </div>
            </section>
        </div>
    </main>

</asp:Content>
<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employee User Panel</title>
        <link rel="stylesheet" href="css/style-emp.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            /* White theme for GridView */
            .white-grid {
                width: 100%;
                border-collapse: collapse;
                font-family: Arial, sans-serif;
                background-color: #ffffff;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                margin-top: 15px;
            }

                .white-grid th {
                    background-color: lightseagreen;
                    color: white;
                    padding: 10px;
                    text-align: center;
                    border: 1px solid #ddd;
                    font-weight: bold;
                }

                .white-grid td {
                    border: 1px solid #ddd;
                    padding: 8px;
                    text-align: center;
                    color: #444;
                }

                .white-grid tr:nth-child(even) {
                    background-color: #fafafa;
                }

                .white-grid tr:hover {
                    background-color: #f5f5f5;
                }
        </style>

    </head>
    <body>
        <!-- CSS-only theme toggle checkbox -->
        <input type="checkbox" id="themeToggle" class="theme-toggle-checkbox">

        <!-- Header -->
        <header class="header">
            <div class="header-left">
                <button class="hamburger-btn" id="hamburgerBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="logo">
                    <i class="fas fa-user-circle"></i>
                    <h1>Employee Portal</h1>
                </div>
            </div>
            <div class="header-right">
                <div class="user-info">
                    <span id="headerUserName">Welcome, John</span> <i class="fas fa-user-circle"></i>
                </div>
                <label for="themeToggle" class="theme-toggle-label" title="Toggle dark mode">
                    <i class="fas fa-sun"></i><span>/</span> <i class="fas fa-moon"></i>
                </label>
            </div>
        </header>

        <!-- Sidebar -->
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="user-profile">
                    <div class="profile-picture" id="profilePicture">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="user-details">
                        <h3 id="sidebarUserName">John Smith</h3>
                        <p id="sidebarUserRole">
                            Software Engineer
                        </p>
                        <p id="sidebarUserDept">
                            Engineering Department
                        </p>
                    </div>
                </div>
            </div>
            <nav class="sidebar-nav">
                <ul>
                    <li class="nav-item active"><a href="employee.aspx" class="nav-link" data-section="profile"><i class="fas fa-user"></i><span>My Profile</span> </a>
                    </li>
                    <!-- <li class="nav-item">
                    <a href="attendance.html" class="nav-link">
                        <i class="fas fa-calendar-check"></i>
                        <span>Attendance</span>
                    </a>
                </li> -->
                    <li class="nav-item"><a href="leave.aspx" class="nav-link"><i class="fas fa-calendar-plus"></i><span>Leave Management</span> </a></li>
                    <li class="nav-item"><a href="salary.aspx" class="nav-link"><i class="fas fa-money-bill-wave"></i><span>Salary</span> </a>
                    </li>
                    <!-- <li class="nav-item">
                    <a href="tasks.html" class="nav-link">
                        <i class="fas fa-tasks"></i>
                        <span>Tasks</span>
                        <span class="badge" id="taskBadge">3</span>
                    </a>
                </li> -->
                    <li class="nav-item"><a href="settings.aspx" class="nav-link"><i class="fas fa-cog"></i><span>Settings</span> </a>
                    </li>
                    <!-- <li class="nav-item">
                    <a href="#password" class="nav-link" data-section="password">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </a>
                </li> -->
                    <li class="nav-item"><a href="logout.aspx" class="nav-link" id="logoutBtn"><i class="fas fa-sign-out-alt"></i><span>Logout</span> </a></li>
                </ul>
            </nav>
        </aside>
</asp:Content>


