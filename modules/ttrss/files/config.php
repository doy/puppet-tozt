<?php

putenv('TTRSS_DB_TYPE=pgsql');
putenv('TTRSS_DB_HOST=localhost');
putenv('TTRSS_DB_USER=ttrss');
putenv('TTRSS_DB_NAME=ttrss');
putenv('TTRSS_DB_PASS=');
putenv('TTRSS_DB_PORT=5432');
putenv('TTRSS_MYSQL_CHARSET=UTF8');

putenv('TTRSS_SELF_URL_PATH=https://rss.tozt.net/');
putenv('TTRSS_SINGLE_USER_MODE=false');
putenv('TTRSS_SIMPLE_UPDATE_MODE=false');

putenv('TTRSS_PHP_EXECUTABLE=/usr/bin/php');
putenv('TTRSS_LOCK_DIRECTORY=lock');
putenv('TTRSS_CACHE_DIR=cache');
putenv('TTRSS_ICONS_DIR=feed-icons');
putenv('TTRSS_ICONS_URL=feed-icons');

putenv('TTRSS_AUTH_AUTO_CREATE=true');
putenv('TTRSS_AUTH_AUTO_LOGIN=true');

putenv('TTRSS_FORCE_ARTICLE_PURGE=0');

putenv('TTRSS_SPHINX_SERVER=localhost:9312');
putenv('TTRSS_SPHINX_INDEX=ttrss, delta');

putenv('TTRSS_ENABLE_REGISTRATION=false');
putenv('TTRSS_REG_NOTIFY_ADDRESS=ttrss@tozt.net');
putenv('TTRSS_REG_MAX_USERS=2');

putenv('TTRSS_SESSION_COOKIE_LIFETIME=86400');

putenv('TTRSS_SMTP_FROM_NAME=Tiny Tiny RSS');
putenv('TTRSS_SMTP_FROM_ADDRESS=ttrss-noreply@tozt.net');
putenv('TTRSS_DIGEST_SUBJECT=[tt-rss] New headlines for last 24 hours');
putenv('TTRSS_SMTP_SERVER=');
putenv('TTRSS_SMTP_LOGIN=');
putenv('TTRSS_SMTP_PASSWORD=');
putenv('TTRSS_SMTP_SECURE=tls');

putenv('TTRSS_CHECK_FOR_UPDATES=false');
putenv('TTRSS_ENABLE_GZIP_OUTPUTfalse');
putenv('TTRSS_PLUGINS=auth_internal, note');
putenv('TTRSS_LOG_DESTINATION=sql');
putenv('TTRSS_CONFIG_VERSION=26');
