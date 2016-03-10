<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{% block title %}Title{% endblock %}</title>
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
        <script src="//code.jquery.com/jquery-1.12.0.min.js"></script>
        <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script>
            $(function () {
                var link = 'https://www.ptt.cc/bbs/LGBT_SEX/M.1456717141.A.C4D.html',
                    url_extracter = /ptt.+\/bbs\/(\w+)\/([\w\.]+)\.html?/;

                if ((window.m = url_extracter.exec(link)) !== null) {
                    if (window.m.index === url_extracter.lastIndex) {
                        url_extracter.lastIndex++;
                    }
                    // View your result using the m-variable.
                    // eg m[0] etc.
                }
            })
        </script>
        {% block extJs %}{% endblock %}
    </body>
</html>
