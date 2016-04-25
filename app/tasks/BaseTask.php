<?php

use \Phalcon\Cli;
class BaseTask extends Cli\Task
{
    protected $mongo, $redis, $redisServer, $mongoServer, $jobServer, $memcacheServer;

    public function onConstruct()
    {

    }

	public function mainAction()
	{
		echo "\nThis is the default task and the default action \n";
	}

    public function initialize()
    {
        if( APPLICATION_ENV == 'production' )
        {
            $this->redisServer  = '192.168.31.106:6381';
            $this->mongoServer  = '192.168.31.101';
            $this->jobServer    = '192.168.31.108';
            $this->memcacheServer   = '192.168.31.100';
        }else{
            $this->redisServer  = '127.0.0.1:6379';
            $this->mongoServer  = '127.0.0.1';
            $this->jobServer    = '127.0.0.1';
            $this->memcacheServer   = '127.0.0.1';
        }
    }

    protected function initGearman()
    {
        $gearman = new \GearmanClient();
        $gearman->addServer('192.168.122.1');
        return $gearman;
    }

    protected function initMongo()
    {
        $mongo = new \MongoClient("mongodb://192.168.122.253:27017");
        return $mongo;
    }

    protected function initRedis()
    {
        $redis = new \Redis();
        $redis->pconnect('192.168.122.1');
        return $redis;
    }

}
