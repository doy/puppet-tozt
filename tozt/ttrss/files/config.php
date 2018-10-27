<?php

define('DB_TYPE', "pgsql");
define('DB_HOST', "localhost");
define('DB_USER', "ttrss");
define('DB_NAME', "ttrss");
define('DB_PASS', "");
define('DB_PORT', '5432');

define('SELF_URL_PATH', 'https://rss.tozt.net/');
define('SINGLE_USER_MODE', false);
define('SIMPLE_UPDATE_MODE', false);

define('PHP_EXECUTABLE', '/usr/bin/php');
define('LOCK_DIRECTORY', 'lock');
define('CACHE_DIR', 'cache');
define('ICONS_DIR', 'feed-icons');
define('ICONS_URL', 'feed-icons');

define('AUTH_AUTO_CREATE', true);
define('AUTH_AUTO_LOGIN', true);

define('FORCE_ARTICLE_PURGE', 0);

define('ENABLE_REGISTRATION', false);
define('REG_NOTIFY_ADDRESS', 'ttrss@tozt.net');
define('REG_MAX_USERS', 2);

define('SESSION_COOKIE_LIFETIME', 86400);

define('SMTP_FROM_NAME', 'Tiny Tiny RSS');
define('SMTP_FROM_ADDRESS', 'ttrss-noreply@tozt.net');
define('DIGEST_SUBJECT', '[tt-rss] New headlines for last 24 hours');
define('SMTP_SERVER', '');
define('SMTP_LOGIN', '');
define('SMTP_PASSWORD', '');
define('SMTP_SECURE', 'tls');

define('CHECK_FOR_UPDATES', false);
define('ENABLE_GZIP_OUTPUT', false);
define('PLUGINS', 'auth_internal, note');
define('LOG_DESTINATION', 'sql');
define('CONFIG_VERSION', 26);
