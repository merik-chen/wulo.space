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

    public function getArticle(array $payload = []) {
        if (empty($payload)) return ['status' => false];

        $target = "https://www.ptt.cc/bbs/{$payload['board']}/{$payload['article']}.html";
        $hash = $this->make_hash($target);

        $find = $this->collection->findOne(
            ['hash' => $hash]
        );

        if (!empty($find)) {
            return [
                'status' => true,
                'payload' => $find
            ];
        }

        return [
            'status' => false
        ];
    }
}