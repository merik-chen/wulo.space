<?php
/**
 * Created by PhpStorm.
 * User: merik
 * Date: 2016/3/14
 * Time: 下午10:18
 */

namespace Wulo;


class Base extends \Phalcon\Mvc\Model
{
    protected $mongo;
    protected $gearman;
    protected $database;
    protected $collection;

    function onConstruct() {

        $this->mongo = new \MongoClient("mongodb://192.168.10.254:27017");
        $this->gearman = new \GearmanClient();
        $this->gearman->addServer('192.168.10.254');

        $this->database = $this->mongo->selectDB('wulo');
        $this->collection = $this->database->selectCollection('data');
    }

    protected function make_hash($text) {
        return strval(sha1($text));
    }
}