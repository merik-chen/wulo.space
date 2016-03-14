{% extends "templates.volt" %}


{% block extCss %}
{% endblock %}

{% block extModels %}
{% endblock %}

{% block body %}
<div>
    <p>Board: {{board}}</p>
    <p>Post: {{post}}</p>
    <p>
        <a href="https://www.ptt.cc/bbs/{{ board }}/{{ post }}.html">
            https://www.ptt.cc/bbs/{{ board }}/{{ post }}.html
        </a>
    </p>
    <pre>
        {{ post['body'] }}
    </pre>
    <p>
        <span>
            {{ post['wulo']['user'] }}[{{ post['wulo']['symbol'] }}]{{ post['wulo']['content'] }}
        </span>
    </p>
</div>
{% endblock %}

{% block extJs %}
<script>
    "use strict";
    $(function () {
        var board = '{{board}}',
            article = '{{post}}';
    })
</script>
{% endblock %}