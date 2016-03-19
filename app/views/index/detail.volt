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
                                <span class="hidden-xs-up" itemprop="name">五樓，你怎麼說？</span>
                                <span>首頁</span>
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
                    <h6>作者：
                        <span>{{ post['author'] }} ({{ post['nick']}})</span>
                    </h6>
                    <h6>發文時間：
                        <span>{{ date('Y-m-d H:i:s', post['date']) }}</span>
                    </h6>
                    <h6>原文網址：
                        <a href="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">
                            <span class="hidden-md-up">
                                連結
                            </span>
                            <span class="hidden-sm-down">
                                https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html
                            </span>
                        </a>
                    </h6>

                    <div class="detail-title-info-spacer"></div>

                    <div class="detail-5f-warp text-xs-center">
                        <span>
                        {% if not(post['wulo'] is empty) %}
                            [{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }} by {{ post['wulo']['user'] }}
                        {% else %}
                            它的五樓，還未出現...（ＯＡＯ“）
                        {% endif %}
                        </span>
                    </div>

                    <div class="detail-title-info-spacer"></div>

                    <div>
                        <span class="read-more" itemscope="text">{{ post['body'] | nl2br }}</span>
                        <!-- wulo-detail-水平-1 -->
                        <ins class="adsbygoogle"
                             style="display:inline-block;width:100%;height:90px"
                             data-ad-client="ca-pub-3001056417467618"
                             data-ad-slot="4519532201"></ins>
                        <script>
                            (adsbygoogle = window.adsbygoogle || []).push({});
                        </script>
                    </div>
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
        $('.read-more').readmore({
            collapsedHeight: 20
        });
    })
</script>
{% endblock %}