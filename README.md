# Employee Management System

A modern, responsive employee management system with separate pages for different functionalities.

## Pages Structure

### 1. **Login Page** (`index.html`)
- Employee authentication
- Modern login interface with theme toggle
- Demo credentials provided
- Responsive design

### 2. **Employee Dashboard** (`employee.html`)
- Main employee portal with navigation
- Profile management
- Settings and password change
- Navigation to separate pages

### 3. **Attendance Management** (`attendance.html`)
- **Attendance Summary**: Monthly and weekly attendance statistics
- **Recent Attendance**: List of recent attendance records
- **Monthly Calendar**: Visual calendar showing attendance status
- **Features**:
  - Real-time attendance tracking
  - Calendar view with status indicators
  - Attendance statistics and summaries
  - Responsive design for all devices

### 4. **Leave Management** (`leave.html`)
- **Leave Balance Summary**: Visual cards showing different leave types with usage progress
- **Leave Request Form**: Modal for submitting new leave requests
- **Leave History**: Complete history of past leave requests
- **Upcoming Leaves**: Scheduled future leaves
- **Features**:
  - Annual, Sick, Personal, Maternity, Paternity leave types
  - Date range selection
  - Reason documentation
  - Emergency contact information
  - Status tracking (Approved, Pending, Rejected)

### 5. **Salary Management** (`salary.html`)
- **Salary Overview**: Current salary, pay dates, YTD earnings, net pay
- **Salary Breakdown**: Detailed breakdown of earnings and deductions
- **Payslip History**: Complete history of payslips with download/view options
- **Detailed Payslip View**: Modal with comprehensive salary details
- **Features**:
  - Salary components (Basic, Allowances, Bonuses)
  - Deductions (Tax, Insurance, Retirement)
  - Payslip download functionality
  - Detailed salary analysis

### 6. **Task Management** (`tasks.html`)
- **Task List**: Complete list of assigned tasks with filtering
- **Task Filters**: Filter by All, Pending, or Completed tasks
- **Task Details**: Title, description, due date, and assignee information
- **Task Status**: Visual status indicators (pending/completed)
- **Features**:
  - Task filtering and sorting
  - Due date tracking
  - Status management
  - Assignee information
  - Task badge showing pending count

### 7. **Settings Management** (`settings.html`)
- **Appearance Settings**: Theme selection (Light/Dark mode)
- **Notification Preferences**: Email notifications and task reminders
- **User Preferences**: Personalized settings management
- **Features**:
  - Theme switching with instant preview
  - Notification toggle controls
  - Settings persistence using localStorage
  - Real-time settings updates
  - **Global Theme System**: Theme changes apply across all pages

## Features

### 🎨 **Modern UI/UX**
- Clean, professional design
- Responsive layout for all devices
- **Advanced Theme System**: Light/Dark mode with global persistence
- Smooth animations and transitions
- **Theme Manager**: Centralized theme management across all pages

### 📱 **Responsive Design**
- Mobile-first approach
- Tablet and desktop optimized
- Touch-friendly interface

### 🔧 **Interactive Elements**
- Modal dialogs for forms
- Real-time form validation
- Dynamic content loading
- Status indicators and badges

### 🎯 **User Experience**
- Intuitive navigation
- Clear visual hierarchy
- Consistent design language
- Accessibility considerations

## File Structure

```
emp-user/
├── index.html          # Login page
├── employee.html       # Main dashboard (Profile, Password)
├── attendance.html     # Attendance management
├── leave.html         # Leave management
├── salary.html        # Salary management
├── tasks.html         # Task management
├── settings.html      # Settings management
├── style.css          # Login page styles
├── style-emp.css      # Employee portal styles
├── script.js          # Login functionality
├── script-emp.js      # Employee portal functionality
├── theme-manager.js   # Global theme management
└── README.md          # Documentation
```

## Getting Started

1. **Open the login page**: `index.html`
2. **Use demo credentials**:
   - Email: `john.smith@company.com`
   - Password: `password123`
3. **Navigate through the system**:
   - Dashboard: Profile, Password Change
   - Settings: Theme and notification preferences
   - Attendance: Track attendance and view calendar
   - Leave Management: Request and track leaves
   - Salary Management: View salary details and payslips
   - Task Management: View and filter tasks

## Navigation Flow

```
Login (index.html)
    ↓
Dashboard (employee.html)
    ↓
├── Profile Section
├── Attendance Management (attendance.html) ← Separate Page
├── Leave Management (leave.html) ← Separate Page
├── Salary Management (salary.html) ← Separate Page
├── Task Management (tasks.html) ← Separate Page
├── Settings Management (settings.html) ← Separate Page
└── Password Change Section
```

## Technical Details

### **CSS Framework**
- Custom CSS with CSS variables for theming
- Flexbox and Grid layouts
- Mobile-responsive breakpoints
- Smooth transitions and hover effects

### **JavaScript Features**
- Form validation
- Modal management
- Dynamic content rendering
- **Global Theme Management**: Centralized theme switching across all pages
- Responsive sidebar
- Task filtering and management
- Attendance tracking and calendar
- Leave request processing
- Salary calculation and display

### **Browser Support**
- Modern browsers (Chrome, Firefox, Safari, Edge)
- Mobile browsers
- Progressive enhancement approach

## Theme System

### **Global Theme Management**
The application features a comprehensive theme system that works across all pages:

- **Theme Persistence**: Theme preference is saved in localStorage and persists across browser sessions
- **Cross-Page Consistency**: Theme changes apply immediately to all pages in the application
- **Smooth Transitions**: All theme changes include smooth CSS transitions for better UX
- **Automatic Detection**: Theme manager automatically loads the saved theme on page load

### **Theme Switching**
- **Login Page**: Theme toggle buttons in the top-right corner
- **Settings Page**: Theme selection in the Appearance section
- **All Pages**: Theme automatically applies based on saved preference

### **Customization**

#### **Colors and Themes**
Modify CSS variables in `style-emp.css` and `style.css`:
```css
:root {
    --primary-color: #2563eb;
    --secondary-color: #64748b;
    --success-color: #10b981;
    --danger-color: #ef4444;
    /* ... more variables */
}

.dark-theme {
    --background-color: #0f172a;
    --surface-color: #1e293b;
    --text-primary: #f1f5f9;
    /* ... dark theme variables */
}
```

### **Content**
- Update employee data in JavaScript files
- Modify form fields and validation rules
- Customize leave types and salary components
- Add new task categories and statuses

## Future Enhancements

- [ ] Real-time notifications
- [ ] Calendar integration
- [ ] Document upload functionality
- [ ] Advanced reporting
- [ ] Multi-language support
- [ ] API integration
- [ ] Offline functionality
- [ ] Task assignment and collaboration
- [ ] Time tracking integration
- [ ] Performance analytics

---

**Note**: This is a frontend demonstration. For production use, integrate with backend services for data persistence and user authentication. 