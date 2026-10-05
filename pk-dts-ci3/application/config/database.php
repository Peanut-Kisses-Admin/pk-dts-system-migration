<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
    'dsn'      => '',
    'hostname' => (string) dts_env('DB_HOST', '127.0.0.1'),
    'port'     => (string) dts_env('DB_PORT', '5432'),
    'username' => (string) dts_env('DB_USER', 'postgres'),
    'password' => (string) dts_env('DB_PASSWORD', ''),
    'database' => (string) dts_env('DB_NAME', 'pk_dts'),
    'dbdriver' => (string) dts_env('DB_DRIVER', 'postgre'),
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (defined('ENVIRONMENT') && ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8',
    'dbcollat' => 'utf8_general_ci',
    'swap_pre' => '',
    'encrypt'  => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE,
);
