{% extends "templates.volt" %}

{% block title %}{{ post['title'] }}，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<link rel="stylesheet" href="/scss/detail.css">
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div class="row">
    <div class="col-xs-12 col-md-8 col-md-push-2">
        {% include "layouts/navbar.volt" %}
        <div class="row detail-warp">
            <div class="col-xs-12">
                <div itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemPage">

                    <div class="detail-breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
                        <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope
                              itemtype="https://schema.org/ListItem">
                            <a href="/" title="五樓，你怎麼說？" itemprop="item">
                                <span itemprop="name">五樓，你怎麼說？</span>
                            </a>
                        </span>
                        <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope
                              itemtype="https://schema.org/ListItem">
                            <a href="/bbs/{{board}}/index.html" itemprop="item">
                                <span itemprop="name">{{ board }}</span>
                            </a>
                        </span>
                        <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope
                              itemtype="https://schema.org/ListItem">
                            <a href="/bbs/{{board}}/{{article}}.html" itemprop="item">
                                <span itemprop="name">{{ post['title'] }}</span>
                            </a>
                        </span>
                    </div>

                    <h1 itemprop="name">{{ post['title'] }}</h1>
                    <!--            <p>-->
                    <!--                <a href="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">-->
                    <!--                    https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html-->
                    <!--                </a>-->
                    <!--            </p>-->
                    <div>
                        <span class="readmore" itemscope="text">{{ post['body'] }}</span>
                    </div>
                    <p>
                        <span>
                            {{ post['wulo']['user'] }}[{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }}
                        </span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
{% endblock %}

{% block extJs %}
<script src="/bower_components/Readmore.js/readmore.js"></script>
<script>
    "use strict";
    $(function () {
        var board = '{{board}}',
            article = '{{article}}';
        $('.readmore').readmore();
    })
</script>
{% endblock %}