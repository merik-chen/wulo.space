<?php
/**
 * Created by PhpStorm.
 * User: merik
 * Date: 2016/4/4
 * Time: 下午6:35
 */

namespace Wulo;


class Attachment extends Base
{
    public $cache;

    public function onConstruct() {
        parent::onConstruct();
        $this->cache = $this->initCache(get_class($this));
        $this->mongo = $this->initMongo();
        $this->gearman  = $this->initGearman();
        $this->database = $this->mongo->selectDB('screenshot');
        $this->collection = $this->database->selectCollection('store');
    }

    public function getScreenShot($hash)
    {
        $find = $this->collection->find_one(['hash' => $hash]);
        return empty($find) ? false : $find;
    }
}