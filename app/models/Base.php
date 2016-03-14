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
}