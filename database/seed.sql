USE ems;
INSERT INTO departments(department_name,department_code,description) VALUES
('Engineering','ENG','Product engineering and IT operations'),('People & Culture','PEO','Hiring, people operations and development'),('Finance','FIN','Financial planning and operations'),('Marketing','MKT','Brand and customer communications');
-- Development only: all demo accounts use password "password". Replace before real use.
INSERT INTO users(username,email,password,role) VALUES
('admin','admin@ems.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','admin'),
('hr','hr@ems.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','hr'),
('employee','employee@ems.local','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','employee');
INSERT INTO employees(employee_id,user_id,first_name,last_name,email,phone,gender,city,department_id,designation,joining_date) VALUES
('EMP001',3,'Jordan','Lee','employee@ems.local','+1 555 013 2140','Prefer not to say','Austin',1,'Systems Analyst',CURDATE()-INTERVAL 1 YEAR),
('EMP002',NULL,'Casey','Morgan','casey.morgan@example.test','+1 555 014 3850','Female','Austin',2,'People Operations Partner',CURDATE()-INTERVAL 8 MONTH),
('EMP003',NULL,'Riley','Patel','riley.patel@example.test','+1 555 016 9270','Male','Denver',1,'Software Engineer',CURDATE()-INTERVAL 4 MONTH);
INSERT INTO attendance(employee_id,attendance_date,check_in,status) VALUES (1,CURDATE(),'09:02:00','Present');
INSERT INTO notifications(user_id,title,message,type) VALUES (3,'Welcome to EMS','Your profile is ready. Add your contact details to complete it.','info');
INSERT INTO settings(setting_key,setting_value) VALUES ('company_name','EMS Workspace'),('timezone','Asia/Kolkata');
