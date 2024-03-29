{% extends "templates.volt" %}

{% block title %}站內搜尋，{% endblock %}

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
                            <a href="/search" title="站內搜尋 - 五樓，你怎麼說？" itemprop="item">
                                <span itemprop="name">站內搜尋</span>
                            </a>
                        </span>
                    </div>

                    <div class="detail-title-info-spacer"></div>

                    <div>
                        <script>
                            (function() {
                                var cx = '005531783808230047355:mcrp0hemfjw';
                                var gcse = document.createElement('script');
                                gcse.type = 'text/javascript';
                                gcse.async = true;
                                gcse.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') +
                                    '//cse.google.com/cse.js?cx=' + cx;
                                var s = document.getElementsByTagName('script')[0];
                                s.parentNode.insertBefore(gcse, s);
                            })();
                        </script>
                        <gcse:search></gcse:search>
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

            <div class="col-xs-12">
                <div class="detail-list-article">
                    <div class="card-columns">
                        {% for post in latest_posts %}
                        <div class="card{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <a itemprop="relatedLink" href="/bbs/{{ post['board'] }}//{{ post['article'] }}.html" title="{{ post['title'] }} - {{ post['board'] }}">
                                        {{ post['title'] }} - {{ post['board'] }}
                                    </a>
                                </h5>
                                <p class="card-text">
                                    <small class="text-muted">
                                        推: {{ article['like']| default('0') }}
                                    </small>
                                </p>
                            </div>
                        </div>
                        {% endfor %}
                        {% for post in most_like %}
                        <div class="card{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <div class="card-block">
                                <h5 class="card-title">
                                    <a itemprop="relatedLink" href="/bbs/{{ post['board'] }}//{{ post['article'] }}.html" title="{{ post['title'] }} - {{ post['board'] }}">
                                        {{ post['title'] }} - {{ post['board'] }}
                                    </a>
                                </h5>
                                <p class="card-text">
                                    <small class="text-muted">
                                        推: {{ article['like']| default('0') }}
                                    </small>
                                </p>
                            </div>
                        </div>
                        {% endfor %}
                    </div>
                </div>
            </div>
            <div class="col-xs-12">
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
<!--<script src="/bower_components/Readmore.js/readmore.min.js"></script>-->
<script>
    "use strict";
    $(function () {
//        var board = '{{board}}',
//            article = '{{article}}';

//        $('.wulo-comment').html( function () {
//            var text = $(this).html();
//            return text.replace(/^:/, '');
//        });
//        $('.read-more').readmore({
//            collapsedHeight: 20,
//            moreLink: '<btn class="btn btn-info-outline detail-read-more-btn text-xs-center">觀看全部</btn>',
//            lessLink: '<btn class="btn btn-info-outline detail-read-more-btn text-xs-center">收合內容</btn>'
//        });
//        $('span[data-open-url]').click(function () {
//            var link = $(this).data('open-url');
//            open(link);
//            return false;
//        });
    })
</script>
{% endblock %}