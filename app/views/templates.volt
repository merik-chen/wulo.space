<!DOCTYPE html>
<html itemscope itemtype="http://schema.org/WebPage">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta property="og:url" content="https://wulo.space">
        <meta property="og:image" content="">
        <meta property="og:title" content="五樓，你怎麼說？">
        <meta property="og:description" content="每個文章的心中，都有一個五樓。">
        <meta property="fb:app_id" content="1551853838477846">
        <title>{% block title %}{% endblock %}五樓，你怎麼說？ - 每個文章的心中，都有一個五樓。</title>
        <meta property="description" content="每個文章的心中，都有一個五樓。">
        <meta property="keywords" content="Ptt,5樓,五樓,big data">
        <link rel="stylesheet" href="/bower_components/tether/dist/css/tether.css">
        <link rel="stylesheet" href="/bower_components/bootstrap/dist/css/bootstrap.css">
        <link rel="stylesheet" href="/css/spinner.css">
        <style>
            @import url('//fonts.googleapis.com/earlyaccess/cwtexhei.css');
            body {
                font-family: 'cwTeXFangSong', serif !important;
            }
        </style>
        {% block extCss %}{% endblock %}
        {% block extModels %}{% endblock %}
        <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
    </head>
    <body>
        <div id="loading" style="background: white; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index:99;">
            <div class="bounce-spinner">
                <div class="double-bounce1"></div>
                <div class="double-bounce2"></div>
            </div>
            <div class="col-xs-12 text-xs-center m-t-1" style="top: 50%;">載入中...五樓，你怎麼說？</div>
        </div>
        <div class="container-fluid">
            {% block body %}{% endblock %}
        </div>
        <script src="https://www.promisejs.org/polyfills/promise-7.0.4.min.js"></script>
        <script src="https://www.promisejs.org/polyfills/promise-done-7.0.4.min.js"></script>
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="/bower_components/tether/dist/js/tether.min.js"></script>
        <script src="/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="/js/wulo.js"></script>
        <script>
            $(function () {
                $("#loading").fadeOut();
                amplitude.logEvent('PV');
            })
        </script>
        {% block extJs %}{% endblock %}
        {% include "layouts/ga.volt" %}
        {# include "layouts/fb.volt" #}
        <script type="text/javascript">
            (function(e,t){var n=e.amplitude||{};var r=t.createElement("script");r.type="text/javascript";
                r.async=true;r.src="https://d24n15hnbwhuhn.cloudfront.net/libs/amplitude-2.9.0-min.gz.js";
                r.onload=function(){e.amplitude.runQueuedFunctions()};var s=t.getElementsByTagName("script")[0];
                s.parentNode.insertBefore(r,s);var i=function(){this._q=[];return this};function a(e){
                    i.prototype[e]=function(){this._q.push([e].concat(Array.prototype.slice.call(arguments,0)));
                        return this}}var o=["add","append","clearAll","set","setOnce","unset"];for(var c=0;c<o.length;c++){
                    a(o[c])}n.Identify=i;n._q=[];function u(e){n[e]=function(){n._q.push([e].concat(Array.prototype.slice.call(arguments,0)));
                }}var l=["init","logEvent","logRevenue","setUserId","setUserProperties","setOptOut","setVersionName","setDomain","setDeviceId","setGlobalUserProperties","identify","clearUserProperties"];
                for(var p=0;p<l.length;p++){u(l[p])}e.amplitude=n})(window,document);

            amplitude.init("6b58d90263e8baa8480b74a05095e283");
        </script>
    </body>
</html>
