# Employment Management System

A responsive employee management web application built with PHP and MySQL for local development in XAMPP. The interface uses a dark portfolio style with a light theme option and responsive layouts.

## Features

- Role-based workspaces for Administrator, HR staff, and Employee accounts.
- Secure sign-in and sign-out with hashed passwords, session expiry, CSRF checks, and server-side role checks.
- Employee directory with search, department and status filters, employee creation, editing, and activation/deactivation.
- Department records with employee counts and active/inactive status.
- Employee check-in/check-out, staff-entered attendance, daily statuses, date filters, and history.
- Leave requests, HR/admin review, request status, and in-app notifications.
- Dashboards, CSV reports for people, attendance, and leave, plus an administrator activity log.
- Employee self-service for profile contact details, attendance, leave, and notifications.
- Responsive sidebar, dark/light theme, and browser-side UI interactions.

## Technology

- PHP 8.1 or later with PDO MySQL
- MySQL through XAMPP
- HTML, CSS, JavaScript, and Bootstrap 5.3.3
- No Composer or npm build step is required

Bootstrap and Google Fonts are loaded from CDNs. System fonts are used as fallbacks.

## Local setup with XAMPP

1. Place the project folder at `C:\xampp\htdocs\EMS`.
2. Start Apache and MySQL in the XAMPP Control Panel.
3. Open [phpMyAdmin](http://localhost/phpmyadmin/) and import `database/ems.sql`.
4. Select the `ems` database and import `database/seed.sql` to add fictional departments, employees, and development accounts.
5. Check `config/database.php` if your local MySQL connection differs from the XAMPP defaults.
6. Open [http://localhost/EMS/](http://localhost/EMS/).

**Database warning:** `database/ems.sql` drops and recreates EMS tables. Back up existing EMS data before importing it again. The seed file is for local development; change or deactivate its sample accounts before making the app reachable outside your computer.

## Roles

| Role | Main access |
| --- | --- |
| Administrator | Dashboard, people, departments, attendance, leave, reports, user access, activity, and settings |
| HR | Dashboard, people, departments, attendance, leave, and reports |
| Employee | Dashboard, own profile, attendance, leave requests, and notifications |

## Documentation

- [Complete project documentation](docs/EMS_Complete_Project_Documentation.docx)
- [XAMPP setup guide](docs/EMS_XAMPP_Setup_Guide.docx)
- [EMS user guide](docs/EMS_User_Guide.docx)

## Security and current scope

This project is configured for local XAMPP use. The default database configuration uses MySQL `root` with a blank password. Do not use these settings or development seed accounts on a public server. A production deployment needs secure database credentials, HTTPS, backups, and an operational security review.

The current app does not include payroll, recruitment, leave-balance calculations, password reset, multi-factor authentication, or profile-photo uploads. Leave policy and attendance schedules are not calculated.
