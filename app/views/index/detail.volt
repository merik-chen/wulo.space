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
            console.log(rsp);
        });
    })
</script>
{% endblock %}