{% extends "templates.volt" %}

{% block title %}{{ post['title'] }}，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<link rel="stylesheet" href="/scss/detail.css">
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
{% include "layouts/navbar.volt" %}
<div class="row">
    <div class="col-xs-12">

    </div>
    <p>
        <a href="/">
            繼續找五樓
        </a>
    </p>


    <div itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemPage">
        <p>Board: {{board}}</p>
        <p>Article: {{article}}</p>
        <h1 itemprop="name">{{ post['title'] }}</h1>
        <p>
            <a href="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">
                https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html
            </a>
        </p>
        <pre itemscope="text">{{ post['body'] }}</pre>
        <p>
        <span>
            {{ post['wulo']['user'] }}[{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }}
        </span>
        </p>
    </div>
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