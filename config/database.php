<?php
// Database and environment settings.
// On a hosted server, copy config/config.example.php to config/config.local.php
// and fill in the values from your hosting control panel. config.local.php is
// not committed to Git. Environment variables with the same names also work.
// Without either, the XAMPP defaults below are used.
$emsLocalConfig = __DIR__ . '/config.local.php';
$emsConfig = is_file($emsLocalConfig) ? (array)require $emsLocalConfig : [];
$emsSetting = static function (string $key, string $default) use ($emsConfig): string {
    if (array_key_exists($key, $emsConfig)) return (string)$emsConfig[$key];
    $env = getenv($key);
    return $env === false ? $default : $env;
};
define('DB_HOST', $emsSetting('DB_HOST', '127.0.0.1'));
define('DB_PORT', $emsSetting('DB_PORT', '3306'));
define('DB_NAME', $emsSetting('DB_NAME', 'ems'));
define('DB_USER', $emsSetting('DB_USER', 'root'));
define('DB_PASS', $emsSetting('DB_PASS', ''));
// Show PHP errors only while developing. Defaults to on when the visitor is this
// computer (XAMPP), off for everyone else.
$emsIsLocal = PHP_SAPI === 'cli' || in_array($_SERVER['REMOTE_ADDR'] ?? '', ['127.0.0.1', '::1'], true);
define('APP_DEBUG', filter_var($emsSetting('APP_DEBUG', $emsIsLocal ? '1' : '0'), FILTER_VALIDATE_BOOLEAN));
unset($emsLocalConfig, $emsConfig, $emsSetting, $emsIsLocal);

function db(): PDO {
    static $pdo = null;
    if ($pdo instanceof PDO) return $pdo;
    $pdo = new PDO('mysql:host=' . DB_HOST . ';port=' . DB_PORT . ';dbname=' . DB_NAME . ';charset=utf8mb4', DB_USER, DB_PASS, [PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION, PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC, PDO::ATTR_EMULATE_PREPARES=>false, PDO::MYSQL_ATTR_INIT_COMMAND=>"SET time_zone='+05:30'"]);
    return $pdo;
}
