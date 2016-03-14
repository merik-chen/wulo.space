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

        $.post(
            '/api/get5F',
            {
                'board': board,
                'article': article
            },
            function (rsp) {
                console.log(rsp)
            }, 'json'
        );
    })
</script>
{% endblock %}