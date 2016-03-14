{% extends "templates.volt" %}


{% block extCss %}
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div>
    <p>Board: {{board}}</p>
    <p>Post: {{post}}</p>
    <p>
        <a href="https://www.ptt.cc/bbs/{{ board }}/{{ post }}.html">
            https://www.ptt.cc/bbs/{{ board }}/{{ post }}.html
        </a>
    </p>
</div>
{% endblock %}

{% block extJs %}
<script>
    "use strict";
    $(function () {
        var board = '{{board}}',
            article = '{{post}}';

        var get_article = wulo.utility.promisePost(
            '/api/get5F',
            {
                'payload': {
                    'board': board,
                    'article': article
                }
            },
            'json'
        );

        get_article.done(function (rsp) {
            switch (rsp.status) {
                case true:
//                    window.location.href = '/bbs/' + board + '/' + article + '.html';
                    break;
                case false:
                    console.error('Get article failed!', rsp);
                    break;
                case null:
                    wulo.utility.trackingArticle(
                        '/api/get5F',
                        {
                            'payload': {
                                'board': board,
                                'article': article
                            }
                        },
                        'json',
                        function (rsp) {
                            console.log(rsp);
                        }
                    );
                    break;
                default:
                    console.error('Un-know state.', rsp);
                    break;
            }
        });
    })
</script>
{% endblock %}