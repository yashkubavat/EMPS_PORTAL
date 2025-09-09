<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="settings.aspx.cs" Inherits="EMPS_PORTAL.settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <main class="main-content app">
        <div class="content-wrapper">
            <!-- Settings Section -->
            <section class="content-section active" id="settingsSection">
                <div class="section-header">
                    <h2>Settings</h2>
                </div>

                <div class="settings-content">
                    <!-- <div class="settings-card">
                        <h3>Appearance</h3>
                        <div class="setting-item">
                            <div class="setting-info">
                                <label>Theme</label>
                                <p>Choose your preferred theme</p>
                            </div>
                            <div class="theme-toggle">
                                <button class="theme-btn active" data-theme="light">
                                    <i class="fas fa-sun"></i>
                                    Light
                                </button>
                                <button class="theme-btn" data-theme="dark">
                                    <i class="fas fa-moon"></i>
                                    Dark
                                </button>
                            </div>
                        </div>
                    </div> -->

                    <div class="settings-card">
                        <h3>Notifications</h3>
                        <div class="setting-item">
                            <div class="setting-info">
                                <label>Email Notifications</label>
                                <p>Receive updates via email</p>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" id="emailNotifications" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                        <div class="setting-item">
                            <div class="setting-info">
                                <label>Task Reminders</label>
                                <p>Get reminded about pending tasks</p>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" id="taskReminders" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <!DOCTYPE html>
                <html>
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Employee User Panel</title>
                    <link rel="stylesheet" href="css/style-emp.css">
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                                        Software Engineer</p>
                                    <p id="sidebarUserDept">
                                        Engineering Department</p>
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


