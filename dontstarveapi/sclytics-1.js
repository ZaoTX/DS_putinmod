(function(){ 
  var $target = document.body, html, tag=document.createElement('script'), code='';
  var ver = window.sweetcatpchaPluginVersion || null;
  code+= "(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){";
  code+= "(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),";
  code+= "m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)";
  code+= "})(window,document,'script','analytics.js'/*tpa=http://www.google-analytics.com/analytics.js*/,'sweetcaptchalyticsObj');";
  code+= "sweetcaptchalyticsObj('create', 'UA-45313765-5', {'name': 'sweetcaptchalytics'});";
  code+= "sweetcaptchalyticsObj('http://www.sweetcaptcha.com/javascripts/sweetcaptchalytics.send', 'pageview');";
  code+= "sweetcaptchalyticsObj('http://www.sweetcaptcha.com/javascripts/sweetcaptchalytics.send', {";
  code+= "'hitType': 'event',";
  code+= "'eventCategory': window.location.hostname,";
  code+= "'eventAction': 'load',";
  code+= "'eventLabel': "+ver;
  code+= "});";
  tag.setAttribute('type', 'text/javascript');
  tag.setAttribute('async', '');
  tag.appendChild(document.createTextNode(code));
  $target.appendChild(tag);
})();