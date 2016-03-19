<?php
/**
 * Created by PhpStorm.
 * User: merik
 * Date: 2016/3/14
 * Time: 下午10:18
 */

namespace Wulo;

use \Phalcon;

class Base extends Phalcon\Mvc\Model
{
    protected $mongo;
    protected $gearman;
    protected $database;
    protected $collection;
    protected $frontCache;

    function onConstruct() {

        $this->frontCache = new Phalcon\Cache\Frontend\Data(array(
            "lifetime" => 604800
        ));

        $this->mongo = new \MongoClient("mongodb://192.168.122.1:27017");
        $this->gearman = new \GearmanClient();
        $this->gearman->addServer('192.168.122.1');


        $this->database = $this->mongo->selectDB('wulo');
        $this->collection = $this->database->selectCollection('data');
    }

    function sendBackgroundTask($task_name, $task_payload, $task_unique = null) {
        return $this->gearman->doBackground($task_name, $task_payload, $task_unique);
    }

    protected function make_hash($text) {
        return strval(sha1($text));
    }

    // Memcache 使用 phalcon 的 Libmemcached
    protected function initCache( $prefix )
    {
        //Create the Cache setting memcached connection options
        $cache = new Phalcon\Cache\Backend\Libmemcached($this->frontCache, array(
            'servers' => array(
                array(
                    'host'      => '192.168.122.1',
                    'port'      => 11211,
                    'weight'    => 1
                ),
            ),
            'client' => array(
                \Memcached::OPT_HASH => \Memcached::HASH_MD5,
                \Memcached::OPT_PREFIX_KEY => '_Phalcon.'.$this->projectName.'.'.$prefix.'.',
            ),
            'statsKey' => ''
        ));

        return $cache;
    }
}