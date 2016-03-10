<!DOCTYPE html>
<html>
<head>
    <!-- 1. Load webcomponents-lite.min.js for polyfill support. -->
    <script src="/bower_components/webcomponentsjs/webcomponents-lite.min.js">
    </script>

    <!-- 2. Use an HTML Import to bring in some elements. -->
    <link rel="import" href="/bower_components/paper-button/paper-button.html">
    <link rel="import" href="/bower_components/paper-input/paper-input.html">
</head>
<body>
<!-- 3. Declare the element. Configure using its attributes. -->
<paper-input label="Your name here"></paper-input>
<paper-button>Say Hello</paper-button>
<div id="greeting"></div>

<script>
    // To ensure that elements are ready on polyfilled browsers,
    // wait for WebComponentsReady.
    document.addEventListener('WebComponentsReady', function() {
        var input = document.querySelector('paper-input');
        var button = document.querySelector('paper-button');
        var greeting = document.getElementById("greeting");
        button.addEventListener('click', function() {
            greeting.textContent = 'Hello, ' + input.value;
        });
    });
</script>
</body>
</html>
