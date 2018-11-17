<?php
$conf['dblayer']      = 'mysqli';
$conf['db_base']      = getenv('MYSQL_BASE')      ?? 'piwigo';
$conf['db_user']      = getenv('MYSQL_USER')      ?? 'piwigo';
$conf['db_password']  = getenv('MYSQL_PASSWORD')  ?? 'piwigo';
$conf['db_host']      = getenv('MYSQL_HOST')      ?? 'db';

$prefixeTable         = getenv('MYSQL_PREFIX')    ?? 'piwigo_';

define('PHPWG_INSTALLED', true);
define('PWG_CHARSET', 'utf-8');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
?>
