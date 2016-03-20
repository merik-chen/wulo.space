{% extends "templates.volt" %}

{% block title %}{{ board }}，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<link rel="stylesheet" href="/scss/list.css">
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

                <ul class="list-article">
                    {% for article in data['list'] %}
                    <li>
                        <a href="/bbs/{{ article['board'] }}/{{ article['article'] }}.html">
                            <span>{{ article['title'] }}</span>
                        </a>
                    </li>
                    {% if loop.index % 5 == 0 %}
                    <!-- wulo-detail-水平-1 -->
                    <ins class="adsbygoogle"
                         style="display:inline-block;width:100%;min-height:60px;height:100%;max-height:100px"
                         data-ad-client="ca-pub-3001056417467618"
                         data-ad-slot="4519532201"></ins>
                    <script>
                        (adsbygoogle = window.adsbygoogle || []).push({});
                    </script>
                    {% endif %}
                    {% endfor %}
                </ul>

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
    $(function () {
        var board = '{{board}}',
            page = '{{page}}';

    })
</script>
{% endblock %}