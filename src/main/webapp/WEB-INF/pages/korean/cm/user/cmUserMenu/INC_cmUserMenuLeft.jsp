<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	
	//{{ BH, 2015.11.10, 도메인관리삭제로 인한 소스변경 
	// 변경소스
	request.setAttribute("SubDomain","korean");
	//}} 
	
	String nowURL = request.getRequestURI().toString();
	
%>
<script type="text/javascript">
	 
	var cmmntySttusCd = '<c:out value="${cmInfoView.cmmntySttusCd}" />';  //1001:신청  1002:승인   1003:승인보류  1004: 커뮤니티 폐쇄 1005 폐쇄중 
	
	if(cmmntySttusCd == 1001 ){
	    alert(Message.msg.chkCm1001); 
	  // 이전소스  
	  //location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/index.do";
	  
	  //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	  // 변경소스
	  location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/pt/index.do";
	  //}} 
	}
	else if(cmmntySttusCd == 1004 ){
	    alert(Message.msg.chkCm1004);
	  // 이전소스
      //location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/index.do";
    
	  //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	  // 변경소스
	  location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/pt/index.do";
	  //}}
	    
	}else if(cmmntySttusCd == "" ){
	    alert(Message.msg.chkCmNull); 
	  // 이전소스
	  //location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/pt/index.do";
		
	  //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	  // 변경소스
	  location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/pt/index.do";
	  //}}
	
	}
	
	
</script>
<!-- 페이지뷰로그 수집영역 -->
<script type="text/javascript">
    var anlzSessionId = '<%=session.getId()%>';
    var anlzClientIp = '<%=request.getRemoteAddr()%>';
    var anlzSearchEngine = new Array();
    var anlzMobileOS = new Array();
    var anlzCmmntyId = "<c:out value='${cmmntyId}'/>";

    <%
    String[] domains = Config.getStringArray("analyze.search-engines.domain");
    for (String domain : domains) {
        out.println("anlzSearchEngine.push('"+domain+"');");
    }
    String[] mobiles = Config.getStringArray("analyze.platforms.mobile");
    for (String mobile : mobiles) {
        out.println("anlzMobileOS.push('"+mobile+"');");
    }
    %>
</script>    
	<style type="text/css">
	#containerLogoMenu {position:relative; width:999px; height:170px; margin:0 auto; overflow:hidden}
	#containerLogoMenu img {position:absolute; top:0; left:0} 
	#containerLogoMenu .resultMenu > * {position:absolute;}
	 #containerLogoMenu .resultMenu .inertxtMenu {line-height:normal; }
	</style>
	<script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>
	<script type="text/javascript" src="<c:url value="/resources/cmmnty/analyze/tracking/tracker.js"/>"></script>
	<script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script>
	<script type="text/javascript">
	  $(document).ready(function() {
	        var visitIp = "<%=request.getRemoteAddr()%>";
	        var subdomain = "<c:out value='${SubDomain}'/>";
	        // 이전소스
	        //var logUrl = "http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/ND_cmUserVisitLog.do";
	        
	        //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			var logUrl = "http://<%=GlobalConfig.DOMAIN_SUBNM %>/cm/user/cmUserMenu/ND_cmUserVisitLog.do";
			//}}
	      	//접속자 로그      	
	      	$.ajax({
	            url     : logUrl,
	            type    : "POST",
	            data    : {cmmntyId : "<c:out value='${cmmntyId}'/>", visitIp : visitIp},
	      	 	timeout : 2000
	        });
		     cmOpenInfoMenu = {
		              	logoTitleMenu : "<c:out value="${cmInfoView.logoTitle}" default="Open Market Place" />",
					    logoTitleWidthLcMenu  : <c:out value="${cmInfoView.logoTitleWidthLc}" default="0" />,	        
					    logoTitleVrticlLcMenu  : <c:out value="${cmInfoView.logoTitleVrticlLc}" default="0" />,	        
					    logoTitleFontMenu  : "<c:out value="${cmInfoView.logoTitleFont}" />",	        
					    logoTitleFontSizeMenu : "<c:out value="${cmInfoView.logoTitleFontSize}" default="34" />",	        
					    logoTitleColorMenu : "<c:out value="${cmInfoView.logoTitleColor}" />"	        
			};
	   		// text 로고의 초기 위치 설정
	    	var leftMenu = cmOpenInfoMenu.logoTitleWidthLcMenu;
	    	var topMenu  = cmOpenInfoMenu.logoTitleVrticlLcMenu;
	    	
	    	$("#textLogoMenu").css({ "top": parseInt(topMenu, 10), "left": parseInt(leftMenu, 10) });
	    	
		    var html = '<P id="preLogoMenu" style="font-family:\'' + cmOpenInfoMenu.logoTitleFontMenu + '\'; font-size:' + cmOpenInfoMenu.logoTitleFontSizeMenu + 'px; font-style:italic; color:#' + cmOpenInfoMenu.logoTitleColorMenu + '">' + cmOpenInfoMenu.logoTitleMenu + '</p>';
		    $( "#textLogoMenu" ).html(html);
		    
		    $("#browserType").val(getBrowserType());
		    
		    //$("#footerCmNm").html("<c:out value='${cmInfoView.cmmntyNm}'/>");
	  });
	  
	 	// 브라우저 체크 
	    var getBrowserType = function(){
	     	  var agt = navigator.userAgent.toLowerCase();
	     	  if (agt.indexOf("chrome") != -1) return 'Chrome'; 
	     	  if (agt.indexOf("opera") != -1) return 'Opera'; 
	     	  if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
	     	  if (agt.indexOf("webtv") != -1) return 'WebTV'; 
	     	  if (agt.indexOf("beonex") != -1) return 'Beonex'; 
	     	  if (agt.indexOf("chimera") != -1) return 'Chimera'; 
	     	  if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
	     	  if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
	     	  if (agt.indexOf("firefox") != -1) return 'Firefox'; 
	     	  if (agt.indexOf("safari") != -1) return 'Safari'; 
	     	  if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
	     	  if (agt.indexOf("msie") != -1) return 'Internet Explorer';
	     	  if (agt.indexOf("rv:11.0") != -1) return 'Internet Explorer';
	     	  if (agt.indexOf("netscape") != -1) return 'Netscape'; 
	     	  if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla'; 
	    };
	    
	  var jrMoveMenu = function(cmmntyMenuUrl, cmmntyId, cmmntyMenuCode, langCode, cmmntyBbsTyCd, cmmntyMenuFolderNm ){

	      var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	      	// if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean"+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode+"&langCode="+langCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd;
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode+"&langCode="+langCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd;
	     	//} 
	      	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean"+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode+"&langCode="+langCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd;
			//}}
	     	
	     	
	     	
	  		//$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
	  		//$("#dataForm").attr("action",movepage).submit();
	     	location.href = movepage;
	  };
	  
 	  var jrMoveMenu1 = function(subdomain){
 	     var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	      	//if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value='${cmmntyId}'/>";
			//}}
	     
// 	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
// 	  		$("#dataForm").attr("action",movepage).submit();
	     	location.href = movepage;
	  };
	  var jrMoveMenu2 = function(subdomain){
	      var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	      	//if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserInfo/BD_index.do?cmmntyMenuCode=1&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserInfo/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserInfo/BD_index.do?cmmntyMenuCode=1&cmmntyId=<c:out value='${cmmntyId}'/>";
			//}}
	     
// 	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
// 	  		$("#dataForm").attr("action",movepage).submit();
	     	location.href = movepage;
	  };
	  
	  var jsAdminMove = function(){
	      var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	        //if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/admin/cmOptMain/BD_index.do?cmmntyMenuCode=1&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/admin/cmOptMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}
	     	
	        //{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/admin/cmOptMain/BD_index.do?cmmntyMenuCode=1&cmmntyId=<c:out value='${cmmntyId}'/>";
			//}}
	        
// 	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
// 	  		$("#dataForm").attr("action",movepage).submit();
	     	location.href = movepage;
	  };
	   
	  var  jsWriteReplyList = function(moveChk){
	      var subdomain = "<c:out value='${SubDomain}'/>";
	      //alert(moveChk);
	      if(moveChk == "write"){
		     // 이전소스
	         //if(subdomain == "korean"){
		     //	   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/BD_cmUserWriteList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=write";
		     //	}else{
		     //	   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/cmBD_cmUserWriteList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=write";
		     
		     //{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			 // 변경소스
			 movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/BD_cmUserWriteList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=write";
			 //}}
	      }else if(moveChk == "reply"){
	         //if(subdomain == "korean"){
		     //	   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/BD_cmUserReplyList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=reply";
		     //	}else{
		     //	   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/BD_cmUserReplyList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=reply";
		     
		    //{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/BD_cmUserReplyList.do?cmmntyId=<c:out value='${cmmntyId}'/>&writeReplyChk=reply";
			//}}
	      }
	      //alert(movepage);
	      	location.href = movepage;
	  };
	  // 커뮤니티  회원정보 팝업 view 
      var jsMemberJoinPop = function(el, cmmntyId, langCode, cmmntySbscrbMthd) {

          var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	        //if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd;
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd;
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd;
			//}}

          $(el).colorbox({
             	title : "커뮤니티 회원 가입",         
   				href      : movepage,
   				width : "790px",
   	        	height : "640px",
   	       		overlayClose : false,
             	escKey : false,
             	closeButton : false,
             	iframe : true
         }); 
      };
      var jsMemberJoinPop2 = function(el, cmmntyId, langCode, cmmntySbscrbMthd, mberStateCd) {
          var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	      	//if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd+"&mberStateCd="+mberStateCd;
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd+"&mberStateCd="+mberStateCd;
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntySbscrbMthd="+cmmntySbscrbMthd+"&mberStateCd="+mberStateCd;
			//}}

          if(mberStateCd =="1002"){
              alert("커뮤니티 가입 거절되었습니다.");
              return;
          }
          if( confirm("커뮤니티 탈퇴 회원 입니다. 재가입 하시겠습니까?")){
	          $(el).colorbox({
	             	title : "커뮤니티 회원 가입",         
	   				href      : movepage,
	   				width : "790px",
	   	        	height : "750px",
	   	       		overlayClose : false,
	             	escKey : false,
	             	closeButton : false,
	             	iframe : true
	         }); 
          }
      };
      
      var jsCmmntyMberInfo = function(el,cmmntyId, langCode, mberStateCd) {
          var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	     	// 이전소스
	        //if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&mberStateCd="+mberStateCd;
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&mberStateCd="+mberStateCd;
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/PD_cmUserJoinInfoView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&mberStateCd="+mberStateCd;
			//}}
          $(el).colorbox({
             	title : "커뮤니티 회원 정보",         
   				href      : movepage,
   				width : "790px",
   	        	height : "750px",
   	       		overlayClose : false,
             	escKey : false,
             	closeButton : false,
             	iframe : true
         }); 
      };
      
      //커뮤니티 가입 취소 
      var jsMemberCancelPop = function(){
          var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	      var movepage2="";
	     	// 이전소스
	      	//if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/INC_cmMemberShipCancelDelete.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//  movepage2 ="http://korean.ceart.kr/korean/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/INC_cmMemberShipCancelDelete.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//   movepage2 ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}
	     	
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/INC_cmMemberShipCancelDelete.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	movepage2 ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
			//}}
          
 	     if ( confirm(Message.msg.chkCmConfirmCancle)) {
 	         
	         $("#dataForm").ajaxSubmit({
		        url      : movepage,
		        type     : "POST",
		        dataType : "text",
		        success  : function(response) {
        			if (response == "true")  {
		                alert(Message.msg.chkCmConfirmCancleOk);//성공
		                $("#dataForm").attr("action",movepage2).submit();
            		} else { 
            		    alert(Message.msg.processError);//오류발생
		               	return;
            		}
       			}
    		});
	 	}
      };
      var jsMemberSecede = function(){
          var subdomain = "<c:out value='${SubDomain}'/>";
	      var movepage = "";
	      var movepage2="";
	     	// 이전소스
	        //if(subdomain == "korean"){
	     	//   movepage ="http://korean.ceart.kr/korean/cm/user/cmUserMenu/INC_cmMemberShipSecedeUpdate.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//   movepage2 ="http://korean.ceart.kr/korean/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}else{
	     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMenu/INC_cmMemberShipSecedeUpdate.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//   movepage2 ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	//}
          
	     	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
			// 변경소스
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMenu/INC_cmMemberShipSecedeUpdate.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	     	movepage2 ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMain/BD_index.do?cmmntyId=<c:out value='${cmmntyId}'/>";
			//}}
 	     if ( confirm("커뮤니티를 탈퇴 하시겠습니까?")) {
 	         
	         $("#dataForm").ajaxSubmit({
		        url      : movepage,
		        type     : "POST",
		        dataType : "text",
		        success  : function(response) {
        			if (response == "true")  {
		                alert("커뮤니티 탈퇴가 완료 되었습니다.");
		                $("#dataForm").attr("action",movepage2).submit();
            		} else { 
            		    alert("커뮤니티 탈퇴 중 오류가 발생했습니다.");
		               	return;
            		}
       			}
    		});
	 	}
      };
      // 로그인 체크 
      var jsLoginCheck  = function(el, fn, check, cmmntyBbsSeq, schdulSeq ){
          //alert("111");
          var subdomain = "<c:out value='${SubDomain}'/>";
          var cmmntyId = "<c:out value='${cmInfoView.cmmntyId}'/>";
          var langCode = "<c:out value='${cmInfoView.langCode}'/>";
          var cmmntySbscrbMthd = "<c:out value='${cmInfoView.cmmntySbscrbMthd}'/>";
          var cmmntyMenuCode = "<c:out value='${cmmntyMenuCode}'/>";
          //var cmmntyBbsSeq = cmmntyBbsSeq;
         if(cmmntyBbsSeq == ""){
              
              cmmntyBbsSeq = $("#dataForm #cmmntyBbsSeq").val();
              
              if( typeof cmmntyBbsSeq == "undefined"){
                  cmmntyBbsSeq = "";
              }
          }
         if(schdulSeq == "" || typeof schdulSeq == "undefined"){
             
             schdulSeq = $("#dataForm #schdulSeq").val();
             
             if( typeof schdulSeq == "undefined"){
                 schdulSeq = "";
             }
         }
         
          var movepage = "";
          if(subdomain == "korean"){
              movepage = "/korean/cm/user/cmUserMenu/ND_loginCheckURL.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode+"&langCode="+langCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&schdulSeq="+schdulSeq;
          }else{
              movepage = "/"+subdomain+"/cm/user/cmUserMenu/ND_loginCheckURL.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode+"&langCode="+langCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&schdulSeq="+schdulSeq;
          }
          if(fn == "" ){
		      $("#dataForm").ajaxSubmit({
		          url      : movepage,
		          type     : "POST",
		          dataType : "json",
		     	  async : false,
		          success  : function(data) {
		          	if (data.result == true){
		          	    	if(check !="cmuser"){
		         				alert(data.message);
		          	    	}
		          	    	//alert( data.value);
		         			location.href = data.value;
		          	} 
		          }
		     });
          }else{
              jsMemberJoinPop(el,cmmntyId, langCode, cmmntySbscrbMthd);
          }
      }
	</script>
	<input type="hidden" id="nowURL" name="nowURL" value="<%=nowURL%>"/> 
	<input type="hidden" id="browserType" name="browserType" value="" />
	<div class="visual">
		<c:if test="${cmInfoView.logoDirectRegistAt eq 'Y'}">
				<img id="img1" src="<c:out value="${cmInfoView.logoFileUrl}"/>" alt="대표이미지">
		</c:if>
		<c:if test="${cmInfoView.logoDirectRegistAt eq 'N'}">
			<div id="containerLogoMenu">
				<div class="resultMenu" >
					<img id="mainLogoMenu" src="/upload/cmmntylogo/img_banner_visual.jpg" alt="대표이미지" style="width:999px; height:170px;" />
					<div id="textLogoMenu" class="inertxtMenu" ></div>
				</div>
			</div>
		</c:if>
		</div>
		<!-- side navigation bar -->
		<div class="snb">
			<c:if test="${cmInfoView.userId != sessionScope['__usk'].userId }">
			<c:if test="${cmInfoView.cmmntySttusCd == 1002}" >
				<c:if test="${empty cmUserMberInfo}">
				<!-- 가입전 -->
				<div class="community_Join">
					<div class="btn_org"><a href="#none" onclick="jsLoginCheck(this,'<c:out value="${sessionScope['__usk'].userId}"/>','left', '');"><span class="community">커뮤니티 가입</span></a></div>
				</div>
				<!-- //가입전 -->
				</c:if>
<%-- 				<c:out value="${cmUserMberInfo.mberStateCd}"/> --%>
				<c:if test="${cmUserMberInfo.mberStateCd == '1004'}">
				<!-- 가입전 -->
				<div class="community_Join">  
					<div class="btn_org">
					<a href="#none" onclick="jsMemberJoinPop2(this,'<c:out value='${cmInfoView.cmmntyId}'/>', '<c:out value='${cmInfoView.langCode}'/>', '<c:out value='${cmInfoView.cmmntySbscrbMthd}'/>', '1004');">
					<span class="community">커뮤니티 가입</span></a>
					</div>
				</div>
				<!-- //가입전 -->
				</c:if>
				<c:if test="${cmUserMberInfo.mberStateCd == '1002'}">
				<!-- 가입전 -->
				<div class="community_Join">  
					<div class="btn_org">
					<a href="#none" onclick="jsMemberJoinPop2(this,'<c:out value='${cmInfoView.cmmntyId}'/>', '<c:out value='${cmInfoView.langCode}'/>', '<c:out value='${cmInfoView.cmmntySbscrbMthd}'/>', '1002');">
					<span class="community">커뮤니티 가입</span></a>
					</div>
				</div>
				<!-- //가입전 -->
				</c:if>
				<c:if test="${cmUserMberInfo.mberStateCd == '1001' }">
				<!-- 가입중 -->
				<div class="community_Login">
					<p><strong>가입 진행중</strong>입니다.</p>
					<div class="join">
						<div class="btn_light_gray">
							<a href="#none" onclick="jsMemberCancelPop();">가입취소</a>
						</div>
					</div>
				</div>
				<!-- //가입중 -->
				</c:if>
				<c:if test="${cmUserMberInfo.mberStateCd == '1003'  }">
				<!-- 가입완료 일반 회원 -->
				<div class="community_Login">	
					<p><strong><a href="#none" onclick="jsCmmntyMberInfo(this,'<c:out value='${cmUserMberInfo.cmmntyId}'/>', '<c:out value='${cmUserMberInfo.langCode}'/>', '<c:out value='${cmUserMberInfo.mberStateCd}'/>');"><c:out value='${cmUserMberInfo.ncnm}'/></a></strong> 님 환영합니다.</p>
					<ul>
						<li><span class="txt" onclick="jsWriteReplyList('write')" style="cursor: pointer;">작성글</span><span class="num"><em><c:out value='${userBBS}'/></em>건</span></li>
						<li><span class="txt"onclick="jsWriteReplyList('reply')" style="cursor: pointer;" >작성 댓글</span><span class="num"><em><c:out value='${userCMT}'/></em>건</span></li>
					</ul> 
				</div>
				<!-- //가입완료 일반 회원 -->
				</c:if>
			</c:if>
			<c:if test="${cmInfoView.cmmntySttusCd == 1005}">
			<div class="community_Join">  
					<div class="btn_org">
					<a href="#none" onclick="alert(Message.msg.chkCmRegist)">
					<span class="community">커뮤니티 폐쇄중</span></a>
					</div>
				</div>
			</c:if>
			</c:if>
			<c:if test="${cmInfoView.userId == sessionScope['__usk'].userId }">
			<!-- 운영자 -->
			<div class="community_Login">	
				<p class="ico"><c:out value='${cmInfoView.userNm}'/></p>
				<div class="setting"><a href="#none" onclick="jsAdminMove();"><img src="/resources/cmmnty/default/images/common/ico/ico_setting.png" alt="설정"></a></div>
				<ul>
					<li><span id="span1" class="txt" onclick="jsWriteReplyList('write')" style="cursor: pointer;">작성글</span><span class="num"><em><c:out value='${userBBS}'/></em>건</span></li>
					<li><span id="span2" class="txt" onclick="jsWriteReplyList('reply')" style="cursor: pointer;">작성 댓글</span><span class="num"><em><c:out value='${userCMT}'/></em>건</span></li>
				</ul>
			</div> 
			<!-- //운영자 -->
			</c:if>
			<ul>
				<li><a href="#none" onclick="jrMoveMenu1('<c:out value='${SubDomain}'/>')" <c:if test="${ cmmntyMenuCode == '0'}"> class="on" </c:if>>커뮤니티 홈</a></li>
				<li><a href="#none" onclick="jrMoveMenu2('<c:out value='${SubDomain}'/>')" <c:if test="${ cmmntyMenuCode == '1'}"> class="on" </c:if>>커뮤니티 정보</a></li>
				<c:forEach var="dataList" items="${cmUserMenuList}" varStatus="status">
				<li><a href="#none" onclick="jrMoveMenu('<c:out value='${ dataList.cmmntyMenuUrl}'/>','<c:out value='${dataList.cmmntyId}'/>','<c:out value='${dataList.cmmntyMenuCode}'/>'
				,'<c:out value='${dataList.langCode}'/>','<c:out value='${dataList.cmmntyBbsTyCd}'/>','<c:out value='${dataList.cmmntyMenuFolderNm}'/>' );"<c:if test='${ cmmntyMenuCode == dataList.cmmntyMenuCode }'> class="on" </c:if> >
				<c:out value='${ dataList.cmmntyMenuNm}'/></a></li>
				</c:forEach>
			</ul>
			<div class="btn_area">
					<div class="btn_l">		
					<c:if test="${cmInfoView.userId != sessionScope['__usk'].userId && not empty sessionScope['__usk'].userId}">				
						<div class="btn_navi">
						<c:if test="${cmUserMberInfo.mberStateCd == '1003'  }">
							<a href="#none" onclick="jsMemberSecede();" ><span class="cancel">커뮤니티 탈퇴</span></a>
						</c:if>
						</div>
					</c:if>
					</div>
				</div>
		</div>
		<!-- //side navigation bar -->