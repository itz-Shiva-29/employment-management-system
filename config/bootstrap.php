<?php
declare(strict_types=1);
date_default_timezone_set('Asia/Kolkata');
require_once __DIR__ . '/database.php';

ini_set('display_errors', APP_DEBUG ? '1' : '0');
ini_set('log_errors', '1');
error_reporting(E_ALL);

function ems_is_https(): bool {
    if (!empty($_SERVER['HTTPS']) && strtolower((string)$_SERVER['HTTPS']) !== 'off') return true;
    if ((string)($_SERVER['SERVER_PORT'] ?? '') === '443') return true;
    return strtolower((string)($_SERVER['HTTP_X_FORWARDED_PROTO'] ?? '')) === 'https';
}

if (!headers_sent()) {
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: DENY');
    header('Referrer-Policy: same-origin');
    if (ems_is_https()) header('Strict-Transport-Security: max-age=31536000');
}

if (session_status() !== PHP_SESSION_ACTIVE) {
    ini_set('session.use_strict_mode', '1');
    ini_set('session.use_only_cookies', '1');
    ini_set('session.cookie_httponly', '1');
    ini_set('session.cookie_samesite', 'Lax');
    ini_set('session.cookie_secure', ems_is_https() ? '1' : '0');
    ini_set('session.cookie_lifetime', '0');
    ini_set('session.gc_maxlifetime', '3600');
    session_name('ems_session');
    session_start();
}
require_once __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../includes/auth.php';
