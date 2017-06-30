<?php
$conf['dblayer']     = 'mysqli';
$conf['db_base']     = getenv('DB_BASE')   ?? 'piwigo';
$conf['db_user']     = getenv('DB_USER')   ?? 'piwigo';
$conf['db_password'] = getenv('DB_PASS')   ?? '';
$conf['db_host']     = getenv('DB_HOST')   ?? 'localhost';

$prefixeTable        = getenv('DB_PREFIX') ?? '';

define('PHPWG_INSTALLED', true);
define('PWG_CHARSET', 'utf-8');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
?>
