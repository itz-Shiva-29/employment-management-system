# Employment Management System

A responsive employee management system built with PHP and MySQL. The application runs locally with XAMPP; this repository also includes a static GitHub Pages preview.

## Live preview

**[Open the static EMS preview](https://itz-shiva-29.github.io/employment-management-system/)**

The preview uses fictional sample data and browser-only interactions. It does not provide real sign-in, save edits, or connect to a database. Use the PHP application below for the working system.

## Features

- Role-based workspaces for Administrator, HR staff, and Employee accounts.
- Hashed-password sign-in, sessions, CSRF checks, and server-side role checks.
- Employee directory with search, department and status filters, create/edit, and activation controls.
- Department management, attendance tracking, leave requests, and HR/admin review.
- Dashboards, CSV reports, activity log, employee self-service, and in-app notifications.
- Responsive layout with dark and light themes.

## Technology

- PHP 8.1 or later with PDO MySQL
- MySQL through XAMPP
- HTML, CSS, JavaScript, and Bootstrap 5.3.3

No Composer or npm build step is required. Bootstrap and Google Fonts load from CDNs.

## Run the working app locally

1. Place the project folder at `C:\xampp\htdocs\EMS`.
2. Start Apache and MySQL in the XAMPP Control Panel.
3. Open [phpMyAdmin](http://localhost/phpmyadmin/) and import `database/ems.sql`.
4. Select the `ems` database and import `database/seed.sql` for fictional development data and sample accounts.
5. Open [http://localhost/EMS/](http://localhost/EMS/).

**Database warning:** `database/ems.sql` drops and recreates EMS tables. Back up existing data before importing it again. Seed accounts are only for local development; change or deactivate them before any public deployment.

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

## Security and scope

The local XAMPP configuration uses MySQL `root` with a blank password. Do not use these credentials or the development seed accounts on a public PHP host. Keep real employee records off free portfolio hosting.

The app does not include payroll, recruitment, leave-balance calculations, password reset, multi-factor authentication, or profile-photo uploads. Leave policy and attendance schedules are not calculated.
