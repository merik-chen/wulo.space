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
                            <a href="/bbs/{{board}}/index.html" title="{{ board }} - 五樓，你怎麼說？" itemprop="item">
                                <span itemprop="name">{{ board }}</span>
                            </a>
                        </span>
                        <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope
                              itemtype="https://schema.org/ListItem">
                            <a href="/bbs/{{board}}/{{article}}.html" title="{{ post['title'] }} - 五樓，你怎麼說？" itemprop="item">
                                <span itemprop="name">{{ post['title'] }}</span>
                            </a>
                        </span>
                    </div>

                    <h1 itemprop="headline">{{ post['title'] }}</h1>
                    <h6>作者：
                        <span itemprop="author">{{ post['author'] }} ({{ post['nick']}})</span>
                    </h6>
                    <h6>發文時間：
                        <span itemprop="datePublished">{{ date('Y-m-d H:i:s', post['date']) }}</span>
                    </h6>
                    <h6>原文網址：
                        <span data-open-url="https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html">
                            <span class="hidden-md-up">
                                連結
                            </span>
                            <span class="hidden-sm-down">
                                https://www.ptt.cc/bbs/{{ board }}/{{ article }}.html
                            </span>
                        </span>
                    </h6>

                    <div class="detail-title-info-spacer"></div>

                    <div class="detail-5f-warp text-xs-center">
                        <span>
                        {% if not(post['wulo'] is empty) %}
                            <span itemprop="comment" class="wulo-comment">{{ post['wulo']['content'] }}</span> by {{ post['wulo']['user'] }}
                        {% else %}
                            它的五樓，還未出現...（ＯＡＯ“）
                        {% endif %}
                        </span>
                    </div>

                    <div class="detail-title-info-spacer"></div>

                    <div>
                        <span class="read-more" itemprop="text">{{ post['body'] | trim | nl2br }}</span>
                        <!-- wulo-detail-水平-1 -->
                        <ins class="adsbygoogle"
                             style="display:inline-block;width:100%;height:90px"
                             data-ad-client="ca-pub-3001056417467618"
                             data-ad-slot="3125354204"></ins>
                        <script>
                            (adsbygoogle = window.adsbygoogle || []).push({});
                        </script>
                    </div>
                </div>
            </div>
            <div class="col-xs-12 col-md-6">
                <div class="card">
                    <div class="card-block">
                        <h4 class="card-title">也許你有興趣</h4>
                    </div>
                    <ul class="list-group list-group-flush">
                        {% for post in most_like %}
                        <li class="list-group-item{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <a itemprop="relatedLink" href="/bbs/{{ post['board'] }}//{{ post['article'] }}.html" title="{{ post['title'] }} - {{ post['board'] }}">
                                {{ post['title'] }} - {{ post['board'] }}
                            </a>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
            <div class="col-xs-12 col-md-6">
                <div class="card">
                    <div class="card-block">
                        <h4 class="card-title">最新五樓</h4>
                    </div>
                    <ul class="list-group list-group-flush">
                        {% for post in latest_posts %}
                        <li class="list-group-item{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <a itemprop="relatedLink" href="/bbs/{{ post['board'] }}//{{ post['article'] }}.html" title="{{ post['title'] }} - {{ post['board'] }}">
                                {{ post['title'] }} - {{ post['board'] }}
                            </a>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
            <div class="col-xs-12 col-md-6">
                <div class="card">
                    <div class="card-block">
                        <h4 class="card-title">推薦五樓</h4>
                    </div>
                    <ul class="list-group list-group-flush">
                        {% for post in same_board %}
                        <li class="list-group-item{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <a itemprop="relatedLink" href="/bbs/{{ post['board'] }}//{{ post['article'] }}.html" title="{{ post['title'] }} - {{ post['board'] }}">
                                {{ post['title'] }} - {{ post['board'] }}
                            </a>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
            <div class="col-xs-12 col-md-6">
                <div class="card">
                    <div class="card-block">
                        <h4 class="card-title">熱門看板</h4>
                    </div>
                    <ul class="list-group list-group-flush">
                        {% for post in boards %}
                        <li class="list-group-item{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <a itemprop="relatedLink" href="/bbs/{{ post }}//index.html" title="{{ post }}">
                                {{ post }}
                            </a>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
{% endblock %}

{% block extJs %}
<script src="/bower_components/Readmore.js/readmore.min.js"></script>
<script>
    "use strict";
    $(function () {
        var board = '{{board}}',
            article = '{{article}}';

        $('.wulo-comment').html( function () {
            var text = $(this).html();
            return text.replace(/^:/, '');
        });
        $('.read-more').readmore({
            collapsedHeight: 20,
            moreLink: '<btn class="btn btn-info-outline detail-read-more-btn text-xs-center">觀看全部</btn>',
            lessLink: '<btn class="btn btn-info-outline detail-read-more-btn text-xs-center">收合內容</btn>'
        });
        $('span[data-open-url]').click(function () {
            var link = $(this).data('open-url');
            open(link);
            return false;
        });
    })
</script>
{% endblock %}