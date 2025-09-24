<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="salary.aspx.cs" Inherits="EMPS_PORTAL.salary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <main class="main-content">
        <div class="content-wrapper">
            <!-- Salary Management Section -->
            <section class="content-section active" id="salarySection">
                <div class="section-header">
                    <h2>Salary Management</h2>
                    <div class="salary-actions">
                        <!-- <button class="btn btn-secondary" id="downloadPayslipBtn">
                            <i class="fas fa-download"></i>
                            Download Payslip
                        </button> -->
                        <button class="btn btn-primary" id="viewDetailsBtn">
                            <i class="fas fa-eye"></i>
                            View Details
                        </button>
                    </div>
                </div>

                <!-- Salary Summary -->
                <div class="salary-summary">
                    <div class="summary-card primary">
                        <div class="summary-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Current Salary</h3>
                            <div class="salary-amount">$85,000</div>
                            <p>Annual Gross Salary</p>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Last Pay Date</h3>
                            <div class="pay-date">July 31, 2024</div>
                            <p>Next: August 31, 2024</p>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="summary-content">
                            <h3>YTD Earnings</h3>
                            <div class="ytd-amount">$49,583</div>
                            <p>Year to Date</p>
                        </div>
                    </div>

                    <div class="summary-card">
                        <div class="summary-icon">
                            <i class="fas fa-piggy-bank"></i>
                        </div>
                        <div class="summary-content">
                            <h3>Net Pay</h3>
                            <div class="net-amount">$5,416</div>
                            <p>Monthly Net Salary</p>
                        </div>
                    </div>
                </div>

                <!-- Salary Breakdown -->
                <div class="salary-breakdown">
                    <div class="breakdown-card">
                        <h3>Salary Breakdown</h3>
                        <div class="breakdown-list">
                            <div class="breakdown-item">
                                <span class="item-label">Basic Salary</span>
                                <span class="item-amount">$7,083</span>
                            </div>
                            <div class="breakdown-item">
                                <span class="item-label">Housing Allowance</span>
                                <span class="item-amount">$1,500</span>
                            </div>
                            <div class="breakdown-item">
                                <span class="item-label">Transport Allowance</span>
                                <span class="item-amount">$500</span>
                            </div>
                            <div class="breakdown-item">
                                <span class="item-label">Performance Bonus</span>
                                <span class="item-amount">$917</span>
                            </div>
                            <div class="breakdown-item total">
                                <span class="item-label">Gross Salary</span>
                                <span class="item-amount">$10,000</span>
                            </div>
                        </div>
                    </div>

                    <div class="breakdown-card">
                        <h3>Deductions</h3>
                        <div class="breakdown-list">
                            <div class="breakdown-item deduction">
                                <span class="item-label">Income Tax</span>
                                <span class="item-amount">-$2,500</span>
                            </div>
                            <div class="breakdown-item deduction">
                                <span class="item-label">Social Security</span>
                                <span class="item-amount">-$620</span>
                            </div>
                            <div class="breakdown-item deduction">
                                <span class="item-label">Health Insurance</span>
                                <span class="item-amount">-$300</span>
                            </div>
                            <div class="breakdown-item deduction">
                                <span class="item-label">Retirement Plan</span>
                                <span class="item-amount">-$500</span>
                            </div>
                            <div class="breakdown-item total">
                                <span class="item-label">Total Deductions</span>
                                <span class="item-amount">-$3,920</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Payslip History -->
                <div class="payslip-history">
                    <h3>Payslip History</h3>
                    <div class="payslip-list" id="payslipList">
                        <!-- Payslips will be populated by JavaScript -->
                    </div>
                </div>
            </section>
        </div>
    </main>

    <!-- Salary Details Modal -->
    <div class="modal-overlay" id="salaryDetailsModal">
        <div class="modal large">
            <div class="modal-header">
                <h2>Salary Details - July 2024</h2>
                <button class="modal-close" id="closeSalaryModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="salary-details-content">
                    <div class="detail-section">
                        <h4>Employee Information</h4>
                        <div class="detail-grid">
                            <div class="detail-item">
                                <label>Employee ID:</label>
                                <span>EMP001</span>
                            </div>
                            <div class="detail-item">
                                <label>Name:</label>
                                <span>John Smith</span>
                            </div>
                            <div class="detail-item">
                                <label>Department:</label>
                                <span>Engineering</span>
                            </div>
                            <div class="detail-item">
                                <label>Position:</label>
                                <span>Software Engineer</span>
                            </div>
                            <div class="detail-item">
                                <label>Pay Period:</label>
                                <span>July 1 - July 31, 2024</span>
                            </div>
                            <div class="detail-item">
                                <label>Pay Date:</label>
                                <span>July 31, 2024</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h4>Earnings</h4>
                        <div class="detail-table">
                            <div class="table-header">
                                <span>Description</span>
                                <span>Amount</span>
                            </div>
                            <div class="table-row">
                                <span>Basic Salary</span>
                                <span>$7,083.33</span>
                            </div>
                            <div class="table-row">
                                <span>Housing Allowance</span>
                                <span>$1,500.00</span>
                            </div>
                            <div class="table-row">
                                <span>Transport Allowance</span>
                                <span>$500.00</span>
                            </div>
                            <div class="table-row">
                                <span>Performance Bonus</span>
                                <span>$916.67</span>
                            </div>
                            <div class="table-row total">
                                <span>Total Earnings</span>
                                <span>$10,000.00</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h4>Deductions</h4>
                        <div class="detail-table">
                            <div class="table-header">
                                <span>Description</span>
                                <span>Amount</span>
                            </div>
                            <div class="table-row deduction">
                                <span>Income Tax</span>
                                <span>-$2,500.00</span>
                            </div>
                            <div class="table-row deduction">
                                <span>Social Security</span>
                                <span>-$620.00</span>
                            </div>
                            <div class="table-row deduction">
                                <span>Health Insurance</span>
                                <span>-$300.00</span>
                            </div>
                            <div class="table-row deduction">
                                <span>Retirement Plan</span>
                                <span>-$500.00</span>
                            </div>
                            <div class="table-row total">
                                <span>Total Deductions</span>
                                <span>-$3,920.00</span>
                            </div>
                        </div>
                    </div>

                    <div class="detail-section">
                        <h4>Summary</h4>
                        <div class="summary-table">
                            <div class="summary-row">
                                <span>Gross Pay</span>
                                <span>$10,000.00</span>
                            </div>
                            <div class="summary-row">
                                <span>Total Deductions</span>
                                <span>-$3,920.00</span>
                            </div>
                            <div class="summary-row final">
                                <span>Net Pay</span>
                                <span>$6,080.00</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Employee User Panel</title>
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
                    <span id="headerUserName">Welcome,
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label></span> <i class="fas fa-user-circle"></i>
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
                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Department") %>'></asp:Label>
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


