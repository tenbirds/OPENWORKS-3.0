<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%  
	String sslYn = "";
	String prtcl = "";
	if("Y".equals(Config.getString("global.sslUse"))) {
		sslYn = "Y";
		prtcl = ":443";
	}else{
		sslYn = "N";
	}
	//핸드폰인증 부분 시작
    String SubDomain = CmsUtil.getHostName(request.getServerName());
    NiceID.Check.CPClient niceCheck = new NiceID.Check.CPClient();
    
    String cpsSiteCode = "G7358";                   // NICE로부터 부여받은 사이트 코드
    String sSitePassword = "UM0TNW4SRJ9S";      // NICE로부터 부여받은 사이트 패스워드
    
    String sRequestNumber = "REQ0000000001";            // 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 
                                                        // 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
    sRequestNumber = niceCheck.getRequestNO(cpsSiteCode);
    session.setAttribute("REQ_SEQ" , sRequestNumber);   // 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.
    
    String sAuthType = "";          // 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
    
    String popgubun     = "N";      //Y : 취소버튼 있음 / N : 취소버튼 없음
    String customize    = "";           //없으면 기본 웹페이지 / Mobile : 모바일페이지
    String sReturnUrl = "";    
    String sErrorUrl = "";
    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
    if("Y".equals(Config.getString("global.sslUse"))) {
	    sReturnUrl = "https://"+GlobalConfig.DOMAIN_SUBNM+prtcl+"/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    sErrorUrl = "https://"+GlobalConfig.DOMAIN_SUBNM+prtcl+"/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
    }else{
	    sReturnUrl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/common/checkplus/checkplus_success.do";  // 성공시 이동될 URL
	    sErrorUrl = "http://"+GlobalConfig.DOMAIN_SUBNM+"/common/checkplus/checkplus_fail.do";      // 실패시 이동될 URL
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
    if( iReturn == 0 )
    {
        cpsEncData = niceCheck.getCipherData();
    }
    else if( iReturn == -1)
    {
        sMessage = "암호화 시스템 에러입니다.";
    }    
    else if( iReturn == -2)
    {
        sMessage = "암호화 처리오류입니다.";
    }    
    else if( iReturn == -3)
    {
        sMessage = "암호화 데이터 오류입니다.";
    }    
    else if( iReturn == -9)
    {
        sMessage = "입력 데이터 오류입니다.";
    }    
    else
    {
        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
    }
    //핸드폰인증 부분 끝
    
    
    String hostNm = "";
	hostNm = CmsUtil.getHostName(request.getServerName());
    

	out.println("hostNm : " + hostNm);
%>
<%  //아이핀인증 부분 시작
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
//     String SubDomain = CmsUtil.getHostName(request.getServerName());
    String sReturnURL = "";
    if("Y".equals(Config.getString("global.sslUse"))) {
    	sReturnURL = "https://"+GlobalConfig.DOMAIN_SUBNM+prtcl+"/common/ipin/ipin_process.do";
    }else{
	    sReturnURL = "http://"+GlobalConfig.DOMAIN_SUBNM+"/common/ipin/ipin_process.do";
    }
    String Param3Val = SubDomain+" "+"1";    //결과페이지에서 사용
    
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
    if (iRtn == 0)
    {
    
        // fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
        // 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
        sEncData = pClient.getCipherData();     //암호화 된 데이타
        
        sRtnMsg = "정상 처리되었습니다.";
    
    }
    else if (iRtn == -1 || iRtn == -2)
    {
        sRtnMsg =   "배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<br />" +
                    "귀사 서버환경에 맞는 모듈이 없다면 ..<br /><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
    }
    else if (iRtn == -9)
    {
        sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
    }
    else
    {
        sRtnMsg = "iRtn 값 확인 후, NICE신용평가정보 개발 담당자에게 문의해 주세요.";
    }
    //아이핀인증 부분 끝
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <op:jsTag type="spi" items="form,validate" />
    <script type="text/javascript" src="/resources/web/zipcode/zipcommon.js"></script>
    <!--    ==========================================================    -->
    <!--    한국신용정보주식회사 처리 모듈 (수정 및 변경하지 마십시오)    -->
    <!--    ==========================================================    -->
    <script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
    <script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
    <script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
    
    		<c:if test="${!empty param.userTyCd and param.nationCode eq '410'}">
    		<script type="text/javascript">
            var emailChk = "N";
            $().ready(function(){
                $("#emailForm").validate({
                    rules: {
                        userNm : {required: true, rangelength: [2, 100]}
                       ,email  : {required: true, email: true}
                    }, 
                    submitHandler : function(form){
                        if(emailChk == "Y"){
                            /* 
                            $(form).ajaxSubmit({
                                url : "ND_emailCrtfcAction.do",
                                type : "POST",
                                dataType : "text",
                                success : function(response){
                                    if(response == 'true'){
                                        alert(Message.msg.sendMailSucc);
                                        window.location.replace("BD_join.do");
                                    }else if(response == '999') {
                                        alert(Message.msg.dupEmailCrtfc);
                                        window.location.replace("/korean/pt/index.do");
                                    } else {
                                        alert(Message.msg.sendMailFail);
                                    }
                                }
                            });
                            */
                            $("#emailForm").ajaxSubmit({
                            	url		: "DummyGet.do",
                            	type	: "POST",
                            	async	: false,
                            	success	: function (response) {
                            	    if(response == "true"){
                            	        $(form).ajaxSubmit({
                                            url : "ND_emailCrtfcAction.do",
                                            type : "POST",
                                            dataType : "text",
                                            response : "true",
                                            success : function(response){
                                                if(response == 'true'){
                                                    alert(Message.msg.sendMailSucc);
                                                    window.location.replace("BD_join.do");
                                                }else if(response == '999') {
                                                    alert(Message.msg.dupEmailCrtfc);
                                                    //window.location.replace("/korean/pt/index.do");
                                                    return;
                                                } else {
                                                    alert(Message.msg.sendMailFail);
                                                }
                                            }
                                        });
                            	     }
                            	}
                            });
                        }else{
                            alert(Message.msg.checkDupEmail);
                            $("#emailChk").focus();
                            return false;
                        }
                    }
                }); 
            });
            var jsEmailCrtfc = function(){
                $("#emailForm").submit();
            };
            var jsReset = function(){
                emailChk = "N";
            };
            var idCheck = function(){
                if($("#userNm").val() == ''){
                    alert(Message.msg.emptyUserNm);
                    $("#userNm").focus();
                    return false;
                }
                if($("#email").val() == ''){
                    alert(Message.msg.emptyEmail);
                    $('#email').focus();
                    return false;
                }
        		<c:if test="${param.userTyCd == '3001'}">
/*                 if(!/(korea|\.ac|\.or|\.go)\.kr$/.test($("#email").val())){
                    alert('공공기관 전용 이메일을 입력하여주십시오.');
                    $('#email').focus();
                    return false;
                }
 */                </c:if>
                /* 
                $("#emailForm").ajaxSubmit({
                    url      : "ND_emailDupleCheck.do",
                    type     : "POST",
                    async    : false,
                    success  : function (response) {
                        if(response == 'true'){
                            emailChk = "Y";
                            alert(Message.msg.availableEmail);
                        }else if(response == 'duple') {
                            alert(Message.msg.dupEmail);
                            $('#email').focus();
                        }else {
                            alert(Message.msg.email);
                        }
                    }
                });
                */
                //ajax가 한번에 응답하지 않는 문제해결을 위해 아래로 변경 : KS : 2016-08-18
                //get방식으로 호출 후 Post로 전송
                $("#emailForm").ajaxSubmit({
                	url		: "DummyGet.do",
                	type	: "POST",
                	async	: false,
                	success	: function (response) {
                	    if(response == "true"){
                	        $("#emailForm").ajaxSubmit({
			                  	url      : "ND_emailDupleCheck.do",
			                    type     : "POST",
			                    async    : false,
			                    success  : function (response) {
			                    	if(response == 'true'){
			                        	emailChk = "Y";
			                            alert(Message.msg.availableEmail);
			                        }else if(response == 'duple') {
			                        	alert(Message.msg.dupEmail);
			                            $('#email').focus();
			                        }else {
			                        	alert(Message.msg.email);
			                        }
			                    }
			            	});
                	    }
                	}
                });
            };
        </script>
        </c:if>
        <%-- <c:if test="${(param.userTyCd eq '1002' || (empty param.userTyCd && sessionScope['__usk'].userTyCd == 1001)) && param.nationCode eq '410'}">
        <script type="text/javascript">
        window.name = "Parent_window";
        //아이핀 인증
        function jsPopup(){
            window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_ipin.target = "popupIPIN2";
            document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
            document.form_ipin.submit();
        }

        //휴대폰인증
        function cpPopup(){
            window.open('', 'popupChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
            document.form_chk.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
            document.form_chk.target = "popupChk";
            document.form_chk.submit();
        }

        var setChildValue = function(encData, rtnMsg, userTyCd, nationCode, param3){
            var param3Arr = "";
            if(param3 != ""){
                param3Arr = param3.split(' ');
                //alert(param3Arr[1]);
                if(param3Arr[1] == '1'){    //회원가입
                    if(rtnMsg != "") {
                        alert(rtnMsg);
                    }
                    document.user.sbscrbTyCd.value = "1001";
                    document.user.encData.value = encData;
                    document.user.userTyCd.value = userTyCd;
                    document.user.nationCode.value = nationCode;
                    document.user.action = "/"+param3Arr[0]+"/pt/register/BD_index.do";
                }else if(param3Arr[1] == '2'){
                    document.user.action = "/"+param3Arr[0]+"/pt/login/user/BD_findId3.do";
                }else{
                    document.user.action = "/"+param3Arr[0]+"/pt/login/user/BD_findPwd3.do";
                }
                document.user.submit();
            }
        };
        </script>
        </c:if> --%>
        <c:if test="${empty param.userTyCd and param.nationCode eq '410'}">
        <script type="text/javascript">
            document.onkeydown = onKeyDown;
    
            function onKeyDown(e){
                /* var e = event; */
                /* if(event == null) e = window.event; */

                if(e.keyCode == 13) return jsValidateBizrno('Y');
            }
    
            /* function loadAction(){
                document.bizForm.bizNo.focus();
            } */

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
                    //var form = document.inputForm;
                    var strNm = $("#bizNm").val();
                    var strNo = $("#bizNo").val(); // 10 바이트로 합쳐진다.
                    var strRsn = $("#inqRsn").val(); // 10 
                    var strInfoFlag = "2";    //2:사업자번호,3:법인번호
                	
                    var strDom = '<c:out value="${SubDomain}" />';
//                	alert("strDom : " + strDom);
                	
                    document.inputForm.SendInfo.value = makeBizSendInfo(strNo, strNm, strRsn, strInfoFlag); // nice (https://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js) 회원사 서버에 전송할 기업 정보를 암호화하여 반환한다.
                    <% if("Y".equals(Config.getString("global.sslUse"))) { %>
                    
                    
                    
//                    	  document.inputForm.action = "https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/common/bizrno/rnCheckRequest.do";
                    	  document.inputForm.action = "/common/bizrno/rnCheckRequest.do";
                    <% }else{ %>
//                    alert(">>>>>>>>>>>>>> : " + $("#bizNo").val());
//                    	  document.inputForm.action = "https://<%=GlobalConfig.DOMAIN_SUBNM %>:443/common/bizrno/rnCheckRequest.do";
                    	  document.inputForm.action = "/common/bizrno/rnCheckRequest.do";
                    <% } %>
                    document.inputForm.submit();
                }
                return;
            }

            var bizrnoChk = "N"; 
            var jsValidateBizrno = function(yn){
                if($("#bizNm").val() == ''){
                    alert(Message.msg.emptyCmpnyNm);
                    $("#bizNm").focus();
                    return false;
                }else
                if($("#bizNm1").val() == ''){
                    alert(Message.msg.emptyBizno);
                    $("#bizNm1").focus();
                    return false;
                }else
                if($("#bizNm2").val() == ''){
                    alert(Message.msg.emptyBizno);
                    $("#bizNm2").focus();
                    return false;
                }else
                if($("#bizNm3").val() == ''){
                    alert(Message.msg.emptyBizno);
                    $("#bizNm3").focus();
                    return false;
                }
                
                if(isValidBusNum(bizForm.bizNm1,bizForm.bizNm2,bizForm.bizNm3) == true){ 
                    $("#cmpnyRprsntvNm").val($("#bizNm").val());
					//$("#bizrno").val($("#bizNm1").val()+"-"+$("#bizNm2").val()+"-"+$("#bizNm3").val());
					$("#bizNo").val($("#bizNm1").val()+$("#bizNm2").val()+$("#bizNm3").val());
					$("#bizName").val($("#bizNm").val());					
					
                    if(bizrnoChk == "N" && yn == "Y"){
                        alert(Message.msg.dupChk);
                        $("#bizrnoChk").focus();
                        return false;
                    }
                    $("#bizForm").ajaxSubmit({
                        url      : "ND_checkDupleBizrno.do",
                        type     : "POST",
                        async    : false,
                        success  : function (response) {
                            if(response == 'true'){
                                if(yn == 'Y'){
                                    goIDCheck();
                                } else if(yn == 'N'){
                                    bizrnoChk = "Y";
                                    alert(Message.msg.biznoAvailable);
                                }
                            }else{
                                alert(Message.msg.bizrnoAlready);
                                $('#bizrno1').focus();
                            }
                        }
                    });
                } else{
                    //alert("사업자 등록번호가 유효하지 않습니다.");
                    $("#bizNm1").focus();
                    return false;
                } 
            	
            };
            
            //사업자번호 유효성 체크
            function isValidBusNum(obj1,obj2,obj3){
                if(obj1.value+''+obj2.value+''+obj3.value != ''){
                    if (obj1.value+''+obj2.value+''+obj3.value == '0000000000'){
                        alert(Message.msg.bizNoIncorrect);
                        obj1.focus(); 
                        return false; 
                    }
            
                    if(BizCheck(obj1,obj2,obj3) == false) { 
                        alert(Message.msg.bizNoIncorrect); 
                        obj1.focus(); 
                        return false;
                    }else{ 
                        return true; 
                    } 
                }else{
                    return true;
                }   
            }
            
            //사업자 등록번호 체크 
            function BizCheck(obj1, obj2, obj3){
            	
                biz_value = new Array(10); 
                
                // debugger; // 자바스크립트 디버깅시 유용
                
                var objstring = obj1.value +"-"+ obj2.value +"-"+ obj3.value; 
                var li_temp, li_lastid; 
                
                if ( objstring.length == 12 ) { 
                    biz_value[0] = ( parseFloat(objstring.substring(0 ,1)) * 1 ) % 10; 
                    biz_value[1] = ( parseFloat(objstring.substring(1 ,2)) * 3 ) % 10; 
                    biz_value[2] = ( parseFloat(objstring.substring(2 ,3)) * 7 ) % 10; 
                    biz_value[3] = ( parseFloat(objstring.substring(4 ,5)) * 1 ) % 10; 
                    biz_value[4] = ( parseFloat(objstring.substring(5 ,6)) * 3 ) % 10; 
                    biz_value[5] = ( parseFloat(objstring.substring(7 ,8)) * 7 ) % 10; 
                    biz_value[6] = ( parseFloat(objstring.substring(8 ,9)) * 1 ) % 10; 
                    biz_value[7] = ( parseFloat(objstring.substring(9,10)) * 3 ) % 10; 
                    li_temp = parseFloat(objstring.substring(10,11)) * 5 + "0"; 
                    biz_value[8] = parseFloat(li_temp.substring(0,1)) + parseFloat(li_temp.substring(1,2)); 
                    biz_value[9] = parseFloat(objstring.substring(11,12)); 
                    li_lastid = (10 - ( ( biz_value[0] + biz_value[1] + biz_value[2] + biz_value[3] + biz_value[4] + biz_value[5] + biz_value[6] + biz_value[7] + biz_value[8] ) % 10 ) ) % 10; 
                    if (biz_value[9] != li_lastid) { 
                        obj1.focus(); 
                        obj1.select(); 
                        return false;
                    } else {
                        return true; 
                    }
                } else {
                    obj1.focus();
                    obj1.select();
                    return false;
                } 
            }
            
            // 숫자만 입력하도록 체크
    		function jsOnlyNumber(event){
    			 var keyID = (event.which) ? event.which : event.keyCode;
        		  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
    			else return false;
    		}
         	
    		// 숫자만 입력하도록 체크2
    		function removeChar(event) {
    			event = event || window.event;
    			 var keyID = (event.which) ? event.which : event.keyCode;
    			  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
    			else event.target.value = event.target.value.replace(/[^0-9]/g, "");
    		}
				    
        </script>
        </c:if>
</head>
<body>
<!-- 일반 이용자 가입 -->
<c:if test="${param.userTyCd eq '1001' and param.nationCode eq '410'}">
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/join_step_1.png" alt="인증" />
			<h2>일반 회원가입</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	<form id="emailForm" name="emailForm" onsubmit="return false;">
	<input type="hidden" name="userTyCd" value="<c:out value="${param.userTyCd}" />" />
  <input type="hidden" name="nationCode" value="<c:out value='${param.nationCode}' />" />
	<div class="conWrap join">
		<h3 class="fcol_1">
			<i class="quot">고객님의 개인정보 보호를 위해 <br />이메일 인증을 거쳐 회원가입을 진행합니다.
			</i>
		</h3>
		<p>
			이메일 주소를 입력 후 이메일 인증 보내기를 클릭합니다.<br />
			<i>받은 이메일에 인증 완료 + 회원 가입하기를 클릭</i>하면 회원 가입 다음 단계로 이동합니다.
		</p>
		
		<div class="certi">		
			<table class="tbl_st4">
				<tr>
					<th>이름</th>
					<td><input type="text" tabindex="1" id="userNm" name="userNm" autofocus="autofocus"/></td>
					<td rowspan="2"><input type="submit" tabindex="3" id="emailChk" onclick="idCheck();return false;" value="중복 가입 확인" /></td>
				</tr>
				<tr>
					<th>인증 받을 이메일 주소</th>
					<td><input type="text" tabindex="2" id="email" name="email" value="" onchange="jsReset();" /></td>
				</tr>			
			</table>
			
			<div class="btnArea rig">
				<a href="#none" tabindex="4" onclick="jsEmailCrtfc();return false;" class="btns st1 icn icnEmail">이메일로 인증 보내기</a>
			</div>
		</div>
	</div>
	</form>
</c:if>
<!--// content -->

<!-- 공공기관 이용자 가입 -->
<c:if test="${param.userTyCd eq '3001' and param.nationCode eq '410'}">
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/join_step_1.png" alt="인증" />
			<h2>공공기관 회원가입</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<form id="emailForm" name="emailForm" onsubmit="return false;">
	<input type="hidden" name="userTyCd" value="<c:out value="${param.userTyCd}" />" />
  <input type="hidden" name="nationCode" value="<c:out value='${param.nationCode}' />" />
	<div class="conWrap join public">
		<h3 class="fcol_1">
			<i class="quot">고객님의 개인정보 보호를 위해 <br />이메일 인증을 거쳐 회원가입을 진행합니다.
			</i>
		</h3>
		<p>
			이메일 주소를 입력 후 이메일 인증 보내기를 클릭합니다.<br />
			<i>받은 이메일에 인증 완료 + 회원 가입하기를 클릭</i>하면 회원 가입 다음 단계로 이동합니다.
		</p>		
		
		<div class="certi">
			<p class="info">※ 소속 공공 기관 이메일로 만 인증이 가능합니다.</p>		
			<table class="tbl_st4">
				<tr>
					<th>이름</th>
					<td><input type="text" id="userNm" name="userNm" tabindex="1" autofocus="autofocus" /></td>
					<td rowspan="2"><input type="submit" id="emailChk" tabindex="3" onclick="idCheck();return false;" value="중복 가입 확인" /></td>
				</tr>
				<tr>
					<th>인증 받을 이메일 주소</th>
					<td><input type="text" id="email" name="email" value="" tabindex="2" onchange="jsReset();" tabindex="1"/></td>
				</tr>			
			</table>
			
			<div class="btnArea rig">
				<a href="#none" tabindex="4" onclick="jsEmailCrtfc();return false;" class="btns st1 icn icnEmail" >이메일로 인증 보내기</a>
			</div>
		</div>
	</div>
	<!--// content -->
	</form>
</c:if>

<!-- 제공자 권한 신청 -->
<c:if test="${empty param.userTyCd and param.nationCode eq '410' }">
		<form id="inputForm" name="inputForm" method="POST">
			<input type="hidden" id="SendInfo" name="SendInfo" />
			<input type="hidden" name="userTyCd" value="${param.userTyCd}" />
			<input type="hidden" name="nationCode" value="${param.nationCode}" />
			<input type="hidden" id="bizNo" name="bizNo" />	
			<input type="hidden" id="bizName" name="bizName" />			
		</form>
		<form id="bizForm" name="bizForm" method="post" onsubmit="return false;">
			<input type="hidden" id="inqRsn" name="inqRsn" value="10">
			<input type="hidden" id="bizNo" name="bizNo" />
		
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/offer_step_1.png" alt="구비서류 확인" />
			<h2>제공(판매) 권한 신청</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap offer docConfirm">
		<h4>제공자 권한 승인 절차</h4>
		<ol>
			<li>1. 가입 승인을 위한 구비서류를 정보입력 스텝에서 파일로 업로드</li>
			<li>2. 구비서류 업로드 후 서명 날인을 대체하여 기업공인인증서 인증</li>
			<li>3. 한국정보화진흥원에서 첨부 서류 확인 및 승인</li>
			<li>4. 승인 완료 메일 수신 이후 제공자 권한으로 서비스 정상 이용 가능(첨부파일 업로드후 영업일 기준 최대 48시간 이내 승인)</li>
		</ol>
		<img src="/cloud_ver2/new_cloud/images/img_offer_preDoc.png" alt="" />
		<p>※ 구비서류를 PDF파일로 준비하여 정보입력시 업로드 해 주세요.</p>
		
		<table class="tbl_st4">
			<tr>
				<th rowspan="6">구비서류</th>
				<td>
					<i>(필수)</i> 협약서 1부 (제공자 협약서.pdf 파일을 다운로드 하여 작성)(간인필수)
					<%--http://www.ceart.kr/component/file/ND_fileDownload.do?id=0a25b492-4fb1-409e-9872-b8746b309a6e --%>
					<a href="/resources/download/Agreement2.hwp" class="btns st3">협약서 양식 다운로드</a>
				</td>
			</tr>
			<tr>			
				<td><i>(필수)</i> 등기부등본 1부(법인등기부등본)</td>
			</tr>
			<tr>			
				<td><i>(필수)</i> 신용평가서 1부</td>
			</tr>
			<tr>			
				<td><i>(필수)</i> 재무제표 1부(최근3년간)</td>
			</tr>
			<tr>			
				<td>(선택) 벤처기업인증서 1부</td>
			</tr>
			<tr>			
				<td>(선택) 직접생산증명서 1부</td>
			</tr>
		</table>
		
		<h4>중복가입 여부 확인</h4>
			<table class="tbl_st4">
				<tr>
					<th>상호(가입명)</th>
					<td><input type="text" id="bizNm" name="bizNm" autofocus="autofocus" tabindex="1"/></td>
					<td rowspan="2"><input type="submit" id="bizrnoChk" onclick="jsValidateBizrno('N');" value="중복 가입 확인" style="width:80px" tabindex="5"/></td>
				</tr>
				<tr>
					<th>사업자등록번호</th>
					<td>
						<input type="text" id="bizNm1" name="bizNm1" maxlength="3" tabindex="2" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" id="bizNm2" name="bizNm2" maxlength="2" tabindex="3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
						<input type="text" id="bizNm3" name="bizNm3" maxlength="5" tabindex="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
					</td>
				</tr>			
			</table>
			
			<ul>
				<li>타인의 정보를 부정하게 사용하는 경우 관계법령에 따라 처벌받을 수 있습니다.</li>
				<li>실명인증이 되지 않는 경우 아래의 실명인증기관에 실명등록을 요청할 수 있습니다.</li>
				<li><i>나이스신용평가정보</i> 1588-2486</li>
			</ul>
			
			<div class="btnArea rig">
				<a href="/korean/pt/index.do" class="btns st2" tabindex="7">취소</a>
				<a href="#" onclick="jsValidateBizrno('Y');return false;" class="btns st1 icn_r next" tabindex="6">다음</a>				
			</div>
	</div>
	<!--// content -->
		</form> 
		</c:if>
	</body>
</html>
