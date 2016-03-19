{% extends "templates.volt" %}

{% block title %}{{ board }}，{% endblock %}

{% block extCss %}
<link rel="stylesheet" href="/scss/navbar.css">
<!--<link rel="stylesheet" href="/scss/detail.css">-->
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div class="row">
    <div class="col-xs-12 col-md-8 col-md-push-2">
        {% include "layouts/navbar.volt" %}
        <div class="row list-warp">
            <div class="col-xs-12">
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
                </div>

                {{ page }} / {{ data['total'] }}

                <ul>
                    {% for article in data['list'] %}
                    <li>
                        <a href="/bbs/{{ article['board'] }}/{{ article['article'] }}.html">
                            <span>{{ article['title'] }}</span>
                        </a>
                    </li>
                    {% endfor %}
                </ul>

                <div>
                    <ul class="pagination">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                                <span class="sr-only">Previous</span>
                            </a>
                        </li>
                        <li class="page-item active">
                            <a class="page-link" href="#">{{ page }} <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">4</a></li>
                        <li class="page-item"><a class="page-link" href="#">5</a></li>
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