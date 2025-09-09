<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="EMPS_PORTAL.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!DOCTYPE html>
            <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Employee Login</title>
                <link rel="stylesheet" href="css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            </head>
            <body>
                <!-- CSS-only theme toggle checkbox -->
                <input type="checkbox" id="themeToggle" class="theme-toggle-checkbox">

                <div class="login-container app">
                    <!-- Background Pattern -->
                    <div class="background-pattern"></div>

                    <!-- Login Card -->
                    <div class="login-card">
                        <!-- Company Logo/Header -->
                        <div class="login-header">
                            <div class="company-logo">
                                <i class="fas fa-building"></i>
                            </div>
                            <h1>Employee Login</h1>
                            <p>Welcome back! Please sign in to your account.</p>
                        </div>

                        <!-- Login Form -->
                        <form class="login-form" id="loginForm">
                            <div class="form-group">
                                <label for="emailOrId">Email or Employee ID *</label>
                                <div class="input-wrapper">
                                    <i class="fas fa-user input-icon"></i>
                                    <%--<input
                                        type="text"
                                        id="emailOrId"
                                        name="emailOrId"
                                        placeholder="Enter your email or employee ID"
                                        required>
                                </div>--%>
                                    <asp:TextBox ID="txtun" name="emailOrId"
                                        placeholder="Enter your email" runat="server"></asp:TextBox>
                                    <span class="error-message" id="emailOrIdError"></span>
                                </div>

                                <div class="form-group">
                                    <label for="password">Password *</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock input-icon"></i>
                                        <%--<input
                                        type="password"
                                        id="password"
                                        name="password"
                                        placeholder="Enter your password"
                                        required>--%>
                                        <asp:TextBox ID="txtpass" name="password"
                                            placeholder="Enter your password" runat="server"></asp:TextBox>
                                        <button type="button" class="password-toggle" id="passwordToggle">
                                            <i class="fas fa-eye"></i>
                                        </button>

                                    </div>
                                    <span class="error-message" id="passwordError"></span>
                                </div>

                                <div class="form-options">
                                    <%--<label class="checkbox-wrapper">
                                        <input type="checkbox" id="rememberMe" name="rememberMe">
                                        <span class="checkmark"></span>
                                        Remember me
                                    </label>
                                    <a href="#forgot-password" class="forgot-password">Forgot Password?</a><br>--%>
                                    <p class="checkbox-wrapper">you don't have account? <a href="registration.aspx" class="forgot-password">Register</a></p>
                                </div>

                                <%--<button type="submit" class="login-btn" id="loginBtn">--%>
                                <asp:Button ID="Button1" class="login-btn" style="color:white;" runat="server" Text="Login" OnClick="Button1_Click" />
                               <%-- <span class="btn-text">Sign In</span>
                                <span class="btn-loading">
                                    <i class="fas fa-spinner fa-spin"></i>
                                    Signing in...
                                </span>
                            </button>--%>
                        </form>

                        <!-- Demo Credentials -->
                        <!-- <div class="demo-credentials">
                <h4>Demo Credentials:</h4>
                <div class="credential-item">
                    <strong>Email:</strong> john.smith@company.com
                </div>
                <div class="credential-item">
                    <strong>Password:</strong> password123
                </div>
            </div> -->

                        <!-- Theme Toggle -->
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
                        <div class="footer-links">
                            <a href="#privacy">Privacy Policy</a>
                            <a href="#terms">Terms of Service</a>
                            <a href="#support">Support</a>
                        </div>
                    </footer>
                </div>

                <!-- Success Modal -->
                <!-- <div class="modal-overlay" id="successModal">
        <div class="modal">
            <div class="modal-header">
                <h2>Login Successful!</h2>
                <button class="modal-close" id="closeModal">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="success-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <p>Welcome back, <span id="userName">John Smith</span>!</p>
                <p>You have successfully logged into your employee account.</p>
                <div class="modal-actions">
                    <button class="btn btn-primary" id="goToDashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        Go to Dashboard
                    </button>
                    <button class="btn btn-secondary" id="stayHere">
                        Stay Here
                    </button>
                </div>
            </div>
        </div>
    </div> -->

                <!-- No JavaScript: CSS-only theme and UI -->
            </body>
            </html>
        </div>
    </form>
</body>
</html>
