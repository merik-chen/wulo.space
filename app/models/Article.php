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
    public function onConstruct() {
        parent::onConstruct();
    }

    public function getLatestArticle($count = 5) {
        $find = $this->collection->find([], [
            'url' => 1,
            'date' => 1,
            'title' => 1,
        ])->limit($count);

        return iterator_to_array($find);
    }

    public function getArticle(array $payload = []) {
        if (empty($payload)) return ['status' => false];

        $target = "https://www.ptt.cc/bbs/{$payload['board']}/{$payload['article']}.html";
        $hash = $this->make_hash($target);

        $find = $this->collection->findOne(
            ['hash' => $hash]
        );

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

//        return [
//            'status' => false
//        ];
    }
}