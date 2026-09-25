<?php
require __DIR__ . '/config/bootstrap.php';
if (!is_logged_in()) redirect('login.php');
$role = current_user()['role'];
redirect($role === 'admin' ? 'admin/dashboard.php' : ($role === 'hr' ? 'hr/dashboard.php' : 'employee/dashboard.php'));
