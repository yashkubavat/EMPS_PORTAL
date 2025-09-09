// Employee Login Page JavaScript

class EmployeeLogin {
    constructor() {
        this.settings = this.loadSettings();
        this.initializeElements();
        this.bindEvents();
        this.applyTheme();
        this.loadRememberedCredentials();
    }

    // Initialize DOM elements
    initializeElements() {
        // Form elements
        this.loginForm = document.getElementById('loginForm');
        this.emailOrIdInput = document.getElementById('emailOrId');
        this.passwordInput = document.getElementById('password');
        this.rememberMeCheckbox = document.getElementById('rememberMe');
        this.loginBtn = document.getElementById('loginBtn');
        
        // Password toggle
        this.passwordToggle = document.getElementById('passwordToggle');
        
        // Theme toggle
        this.themeBtns = document.querySelectorAll('.theme-btn');
        
        // Modal elements
        this.successModal = document.getElementById('successModal');
        this.closeModal = document.getElementById('closeModal');
        this.goToDashboard = document.getElementById('goToDashboard');
        this.stayHere = document.getElementById('stayHere');
        
        // Error message elements
        this.emailOrIdError = document.getElementById('emailOrIdError');
        this.passwordError = document.getElementById('passwordError');
    }

    // Bind event listeners
    bindEvents() {
        // Form submission
        this.loginForm.addEventListener('submit', (e) => this.handleLogin(e));
        
        // Password toggle
        this.passwordToggle.addEventListener('click', () => this.togglePassword());
        
        // Theme switching
        this.themeBtns.forEach(btn => {
            btn.addEventListener('click', () => this.changeTheme(btn.dataset.theme));
        });
        
        // Modal events
        this.closeModal.addEventListener('click', () => this.closeSuccessModal());
        this.successModal.addEventListener('click', (e) => {
            if (e.target === this.successModal) this.closeSuccessModal();
        });
        
        this.goToDashboard.addEventListener('click', () => this.goToDashboardAction());
        this.stayHere.addEventListener('click', () => this.closeSuccessModal());
        
        // Real-time validation
        this.emailOrIdInput.addEventListener('input', () => this.validateEmailOrId());
        this.passwordInput.addEventListener('input', () => this.validatePassword());
        
        // Remember me functionality
        this.rememberMeCheckbox.addEventListener('change', () => this.saveSettings());
    }

    // Login handling
    handleLogin(e) {
        e.preventDefault();
        
        // Clear previous errors
        this.clearErrors();
        
        // Validate form
        const isEmailOrIdValid = this.validateEmailOrId();
        const isPasswordValid = this.validatePassword();
        
        if (isEmailOrIdValid && isPasswordValid) {
            this.performLogin();
        }
    }

    performLogin() {
        // Show loading state
        this.setLoadingState(true);
        
        // Simulate API call delay
        setTimeout(() => {
            const emailOrId = this.emailOrIdInput.value.trim();
            const password = this.passwordInput.value;
            
            // Mock authentication (in real app, this would be an API call)
            if (this.authenticateUser(emailOrId, password)) {
                // Save credentials if "Remember me" is checked
                if (this.rememberMeCheckbox.checked) {
                    this.saveCredentials(emailOrId, password);
                } else {
                    this.clearSavedCredentials();
                }
                
                // Show success modal
                this.showSuccessModal(emailOrId);
            } else {
                this.showError('Invalid email/ID or password. Please try again.');
            }
            
            this.setLoadingState(false);
        }, 1500);
    }

    authenticateUser(emailOrId, password) {
        // Mock authentication logic
        const validCredentials = [
            { email: 'john.smith@company.com', password: 'password123', name: 'John Smith' },
            { email: 'sarah.johnson@company.com', password: 'password123', name: 'Sarah Johnson' },
            { email: 'michael.brown@company.com', password: 'password123', name: 'Michael Brown' },
            { id: 'EMP001', password: 'password123', name: 'John Smith' },
            { id: 'EMP002', password: 'password123', name: 'Sarah Johnson' },
            { id: 'EMP003', password: 'password123', name: 'Michael Brown' }
        ];
        
        return validCredentials.some(cred => 
            (cred.email && cred.email.toLowerCase() === emailOrId.toLowerCase() && cred.password === password) ||
            (cred.id && cred.id.toLowerCase() === emailOrId.toLowerCase() && cred.password === password)
        );
    }

    getUserName(emailOrId) {
        const userMap = {
            'john.smith@company.com': 'John Smith',
            'sarah.johnson@company.com': 'Sarah Johnson',
            'michael.brown@company.com': 'Michael Brown',
            'emp001': 'John Smith',
            'emp002': 'Sarah Johnson',
            'emp003': 'Michael Brown'
        };
        
        return userMap[emailOrId.toLowerCase()] || 'User';
    }

    // Form validation
    validateEmailOrId() {
        const value = this.emailOrIdInput.value.trim();
        
        if (!value) {
            this.showFieldError(this.emailOrIdError, 'Email or Employee ID is required');
            return false;
        }
        
        // Check if it's an email or employee ID
        const isEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value);
        const isEmployeeId = /^EMP\d{3,}$/i.test(value);
        
        if (!isEmail && !isEmployeeId) {
            this.showFieldError(this.emailOrIdError, 'Please enter a valid email or employee ID (e.g., EMP001)');
            return false;
        }
        
        this.clearFieldError(this.emailOrIdError);
        return true;
    }

    validatePassword() {
        const value = this.passwordInput.value;
        
        if (!value) {
            this.showFieldError(this.passwordError, 'Password is required');
            return false;
        }
        
        if (value.length < 6) {
            this.showFieldError(this.passwordError, 'Password must be at least 6 characters');
            return false;
        }
        
        this.clearFieldError(this.passwordError);
        return true;
    }

    // Password toggle functionality
    togglePassword() {
        const type = this.passwordInput.type === 'password' ? 'text' : 'password';
        this.passwordInput.type = type;
        
        const icon = this.passwordToggle.querySelector('i');
        icon.className = type === 'password' ? 'fas fa-eye' : 'fas fa-eye-slash';
        
        // Update aria-label for accessibility
        this.passwordToggle.setAttribute('aria-label', 
            type === 'password' ? 'Show password' : 'Hide password'
        );
    }

    // Theme switching
    changeTheme(theme) {
        // Use theme manager to change theme
        if (window.themeManager) {
            window.themeManager.setTheme(theme);
        } else {
            // Fallback for when theme manager is not loaded
            this.settings.theme = theme;
            this.saveSettings();
            this.applyTheme();
        }
        
        // Update theme buttons
        this.themeBtns.forEach(btn => {
            btn.classList.remove('active');
            if (btn.dataset.theme === theme) {
                btn.classList.add('active');
            }
        });
    }

    applyTheme() {
        // Use theme manager if available, otherwise fallback to data-theme
        if (window.themeManager) {
            const currentTheme = window.themeManager.getCurrentTheme();
            if (currentTheme === 'dark') {
                document.body.classList.add('dark-theme');
            } else {
                document.body.classList.remove('dark-theme');
            }
        } else {
            document.documentElement.setAttribute('data-theme', this.settings.theme);
        }
    }

    // Loading state management
    setLoadingState(isLoading) {
        if (isLoading) {
            this.loginBtn.classList.add('loading');
            this.loginBtn.disabled = true;
        } else {
            this.loginBtn.classList.remove('loading');
            this.loginBtn.disabled = false;
        }
    }

    // Success modal
    showSuccessModal(emailOrId) {
        const userName = this.getUserName(emailOrId);
        document.getElementById('userName').textContent = userName;
        this.successModal.classList.add('active');
    }

    closeSuccessModal() {
        this.successModal.classList.remove('active');
    }

    goToDashboardAction() {
        // In a real app, this would redirect to the dashboard
        alert('Redirecting to Employee Dashboard...');
        window.location.href = 'employee.html';
        this.closeSuccessModal();
        
        // For demo purposes, you could redirect to the employee panel
        // window.location.href = 'employee.html';
    }

    // Error handling
    showFieldError(element, message) {
        element.textContent = message;
        element.style.display = 'block';
    }

    clearFieldError(element) {
        element.textContent = '';
        element.style.display = 'none';
    }

    clearErrors() {
        this.clearFieldError(this.emailOrIdError);
        this.clearFieldError(this.passwordError);
    }

    showError(message) {
        // Create a temporary error notification
        const notification = document.createElement('div');
        notification.className = 'error-notification';
        notification.innerHTML = `
            <i class="fas fa-exclamation-circle"></i>
            <span>${message}</span>
        `;
        
        // Add styles
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: var(--danger-color);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            z-index: 3000;
            transform: translateX(100%);
            transition: transform 0.3s ease;
            max-width: 400px;
            font-size: 0.875rem;
        `;
        
        document.body.appendChild(notification);
        
        // Animate in
        setTimeout(() => {
            notification.style.transform = 'translateX(0)';
        }, 100);
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => {
                if (document.body.contains(notification)) {
                    document.body.removeChild(notification);
                }
            }, 300);
        }, 5000);
    }

    // Remember me functionality
    saveCredentials(emailOrId, password) {
        const credentials = {
            emailOrId: emailOrId,
            password: password,
            timestamp: Date.now()
        };
        localStorage.setItem('rememberedCredentials', JSON.stringify(credentials));
    }

    clearSavedCredentials() {
        localStorage.removeItem('rememberedCredentials');
    }

    loadRememberedCredentials() {
        const saved = localStorage.getItem('rememberedCredentials');
        if (saved) {
            try {
                const credentials = JSON.parse(saved);
                const isExpired = Date.now() - credentials.timestamp > 30 * 24 * 60 * 60 * 1000; // 30 days
                
                if (!isExpired) {
                    this.emailOrIdInput.value = credentials.emailOrId;
                    this.passwordInput.value = credentials.password;
                    this.rememberMeCheckbox.checked = true;
                } else {
                    this.clearSavedCredentials();
                }
            } catch (error) {
                this.clearSavedCredentials();
            }
        }
    }

    // Settings management
    saveSettings() {
        this.settings.rememberMe = this.rememberMeCheckbox.checked;
        localStorage.setItem('loginSettings', JSON.stringify(this.settings));
    }

    loadSettings() {
        const saved = localStorage.getItem('loginSettings');
        if (saved) {
            try {
                return JSON.parse(saved);
            } catch (error) {
                console.error('Error loading settings:', error);
            }
        }
        
        return {
            theme: 'light',
            rememberMe: false
        };
    }

    // Utility functions
    showNotification(message, type = 'info') {
        // Create notification element
        const notification = document.createElement('div');
        notification.className = `notification notification-${type}`;
        notification.innerHTML = `
            <i class="fas fa-${type === 'success' ? 'check-circle' : 'info-circle'}"></i>
            <span>${message}</span>
            <button class="notification-close">
                <i class="fas fa-times"></i>
            </button>
        `;
        
        // Add styles
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: ${type === 'success' ? '#10b981' : '#3b82f6'};
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
            z-index: 3000;
            transform: translateX(100%);
            transition: transform 0.3s ease;
            max-width: 400px;
        `;
        
        document.body.appendChild(notification);
        
        // Animate in
        setTimeout(() => {
            notification.style.transform = 'translateX(0)';
        }, 100);
        
        // Close button functionality
        const closeBtn = notification.querySelector('.notification-close');
        closeBtn.addEventListener('click', () => {
            notification.style.transform = 'translateX(100%)';
            setTimeout(() => {
                document.body.removeChild(notification);
            }, 300);
        });
        
        // Auto remove after 5 seconds
        setTimeout(() => {
            if (document.body.contains(notification)) {
                notification.style.transform = 'translateX(100%)';
                setTimeout(() => {
                    if (document.body.contains(notification)) {
                        document.body.removeChild(notification);
                    }
                }, 300);
            }
        }, 5000);
    }
}

// Initialize the application
let employeeLogin;
document.addEventListener('DOMContentLoaded', () => {
    employeeLogin = new EmployeeLogin();
});

// Handle keyboard shortcuts
document.addEventListener('keydown', (e) => {
    // Ctrl/Cmd + Enter to submit form
    if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.dispatchEvent(new Event('submit'));
        }
    }
    
    // Escape to close modal
    if (e.key === 'Escape') {
        const successModal = document.getElementById('successModal');
        if (successModal && successModal.classList.contains('active')) {
            employeeLogin.closeSuccessModal();
        }
    }
});

// Handle form auto-fill detection
document.addEventListener('animationstart', (e) => {
    if (e.animationName === 'onAutoFillStart') {
        // Handle autofill start
        console.log('Autofill started');
    }
});

document.addEventListener('animationend', (e) => {
    if (e.animationName === 'onAutoFillCancel') {
        // Handle autofill end
        console.log('Autofill ended');
    }
});

// Add CSS for autofill detection
const style = document.createElement('style');
style.textContent = `
    @keyframes onAutoFillStart {
        from {/**/}
        to {/**/}
    }
    
    @keyframes onAutoFillCancel {
        from {/**/}
        to {/**/}
    }
    
    input:-webkit-autofill {
        animation-name: onAutoFillStart;
    }
    
    input:not(:-webkit-autofill) {
        animation-name: onAutoFillCancel;
    }
`;
document.head.appendChild(style); 

// add aditional


