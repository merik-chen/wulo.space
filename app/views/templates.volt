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
        <link rel="stylesheet" href="/bower_components/tether/dist/css/tether.css">
        <link rel="stylesheet" href="/bower_components/bootstrap/dist/css/bootstrap.css">
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
        <div class="container-fluid">
            {% block body %}{% endblock %}
        </div>
        <script src="https://www.promisejs.org/polyfills/promise-7.0.4.min.js"></script>
        <script src="https://www.promisejs.org/polyfills/promise-done-7.0.4.min.js"></script>
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="/bower_components/tether/dist/js/tether.js"></script>
        <script src="/bower_components/bootstrap/dist/js/bootstrap.js"></script>
        <script src="/js/wulo.js"></script>
        <script>
            $(function () {
            })
        </script>
        {% block extJs %}{% endblock %}
        {% include "layouts/ga.volt" %}
        {% include "layouts/fb.volt" %}
    </body>
</html>
