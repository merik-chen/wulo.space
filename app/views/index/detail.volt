{% extends "templates.volt" %}

{% block title %}{{ post['title'] }}，{% endblock %}

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

    <div itemscope itemtype="https://schema.org/BreadcrumbList">
        <span itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
            <a href="/" title="五樓，你怎麼說？" itemprop="item">
                <span itemprop="name">五樓，你怎麼說？</span>
            </a>
        </span>
        <span itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
            <a href="/bbs/{{board}}/index.html" itemprop="item">
                <span itemprop="name">{{ board }}</span>
            </a>
        </span>
        <span itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
            <a href="/bbs/{{board}}/{{article}}.html" itemprop="item">
                <span itemprop="name">{{ post['title'] }}</span>
            </a>
        </span>


    </div>
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