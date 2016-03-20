<?php

use Phalcon\DI\FactoryDefault\CLI as CliDI,
    Phalcon\CLI\Console as ConsoleApp;

define('VERSION', '1.0.0');

//Using the CLI factory default services container
$di = new CliDI();

// Define path to application directory
defined('APPLICATION_PATH')
|| define('APPLICATION_PATH', realpath(dirname(__FILE__)));

/**
 * Register the autoloader and tell it to register the tasks directory
 */
$loader = new \Phalcon\Loader();
$loader->registerDirs(
    array(
        APPLICATION_PATH . '/library',
        APPLICATION_PATH . '/tasks'
    )
);
$loader->register();

$loader->registerNamespaces(array(
    'Wulo' => APPLICATION_PATH . '/models/',
))->register();

// Load the configuration file (if any)
if (is_readable(APPLICATION_PATH . '/config/config.php')) {
    $config = include APPLICATION_PATH . '/config/config.php';
    $di->set('config', $config);
}

$di->set('crypt', function () {
    $crypt = new Phalcon\Crypt();
    $crypt->setKey('Merik1316'); //Pi3.141596 (ripemd320)
    return $crypt;
}, true);

$di->setShared('session', function () {
    $session = new Phalcon\Session\Adapter\Files();
    $session->start();

    return $session;
});


$di->setShared('article', function () {
    return new Wulo\Article();
});

$di->setShared('lists', function () {
    return new Wulo\Lists();
});

$di->setShared('sitemap', function () {
    return new Wulo\Sitemap();
});

//Create a console application
$console = new ConsoleApp();
$console->setDI($di);

/**
 * Process the console arguments
 */
$arguments = array();
foreach ($argv as $k => $arg) {
    if ($k == 1) {
        $arguments['task'] = $arg;
    } elseif ($k == 2) {
        $arguments['action'] = $arg;
    } elseif ($k >= 3) {
        $arguments['params'][] = $arg;
    }
}

// define global constants for the current task and action
define('CURRENT_TASK', (isset($argv[1]) ? $argv[1] : null));
define('CURRENT_ACTION', (isset($argv[2]) ? $argv[2] : null));

defined('APPLICATION_ENV') || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));

try {
    // handle incoming arguments
    $console->handle($arguments);
} catch (\Phalcon\Exception $e) {
    var_dump($e);
    exit(255);
}
