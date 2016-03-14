{% extends "templates.volt" %}

{% block title %}{{ post['title'] }}{% endblock %}

{% block extCss %}
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div>
    <p>
        <a href="/">
            繼續找五樓
        </a>
    </p>
    <p>Board: {{board}}</p>
    <p>Article: {{article}}</p>
    <p>
        <a href="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">
            https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html
        </a>
    </p>
    <pre>{{ post['body'] }}</pre>
    <p>
        <span>
            {{ post['wulo']['user'] }}[{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }}
        </span>
    </p>
</div>
{% endblock %}

{% block extJs %}
<script>
    "use strict";
    $(function () {
        var board = '{{board}}',
            article = '{{article}}';
    })
</script>
{% endblock %}