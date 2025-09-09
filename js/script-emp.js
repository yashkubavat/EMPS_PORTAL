// Employee User Panel JavaScript

class EmployeeUserPanel {
    constructor() {
        this.currentSection = 'profile';
        this.userData = this.loadUserData();
        this.attendanceData = this.loadAttendanceData();
        this.tasksData = this.loadTasksData();
        this.settings = this.loadSettings();
        
        this.initializeElements();
        this.bindEvents();
        this.initializeUI();
        this.renderAttendance();
        this.renderTasks();
        this.applyTheme();
    }

    // Initialize DOM elements
    initializeElements() {
        // Sidebar and navigation
        this.hamburgerBtn = document.getElementById('hamburgerBtn');
        this.sidebar = document.getElementById('sidebar');
        this.navLinks = document.querySelectorAll('.nav-link[data-section]');
        this.logoutBtn = document.getElementById('logoutBtn');
        
        // Content sections
        this.contentSections = document.querySelectorAll('.content-section');
        
        // Profile elements
        this.editProfileBtn = document.getElementById('editProfileBtn');
        this.editProfileModal = document.getElementById('editProfileModal');
        this.editProfileForm = document.getElementById('editProfileForm');
        this.closeEditModal = document.getElementById('closeEditModal');
        this.cancelEditBtn = document.getElementById('cancelEditBtn');
        
        // Password form elements
        this.passwordForm = document.getElementById('passwordForm');
        this.currentPassword = document.getElementById('currentPassword');
        this.newPassword = document.getElementById('newPassword');
        this.confirmPassword = document.getElementById('confirmPassword');
        
        // Settings elements
        this.themeBtns = document.querySelectorAll('.theme-btn');
        this.emailNotifications = document.getElementById('emailNotifications');
        this.taskReminders = document.getElementById('taskReminders');
        
        // Attendance elements
        this.attendanceList = document.getElementById('attendanceList');
        this.calendarGrid = document.getElementById('calendarGrid');
        this.monthlyAttendance = document.getElementById('monthlyAttendance');
        this.weeklyAttendance = document.getElementById('weeklyAttendance');
        
        // Tasks elements
        this.tasksList = document.getElementById('tasksList');
        this.taskFilters = document.querySelectorAll('.filter-btn');
        this.taskBadge = document.getElementById('taskBadge');
    }

    // Bind event listeners
    bindEvents() {
        // Sidebar toggle
        this.hamburgerBtn.addEventListener('click', () => this.toggleSidebar());
        
        // Navigation
        this.navLinks.forEach(link => {
            link.addEventListener('click', (e) => this.handleNavigation(e));
        });
        
        // Logout
        this.logoutBtn.addEventListener('click', (e) => this.handleLogout(e));
        
        // Edit profile modal
        this.editProfileBtn.addEventListener('click', () => this.openEditProfileModal());
        this.closeEditModal.addEventListener('click', () => this.closeEditProfileModal());
        this.cancelEditBtn.addEventListener('click', () => this.closeEditProfileModal());
        this.editProfileModal.addEventListener('click', (e) => {
            if (e.target === this.editProfileModal) this.closeEditProfileModal();
        });
        
        // Form submissions
        this.editProfileForm.addEventListener('submit', (e) => this.handleProfileSubmit(e));
        this.passwordForm.addEventListener('submit', (e) => this.handlePasswordSubmit(e));
        
        // Settings
        this.themeBtns.forEach(btn => {
            btn.addEventListener('click', () => this.changeTheme(btn.dataset.theme));
        });
        
        this.emailNotifications.addEventListener('change', () => this.saveSettings());
        this.taskReminders.addEventListener('change', () => this.saveSettings());
        
        // Task filters
        this.taskFilters.forEach(filter => {
            filter.addEventListener('click', () => this.filterTasks(filter.dataset.filter));
        });
        
        // Password validation
        this.newPassword.addEventListener('input', () => this.validatePassword());
        this.confirmPassword.addEventListener('input', () => this.validatePassword());
    }

    // Sidebar functionality
    toggleSidebar() {
        this.sidebar.classList.toggle('active');
    }

    // Navigation handling
    handleNavigation(e) {
        e.preventDefault();
        const section = e.target.closest('.nav-link').dataset.section;
        
        // Remove active class from all nav items and sections
        this.navLinks.forEach(link => link.parentElement.classList.remove('active'));
        this.contentSections.forEach(section => section.classList.remove('active'));
        
        // Add active class to clicked item and corresponding section
        e.target.closest('.nav-item').classList.add('active');
        document.getElementById(section + 'Section').classList.add('active');
        
        this.currentSection = section;
        
        // Close sidebar on mobile after navigation
        if (window.innerWidth <= 1024) {
            this.sidebar.classList.remove('active');
        }
    }

    // Logout handling
    handleLogout(e) {
        e.preventDefault();
        if (confirm('Are you sure you want to logout?')) {
            // In a real app, you would clear session/tokens here
            alert('Logged out successfully!');
            // Redirect to login page or show login form
            window.location.href = 'index.html'; // Assuming index.html is the login page
        }
    }

    // Profile editing
    openEditProfileModal() {
        // Populate form with current user data
        document.getElementById('editName').value = this.userData.name;
        document.getElementById('editEmail').value = this.userData.email;
        document.getElementById('editPhone').value = this.userData.phone;
        document.getElementById('editLocation').value = this.userData.location;
        
        this.editProfileModal.classList.add('active');
    }

    closeEditProfileModal() {
        this.editProfileModal.classList.remove('active');
        this.editProfileForm.reset();
    }

    handleProfileSubmit(e) {
        e.preventDefault();
        
        if (this.validateProfileForm()) {
            // Update user data
            this.userData.name = document.getElementById('editName').value.trim();
            this.userData.email = document.getElementById('editEmail').value.trim();
            this.userData.phone = document.getElementById('editPhone').value.trim();
            this.userData.location = document.getElementById('editLocation').value.trim();
            
            this.saveUserData();
            this.updateProfileDisplay();
            this.closeEditProfileModal();
            this.showNotification('Profile updated successfully!', 'success');
        }
    }

    validateProfileForm() {
        let isValid = true;
        
        // Name validation
        const name = document.getElementById('editName').value.trim();
        if (!name) {
            this.showFieldError('editNameError', 'Name is required');
            isValid = false;
        } else {
            this.clearFieldError('editNameError');
        }
        
        // Email validation
        const email = document.getElementById('editEmail').value.trim();
        if (!email) {
            this.showFieldError('editEmailError', 'Email is required');
            isValid = false;
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            this.showFieldError('editEmailError', 'Please enter a valid email address');
            isValid = false;
        } else {
            this.clearFieldError('editEmailError');
        }
        
        return isValid;
    }

    // Password change
    handlePasswordSubmit(e) {
        e.preventDefault();
        
        if (this.validatePasswordForm()) {
            // In a real app, you would send this to the server
            this.showNotification('Password changed successfully!', 'success');
            this.passwordForm.reset();
            this.clearPasswordRequirements();
        }
    }

    validatePasswordForm() {
        let isValid = true;
        
        // Current password validation
        const currentPassword = this.currentPassword.value;
        if (!currentPassword) {
            this.showFieldError('currentPasswordError', 'Current password is required');
            isValid = false;
        } else if (currentPassword !== 'password123') { // Mock current password
            this.showFieldError('currentPasswordError', 'Current password is incorrect');
            isValid = false;
        } else {
            this.clearFieldError('currentPasswordError');
        }
        
        // New password validation
        const newPassword = this.newPassword.value;
        if (!newPassword) {
            this.showFieldError('newPasswordError', 'New password is required');
            isValid = false;
        } else {
            this.clearFieldError('newPasswordError');
        }
        
        // Confirm password validation
        const confirmPassword = this.confirmPassword.value;
        if (!confirmPassword) {
            this.showFieldError('confirmPasswordError', 'Please confirm your new password');
            isValid = false;
        } else if (newPassword !== confirmPassword) {
            this.showFieldError('confirmPasswordError', 'Passwords do not match');
            isValid = false;
        } else {
            this.clearFieldError('confirmPasswordError');
        }
        
        return isValid;
    }

    validatePassword() {
        const password = this.newPassword.value;
        const requirements = {
            length: password.length >= 8,
            uppercase: /[A-Z]/.test(password),
            lowercase: /[a-z]/.test(password),
            number: /\d/.test(password),
            special: /[!@#$%^&*(),.?":{}|<>]/.test(password)
        };
        
        // Update requirement indicators
        Object.keys(requirements).forEach(req => {
            const element = document.getElementById('req' + req.charAt(0).toUpperCase() + req.slice(1));
            if (requirements[req]) {
                element.classList.add('valid');
            } else {
                element.classList.remove('valid');
            }
        });
    }

    clearPasswordRequirements() {
        document.querySelectorAll('.password-requirements li').forEach(li => {
            li.classList.remove('valid');
        });
    }

    // Theme switching
    changeTheme(theme) {
        this.settings.theme = theme;
        this.saveSettings();
        this.applyTheme();
        
        // Update theme buttons
        this.themeBtns.forEach(btn => {
            btn.classList.remove('active');
            if (btn.dataset.theme === theme) {
                btn.classList.add('active');
            }
        });
    }

    applyTheme() {
        document.documentElement.setAttribute('data-theme', this.settings.theme);
    }

    // Attendance rendering
    renderAttendance() {
        this.renderAttendanceList();
        this.renderAttendanceCalendar();
        this.updateAttendanceSummary();
    }

    renderAttendanceList() {
        const recentAttendance = this.attendanceData.slice(-7); // Last 7 days
        
        this.attendanceList.innerHTML = recentAttendance.map(record => `
            <div class="attendance-item">
                <span class="attendance-date">${this.formatDate(record.date)}</span>
                <span class="attendance-status ${record.status}">${record.status}</span>
            </div>
        `).join('');
    }

    renderAttendanceCalendar() {
        const today = new Date();
        const currentMonth = today.getMonth();
        const currentYear = today.getFullYear();
        const firstDay = new Date(currentYear, currentMonth, 1);
        const lastDay = new Date(currentYear, currentMonth + 1, 0);
        const startDate = new Date(firstDay);
        startDate.setDate(startDate.getDate() - firstDay.getDay());
        
        let calendarHTML = '';
        
        // Generate calendar grid
        for (let i = 0; i < 42; i++) {
            const date = new Date(startDate);
            date.setDate(startDate.getDate() + i);
            
            const isCurrentMonth = date.getMonth() === currentMonth;
            const dayNumber = date.getDate();
            
            // Find attendance record for this date
            const attendanceRecord = this.attendanceData.find(record => 
                new Date(record.date).toDateString() === date.toDateString()
            );
            
            let dayClass = 'calendar-day';
            if (!isCurrentMonth) dayClass += ' other-month';
            if (attendanceRecord) dayClass += ` ${attendanceRecord.status}`;
            
            calendarHTML += `<div class="${dayClass}">${dayNumber}</div>`;
        }
        
        this.calendarGrid.innerHTML = calendarHTML;
    }

    updateAttendanceSummary() {
        const today = new Date();
        const currentMonth = today.getMonth();
        const currentYear = today.getFullYear();
        
        // Monthly attendance
        const monthlyRecords = this.attendanceData.filter(record => {
            const recordDate = new Date(record.date);
            return recordDate.getMonth() === currentMonth && 
                   recordDate.getFullYear() === currentYear;
        });
        
        const presentDays = monthlyRecords.filter(record => record.status === 'present').length;
        const totalDays = monthlyRecords.length;
        
        this.monthlyAttendance.textContent = `${presentDays}/${totalDays}`;
        
        // Weekly attendance (current week)
        const weekStart = new Date(today);
        weekStart.setDate(today.getDate() - today.getDay());
        const weekEnd = new Date(weekStart);
        weekEnd.setDate(weekStart.getDate() + 6);
        
        const weeklyRecords = this.attendanceData.filter(record => {
            const recordDate = new Date(record.date);
            return recordDate >= weekStart && recordDate <= weekEnd;
        });
        
        const weeklyPresent = weeklyRecords.filter(record => record.status === 'present').length;
        const weeklyTotal = weeklyRecords.length;
        
        this.weeklyAttendance.textContent = `${weeklyPresent}/${weeklyTotal}`;
    }

    // Tasks rendering
    renderTasks() {
        this.renderTasksList();
        this.updateTaskBadge();
    }

    renderTasksList(filter = 'all') {
        let filteredTasks = this.tasksData;
        
        if (filter === 'pending') {
            filteredTasks = this.tasksData.filter(task => task.status === 'pending');
        } else if (filter === 'completed') {
            filteredTasks = this.tasksData.filter(task => task.status === 'completed');
        }
        
        this.tasksList.innerHTML = filteredTasks.map(task => `
            <div class="task-item">
                <div class="task-header">
                    <h4 class="task-title">${this.escapeHtml(task.title)}</h4>
                    <span class="task-status ${task.status}">${task.status}</span>
                </div>
                <p class="task-description">${this.escapeHtml(task.description)}</p>
                <div class="task-meta">
                    <span><i class="fas fa-calendar"></i> Due: ${this.formatDate(task.dueDate)}</span>
                    <span><i class="fas fa-user"></i> ${task.assignedBy}</span>
                </div>
            </div>
        `).join('');
    }

    filterTasks(filter) {
        // Update filter buttons
        this.taskFilters.forEach(btn => btn.classList.remove('active'));
        event.target.classList.add('active');
        
        this.renderTasksList(filter);
    }

    updateTaskBadge() {
        const pendingTasks = this.tasksData.filter(task => task.status === 'pending').length;
        this.taskBadge.textContent = pendingTasks;
        
        if (pendingTasks === 0) {
            this.taskBadge.style.display = 'none';
        } else {
            this.taskBadge.style.display = 'inline-block';
        }
    }

    // Initialize UI
    initializeUI() {
        this.updateProfileDisplay();
        this.loadSettingsToUI();
    }

    updateProfileDisplay() {
        // Update all profile displays
        const nameElements = ['sidebarUserName', 'mainUserName', 'headerUserName'];
        const roleElements = ['sidebarUserRole', 'mainUserRole'];
        const deptElements = ['sidebarUserDept', 'mainUserDept'];
        
        nameElements.forEach(id => {
            const element = document.getElementById(id);
            if (element) element.textContent = this.userData.name;
        });
        
        roleElements.forEach(id => {
            const element = document.getElementById(id);
            if (element) element.textContent = this.userData.position;
        });
        
        deptElements.forEach(id => {
            const element = document.getElementById(id);
            if (element) element.textContent = this.userData.department + ' Department';
        });
        
        // Update other profile details
        document.getElementById('employeeId').textContent = this.userData.employeeId;
        document.getElementById('userEmail').textContent = this.userData.email;
        document.getElementById('userPhone').textContent = this.userData.phone;
        document.getElementById('userDepartment').textContent = this.userData.department;
        document.getElementById('userPosition').textContent = this.userData.position;
        document.getElementById('userJoiningDate').textContent = this.formatDate(this.userData.joiningDate);
        document.getElementById('userLocation').textContent = this.userData.location;
    }

    loadSettingsToUI() {
        // Apply theme
        this.themeBtns.forEach(btn => {
            btn.classList.remove('active');
            if (btn.dataset.theme === this.settings.theme) {
                btn.classList.add('active');
            }
        });
        
        // Apply notification settings
        this.emailNotifications.checked = this.settings.emailNotifications;
        this.taskReminders.checked = this.settings.taskReminders;
    }

    // Utility functions
    showFieldError(elementId, message) {
        const errorElement = document.getElementById(elementId);
        if (errorElement) {
            errorElement.textContent = message;
        }
    }

    clearFieldError(elementId) {
        const errorElement = document.getElementById(elementId);
        if (errorElement) {
            errorElement.textContent = '';
        }
    }

    formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

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

    // Data management
    saveUserData() {
        localStorage.setItem('employeeUserData', JSON.stringify(this.userData));
    }

    loadUserData() {
        const saved = localStorage.getItem('employeeUserData');
        if (saved) {
            return JSON.parse(saved);
        }
        
        // Return default user data
        return {
            name: 'John Smith',
            email: 'john.smith@company.com',
            phone: '+1 (555) 123-4567',
            location: 'New York, NY',
            employeeId: 'EMP001',
            position: 'Software Engineer',
            department: 'Engineering',
            joiningDate: '2023-01-15'
        };
    }

    saveSettings() {
        this.settings.emailNotifications = this.emailNotifications.checked;
        this.settings.taskReminders = this.taskReminders.checked;
        localStorage.setItem('employeeSettings', JSON.stringify(this.settings));
    }

    loadSettings() {
        const saved = localStorage.getItem('employeeSettings');
        if (saved) {
            return JSON.parse(saved);
        }
        
        return {
            theme: 'light',
            emailNotifications: true,
            taskReminders: true
        };
    }

    loadAttendanceData() {
        // Mock attendance data for the current month
        const today = new Date();
        const currentMonth = today.getMonth();
        const currentYear = today.getFullYear();
        const daysInMonth = new Date(currentYear, currentMonth + 1, 0).getDate();
        
        const attendanceData = [];
        
        for (let day = 1; day <= daysInMonth; day++) {
            const date = new Date(currentYear, currentMonth, day);
            
            // Skip weekends (Saturday = 6, Sunday = 0)
            if (date.getDay() !== 0 && date.getDay() !== 6) {
                // Random attendance (90% present rate)
                const status = Math.random() > 0.1 ? 'present' : 'absent';
                
                attendanceData.push({
                    date: date.toISOString().split('T')[0],
                    status: status
                });
            }
        }
        
        return attendanceData;
    }

    loadTasksData() {
        // Mock tasks data
        return [
            {
                id: 1,
                title: 'Complete User Authentication Module',
                description: 'Implement secure user authentication with JWT tokens and password hashing.',
                status: 'pending',
                dueDate: '2024-01-20',
                assignedBy: 'Project Manager'
            },
            {
                id: 2,
                title: 'Review Code for Security Vulnerabilities',
                description: 'Perform security audit on the payment processing module.',
                status: 'completed',
                dueDate: '2024-01-15',
                assignedBy: 'Security Team'
            },
            {
                id: 3,
                title: 'Update API Documentation',
                description: 'Update the REST API documentation with new endpoints and examples.',
                status: 'pending',
                dueDate: '2024-01-25',
                assignedBy: 'Technical Lead'
            },
            {
                id: 4,
                title: 'Fix Mobile Responsiveness Issues',
                description: 'Resolve layout issues on mobile devices for the dashboard.',
                status: 'pending',
                dueDate: '2024-01-22',
                assignedBy: 'UI/UX Team'
            }
        ];
    }
}

// Initialize the application
let employeePanel;
document.addEventListener('DOMContentLoaded', () => {
    employeePanel = new EmployeeUserPanel();
});

// Close sidebar when clicking outside on mobile
document.addEventListener('click', (e) => {
    if (window.innerWidth <= 1024) {
        const sidebar = document.getElementById('sidebar');
        const hamburgerBtn = document.getElementById('hamburgerBtn');
        
        if (sidebar.classList.contains('active') && 
            !sidebar.contains(e.target) && 
            !hamburgerBtn.contains(e.target)) {
            sidebar.classList.remove('active');
        }
    }
});

// Handle window resize
window.addEventListener('resize', () => {
    if (window.innerWidth > 1024) {
        document.getElementById('sidebar').classList.remove('active');
    }
});