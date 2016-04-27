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
    public $projectName = 'Wulo';
    protected $mongo = false;
    protected $reids = false;
    protected $gearman = false;
    protected $database = null;
    protected $collection = null;
    protected $frontCache;

    public $link_parse = "/bbs\\/(?P<board>.+)\\/(?P<article>M\\..+).html?/";

    function onConstruct() {

        $this->frontCache = new Phalcon\Cache\Frontend\Data(array(
            "lifetime" => 604800
        ));

    }

    function sendBackgroundTask($task_name, $task_payload, $task_unique = null) {
        return $this->gearman->doBackground($task_name, $task_payload, $task_unique);
    }

    protected function make_hash($text) {
        return strval(sha1($text));
    }

    protected function initGearman()
    {
        $gearman = new \GearmanClient();
        $gearman->addServer('192.168.122.1');
        return $gearman;
    }

    protected function initMongo()
    {
        $mongo = new \MongoClient("mongodb://192.168.122.253:27017,192.168.10.251:27018", ['replicaSet' => 'dbrepl']);
        return $mongo;
    }

    protected function initRedis()
    {
        $redis = new \Redis();
        $redis->pconnect('192.168.122.253');
        return $redis;
    }

    // Memcache 使用 phalcon 的 Libmemcached
    protected function initCache( $prefix )
    {
        //Create the Cache setting memcached connection options
        $cache = new Phalcon\Cache\Backend\Libmemcached($this->frontCache, array(
            'servers' => array(
                array(
                    'host'      => '127.0.0.1',
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
