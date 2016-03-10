<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>{% block title %}Title{% endblock %}</title>
        <script src="/bower_components/webcomponentsjs/webcomponents-lite.min.js"></script>
        <style>
            @import url(http://fonts.googleapis.com/earlyaccess/cwtexhei.css);
            body {
                font-family: 'cwTeXFangSong', serif !important;
            }
        </style>
        {% block extCss %}{% endblock %}
        {% block extModels %}{% endblock %}
    </head>
    <body>
        {% block body %}{% endblock %}
        {% block extJs %}{% endblock %}
    </body>
</html>
