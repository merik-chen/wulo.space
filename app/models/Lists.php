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
        $memKey = 'allBoards' . $with_count ? 'WithCount' : '';
        if ( $this->cache->exists($memKey) && $cached )
        {
            $boards = $this->cache->get($memKey);
        } else {
            $this->redis = $this->initRedis();
            $boards = $this->redis->zRange('allBoardsList', 0, -1, $with_count);
            $this->cache->save($memKey, $boards, 60 * 60);
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
            $this->cache->save($memKeyTotalSize, $total, 60 * 60);
        }

        $total_page = ceil($total / $count);

        if ( $this->cache->exists($memKey) && $cached )
        {
            $list = $this->cache->get($memKey);
        } else {
            $page = $page > $total_page ? (int)$total_page : $page;
            $start = ($page - 1) * $count;
            $list = $redis->lRange($board, $start, $start + $count - 1);
            $this->cache->save($memKey, $list, 60 * 60);
        }

        foreach($list as $index => &$article) {
            $aid = $article;
            $find = $this->getDI()->getShared('article')->getArticle(['board' => $board, 'article' => $article], true);
            if (!empty($find)) {
                $find['board'] = $board;
                $find['article'] = $aid;
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
}