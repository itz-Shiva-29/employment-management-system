CREATE DATABASE IF NOT EXISTS ems CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ems;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS payslips, salary_structures, activity_logs, notifications, announcements, public_holidays, leave_balances, leaves, attendance, employees, job_roles, departments, settings, users;
SET FOREIGN_KEY_CHECKS=1;
CREATE TABLE users (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, username VARCHAR(80) NOT NULL UNIQUE, email VARCHAR(190) NOT NULL UNIQUE,
 password VARCHAR(255) NOT NULL, role ENUM('admin','hr','employee') NOT NULL DEFAULT 'employee', status ENUM('active','inactive') NOT NULL DEFAULT 'active',
 created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE departments (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, department_name VARCHAR(100) NOT NULL UNIQUE, department_code VARCHAR(20) NOT NULL UNIQUE,
 description VARCHAR(500) NULL, status ENUM('active','inactive') NOT NULL DEFAULT 'active', created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;
CREATE TABLE job_roles (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, department_code VARCHAR(20) NOT NULL, role_title VARCHAR(120) NOT NULL,
 seniority_level ENUM('Intern','Junior','Associate','Mid-Level','Senior','Lead','Manager','Director','Executive') NOT NULL DEFAULT 'Mid-Level', responsibilities TEXT NULL,
 status ENUM('active','inactive') NOT NULL DEFAULT 'active', created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_job_roles_department_title(department_code,role_title), INDEX idx_job_roles_department(department_code),
 CONSTRAINT fk_job_roles_department FOREIGN KEY(department_code) REFERENCES departments(department_code) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE employees (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id VARCHAR(30) NOT NULL UNIQUE, user_id INT UNSIGNED NULL UNIQUE,
 first_name VARCHAR(80) NOT NULL, last_name VARCHAR(80) NOT NULL, email VARCHAR(190) NOT NULL UNIQUE, phone VARCHAR(30) NULL,
 gender VARCHAR(30) NULL, date_of_birth DATE NULL, address VARCHAR(500) NULL, city VARCHAR(100) NULL, department_id INT UNSIGNED NULL, manager_id INT UNSIGNED NULL,
 designation VARCHAR(120) NOT NULL, salary_amount DECIMAL(12,2) NULL, joining_date DATE NOT NULL, employment_status ENUM('active','inactive','on_leave') NOT NULL DEFAULT 'active',
 profile_photo VARCHAR(255) NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT fk_employee_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
 CONSTRAINT fk_employee_department FOREIGN KEY(department_id) REFERENCES departments(id) ON DELETE SET NULL,
 CONSTRAINT fk_employee_manager FOREIGN KEY(manager_id) REFERENCES employees(id) ON DELETE SET NULL,
 INDEX idx_employee_name(first_name,last_name), INDEX idx_employee_department(department_id), INDEX idx_employee_manager(manager_id), INDEX idx_employee_status(employment_status)
) ENGINE=InnoDB;
CREATE TABLE attendance (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, attendance_date DATE NOT NULL, check_in TIME NULL, check_out TIME NULL,
 status ENUM('Present','Absent','Late','Half Day','Leave','On Break') NOT NULL DEFAULT 'Present', remarks VARCHAR(500) NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_attendance_employee_day(employee_id,attendance_date), INDEX idx_attendance_date(attendance_date),
 CONSTRAINT fk_attendance_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE leaves (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, leave_type ENUM('Annual','Casual Leave (LWP)','Casual Leave','Paid Leave','Sick Leave','Personal Leave','Unpaid Leave','Compensatory Off','Public Holiday','Sick','Personal','Unpaid','Other') NOT NULL DEFAULT 'Paid Leave',
 start_date DATE NOT NULL, end_date DATE NOT NULL, reason TEXT NOT NULL, status ENUM('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
 reviewed_by INT UNSIGNED NULL, reviewed_at DATETIME NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 INDEX idx_leave_status(status), INDEX idx_leave_dates(start_date,end_date),
 CONSTRAINT fk_leave_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE,
 CONSTRAINT fk_leave_reviewer FOREIGN KEY(reviewed_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;
CREATE TABLE public_holidays (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, holiday_date DATE NOT NULL UNIQUE, holiday_name VARCHAR(160) NOT NULL, created_by INT UNSIGNED NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, CONSTRAINT fk_holiday_creator FOREIGN KEY(created_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE announcements (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, title VARCHAR(180) NOT NULL, body TEXT NOT NULL, publish_date DATE NOT NULL, expires_on DATE NULL, status ENUM('published','draft') NOT NULL DEFAULT 'published', created_by INT UNSIGNED NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, INDEX idx_announcement_visibility(status,publish_date,expires_on), CONSTRAINT fk_announcement_creator FOREIGN KEY(created_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE leave_balances (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, leave_type ENUM('Paid Leave','Sick Leave') NOT NULL, leave_year SMALLINT UNSIGNED NOT NULL, total_days DECIMAL(6,2) NULL, updated_by INT UNSIGNED NULL, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, UNIQUE KEY uq_employee_leave_year(employee_id,leave_type,leave_year), CONSTRAINT fk_balance_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE, CONSTRAINT fk_balance_editor FOREIGN KEY(updated_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE salary_structures (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL UNIQUE, basic_salary DECIMAL(12,2) NOT NULL DEFAULT 0, dearness_allowance DECIMAL(12,2) NOT NULL DEFAULT 0, hra DECIMAL(12,2) NOT NULL DEFAULT 0, other_allowances DECIMAL(12,2) NOT NULL DEFAULT 0, epf_covered TINYINT(1) NOT NULL DEFAULT 1, epf_rate DECIMAL(4,2) NOT NULL DEFAULT 12.00, pt_exempt TINYINT(1) NOT NULL DEFAULT 0, updated_by INT UNSIGNED NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, CONSTRAINT fk_salary_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE, CONSTRAINT fk_salary_editor FOREIGN KEY(updated_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE payslips (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, period CHAR(7) NOT NULL, pay_date DATE NOT NULL, basic_salary DECIMAL(12,2) NOT NULL, dearness_allowance DECIMAL(12,2) NOT NULL DEFAULT 0, hra DECIMAL(12,2) NOT NULL DEFAULT 0, other_allowances DECIMAL(12,2) NOT NULL DEFAULT 0, other_earnings DECIMAL(12,2) NOT NULL DEFAULT 0, gross_salary DECIMAL(12,2) NOT NULL, pf_wage DECIMAL(12,2) NOT NULL DEFAULT 0, epf_rate DECIMAL(4,2) NOT NULL DEFAULT 12.00, employee_pf DECIMAL(12,2) NOT NULL DEFAULT 0, employer_pf DECIMAL(12,2) NOT NULL DEFAULT 0, professional_tax DECIMAL(12,2) NOT NULL DEFAULT 0, other_deductions DECIMAL(12,2) NOT NULL DEFAULT 0, total_deductions DECIMAL(12,2) NOT NULL DEFAULT 0, net_salary DECIMAL(12,2) NOT NULL, scheduled_days DECIMAL(6,2) NOT NULL DEFAULT 0, payable_days DECIMAL(6,2) NOT NULL DEFAULT 0, issued_by INT UNSIGNED NULL, issued_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, UNIQUE KEY uq_payslip_employee_period(employee_id,period), INDEX idx_payslip_period(period), CONSTRAINT fk_payslip_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE, CONSTRAINT fk_payslip_issuer FOREIGN KEY(issued_by) REFERENCES users(id) ON DELETE SET NULL) ENGINE=InnoDB;
CREATE TABLE notifications (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id INT UNSIGNED NOT NULL, title VARCHAR(150) NOT NULL, message VARCHAR(500) NOT NULL,
 type ENUM('info','success','warning','danger') NOT NULL DEFAULT 'info', is_read TINYINT(1) NOT NULL DEFAULT 0, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 INDEX idx_notification_user_read(user_id,is_read), CONSTRAINT fk_notification_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE activity_logs (
 id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, user_id INT UNSIGNED NULL, action VARCHAR(100) NOT NULL, details VARCHAR(500) NULL,
 ip_address VARCHAR(45) NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, INDEX idx_activity_created(created_at), INDEX idx_activity_user(user_id),
 CONSTRAINT fk_activity_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;
CREATE TABLE settings (setting_key VARCHAR(100) PRIMARY KEY, setting_value TEXT NOT NULL, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB;

-- Gujarat Government public holidays for 2026 (optional holidays are not included).
INSERT IGNORE INTO public_holidays(holiday_date,holiday_name,created_by) VALUES
('2026-01-14','Makar Sankranti',NULL),
('2026-01-26','Republic Day',NULL),
('2026-03-04','Holi (Dhuleti)',NULL),
('2026-03-19','Chetichand',NULL),
('2026-03-21','Ramzan Eid (Eid-ul-Fitr)',NULL),
('2026-03-26','Shree Ram Navami',NULL),
('2026-03-31','Mahavir Janma Kalyanak',NULL),
('2026-04-03','Good Friday',NULL),
('2026-04-14','Dr. B. R. Ambedkar Jayanti',NULL),
('2026-05-28','Eid-ul-Adha (Bakri Eid)',NULL),
('2026-06-26','Muharram (Ashoora)',NULL),
('2026-08-15','Independence Day / Parsi New Year (Pateti)',NULL),
('2026-08-26','Eid-e-Miladunnabi',NULL),
('2026-08-28','Raksha Bandhan',NULL),
('2026-09-04','Janmashtami',NULL),
('2026-09-15','Samvatsari',NULL),
('2026-10-02','Mahatma Gandhi Jayanti',NULL),
('2026-10-20','Dussehra (Vijaya Dashmi)',NULL),
('2026-10-31','Sardar Vallabhbhai Patel Jayanti',NULL),
('2026-11-10','Vikram Samvat New Year',NULL),
('2026-11-11','Bhai Bij',NULL),
('2026-11-24','Guru Nanak Jayanti',NULL),
('2026-12-25','Christmas',NULL);
