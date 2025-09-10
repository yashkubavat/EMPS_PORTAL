// Global variables
let currentUser = null;
let employees = [];
let departments = [];
let currentPage = 1;
let itemsPerPage = 10;
let filteredEmployees = [];
let salaryHistory = [];
let salaryCharts = {}; // To store Chart.js instances

// Initialize dashboard
document.addEventListener('DOMContentLoaded', function() {
    checkAuth();
    loadTheme(); // Load theme preference first
    initializeDashboard();
    loadData();
    setupEventListeners();
    // Load dashboard content by default
    loadSectionContent('dashboard', 'pages/dashboard-content.html');
});

// Authentication check
function checkAuth() {
    const user = localStorage.getItem('user');
    if (!user) {
        window.location.href = 'index.html'; // Redirect to login if not authenticated
        return;
    }
    
    currentUser = JSON.parse(user);
    document.getElementById('userName').textContent = currentUser.name;
}

// Initialize dashboard specific elements
function initializeDashboard() {
    // These will be called by reinitializePageElements after content loads
}

// Setup event listeners
function setupEventListeners() {
    // Navigation
    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            const section = this.dataset.section;
            const url = this.dataset.url; // Get the URL from data-url attribute
            loadSectionContent(section, url);
        });
    });

    // Hamburger menu
    document.getElementById('hamburger').addEventListener('click', toggleMobileMenu);

    // Theme toggle
    document.getElementById('themeToggle').addEventListener('click', toggleTheme);

    // Logout
    document.getElementById('logoutBtn').addEventListener('click', logout);

    // Modals (these listeners need to be re-applied after content is loaded)
    // We'll use event delegation for modals or re-attach listeners after content load
}

// Function to load content into the main content area
async function loadSectionContent(sectionName, url) {
    const mainContent = document.getElementById('mainContentArea');
    if (!mainContent) return;

    try {
        const response = await fetch(url);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const html = await response.text();
        mainContent.innerHTML = html;

        // Update navigation active state
        document.querySelectorAll('.nav-link').forEach(link => {
            link.classList.remove('active');
        });
        const activeLink = document.querySelector(`.nav-link[data-section="${sectionName}"]`);
        if (activeLink) {
            activeLink.classList.add('active');
        }
        
        // Close mobile menu if open
        const navMenu = document.getElementById('navMenu');
        const hamburger = document.getElementById('hamburger');
        if (navMenu.classList.contains('active')) {
            navMenu.classList.remove('active');
            hamburger.classList.remove('active');
        }

        // After content is loaded, re-initialize specific elements and attach event listeners
        // This is crucial because the DOM elements are new
        reinitializePageElements(sectionName);

    } catch (error) {
        console.error('Error loading section content:', error);
        mainContent.innerHTML = `<p style="color: var(--danger-color);">Error loading content for ${sectionName}. Please try again.</p>`;
    }
}

// Function to re-initialize elements and attach listeners after content load
function reinitializePageElements(sectionName) {
    // Load modals (they are in a separate file now)
    loadModals();

    // Common initializations
    loadDepartmentsForSelect(); // For employee and bulk salary forms

    // Section-specific initializations
    switch (sectionName) {
        case 'dashboard':
            updateDashboardStats();
            loadRecentActivities();
            break;
        case 'employees':
            // Attach search and filter listeners
            document.getElementById('employeeSearch')?.addEventListener('input', filterEmployees);
            document.getElementById('departmentFilter')?.addEventListener('change', filterEmployees);
            document.getElementById('salaryFilter')?.addEventListener('change', filterEmployees);
            renderEmployees(); // Render employees table
            break;
        case 'salary':
            // Set current date for salary effective date
            document.getElementById('salaryEffectiveDate').valueAsDate = new Date();
            document.getElementById('bulkEffectiveDate').valueAsDate = new Date();
            // Attach bulk salary update type change listener
            document.getElementById('bulkUpdateType')?.addEventListener('change', handleBulkUpdateTypeChange);
            document.getElementById('bulkUpdateValue')?.addEventListener('input', updateBulkPreview);
            initializeSalaryCharts();
            renderSalaryTable();
            updateSalaryStats(); // Ensure salary stats are updated
            break;
        case 'departments':
            renderDepartments(); // Render departments grid
            break;
    }

    // Re-attach form submit listeners (using event delegation or direct attachment)
    document.getElementById('employeeForm')?.addEventListener('submit', handleEmployeeSubmit);
    document.getElementById('departmentForm')?.addEventListener('submit', handleDepartmentSubmit);
    document.getElementById('salaryForm')?.addEventListener('submit', handleSalarySubmit);
    document.getElementById('bulkSalaryForm')?.addEventListener('submit', handleBulkSalarySubmit);

    // Re-attach photo preview listener
    document.getElementById('employeePhoto')?.addEventListener('change', handlePhotoPreview);

    // Set current date for joining date input (for employee form)
    document.getElementById('employeeJoiningDate')?.valueAsDate = new Date();

    // Re-attach modal close on outside click (using event delegation)
    // This listener is now attached to the modalContainer itself for better delegation
    // and will be set up once when the modalContainer is loaded.
    // No need to re-attach here for every page load.
}

// Function to load modals dynamically
async function loadModals() {
    let modalContainer = document.getElementById('modalContainer');
    if (!modalContainer) {
        // Create modal container if it doesn't exist (e.g., if it's not in dashboard.html initially)
        const body = document.body;
        const newModalContainer = document.createElement('div');
        newModalContainer.id = 'modalContainer';
        body.appendChild(newModalContainer);
        modalContainer = newModalContainer;

        // Attach the single event listener for closing modals on outside click to the container
        modalContainer.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal')) {
                closeModal(e.target.id);
            }
        });
    }

    // Only load modals if they haven't been loaded yet (check if container is empty)
    if (modalContainer.innerHTML.trim() === '') {
        try {
            const response = await fetch('modals.html');
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const html = await response.text();
            modalContainer.innerHTML = html;

            // Re-attach close button listeners for modals
            modalContainer.querySelectorAll('.close-btn').forEach(btn => {
                btn.onclick = function() {
                    closeModal(this.closest('.modal').id);
                };
            });

        } catch (error) {
            console.error('Error loading modals:', error);
        }
    }
}


function toggleMobileMenu() {
    const navMenu = document.getElementById('navMenu');
    const hamburger = document.getElementById('hamburger');
    
    navMenu.classList.toggle('active');
    hamburger.classList.toggle('active');
}

function toggleTheme() {
    const body = document.body;
    const themeToggle = document.getElementById('themeToggle');
    const icon = themeToggle.querySelector('i');
    
    if (body.getAttribute('data-theme') === 'dark') {
        body.removeAttribute('data-theme');
        localStorage.setItem('theme', 'light');
        icon.className = 'fas fa-moon'; // Change to moon icon for light theme
    } else {
        body.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
        icon.className = 'fas fa-sun'; // Change to sun icon for dark theme
    }
    
    // Update charts with new theme if they exist
    updateChartsTheme();
}

function logout() {
    localStorage.removeItem('user');
    window.location.href = 'index.html';
}

// Load theme preference
function loadTheme() {
    const theme = localStorage.getItem('theme');
    const themeToggle = document.getElementById('themeToggle');
    const icon = themeToggle.querySelector('i');
    
    if (theme === 'dark') {
        document.body.setAttribute('data-theme', 'dark');
        icon.className = 'fas fa-sun';
    } else {
        document.body.removeAttribute('data-theme');
        icon.className = 'fas fa-moon';
    }
}

// Data loading functions
function loadData() {
    // Load sample data for demo
    loadSampleData();
    // Initial rendering will happen after content loads in reinitializePageElements
}

function loadSampleData() {
    // Sample departments
    departments = [
        { id: 1, name: 'Engineering', description: 'Software development and technical operations', employee_count: 3 },
        { id: 2, name: 'Marketing', description: 'Digital marketing and brand management', employee_count: 1 },
        { id: 3, name: 'Sales', description: 'Customer acquisition and revenue generation', employee_count: 2 },
        { id: 4, name: 'HR', description: 'Human resources and employee relations', employee_count: 1 },
        { id: 5, name: 'Finance', description: 'Financial planning and accounting', employee_count: 1 }
    ];

    // Sample employees with more realistic salaries
    employees = [
        {
            id: 1,
            name: 'John Doe',
            email: 'john.doe@company.com',
            phone: '+1 (555) 123-4567',
            department_id: 1,
            department: 'Engineering',
            position: 'Senior Developer',
            salary: 95000,
            joining_date: '2023-01-15',
            photo: null,
            last_salary_update: '2024-01-15'
        },
        {
            id: 2,
            name: 'Jane Smith',
            email: 'jane.smith@company.com',
            phone: '+1 (555) 234-5678',
            department_id: 2,
            department: 'Marketing',
            position: 'Marketing Manager',
            salary: 85000,
            joining_date: '2023-02-20',
            photo: null,
            last_salary_update: '2024-02-01'
        },
        {
            id: 3,
            name: 'Mike Johnson',
            email: 'mike.johnson@company.com',
            phone: '+1 (555) 345-6789',
            department_id: 3,
            department: 'Sales',
            position: 'Sales Representative',
            salary: 75000,
            joining_date: '2023-03-10',
            photo: null,
            last_salary_update: '2024-01-20'
        },
        {
            id: 4,
            name: 'Sarah Wilson',
            email: 'sarah.wilson@company.com',
            phone: '+1 (555) 456-7890',
            department_id: 4,
            department: 'HR',
            position: 'HR Specialist',
            salary: 65000,
            joining_date: '2023-04-05',
            photo: null,
            last_salary_update: '2024-02-15'
        },
        {
            id: 5,
            name: 'David Brown',
            email: 'david.brown@company.com',
            phone: '+1 (555) 567-8901',
            department_id: 1,
            department: 'Engineering',
            position: 'Frontend Developer',
            salary: 80000,
            joining_date: '2023-05-12',
            photo: null,
            last_salary_update: '2024-01-10'
        },
        {
            id: 6,
            name: 'Emily Davis',
            email: 'emily.davis@company.com',
            phone: '+1 (555) 678-9012',
            department_id: 5,
            department: 'Finance',
            position: 'Financial Analyst',
            salary: 70000,
            joining_date: '2023-06-01',
            photo: null,
            last_salary_update: '2024-02-10'
        },
        {
            id: 7,
            name: 'Robert Wilson',
            email: 'robert.wilson@company.com',
            phone: '+1 (555) 789-0123',
            department_id: 1,
            department: 'Engineering',
            position: 'Backend Developer',
            salary: 90000,
            joining_date: '2023-07-15',
            photo: null,
            last_salary_update: '2024-01-25'
        },
        {
            id: 8,
            name: 'Lisa Anderson',
            email: 'lisa.anderson@company.com',
            phone: '+1 (555) 890-1234',
            department_id: 3,
            department: 'Sales',
            position: 'Sales Manager',
            salary: 95000,
            joining_date: '2023-08-20',
            photo: null,
            last_salary_update: '2024-02-05'
        }
    ];

    // Update department employee counts based on sample data
    departments.forEach(dept => {
        dept.employee_count = employees.filter(emp => emp.department_id === dept.id).length;
    });

    // Sample salary history
    salaryHistory = [
        { employee_id: 1, old_salary: 90000, new_salary: 95000, reason: 'Performance review', date: '2024-01-15' },
        { employee_id: 2, old_salary: 80000, new_salary: 85000, reason: 'Promotion', date: '2024-02-01' },
        { employee_id: 3, old_salary: 70000, new_salary: 75000, reason: 'Market adjustment', date: '2024-01-20' },
        { employee_id: 4, old_salary: 60000, new_salary: 65000, reason: 'Annual review', date: '2024-02-15' },
        { employee_id: 5, old_salary: 75000, new_salary: 80000, reason: 'Performance review', date: '2024-01-10' },
        { employee_id: 6, old_salary: 65000, new_salary: 70000, reason: 'Promotion', date: '2024-02-10' },
        { employee_id: 7, old_salary: 85000, new_salary: 90000, reason: 'Market adjustment', date: '2024-01-25' },
        { employee_id: 8, old_salary: 90000, new_salary: 95000, reason: 'Performance review', date: '2024-02-05' }
    ];

    filteredEmployees = [...employees]; // Initialize filtered employees
}

function updateDashboardStats() {
    const totalEmployeesElement = document.getElementById('totalEmployees');
    const totalDepartmentsElement = document.getElementById('totalDepartments');
    const newEmployeesElement = document.getElementById('newEmployees');
    const avgSalaryElement = document.getElementById('avgSalary');
    const totalSalaryElement = document.getElementById('totalSalary');
    const highestSalaryElement = document.getElementById('highestSalary');

    if (!totalEmployeesElement) return; // Check if elements exist (only on dashboard page)

    totalEmployeesElement.textContent = employees.length;
    totalDepartmentsElement.textContent = departments.length;
    
    const currentMonth = new Date().getMonth();
    const newEmployeesCount = employees.filter(emp => {
        const joiningMonth = new Date(emp.joining_date).getMonth();
        return joiningMonth === currentMonth;
    }).length;
    newEmployeesElement.textContent = newEmployeesCount;
    
    // Enhanced salary statistics
    const salaries = employees.map(emp => emp.salary || 0).filter(salary => salary > 0);
    const avgSalary = salaries.length > 0 ? Math.round(salaries.reduce((sum, salary) => sum + salary, 0) / salaries.length) : 0;
    const totalSalary = salaries.reduce((sum, salary) => sum + salary, 0);
    const highestSalary = Math.max(...salaries, 0);
    
    avgSalaryElement.textContent = `$${avgSalary.toLocaleString()}`;
    totalSalaryElement.textContent = `$${totalSalary.toLocaleString()}`;
    highestSalaryElement.textContent = `$${highestSalary.toLocaleString()}`;
    
    // Update salary section stats if visible
    updateSalaryStats();
}

function updateSalaryStats() {
    const salaries = employees.map(emp => emp.salary || 0).filter(salary => salary > 0);
    
    const salaryAvgElement = document.getElementById('salaryAvg');
    if (!salaryAvgElement) return; // Only update if on salary page

    if (salaries.length === 0) {
        // Reset stats if no salary data
        salaryAvgElement.textContent = '$0';
        document.getElementById('salaryMax').textContent = '$0';
        document.getElementById('salaryTotal').textContent = '$0';
        document.getElementById('salaryMedian').textContent = '$0';
        document.getElementById('salaryAvgChange').textContent = 'N/A';
        document.getElementById('salaryMaxHolder').textContent = 'No data';
        document.getElementById('salaryTotalEmployees').textContent = '0 employees';
        document.getElementById('salaryRange').textContent = '$0 - $0';
        return;
    }
    
    const avgSalary = Math.round(salaries.reduce((sum, salary) => sum + salary, 0) / salaries.length);
    const totalSalary = salaries.reduce((sum, salary) => sum + salary, 0);
    const highestSalary = Math.max(...salaries);
    const lowestSalary = Math.min(...salaries);
    
    // Calculate median
    const sortedSalaries = [...salaries].sort((a, b) => a - b);
    const medianSalary = sortedSalaries.length % 2 === 0 
        ? (sortedSalaries[sortedSalaries.length / 2 - 1] + sortedSalaries[sortedSalaries.length / 2]) / 2
        : sortedSalaries[Math.floor(sortedSalaries.length / 2)];
    
    // Find highest salary holder
    const highestSalaryHolder = employees.find(emp => emp.salary === highestSalary);
    
    salaryAvgElement.textContent = `$${avgSalary.toLocaleString()}`;
    document.getElementById('salaryMax').textContent = `$${highestSalary.toLocaleString()}`;
    document.getElementById('salaryTotal').textContent = `$${totalSalary.toLocaleString()}`;
    document.getElementById('salaryMedian').textContent = `$${Math.round(medianSalary).toLocaleString()}`;
    
    // Placeholder for actual change calculation
    document.getElementById('salaryAvgChange').textContent = '+5.2% from last month';
    document.getElementById('salaryMaxHolder').textContent = highestSalaryHolder ? highestSalaryHolder.name : 'No data';
    document.getElementById('salaryTotalEmployees').textContent = `${salaries.length} employees`;
    document.getElementById('salaryRange').textContent = `$${lowestSalary.toLocaleString()} - $${highestSalary.toLocaleString()}`;
}

function loadRecentActivities() {
    const activities = [
        { type: 'salary_updated', message: 'Sarah Wilson\'s salary updated to $65,000', time: '2 hours ago' },
        { type: 'employee_added', message: 'New employee Emily Davis joined Finance department', time: '4 hours ago' },
        { type: 'salary_updated', message: 'John Doe received 5% salary increase', time: '1 day ago' },
        { type: 'bulk_update', message: 'Applied 3% salary increase to Engineering department', time: '2 days ago' },
        { type: 'employee_updated', message: 'David Brown\'s position updated to Senior Developer', time: '3 days ago' }
    ];

    const container = document.getElementById('recentActivities');
    if (!container) return; // Ensure container exists

    container.innerHTML = activities.map(activity => `
        <div class="activity-item">
            <div class="activity-icon ${getActivityIconClass(activity.type)}">
                <i class="${getActivityIcon(activity.type)}"></i>
            </div>
            <div>
                <p>${activity.message}</p>
                <small>${activity.time}</small>
            </div>
        </div>
    `).join('');
}

function getActivityIcon(type) {
    const icons = {
        'employee_added': 'fas fa-user-plus',
        'employee_updated': 'fas fa-user-edit',
        'employee_deleted': 'fas fa-user-minus',
        'department_updated': 'fas fa-building',
        'department_added': 'fas fa-plus',
        'salary_updated': 'fas fa-dollar-sign',
        'bulk_update': 'fas fa-chart-line'
    };
    return icons[type] || 'fas fa-info-circle';
}

function getActivityIconClass(type) {
    const classes = {
        'employee_added': 'bg-success',
        'employee_updated': 'bg-info',
        'employee_deleted': 'bg-danger',
        'department_updated': 'bg-warning',
        'department_added': 'bg-primary',
        'salary_updated': 'bg-success',
        'bulk_update': 'bg-primary'
    };
    return classes[type] || 'bg-secondary';
}

// Employee functions
function renderEmployees() {
    const startIndex = (currentPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    const pageEmployees = filteredEmployees.slice(startIndex, endIndex);

    const tbody = document.getElementById('employeesTableBody');
    if (!tbody) return; // Ensure tbody exists before rendering

    tbody.innerHTML = pageEmployees.map(employee => `
        <tr>
            <td>
                <img src="${employee.photo || getDefaultAvatar()}" 
                     alt="${employee.name}" 
                     class="employee-photo"
                     onerror="this.src='${getDefaultAvatar()}'">
            </td>
            <td>${employee.name}</td>
            <td>${employee.email}</td>
            <td>${employee.phone}</td>
            <td>${employee.department}</td>
            <td>${employee.position}</td>
            <td>$${(employee.salary || 0).toLocaleString()}</td>
            <td>${formatDate(employee.joining_date)}</td>
            <td class="action-buttons-cell">
                <button class="btn-edit" onclick="editEmployee(${employee.id})">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-edit" onclick="updateEmployeeSalary(${employee.id})" title="Update Salary">
                    <i class="fas fa-dollar-sign"></i>
                </button>
                <button class="btn-delete" onclick="deleteEmployee(${employee.id})">
                    <i class="fas fa-trash"></i>
                </button>
            </td>
        </tr>
    `).join('');

    renderPagination();
}

function filterEmployees() {
    const searchTerm = document.getElementById('employeeSearch')?.value.toLowerCase();
    const departmentFilter = document.getElementById('departmentFilter')?.value;
    const salaryFilter = document.getElementById('salaryFilter')?.value;

    filteredEmployees = employees.filter(employee => {
        const matchesSearch = (searchTerm === undefined || employee.name.toLowerCase().includes(searchTerm) ||
                            employee.email.toLowerCase().includes(searchTerm) ||
                            employee.position.toLowerCase().includes(searchTerm));
        
        const matchesDepartment = (departmentFilter === undefined || !departmentFilter || employee.department_id == departmentFilter);
        
        let matchesSalary = true;
        if (salaryFilter) {
            const salary = employee.salary || 0;
            switch (salaryFilter) {
                case '0-50000':
                    matchesSalary = salary >= 0 && salary <= 50000;
                    break;
                case '50000-75000':
                    matchesSalary = salary > 50000 && salary <= 75000;
                    break;
                case '75000-100000':
                    matchesSalary = salary > 75000 && salary <= 100000;
                    break;
                case '100000+':
                    matchesSalary = salary > 100000;
                    break;
            }
        }
        
        return matchesSearch && matchesDepartment && matchesSalary;
    });

    currentPage = 1; // Reset to first page after filtering
    renderEmployees();
}

function renderPagination() {
    const totalPages = Math.ceil(filteredEmployees.length / itemsPerPage);
    const pagination = document.getElementById('employeePagination');
    
    if (!pagination) return; // Ensure pagination element exists

    if (totalPages <= 1) {
        pagination.innerHTML = '';
        return;
    }

    let paginationHTML = '';
    
    // Previous button
    paginationHTML += `
        <button onclick="changePage(${currentPage - 1})" ${currentPage === 1 ? 'disabled' : ''}>
            <i class="fas fa-chevron-left"></i>
        </button>
    `;

    // Page numbers
    // Logic to show a limited number of pages around the current page
    const maxPagesToShow = 5;
    let startPage = Math.max(1, currentPage - Math.floor(maxPagesToShow / 2));
    let endPage = Math.min(totalPages, startPage + maxPagesToShow - 1);

    if (endPage - startPage + 1 < maxPagesToShow) {
        startPage = Math.max(1, endPage - maxPagesToShow + 1);
    }

    if (startPage > 1) {
        paginationHTML += `<button onclick="changePage(1)">1</button>`;
        if (startPage > 2) {
            paginationHTML += `<span>...</span>`;
        }
    }

    for (let i = startPage; i <= endPage; i++) {
        paginationHTML += `
            <button onclick="changePage(${i})" class="${i === currentPage ? 'active' : ''}">
                ${i}
            </button>
        `;
    }

    if (endPage < totalPages) {
        if (endPage < totalPages - 1) {
            paginationHTML += `<span>...</span>`;
        }
        paginationHTML += `<button onclick="changePage(${totalPages})">${totalPages}</button>`;
    }

    // Next button
    paginationHTML += `
        <button onclick="changePage(${currentPage + 1})" ${currentPage === totalPages ? 'disabled' : ''}>
            <i class="fas fa-chevron-right"></i>
        </button>
    `;

    pagination.innerHTML = paginationHTML;
}

function changePage(page) {
    const totalPages = Math.ceil(filteredEmployees.length / itemsPerPage);
    if (page >= 1 && page <= totalPages) {
        currentPage = page;
        renderEmployees();
    }
}

// Salary Management Functions
function initializeSalaryCharts() {
    // Destroy existing charts to prevent duplicates
    Object.values(salaryCharts).forEach(chart => {
        if (chart) chart.destroy();
    });
    
    // Create salary distribution chart
    createSalaryDistributionChart();
    
    // Create department salary chart
    createDepartmentSalaryChart();
}

function createSalaryDistributionChart() {
    const ctx = document.getElementById('salaryDistributionChart');
    if (!ctx) return;
    
    const salaries = employees.map(emp => emp.salary || 0).filter(salary => salary > 0);
    const ranges = [
        { min: 0, max: 50000, label: '$0 - $50K' },
        { min: 50000, max: 75000, label: '$50K - $75K' },
        { min: 75000, max: 100000, label: '$75K - $100K' },
        { min: 100000, max: 125000, label: '$100K - $125K' },
        { min: 125000, max: Infinity, label: '$125K+' }
    ];
    
    const data = ranges.map(range => {
        return salaries.filter(salary => salary >= range.min && salary < range.max).length;
    });
    
    const labels = ranges.map(range => range.label);
    
    salaryCharts.distribution = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                data: data,
                backgroundColor: [
                    '#3B82F6', // Primary
                    '#10B981', // Success
                    '#F59E0B', // Warning
                    '#EF4444', // Danger
                    '#8B5CF6'  // Purple
                ],
                borderWidth: 2,
                borderColor: getComputedStyle(document.body).getPropertyValue('--bg-primary')
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        color: getComputedStyle(document.body).getPropertyValue('--text-primary'),
                        padding: 20,
                        usePointStyle: true
                    }
                }
            }
        }
    });
}

function createDepartmentSalaryChart() {
    const ctx = document.getElementById('departmentSalaryChart');
    if (!ctx) return;
    
    const deptData = departments.map(dept => {
        const deptEmployees = employees.filter(emp => emp.department_id === dept.id);
        const avgSalary = deptEmployees.length > 0 
            ? deptEmployees.reduce((sum, emp) => sum + (emp.salary || 0), 0) / deptEmployees.length
            : 0;
        return {
            department: dept.name,
            avgSalary: avgSalary,
            employeeCount: deptEmployees.length
        };
    }).filter(data => data.employeeCount > 0); // Only include departments with employees
    
    salaryCharts.department = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: deptData.map(d => d.department),
            datasets: [{
                label: 'Average Salary',
                data: deptData.map(d => d.avgSalary),
                backgroundColor: '#3B82F6', // Primary color
                borderColor: '#2563EB',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        color: getComputedStyle(document.body).getPropertyValue('--text-primary'),
                        callback: function(value) {
                            return '$' + value.toLocaleString();
                        }
                    },
                    grid: {
                        color: getComputedStyle(document.body).getPropertyValue('--border-color')
                    }
                },
                x: {
                    ticks: {
                        color: getComputedStyle(document.body).getPropertyValue('--text-primary')
                    },
                    grid: {
                        color: getComputedStyle(document.body).getPropertyValue('--border-color')
                    }
                }
            },
            plugins: {
                legend: {
                    labels: {
                        color: getComputedStyle(document.body).getPropertyValue('--text-primary')
                    }
                }
            }
        }
    });
}

function updateChartsTheme() {
    Object.values(salaryCharts).forEach(chart => {
        if (chart) {
            const textColor = getComputedStyle(document.body).getPropertyValue('--text-primary');
            const borderColor = getComputedStyle(document.body).getPropertyValue('--border-color');
            
            // Update chart options
            if (chart.options.scales) {
                if (chart.options.scales.y) {
                    chart.options.scales.y.ticks.color = textColor;
                    chart.options.scales.y.grid.color = borderColor;
                }
                if (chart.options.scales.x) {
                    chart.options.scales.x.ticks.color = textColor;
                    chart.options.scales.x.grid.color = borderColor;
                }
            }
            
            if (chart.options.plugins && chart.options.plugins.legend) {
                chart.options.plugins.legend.labels.color = textColor;
            }

            // For doughnut chart, update border color of segments
            if (chart.config.type === 'doughnut' && chart.data.datasets.length > 0) {
                chart.data.datasets[0].borderColor = getComputedStyle(document.body).getPropertyValue('--bg-primary');
            }
            
            chart.update();
        }
    });
}

function renderSalaryTable() {
    const tbody = document.getElementById('salaryTableBody');
    if (!tbody) return;
    
    tbody.innerHTML = employees.map(employee => `
        <tr>
            <td>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <img src="${employee.photo || getDefaultAvatar()}" 
                         alt="${employee.name}" 
                         class="employee-photo"
                         onerror="this.src='${getDefaultAvatar()}'">
                    <span>${employee.name}</span>
                </div>
            </td>
            <td>${employee.department}</td>
            <td>${employee.position}</td>
            <td>$${(employee.salary || 0).toLocaleString()}</td>
            <td>${employee.last_salary_update ? formatDate(employee.last_salary_update) : 'Never'}</td>
            <td class="action-buttons-cell">
                <button class="btn-edit" onclick="updateEmployeeSalary(${employee.id})">
                    <i class="fas fa-edit"></i>
                </button>
                <button class="btn-edit" onclick="viewSalaryHistory(${employee.id})" title="View History">
                    <i class="fas fa-history"></i>
                </button>
            </td>
        </tr>
    `).join('');
}

// Salary Update Functions
function updateEmployeeSalary(employeeId) {
    const employee = employees.find(emp => emp.id === employeeId);
    if (!employee) return;

    document.getElementById('salaryEmployeeId').value = employee.id;
    document.getElementById('salaryEmployeeName').value = employee.name;
    document.getElementById('currentSalary').value = employee.salary || 0;
    document.getElementById('newSalary').value = ''; // Clear new salary field
    document.getElementById('salaryReason').value = ''; // Clear reason field
    document.getElementById('salaryEffectiveDate').valueAsDate = new Date(); // Set current date

    document.getElementById('salaryModal').classList.add('active');
}

function handleSalarySubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const employeeId = parseInt(formData.get('employee_id'));
    const newSalary = parseFloat(formData.get('new_salary'));
    const reason = formData.get('reason');
    const effectiveDate = formData.get('effective_date');
    
    const employee = employees.find(emp => emp.id === employeeId);
    if (!employee) {
        showNotification('Employee not found!', 'error');
        return;
    }

    if (isNaN(newSalary) || newSalary < 0) {
        showNotification('Please enter a valid new salary.', 'error');
        return;
    }
    
    const oldSalary = employee.salary || 0;
    
    // Update employee salary
    employee.salary = newSalary;
    employee.last_salary_update = effectiveDate;
    
    // Add to salary history
    salaryHistory.push({
        employee_id: employeeId,
        old_salary: oldSalary,
        new_salary: newSalary,
        reason: reason,
        date: effectiveDate
    });
    
    showNotification(`Salary updated for ${employee.name}`, 'success');
    closeModal('salaryModal');
    
    // Update all displays
    updateDashboardStats();
    renderEmployees();
    renderSalaryTable();
    loadRecentActivities();
    
    // Update charts if salary section is active
    if (document.getElementById('salary')?.classList.contains('active')) {
        initializeSalaryCharts();
    }
}

// Bulk Salary Update Functions
function showBulkSalaryUpdateModal() {
    document.getElementById('bulkSalaryForm').reset();
    document.getElementById('bulkUpdateType').value = ''; // Reset dropdown
    document.getElementById('bulkUpdateValue').value = '';
    document.getElementById('bulkReason').value = '';
    document.getElementById('bulkEffectiveDate').valueAsDate = new Date();
    document.getElementById('bulkPreviewContent').innerHTML = '';
    document.getElementById('bulkDepartmentGroup').style.display = 'none'; // Hide department filter initially
    document.getElementById('bulkUpdateHint').textContent = 'Enter percentage (e.g., 5 for 5%) or fixed amount'; // Reset hint
    
    document.getElementById('bulkSalaryModal').classList.add('active');
}

function handleBulkUpdateTypeChange() {
    const updateType = document.getElementById('bulkUpdateType')?.value;
    const departmentGroup = document.getElementById('bulkDepartmentGroup');
    const hint = document.getElementById('bulkUpdateHint');
    
    if (updateType === 'department') {
        departmentGroup.style.display = 'block';
        hint.textContent = 'Enter percentage (e.g., 5 for 5%) or fixed amount for selected department.';
    } else if (updateType === 'percentage') {
        departmentGroup.style.display = 'none';
        hint.textContent = 'Enter percentage (e.g., 5 for 5%) for all employees.';
    } else if (updateType === 'fixed') {
        departmentGroup.style.display = 'none';
        hint.textContent = 'Enter fixed amount (e.g., 5000 for $5,000) for all employees.';
    } else {
        departmentGroup.style.display = 'none';
        hint.textContent = 'Enter percentage (e.g., 5 for 5%) or fixed amount';
    }
    
    updateBulkPreview(); // Update preview when type changes
}

function updateBulkPreview() {
    const updateType = document.getElementById('bulkUpdateType')?.value;
    const updateValue = parseFloat(document.getElementById('bulkUpdateValue')?.value) || 0;
    const departmentId = document.getElementById('bulkDepartment')?.value;
    
    const bulkPreviewContent = document.getElementById('bulkPreviewContent');
    if (!bulkPreviewContent) return;

    if (!updateType || updateValue <= 0) {
        bulkPreviewContent.innerHTML = '<p>Enter update type and value to see preview.</p>';
        return;
    }
    
    let targetEmployees = employees;
    if (updateType === 'department' && departmentId) {
        targetEmployees = employees.filter(emp => emp.department_id == departmentId);
    } else if (updateType === 'department' && !departmentId) {
        bulkPreviewContent.innerHTML = '<p>Please select a department for "By Department" update.</p>';
        return;
    }
    
    if (targetEmployees.length === 0) {
        bulkPreviewContent.innerHTML = '<p>No employees found for this selection.</p>';
        return;
    }

    const previewItems = targetEmployees.slice(0, 5).map(emp => {
        let newSalary = emp.salary || 0;
        if (updateType === 'percentage' || (updateType === 'department' && updateValue > 0)) {
            newSalary = emp.salary * (1 + updateValue / 100);
        } else if (updateType === 'fixed' || (updateType === 'department' && updateValue > 0)) {
            newSalary = emp.salary + updateValue;
        }
        
        const increase = newSalary - emp.salary;
        return `
            <div class="bulk-preview-item">
                <span class="employee-name">${emp.name}</span>
                <span class="salary-change">+$${increase.toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 0})}</span>
            </div>
        `;
    }).join('');
    
    const totalEmployeesAffected = targetEmployees.length;
    let previewHTML = `
        <div class="bulk-preview-item">
            <span class="employee-name">Total employees affected: ${totalEmployeesAffected}</span>
        </div>
        ${previewItems}
    `;
    
    if (totalEmployeesAffected > 5) {
        previewHTML += `<div class="bulk-preview-item"><span class="employee-name">... and ${totalEmployeesAffected - 5} more</span></div>`;
    }
    
    bulkPreviewContent.innerHTML = previewHTML;
}

function handleBulkSalarySubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const updateType = formData.get('update_type');
    const updateValue = parseFloat(formData.get('update_value'));
    const departmentId = formData.get('department_id');
    const reason = formData.get('reason');
    const effectiveDate = formData.get('effective_date');

    if (!updateType || isNaN(updateValue) || updateValue <= 0) {
        showNotification('Please select an update type and enter a valid positive value.', 'error');
        return;
    }

    let targetEmployees = employees;
    if (updateType === 'department') {
        if (!departmentId) {
            showNotification('Please select a department for "By Department" update.', 'error');
            return;
        }
        targetEmployees = employees.filter(emp => emp.department_id == departmentId);
    }
    
    if (targetEmployees.length === 0) {
        showNotification('No employees found to apply bulk update.', 'warning');
        closeModal('bulkSalaryModal');
        return;
    }

    let updatedCount = 0;
    targetEmployees.forEach(emp => {
        const oldSalary = emp.salary || 0;
        let newSalary = oldSalary;
        
        if (updateType === 'percentage' || updateType === 'department') {
            newSalary = oldSalary * (1 + updateValue / 100);
        } else if (updateType === 'fixed') {
            newSalary = oldSalary + updateValue;
        }
        
        // Ensure salary doesn't go below zero
        newSalary = Math.max(0, newSalary);

        if (newSalary !== oldSalary) {
            emp.salary = newSalary;
            emp.last_salary_update = effectiveDate;
            
            // Add to salary history
            salaryHistory.push({
                employee_id: emp.id,
                old_salary: oldSalary,
                new_salary: newSalary,
                reason: reason,
                date: effectiveDate
            });
            
            updatedCount++;
        }
    });
    
    showNotification(`Updated salaries for ${updatedCount} employees`, 'success');
    closeModal('bulkSalaryModal');
    
    // Update all displays
    updateDashboardStats();
    renderEmployees();
    renderSalaryTable();
    loadRecentActivities();
    
    // Update charts if salary section is active
    if (document.getElementById('salary')?.classList.contains('active')) {
        initializeSalaryCharts();
    }
}

// Department functions
function renderDepartments() {
    const container = document.getElementById('departmentsGrid');
    if (!container) return; // Ensure container exists

    container.innerHTML = departments.map(department => `
        <div class="department-card">
            <div class="department-header">
                <div>
                    <h3 class="department-name">${department.name}</h3>
                    <p class="department-description">${department.description}</p>
                </div>
                <div class="department-actions">
                    <button class="btn-edit" onclick="editDepartment(${department.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn-delete" onclick="deleteDepartment(${department.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            <div class="department-stats">
                <span class="department-employees">${department.employee_count} employees</span>
            </div>
        </div>
    `).join('');
}

function loadDepartmentsForSelect() {
    const employeeSelect = document.getElementById('employeeDepartment');
    const filterSelect = document.getElementById('departmentFilter');
    const bulkDepartmentSelect = document.getElementById('bulkDepartment');
    
    // Clear previous options
    if (employeeSelect) employeeSelect.innerHTML = '<option value="">Select Department</option>';
    if (filterSelect) filterSelect.innerHTML = '<option value="">All Departments</option>';
    if (bulkDepartmentSelect) bulkDepartmentSelect.innerHTML = '<option value="">All Departments</option>';

    const options = departments.map(dept => 
        `<option value="${dept.id}">${dept.name}</option>`
    ).join('');
    
    if (employeeSelect) employeeSelect.innerHTML += options;
    if (filterSelect) filterSelect.innerHTML += options;
    if (bulkDepartmentSelect) bulkDepartmentSelect.innerHTML += options;
}

// Modal functions
function showAddEmployeeModal() {
    document.getElementById('employeeModalTitle').textContent = 'Add New Employee';
    document.getElementById('employeeForm').reset();
    document.getElementById('employeeId').value = ''; // Clear hidden ID for new entry
    document.getElementById('photoPreview').innerHTML = ''; // Clear photo preview
    document.getElementById('employeeJoiningDate').valueAsDate = new Date(); // Set current date
    document.getElementById('employeeModal').classList.add('active');
}

function showAddDepartmentModal() {
    document.getElementById('departmentModalTitle').textContent = 'Add New Department';
    document.getElementById('departmentForm').reset();
    document.getElementById('departmentId').value = ''; // Clear hidden ID for new entry
    document.getElementById('departmentModal').classList.add('active');
}

function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('active');
    }
}

function handlePhotoPreview(e) {
    const file = e.target.files[0];
    const preview = document.getElementById('photoPreview');
    
    if (!preview) return;

    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            preview.innerHTML = `<img src="${e.target.result}" alt="Preview">`;
        };
        reader.readAsDataURL(file);
    } else {
        preview.innerHTML = '';
    }
}

// Form handlers
function handleEmployeeSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const employeeId = formData.get('id');
    const employeeData = {
        id: employeeId ? parseInt(employeeId) : Date.now(), // Use existing ID or generate new
        name: formData.get('name'),
        email: formData.get('email'),
        phone: formData.get('phone'),
        department_id: parseInt(formData.get('department_id')),
        position: formData.get('position'),
        salary: parseFloat(formData.get('salary')) || 0,
        joining_date: formData.get('joining_date'),
        photo: null, // For simplicity, photo handling is basic (not saving actual file)
        last_salary_update: employeeId ? employees.find(emp => emp.id === parseInt(employeeId))?.last_salary_update : new Date().toISOString().split('T')[0]
    };

    // Get department name
    const department = departments.find(d => d.id === employeeData.department_id);
    employeeData.department = department ? department.name : '';

    if (employeeId) {
        // Update existing employee
        const index = employees.findIndex(emp => emp.id == employeeId);
        if (index !== -1) {
            employees[index] = { ...employees[index], ...employeeData };
            showNotification('Employee updated successfully!', 'success');
        } else {
            showNotification('Employee not found for update!', 'error');
        }
    } else {
        // Add new employee
        employees.push(employeeData);
        showNotification('Employee added successfully!', 'success');
    }

    // Update department employee counts
    departments.forEach(dept => {
        dept.employee_count = employees.filter(emp => emp.department_id === dept.id).length;
    });

    closeModal('employeeModal');
    updateDashboardStats();
    filterEmployees(); // Re-filter and render employees to update table
    renderSalaryTable();
    renderDepartments(); // Update department counts on dashboard
    loadRecentActivities();
}

function handleDepartmentSubmit(e) {
    e.preventDefault();
    
    const formData = new FormData(e.target);
    const departmentId = formData.get('id');
    const departmentData = {
        id: departmentId ? parseInt(departmentId) : Date.now(),
        name: formData.get('name'),
        description: formData.get('description'),
        employee_count: 0 // Will be updated based on existing employees
    };

    if (departmentId) {
        // Update existing department
        const index = departments.findIndex(dept => dept.id == departmentId);
        if (index !== -1) {
            departments[index] = { ...departments[index], ...departmentData };
            showNotification('Department updated successfully!', 'success');
        } else {
            showNotification('Department not found for update!', 'error');
        }
    } else {
        // Add new department
        departments.push(departmentData);
        showNotification('Department added successfully!', 'success');
    }

    // Recalculate employee counts for all departments
    departments.forEach(dept => {
        dept.employee_count = employees.filter(emp => emp.department_id === dept.id).length;
    });

    closeModal('departmentModal');
    loadDepartmentsForSelect(); // Update dropdowns
    renderDepartments(); // Re-render departments grid
    updateDashboardStats(); // Update dashboard stats
    loadRecentActivities();
}

// CRUD operations
function editEmployee(id) {
    const employee = employees.find(emp => emp.id === id);
    if (!employee) {
        showNotification('Employee not found!', 'error');
        return;
    }

    document.getElementById('employeeModalTitle').textContent = 'Edit Employee';
    document.getElementById('employeeId').value = employee.id;
    document.getElementById('employeeName').value = employee.name;
    document.getElementById('employeeEmail').value = employee.email;
    document.getElementById('employeePhone').value = employee.phone;
    document.getElementById('employeeDepartment').value = employee.department_id;
    document.getElementById('employeePosition').value = employee.position;
    document.getElementById('employeeSalary').value = employee.salary || '';
    document.getElementById('employeeJoiningDate').value = employee.joining_date;
    
    if (employee.photo) {
        document.getElementById('photoPreview').innerHTML = `<img src="${employee.photo}" alt="Preview">`;
    } else {
        document.getElementById('photoPreview').innerHTML = '';
    }

    document.getElementById('employeeModal').classList.add('active');
}

function deleteEmployee(id) {
    if (confirm('Are you sure you want to delete this employee?')) {
        const initialEmployeeCount = employees.length;
        employees = employees.filter(emp => emp.id !== id);
        filteredEmployees = filteredEmployees.filter(emp => emp.id !== id); // Also update filtered list
        
        if (employees.length < initialEmployeeCount) {
            showNotification('Employee deleted successfully!', 'success');
            // Update department employee counts
            departments.forEach(dept => {
                dept.employee_count = employees.filter(emp => emp.department_id === dept.id).length;
            });
            updateDashboardStats();
            filterEmployees(); // Re-filter and render to update table and pagination
            renderSalaryTable();
            renderDepartments(); // Update department counts on dashboard
            loadRecentActivities();
        } else {
            showNotification('Employee not found for deletion.', 'error');
        }
    }
}

function editDepartment(id) {
    const department = departments.find(dept => dept.id === id);
    if (!department) {
        showNotification('Department not found!', 'error');
        return;
    }

    document.getElementById('departmentModalTitle').textContent = 'Edit Department';
    document.getElementById('departmentId').value = department.id;
    document.getElementById('departmentName').value = department.name;
    document.getElementById('departmentDescription').value = department.description;

    document.getElementById('departmentModal').classList.add('active');
}

function deleteDepartment(id) {
    const department = departments.find(dept => dept.id === id);
    if (!department) {
        showNotification('Department not found!', 'error');
        return;
    }

    // Check if department has employees
    const employeesInDept = employees.filter(emp => emp.department_id === id);
    if (employeesInDept.length > 0) {
        showNotification(`Cannot delete department "${department.name}" because it has ${employeesInDept.length} employee(s).`, 'error');
        return;
    }

    if (confirm(`Are you sure you want to delete the department "${department.name}"?`)) {
        const initialDepartmentCount = departments.length;
        departments = departments.filter(dept => dept.id !== id);
        
        if (departments.length < initialDepartmentCount) {
            showNotification('Department deleted successfully!', 'success');
            loadDepartmentsForSelect(); // Update dropdowns
            renderDepartments(); // Re-render departments grid
            updateDashboardStats(); // Update dashboard stats
            loadRecentActivities();
        } else {
            showNotification('Department not found for deletion.', 'error');
        }
    }
}

// Utility functions
function formatDate(dateString) {
    if (!dateString) return '';
    try {
        return new Date(dateString).toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' });
    } catch (e) {
        console.error("Invalid date string:", dateString, e);
        return dateString; // Return original if invalid
    }
}

function getDefaultAvatar() {
    // Create a simple SVG avatar with initials
    return 'data:image/svg+xml;base64,' + btoa(`
        <svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">
            <circle cx="20" cy="20" r="20" fill="#e2e8f0"/>
            <circle cx="20" cy="16" r="6" fill="#94a3b8"/>
            <path d="M8 32c0-6.627 5.373-12 12-12s12 5.373 12 12" fill="#94a3b8"/>
        </svg>
    `);
}

function showNotification(message, type = 'info') {
    const container = document.getElementById('notificationContainer');
    if (!container) return;

    const notification = document.createElement('div');
    notification.className = `notification ${type}`;
    notification.innerHTML = `
        <div style="display: flex; justify-content: space-between; align-items: center;">
            <span>${message}</span>
            <button onclick="this.parentElement.parentElement.remove()" style="background: none; border: none; color: inherit; cursor: pointer;">
                <i class="fas fa-times"></i>
            </button>
        </div>
    `;
    
    container.appendChild(notification);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (notification.parentElement) {
            notification.remove();
        }
    }, 5000);
}

function showSalaryReport() {
    // Generate comprehensive salary report
    const salaries = employees.map(emp => emp.salary || 0).filter(salary => salary > 0);
    const totalSalary = salaries.reduce((sum, salary) => sum + salary, 0);
    const avgSalary = salaries.length > 0 ? totalSalary / salaries.length : 0;
    const maxSalary = salaries.length > 0 ? Math.max(...salaries) : 0;
    const minSalary = salaries.length > 0 ? Math.min(...salaries) : 0;
    
    let report = `
Salary Report - ${new Date().toLocaleDateString()}

Total Employees with Salary Data: ${salaries.length}
Total Payroll: $${totalSalary.toLocaleString()}
Average Salary: $${avgSalary.toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 0})}
Highest Salary: $${maxSalary.toLocaleString()}
Lowest Salary: $${minSalary.toLocaleString()}
Salary Range: $${(maxSalary - minSalary).toLocaleString()}

Department Breakdown:
`;
    departments.forEach(dept => {
        const deptEmployees = employees.filter(emp => emp.department_id === dept.id);
        const deptSalaries = deptEmployees.map(emp => emp.salary || 0).filter(salary => salary > 0);
        const deptTotal = deptSalaries.reduce((sum, salary) => sum + salary, 0);
        const deptAvg = deptSalaries.length > 0 ? deptTotal / deptSalaries.length : 0;
        report += `${dept.name}: ${deptEmployees.length} employees, Avg: $${deptAvg.toLocaleString(undefined, {minimumFractionDigits: 0, maximumFractionDigits: 0})}\n`;
    });
    
    // Create and download report
    const blob = new Blob([report], { type: 'text/plain' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = `salary-report-${new Date().toISOString().split('T')[0]}.txt`;
    a.click();
    window.URL.revokeObjectURL(url);
    
    showNotification('Salary report generated successfully!', 'success');
}

function exportData() {
    // Create CSV content
    const headers = ['Name', 'Email', 'Phone', 'Department', 'Position', 'Salary', 'Joining Date', 'Last Salary Update'];
    const csvContent = [
        headers.join(','),
        ...employees.map(emp => [
            `"${emp.name}"`, // Enclose in quotes to handle commas in names
            `"${emp.email}"`,
            `"${emp.phone}"`,
            `"${emp.department}"`,
            `"${emp.position}"`,
            emp.salary || 0,
            emp.joining_date,
            emp.last_salary_update || ''
        ].join(','))
    ].join('\n');

    // Create and download file
    const blob = new Blob([csvContent], { type: 'text/csv' });
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'employees-salary-data.csv';
    a.click();
    window.URL.revokeObjectURL(url);
    
    showNotification('Data exported successfully!', 'success');
}

// Function to view salary history (placeholder)
function viewSalaryHistory(employeeId) {
    const employee = employees.find(emp => emp.id === employeeId);
    if (!employee) {
        showNotification('Employee not found.', 'error');
        return;
    }
    const history = salaryHistory.filter(item => item.employee_id === employeeId);
    let historyMessage = `Salary History for ${employee.name}:\n\n`;
    if (history.length === 0) {
        historyMessage += "No salary history available.";
    } else {
        history.forEach(item => {
            historyMessage += `Date: ${formatDate(item.date)}\n`;
            historyMessage += `Old Salary: $${item.old_salary.toLocaleString()}\n`;
            historyMessage += `New Salary: $${item.new_salary.toLocaleString()}\n`;
            historyMessage += `Reason: ${item.reason || 'N/A'}\n\n`;
        });
    }
    alert(historyMessage); // Simple alert for demo
    // In a real app, you'd open a modal with this history
}
