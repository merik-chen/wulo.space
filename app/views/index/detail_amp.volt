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

        /*
         * Gridism
         * A simple, responsive, and handy CSS grid by @cobyism
         * https://github.com/cobyism/gridism
         */

        /* Preserve some sanity */
        .grid,
        .unit {
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        /* Set up some rules to govern the grid */
        .grid {
            display: block;
            clear: both;
        }
        .grid .unit {
            float: left;
            width: 100%;
            padding: 10px;
        }

        /* This ensures the outer gutters are equal to the (doubled) inner gutters. */
        .grid .unit:first-child { padding-left: 20px; }
        .grid .unit:last-child { padding-right: 20px; }

        /* Nested grids already have padding though, so let’s nuke it */
        .unit .unit:first-child { padding-left: 0; }
        .unit .unit:last-child { padding-right: 0; }
        .unit .grid:first-child > .unit { padding-top: 0; }
        .unit .grid:last-child > .unit { padding-bottom: 0; }

        /* Let people nuke the gutters/padding completely in a couple of ways */
        .no-gutters .unit,
        .unit.no-gutters {
            padding: 0;
        }

        /* Wrapping at a maximum width is optional */
        .wrap .grid,
        .grid.wrap {
            max-width: 978px;
            margin: 0 auto;
        }

        /* Width classes also have shorthand versions numbered as fractions
         * For example: for a grid unit 1/3 (one third) of the parent width,
         * simply apply class="w-1-3" to the element. */
        .grid .whole,          .grid .w-1-1 { width: 100%; }
        .grid .half,           .grid .w-1-2 { width: 50%; }
        .grid .one-third,      .grid .w-1-3 { width: 33.3332%; }
        .grid .two-thirds,     .grid .w-2-3 { width: 66.6665%; }
        .grid .one-quarter,
        .grid .one-fourth,     .grid .w-1-4 { width: 25%; }
        .grid .three-quarters,
        .grid .three-fourths,  .grid .w-3-4 { width: 75%; }
        .grid .one-fifth,      .grid .w-1-5 { width: 20%; }
        .grid .two-fifths,     .grid .w-2-5 { width: 40%; }
        .grid .three-fifths,   .grid .w-3-5 { width: 60%; }
        .grid .four-fifths,    .grid .w-4-5 { width: 80%; }
        .grid .golden-small,   .grid .w-g-s { width: 38.2716%; } /* Golden section: smaller piece */
        .grid .golden-large,   .grid .w-g-l { width: 61.7283%; } /* Golden section: larger piece */

        /* Clearfix after every .grid */
        /*.grid {*/
            /**zoom: 1;*/
        /*}*/

        .grid:before, .grid:after {
            display: table;
            content: "";
            line-height: 0;
        }
        .grid:after {
            clear: both;
        }

        /* Utility classes */
        .align-center { text-align: center; }
        .align-left   { text-align: left; }
        .align-right  { text-align: right; }
        .pull-left    { float: left; }
        .pull-right   { float: right; }

        /* A property for a better rendering of images in units: in
           this way bigger pictures are just resized if the unit
           becomes smaller */
        .unit img {
            max-width: 100%;
        }

        /* Hide elements using this class by default */
        .only-on-mobiles {
            display: none;
        }

        /* Responsive Stuff */
        @media screen and (max-width: 568px) {
            /* Stack anything that isn’t full-width on smaller screens
               and doesn't provide the no-stacking-on-mobiles class */
            .grid:not(.no-stacking-on-mobiles) > .unit {
                width: 100%;
                padding-left: 20px;
                padding-right: 20px;
            }
            .unit .grid .unit {
                padding-left: 0;
                padding-right: 0;
            }

            /* Sometimes, you just want to be different on small screens */
            .center-on-mobiles {
                text-align: center;
            }
            .hide-on-mobiles {
                display: none;
            }
            .only-on-mobiles {
                display: block;
            }
        }

        /* Expand the wrap a bit further on larger screens */
        @media screen and (min-width: 1180px) {
            .wider .grid,
            .grid.wider {
                max-width: 1180px;
                margin: 0 auto;
            }
        }

        body {
            font-family: 'cwTeXFangSong', serif;
        }

        .hide-all {
            display: none;
        }

        .h2-title a,
        .h2-title a:hover,
        .h2-title a:visited {
            text-decoration: none;
            color: black;
        }

        .navbar-breadcrumb-items::after {
            content: " / ";
            color: lightgray;
        }

        .navbar-breadcrumb-items:last-child::after {
            content: "";
        }

        .navbar-breadcrumb-items a,
        .navbar-breadcrumb-items a:hover,
        .navbar-breadcrumb-items a:visited
        {
            text-decoration: none;
            color: lightgray;
        }

        .navbar-breadcrumb-items a:hover {
            color: #29b6f6;
        }

        amp-img {
            background-color: grey;
            width: 100%;
            height: 30vh;
            overflow: hidden;
        }

        @media screen and (max-width: 568px) {
            amp-img {
                height: 15vh;
            }
        }

    </style>
</head>
<body>
    <div class="wider">
        <div class="grid">
            <div class="unit">
                <h2 class="align-center h2-title">
                    <a href="/" title="五樓，你怎麼說？">五樓，你怎麼說？</a>
                </h2>

                <div class="align-center" itemscope itemtype="https://schema.org/BreadcrumbList">
                    <span class="navbar-breadcrumb-items" itemprop="itemListElement" itemscope
                          itemtype="https://schema.org/ListItem">
                        <a href="/" title="五樓，你怎麼說？" itemprop="item">
                            <span class="hide-all" itemprop="name">五樓，你怎麼說？</span>
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

            </div>
            <div class="unit">
                <div class="whole" itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemPage">

                    <amp-img class="" width=1280 height=60 layout="responsive" src="https://unsplash.it/1280/120?random" /></amp-img>

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
            <div class="unit align-right">
                <hr>
                <h6>WULO.SPACE 2016, Made with Data.</h6>
            </div>
        </div>
    </div>
</body>
</html>
