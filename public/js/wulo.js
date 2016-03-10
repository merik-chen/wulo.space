"use strict";

/**
 * Created by merik on 2016/3/10.
 */

var wulo = window.wulo || {};

wulo.utility = {
    ptt_link_extract: function (url) {
        var regex = /ptt.+\/bbs\/(\w+)\/([\w\.]+)\.html?/,
            result;
        result = regex.exec(url);
        if (result !== null) {
            return {
                'board': result[1],
                'article': result[2]
            };
        }
        return false;
    }
};
