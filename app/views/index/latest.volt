{% extends "templates.volt" %}

{% block title %}最新收錄，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<link rel="stylesheet" href="/scss/list.css">
<style>
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
                            <a href="/bbs/latest" title="最新收錄 - 五樓，你怎麼說？" itemprop="item">
                                <span itemprop="name">最新收錄</span>
                            </a>
                        </span>
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

                <div class="list-article">
                    <div class="card-columns">
                        {% for article in posts %}
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
                    </div>
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

    })
</script>
{% endblock %}