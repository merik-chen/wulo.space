<!doctype html>
<html ⚡ lang="zh-Hant">
<head>
    <meta charset="utf-8">
    <title>{{ post['title'] }}，五樓，你怎麼說？</title>
    <link rel="canonical" href="https://wulo.space/bbs/{{board}}/{{article}}.html"/>
    <meta property="description" content="{{ post['title'] }}，每個文章的心中，都有一個五樓。">
    <meta property="keywords" content="Ptt,5樓,五樓,big data">
    <meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
    <style amp-boilerplate>body{-webkit-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-moz-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-ms-animation:-amp-start 8s steps(1,end) 0s 1 normal both;animation:-amp-start 8s steps(1,end) 0s 1 normal both}@-webkit-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-moz-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-ms-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-o-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}</style><noscript><style amp-boilerplate>body{-webkit-animation:none;-moz-animation:none;-ms-animation:none;animation:none}</style></noscript>
    <script async src="https://cdn.ampproject.org/v0.js"></script>

    <style amp-custom>
        @font-face {
            font-family: 'cwTeXHei';
            font-style: normal;
            font-weight: 500;
            src: url(//fonts.gstatic.com/ea/cwtexhei/v3/cwTeXHei-zhonly.eot);
            src: url(//fonts.gstatic.com/ea/cwtexhei/v3/cwTeXHei-zhonly.eot?#iefix) format('embedded-opentype'),
                 url(//fonts.gstatic.com/ea/cwtexhei/v3/cwTeXHei-zhonly.woff2) format('woff2'),
                 url(//fonts.gstatic.com/ea/cwtexhei/v3/cwTeXHei-zhonly.woff) format('woff'),
                 url(//fonts.gstatic.com/ea/cwtexhei/v3/cwTeXHei-zhonly.ttf) format('truetype');
        }

        body {
            font-family: 'cwTeXFangSong', serif;
        }
    </style>
</head>
<body>
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
                    五樓說：<span itemprop="comment" class="wulo-comment">{{ post['wulo']['content'] }}</span> by {{ post['wulo']['user'] }}
                {% else %}
                    它的五樓，還未出現...（ＯＡＯ“）
                {% endif %}
                </span>
            </div>

            <div class="detail-title-info-spacer"></div>

            <div>
                <span itemprop="text">{{ post['body'] | trim | nl2br }}</span>
            </div>
        </div>
    </div>
</body>
</html>
