<?php
// Copy this file to config/config.local.php on your server and fill in the
// values from your hosting control panel. Never commit config.local.php.
return [
    'DB_HOST' => 'localhost',          // MySQL host name from your host
    'DB_PORT' => '3306',
    'DB_NAME' => 'your_database_name',
    'DB_USER' => 'your_database_user',
    'DB_PASS' => 'your_database_password',
    'APP_DEBUG' => '0',                // keep 0 on a public server
];
