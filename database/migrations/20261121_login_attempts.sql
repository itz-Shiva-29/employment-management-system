-- Adds failed sign-in tracking used to limit password guessing.
-- Safe to run on an existing installation; it does not change other data.
CREATE TABLE IF NOT EXISTS login_attempts (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, identity VARCHAR(190) NOT NULL, ip_address VARCHAR(45) NOT NULL, attempted_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, INDEX idx_login_identity (identity, attempted_at), INDEX idx_login_ip (ip_address, attempted_at)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
