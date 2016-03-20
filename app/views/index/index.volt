{% extends "templates.volt" %}


{% block extCss %}
<link rel="stylesheet" href="/css/spinners.css">
<link rel="stylesheet" href="/scss/index.css">
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div class="loader" style="display: none;">Loading...</div>
<div class="row">
    <div class="col-xs-12 text-xs-center">
        <div class="row slogan-margin-top">
            <h1 class="index-h1">五樓，你怎麼說？</h1>
            <h2 class="index-h2">每個文章的心中，都有一個五樓。</h2>
        </div>
        <div class="row">
            <div class="col-xs-12 col-lg-8 col-lg-push-2">
                <input class="form-control index-target" id="target" type="url" placeholder="貼上PTT網址，趕快知道5樓是誰！">
            </div>
            <div class="col-xs-12 text-xs-center">
                <button id="go" class="btn btn-info-outline index-target-btn"> 5樓？ </button>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 col-lg-8 col-lg-push-2 index-ad-1">
                <!-- Wulo -->
                <ins class="adsbygoogle"
                     style="display:block"
                     data-ad-client="ca-pub-3001056417467618"
                     data-ad-slot="3125354204"
                     data-ad-format="auto"></ins>
                <script>
                    (adsbygoogle = window.adsbygoogle || []).push({});
                </script>
            </div>
        </div>
        <div class="row text-xs-center index-marquee-1">
            <div id="marquee">
                <ul>
                    {% for article in latest %}
                    <li>
                        <a href="/bbs/{{ article['board'] }}/{{ article['article'] }}.html">{{ article['title'] }} - {{ article['board'] }}</a>
                    </li>
                    {% endfor %}
                </ul>
            </div>
        </div>
    </div>
</div>
{% endblock %}

{% block extJs %}
<script src="//assets.interview.tw/js/jquery.vticker.min.js"></script>
<script>
    $(function () {

        $("#marquee").show().delay(100).vTicker({
            height: 30,
            margin: 5
        });

        $("#go").click(function () {
            var link = $.trim($("#target").val()),
                params = wulo.utility.ptt_link_extract(link);

            wulo.utility.promisePost(
                '/api/get5F',
                {
                    'payload': params
                },
                'json'
            ).done(function (rsp) {
                switch (rsp.status) {
                    case true:
                        window.location.href = '/bbs/' + params.board + '/' + params.article + '.html';
                        break;
                    case false:
                        console.error('Get article failed!', rsp);
                        break;
                    case null:
                        wulo.utility.trackingArticle(
                            '/api/get5F',
                            {
                                'payload': params
                            },
                            'json',
                            function (rsp) {
                                console.log(rsp);
                                window.location.href = '/bbs/' + params.board + '/' + params.article + '.html';
                            }
                        );
                        break;
                    default:
                        console.error('Un-know state.', rsp);
                        break;
                }
            });
        });

    })
</script>
{% endblock %}