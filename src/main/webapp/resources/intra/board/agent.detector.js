var UserAgent = navigator.userAgent;

if(UserAgent.match(/iPhone/i) != null)
    UserAgent = "iPhone";
else if(UserAgent.match(/iPod/i) != null)
    UserAgent = "iPod";
else if(UserAgent.match(/Android/i) != null)
    UserAgent = "Android";
else if(UserAgent.match(/Windows CE/i) != null)
    UserAgent = "Windows CE";
else if(UserAgent.match(/BlackBerry/i) != null)
    UserAgent = "BlackBerry";
else if(UserAgent.match(/Symbian/i) != null)
    UserAgent = "Symbian";
else if(UserAgent.match(/Windows Phone/i) != null)
    UserAgent = "Windows Phone";
else if(UserAgent.match(/webOS/i) != null)
    UserAgent = "webOS";
else if(UserAgent.match(/Opera Mini/i) != null)
    UserAgent = "Opera Mini";
else if(UserAgent.match(/Opera Mobi/i) != null)
    UserAgent = "Opera Mobile";
else if(UserAgent.match(/POLARIS/i) != null)
    UserAgent = "POLARIS";
else if(UserAgent.match(/IEMobile/i) != null)
    UserAgent = "IEMobile";
else if(UserAgent.match(/lgtelecom/i) != null)
    UserAgent = "lgtelecom";
else if(UserAgent.match(/nokia/i) != null)
    UserAgent = "nokia";
else if(UserAgent.match(/SonyEricsson/i) != null)
    UserAgent = "SonyEricsson";
else if(UserAgent.match(/MSIE/i) != null)
    UserAgent = "MSIE";
else if(UserAgent.match(/Firefox/i) != null)
    UserAgent = "Firefox";
else if(UserAgent.match(/Crome/i) != null)
    UserAgent = "Crome";
else 
    UserAgent = "기타";