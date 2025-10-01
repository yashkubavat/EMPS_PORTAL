<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="edit.aspx.cs" Inherits="EMPS_PORTAL.edit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <!DOCTYPE html>
                <html lang="en">
                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Employee Registration</title>
                    <link rel="stylesheet" href="css/style.css">
                    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
                </head>
                <body>
                    <!-- Theme toggle -->
                    <input type="checkbox" id="themeToggle" class="theme-toggle-checkbox">

                    <div class="login-container app">
                        <div class="background-pattern"></div>

                        <!-- Registration Card -->
                        <div class="login-card">
                            <div class="login-header">
                                <div class="company-logo">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <h1>Employee Registration</h1>
                                <p>Create a new employee account</p>
                            </div>

                            <form class="login-form" id="registrationForm">
                                <!-- Full Name -->
                                <div class="form-group">
                                    <label for="fullName">Full Name *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-user input-icon"></i>
                                        <%--<input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>--%>
                                        <asp:TextBox ID="txtun" name="fullName" placeholder="Enter your full name" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <!-- Employee ID -->
                                <!-- <div class="form-group">
            <label for="employeeId">Employee ID *</label>
            <div class="input-wrapper">
                <i class="fas fa-id-card input-icon"></i>
                <input type="text" id="employeeId" name="employeeId" placeholder="Enter your employee ID" required>
            </div>
        </div> -->

                                <!-- Email -->
                                <div class="form-group">
                                    <label for="email">Email *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-envelope input-icon"></i>
                                        <%--<input type="email" id="email" name="email" placeholder="Enter your email" required>--%>
                                        <asp:TextBox ID="txtem" name="email" placeholder="Enter your email" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <!-- Department -->
                                <!-- <div class="form-group">
            <label for="department">Department *</label>
            <div class="input-wrapper">
                <i class="fas fa-briefcase input-icon"></i>
                <input type="text" id="department" name="department" placeholder="Enter department" required>
            </div>
        </div> -->

                                <!-- Password -->
                                <div class="form-group">
                                    <label for="password">Password *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock input-icon"></i>
                                        <%--<input type="password" id="password" name="password" placeholder="Enter password" required>--%>
                                        <asp:TextBox ID="txtpass" name="password" placeholder="Enter password" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <!-- Confirm Password -->
                                <%--<div class="form-group">
                        <label for="confirmPassword">Confirm Password *</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
                        </div>
                    </div>--%>
                                <!-- Department -->
                                <div class="form-group">
                                    <label for="department">Department *</label>
                                    <div class="input-wrapper">
                                        <%--<i class="fas fa-briefcase input-icon"></i>--%>
                                        <%--<input type="text" id="department" name="department" placeholder="Enter department" required>--%>
                                        <asp:DropDownList ID="drctdep" Style="border-radius: 5px; width: max-content; height: 25px;" runat="server" AutoPostBack="True" OnSelectedIndexChanged="drctdep_SelectedIndexChanged">
                                            <asp:ListItem>---Select Department---</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password">Mobile *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-mobile input-icon"></i>
                                        <%--<input type="password" id="password" name="password" placeholder="Enter password" required>--%>
                                        <asp:TextBox ID="txtmo" name="mobile" placeholder="Enter MObile No" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password">City *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-user input-icon"></i>
                                        <%--<input type="password" id="password" name="password" placeholder="Enter password" required>--%>
                                        <asp:TextBox ID="txtct" name="city" placeholder="Enter City" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="password">Gender *</label>
                                    <div class="input-wrapper">
                                        <%--<i class="fas fa-user input-icon"></i>--%>
                                        <%--<input type="password" id="password" name="password" placeholder="Enter password" required>--%>
                                        <asp:RadioButtonList ID="rdbgd" runat="server" RepeatDirection="Horizontal">
                                            <asp:ListItem>Male</asp:ListItem>
                                            <asp:ListItem>Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </div>
                                </div>
                                <%--<div class="form-group">
                        <label for="password">Image *</label>
                        <div class="input-wrapper">
                            <i class="fas fa-image input-icon"></i>--%>
                                <%--<input type="password" id="password" name="password" placeholder="Enter password" required>--%>
                                <%--  <asp:FileUpload ID="fldimg" runat="server" />
                        </div>
                    </div>
                    <p class="checkbox-wrapper">you have account? <a href="login.aspx" class="forgot-password">Login</a></p>
                    <br>--%>
                                <asp:Button ID="Button1" class="login-btn" Style="color: white;" runat="server" Text="Save" OnClick="Button1_Click" />
                                <%--<button type="submit" class="login-btn">
                        <span class="btn-text">Register</span>
                        <span class="btn-loading">
                            <i class="fas fa-spinner fa-spin"></i>Processing...
                        </span>
                    </button>--%>
                            </form>

                            <div class="theme-toggle">
                                <label for="themeToggle" class="theme-toggle-label" title="Toggle dark mode">
                                    <i class="fas fa-sun"></i>
                                    <span>/</span>
                                    <i class="fas fa-moon"></i>
                                </label>
                            </div>
                        </div>

                        <!-- Footer -->
                        <footer class="login-footer">
                            <p>&copy; 2024 Company Name. All rights reserved.</p>
                        </footer>
                    </div>
                </body>
                </html>

            </div>
        </div>
    </form>
</body>
</html>
