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
        <div itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemPage">
            <h1 itemprop="name">{{ post['title'] }}</h1>

            <div itemscope itemtype="https://schema.org/BreadcrumbList">
                <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a href="/" title="五樓，你怎麼說？" itemprop="item">
                        <span itemprop="name">五樓，你怎麼說？</span>
                    </a>
                </span>
                <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a href="/bbs/{{board}}/index.html" itemprop="item">
                        <span itemprop="name">{{ board }}</span>
                    </a>
                </span>
                <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
                    <a href="/bbs/{{board}}/{{article}}.html" itemprop="item">
                        <span itemprop="name">{{ post['title'] }}</span>
                    </a>
                </span>
            </div>

<!--            <p>-->
<!--                <a href="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">-->
<!--                    https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html-->
<!--                </a>-->
<!--            </p>-->
            <div>
                <pre itemscope="text">{{ post['body'] }}</pre>
            </div>
            <p>
                <span>
                    {{ post['wulo']['user'] }}[{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }}
                </span>
            </p>
        </div>
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