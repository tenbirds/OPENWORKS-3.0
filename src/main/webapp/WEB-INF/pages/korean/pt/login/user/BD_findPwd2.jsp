<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//String SubDomain = CmsUtil.getHostName(request.getServerName());

	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
	//변경소스
	  request.setAttribute("SubDomain", "korean");
	  HttpSession hs = request.getSession();
	  String DomainName = String.valueOf(hs.getAttribute("domain_name"));  
	//}} 
	NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
    
    String cpsSiteCode = "G7358";					// NICE로부터 부여받은 사이트 코드
    String sSitePassword = "UM0TNW4SRJ9S";		// NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                    	// 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(cpsSiteCode);
  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
  	
   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
   	
   	String popgubun 	= "N";		//Y : 취소버튼 있음 / N : 취소버튼 없음
	String customize 	= "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
	String sReturnUrl = "";    
    String sErrorUrl = "";
	String sslYn = "";
	String prtcl = "";
	if("Y".equals(Config.getString("global.sslUse"))) {
		sslYn = "Y";
		prtcl = ":443";
	}else{
		sslYn = "N";
	}
	// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    if("Y".equals(Config.getString("global.sslUse"))) {
	    // 이전소스
    	//sReturnUrl = "https://"+SubDomain+".ceart.kr"+prtcl+"/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    //sErrorUrl = "https://"+SubDomain+".ceart.kr"+prtcl+"/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
	    
	    //{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		sReturnUrl = "https://"+DomainName+prtcl+"/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    sErrorUrl = "https://"+DomainName+prtcl+"/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
		//}} 
    }else{
	    // 이전소스
    	//sReturnUrl = "http://"+SubDomain+".ceart.kr/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    //sErrorUrl = "http://"+SubDomain+".ceart.kr/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
	    
	    //{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		sReturnUrl = "http://"+DomainName+"/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    sErrorUrl = "http://"+DomainName+"/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
		//}}
    }

    // 입력될 plain 데이타를 만든다.
    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                        "8:SITECODE" + cpsSiteCode.getBytes().length + ":" + cpsSiteCode +
                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
    
    String sMessage = "";
    String cpsEncData = "";
    
    int iReturn = niceCheck.fnEncode(cpsSiteCode, sSitePassword, sPlainData);
    if( iReturn == 0 ){
        cpsEncData = niceCheck.getCipherData();
    }else if( iReturn == -1){
        sMessage = "암호화 시스템 에러입니다.";
    }else if( iReturn == -2){
        sMessage = "암호화 처리오류입니다.";
    }else if( iReturn == -3){
        sMessage = "암호화 데이터 오류입니다.";
    }else if( iReturn == -9){
        sMessage = "입력 데이터 오류입니다.";
    }else{
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
%>
<%
    /********************************************************************************************************************************************
        NICE신용평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
        
        서비스명 : 가상주민번호서비스 (IPIN) 서비스
        페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
    *********************************************************************************************************************************************/
    
    String sSiteCode                = "K517";           // IPIN 서비스 사이트 코드      (NICE신용평가정보에서 발급한 사이트코드)
    String sSitePw                  = "57168249";       // IPIN 서비스 사이트 패스워드    (NICE신용평가정보에서 발급한 사이트패스워드)

    /*
    ┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
        NICE신용평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
        따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.
        
        * URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
        * 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.
        
        아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
        예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
    └────────────────────────────────────────────────────────────────────
    */

    String sReturnURL = "";
    if("Y".equals(Config.getString("global.sslUse"))) {
    	// 이전소스
    	//sReturnURL = "https://"+SubDomain+".ceart.kr"+prtcl+"/common/ipin/ipin_process.do";
    	
    	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
		// 변경소스
			sReturnURL = "https://"+DomainName+prtcl+"/common/ipin/ipin_process.do";
		//}}
    }else{
    	// 이전소스
	    //sReturnURL = "http://"+SubDomain+".ceart.kr/common/ipin/ipin_process.do";
	    
	  	//{{ BH, 2015.11.19, 도메인관리삭제로 인한 소스변경 
  		// 변경소스
	  		sReturnURL = "http://"+DomainName+"/common/ipin/ipin_process.do";
  		//}}
    }
    //String Param3Val = SubDomain+" "+"3";	//결과페이지에서 사용
    String Param3Val = "korean 3";	//결과페이지에서 사용
    
    /*
    ┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
        [CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.
        
        CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
        데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.
        
        따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
    └────────────────────────────────────────────────────────────────────
    */
    String sCPRequest               = "";

    // 객체 생성
    IPINClient pClient = new IPINClient();

    // 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
    sCPRequest = pClient.getRequestNO(sSiteCode);
    
    // CP 요청번호를 세션에 저장합니다.
    // 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
    // 필수사항은 아니며, 보안을 위한 권고사항입니다.
    session.setAttribute("CPREQUEST" , sCPRequest);

    // Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
    int iRtn = pClient.fnRequest(sSiteCode, sSitePw, sCPRequest, sReturnURL);
    
    String sRtnMsg                  = "";           // 처리결과 메세지
    String sEncData                 = "";           // 암호화 된 데이타
    
    // Method 결과값에 따른 처리사항
    if (iRtn == 0){
        // fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
        // 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
        sEncData = pClient.getCipherData();     //암호화 된 데이타
        sRtnMsg = "정상 처리되었습니다.";
    }else if (iRtn == -1 || iRtn == -2){
        sRtnMsg =   "배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<br />" +
                    "귀사 서버환경에 맞는 모듈이 없다면 ..<br /><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
    }else if (iRtn == -9){
        sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
    }else{
        sRtnMsg = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요.";
    }

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>비밀번호 찾기 2단계</title>
	<op:jsTag type="spi" items="form" />
	<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
	<!--	==========================================================	-->
	<!--	한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)	-->
	<!--	==========================================================	-->
	<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
	<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
	<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            if("${param.clTy}" == "2"){
			    $('#clty3').css('display','block');
			    $('#clty1').css('display','none');
			    $('#clty2').css('display','none');
			}else if("${param.clTy}" == "3"){
			    $('#clty2').css('display','block');
			    $('#clty1').css('display','none');
			    $('#clty3').css('display','none');
			}else{
			    $('#clty1').css('display','block');
			    $('#clty3').css('display','none');
			    $('#clty2').css('display','none');
			}
		});
        
        var setChildValue = function(encData, rtnMsg, userTyCd, nationCode, param3){
        	var param3Arr = "";
        	if(param3 != ""){
        	    param3Arr = param3.split(' ');
        	    document.user.encData.value = encData;
       		    document.user.action = "/"+param3Arr[0]+"/pt/login/user/BD_findPwd3.do";
        	    document.user.submit();
        	}
        };
        
        var jsFindSend = function(){
            $("#dataForm").ajaxSubmit({
            	url		: "DummyGet.do",
            	type	: "POST",
            	async	: false,
            	success	: function (response) {
            	    
            		$.post("ND_findPwdSend.do", {
                
		            }, function(response) {
		                if(response) {
		                    alert(Message.msg.sendMailSucc);
		                    /* if("${param.clTy}" == "2" || "${param.clTy}" == "3"){
		                    	top.location.href = "/korean/pt/login/user/BD_findPwd3.do";
		                    }else{ */
		                        top.location.href = "/korean/pt/index.do";
		                    /* } */
		                } else {
		                    alert(Message.msg.sendMailFail);
		                }
		            });
            	}
            });
        };
        
        window.name ="Parent_window";
      	//휴대폰인증
		function cpPopup(){
			window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
			document.form_chk.target = "popupChk";
			document.form_chk.submit();
		}
        
      	//IPIN인증
		function jsIpinPopup(){
		    window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
		    document.form_ipin.target = "popupIPIN2";
		    document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
		    document.form_ipin.submit();
		}
		
		document.onkeydown = onKeyDown;
		
		function onKeyDown(event){
			var e = event;
			if(event == null) e = window.event;

			if(e.keyCode == 13) jsValidateBizrno();
		}

		function bizrnoValidate(){
			var $bizNm = $("#bizNm");
			var $bizNo = $("#bizNo");
			var infoFlag = "2";

			//사업자/법인번호에서 '-'를 제거한다.
			//$bizNo.val($bizNo.val().replace(/-/g, '');

			if($bizNo.val() == ""){
				alert(getCheckMessage("S41"));
				$bizNo.val("");
				$bizNo.focus();
				return false;
			}

			if($bizNm.val() == ""){
				alert(getCheckMessage("S42"));
				$bizNm.focus();
				return false;
			}

			if(checkString($bizNm.val()) == false){
				alert(getCheckMessage("S43"));
				$bizNm.focus();
				return false;
			}

			if(checkNumeric($bizNo.val()) == false){
				alert(getCheckMessage("S44"));
				$bizNo.focus();
				return false;
			}

			return true;
		}

		function goIDCheck(){
			if(bizrnoValidate() == true){
			    var strNm = $("#bizNm").val();
				var strNo = $("#bizNo").val();
				var strRsn = $("#inqRsn").val();
				var strInfoFlag = "2";	//2:사업자번호,3:법인번호

				document.inputForm.SendInfo.value = makeBizSendInfo(strNo, strNm, strRsn, strInfoFlag);
				<% if("Y".equals(Config.getString("global.sslUse"))) { %>
						document.inputForm.action = "https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/common/bizrno/rnCheckRequest.do";
	            <% }else{ %>
						document.inputForm.action = "http://<%=GlobalConfig.DOMAIN_SUBNM %>/common/bizrno/rnCheckRequest.do";
	            <% } %>
				document.inputForm.submit();
			}
			return;
		}

		var jsValidateBizrno = function(){
		    if($("#bizNm").val() == ''){
		        alert("상호(법인명)를 입력해 주세요.");
		        $("#bizNm").focus();
		        return false;
		    }
		    if($("#bizNm1").val() == ''){
		        alert("사업자 등록번호를 입력해 주세요.");
		        $("#bizNm1").focus();
		        return false;
		    }
		    if($("#bizNm2").val() == ''){
		        alert("사업자 등록번호를 입력해 주세요.");
		        $("#bizNm2").focus();
		        return false;
		    }
		    if($("#bizNm3").val() == ''){
		        alert("사업자 등록번호를 입력해 주세요.");
		        $("#bizNm3").focus();
		        return false;
		    }

		    $("#cmpnyRprsntvNm").val($("#bizNm").val());
		    $("#bizrno").val($("#bizNm1").val()+"-"+$("#bizNm2").val()+"-"+$("#bizNm3").val());
		    $("#bizNo").val($("#bizNm1").val()+$("#bizNm2").val()+$("#bizNm3").val());
		    goIDCheck();
		};
    </script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post">
</form>


	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<span>
				<a href="BD_findId.do">아이디 찾기</a>
				<a href="BD_findPwd.do" class="on">비밀번호 찾기</a>
			</span>
			
			<img src="/cloud_ver2/new_cloud/images/findpw_step_2.png" alt="기본정보 입력" />
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap find_idpw pwComp">
		<h2>임시 비밀번호 발송</h2>
		<h3><i class="quot">등록한 이메일 : <em>${param.maskEmail}</em></i></h3>
		
		<div>
			<ul>
				<li>회원정보상의 이메일주소로 회원님의 비밀번를 안전하게 재발급하여 드립니다.</li>
				<li>임시비밀번호로 로그인 하신 후, 회원정보에서 비밀번호를 변경해주세요.</li>
			</ul>
			
			<div class="btnArea rig">				
				<a href="javascript:;" onclick="jsFindSend();" class="btns st1 icn icnPw">임시 비밀번호 발송</a>
			</div>
		</div>
		
	</div>
	<!--// content -->
<%-- 

	<!-- container -->
		<div id="container" class="join-wrap">
	
			<!-- contents -->
			<div class="contents">
				
				<!-- section -->
				<div class="section">
					<!-- tab-type1 -->
					<div class="tab-type1">
						<ul>
						<li><a href="BD_findId.do">아이디 찾기</a></li>
						<li class="on"><a href="BD_findPwd.do">비밀번호 찾기</a></li>
						</ul>
	
						<div class="step">
							<span class="step02"><em>기본정보 입력</em></span>
							<span class="step03 on"><em>인증정보 입력</em></span>
							<span class="step04"><em>비밀번호 재발급</em></span>
						</div>
					</div>
					<!-- //tab-type1 -->
				</div>
				<!-- //section -->
	
				<!-- title-area -->
				<div class="title-area">
					<h2>인증정보 입력</h2>
					<p class="txt-explain ml20 mb20">회원정보상의 이메일주소로 회원님의 비밀번호를 안전하게 재발급하여 드립니다.<br />임시비밀번호로 로그인 하신 후, 회원정보에서 비밀번호를 변경해주세요.</p>
				</div>
				<!-- //title-area -->
				
				<!-- [ 개인 구매회원 | 기업 구매회원 | 해외 회원 ]일  경우 인증방식 -->
				<span id="clty1" style="display:none">
					<!-- section -->
					<div class="section">
						<div class="type-list ac">
							<p class="txt-comform">등록한 이메일<strong class="txt-point ml20">${param.maskEmail}</strong></p>
						</div>
					</div>
					<!-- //section -->
					<!-- btn -->
					<div class="btn-area ar">
						<a href="javascript:;" onclick="jsFindSend();" class="b-btn auth type2"><strong><span>인증하기</span></strong></a>
					</div>
					<!-- //btn -->
				</span>
				
				<!-- //[ 개인 구매회원 | 기업 구매회원 | 해외 회원 ]일  경우 인증방식 -->
				
				<!-- ===================================================[디자인 없음 2015.12.14]============================================================ -->
				<!-- [개인 (판매회원)] 일 경우 인증방식 -->
				<span id="clty2" style="display:none">
				가상주민번호 서비스 팝업을 호출하기 위한 form
                <form name="form_ipin" method="post">
                    <input type="hidden" name="m" value="pubmain"/>                     필수 데이타, 누락하면 안됨
                    <input type="hidden" name="enc_data" value="<%= sEncData %>"/>      위에서 업체정보를 암호화 한 데이타
                    응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신. 해당 파라미터는 추가 불가함
                    <input type="hidden" name="param_r1" value=""/>
                    <input type="hidden" name="param_r2" value=""/>
                    <input type="hidden" name="param_r3" value="<%= Param3Val %>"/>	서브도메인+공백+요청페이지구분(3:비밀번호찾기)
                </form>
                가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
                     따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다.
                <form name="vnoform" method="post">
                    <input type="hidden" name="enc_data"/>      인증받은 사용자 정보 암호화 데이타입니다.
                    업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다.
                    <input type="hidden" name="param_r1" value=""/>
                    <input type="hidden" name="param_r2" value=""/>
                    <input type="hidden" name="param_r3" value=""/>
                </form>
                <!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
				<form name="form_chk" method="post">
					<input type="hidden" name="m" value="checkplusSerivce">			<!-- 필수 데이타로, 누락하시면 안됩니다. -->
					<input type="hidden" name="EncodeData" value="<%= cpsEncData %>">	<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
				    
				    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
				    	 해당 파라미터는 추가하실 수 없습니다. -->
					<input type="hidden" name="param_r1" value="">
					<input type="hidden" name="param_r2" value="">
					<input type="hidden" name="param_r3" value="<%= Param3Val %>">
				</form>
				<form name="user" method="post">
					<input type="hidden" name="regType"/>
					<input type="hidden" name="encData"/>
					<input type="hidden" name="userTyCd" value=""/>
					<input type="hidden" name="nationCode" value=""/>
				</form>
				<!-- 인증 -->
					<div class="join-area certification">
						<div class="multi-section-half">
							<div class="ac">
								<h4>휴대전화 인증</h4>
								<p><img src="/new_cloud/images/sub/icon-certification-mobile.png" alt="" /></p>
								<a href="#none" onclick="cpPopup(); return false;" title="휴대전화 인증 팝업창 열림" class="b-btn auth type2"><strong><span>인증하기</span></strong></a>
								<div class="dot-list">
									<ul>
									<li>개정 정보통신망법 제23조에 따라 회원 가입시에는 주민등록번호를 수집하지 않습니다.</li>
									<li>휴대전화 인증은 가입하시는 분 명의의 휴대전화로만 인증이 가능합니다. (14세 미만 가입 불가)</li>
									<li>인증이 되지 않을 경우, 나이스평가정보(주)(1588-2486)로 문의하시기 바랍니다.</li>
									</ul>
								</div>
							</div>
							<div class="ac">
								<h4>아이핀 인증</h4>
								<p><img src="/new_cloud/images/sub/icon-certification-ipin.png" alt="" /></p>
								<a href="#none" onclick="jsIpinPopup(); return false;" title="아이핀 인증 팝업창 열림" class="b-btn auth type2"><strong><span>인증하기</span></strong></a>
								<div class="dot-list">
									<ul>
									<li>아이핀(i-PIN)은 방송통신위원회에서 주관하는 주민등록번호 대체 수단으로 주민등록번호를 입력하지 않고 가입할 수 있는 서비스 입니다.</li>
									<li>아이핀 가입을 위해서는 아이핀 ID가 있어야 합니다. <a href="#">아이핀 ID 발급받기</a></li>
									<li>아이핀(i-PIN)에 대해서 아직도 잘 모르신다면? <a href="#">아이핀 소개 플래시보기</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</span>
				<!-- //[개인 (판매회원)] 일 경우 인증방식 -->
				
				<!-- ===================================================[디자인 없음 2015.12.14]============================================================ -->

				<!-- [기업 (판매회원)] 일 경우 인증방식 -->
				<span id="clty3" style="display:none">
					<form id="inputForm" name="inputForm" method="POST">	
						<input type="hidden" id="SendInfo" name="SendInfo" />
                    </from>
					<form id="bizForm" name="bizForm" method="post">
	                    <!-- 조회사유를 설정하십시오 ( '10'-회원가입, '20'-기존회원 확인, '30'-성인인증, '40'-비회원 확인, '50'-기타 사유 )	-->
						<input type="hidden" id="inqRsn" name="inqRsn" value="20">
	                    <input type="hidden" id="bizNo" name="bizNo" />
						<fieldset>
						<legend><span>인증 서식</span></legend>
						<div class="section">
					
						<div class="type-list">
							<!-- 테이블 -->
							<div class="type-write">
                                    <table>
                                    <colgroup>
                                        <col style="width:148px">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                       <th><span class="point">상호(가입명)</span></th>
                                        <td>
                                            <input type="text" id="bizNm" name="bizNm" style="width:423px;float:left;" maxlength="100" autofocus="autofocus">
                                        </td>
                                    </tr>
                                    <tr>
                                        <th><span class="point">사업자등록번호</span></th>
                                        <td class="sub">
                                            <input type="text" id="bizNm1" name="bizNm1" maxlength="3" title="사업자등록번호 첫번째 자리" class="w124">
                                            <span class="space">-</span>
                                            <input type="text" id="bizNm2" name="bizNm2" maxlength="2" title="사업자등록번호 가운데 자리" class="w124">
                                            <span class="space">-</span>
                                            <input type="text" id="bizNm3" name="bizNm3" maxlength="5" title="사업자등록번호 마지막 자리" class="w124">
                                            <a href="#" id="bizrnoChk" onclick="jsValidateBizrno('N');" title="팝업 창 열림" class="b-btn type1"><strong><span>중복 확인</span></strong></a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                 </div>
                                 </div>
                                <!-- list -->
								<ul class="mt20">
								<li>· 타인의 정보를 부정하게 사용하는 경우 관계법령에 따라 처벌받을 수 있습니다.</li>
								<li>· 실명인증이 되지 않는 경우 아래의 실명인증기관에 실명등록을 요청할 수 있습니다.</li>
								<li>· <strong>나이스신용평가정보</strong> 1588-2486</li>
								</ul>
								<!-- //list -->
                                <!-- btn -->
								<div class="btn-area ar">
									<a href="#none" onclick="jsValidateBizrno('Y');return false;" title="기업인증 하기" class="b-btn auth type2"><strong><span>인증하기</span></strong></a>
								</div>
								<!-- //btn -->
								</div>
						</fieldset>
					</form>
				</span>
				<!-- //[기업 (판매회원)] 일 경우 인증방식 -->	
				<!-- ===================================================[디자인 없음 2015.12.14]============================================================ -->			
				
			</div>
			<!-- //contents -->
	
		</div>
		<!-- //container --> --%>
</body>
</html>