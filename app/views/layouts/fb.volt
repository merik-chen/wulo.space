<script>
    window.fbInited = window.fbInited || function () {};
    window.fbAsyncInit = function() {
        FB.init({
            appId      : '1551853838477846',
            xfbml      : true,
            version    : 'v2.5'
        });
        window.fbInited()
    };

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
</script>