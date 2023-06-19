<?php

$MySettings = array(
	'db_host'    => $_ENV['DB_HOSTNAME'],
	'db_name'    => $_ENV['DB_ENV_MYSQL_DATABASE'],
	'db_user'    => $_ENV['DB_ENV_MYSQL_USER'],
	'db_pwd'     => $_ENV['DB_ENV_MYSQL_PASSWORD'],
	'db_subname' => $_ENV['DB_PREFIX'],
);

$MyModuleSettings = array();
$MyModules = array('addons' => array());
