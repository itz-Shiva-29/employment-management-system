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
5. If your local MySQL connection differs from the XAMPP defaults (`root`, no password, database `ems`), copy `config/config.example.php` to `config/config.local.php` and edit it.
6. Open [http://localhost/EMS/](http://localhost/EMS/).

**Database warning:** `database/ems.sql` drops and recreates EMS tables. Back up existing EMS data before importing it again. The seed file creates one local administrator plus the standard IT-company department and job-title catalog. The starter login is username `admin` (email `admin@ems.com`) and password `ADMIN@123`. Signing in with it opens the **Account** page and shows a warning on every page until the password is changed there. The local working database currently has 90 fictional sample employees (five per department), with attendance marked as sample data. Employee accounts are listed in `C:\xampp\private\EMS\employee-credentials.csv`, outside the web root.

## Project page

`index.html` is a static project page for [GitHub Pages](https://itz-shiva-29.github.io/employment-management-system/). It describes the features and roles, shows screenshots of the running application (fictional sample data), and explains how to run it locally. It has no sign-in, PHP processing, or database. Locally, the PHP application at `http://localhost/EMS/` is served by `index.php`, and the project page is at `http://localhost/EMS/index.html`.

## Roles

| Role | Main access |
| --- | --- |
| Administrator | Dashboard, people, departments, attendance, leave, reports, payroll, user access, activity, settings, public holidays, and notices |
| HR | Dashboard, people, departments, attendance, leave, reports, and notices |
| Employee | Dashboard, own profile, attendance, leave requests, payslips, notices, calendar, and notifications |

Every role can change its own password from **Account** (the username in the sidebar or top bar).

## Documentation

- [Complete project documentation](docs/EMS_Complete_Project_Documentation.docx)
- [XAMPP setup guide](docs/EMS_XAMPP_Setup_Guide.docx)
- [EMS user guide](docs/EMS_User_Guide.docx)

## Host it online

Any web host with **PHP 8.1 or later**, **MySQL or MariaDB**, and **Apache** (most shared hosting) can run the app. GitHub Pages cannot, because it does not run PHP.

1. **Create a database** in your host's control panel. Note the host name, database name, user and password it gives you.
2. **Import the schema.** In the host's phpMyAdmin, select the new database and import `database/ems.sql`, then `database/seed.sql`. Shared hosts usually don't allow creating databases from SQL, so first delete the `CREATE DATABASE` and `USE ems;` lines at the top of `ems.sql`, and the `USE ems;` line at the top of `seed.sql`.
3. **Upload the files** to your site's web folder (often `public_html`) with the host's file manager, FTP, or Git. Include the hidden `.htaccess` files. Do not upload the `.git` folder.
4. **Add your settings.** Copy `config/config.example.php` to `config/config.local.php` on the server and fill in the database details from step 1. Keep `APP_DEBUG` at `0`. This file is never committed to Git. Hosts that use environment variables can set `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASS` and `APP_DEBUG` instead.
5. **Turn on HTTPS** in the control panel (most hosts offer a free certificate). The sign-in cookie is marked secure automatically on HTTPS.
6. **Sign in and change the password.** Open your site, sign in as `admin` with `ADMIN@123`, and change the password on the **Account** page straight away.
7. **Check the protection works.** Opening `/README.md`, `/database/ems.sql` or `/includes/functions.php` on your site should show "Forbidden".

If your host runs **Nginx** instead of Apache, `.htaccess` files are ignored. Ask the host to deny access to the `config`, `database` and `includes` folders, hidden files, and `.sql` and `.md` files.

To add sign-in limiting to an existing installation, import `database/migrations/20261121_login_attempts.sql`. (The app also creates the table automatically on the first sign-in attempt.)

## Security

- Passwords are stored as hashes. Every role can change its own password.
- After 5 failed sign-ins for the same account, or 20 from the same IP address, sign-in is paused for 15 minutes.
- Deactivated accounts are signed out on their next page load.
- Sessions end after 60 minutes of inactivity. The session cookie is HTTP-only, SameSite=Lax, and secure on HTTPS.
- Every form is protected against cross-site request forgery, and every page checks the role on the server.
- PHP errors are shown only when viewing from the same computer (XAMPP) or when `APP_DEBUG` is `1`.
- `.htaccess` files block hidden files, the `config`, `database` and `includes` folders, and `.sql`, `.md` and `.txt` files.

Keep real employee records off free hosting.

Payroll is managed by an administrator under **Payroll**. Configure each fixed salary structure, enter variable earnings and manual deductions per month, then issue the payslip. Salary for each month is paid on the 7th of the following month. The joining month is prorated by scheduled working days, excluding Sundays and configured public holidays. Employees can see only their own issued payslips. The payslip can be printed or saved as PDF using the browser print dialog. Payroll values are snapshots by month and can be re-issued by an administrator. The local app calculates employee PF at the configured 10% or 12% rate of its eligible wage base, with the current ₹25,000 ceiling, and Gujarat professional tax at ₹0 up to ₹12,000 monthly wages and ₹200 above that; admins can flag employee-specific EPF coverage and professional-tax exemption. Employer PF is disclosed separately and is not deducted from take-home pay. Statutory eligibility and exceptions should be checked before filing payroll returns. Existing employee salary values are preserved; payroll setup does not populate salaries automatically.

### Add payroll tables to an existing installation

Import `database/migrations/20261026_payroll.sql` in phpMyAdmin after selecting the existing `ems` database. This is an additive migration and does not delete employee data. For a fresh database, use the updated `database/ems.sql`.

Paid and sick leave entitlements are administrator-configured and start unset; Casual Leave (LWP) is unlimited and unpaid. Public-holiday dates must be entered by an administrator. Sundays and configured public holidays are excluded from leave-day totals, and attendance is blocked on those dates and before an employee’s joining date.
