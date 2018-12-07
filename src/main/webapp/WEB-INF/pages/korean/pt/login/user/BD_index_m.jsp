<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%
	String sslYn = "";
	if("Y".equals(Config.getString("global.sslUse"))) {
		sslYn = "Y";
	}else{
		sslYn = "N";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head><c:url value="" />
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>로그인</title>	
	<op:jsTag type="spi" items="cookie" />
	
	<!-- 2016.12.02 회원 로그인 css추가 -->
   <link rel="stylesheet" type="text/css" href="/new_cloud_m/css/sub.css" />
   <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

    <script type="text/javascript">
    	<c:if test="${!empty sessionScope['__usk']}">
	    	alert(Message.msg.loginAlready);
	        top.location.href = CTX_PATH + Config.url.mobileMain;
    	</c:if>
    	$().ready(function() {
            $("#userId").focus();
            $("#userId").bind("keypress", {}, enterEvent);
            $("#userPassword").bind("keypress", {}, enterEvent);
            $("#login").bind("click", {}, jsLoginAction);
        });
		
        var enterEvent = function(e) {
            if(e.keyCode == 13) {
                return jsLoginAction();
            }
        };
        
		var num =0;
        var jsLoginAction = function() {
            if($("#userId").val() == '') {
                alert(Message.msg.emptyId);
                $("#userId").focus();
                return false;
            }
            if($("#userPassword").val() == '') {
                alert(Message.msg.emptyPwd);
                $("#userPassword").focus();
                return false;
            }
            if($("#userPassword").val().indexOf('●') > -1){
        	    alert(Message.msg.wrongPwd);
        		return false;
        	}
			num++;
            $.post(CTX_PATH + Config.url.userLoginAction, {
                userId : $("#userId").val(),
                userPassword : $("#userPassword").val(),
                memChk : $("#memChk").val()
            }, function(response) {
                if(isNaN(response) && response.indexOf('200') < 0) {
                    if(response.indexOf('Withdraw') > -1){
                        alert(Message.msg.noUseId);
                    }else if(response.indexOf('notMatchLogin') > -1){
                        alert(Message.msg.notMatchLogin);
                    }else{
                        alert(response);
                    }
                } else {
                    old = 'N';
                    responses = response.split(" ");
                    $.cookie("userId",responses[1],{path:'/'});
                    if(responses[0] == 2000){ <%-- 비밀번호 변경 90일 확인 --%>
                        if(confirm(Message.msg.pwdTooOld)){
                            old = 'Y';
                            <% if("Y".equals(Config.getString("global.sslUse"))) { %>
                            	top.location.href = "https://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/register/BD_userUpdateForm.do?pwdChg=Y";	
                        	<% }else{ %>
                        		top.location.href = "http://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/register/BD_userUpdateForm.do?pwdChg=Y";
    	                    <% } %>
                        }
                    }else if(responses[0] == 2001){
                        old = 'Y';
                        <% if("Y".equals(Config.getString("global.sslUse"))) { %>
                            top.location.href = "https://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/register/BD_userDrmncyForm.do";  
                        <% }else{ %>
                            top.location.href = "http://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/register/BD_userDrmncyForm.do";
                        <% } %>
                    }
                  	//20160804 : KS : 신규약관동의 종료
                    <%-- 
                    else if(responses[0] == 2002){
                        if(confirm('변경된 이용약관에 동의해야만 로그인이 가능합니다.\n약관동의 페이지로 이동하시겠습니까?')){
	                        old = 'Y';
	                        <% if("Y".equals(Config.getString("global.sslUse"))) { %>
	                            top.location.href = "https://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/login/user/BD_newAgree.do";  
	                        <% }else{ %>
	                            top.location.href = "http://"+$("#rtnDomain").val() + CTX_PATH+"/korean/pt/login/user/BD_newAgree.do";
	                        <% } %>
                        } else {
                            return false;
                        }
                    }
                    --%>
                    if(old == 'N'){
	                   	if($("#returnUrl").val() != "" ){
	                   	   // 이슬버미 추가 2014.11.19
	                   	   //POST/GET 방식 전송
	                       var path2 = "http://"+$("#rtnDomain").val();
	                       path2 = path2.replace("https","http");
	                       path2 = path2.replace(":443","");
	                   	   var path = path2 + CTX_PATH + $("#returnUrl").val();
	                       var url = $("#returnParam").val();
	                       var method = (url.toLowerCase().indexOf("returnmethod=post") == -1 ? "GET" : "POST"); 
	                       
	                       getReturnUrl(path,url,method);
	                       
	                       /* if($("#returnParam").val() != ""){
	                            top.location.href = "http://"+$("#rtnDomain").val() + CTX_PATH + $("#returnUrl").val() + "?" + $("#returnParam").val();
	                        }else{
	                            top.location.href = "http://"+$("#rtnDomain").val() + CTX_PATH + $("#returnUrl").val();
	                        } */
	     	            }else{
	     	               	var url = $("#rtnDomUrl").val();
	     	               	alert(url);
	     	               	url = url.replace("https","http");
	     	               	url = url.replace(":443","");
	     	               	top.location.href = url + "index.do";
	    	            }
                    }
                }
            }).error(function(result) {
				//alert(num);	
				if(num <= 15) jsLoginAction();
            //   alert(result.statusText+":"+result.status+":"+result.responseText); 
            });
            return false;
        };

      //Submit 전속 전송  (주소,파라메터,메소드)
      function getReturnUrl(path, url, method) {
            
          method = method || "get"; // Post:Get 전송 기본설정은 Post
        
          //FORM 생성
          var form = document.createElement("form");
          form.setAttribute("method", method);
          form.setAttribute("action", path);
          
          //URL-> JSON 변환
          var hash;
          var myJson = {};
          var hashes = url.slice(url.indexOf('?') + 1).split('&');
          for (var i = 0; i < hashes.length; i++) {
              hash = hashes[i].split('=');
              myJson[hash[0]] = hash[1];
          }
          
          //변수 저장
          var params = myJson;
          
          //INPUT HIDDEN 에 값 저장
          // 예  {"userId":"abcd","mgrId":"abcd"}
          for(var key in params) {
              var hiddenField = document.createElement("input");
              hiddenField.setAttribute("type", "hidden");
              hiddenField.setAttribute("name", key);
              hiddenField.setAttribute("value", params[key]);
       
              form.appendChild(hiddenField);
          }
       
          //SUBMIT 발송
          document.body.appendChild(form);
          form.submit();
        };
        
    </script>
</head>
<body>
	<div id="container" >
			<!-- contents -->
			<div class="contents login">
				<h2><i>클라우드스토어 씨앗에 오신 것을 환영합니다.</i></h2>
				<p>로그인 하시면 회원님을 위한 더 많은 서비스를 경험하실 수 있습니다.</p>
				 <form id="dataForm" method="post" action="<c:url value='/login/user/ND_loginAction.do' />" onsubmit="return false">
				  <%-- 이전 Web 로그인 소스
				  <input type="hidden" name="returnUrl" id="returnUrl" value="<c:out value='${param.returnUrl}' />" />
				  --%>
				  <input type="hidden" name="returnUrl" id="returnUrl" value="/korean/m/index.do" />
				  <input type="hidden" name="returnParam" id="returnParam" value="<c:out value='${returnParam}' />" />
				  <input type="hidden" name="rtnDomUrl" id="rtnDomUrl" value="<c:out value='${rtnDomUrl}' />" />
				  <input type="hidden" name="rtnDomain" id="rtnDomain" value="<c:out value='${rtnDomain}' />" />
				  <input type="hidden" name="memChk" id="memChk" value="<c:out value='${memChk}' />" />
				<input type="text" id="userId" name="userId"  autofocus="auto" tabindex="1" placeholder="ID"/>
				<input type="password" id="userPassword" name="userPassword" tabindex="1"  placeholder="PW"/>
				<a href="javascript:" onclick="jsLoginAction();"><i>Login</i></a>
				<label><input type="checkbox" checked="checked" /> 로그인 상태 유지</label>
				</form>
			</div>
	<!--// content -->
	</div>

</body>
</html>