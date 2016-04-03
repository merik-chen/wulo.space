<?php
/**
 * Created by PhpStorm.
 * User: merik
 * Date: 2016/3/20
 * Time: 上午1:31
 */

namespace Wulo;

use Wulo;
class Lists extends Base
{
    public $cache;
    public $redis;

    public function onConstruct() {
        parent::onConstruct();
        $this->cache = $this->initCache(get_class($this));
        $this->mongo = $this->initMongo();
        $this->gearman  = $this->initGearman();
        $this->database = $this->mongo->selectDB('wulo');
        $this->collection = $this->database->selectCollection('data');
    }

    public function getAllBoards($with_count = false, $cached = true)
    {
        $memKey = 'allBoards';
        $memKey = $with_count ? $memKey . 'WithCount' : $memKey;
        if ( $this->cache->exists($memKey) && $cached )
        {
            $boards = $this->cache->get($memKey);
        } else {
            $this->redis = $this->initRedis();
            $boards = $this->redis->zRange('allBoardsList', 0, -1, $with_count);
            $this->cache->save($memKey, $boards, 60 * 60 * 2);
        }

        return $boards;
    }

    public function getBoardList($board = '', $page = 1, $cached = true)
    {
        $count = 50;
        $redis = $this->initRedis();
        $memKey = "$board:$page";
        $memKeyTotalSize = "$board:size";

        if ( $this->cache->exists($memKeyTotalSize) && $cached )
        {
            $total = $this->cache->get($memKeyTotalSize);
        } else {
            $total = $redis->lLen($board);
            $this->cache->save($memKeyTotalSize, $total, 60 * 60 * 2);
        }

        $total_page = ceil($total / $count);

        if ( $this->cache->exists($memKey) && $cached )
        {
            $list = $this->cache->get($memKey);
        } else {
            $page = $page > $total_page ? (int)$total_page : $page;
            $start = ($page - 1) * $count;
            $list = $redis->lRange($board, $start, $start + $count - 1);
            $this->cache->save($memKey, $list, 60 * 60 * 2);
        }

        foreach($list as $index => &$article) {
            $aid = $article;
            $find = $this->getDI()->getShared('article')->getArticle(['board' => $board, 'article' => $article], true);
            if (!empty($find)) {
                $find['board'] = $board;
                $find['article'] = $aid;
                $find['abstract'] = mb_strimwidth(strip_tags($find['body']), 0, 50, '...', 'utf-8');
                unset($find['body']);
                unset($find['hash']);
                unset($find['ip']);
                $article = $find;
            } else {
                unset($list[$index]);
            }
        }

        return [
            'now' => $page,
            'list' => $list,
            'total' => $total_page
        ];
    }

    public function getMostLikePosts($count = 20, $cached = true)
    {
        $memKey = "Global:Most:Like:$count";

        if ($this->cache->exists($memKey) && $cached)
        {
            $find = $this->cache->get($memKey);
        }else{
            $query = $this->collection->find(['like' => ['$exists' => true]],
                [
                    'url' => 1,
                    'like' => 1,
                    'title' => 1,
                    'board' => 1,
                ]
            )->sort(['like' => -1])->limit($count);

            $find = iterator_to_array($query);

            foreach($find as $key => &$value)
            {
                if(preg_match($this->link_parse, $value['url'], $matches)) {
                    $value['board'] = $matches['board'];
                    $value['article'] = $matches['article'];
                }
            }

            if (!empty($find)) $this->cache->save($memKey, $find, 60 * 60 * 2);
        }

        return$find;
    }
}