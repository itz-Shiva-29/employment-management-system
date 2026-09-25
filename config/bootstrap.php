<?php
declare(strict_types=1);
if (session_status() !== PHP_SESSION_ACTIVE) { ini_set('session.use_strict_mode','1'); ini_set('session.cookie_httponly','1'); ini_set('session.cookie_samesite','Lax'); ini_set('session.cookie_lifetime',isset($_POST['remember'])?'2592000':'0'); session_name('ems_session'); session_start(); }
require_once __DIR__ . '/database.php';
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';
