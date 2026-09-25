CREATE DATABASE IF NOT EXISTS ems CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ems;
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS activity_logs, notifications, leaves, attendance, employees, departments, settings, users;
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
CREATE TABLE employees (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id VARCHAR(30) NOT NULL UNIQUE, user_id INT UNSIGNED NULL UNIQUE,
 first_name VARCHAR(80) NOT NULL, last_name VARCHAR(80) NOT NULL, email VARCHAR(190) NOT NULL UNIQUE, phone VARCHAR(30) NULL,
 gender VARCHAR(30) NULL, date_of_birth DATE NULL, address VARCHAR(500) NULL, city VARCHAR(100) NULL, department_id INT UNSIGNED NULL,
 designation VARCHAR(120) NOT NULL, joining_date DATE NOT NULL, employment_status ENUM('active','inactive','on_leave') NOT NULL DEFAULT 'active',
 profile_photo VARCHAR(255) NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT fk_employee_user FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE SET NULL,
 CONSTRAINT fk_employee_department FOREIGN KEY(department_id) REFERENCES departments(id) ON DELETE SET NULL,
 INDEX idx_employee_name(first_name,last_name), INDEX idx_employee_department(department_id), INDEX idx_employee_status(employment_status)
) ENGINE=InnoDB;
CREATE TABLE attendance (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, attendance_date DATE NOT NULL, check_in TIME NULL, check_out TIME NULL,
 status ENUM('Present','Absent','Late','Half Day','Leave') NOT NULL DEFAULT 'Present', remarks VARCHAR(500) NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_attendance_employee_day(employee_id,attendance_date), INDEX idx_attendance_date(attendance_date),
 CONSTRAINT fk_attendance_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE
) ENGINE=InnoDB;
CREATE TABLE leaves (
 id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, employee_id INT UNSIGNED NOT NULL, leave_type ENUM('Annual','Sick','Personal','Unpaid','Other') NOT NULL DEFAULT 'Annual',
 start_date DATE NOT NULL, end_date DATE NOT NULL, reason TEXT NOT NULL, status ENUM('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
 reviewed_by INT UNSIGNED NULL, reviewed_at DATETIME NULL, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 INDEX idx_leave_status(status), INDEX idx_leave_dates(start_date,end_date),
 CONSTRAINT fk_leave_employee FOREIGN KEY(employee_id) REFERENCES employees(id) ON DELETE CASCADE,
 CONSTRAINT fk_leave_reviewer FOREIGN KEY(reviewed_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB;
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
