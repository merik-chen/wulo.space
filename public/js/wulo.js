"use strict";

/**
 * Created by merik on 2016/3/10.
 */

var wulo = window.wulo || {};
var trackingArticle = false;

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
    },
    promisePost: function (url, payload, type) {
        var jQueryPromise = $.ajax({
            url: url,
            method: "POST",
            data: payload,
            dataType: type
        });
        return Promise.resolve(jQueryPromise);
    },
    trackingArticle: function (url, payload, type, success_callback) {
        var tracking_timer = setInterval(function () {
            var jQueryPromise = $.ajax({
                url: url,
                method: "POST",
                data: payload,
                dataType: type
            });
            jQueryPromise.done(function (rsp) {
                if (rsp.status) {
                    clearInterval(tracking_timer);
                    trackingArticle = true;
                    success_callback(rsp);
                }
            });
        }, 1000);
    }
};
