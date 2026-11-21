# Employment Management System

A responsive employee management web application built with PHP and MySQL for local development in XAMPP. This repository also hosts a static portfolio preview with fictional sample data.

## Features

- Role-based workspaces for Administrator, HR staff, and Employee accounts.
- Secure sign-in and sign-out with hashed passwords, session expiry, CSRF checks, and server-side role checks.
- Employee directory with search, department and status filters, employee creation, editing, and activation/deactivation.
- Department records with employee counts and active/inactive status.
- Employee attendance status choices for Present, Absent, and On Break; staff-managed records, date filters, and history.
- Admin-managed public holiday calendar, with Sundays and configured holidays excluded from attendance and leave-day totals.
- Individual employee reports with attendance totals, salary, leave used, pending requests, and editable leave balances.
- Admin-posted notices and events visible in employee workspaces.
- Casual Leave (LWP), paid leave, and sick leave requests; admin can correct leave types and configure paid/sick entitlements.
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
4. Select the `ems` database and import `database/seed.sql` to create the local administrator, 18 common departments, and their job-title suggestions.
5. Check `config/database.php` if your local MySQL connection differs from the XAMPP defaults.
6. Open [http://localhost/EMS/](http://localhost/EMS/).

**Database warning:** `database/ems.sql` drops and recreates EMS tables. Back up existing EMS data before importing it again. The seed file creates one local administrator plus the standard IT-company department and job-title catalog. The local seed login is username `admin` (email `admin@ems.com`) and password `ADMIN@123`; change it before making the app reachable outside your computer. The local working database currently has 90 fictional sample employees (five per department), with attendance marked as sample data. Employee accounts are listed in `C:\xampp\private\EMS\employee-credentials.csv`, outside the web root.

## Project page

`index.html` is a static project page for [GitHub Pages](https://itz-shiva-29.github.io/employment-management-system/). It describes the features and roles, shows screenshots of the running application (fictional sample data), and explains how to run it locally. It has no sign-in, PHP processing, or database. Locally, the PHP application at `http://localhost/EMS/` is served by `index.php`, and the project page is at `http://localhost/EMS/index.html`.

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

This project is configured for local XAMPP use. The local database configuration uses MySQL `root` with a blank password. Do not use these settings or development seed accounts on a public PHP host. Keep real employee records off free portfolio hosting.

Payroll is managed by an administrator under **Payroll**. Configure each fixed salary structure, enter variable earnings and manual deductions per month, then issue the payslip. Salary for each month is paid on the 7th of the following month. The joining month is prorated by scheduled working days, excluding Sundays and configured public holidays. Employees can see only their own issued payslips. The payslip can be printed or saved as PDF using the browser print dialog. Payroll values are snapshots by month and can be re-issued by an administrator. The local app calculates employee PF at the configured 10% or 12% rate of its eligible wage base, with the current ₹25,000 ceiling, and Gujarat professional tax at ₹0 up to ₹12,000 monthly wages and ₹200 above that; admins can flag employee-specific EPF coverage and professional-tax exemption. Employer PF is disclosed separately and is not deducted from take-home pay. Statutory eligibility and exceptions should be checked before filing payroll returns. Existing employee salary values are preserved; payroll setup does not populate salaries automatically.

### Add payroll tables to an existing installation

Import `database/migrations/20261026_payroll.sql` in phpMyAdmin after selecting the existing `ems` database. This is an additive migration and does not delete employee data. For a fresh database, use the updated `database/ems.sql`.

Paid and sick leave entitlements are administrator-configured and start unset; Casual Leave (LWP) is unlimited and unpaid. Public-holiday dates must be entered by an administrator. Sundays and configured public holidays are excluded from leave-day totals, and attendance is blocked on those dates and before an employee’s joining date.
