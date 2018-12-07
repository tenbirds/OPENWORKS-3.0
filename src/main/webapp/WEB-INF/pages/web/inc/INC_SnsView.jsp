<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%
	String fullUrl = request.getRequestURL().toString();
	String query   = request.getQueryString();
	if (query != null && !query.equals("")) {
		fullUrl += "?" + query;
	}
	fullUrl = fullUrl.replaceAll("/WEB-INF/pages", "");
	fullUrl = fullUrl.replaceAll(".jsp", ".do");
	String loginId = Config.getString("shortKey.bit.id");
	String apiKey  = Config.getString("shortKey.bit.apiKey");
%>

<script type="text/javascript">
    //<![CDATA[
	var shortUrl;
	var snsType;
	var fullUrl = '<%= fullUrl %>';
	var snsTitle;
	
	//임시단축URL
	function fn_sendSns(snsName,goodsNm) {
		// SNS 타입 설정
	    snsType = snsName;
	    snsTitle = "[클라우드스토어 씨앗] " + goodsNm;
	
	   if (snsType == "naver"){
	        href = "http://blog.naver.com/openapi/share?url=" + fullUrl + "&title=" + encodeURI(snsTitle);
	        pop =  window.open(href, snsType, "width=630,height=250,scrollbars=yes,resizable=yes,toolbar=no");
	        if(pop)    pop.focus();
	   }else{
	        // 단축 URL 생성
	        fn_makeShortUrl();
	   }
	
	}
	
	function fn_makeShortUrl () {
	    $.ajax({
	      	url:"http://api.bit.ly/v3/shorten",
	      	data:{
	         	longUrl : '<%= fullUrl %>',
	         	apiKey  : '<%= apiKey  %>',
	         	login   : '<%= loginId %>'
	      	}
	      	,dataType:"jsonp"
	      	,async: false
	      	,success:function(v){
	          	shortUrl = v.data.url;
	          	fn_SnsCall();
	      	}
	      	,error : function(hxr, status, error) {
	          	alert(error);
	      	}
	  	});
	}

	function fn_SnsCall() {

	    var href = "";
	    var snsSummary = "";
	    var snsSummaryV = $(".snsSummary").val();	//보드형
	    var snsSummaryH = $(".snsSummary").html();	//컨텐츠형

	    if (snsSummaryV == null || snsSummaryV == ""){
	        snsSummary = snsSummaryH;
	    }else{
			snsSummary = snsSummaryV;
	    }
	    if(snsSummary == null || snsSummary == ""){
	        snsSummary = "CEART MARKET";
	    }

	    fullUrl = encodeURIComponent(fullUrl);
		snsSummary = encodeURIComponent(snsSummary);
		
	    switch (snsType) {
	    
	    case 'twitter':
	        href =  "http://twitter.com/home?status="+snsSummary+" "+shortUrl;
	        break;
	        
	    case 'facebook':
	        href = "http://www.facebook.com/share.php?u="+shortUrl+"&t="+snsSummary;
	        break;
        case 'naver':
            href = "http://blog.naver.com/openapi/share?url="+shortUrl+"&title="+snsSummary;
            break;
	    }
	    
		pop =  window.open(href, snsType, "width=630,height=250,scrollbars=yes,resizable=yes,toolbar=no");
		
		if(pop)	pop.focus();  
		
	}
	//]]>
</script>