<?php
/**
 * Services are globally registered in this file
 *
 * @var \Phalcon\Config $config
 */

use Phalcon\Di\FactoryDefault;
use Phalcon\Mvc\View;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Direct as Flash;

/**
 * The FactoryDefault Dependency Injector automatically register the right services providing a full stack framework
 */
$di = new FactoryDefault();

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () use ($config) {
    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () use ($config) {

    $view = new View();

    $view->setViewsDir($config->application->viewsDir);

    $view->registerEngines(array(
        '.volt' => function ($view, $di) use ($config) {

            $volt = new VoltEngine($view, $di);

            $volt->setOptions(array(
                'compiledPath' => $config->application->cacheDir,
                'compiledSeparator' => '_',
                'compileAlways' => true
            ));

            return $volt;
        },
        '.phtml' => 'Phalcon\Mvc\View\Engine\Php'
    ));

    return $view;
});

/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    return new Flash(array(
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ));
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
});

$di->setShared('router', function () {
    $router = new \Phalcon\Mvc\Router();

    $router->addGet("/screenshot/(\\w+)/([\\w\\.]+).png?", [
        'controller'    => 'index',
        'action'        => 'getScreenshot',
        'board'         => 1,
        'post'          => 2
    ]);

    $router->addGet("/bbs/(\\w+)/([\\w\\.]+).html?", [
        'controller'    => 'index',
        'action'        => 'detail',
        'board'         => 1,
        'post'          => 2
    ]);

    $router->addGet("/bbs/(\\w+)/index(\\d+)?.html?", [
        'controller'    => 'index',
        'action'        => 'list',
        'board'         => 1,
        'page'          => 2
    ]);

    $router->addGet("/bbs/(\\w+)/index.html?", [
        'controller'    => 'index',
        'action'        => 'list',
        'board'         => 1
    ]);

    $api = new \Phalcon\Mvc\Router\Group();
    $api->setPrefix('/api');

    $api->add('/get5F', [
        'controller'    => 'index',
        'action'        => 'postGet5F'
    ]);

    $router->mount($api);

    return $router;
});

$di->setShared('article', function () {
    return new Wulo\Article();
});

$di->setShared('lists', function () {
    return new Wulo\Lists();
});

$di->setShared('attachment', function () {
    return new Wulo\Attachment();
});
