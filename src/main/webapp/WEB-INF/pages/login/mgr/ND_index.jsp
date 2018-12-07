<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.base.support.OpHelper" %>
<%@ page import="zes.core.spi.commons.configuration.Config" %>
<%@ page import="zes.openworks.common.GlobalConfig" %>
<%@ page language="java" import="java.net.InetAddress" %>
<%
if( GlobalConfig.SERVICE_MODE.equals("real")) {
	String ipAddress = (String)request.getRemoteAddr();
	if (!(ipAddress.equals("210.91.26.242") 	|| ipAddress.equals("123.111.240.111") 	|| ipAddress.equals("172.20.105.159") || 
			  ipAddress.equals("172.20.105.105") 	|| ipAddress.equals("172.20.105.67") 	|| ipAddress.equals("152.99.104.252") || 
			  ipAddress.equals("203.254.51.26")  	|| ipAddress.equals("218.48.232.106") 	|| ipAddress.equals("125.128.73.3")		|| 
			  ipAddress.equals("220.64.91.55") 		|| ipAddress.equals("203.254.51.15") 	|| ipAddress.equals("172.20.105.18") 	|| 
			  ipAddress.equals("172.20.101.121") 	|| ipAddress.equals("172.20.101.122")  	|| ipAddress.equals("172.20.101.125") ||
			  ipAddress.equals("172.20.101.126") 	|| ipAddress.equals("172.20.101.127")  	|| ipAddress.equals("172.20.101.129") || 
			  ipAddress.equals("172.20.101.124")  || ipAddress.equals("220.64.91.55")) )
	{ 
		%>
		<script type="text/javascript">alert('접근할 수 없는 IP 입니다'); location.href="https://www.ceart.kr/";</script> 
		<%
	}
}
%>
<%
	
	Object loginVo = OpHelper.getMgrSession(request);
	if(loginVo != null){
		response.sendRedirect(request.getContextPath() + Config.getString("url.mgrMain"));
		return;
	}
	String sslYn = "";
	String prtcl = "";
	if("Y".equals(Config.getString("global.sslUse"))) {
		sslYn = "Y";
		prtcl = ":447";
	}else{
		sslYn = "N";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="ko" />
<title>로그인</title>
<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/ceart_favicon.ico" />
<op:jsTag type="spi" items="jquery, notice, cookie" />
<op:jsTag type="openworks" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/login/css/login.css" />
<style type="text/css">
	#result {
		text-align: right;
		color: red;
		font-size: 12px;
	}
</style>
<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
<script type="text/javascript">
	var enterEvent = function(e){
		if(e.keyCode == 13){
			return jsLoginAction();
		}
	};

	$().ready(function(){
		$("#mngrId")[0].focus();
		$("#mngrId").bind("keypress", {}, enterEvent);
		$("#mngrPassword").bind("keypress", {}, enterEvent);
		$("#lv1_submit").bind("click", {}, jsLoginAction);

		//아이디저장(쿠키이용)
		$("#checkId").bind('click', function(){
			var ischecked = $("#checkId").is(":checked");
			if(ischecked){
				$.cookie("opMgrId", $('#mngrId').val(), { expires:30, path: '/' });
			}else{
				$.cookie('opMgrId', '', { expires: -1, path: '/' });
			}
		});

		var saveId = $.cookie("opMgrId");
		if(saveId != null && saveId != -1){
			$("#mngrId").val(saveId);
			$("#checkId").attr("checked","checked");
			$("#mngrPassword").focus();
		}else{
			$("#mngrId").focus();
		}
	});

	var jsLoginAction = function(){
		if(!$("#mngrId").val()){
			$("#result").html("아이디를 입력하세요.");
			$("#mngrId").focus();
			return false;
		}
		if(!$("#mngrPassword").val()){
			$("#result").html("비밀번호를 입력하세요.");
			$("#mngrPassword").focus();
			return false;
		}

		$("#result").html("로그인 중입니다.");
		
		$.post(CTX_PATH + Config.url.mgrLoginAction, {
			mngrId : $("#mngrId").val(),
			mngrPassword : $("#mngrPassword").val()
		}, function(response){
			if(isNaN(response)){
			    $("#result").html("");
			    if(response.indexOf('notMatchLogin') > -1){
			        alert(Message.msg.notMatchLogin);
			    }else{
			        alert(response);    
			    }
			}else{
			    var url = "http://<%= GlobalConfig.DOMAIN_ADMNM%>";
			    //"http://intra.sceart.kr";	//SSL로 포트를 달고 들어왔을 경우 프로토콜과 포트를 해제
				top.location.href = url + CTX_PATH + Config.url.mgrMain;
			}
        });
		return false;
	};
</script>
</head>
<body>
	<%
	InetAddress inet = InetAddress.getLocalHost();
	String svrIP     = inet.getHostAddress();
	String autoId    = "192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) ? "ceartmanager01" : "" ; // 로컬ip일때 자동으로 만능암호를 자동입력한다.	                   
	String autoPw    = "192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) ? "ceart0414!@" : "" ; // 로컬ip일때 자동으로 만능암호를 자동입력한다.	                   
	%>
	
	<div class="wrap">
		<img src="/resources/openworks/login/images/top_r_img.png" class="top_img" alt="" />
		<!-- contents -->
		<div class="con_all">
			<h1><img src="/resources/openworks/theme/default/images/layout/bi_kor.png" alt="클라우드스토어 씨앗 로고" /></h1>
			
			<div class="login">
				<img src="/resources/openworks/login/images/tx_copy_re.png" class="pad_t25" alt="오픈플랫폼 마켓플레이스 통합관리자" />
				<form id="dataForm" method="post" action="/login/mgr/ND_loginAction.do" >
					<fieldset>
						<legend>로그인</legend>
						<dl>
							<dt><label for="mngrId">아 이 디</label></dt>
							<dd><input type="text" name="mngrId" id="mngrId" class="txt" value="<%=autoId%>" /></dd>
							<dt><label for="mngrPassword">비밀번호</label></dt>
							<dd><input type="password" name="mngrPassword" id="mngrPassword" class="txt" value="<%=autoPw%>" autocomplete="off" /></dd>
						</dl>

						<input type="image" name="lv1_submit" id="lv1_submit" alt="로그인" src="/resources/openworks/login/images/btn_login.gif" class="btn" />
						<div id="result"></div>
						<p>
							<input type="checkbox" id="checkId" name="checkId" class="check" />
							<label for="keep_uid2">아이디저장</label>
						</p>
					</fieldset>
				</form>

			</div>
			<p>
				본 시스템은 허가된 사용자만 이용하실 수 있습니다.
				부당한 방법으로 전산망에  접속하거나 정보를 삭제/변경/유출하는 사용자는 관련법령에 따라 처벌 받게 됩니다.
				<span>COPYRIGHT 2015 (c) 한국정보화진흥원 ALL RIGHTS RESERVED</span>
			</p>
		</div>
		<!-- //contents -->

		<img src="/resources/openworks/login/images/bottom_l_img.png" class="bottom_img" alt="" />
	</div>
</body>
</html>