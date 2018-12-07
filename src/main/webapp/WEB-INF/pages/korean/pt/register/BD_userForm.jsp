<%@page import="zes.core.lang.Validate"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page language="java" import="Kisinfo.Check.IPINClient" %>

<%
String sResponseData = ""; // 암호화된 인증데이터
String sSiteCode = "";     // 사이트 코드
String sSitePw = "" ;      // 사이트 패스워드
String sDupInfo = "";      // 중복가입 확인값
String sRequestNumber = "";// 요청 번호
String sName = "";         // 성명
String sPlainData = "";    //

if(Validate.isNotEmpty(request.getParameter("enc_data"))) {
    //아이핀 복호화 시작
    sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");
    sSiteCode     = "K517";
    sSitePw       = "57168249";
    IPINClient pClient = new IPINClient();
    int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData);

    sName = pClient.getName();
    sDupInfo = pClient.getDupInfo();
} else if(Validate.isNotEmpty(request.getParameter("encData"))) {
    //SMS 복호화 시작
    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

    sResponseData = requestReplace(request.getParameter("encData"), "encodeData");
    sSiteCode     = "G7358";
    sSitePw       = "UM0TNW4SRJ9S";

    int iReturn = niceCheck.fnDecode(sSiteCode, sSitePw, sResponseData);

    if( iReturn == 0 ) {
        sPlainData = niceCheck.getPlainData();

        // 데이타를 추출합니다.
        java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
        sName           = (String)mapresult.get("NAME");
        sDupInfo        = (String)mapresult.get("DI");
    }
}
%>
<%!
public static String requestReplace (String paramValue, String gubun) {
        String result = "";

        if (paramValue != null) {

            paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

            paramValue = paramValue.replaceAll("\\*", "");
            paramValue = paramValue.replaceAll("\\?", "");
            paramValue = paramValue.replaceAll("\\[", "");
            paramValue = paramValue.replaceAll("\\{", "");
            paramValue = paramValue.replaceAll("\\(", "");
            paramValue = paramValue.replaceAll("\\)", "");
            paramValue = paramValue.replaceAll("\\^", "");
            paramValue = paramValue.replaceAll("\\$", "");
            paramValue = paramValue.replaceAll("'", "");
            paramValue = paramValue.replaceAll("@", "");
            paramValue = paramValue.replaceAll("%", "");
            paramValue = paramValue.replaceAll(";", "");
            paramValue = paramValue.replaceAll(":", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll("#", "");
            paramValue = paramValue.replaceAll("--", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll(",", "");

            if(gubun != "encodeData"){
                paramValue = paramValue.replaceAll("\\+", "");
                paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
            }

            result = paramValue;

        }
        return result;
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원 가입</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript" src="/resources/openworks/login/js/validationOfPassword.js"></script>
<c:if test="${fn:startsWith(param.userTyCd,'10') || fn:startsWith(param.userTyCd,'20')}">
<script type="text/javascript">
    var idChk = "N"; <%-- 아이디 중복확인 체크용 --%>
    var emailChk = "N"; <%-- 이메일 중복확인 체크용 --%>
    $().ready(function(){
        $("#dataForm").validate({
            ignore: "",
            rules: {
             telno1            : { /*required: true,*/ number: true}
            ,telno2            : { /*required: true,*/ number: true}
            ,telno3            : { /*required: true,*/ number: true}
            ,intrlTelno        : { /*required: true,*/ maxlength: 6}
            ,lxtnTelno         : { number: true}
            ,userId            : { required: true, nowhitespace: true, rangelength: [5, 15], remote: "ND_checkDupleId.do" }
            ,userNm            : { required: true}
            ,nationCode        : { required: true}
            ,userPassword      : { required: true, rangelength: [10, 16] }
            ,userPassword2     : { required: true, equalTo: "#userPassword" }
            ,sexdstnCd         : { required: true}
            ,brthdy            : { required: true, formatDate: true}
            ,mbtlnum1          : { number: true, required: true}
            ,mbtlnum2          : { number: true, required: true}
            ,mbtlnum3          : { number: true, required: true}
            ,email             : { email2: true, required: true}
            ,email1            : { required: true}
            ,email2            : { required: true/* , remote: "ND_emailDupleCheck.do" */}
            ,zip1              : { number: true/*, required: true*/}
            ,zip2              : { number: true/*, required: true*/}
            <c:if test="${userSetYn.cmpnyNm == 1003}">
            ,cmpnyNm           : { required: true}
            </c:if>
            <c:if test="${userSetYn.cmpnyRprsntvNm == 1003}">
            ,cmpnyRprsntvNm    : { required: true}
            </c:if>
            ,bizrno2           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
            ,bizrno3           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
            ,cmpnyTelno1       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyTelno2       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyTelno3       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyLxtnTelno    : { number: true}
            ,cmpnyReprsntTelno1: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyReprsntTelno2: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyReprsntTelno3: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
            ,cmpnyFaxnum1      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
            ,cmpnyFaxnum2      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
            ,cmpnyFaxnum3      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
            ,cmpnyEmail        : { email2: true}
            <c:if test="${userSetYn.cmpnyEmail == 1003}">
            ,cmpnyEmail1       : { required: true}
            ,cmpnyEmail2       : { required: true}
            </c:if>
            ,cmpnyUrl          : { url: true${userSetYn.cmpnyUrl == 1003 ? ', required: true' : ''}}
            ,cmpnyZip1         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
            ,cmpnyZip2         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
            <c:if test="${userSetYn.cmpnyBassAdres == 1003}">
            ,cmpnyBassAdres    : { required: true}
            </c:if>
            <c:if test="${userSetYn.cmpnyDetailAdres == 1003}">
            ,cmpnyDetailAdres  : { required: true}
            </c:if>
            <c:if test="${fn:endsWith(param.userTyCd, '02')}">
            ,reprsntEmails    : { email2: true}
            ,langStoreNms     : { rangelength: [2, 60]}
            ,langStoreIntrcns : { maxlength : 1000}
            ,storeChargerNms  : { maxlength : 100}
            ,reprsntTelnos1   : { number : true}
            ,reprsntTelnos2   : { number : true}
            ,reprsntTelnos3   : { number : true}
            ,reprsntEmails    : { email2: true}
            ,storeUrls        : { url : true}
            </c:if>
            },
            messages : {
                 userId        : { remote : Message.msg.idNotAvailable}
                ,email2        : { remote : Message.msg.availableEmail}
                ,brthdy        : { formatDate : Message.msg.formatDate}
                ,email         : { email2: "이메일 형식으로 입력해주세요."}
                ,cmpnyEmail    : { email2: "기업이메일을 이메일 형식으로 입력해주세요."}
                ,reprsntEmails : { email2: "다국어 판매정보의 이메일을 이메일 형식으로 입력해주세요."}
            },
            submitHandler : function(form){
                <c:if test="${fn:endsWith(param.userTyCd, '02')}">
                if(${param.userTyCd} == '1002' || ${param.userTyCd} == '2002' || ${empty param.userTyCd}){
                    if($("input[name='storeLangCodes']:checked").length > 0){
                        affected = 'Y'; <%-- 다국어판매정보 회사 체크용 --%>
                        //모든테이블을 비활성
                        $("#storeInfo *").attr("disabled",true);
                        $("input[name=storeLangCodes]:checked").each(function(i) {
                            //선택된 테이블만 활성
                            $(".store"+$(this).val()+" *").attr("disabled",false);
                            <c:if test="${storeSetYn.langStoreNm == 1003}">
                            if($("#langStoreNms"+$(this).val()).val().length < 2){
                                alert(Message.msg.storeNmEmpty);
                                $("#langStoreNms"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }
                            </c:if>
                            <c:if test="${storeSetYn.langStoreIntrcn == 1003}">
                            if($("#langStoreIntrcns"+$(this).val()).val() == ''){
                                alert(Message.msg.sotreIntrcnEmpty);
                                $("#langStoreIntrcns"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }
                            </c:if>
                            <c:if test="${storeSetYn.storeChargerNm == 1003}">
                            if($("#storeChargeNms"+$(this).val()).val() == ''){
                                alert(Message.msg.storeChargeNmEmpty);
                                $("#storeChargerNms"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }
                            </c:if>
                            <c:if test="${storeSetYn.reprsntTelno == 1003}">
                            if($("#reprsntTelnos1"+$(this).val()).val() == '' || $("#reprsntTelnos2"+$(this).val()).val() == '' || $("#reprsntTelnos3"+$(this).val()).val() == ''){
                                alert(Message.msg.telnoEmpty);
                                $("#reprsntTelnos1"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }
                            </c:if>
                            <c:if test="${storeSetYn.reprsntEmail == 1003}">
                            if($("#reprsntEmails1"+$(this).val()).val() == '' || $("#reprsntEmails2"+$(this).val()).val() == ''){
                                alert(Message.msg.emptyEmail);
                                $("#reprsntEmails1"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }else{
                                //if($("#reprsntEmails1"+$(this).val()).val() != '' && $("#reprsntEmails2"+$(this).val()).val() != ''){
                                $("#reprsntEmails"+$(this).val()).val($("#reprsntEmails1"+$(this).val()).val()+"@"+$("#reprsntEmails2"+$(this).val()).val());
                                //}
                                if($.trim($("#reprsntEmails"+$(this).val()).val()) != ''){
                                    var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                                    if(!emailExp.test($("#reprsntEmails"+$(this).val()).val())){
                                        alert(Message.msg.validEmail);
                                        $("#reprsntEmails1"+$(this).val()).focus();
                                        return false;
                                    }
                                }
                            }
                            </c:if>
                            <c:if test="${storeSetYn.storeUrl == 1003}">
                            if($("#storeUrls"+$(this).val()).val() == ''){
                                alert(Message.msg.storeUrlEmpty);
                                $("#storeUrls"+$(this).val()).focus();
                                affected = 'N';
                                return false;
                            }
                            </c:if>
                            if($("input[name='storeChk"+$(this).val()+"']").val() == 'N') {
                                $("#storeChk"+$(this).val()).focus();
                                alert(Message.msg.storeNmDupChk);
                                affected = 'N';
                                return false;
                            }
                            if($("#reprsntTelnos1"+$(this).val()).val() != '' && $("#reprsntTelnos2"+$(this).val()).val() != '' && $("#reprsntTelnos3"+$(this).val()).val() != ''){
                                $("#reprsntTelnos"+$(this).val()).val($("#reprsntTelnos1"+$(this).val()).val()+"-"+$("#reprsntTelnos2"+$(this).val()).val()+"-"+$("#reprsntTelnos3"+$(this).val()).val());
                            }
                            if($("#reprsntEmails1"+$(this).val()).val() != '' && $("#reprsntEmails2"+$(this).val()).val() != ''){
                                $("#reprsntEmails"+$(this).val()).val($("#reprsntEmails1"+$(this).val()).val()+"@"+$("#reprsntEmails2"+$(this).val()).val());
                            }
                        });
                        if(affected == 'N'){
                            //검증 실패시 모든테이블을 활성
                            $("#storeInfo *").attr("disabled",false);
                            return false;
                        }
                    } else {
                        $("#00").focus();
                        alert(Message.msg.storeChoice);
                        return;
                    }
                }
                </c:if>
                if($("#telno1").val() != '' && $("#telno2").val() != '' && $("#telno3").val() != ''){
                    $("#telno").val($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val());
                }
                if($("#mbtlnum1").val() != '' && $("#mbtlnum2").val() != '' && $("#mbtlnum3").val() != ''){
                    $("#mbtlnum").val($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val());
                }
                if($("#zip1").val() != '' && $("#zip2").val() != '' ){
                    $("#zip").val($("#zip1").val()+"-"+$("#zip2").val());
                }
                if($("#bizrno1").val() != '' && $("#bizrno2").val() != '' && $("#bizrno3").val() != ''){
                    $("#bizrno").val($("#bizrno1").val()+"-"+$("#bizrno2").val()+"-"+$("#bizrno3").val());
                }
                if($("#cmpnyTelno1").val() != '' && $("#cmpnyTelno2").val() != '' && $("#cmpnyTelno3").val() != ''){
                    $("#cmpnyTelno").val($("#cmpnyTelno1").val()+"-"+$("#cmpnyTelno2").val()+"-"+$("#cmpnyTelno3").val());
                }
                if($("#cmpnyReprsntTelno1").val() != '' && $("#cmpnyReprsntTelno2").val() != '' && $("#cmpnyReprsntTelno3").val() != ''){
                    $("#cmpnyReprsntTelno").val($("#cmpnyReprsntTelno1").val()+"-"+$("#cmpnyReprsntTelno2").val()+"-"+$("#cmpnyReprsntTelno3").val());
                }
                if($("#cmpnyFaxnum1").val() != '' && $("#cmpnyFaxnum2").val() != '' && $("#cmpnyFaxnum3").val() != ''){
                    $("#cmpnyFaxnum").val($("#cmpnyFaxnum1").val()+"-"+$("#cmpnyFaxnum2").val()+"-"+$("#cmpnyFaxnum3").val());
                }
                if($("#cmpnyEmail1").val() != '' && $("#cmpnyEmail2").val() != ''){
                    $("#cmpnyEmail").val($("#cmpnyEmail1").val()+"@"+$("#cmpnyEmail2").val());
                }
                if($("#cmpnyZip1").val() != '' && $("#cmpnyZip2").val() != ''){
                    $("#cmpnyZip").val($("#cmpnyZip1").val()+"-"+$("#cmpnyZip2").val());
                } else if($("#cmpnyZip1").val() != '' && $("#cmpnyZip2").val() == ''){
                    $("#cmpnyZip").val($("#cmpnyZip1").val());
                }

                $("input[name=storeLangCodes]:checked").each(function(i) {
                    $("#langStoreNms"+$(this).val()).val($("#langStoreNms"+$(this).val()).val().replace(/, /g, "，").replace(/,/g, "，"));
                });
                $("input[name=storeLangCodes]:checked").each(function(i) {
                    $("#langStoreIntrcns"+$(this).val()).val($("#langStoreIntrcns"+$(this).val()).val().replace(/, /g, "，").replace(/,/g, "，"));
                });
                $(form).ajaxSubmit({
                    url      : "ND_checkDupleBizrno.do",
                    type     : "POST",
                    dataType : "text",
                    success  : function(response) {
                         if (response) {
                             $(form).ajaxSubmit({
                                 url      : "ND_insertAction.do",
                                 type     : "POST",
                                 dataType : "text",
                                 success  : function(response) {
                                     try {
                                         if(eval(response)) {
                                             self.location.href = "BD_complete.do";
                                         } else {
                                             if(response == 888){
                                                 emailChk == "N";
                                             }
                                             alert(Message.msg.processFail);
                                         }
                                     } catch (e) {
                                         alert(response, e);
                                         return;
                                     }
                                 }
                              });
                         }else{
                             $("#bizrno1").focus();
                             alert(Message.msg.bizrnoAlready);
                         }
                    }
                });
            }
        });
        <c:forEach items="${langList}" var="list">
        $(".${list.LANGCD}").click(function(){
            if($(".store${list.LANGCD}").is(":visible") == true){
                $(".store${list.LANGCD}").hide();
                $("#store${list.LANGCD}").removeClass('on');
                $("input[id='${list.LANGCD}']").prop("checked", false);
            } else {
                $(".store${list.LANGCD}").show();
                $("#store${list.LANGCD}").addClass('on');
                $("input[id='${list.LANGCD}']").prop("checked", true);
            }
            <c:if test="${param.userTyCd eq '2002'}">
            if($("#cmpnyNm").val() != '') {
                $("input[name='langStoreNms']").val($("#cmpnyNm").val());
            }
            </c:if>
            <c:if test="${param.userTyCd eq '1002'}">
            if($("#userNm").val() != '') {
                $("input[name='langStoreNms']").val($("#userNm").val());
            }
            </c:if>
        });
        //회사정보 동일 정보적용 체크박스 액션
        $("#sameUser${list.LANGENGABRV}").click(function(){
            $("#storeChargerNms${list.LANGCD}").val($("#userNm").val());
            $("#reprsntTelnos1${list.LANGCD}").val($("#telno1").val());
            $("#reprsntTelnos2${list.LANGCD}").val($("#telno2").val());
            $("#reprsntTelnos3${list.LANGCD}").val($("#telno3").val());
            $("#reprsntEmails1${list.LANGCD}").val($("#email1").val());
            $("#reprsntEmails2${list.LANGCD}").val($("#email2").val());
        });
        </c:forEach>
        $("#00").trigger("click");
        $("#delete").click(function(){
            $(".no-img").html("<img src='/new_cloud/images/sub/img-logo-noimg.jpg' alt='회사 로고 이미지' />");
            $("#multiFiles").empty();
            var control = $("#multiFiles");
            control.replaceWith( control = control.clone( true ) );
            /* $("#storeImgNm").empty(); */
        });
        userNation();
        <c:if test="${(param.userTyCd eq '2002' || (empty param.userTyCd && sessionScope['__usk'].userTyCd == 2001)) && param.nationCode eq '410'}"><%-- 사업자 인증 후 --%>
        $("#cmpnyNm").val("<%=session.getAttribute("bizNm")%>").attr("readonly", true);
        var bizrno = '<%=session.getAttribute("bizNo")%>';
        $("#bizrno1").val(bizrno.substring(0,3)).attr("readonly", true);
        $("#bizrno2").val(bizrno.substring(3,5)).attr("readonly", true);
        $("#bizrno3").val(bizrno.substring(5,10)).attr("readonly", true);
        </c:if>
        <c:if test="${param.userTyCd eq '1002' && param.nationCode eq '410'}"><%-- sms인증 & 아이핀 인증 후 --%>
        $("#userNm").val("<%=sName%>").attr("readonly", true);
        </c:if>
        <c:if test="${param.sbscrbTyCd eq '1003'}"><%-- 이메일 인증 후 --%>
        emailChk = "Y";
        $("#userNm").val("${param.userNm}").attr("readonly", true);
        $("#email").val("${param.email}").attr("readonly", true);
        </c:if>
        $("#userId").css("ime-mode","disabled");
        $(".intrlTelno").change(function(){
            $(".intrlTelno").val($(this).val());
        });
        
    });//ready end

    
    //이메일 수신동의, 수신거부에 따른 상태값저장
    var emailRecptnAgreIng = function(val1,val2) {
		
    	alert(val1);
    	alert(val2);
    	
		var url = "ND_useYnUpdateState.do";
		$.post(url,
		    { emailRecptnAgreCd : val1, gubun : val2},
		    function(result){
		        if(result == 1){
		            $(element).parent().remove();
		
		            //self.location.reload();
		
		        }else{
		            alert('이메일 수신동의를 저장하지 못하였습니다.');
		        }
		    }, 'json');
	}

    
    
    
    var jsSubmit = function() { <%-- 저장액션 --%>    
        if(idChk == "Y"){
            if(pwdUseYn()){
                $("#dataForm").ajaxSubmit({
                	url		: "DummyGet.do",
                	type	: "GET",
                	async	: false,
                	success	: function (response) {
            		    $("#dataForm").submit();
                	 }
                });
            }
        } else if(idChk == "N"){
            alert(Message.msg.checkDupID);
            $("#idChk").focus();
            return false;
        }
    };

    var jsEmailList = function(status) {
        if($("select[name='"+status+"List'] option:selected").val() != ''){
             $("#"+status+"2").val($("select[name='"+status+"List'] option:selected").text());
             $("#"+status+"2").attr("readonly", true);
         } else {
             $("#"+status+"2").attr("readonly", false);
         }
    };

    var jsEmailList2 = function(status) {
        if($("select[id='"+status+"List'] option:selected").val() != ''){
             $("#reprsntEmails2"+status).val($("select[id='"+status+"List'] option:selected").text());
             $("#reprsntEmails2"+status).attr("readonly", true);
         } else {
             $("#reprsntEmails2"+status).attr("readonly", false);
         }
    };

    var pwdUseYn = function(){  <%-- 비밀번호 적합성 검사 --%>
        var pwd = $("#userPassword").val();
        var userId = $("#userId").val();
        var brthdy = $("#brthdy").val();
        var email = $("#email").val();
        var mbtlnum = $("#mbtlnum").val();
        if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
            $("#userPassword").focus();
            alert(Message.msg.passwordCheck2);
            return false;
        }
<%--         개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수 --%>
        vrtn = validPwd(pwd, userId, brthdy, email, mbtlnum);
        if(vrtn != ''){
            $("#userPassword").focus();
            alert(vrtn);
            return false;
        } else {
            return true;
        }
    };
 	// 숫자만 입력하도록 체크
 // 숫자만 입력하도록 체크
	function jsOnlyNumber(event){
		 var keyID = (event.which) ? event.which : event.keyCode;
		  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
		else return false;
	}
    /* 크롬- 숫자만 입력하도록 체크*/
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
    var pwdConfirm = function(){    <%-- 비밀번호와 확인 비밀번호 일치여부검사 --%>
        if($("#userPassword").val() != $("#userPassword2").val()){
            alert(Message.msg.notMatchPwd);
            return false;
        }
    };

    var jsIdReset = function(){
        idChk = "N";
    };
    
    var idCheck = function(){   <%-- 아이디 중복검사 --%>
        if($("#userId").val().length < 5 || $("#userId").val().length > 15){
            alert("아이디는 5자 이상, 15자 이하로 입력해주세요.");
            $("#userId").focus();
            return false;
        }
        if(!/^[A-Za-z0-9+]*$/.test($("#userId").val())){
            if(!/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/i.test($("#userId").val())){
                alert("아이디는 이메일형식 또는 숫자와 영문을 이용하여 입력해주세요.");
                $("#userId").focus();
                return false;
            }
        }
        $("#dataForm").ajaxSubmit({
            url      : "ND_checkDupleId.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if(response == 'true'){
                    idChk = "Y";
                    $("#userPassword").focus();
                    alert(Message.msg.idAvailable);
                }else{
                    alert(Message.msg.idNotAvailable);
                    $('#userId').focus();
                }
            }
        });
    };

    var jsEmailReset = function() {
        emailChk = "Y";
    };

    var jsZipcodePop = function (el, zcId, adr1, adr2) {    <%-- 주소찾기 컬러박스 호출 --%>
        $("#zipCodeId").val(zcId);
        $("#baseAddrId").val(adr1);
        $("#detailAddrId").val(adr2);
        $(el).colorbox({
            title : "우편번호 검색",
            href : "PD_searchList.do",
            width : "908",
            height : "880",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
    };

    var readURL = function (input) {    <%-- 업로드 파일 미리보기 --%>
    	if ( window.FileReader ) {
		     if (input.files && input.files[0]) {
	            fileName = input.files[0].name; // 파일명
	            $("#storeImgNm").text(fileName);
	            ext = fileName.substring(fileName.lastIndexOf('.') + 1);//확장자
	            ext = ext.toLowerCase();
	            if(ext != 'gif' && ext != 'jpg' && ext !='jpeg' && ext !='png') {  <%-- 확장자 확인 --%>
	                $("#delete").trigger("click");	                
	                alert(ext+Message.msg.fileCannotUplaod);
	            } else {
	                var reader = new FileReader();
	                reader.onload = function (e) {
	                    if(e.target.result.indexOf("image/gif") > 0 || e.target.result.indexOf("image/jpg") > 0 || e.target.result.indexOf("image/jpeg") > 0 || e.target.result.indexOf("image/png") > 0){
	                        $(".no-img").html("<img src=\""+e.target.result+"\" alt=\"업로드 이미지 미리보기\" />");
	                    }
	                }; 
	                $("#dataForm").ajaxSubmit({
	                    url      : "ND_uploadImgChk.do",
	                    data     : { inputName    : 'multiFiles',
	                                 maxWidthSize : 0,
	                                 maxHeightSize : 0,
	                                 minWidthSize : 200,
	                                 minHeightSize : 100,
	                                 maxFileSize  : 10240,
	                                 fileExt : 'jpg,jpeg,gif,png'},
	                    type     : "POST",
	                    dataType : "text",
	                    async    : false,
	                    success  : function(response){
	                        if(response == "100") {	                            
	                            reader.readAsDataURL(input.files[0]); <%-- 이미지 미리보기 영역에 이미지 세팅 --%>
	                        }else{
	                            $("#delete").trigger("click");
	                            alert(response);
	                            var control = $("#multiFiles");
	                            control.replaceWith(control = control.clone(true));
	                        }
	                    }
	                });
	            }
	        }
		} else {
	    	var source = $(input).val();

		    //확장자 잘라내기
		    var lastDot = source.lastIndexOf('.');
		    var ext = source.substring(lastDot + 1);
			var fileExt = "jpg,jpeg,gif,png";
		    if(fileExt.indexOf(ext.toLowerCase()) == -1){
		        $("#delete").trigger("click");
		        alert(ext+Message.msg.fileCannotUplaod);
		    } else {
			    $("#dataForm").ajaxSubmit({
			        url      : "ND_uploadImgChk.do",
			        data     : { inputName    : 'multiFiles',
			                     maxWidthSize : 0,
			                     maxHeightSize : 0,
			                     minWidthSize : 200,
			                     minHeightSize : 100,
			                     maxFileSize  : 10240,
			                     fileExt : 'jpg,jpeg,gif,png'},
			        type     : "POST",
			        dataType : "text",
			        async    : false,
			        success  : function(response){
			            if(response == "100") {
			                $(".no-img").html("<img src=\""+ "\" alt=\"" + $(input).val().substring($(input).val().lastIndexOf('\\') + 1) + "\" />");
			<%--                 reader.readAsDataURL(input.files[0]); 이미지 미리보기 영역에 이미지 세팅 --%>
			            }else{
			                $("#delete").trigger("click");
			                alert(response);
			                var control = $("#multiFiles");
			                control.replaceWith(control = control.clone(true));
			            }
			        }
			    });
		    }
		}
    };

    var userNation = function(){    <%-- 국가 코드및 국제전화번호 세팅 스크립트 --%>
        <c:if test="${param.nationCode ne '410'}">
        if($("select[id='nationName'] option:selected").val() != ''){
            INTRLTELNL1 = $("select[id='nationName'] option:selected").text().split("(");
            INTRLTELNL2 = INTRLTELNL1[1].split(")");
            $("#nationCode").val($("#nationName").val());
            $(".intrlTelno").val(INTRLTELNL2[0]);
            if(INTRLTELNL2[0] == ''){
                $(".intrlTelno").attr("readonly", false);
            } else {
                $(".intrlTelno").attr("readonly", true);
            }
        }
        </c:if>
        <c:if test="${param.nationCode eq '410'}">
        $(".intrlTelno").val(82);
        </c:if>
    };
    var jsCategoryPop = function(el) {
        $(el).colorbox({
            title  : "관심 카테고리 선택하기",
            href   : "PD_categoryPop.do?PID=UM01",
            width  : "900",
            height : "600",
            overlayClose : false,
            iframe : true
        });
    };
    var jsCtgrySel = function() {
        var ctgryCodes = $("#setCtgryCodes").val();
        $(".goodsCtgry").empty();
        ctgryCodes = ctgryCodes.split(",");
        var ctgryCodeUrl = "";
        for (var i = 0; i < ctgryCodes.length; i++) {
            if (i > 0) {
                ctgryCodeUrl += "&";
            }
            ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
        }
        var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url,
        function(response){
            if(response.length > 0){
//                 $('table#goodsCtgry tr:gt(0)').remove();
				var htmlVal1 = '<ul>';
                var htmlVal2 = "<ul>";
                var htmlVal3 = "<ul>";
                for (var i = 0; i < response.length; i++) {
                    if(response[i].ctgryClNm == 'SaaS'){
                        htmlVal2 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal2 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal2 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal2 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal2 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    } else if(response[i].ctgryClNm == 'PaaS'){
                        htmlVal1 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal1 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal1 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal2 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal1 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    } else {
                        htmlVal3 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal3 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal3 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal3 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal3 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    }
                }
                htmlVal1 += '</ul>';
                htmlVal2 += '</ul>';
                htmlVal3 += '</ul>';
                $(".cate2").html(htmlVal2);
                $(".cate1").html(htmlVal1);
                $(".cate3").html(htmlVal3);
            }
        });
    };

    var jsCheckDupleStoreNm = function(langCd) {
        if($("#langStoreNms"+langCd).val().length < 2){
            alert(Message.msg.storeNmEmpty);
            $("#langStoreNms"+langCd).focus();
            return false;
        }
        $.post("ND_checkDupleStoreNm.do", {
            langCode : langCd,
            langStoreNm : $("#langStoreNms"+langCd).val()
        }, function(response) {
            if(response == 'true') {
                alert(Message.msg.storeNmAvailable);
                $("#langStoreIntrcns"+langCd).focus();
                $("input[name='storeChk"+langCd+"']").val("Y");
            } else {
                $("#langStoreNms"+langCd).focus();
                alert($("#langStoreNms"+langCd).val()+Message.msg.storeNmAlready);
                $("#storeNmChk"+langCd).val("N");
                return false;
            }
        }, 'text');
    };

    var jsStoreNmReset = function(langCd) {
        $("#storeChk"+langCd).val("N");
    };
</script>
</c:if>
<c:if test="${fn:startsWith(param.userTyCd,'30')}">
<script type="text/javascript">
    var idChk = "N"; <%-- 아이디 중복확인 체크용 --%>
    var emailChk = "N"; <%-- 이메일 중복확인 체크용 --%>
    $().ready(function(){
        
        $("#dataForm").validate({
            ignore: "",
            rules: {
             telno1              : { /*required: true,*/ number: true}
            ,telno2              : { /*required: true,*/ number: true}
            ,telno3              : { /*required: true,*/ number: true}
            ,intrlTelno          : { /*required: true,*/ maxlength: 6}
            ,lxtnTelno           : { number: true}
            ,userId              : { required: true, nowhitespace: true, rangelength: [5, 15], remote: "ND_checkDupleId.do" }
            ,userNm              : { required: true}
            ,userPassword        : { required: true, rangelength: [10, 16] }
            ,userPassword2       : { required: true, equalTo: "#userPassword" }
            ,mbtlnum1            : { number: true, required: true}
            ,mbtlnum2            : { number: true, required: true}
            ,mbtlnum3            : { number: true, required: true}
            ,email               : { email2: true, required: true}
            ,email               : { email2: true, required: true}
            },
            messages : {
                 userId          : { remote : Message.msg.idNotAvailable}
                ,email2          : { remote : Message.msg.availableEmail}
                ,email           : { email2: "이메일 형식으로 입력해주세요."}
 			},
            submitHandler : function(form){
                
                if($("#telno1").val() != '' && $("#telno2").val() != '' && $("#telno3").val() != ''){
                    $("#telno").val($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val());
                }
                if($("#pblinsttTelno1").val() != '' && $("#pblinsttTelno2").val() != '' && $("#pblinsttTelno3").val() != ''){
                    $("#pblinsttTelno").val($("#pblinsttTelno1").val()+"-"+$("#pblinsttTelno2").val()+"-"+$("#pblinsttTelno3").val());
                }
                if($("#mbtlnum1").val() != '' && $("#mbtlnum2").val() != '' && $("#mbtlnum3").val() != ''){
                    $("#mbtlnum").val($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val());
                }
                
               	$(form).ajaxSubmit({
                    url      : "ND_insertAction.do",
                    type     : "POST",
                    dataType : "text",
                    success  : function(response) {
                        try {
                            if(eval(response)) {
                                self.location.href = "BD_complete.do";
                            } else {
                                if(response == 888){
                                    emailChk == "N";
                                }
                                alert(Message.msg.processFail);
                            }
                        } catch (e) {
                            alert(response, e);
                            return;
                        }
                    }
                    
                });
            }
        });
        
        userNation();
        <c:if test="${param.sbscrbTyCd eq '1003'}"><%-- 이메일 인증 후 --%>
        emailChk = "Y";
        $("#userNm").val("${param.userNm}").attr("readonly", true);
        $("#email").val("${param.email}").attr("readonly", true);
                
                /* "${fn:split(param.email, '@')[0]}");
        $("#email1").attr("readonly", true);
        $("#email2").val("${fn:split(param.email, '@')[1]}");
        $("#email2").attr("readonly", true);
        $("#emailList1").hide(); */
        </c:if>
        $("#userId").css("ime-mode","disabled");
        $(".intrlTelno").change(function(){
            $(".intrlTelno").val($(this).val());
        });
    });//ready end

    var jsSubmit = function() { <%-- 저장액션 --%>
        if(idChk == "Y"){
			if(!pwdUseYn()) {
			    return false;
			}
           	if($("#orgn_nm").val() == "" || $("#orgn_nm_st").val() == ""){
   	        	alert("기관명을 검색하여 주십시오");
   	        	$("#orgn_nm").focus();
   	        	return false;
           	}
           	if($("#pblinsttTelno1").val() == "" || $("#pblinsttTelno2").val() == "" || $("#pblinsttTelno3").val() == ""){
   	        	alert("기관 담당자 전화번호를 입력하여 주십시오.");
   	        	$("#pblinsttTelno1").focus();
   	        	return false;
           	}

			$("#dataForm").submit();
        } else if(idChk == "N"){
            alert(Message.msg.checkDupID);
            $("#idChk").focus();
            return false;
	    }
    };

    var pwdUseYn = function(){  <%-- 비밀번호 적합성 검사 --%>
        var pwd = $("#userPassword").val();
        var userId = $("#userId").val();
        var brthdy = $("#brthdy").val();
        var email = $("#email").val();
        var mbtlnum = $("#mbtlnum").val();
        if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
            $("#userPassword").focus();
            alert(Message.msg.passwordCheck2);
            return false;
        }
		<%-- 개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수 --%>
        vrtn = validPwd(pwd, userId, brthdy, email, mbtlnum);
        if(vrtn != ''){
            $("#userPassword").focus();
            alert(vrtn);
            return false;
        } else {
            return true;
        }
    };

    var pwdConfirm = function(){    <%-- 비밀번호와 확인 비밀번호 일치여부검사 --%>
        if($("#userPassword").val() != $("#userPassword2").val()){
            alert(Message.msg.notMatchPwd);
            return false;
        }
    };

    var jsIdReset = function(){
        idChk = "N";
    };
    var idCheck = function(){   <%-- 아이디 중복검사 --%>
        if($("#userId").val().length < 5 || $("#userId").val().length > 15){
            alert("아이디는 5자 이상, 15자 이하로 입력해주세요.");
            $("#userId").focus();
            return false;
        }
        if(!/^[A-Za-z0-9+]*$/.test($("#userId").val())){
            if(!/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/i.test($("#userId").val())){
                alert("아이디는 이메일형식 또는 숫자와 영문을 이용하여 입력해주세요.");
                $("#userId").focus();
                return false;
            }
        }
        $("#dataForm").ajaxSubmit({
            url      : "ND_checkDupleId.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if(response == 'true'){
                    idChk = "Y";
                    $("#userPassword").focus();
                    alert(Message.msg.idAvailable);
                }else{
                    alert(Message.msg.idNotAvailable);
                    $('#userId').focus();
                }
            }
        });
    };

    var jsEmailReset = function() {
        emailChk = "Y";
    };
    
    var jsPblinsttCdPop = function (el) {    <%-- 기관명 검색 컬러박스 호출 --%>
	    $(el).colorbox({
	        title : false,
	        href : "PD_dmandExaminPblinstt.do",
	        width : "745",
	        height : "580",
	        overlayClose : false,
	        escKey : false,
	        iframe : true,
	        closeButton : false,
	        scrolling : false,
	        returnFocus : false,
	        trapFocus : false
	    });
	};

	var jsZipcodePop = function (el, zcId, adr1, adr2) {    <%-- 주소찾기 팝업 호출 --%>
		$("#zipCodeId").val(zcId);
	    $("#baseAddrId").val(adr1);
	    $("#detailAddrId").val(adr2);
	    var pop = window.open(
	            "PD_jusoSearch.do",
	            "pop",
	            "top=" + (screen.height / 2 - 230)
	            +",left=" + (screen.width / 2 - 285)
	            + ",width=570,height=460, scrollbars=no"
	    );
	};

    var userNation = function(){    <%-- 국가 코드및 국제전화번호 세팅 스크립트 --%>
        <c:if test="${param.nationCode ne '410'}">
        if($("select[id='nationName'] option:selected").val() != ''){
            INTRLTELNL1 = $("select[id='nationName'] option:selected").text().split("(");
            INTRLTELNL2 = INTRLTELNL1[1].split(")");
            $("#nationCode").val($("#nationName").val());
            $(".intrlTelno").val(INTRLTELNL2[0]);
            if(INTRLTELNL2[0] == ''){
                $(".intrlTelno").attr("readonly", false);
            } else {
                $(".intrlTelno").attr("readonly", true);
            }
        }
        </c:if>
        <c:if test="${param.nationCode eq '410'}">
        $(".intrlTelno").val(82);
        </c:if>
    };
    
    var jsCategoryPop = function(el) {
        $(el).colorbox({
            title  : "관심 카테고리 선택하기",
            href   : "PD_categoryPop.do?PID=UM01",
            width  : "900",
            height : "600",
            overlayClose : false,
            iframe : true
        });
    };

    var organSearchPop = function(el) {
        $(el).colorbox({
            title        : "기관명 검색",
            href         : "PD_organSearchPop.do",
            width        : "900",
            height       : "700",
            overlayClose : false,
            iframe       : true,
            scrolling    : false
        });
    };

    var jsCtgrySel = function() {
        var ctgryCodes = $("#setCtgryCodes").val();
        $(".goodsCtgry").empty();
        ctgryCodes = ctgryCodes.split(",");
        var ctgryCodeUrl = "";
        for (var i = 0; i < ctgryCodes.length; i++) {
            if (i > 0) {
                ctgryCodeUrl += "&";
            }
            ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
        }
        var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url,
        function(response){
            if(response.length > 0){
//                 $('table#goodsCtgry tr:gt(0)').remove();
				var htmlVal1 = '<ul>';
                var htmlVal2 = "<ul>";
                var htmlVal3 = "<ul>";
                for (var i = 0; i < response.length; i++) {
                    if(response[i].ctgryClNm == 'SaaS'){
                        htmlVal2 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal2 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal2 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal2 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal2 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    } else if(response[i].ctgryClNm == 'PaaS'){
                        htmlVal1 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal1 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal1 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal2 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal1 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    } else {
                        htmlVal3 += '<li><span>'+response[i].ctgryClNm+'</span>';
                        if(response[i].ctgryPath != null){ htmlVal3 += '<span>'+response[i].ctgryPath+'</span>'; }
                        htmlVal3 += '<span class="txt-point">'+response[i].ctgryNm+'</span>';
//                         htmlVal3 += '<input type="button" id="goodsCtgry_' + response[i].ctgryCode + '" value="X" onclick="jsCategoryDelete(this);" />';
                        htmlVal3 += '</li><input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    }
                }
                htmlVal1 += '</ul>';
                htmlVal2 += '</ul>';
                htmlVal3 += '</ul>';
                $(".cate2").html(htmlVal2);
                $(".cate1").html(htmlVal1);
                $(".cate3").html(htmlVal3);
            }
        });
    };
	
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
		  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9) return;
		else event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
</script>
</c:if>
<style type="text/css">
    #multiFiles_wrap_list {margin-left : 70px;}
    #sexdstnCd{width:130px;}
    #mbtlnum1 {width:60px;}
</style>
</head>
<body>
<!-- container -->
		<div id="container" class="join-wrap">
			<!-- contents -->
			<div class="contents">
				<form id="dataForm" onsubmit="return false;">
		            <input type="hidden" id="zipCodeId" value=""/>
		            <input type="hidden" id="baseAddrId" value=""/>
		            <input type="hidden" id="detailAddrId" value=""/>
		            <input type="hidden" id="telno" name="telno" value=""/>
		            <input type="hidden" id="mbtlnum" name="mbtlnum" value=""/>
		            <input type="hidden" id="zip" name="zip" value=""/>
		            <input type="hidden" id="bizrno" name="bizrno" value=""/>
		            <input type="hidden" id="cmpnyTelno" name="cmpnyTelno" value=""/>
		            <input type="hidden" id="cmpnyReprsntTelno" name="cmpnyReprsntTelno" value=""/>
		            <input type="hidden" id="cmpnyFaxnum" name="cmpnyFaxnum" value=""/>
		            <input type="hidden" id="cmpnyZip" name="cmpnyZip" value=""/>
		            <input type="hidden" id="sbscrbTyCd" name="sbscrbTyCd" value="${param.sbscrbTyCd}"/>
		            <input type="hidden" id="langCode" name="langCode" value="00"/>
		            <input type="hidden" id="setCtgryCodes" value=""/>
		            <input type="hidden" id="dplctSbscrbIndvdlznKey" name="dplctSbscrbIndvdlznKey" value="<%=sDupInfo%>"/>
		            <input type="hidden" id="intrlTelno" name="intrlTelno" value="" class="intrlTelno"/>
		            <input type="hidden" id="nationCode" name="nationCode" value="${param.nationCode}"/>
		            <input type="hidden" id="pblinsttTelno" name="pblinsttTelno" value="" class="pblinsttTelno"/>
		            
<c:if test="${param.userTyCd == 1001}">
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/join_step_3.png" alt="정보입력" />
			<h2>일반 회원가입</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap join_info">
		<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>

		<h4>필수정보</h4>
		
		<table class="tbl_st4">
			<tr>
				<th class="requ">회원 구분</th>
				<td colspan="3">
					<input type="radio" name="userTyCd" id="userTyCd" onclick="$('#userTySel').show()" value="2001"/> <label for="mem_com">기업회원</label>
					<input type="radio" name="userTyCd" id="userTyCd" onclick="$('#userTySel').hide()" value="1001" checked="checked"/> <label for="mem_per">개인회원</label>
				</td>
			</tr>
			<!--  기업회원 선택시 노출 -->
			<tr id="userTySel" style="display:none;">
				<th class="requ">기업명</th>
				<td colspan="3"><input type="text" id="cmpnyNm" name="cmpnyNm"/></td>
			</tr>
			<!--//  기업회원 선택시 노출 -->
			<tr>
				<th class="requ">아이디</th>
				<td colspan="3">
					<input type="text" value="" name="userId" id="userId" maxlength="15" onchange="jsIdReset();"/> 
					<a href="#userId" id="idChk" onclick="idCheck();" class="btns st3">중복 확인</a>
					<a href="#" class="tip">
						?
						<dl>
							<dt>사용가능 아이디 조건</dt>
							<dd>영문소문자, 숫자를 포한함 8자 ~ 15자 이내<br/>(이메일 형식 가능, 공백 입력 불가)</dd>						
						</dl>
					</a>
				</td>
			</tr>
			<tr>
				<th class="requ">비밀번호</th>
				<td>
					<input type="password" value="" name="userPassword" id="userPassword" maxlength="15" onchange="pwdUseYn();"/>
					<p>※ 영문, 숫자, 특수문자 중 2가지 이상 10~16자</p>
				</td>
				<th>비밀번호 확인</th>
				<td><input type="password" value="" name="userPassword2" id="userPassword2" maxlength="32" onchange="pwdConfirm();"/>
				   <p>(사용 가능한 특수문자 : ! ” # $ % & ’ ( ) * + , - . / : ; > = < ?@ [ \ ] ^ _ ` { | } ~ )</p>
				</td>
			</tr>
			<tr>
				<th class="requ">이름</th>
				<td colspan="3"><input type="text" value="" name="userNm" id="userNm"/></td>
			</tr>
			<tr>
				<th class="requ">휴대전화</th>
				<td colspan="3" class="inputTel">
					<input type="text" readonly="readonly" value="82" />
					<span class="sel_box">
					<select id="mbtlnum1" name="mbtlnum1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					</span> - 
					<input type="text" id="mbtlnum2" name="mbtlnum2" title="휴대전화번호 가운데자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event);"/> - 
					<input type="text" id="mbtlnum3" name="mbtlnum3" title="휴대전화번호 뒷자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event);"/>
				</td>
			</tr>
			<tr>
				<th class="requ">이메일 주소</th>
				<td colspan="3" class="inputEmail">
					<input type="text" readonly="readonly" id="email" name="email" onchange="jsEmailReset();"/>
				</td>
			</tr>
			<tr>
				<th class="requ">이메일 수신동의</th>
				<td colspan="3" class="emailAgree">

					<dl>
						<dt>광고홍보 이메일</dt>
						<dd>
	                    	<!-- 
	                    	<label><input type="radio"  name="emailRecptnAgreCd" value="1001" onclick="emailRecptnAgreIng(this.value,1);">수신동의</label>
	                    	<label><input type="radio"  name="emailRecptnAgreCd" value="1002" onclick="emailRecptnAgreIng(this.value,1);">수신거부</label>
							 -->
							<op:code id="emailRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>	                    	
						</dd>
						<dt>뉴스레터/세미나</dt>
						<dd>
							<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>
						</dd>
						<dt>입찰공고 이메일</dt>
						<dd>
							<op:code id="bidRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>
						</dd>
					</dl>
					<p>※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이 이메일이 발송됩니다.</p>
				</td>
			</tr>
		</table>
		<!-- 
		<h4>관심분야(다중선택 가능)<a href="#" id="categorySelect" onclick="jsCategoryPop(this);" class="btns st3">선택</a>	</h4>
		<table class="tbl_st4">
			<tr>
				<th>SaaS</th>
				<td class="goodsCtgry cate2"></td>
			</tr>
			<tr>
				<th>Paas</th>
				<td class="goodsCtgry cate1"></td>
			</tr>
			<tr>
				<th>IaaS</th>
				<td class="goodsCtgry cate3"></td>
			</tr>
		</table>

		 -->
		<div class="btnArea rig">
			<a href="/korean/pt/index.do" class="btns st2">취소</a>
			<a href="#none" onclick="javascript:jsSubmit(); return false;" class="btns st1 icn_r next">회원가입</a>
		</div>
	</div>
	<!--// content -->
</c:if>	
	
<c:if test="${param.userTyCd == 3001}">
<!-- content -->
<input type="hidden" id="userTyCd" name="userTyCd" value="${param.userTyCd}">
	
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<img src="/cloud_ver2/new_cloud/images/join_step_3.png" alt="정보입력" />
			<h2>공공기관 회원가입</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap join_info">
		<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>

		<h4>필수정보</h4>
		
		<table class="tbl_st4">
			<tr>
				<th class="requ">아이디</th>
				<td colspan="3">
					<input type="text" name="userId" id="userId" maxlength="15" onchange="jsIdReset();"/> 
					<a href="#userId" id="idChk" onclick="idCheck();" class="btns st3">중복 확인</a>
					<a href="#" class="tip">
						<dl>
							<dt>사용가능 아이디 조건</dt>
							<dd>영문소문자, 숫자를 포한함 8자 ~ 15자 이내<br/>(이메일 형식 가능, 공백 입력 불가)</dd>						
						</dl>
					</a>
					<!-- 수요예보조사 일때만  -->
					<input type="checkbox" id="dmandExaminChargerAt" name="dmandExaminChargerAt" value="Y"/> <label for="dmandExaminChargerAt">수요예보조사 담당자(기관당 1명만 선택)</label>
					<!-- <input type="hidden" id="dmandExaminChargerAt" name="dmandExaminChargerAt" value="" /> -->
				</td>
			</tr>
			<tr>
				<th class="requ" rowspan=2>비밀번호</th>
				<td style="border-bottom:0px;">
					<input type="password" value="" name="userPassword" id="userPassword" maxlength="15" onchange="pwdUseYn();"/>
					<p></p>
				</td>
				<th style="border-bottom:0px;">비밀번호 확인</th>
				<td style="border-bottom:0px;"><input type="password" value="" name="userPassword2" id="userPassword2" maxlength="32" onchange="pwdConfirm();"/>
				</td>
			</tr>
			<tr><td colspan="3"><p style="margin:0px 0 0px;padding:0px;font-size:12px;color:#ff6901;">※ 영문, 숫자, 특수문자 중 2가지 이상 10~16자(사용 가능한 특수문자 : ! ” # $ % & ’ ( ) * + , - . / : ; > = < ?@ [ \ ] ^ _ ` { | } ~ )</p></td></tr>
			<tr>
				<th class="requ">이름</th>
				<td colspan="3"><input type="text" value="" name="userNm" id="userNm"/></td>
			</tr>
			<tr>
				<th class="requ">휴대전화</th>
				<td colspan="3" class="inputTel">
					<input type="text" readonly="readonly" value="82" />
					<span class="sel_box">
					<select id="mbtlnum1" name="mbtlnum1">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
					</span> - 
					<input type="text" id="mbtlnum2" name="mbtlnum2" title="휴대전화번호 가운데자리를 입력해주세요."  maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
					<input type="text" id="mbtlnum3" name="mbtlnum3" title="휴대전화번호 뒷자리를 입력해주세요." maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
				</td>
			</tr>
			<tr>
				<th class="requ">이메일 주소</th>
				<td colspan="3" class="inputEmail">
					<input type="text" readonly="readonly" id="email" name="email" onchange="jsEmailReset();"/>
				</td>
			</tr>
			<tr>
				<th class="requ">이메일 수신동의</th>
				<td colspan="3" class="emailAgree">
					<dl>
						<dt>광고홍보 이메일</dt>
						<dd>
							<op:code id="emailRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>
						</dd>
						<dt>뉴스레터/세미나</dt>
						<dd>
							<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>
						</dd>
						<dt>입찰공고 이메일</dt>
						<dd>
							<op:code id="bidRecptnAgreCd" grpCd="77" type="radio" defaultValues="1002"/>
						</dd>
					</dl>
					<p>※ 개인정보 변경, 서비스등록/상태 변경, 비즈매칭 등과 관련된 내용은 수신동의 여부와 관계없이 이메일이 발송됩니다.</p>
				</td>
			</tr>
		</table>

		<h4>소속기관정보(필수)</h4>
		<table class="tbl_st4">
			<tr>
				<th class="requ">기관명</th>
				<td>
					<input type="hidden" name="orgnCode" id="orgnCode" />
					<input type="hidden" name="buseoCode" id="buseoCode" />
					<input type="text" name="orgn_nm" id="orgn_nm" readonly style="width:530px;" />
					<a href="#" class="btns st3" onclick="organSearchPop(this);">기관검색</a>
				</td>
			</tr>
			<!-- 
			<tr>
				<th class="requ">부서명</th>
				<td>
					<input type="hidden" name="buseoCode" id="buseoCode" />
					<input type="text" name="orgn_nm_st" id="orgn_nm_st" readonly /></td>
			</tr>
			 -->
			<tr>
				<th class="requ">유선전화</th>
				<td class="inputTel">
					<input type="text" name="pblinsttTelno1" id="pblinsttTelno1" maxlength="3" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
					<input type="text" name="pblinsttTelno2" id="pblinsttTelno2" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /> -
					<input type="text" name="pblinsttTelno3" id="pblinsttTelno3" maxlength="4" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" />
				</td>
			</tr>
		</table>
		<!-- 
		<h4>관심분야(다중선택 가능)<a href="#" id="categorySelect" onclick="jsCategoryPop(this);" class="btns st3">선택</a>	</h4>
		<table class="tbl_st4">
			<tr>
				<th>SaaS</th>
				<td class="goodsCtgry cate2"></td>
			</tr>
			<tr>
				<th>Paas</th>
				<td class="goodsCtgry cate1"></td>
			</tr>
			<tr>
				<th>IaaS</th>
				<td class="goodsCtgry cate3"></td>
			</tr>
		</table>
         -->
		
		<div class="btnArea rig">
			<a href="/korean/pt/index.do" class="btns st2">취소</a>
			<a href="#none" onclick="jsSubmit();" class="btns st1 icn_r next">회원가입</a>
		</div>
	</div>
	<!--// content -->
</c:if>
			 </form>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
</body>
</html>