<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{% block title %}五樓，你怎麼說？ - 每個文章的心中，都有一個五樓。{% endblock %}</title>
        <script src="/bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
        <style>
            @import url('//fonts.googleapis.com/earlyaccess/cwtexhei.css');
            body {
                font-family: 'cwTeXFangSong', serif !important;
            }
        </style>
        {% block extCss %}{% endblock %}
        {% block extModels %}{% endblock %}
    </head>
    <body>
        {% block body %}{% endblock %}
        <script src="https://www.promisejs.org/polyfills/promise-7.0.4.min.js"></script>
        <script src="https://www.promisejs.org/polyfills/promise-done-7.0.4.min.js"></script>
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script src="/js/wulo.js"></script>
        <script>
            $(function () {
                var link = 'https://www.ptt.cc/bbs/LGBT_SEX/M.1456717141.A.C4D.html';

                console.log( wulo.utility.ptt_link_extract(link) );
            })
        </script>
        {% block extJs %}{% endblock %}
    </body>
</html>
