USE ems;
-- Local starter account only. Password is stored as a PHP password_hash.
INSERT IGNORE INTO users(username,email,password,role) VALUES
('admin','admin@ems.com','$2y$10$pXIzcxYTz2/sXbzZpqX7I./LJTXBCnZkN8O/DUWZlMRB.YvEnVbJK','admin');

-- Common departments for an IT services or software company.
INSERT IGNORE INTO departments(department_name,department_code,description) VALUES
('Software Engineering','DEV','Application development across web, mobile, and backend systems.'),
('QA & Testing','QA','Manual testing, automation, and software quality assurance.'),
('DevOps & Cloud','DVC','Cloud platforms, deployment automation, reliability, and platform engineering.'),
('IT Infrastructure & Support','ITS','Internal IT support, systems, networks, and workplace technology.'),
('Cybersecurity','SEC','Security operations, engineering, risk management, and compliance.'),
('Data & Artificial Intelligence','DAI','Data engineering, analytics, data science, and AI/ML.'),
('Product Management','PRD','Product strategy, discovery, planning, and delivery.'),
('UI/UX & Product Design','UXD','User research, experience design, and product interface design.'),
('Project & Program Management','PMO','Project delivery, program coordination, and portfolio operations.'),
('Business Analysis & Consulting','BA','Requirements analysis, process improvement, and technology consulting.'),
('Sales & Business Development','SBD','Customer acquisition, account growth, partnerships, and sales engineering.'),
('Marketing','MKT','Brand, content, digital marketing, communications, and growth.'),
('Customer Support & Success','CSS','Technical support, customer service, onboarding, and customer outcomes.'),
('Human Resources & Talent','HR','Recruitment, people operations, learning, and employee experience.'),
('Finance & Accounting','FIN','Accounting, financial planning, reporting, and controls.'),
('Administration & Operations','AOP','Office administration, facilities, and business operations.'),
('Legal & Compliance','LCO','Legal counsel, privacy, governance, and regulatory compliance.'),
('Research & Development','RND','Technology research, prototyping, and new product development.');

-- Department-specific job titles with a clear seniority progression.
INSERT IGNORE INTO job_roles(department_code,role_title,seniority_level) VALUES
('DEV','Software Engineering Intern','Intern'),
('DEV','Junior Software Developer','Junior'),
('DEV','Software Developer','Mid-Level'),
('DEV','Senior Software Engineer','Senior'),
('DEV','Frontend Developer','Mid-Level'),
('DEV','Backend Developer','Mid-Level'),
('DEV','Full-Stack Developer','Mid-Level'),
('DEV','Mobile App Developer','Mid-Level'),
('DEV','Technical Lead','Lead'),
('DEV','Engineering Manager','Manager'),
('DEV','Director of Engineering','Director'),
('QA','QA Intern','Intern'),
('QA','Junior QA Tester','Junior'),
('QA','QA Engineer','Mid-Level'),
('QA','Senior QA Engineer','Senior'),
('QA','QA Automation Engineer','Mid-Level'),
('QA','Test Automation Lead','Lead'),
('QA','QA Manager','Manager'),
('DVC','Cloud Support Associate','Associate'),
('DVC','Junior DevOps Engineer','Junior'),
('DVC','DevOps Engineer','Mid-Level'),
('DVC','Senior DevOps Engineer','Senior'),
('DVC','Cloud Engineer','Mid-Level'),
('DVC','Site Reliability Engineer','Mid-Level'),
('DVC','Platform Engineer','Mid-Level'),
('DVC','Cloud Architect','Lead'),
('DVC','DevOps Manager','Manager'),
('ITS','IT Support Technician','Associate'),
('ITS','Help Desk Analyst','Junior'),
('ITS','Junior System Administrator','Junior'),
('ITS','System Administrator','Mid-Level'),
('ITS','Senior System Administrator','Senior'),
('ITS','Network Engineer','Mid-Level'),
('ITS','Senior Network Engineer','Senior'),
('ITS','IT Administrator','Mid-Level'),
('ITS','IT Operations Manager','Manager'),
('SEC','SOC Analyst','Junior'),
('SEC','Cybersecurity Analyst','Associate'),
('SEC','Security Analyst','Mid-Level'),
('SEC','Senior Security Analyst','Senior'),
('SEC','Security Engineer','Mid-Level'),
('SEC','Penetration Tester','Mid-Level'),
('SEC','Security Architect','Lead'),
('SEC','Security Manager','Manager'),
('SEC','Chief Information Security Officer','Executive'),
('DAI','Junior Data Analyst','Junior'),
('DAI','Data Analyst','Associate'),
('DAI','Data Engineer','Mid-Level'),
('DAI','Senior Data Engineer','Senior'),
('DAI','Data Scientist','Mid-Level'),
('DAI','Machine Learning Engineer','Mid-Level'),
('DAI','AI Engineer','Mid-Level'),
('DAI','Data Architect','Lead'),
('DAI','Head of Data & AI','Director'),
('PRD','Product Analyst','Associate'),
('PRD','Associate Product Manager','Associate'),
('PRD','Product Manager','Mid-Level'),
('PRD','Senior Product Manager','Senior'),
('PRD','Product Lead','Lead'),
('PRD','Director of Product','Director'),
('PRD','Chief Product Officer','Executive'),
('UXD','UI Designer','Junior'),
('UXD','UX Designer','Associate'),
('UXD','UI/UX Designer','Mid-Level'),
('UXD','Product Designer','Mid-Level'),
('UXD','Senior Product Designer','Senior'),
('UXD','UX Researcher','Mid-Level'),
('UXD','Design Lead','Lead'),
('UXD','Design Manager','Manager'),
('PMO','Project Coordinator','Associate'),
('PMO','Project Analyst','Junior'),
('PMO','Project Manager','Mid-Level'),
('PMO','Senior Project Manager','Senior'),
('PMO','Program Manager','Manager'),
('PMO','PMO Lead','Lead'),
('BA','Junior Business Analyst','Junior'),
('BA','Business Analyst','Mid-Level'),
('BA','Senior Business Analyst','Senior'),
('BA','Systems Analyst','Mid-Level'),
('BA','Business Analysis Lead','Lead'),
('BA','IT Consultant','Associate'),
('BA','Senior IT Consultant','Senior'),
('SBD','Sales Development Representative','Associate'),
('SBD','Business Development Executive','Associate'),
('SBD','Account Executive','Mid-Level'),
('SBD','Account Manager','Mid-Level'),
('SBD','Sales Engineer','Mid-Level'),
('SBD','Sales Manager','Manager'),
('SBD','Head of Sales','Director'),
('MKT','Marketing Associate','Associate'),
('MKT','Content Writer','Junior'),
('MKT','SEO Specialist','Mid-Level'),
('MKT','Digital Marketing Executive','Mid-Level'),
('MKT','Social Media Manager','Manager'),
('MKT','Marketing Manager','Manager'),
('MKT','Head of Marketing','Director'),
('CSS','Customer Support Associate','Associate'),
('CSS','Technical Support Engineer','Junior'),
('CSS','Customer Success Associate','Associate'),
('CSS','Customer Success Manager','Mid-Level'),
('CSS','Support Team Lead','Lead'),
('CSS','Customer Support Manager','Manager'),
('HR','HR Assistant','Associate'),
('HR','HR Executive','Associate'),
('HR','Recruiter','Associate'),
('HR','Talent Acquisition Specialist','Mid-Level'),
('HR','HR Business Partner','Senior'),
('HR','HR Manager','Manager'),
('HR','Head of HR','Director'),
('FIN','Accounts Assistant','Associate'),
('FIN','Accountant','Mid-Level'),
('FIN','Financial Analyst','Associate'),
('FIN','Senior Accountant','Senior'),
('FIN','Finance Manager','Manager'),
('FIN','Financial Controller','Director'),
('FIN','Chief Financial Officer','Executive'),
('AOP','Administrative Assistant','Associate'),
('AOP','Office Administrator','Associate'),
('AOP','Operations Executive','Associate'),
('AOP','Operations Coordinator','Associate'),
('AOP','Operations Manager','Manager'),
('AOP','Facilities Manager','Manager'),
('AOP','Chief Operating Officer','Executive'),
('LCO','Legal Assistant','Associate'),
('LCO','Compliance Analyst','Associate'),
('LCO','Legal Counsel','Mid-Level'),
('LCO','Data Protection Officer','Senior'),
('LCO','Compliance Manager','Manager'),
('LCO','General Counsel','Executive'),
('RND','R&D Intern','Intern'),
('RND','Research Assistant','Associate'),
('RND','Research Engineer','Mid-Level'),
('RND','Senior Research Engineer','Senior'),
('RND','R&D Manager','Manager'),
('RND','Director of Research','Director');

INSERT IGNORE INTO job_roles(department_code,role_title,seniority_level) VALUES
('DAI','Data & AI Manager','Manager'),
('PRD','Product Management Manager','Manager'),
('PMO','Project Management Manager','Manager'),
('BA','Business Analysis Manager','Manager');

-- Responsibilities for job-role catalog
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Works with a mentor on scoped learning tasks and documents progress.' WHERE department_code='DEV' AND role_title='Software Engineering Intern';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Completes assigned work with guidance and raises blockers early.' WHERE department_code='DEV' AND role_title='Junior Software Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DEV' AND role_title='Software Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='DEV' AND role_title='Senior Software Engineer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DEV' AND role_title='Frontend Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DEV' AND role_title='Backend Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DEV' AND role_title='Full-Stack Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DEV' AND role_title='Mobile App Developer';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Sets team direction and coordinates delivery.' WHERE department_code='DEV' AND role_title='Technical Lead';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='DEV' AND role_title='Engineering Manager';
UPDATE job_roles SET responsibilities='Design, build, review, test and maintain secure, reliable software against product requirements. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='DEV' AND role_title='Director of Engineering';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Works with a mentor on scoped learning tasks and documents progress.' WHERE department_code='QA' AND role_title='QA Intern';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Completes assigned work with guidance and raises blockers early.' WHERE department_code='QA' AND role_title='Junior QA Tester';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='QA' AND role_title='QA Engineer';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='QA' AND role_title='Senior QA Engineer';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='QA' AND role_title='QA Automation Engineer';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Sets team direction and coordinates delivery.' WHERE department_code='QA' AND role_title='Test Automation Lead';
UPDATE job_roles SET responsibilities='Plan and run manual and automated tests, document defects and prevent regressions. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='QA' AND role_title='QA Manager';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='DVC' AND role_title='Cloud Support Associate';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Completes assigned work with guidance and raises blockers early.' WHERE department_code='DVC' AND role_title='Junior DevOps Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DVC' AND role_title='DevOps Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='DVC' AND role_title='Senior DevOps Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DVC' AND role_title='Cloud Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DVC' AND role_title='Site Reliability Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DVC' AND role_title='Platform Engineer';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Sets team direction and coordinates delivery.' WHERE department_code='DVC' AND role_title='Cloud Architect';
UPDATE job_roles SET responsibilities='Build and operate cloud and deployment platforms, automate delivery and improve reliability. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='DVC' AND role_title='DevOps Manager';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='ITS' AND role_title='IT Support Technician';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Completes assigned work with guidance and raises blockers early.' WHERE department_code='ITS' AND role_title='Help Desk Analyst';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Completes assigned work with guidance and raises blockers early.' WHERE department_code='ITS' AND role_title='Junior System Administrator';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='ITS' AND role_title='System Administrator';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='ITS' AND role_title='Senior System Administrator';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='ITS' AND role_title='Network Engineer';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='ITS' AND role_title='Senior Network Engineer';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='ITS' AND role_title='IT Administrator';
UPDATE job_roles SET responsibilities='Support staff devices and accounts, administer systems and networks, and resolve IT requests. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='ITS' AND role_title='IT Operations Manager';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Completes assigned work with guidance and raises blockers early.' WHERE department_code='SEC' AND role_title='SOC Analyst';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='SEC' AND role_title='Cybersecurity Analyst';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SEC' AND role_title='Security Analyst';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='SEC' AND role_title='Senior Security Analyst';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SEC' AND role_title='Security Engineer';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SEC' AND role_title='Penetration Tester';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Sets team direction and coordinates delivery.' WHERE department_code='SEC' AND role_title='Security Architect';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='SEC' AND role_title='Security Manager';
UPDATE job_roles SET responsibilities='Monitor security risks, investigate alerts, strengthen controls and support incident response. Provides executive direction, governance and accountability.' WHERE department_code='SEC' AND role_title='Chief Information Security Officer';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Completes assigned work with guidance and raises blockers early.' WHERE department_code='DAI' AND role_title='Junior Data Analyst';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='DAI' AND role_title='Data Analyst';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DAI' AND role_title='Data Engineer';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='DAI' AND role_title='Senior Data Engineer';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DAI' AND role_title='Data Scientist';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DAI' AND role_title='Machine Learning Engineer';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='DAI' AND role_title='AI Engineer';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Sets team direction and coordinates delivery.' WHERE department_code='DAI' AND role_title='Data Architect';
UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='DAI' AND role_title='Head of Data & AI';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='PRD' AND role_title='Product Analyst';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='PRD' AND role_title='Associate Product Manager';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='PRD' AND role_title='Product Manager';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='PRD' AND role_title='Senior Product Manager';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Sets team direction and coordinates delivery.' WHERE department_code='PRD' AND role_title='Product Lead';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='PRD' AND role_title='Director of Product';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Provides executive direction, governance and accountability.' WHERE department_code='PRD' AND role_title='Chief Product Officer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Completes assigned work with guidance and raises blockers early.' WHERE department_code='UXD' AND role_title='UI Designer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='UXD' AND role_title='UX Designer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='UXD' AND role_title='UI/UX Designer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='UXD' AND role_title='Product Designer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='UXD' AND role_title='Senior Product Designer';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='UXD' AND role_title='UX Researcher';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Sets team direction and coordinates delivery.' WHERE department_code='UXD' AND role_title='Design Lead';
UPDATE job_roles SET responsibilities='Research user needs and create accessible, consistent interface and product experiences. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='UXD' AND role_title='Design Manager';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='PMO' AND role_title='Project Coordinator';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Completes assigned work with guidance and raises blockers early.' WHERE department_code='PMO' AND role_title='Project Analyst';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='PMO' AND role_title='Project Manager';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='PMO' AND role_title='Senior Project Manager';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='PMO' AND role_title='Program Manager';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Sets team direction and coordinates delivery.' WHERE department_code='PMO' AND role_title='PMO Lead';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Completes assigned work with guidance and raises blockers early.' WHERE department_code='BA' AND role_title='Junior Business Analyst';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='BA' AND role_title='Business Analyst';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='BA' AND role_title='Senior Business Analyst';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='BA' AND role_title='Systems Analyst';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Sets team direction and coordinates delivery.' WHERE department_code='BA' AND role_title='Business Analysis Lead';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='BA' AND role_title='IT Consultant';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='BA' AND role_title='Senior IT Consultant';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='SBD' AND role_title='Sales Development Representative';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='SBD' AND role_title='Business Development Executive';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SBD' AND role_title='Account Executive';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SBD' AND role_title='Account Manager';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='SBD' AND role_title='Sales Engineer';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='SBD' AND role_title='Sales Manager';
UPDATE job_roles SET responsibilities='Develop customer opportunities, understand business needs and support ethical sales execution. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='SBD' AND role_title='Head of Sales';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='MKT' AND role_title='Marketing Associate';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Completes assigned work with guidance and raises blockers early.' WHERE department_code='MKT' AND role_title='Content Writer';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='MKT' AND role_title='SEO Specialist';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='MKT' AND role_title='Digital Marketing Executive';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='MKT' AND role_title='Social Media Manager';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='MKT' AND role_title='Marketing Manager';
UPDATE job_roles SET responsibilities='Plan measurable content and campaigns that build awareness and customer growth. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='MKT' AND role_title='Head of Marketing';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='CSS' AND role_title='Customer Support Associate';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Completes assigned work with guidance and raises blockers early.' WHERE department_code='CSS' AND role_title='Technical Support Engineer';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='CSS' AND role_title='Customer Success Associate';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='CSS' AND role_title='Customer Success Manager';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Sets team direction and coordinates delivery.' WHERE department_code='CSS' AND role_title='Support Team Lead';
UPDATE job_roles SET responsibilities='Resolve customer issues, guide product adoption and share feedback to improve outcomes. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='CSS' AND role_title='Customer Support Manager';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='HR' AND role_title='HR Assistant';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='HR' AND role_title='HR Executive';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='HR' AND role_title='Recruiter';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='HR' AND role_title='Talent Acquisition Specialist';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='HR' AND role_title='HR Business Partner';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='HR' AND role_title='HR Manager';
UPDATE job_roles SET responsibilities='Support recruitment, onboarding, employee relations, learning and people processes. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='HR' AND role_title='Head of HR';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='FIN' AND role_title='Accounts Assistant';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='FIN' AND role_title='Accountant';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='FIN' AND role_title='Financial Analyst';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='FIN' AND role_title='Senior Accountant';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='FIN' AND role_title='Finance Manager';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='FIN' AND role_title='Financial Controller';
UPDATE job_roles SET responsibilities='Maintain accurate financial records, support planning and reporting, and follow controls. Provides executive direction, governance and accountability.' WHERE department_code='FIN' AND role_title='Chief Financial Officer';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='AOP' AND role_title='Administrative Assistant';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='AOP' AND role_title='Office Administrator';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='AOP' AND role_title='Operations Executive';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='AOP' AND role_title='Operations Coordinator';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='AOP' AND role_title='Operations Manager';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='AOP' AND role_title='Facilities Manager';
UPDATE job_roles SET responsibilities='Keep workplace operations, facilities, records and administrative services dependable. Provides executive direction, governance and accountability.' WHERE department_code='AOP' AND role_title='Chief Operating Officer';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='LCO' AND role_title='Legal Assistant';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='LCO' AND role_title='Compliance Analyst';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='LCO' AND role_title='Legal Counsel';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='LCO' AND role_title='Data Protection Officer';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='LCO' AND role_title='Compliance Manager';
UPDATE job_roles SET responsibilities='Support contracts, privacy, policy and compliance reviews; escalate risks promptly. Provides executive direction, governance and accountability.' WHERE department_code='LCO' AND role_title='General Counsel';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Works with a mentor on scoped learning tasks and documents progress.' WHERE department_code='RND' AND role_title='R&D Intern';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Owns routine tasks independently and keeps records and stakeholders informed.' WHERE department_code='RND' AND role_title='Research Assistant';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Delivers end-to-end work, coordinates dependencies and reviews quality.' WHERE department_code='RND' AND role_title='Research Engineer';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Leads complex work, mentors colleagues and improves team practices.' WHERE department_code='RND' AND role_title='Senior Research Engineer';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='RND' AND role_title='R&D Manager';
UPDATE job_roles SET responsibilities='Investigate technical questions, run documented experiments and share reproducible findings. Sets department priorities, develops leaders and aligns outcomes with company goals.' WHERE department_code='RND' AND role_title='Director of Research';

UPDATE job_roles SET responsibilities='Prepare trusted data, deliver analysis and models, and communicate evidence-based insights. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='DAI' AND role_title='Data & AI Manager';
UPDATE job_roles SET responsibilities='Understand user needs, define product outcomes, prioritize the roadmap and coordinate delivery. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='PRD' AND role_title='Product Management Manager';
UPDATE job_roles SET responsibilities='Coordinate scope, schedules, risks, communications and project delivery reporting. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='PMO' AND role_title='Project Management Manager';
UPDATE job_roles SET responsibilities='Elicit requirements, map processes and connect business needs to technical solutions. Plans team work, supports people, reviews outcomes and manages risks.' WHERE department_code='BA' AND role_title='Business Analysis Manager';

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
