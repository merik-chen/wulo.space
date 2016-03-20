<?php
/**
 * Created by PhpStorm.
 * User: merik
 * Date: 2016/3/14
 * Time: 下午10:17
 */

namespace Wulo;


class Article extends Base
{
    public $cache;
    public $redis;

    public function onConstruct() {
        parent::onConstruct();
        $this->redis = $this->initRedis();
        $this->cache = $this->initCache(get_class($this));
        $this->mongo = $this->initMongo();
        $this->gearman  = $this->initGearman();
        $this->database = $this->mongo->selectDB('wulo');
        $this->collection = $this->database->selectCollection('data');
    }

    public function getLatestArticle($count = 5, $cached = true) {
        $memKey = "article:getLatestArticle:$count";

        if ($this->cache->exists($memKey) && $cached) {
            $find = $this->cache->get($memKey);
        } else {
            $re = "/bbs\\/(?P<board>.+)\\/(?P<article>M\\..+).html?/";
            $find = $this->collection->find([], [
                'url' => 1,
                'date' => 1,
                'title' => 1,
            ])->limit($count)->sort(['$natural' => -1]);

            $find = iterator_to_array($find);

            foreach($find as $id => &$data) {
                if(preg_match($re, $data['url'], $matches)) {
                    $data['board'] = $matches['board'];
                    $data['article'] = $matches['article'];
                }
            }

            $this->cache->save($memKey, $find, 60 * 60);
        }

        return $find;
    }

    public function getArticle(array $payload = [], $internal = false) {
        if (empty($payload)) return ['status' => false];

        $memKey = "{$payload['board']}_{$payload['article']}";

        if ($this->cache->exists($memKey)) {
            $find = $this->cache->get($memKey);
        } else {
            $target = "https://www.ptt.cc/bbs/{$payload['board']}/{$payload['article']}.html";
            $hash = $this->make_hash($target);

            $find = $this->collection->findOne(
                ['hash' => $hash]
            );
            if (!empty($find)) $this->cache->save($memKey, $find);;
        }

        if ($internal) {
            return $find;
        }

        if (empty($find)) {
            $ticket = $this->sendBackgroundTask(
                'wulo-get-ptt-article',
                json_encode([
                    'board' => $payload['board'],
                    'article' => $payload['article']
                ]),
                $hash
            );
            return [
                'status' => null,
                'ticket' => $ticket
            ];
        } else {
            return [
                'status' => true,
                'payload' => $find
            ];
        }
    }

    public function getAllArticles(array $filter = [], array $return = [], $iterator = true)
    {
        $find = $this->collection->find($filter, $return);
        return $iterator ? iterator_to_array($find) : $find;
    }

    public function getAllArticlesRedis()
    {
        $this->redis = $this->initRedis();
        return $this->redis->lRange('allArticlesList', 0, -1);
    }
}