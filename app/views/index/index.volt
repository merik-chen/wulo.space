{% extends "templates.volt" %}


{% block extCss %}
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div class="row">
    <div class="col-xs-12 text-xs-center">
        <div class="row slogan-margin-top">
            <h1 class="index-h1">五樓，你怎麼說？</h1>
            <h2 class="index-h2">每個文章的心中，都有一個五樓。</h2>
        </div>
        <div class="row">
            <div class="col-xs-12 col-lg-8 col-lg-push-2">
                <input class="form-control index-target" id="target" type="url">
            </div>
            <div class="col-xs-12 text-xs-center">
                <button id="go" class="btn btn-info-outline index-target-btn"> 5樓？ </button>
            </div>
        </div>
        <div class="row text-xs-center">
            <div id="marquee">
                <ul>
                    {% for article in latest %}
                    <li>
                        {{ article['title'] }}
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
            height: 35,
            margin: 10
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