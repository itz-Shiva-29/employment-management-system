<?php
function e(mixed $v): string { return htmlspecialchars((string)$v,ENT_QUOTES|ENT_SUBSTITUTE,'UTF-8'); }
function app_url(string $path=''): string { $base=rtrim(str_replace('\\','/',dirname($_SERVER['SCRIPT_NAME']??'/EMS/')),'/'); while(preg_match('~/(admin|hr|employee|actions)$~',$base)) $base=dirname($base); return ($base==='/'?'':$base).'/'.ltrim($path,'/'); }
function redirect(string $path): never { header('Location: '.app_url($path)); exit; }
function csrf_token(): string { if(empty($_SESSION['_csrf'])) $_SESSION['_csrf']=bin2hex(random_bytes(32)); return $_SESSION['_csrf']; }
function csrf_field(): string { return '<input type="hidden" name="_csrf" value="'.e(csrf_token()).'">'; }
function verify_csrf(): void { if($_SERVER['REQUEST_METHOD']==='POST'&&!hash_equals($_SESSION['_csrf']??'',$_POST['_csrf']??'')){http_response_code(419);exit('Session expired. Reload and try again.');} }
function flash(string $type,string $message): void { $_SESSION['_flash'][]=[$type,$message]; }
function take_flashes(): array { $v=$_SESSION['_flash']??[];unset($_SESSION['_flash']);return $v; }
function is_logged_in(): bool { return isset($_SESSION['user']); }
function current_user(): array { return $_SESSION['user']??[]; }
function require_login(): void { if(!is_logged_in()){flash('warning','Please sign in to continue.');redirect('login.php');} if(time()-(int)($_SESSION['last_activity']??time())>3600){$_SESSION=[];session_destroy();redirect('login.php');} $_SESSION['last_activity']=time(); }
function require_roles(array $roles): void { require_login();if(!in_array(current_user()['role'],$roles,true)){http_response_code(403);require __DIR__.'/403.php';exit;} }
function log_activity(string $action,string $details=''): void { if(is_logged_in()) db()->prepare('INSERT INTO activity_logs(user_id,action,details,ip_address) VALUES(?,?,?,?)')->execute([current_user()['id'],$action,$details,$_SERVER['REMOTE_ADDR']??null]); }
function notify_user(int $id,string $title,string $message,string $type='info'): void { db()->prepare('INSERT INTO notifications(user_id,title,message,type) VALUES(?,?,?,?)')->execute([$id,$title,$message,$type]); }
function badge_class(string $s): string { return match(strtolower($s)){'active','approved','present'=>'success','pending','late','half day'=>'warning','inactive','rejected','absent'=>'danger',default=>'muted'}; }
function current_employee(): ?array { if(!is_logged_in())return null;$q=db()->prepare('SELECT e.*,d.department_name FROM employees e LEFT JOIN departments d ON d.id=e.department_id WHERE e.user_id=?');$q->execute([current_user()['id']]);return $q->fetch()?:null; }
function setting(string $key,string $default=''): string { try{$q=db()->prepare('SELECT setting_value FROM settings WHERE setting_key=?');$q->execute([$key]);$v=$q->fetchColumn();return $v===false?$default:(string)$v;}catch(Throwable){return $default;} }
