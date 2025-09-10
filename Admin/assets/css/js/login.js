document.addEventListener('DOMContentLoaded', function() {
    const loginForm = document.getElementById('loginForm');
    const loginMessage = document.getElementById('loginMessage');

    loginForm.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(loginForm);
        const username = formData.get('username');
        const password = formData.get('password');

        // Basic validation
        if (!username || !password) {
            showMessage('Please fill in all fields', 'error');
            return;
        }

        // Show loading state
        const submitBtn = loginForm.querySelector('button[type="submit"]');
        const originalText = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Signing In...';
        submitBtn.disabled = true;

        // Simulate login request (replace with actual API call)
        setTimeout(() => {
            // For demo purposes, accept any username/password
            if (username && password) {
                showMessage('Login successful! Redirecting...', 'success');
                
                // Store user session (simplified for demo)
                localStorage.setItem('user', JSON.stringify({
                    username: username,
                    name: username === 'admin' ? 'Administrator' : username,
                    role: 'admin' // Assuming 'admin' role for demo
                }));
                
                // Redirect to dashboard
                setTimeout(() => {
                    window.location.href = 'dashboard.html';
                }, 1000);
            } else {
                showMessage('Invalid credentials. Please try again.', 'error');
                submitBtn.innerHTML = originalText;
                submitBtn.disabled = false;
            }
        }, 1500);
    });

    function showMessage(message, type) {
        loginMessage.textContent = message;
        loginMessage.className = `message ${type}`;
        
        // Clear message after 5 seconds
        setTimeout(() => {
            loginMessage.textContent = '';
            loginMessage.className = 'message';
        }, 5000);
    }

    // Check if user is already logged in
    const user = localStorage.getItem('user');
    if (user) {
        window.location.href = 'dashboard.html';
    }
});
