<?php
function e(mixed $v): string { return htmlspecialchars((string)$v,ENT_QUOTES|ENT_SUBSTITUTE,'UTF-8'); }
function ems_icon(string $name): string {
    static $paths=[
        'dashboard'=>'<rect x="3" y="3" width="7" height="9" rx="1"/><rect x="14" y="3" width="7" height="5" rx="1"/><rect x="14" y="12" width="7" height="9" rx="1"/><rect x="3" y="16" width="7" height="5" rx="1"/>',
        'users'=>'<circle cx="9" cy="8" r="3.5"/><path d="M2.5 20a6.5 6.5 0 0 1 13 0"/><path d="M16 4.6a3.5 3.5 0 0 1 0 6.8"/><path d="M18 14.6a6.5 6.5 0 0 1 3.5 5.4"/>',
        'user'=>'<circle cx="12" cy="8" r="4"/><path d="M4 21a8 8 0 0 1 16 0"/>',
        'building'=>'<rect x="4" y="3" width="16" height="18" rx="1.5"/><path d="M9 7h2M13 7h2M9 11h2M13 11h2M9 15h2M13 15h2M10 21v-3h4v3"/>',
        'clock'=>'<circle cx="12" cy="12" r="9"/><path d="M12 7v5l3 2"/>',
        'calendar'=>'<rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 10h18M8 3v4M16 3v4"/>',
        'chart'=>'<path d="M3 20h18M6 16v-5M11 16V5M16 16v-8"/>',
        'rupee'=>'<path d="M6 4h12M6 9h12M6 4h3a5 5 0 0 1 0 10H6l8 6"/>',
        'shield'=>'<path d="M12 3l8 3v6c0 4.5-3.4 8.3-8 9-4.6-.7-8-4.5-8-9V6z"/><path d="M9 12l2 2 4-4"/>',
        'activity'=>'<path d="M3 12h4l3-8 4 16 3-8h4"/>',
        'settings'=>'<path d="M4 6h10M18 6h2M4 12h4M12 12h8M4 18h12"/><circle cx="16" cy="6" r="2"/><circle cx="10" cy="12" r="2"/><circle cx="18" cy="18" r="2"/>',
        'megaphone'=>'<path d="M3 10v4a1 1 0 0 0 1 1h3l6 4V5L7 9H4a1 1 0 0 0-1 1z"/><path d="M17 9a4 4 0 0 1 0 6"/>',
        'info'=>'<circle cx="12" cy="12" r="9"/><path d="M12 11v5M12 8h.01"/>',
        'bell'=>'<path d="M6 16v-5a6 6 0 0 1 12 0v5l1.5 2h-15z"/><path d="M10 20a2 2 0 0 0 4 0"/>',
        'arrow-right'=>'<path d="M5 12h14M13 6l6 6-6 6"/>',
        'plus'=>'<path d="M12 5v14M5 12h14"/>',
        'edit'=>'<path d="M4 20h4L19 9l-4-4L4 16z"/><path d="M13.5 6.5l4 4"/>',
        'close'=>'<path d="M6 6l12 12M18 6L6 18"/>',
        'menu'=>'<path d="M4 7h16M4 12h16M4 17h16"/>',
        'theme'=>'<circle cx="12" cy="12" r="8"/><path d="M12 4a8 8 0 0 1 0 16z" fill="currentColor"/>',
        'logout'=>'<path d="M9 4H6a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h3"/><path d="M14 8l4 4-4 4M18 12H9"/>',
        'search'=>'<circle cx="11" cy="11" r="6.5"/><path d="M16 16l4 4"/>',
    ];
    $p=$paths[$name]??$paths['info'];
    return '<svg class="icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true" focusable="false">'.$p.'</svg>';
}
function ems_head_meta(string $description): string { return '<meta name="description" content="'.e($description).'"><link rel="icon" href="'.e(app_url('assets/img/favicon.svg')).'" type="image/svg+xml">'; }
function app_url(string $path=''): string { $base=rtrim(str_replace('\\','/',dirname($_SERVER['SCRIPT_NAME']??'/EMS/')),'/'); while(preg_match('~/(admin|hr|employee|actions)$~',$base)) $base=dirname($base); return ($base==='/'?'':$base).'/'.ltrim($path,'/'); }
function redirect(string $path): never { header('Location: '.app_url($path)); exit; }
function csrf_token(): string { if(empty($_SESSION['_csrf'])) $_SESSION['_csrf']=bin2hex(random_bytes(32)); return $_SESSION['_csrf']; }
function csrf_field(): string { return '<input type="hidden" name="_csrf" value="'.e(csrf_token()).'">'; }
function verify_csrf(): void { if($_SERVER['REQUEST_METHOD']==='POST'&&!hash_equals($_SESSION['_csrf']??'',$_POST['_csrf']??'')){http_response_code(419);exit('Session expired. Reload and try again.');} }
function flash(string $type,string $message): void { $_SESSION['_flash'][]=[$type,$message]; }
function take_flashes(): array { $v=$_SESSION['_flash']??[];unset($_SESSION['_flash']);return $v; }
function is_logged_in(): bool { return isset($_SESSION['user']); }
function current_user(): array { return $_SESSION['user']??[]; }
function require_login(): void {
    if(!is_logged_in()){flash('warning','Please sign in to continue.');redirect('login.php');}
    if(time()-(int)($_SESSION['last_activity']??time())>3600){$_SESSION=[];session_destroy();redirect('login.php?expired=1');}
    // Re-read the account on every request so deactivation and role changes apply immediately.
    $q=db()->prepare('SELECT id,username,email,role,status FROM users WHERE id=?');$q->execute([(int)current_user()['id']]);$fresh=$q->fetch();
    if(!$fresh||$fresh['status']!=='active'){$_SESSION=[];session_destroy();redirect('login.php?deactivated=1');}
    $_SESSION['user']=$fresh;$_SESSION['last_activity']=time();
}
const EMS_LOGIN_WINDOW_MINUTES=15;
const EMS_LOGIN_MAX_PER_ACCOUNT=5;
const EMS_LOGIN_MAX_PER_IP=20;
function ems_login_attempts_table(PDO $pdo): void { $pdo->exec('CREATE TABLE IF NOT EXISTS login_attempts (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, identity VARCHAR(190) NOT NULL, ip_address VARCHAR(45) NOT NULL, attempted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, INDEX idx_login_identity (identity, attempted_at), INDEX idx_login_ip (ip_address, attempted_at)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4'); }
function ems_login_blocked(PDO $pdo,string $identity,string $ip): bool {
    $since=date('Y-m-d H:i:s',time()-EMS_LOGIN_WINDOW_MINUTES*60);
    $q=$pdo->prepare('SELECT COUNT(*) FROM login_attempts WHERE identity=? AND attempted_at>=?');$q->execute([strtolower($identity),$since]);if((int)$q->fetchColumn()>=EMS_LOGIN_MAX_PER_ACCOUNT)return true;
    $q=$pdo->prepare('SELECT COUNT(*) FROM login_attempts WHERE ip_address=? AND attempted_at>=?');$q->execute([$ip,$since]);return (int)$q->fetchColumn()>=EMS_LOGIN_MAX_PER_IP;
}
function ems_login_failed(PDO $pdo,string $identity,string $ip): void { $pdo->prepare('INSERT INTO login_attempts(identity,ip_address,attempted_at) VALUES(?,?,?)')->execute([strtolower($identity),$ip,date('Y-m-d H:i:s')]); $pdo->prepare('DELETE FROM login_attempts WHERE attempted_at<?')->execute([date('Y-m-d H:i:s',time()-86400)]); }
function ems_login_succeeded(PDO $pdo,string $identity): void { $pdo->prepare('DELETE FROM login_attempts WHERE identity=?')->execute([strtolower($identity)]); }
const EMS_DEFAULT_ADMIN_PASSWORD='ADMIN@123';
function ems_password_problem(string $pass): ?string { if(strlen($pass)<8||!preg_match('/[A-Z]/',$pass)||!preg_match('/[a-z]/',$pass)||!preg_match('/[0-9]/',$pass)||!preg_match('/[^A-Za-z0-9]/',$pass))return 'Use at least 8 characters with an uppercase letter, a lowercase letter, a number and a symbol.'; if($pass===EMS_DEFAULT_ADMIN_PASSWORD)return 'Choose a password other than the published starter password.'; return null; }
function require_roles(array $roles): void { require_login();if(!in_array(current_user()['role'],$roles,true)){http_response_code(403);require __DIR__.'/403.php';exit;} }
function log_activity(string $action,string $details=''): void { if(is_logged_in()) db()->prepare('INSERT INTO activity_logs(user_id,action,details,ip_address) VALUES(?,?,?,?)')->execute([current_user()['id'],$action,$details,$_SERVER['REMOTE_ADDR']??null]); }
function notify_user(int $id,string $title,string $message,string $type='info'): void { db()->prepare('INSERT INTO notifications(user_id,title,message,type) VALUES(?,?,?,?)')->execute([$id,$title,$message,$type]); }
function badge_class(string $s): string { return match(strtolower($s)){'active','approved','present'=>'success','pending','late','half day'=>'warning','inactive','rejected','absent'=>'danger',default=>'muted'}; }
function current_employee(): ?array { if(!is_logged_in())return null;$q=db()->prepare('SELECT e.*,d.department_name,d.department_code,d.description department_description,m.first_name manager_first_name,m.last_name manager_last_name,m.employee_id manager_employee_id,m.designation manager_designation,j.seniority_level,j.responsibilities job_responsibilities FROM employees e LEFT JOIN departments d ON d.id=e.department_id LEFT JOIN employees m ON m.id=e.manager_id LEFT JOIN job_roles j ON j.department_code=d.department_code AND j.role_title=e.designation WHERE e.user_id=?');$q->execute([current_user()['id']]);return $q->fetch()?:null; }
function setting(string $key,string $default=''): string { try{$q=db()->prepare('SELECT setting_value FROM settings WHERE setting_key=?');$q->execute([$key]);$v=$q->fetchColumn();return $v===false?$default:(string)$v;}catch(Throwable){return $default;} }
function ems_holiday_name(PDO $pdo,string $date): ?string { $q=$pdo->prepare('SELECT holiday_name FROM public_holidays WHERE holiday_date=?');$q->execute([$date]);$v=$q->fetchColumn();return $v===false?null:(string)$v; }
function ems_leave_workdays(PDO $pdo,string $start,string $end): int { if($end<$start)return 0;$q=$pdo->prepare('SELECT holiday_date FROM public_holidays WHERE holiday_date BETWEEN ? AND ?');$q->execute([$start,$end]);$holidays=array_fill_keys($q->fetchAll(PDO::FETCH_COLUMN),true);$n=0;for($d=new DateTimeImmutable($start);$d<=new DateTimeImmutable($end);$d=$d->modify('+1 day'))if($d->format('w')!=='0'&&!isset($holidays[$d->format('Y-m-d')]))$n++;return $n; }
function ems_department_overview(string $code): array {
    return match($code){
        'DEV'=>['Build application features from approved requirements.','Maintain frontend, backend, and integration code.','Review code and follow engineering standards.','Test changes and resolve defects.','Support secure, reliable software releases.'],
        'QA'=>['Turn requirements into test scenarios.','Run manual and automated checks.','Record defects with clear steps and evidence.','Retest fixes and run regression checks.','Share quality risks before release.'],
        'DVC'=>['Maintain cloud and platform environments.','Automate build and deployment pipelines.','Monitor service health and reliability.','Manage infrastructure changes and access.','Support incident response and recovery.'],
        'ITS'=>['Resolve employee hardware and software requests.','Maintain user accounts, devices, and system access.','Troubleshoot network, endpoint, and server issues.','Apply updates and basic security controls.','Document fixes and technology assets.'],
        'SEC'=>['Monitor security alerts and investigate issues.','Review identities, permissions, and configurations.','Assess vulnerabilities and recommend fixes.','Support incident response and follow-up.','Maintain security documentation and controls.'],
        'DAI'=>['Collect and prepare reliable datasets.','Build data pipelines and quality checks.','Analyze trends and produce useful reports.','Develop or evaluate data and AI models.','Protect data access and communicate findings.'],
        'PRD'=>['Understand user and business needs.','Define product goals and success measures.','Prioritize roadmaps and delivery backlogs.','Coordinate decisions across engineering and design.','Review outcomes and adjust priorities.'],
        'UXD'=>['Research user needs and workflows.','Design task flows and interface layouts.','Create prototypes and visual specifications.','Check usability and accessibility.','Support design handoff and quality reviews.'],
        'PMO'=>['Plan project scope, schedules, and milestones.','Track work, dependencies, risks, and decisions.','Coordinate communication across teams.','Share progress and escalate blockers.','Support consistent delivery practices.'],
        'BA'=>['Gather requirements from stakeholders.','Map current and desired business processes.','Document user stories and acceptance criteria.','Clarify requirements with design and engineering.','Validate delivered changes with stakeholders.'],
        'SBD'=>['Identify and qualify customer opportunities.','Understand needs and explain relevant solutions.','Prepare proposals and coordinate demonstrations.','Maintain customer and sales-pipeline records.','Support account growth and partnerships.'],
        'MKT'=>['Plan campaigns for target audiences.','Create and schedule content.','Manage channels, brand, and communications.','Monitor campaign metrics and engagement.','Use results to improve outreach.'],
        'CSS'=>['Respond to customer questions and issues.','Troubleshoot product and service problems.','Guide setup, onboarding, and adoption.','Maintain support documentation and feedback.','Track resolutions and escalate recurring issues.'],
        'HR'=>['Support recruitment and workforce planning.','Coordinate onboarding and employee records.','Help employees with policy and people questions.','Support learning, performance, and engagement.','Maintain accurate, confidential documentation.'],
        'FIN'=>['Maintain accounting records and reconciliations.','Support budgets, invoices, and payroll processes.','Prepare regular financial reports.','Follow approval controls and compliance practices.','Flag discrepancies and financial risks.'],
        'AOP'=>['Coordinate office, facilities, and supplies.','Manage vendor and service requests.','Maintain operational records and schedules.','Support workplace logistics and employee needs.','Improve routine business processes.'],
        'LCO'=>['Review contracts, policies, and compliance needs.','Support privacy and information-handling practices.','Monitor obligations and regulatory updates.','Document risks and recommend controls.','Escalate legal and compliance issues appropriately.'],
        'RND'=>['Investigate technical questions and user needs.','Plan and run documented experiments.','Build prototypes to explore solutions.','Record methods, results, and limitations.','Share reproducible findings for product development.'],
        default=>['Understand the team’s goals and priorities.','Complete work assigned for your role.','Keep records and documentation up to date.','Communicate progress and raise blockers early.','Coordinate with your manager and partner teams.'],
    };
}
function ems_leave_usage(PDO $pdo,int $employeeId,string $type,int $year): array { $s=sprintf('%04d-01-01',$year);$e=sprintf('%04d-12-31',$year);$q=$pdo->prepare('SELECT leave_type,status,start_date,end_date FROM leaves WHERE employee_id=? AND leave_type=? AND end_date>=? AND start_date<=?');$q->execute([$employeeId,$type,$s,$e]);$used=0;$pending=0;foreach($q->fetchAll() as $r){$from=max($s,$r['start_date']);$to=min($e,$r['end_date']);$days=ems_leave_workdays($pdo,$from,$to);if($r['status']==='Approved')$used+=$days;elseif($r['status']==='Pending')$pending+=$days;}return ['used'=>$used,'pending'=>$pending]; }
