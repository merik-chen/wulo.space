{% extends "templates.volt" %}

{% block title %}{{ board }}，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<link rel="stylesheet" href="/scss/list.css">
<style>
    #ad_root {
        display: none;
        font-size: 14px;
        height: 250px;
        line-height: 16px;
        position: relative;
        width: 300px;
    }

    .thirdPartyMediaClass {
        height: 157px;
        width: 300px;
    }

    .thirdPartyTitleClass {
        font-weight: 600;
        font-size: 16px;
        margin: 8px 0 4px 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .thirdPartyBodyClass {
        display: -webkit-box;
        height: 32px;
        -webkit-line-clamp: 2;
        overflow: hidden;
    }

    .thirdPartyCallToActionClass {
        color: #326891;
        font-family: sans-serif;
        font-weight: 600;
        margin-top: 8px;
    }
</style>
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div class="row">
    <div class="col-xs-12 col-md-8 col-md-push-2">
        {% include "layouts/navbar.volt" %}
        <div class="row list-warp">
            <div class="col-xs-12">
                <h1 class="text-xs-center text-lg-left">
                    [{{ board }}]
                </h1>

                <div class="lists-breadcrumb text-xs-center text-lg-left" itemscope itemtype="https://schema.org/BreadcrumbList">
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
                </div>

                {#<ul class="list-article">
                    {% for article in data['list'] %}
                    <li>
                        <a href="/bbs/{{ article['board'] }}/{{ article['article'] }}.html">
                            <span>{{ article['title'] }}</span><span>...[ {{ article['like'] | default('0') }} ]</span
                        </a>
                    </li>
                    {% endfor %}
                </ul>#}

                <div class="list-article">
                    <div class="card-columns">
                        {% for article in data['list'] %}
                        <div class="card">
                            <img class="card-img-top hidden-md-down" src="https://placeholdit.imgix.net/~text?txtsize=33&txt=260%C3%97150&w=260&h=150"
                                 data-src="/screenshot/{{ article['board'] }}/{{ article['article'] }}.png" alt="{{ article['title'] }}">
                            <div class="card-block">
                                <h4 class="card-title">
                                    <a href="/bbs/{{ article['board'] }}/{{ article['article'] }}.html">
                                        {{ article['title'] }}
                                    </a>
                                </h4>
                                <p class="card-text">{{ article['abstract'] }}</p>
                                <p class="card-text">
                                    <small class="text-muted">
                                        推: {{ article['like']| default('0') }}  噓: {{ article['dislike']| default('0') }}
                                    </small>
                                </p>
                            </div>
                        </div>
                        {% endfor %}

                        {#
                        <div class="card">
                            <div class="fb-ad" data-placementid="1551853838477846_1562308260765737" data-format="native" data-nativeadid="ad_root" data-testmode="false"></div>
                            <div id="ad_root">
                                <a class="fbAdLink">
                                    <div class="card-block">
                                        <h4 class="card-title">
                                            <span class="fbAdTitle thirdPartyTitleClass"></span>
                                        </h4>
                                        <dvi class="fbAdMedia thirdPartyMediaClass"></dvi>
                                        <dvi class="fbAdBody thirdPartyBodyClass"></dvi>
                                        <dvi class="fbAdCallToAction thirdPartyCallToActionClass"></dvi>
                                        <p class="card-text">
                                            <small class="text-muted">
                                                推: {{ article['like']| default('0') }}  噓: {{ article['dislike']| default('0') }}
                                            </small>
                                        </p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        #}
                    </div>
                </div>

                <div class="list-board-list-warp">
                    <ul class="list-inline">
                        <li class="list-inline-item">熱門看板：</li>
                        {% for board in boards %}
                        <li class="list-inline-item{{ loop.index > 3 ? ' hidden-sm-down' : '' }}{{ loop.index > 10 ? ' hidden-xs-up' : '' }}">
                            <a href="/bbs/{{ board }}/index.html" title="{{board}}版-5樓，你怎麼說？">{{ board }}</a>
                        </li>
                        {% endfor %}
                    </ul>

                </div>

                <div class="list-ad-h-01">
                    <!-- wulo-detail-水平-1 -->
                    <ins class="adsbygoogle"
                         style="display:inline-block;width:100%;min-height:60px;height:90px;max-height:100px"
                         data-ad-client="ca-pub-3001056417467618"
                         data-ad-slot="4519532201"></ins>
                    <script>
                        (adsbygoogle = window.adsbygoogle || []).push({});
                    </script>
                </div>

                <div class="text-xs-center">
                    {% set total = data['total'] %}
                    <ul class="pagination">
                        <li class="page-item{{ page > 1 ? '' : ' disabled' }}">
                            <a class="page-link" href="index{{ page > 1 ? page - 1 : '1' }}.html" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        {% for prev in 2..1 %}
                        {% if (page - prev) >= 1 %}
                        <li class="page-item"><a class="page-link" href="index{{ page - prev }}.html">{{ page - prev }}</a></li>
                        {% endif %}
                        {% endfor %}
                        <li class="page-item active">
                            <a class="page-link" href="#">{{ page }} <span class="sr-only">(current)</span></a>
                        </li>
                        {% for next in 1..2 %}
                        {% if (page + next) <= total %}
                        <li class="page-item"><a class="page-link" href="index{{ page + next }}.html">{{ page + next }}</a></li>
                        {% endif %}
                        {% endfor %}
                        <li class="page-item">
                            <a class="page-link" href="index{{ page + 1 }}.html" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                                <span class="sr-only">Next</span>
                            </a>
                        </li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>
{% endblock %}

{% block extJs %}
<script>
    "use strict";

    //{#
    window.fbInited = function () {
        FB.Event.subscribe(
            'ad.loaded',
            function(placementId) {
                console.log('Audience Network ad loaded');
                document.getElementById('ad_root').style.display = 'block';
            }
        );
        FB.Event.subscribe(
            'ad.error',
            function(errorCode, errorMessage, placementId) {
                console.log('Audience Network error (' + errorCode + ') ' + errorMessage);
            }
        );
    };


    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk/xfbml.ad.js#xfbml=1&version=v2.5&appId=1551853838477846";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
    //#}


    $(function () {
        var board = '{{board}}',
            page = '{{page}}';

    })
</script>
{% endblock %}