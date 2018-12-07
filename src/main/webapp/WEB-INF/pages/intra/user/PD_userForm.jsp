<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<title>회원관리 | 회원관리 | 회원등록</title>
<op:jsTag type="spi" items="form,validate,colorbox" />
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/openworks/login/js/validationOfPassword.js" />"></script>
<script type="text/javascript">
    $().ready(function() {
        $("#Form").validate({
            ignore: "",
            rules: {
                 // telno1            : { /*required: true,*/ number: true}
                 //,telno2            : { /*required: true,*/ number: true}
                 //,telno3            : { /*required: true,*/ number: true}
                 intrlTelno        : { /*required: true,*/ maxlength: 6}
                 //,lxtnTelno         : { number: true}
                 <c:if test="${empty baseVo}">
                 ,userId            : { required: true, nowhitespace: true, rangelength: [5, 15], remote: "ND_checkDupleId.do" }
                 ,userNm            : { required: true}
                 ,userPassword      : { required: true, rangelength: [10, 16] }
                 ,userPassword1     : { required: true, equalTo: "#userPassword" }
                 </c:if>
                 //,brthdy            : { required: true, formatDate: true}
                 ,mbtlnum1          : { number: true, required: true}
                 ,mbtlnum2          : { number: true, required: true}
                 ,mbtlnum3          : { number: true, required: true}
                 ,email             : { email2: true, required: true}
                 <c:if test="${baseVo.userTyCd == 3001}">
                 ,pblinsttTelno1   : { number: true}
                 ,pblinsttTelno2   : { number: true}
                 ,pblinsttTelno3   : { number: true}                 
                 </c:if>
                 ,email1            : { required: true}
                 ,email2            : { required: true, ${empty baseVo ? 'remote: "ND_emailDupleCheck.do"' : ''}}
                 //,zip1              : { number: true/*, required: true*/}
                 //zip2              : { number: true/*, required: true*/}
//                  ,bassAdres         : { required: true}
//                  ,detailAdres       : { required: true}
//                  ,userGradCode      : { required: true}
//                  ,actLevelCd        : { required: true}
//                  ,sbscrbTyCd        : { required: true}
                 <c:if test="${userSetYn.cmpnyNm == 1003}">
                 ,cmpnyNm           : { required: true}
                 </c:if>
                 /* <c:if test="${userSetYn.cmpnyRprsntvNm == 1003}">
                 ,cmpnyRprsntvNm    : { required: true}
                 </c:if> */
                 ,bizrno1           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                 ,bizrno2           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                 ,bizrno3           : { number: true${userSetYn.bizrno == 1003 ? ', required: true' : ''}}
                 ,cmpnyTelno1       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                 ,cmpnyTelno2       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                 ,cmpnyTelno3       : { number: true${userSetYn.cmpnyTelno == 1003 ? ', required: true' : ''}}
                 //,cmpnyLxtnTelno    : { number: true}
                 //,cmpnyReprsntTelno1: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                 //,cmpnyReprsntTelno2: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                 //,cmpnyReprsntTelno3: { number: true${userSetYn.cmpnyReprsntTelno == 1003 ? ', required: true' : ''}}
                 //,cmpnyFaxnum1      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                 //,cmpnyFaxnum2      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                 //,cmpnyFaxnum3      : { number: true${userSetYn.cmpnyFaxnum == 1003 ? ', required: true' : ''}}
                 //,cmpnyEmail        : { email2: true}
                 /* <c:if test="${userSetYn.cmpnyEmail == 1003}">
                 ,cmpnyEmail1       : { required: true}
                 ,cmpnyEmail2       : { required: true}
                 </c:if> */
                 //,cmpnyUrl          : { url: true${userSetYn.cmpnyUrl == 1003 ? ', required: true' : ''}}
                 //,cmpnyZip1         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
                 //,cmpnyZip2         : { number: true${userSetYn.cmpnyZip == 1003 ? ', required: true' : ''}}
                 /* <c:if test="${userSetYn.cmpnyBassAdres == 1003}">
                 ,cmpnyBassAdres    : { required: true}
                 </c:if> */
                 /* <c:if test="${userSetYn.cmpnyDetailAdres == 1003}">
                 ,cmpnyDetailAdres  : { required: true}
                 </c:if> */
                 <c:if test="${param.userTy == '20' || fn:endsWith(baseVo.userTyCd, '02')}">
                 ,langStoreNms     : { rangelength: [2, 60]}
                 //,langStoreIntrcns : { maxlength: 1000}
                 ,storeChargerNms  : { maxlength: 100}
                 ,reprsntTelnos1   : { number: true}
                 ,reprsntTelnos2   : { number: true}
                 ,reprsntTelnos3   : { number: true}
                 //,reprsntEmails    : { email2: true}
                 //,storeUrls        : { url: true}
                 </c:if>
             },
             messages:{
                  userId        : { remote: "이미 사용중인 아이디입니다."}
                 //,brthdy        : { formatData: "YYYYMMDD 날짜형식으로 입력해주세요."}
                 ,email         : { email2: "이메일 형식으로 입력해주세요."}
                 ,cmpnyEmail    : { email2: "회사이메일을 이메일 형식으로 입력해주세요."}
                 //,reprsntEmails : { email2: "다국어 판매정보의 이메일을 이메일 형식으로 입력해주세요."}
             },
             submitHandler : function(form) {
                 if(($("input[name='userTyCd']:checked").val() == '1002' || $("input[name='userTyCd']:checked").val() == '2002') && next == 'Y'){
                     //모든테이블을 비활성
                     $(".storeInfo *").attr("disabled",true);
                     if($("input[name='storeLangCodes']:checked").length > 0){
                         affected = 'Y';
//                          <c:if test="${empty baseVo}">
//                          if($("#multiFiles").val() == '' || $("#multiFiles").val() == undefined){
//                              jsWarningBox("회사 이미지를 등록해주세요.");
//                              $("#multiFiles").focus();
//                              affected = 'N';
//                          }
//                          </c:if>
//                          <c:if test="${not empty baseVo}">
//                          if($("#storeImageFileSeq").val() == undefined){
//                              if($("#multiFiles").val() == '' || $("#multiFiles").val() == undefined){
//                                  jsWarningBox("회사 이미지를 등록해주세요.");
//                                  $("#multiFiles").focus();
//                                  affected = 'N';
//                              }
//                          }
//                          </c:if>
                         $("input[name=storeLangCodes]:checked").each(function(i) {
                             //선택된 테이블만 활성
                             $("."+$(this).val()+" *").attr("disabled",false);
                             <c:if test="${storeSetYn.langStoreNm == 1003}">
                             if($("#langStoreNms"+$(this).val()).val() == ''){
                                 jsWarningBox("회사명을 입력해주세요.");
                                 $("#langStoreNms"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             if($("#storeNmChk_"+$(this).val()).val() == 'N'){
                                 $("#storeNmChk"+$(this).val()).focus();
                                 jsWarningBox("회사명 중복체크를 해주세요.");
                                 affected = 'N';
                                 return false;
                             }
                             <c:if test="${storeSetYn.langStoreIntrcn == 1003}">
                             /* if($("#langStoreIntrcns"+$(this).val()).val() == ''){
                                 jsWarningBox("회사 소개를 입력해주세요.");
                                 $("#langStoreIntrcns"+$(this).val()).focus();
                                 affected = 'N';
                                 return false;
                             } */
                             </c:if>
                             <c:if test="${storeSetYn.storeChargerNm == 1003}">
                             if($("#storeChargeNms"+$(this).val()).val() == ''){
                                 jsWarningBox("회사 담당자를 입력해주세요.");
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.reprsntTelno == 1003}">
                             if($("#reprsntTelnos1"+$(this).val()).val() == '' || $("#reprsntTelnos2"+$(this).val()).val() == '' || $("#reprsntTelnos3"+$(this).val()).val() == ''){
                                 jsWarningBox("회사 전화번호를 입력해주세요.");
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             /* <c:if test="${storeSetYn.reprsntEmail == 1003}">
                             if($("#reprsntEmails1"+$(this).val()).val() == '' || $("#reprsntEmails2"+$(this).val()).val() == ''){
                                 jsWarningBox("회사 이메일을 입력해주세요.");
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>
                             <c:if test="${storeSetYn.storeUrl == 1003}">
                             if($("#storeUrls"+$(this).val()).val() == ''){
                                 jsWarningBox("회사 이메일을 입력해주세요.");
                                 affected = 'N';
                                 return false;
                             }
                             </c:if>*/
                             if($("#reprsntTelnos1"+$(this).val()).val() != '' && $("#reprsntTelnos2"+$(this).val()).val() != '' && $("#reprsntTelnos3"+$(this).val()).val() != ''){
                                 $("#reprsntTelnos"+$(this).val()).val($("#reprsntTelnos1"+$(this).val()).val()+"-"+$("#reprsntTelnos2"+$(this).val()).val()+"-"+$("#reprsntTelnos3"+$(this).val()).val());
                             }
                             /* if($("#reprsntEmails1"+$(this).val()).val() != '' && $("#reprsntEmails2"+$(this).val()).val() != ''){
                                 $("#reprsntEmails"+$(this).val()).val($("#reprsntEmails1"+$(this).val()).val()+"@"+$("#reprsntEmails2"+$(this).val()).val());
                             } */
                         });
                         if(affected == 'N'){
                             //검증 실패시 모든테이블을 활성
                             $(".storeInfo *").attr("disabled",false);
                             return false;
                         }
                     } else {
                         jsWarningBox("회사 정보를 한가지 이상의 언어를 선택해야 합니다.");
                         return false;
                     }
                 }
                 /* if(!($("#telno1").val() == '' && $("#telno2").val() == '' && $("#telno3").val() == '')){
                     $("#telno").val($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val());
                 } */
                 if(!($("#mbtlnum1").val() == '' && $("#mbtlnum2").val() == '' && $("#mbtlnum3").val() == '')){
                     $("#mbtlnum").val($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val());
                 }
                 
                 if(!($("#pblinsttTelno1").val() == '' && $("#pblinsttTelno2").val() == '' && $("#pblinsttTelno3").val() == '')){
                     $("#pblinsttTelno").val($("#pblinsttTelno1").val()+"-"+$("#pblinsttTelno2").val()+"-"+$("#pblinsttTelno3").val());
                 }
                 
                 if(!($("#zip1").val() == '' && $("#zip2").val() == '' )){
                     $("#zip").val($("#zip1").val()+"-"+$("#zip2").val());
                 }
                 if(!($("#bizrno1").val() == '' && $("#bizrno2").val() == '' && $("#bizrno3").val() == '')){
                     $("#bizrno").val($("#bizrno1").val()+"-"+$("#bizrno2").val()+"-"+$("#bizrno3").val());
                 }
                 if(!($("#cmpnyTelno1").val() == '' && $("#cmpnyTelno2").val() == '' && $("#cmpnyTelno3").val() == '')){
                     $("#cmpnyTelno").val($("#cmpnyTelno1").val()+"-"+$("#cmpnyTelno2").val()+"-"+$("#cmpnyTelno3").val());
                 }
                 /* if(!($("#cmpnyReprsntTelno1").val() == '' && $("#cmpnyReprsntTelno2").val() == '' && $("#cmpnyReprsntTelno3").val() == '')){
                     $("#cmpnyReprsntTelno").val($("#cmpnyReprsntTelno1").val()+"-"+$("#cmpnyReprsntTelno2").val()+"-"+$("#cmpnyReprsntTelno3").val());
                 } */
                 /* if(!($("#cmpnyFaxnum1").val() == '' && $("#cmpnyFaxnum2").val() == '' && $("#cmpnyFaxnum3").val() == '')){
                     $("#cmpnyFaxnum").val($("#cmpnyFaxnum1").val()+"-"+$("#cmpnyFaxnum2").val()+"-"+$("#cmpnyFaxnum3").val());
                 } */
                 /* if(!($("#cmpnyZip1").val() == '' && $("#cmpnyZip2").val() == '')){
                     $("#cmpnyZip").val($("#cmpnyZip1").val()+"-"+$("#cmpnyZip2").val());
                 } */
                if($("#submitYN").val() == "Y"){
                     $(form).ajaxSubmit({
                        url      : "${empty baseVo ? 'ND_insertAction.do' : 'ND_updateAction.do'}",
                        type     : "POST",
                        dataType : "text",
                        success  : function(response) {
                             if (response) {
                                 jsSuccessBox("요청이 성공하였습니다.");
                                 parent.location.reload();
                                 <c:if test="${not empty baseVo}">
                                 self.location.href = "PD_userForm.do?userId=" + $("#userId").val() + "&userTyCd=" + $("input[name='userTyCd']:checked").val();
                                 </c:if>
                             }else{
                                 alert(response);
                             }
                        }
                     });
                }
                if($("input[name='userTyCd']:checked").val() == '1002' || $("input[name='userTyCd']:checked").val() == '2002' || $("input[name='userTyCd']:checked").val() == '3002'){
                    next = 'Y';
                    $(".popupStore").show();
                    $(".popup").hide();
                    $("#next").hide();
                    $("#submit").show();
                }
             }
         });

         var option = {
             tabContainer : "tabContainer"
         };
         tabs = $("#tabDiv").jsTabUi(option);
         $("input[name='userTyCd']").click(function(){
             readyTab();
         });
         readyTab();
         $("#emailList").change(function(){
            if($("select[name='emailList'] option:selected").val() != ''){
                 $("#email2").val($("select[name='emailList'] option:selected").text());
                 $("#email2").attr("readonly", true);
             } else {
                 $("#email2").attr("readonly", false);
             }
         });
         $("#cmpnyEmailList").click(function(){
             if($("select[name='cmpnyEmailList'] option:selected").val() != ''){
                 $("#cmpnyEmail2").val($("select[name='cmpnyEmailList'] option:selected").text());
                 $("#cmpnyEmail2").attr("readonly", true);
             } else {
                 $("#cmpnyEmail2").attr("readonly", false);
             }
         });
         /* <c:forEach items="${langList}" var="list">
         //회사정보 동일 정보적용 체크박스 액션
         $("#sameUser<c:out value="${list.LANGENGABRV}" />").click(function(){
             $("#storeChargerNms<c:out value="${list.LANGCD}" />").val($("#userNm").val());
             $("#reprsntTelnos1<c:out value="${list.LANGCD}" />").val($("#telno1").val());
             $("#reprsntTelnos2<c:out value="${list.LANGCD}" />").val($("#telno2").val());
             $("#reprsntTelnos3<c:out value="${list.LANGCD}" />").val($("#telno3").val());
             $("#reprsntEmails1<c:out value="${list.LANGCD}" />").val($("#email1").val());
             $("#reprsntEmails2<c:out value="${list.LANGCD}" />").val($("#email2").val());
         });
         </c:forEach> */
         <c:forEach items="${baseVo.userList}" var="store" varStatus="status">
         $("input[id='storeLang${store.langCode}']").attr("checked", true);
         $(".${store.langCode}").show();
         </c:forEach>
         <c:if test="${not empty baseVo}">
         	settingValue(updateSettingOptionDate);//기본정보 조회자료 세팅
         	settingValue(updateSettingStoreDate);//회사정보 조회자료 세팅
         </c:if>
         <c:if test="${fn:startsWith(baseVo.userTyCd, '10') || param.userTy eq '10'}">
            <c:if test="${baseVo.userTyCd == 1001}">
         	  	$("input[id='userTyCd_rb_2']").attr("disabled",true).hide();
            	$("label[for='userTyCd_rb_2']").hide();
            </c:if>
            <c:if test="${baseVo.userTyCd == 1002}">
     	  		$("input[id='userTyCd_rb_1']").attr("disabled",true).hide();
        		$("label[for='userTyCd_rb_1']").hide();
        	</c:if>
             	$("input[id='userTyCd_rb_3']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_3']").hide();
             	$("input[id='userTyCd_rb_4']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_4']").hide();
             	$("input[id='userTyCd_rb_5']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_5']").hide();
             	$("input[id='userTyCd_rb_6']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_6']").hide();
         </c:if>
         <c:if test="${fn:startsWith(baseVo.userTyCd, '20') || param.userTy eq '20'}">
             $("input[id='userTyCd_rb_1']").attr("disabled",true).hide();
             $("label[for='userTyCd_rb_1']").hide();
             $("input[id='userTyCd_rb_2']").attr("disabled",true).hide();
             $("label[for='userTyCd_rb_2']").hide();
             <c:if test="${baseVo.userTyCd == 2001}">
             	$("input[id='userTyCd_rb_4']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_4']").hide();
             </c:if>
             <c:if test="${baseVo.userTyCd == 2002}">
             	$("input[id='userTyCd_rb_3']").attr("disabled",true).hide();
             	$("label[for='userTyCd_rb_3']").hide();
             </c:if>
             $("input[id='userTyCd_rb_5']").attr("disabled",true).hide();
          	 $("label[for='userTyCd_rb_5']").hide();
          	 $("input[id='userTyCd_rb_6']").attr("disabled",true).hide();
          	 $("label[for='userTyCd_rb_6']").hide();
         </c:if>
         
         <c:if test="${fn:startsWith(baseVo.userTyCd, '30') || param.userTy eq '30'}">
	         $("input[id='userTyCd_rb_1']").attr("disabled",true).hide();
	         $("label[for='userTyCd_rb_1']").hide();
	         $("input[id='userTyCd_rb_2']").attr("disabled",true).hide();
	         $("label[for='userTyCd_rb_2']").hide();
	         $("input[id='userTyCd_rb_4']").attr("disabled",true).hide();
         	 $("label[for='userTyCd_rb_4']").hide();
             $("input[id='userTyCd_rb_3']").attr("disabled",true).hide();
         	 $("label[for='userTyCd_rb_3']").hide();
	         <c:if test="${baseVo.userTyCd == 3001}">
	         	$("input[id='userTyCd_rb_6']").attr("disabled",true).hide();
	      	 	$("label[for='userTyCd_rb_6']").hide();
	      	 </c:if>
	         <c:if test="${baseVo.userTyCd == 3002}">
	    	  	 $("input[id='userTyCd_rb_5']").attr("disabled",true).hide();
	      		 $("label[for='userTyCd_rb_5']").hide();
	      	</c:if>
      	</c:if>
         /* $("#nationCode").change(function(){
             INTRLTELNL1 = $("select[id='nationCode'] option:selected").text().split("(");
             INTRLTELNL2 = INTRLTELNL1[1].split(")");
             $(".intrlTelno").val(INTRLTELNL2[0]);
             if(INTRLTELNL2[0] == ''){
                 $(".intrlTelno").attr("readonly", false);
             } else {
                 $(".intrlTelno").attr("readonly", true);
             }
         });
         <c:if test="${empty baseVo}">
         $("#nationCode").trigger("change");
         </c:if>*/
         $("#storeTab a").click(function(event) {
             if(next != 'Y') {
                 $("#infoTab > a").triggerHandler("click");
             } else {
                 $("#storeTab > a").triggerHandler("click");
             }
         });
         $(".intrlTelno").change(function(){
             $(".intrlTelno").val($(this).val());
         });
     });// ready end

    var idChk = "N";
    var emailChk = "${empty baseVo ? 'N' : 'Y'}";
    var jsSubmit = function(el) {
        
        if($("#email1").val() != '' || $("#email2").val() != ''){
            $("#email").val($("#email1").val()+"@"+$("#email2").val());
        }
        if(!($("#pblinsttTelno1").val() == '' && $("#pblinsttTelno2").val() == '' && $("#pblinsttTelno3").val() == '')){
            $("#pblinsttTelno").val($("#pblinsttTelno1").val()+"-"+$("#pblinsttTelno2").val()+"-"+$("#pblinsttTelno3").val());
        }
        /* if($("#cmpnyEmail1").val() != '' || $("#cmpnyEmail2").val() != ''){
            $("#cmpnyEmail").val($("#cmpnyEmail1").val()+"@"+$("#cmpnyEmail2").val());
        } */
        /* <c:forEach items="${langList}" var="list">
        if($("#reprsntEmails1${list.LANGCD}").val() != '' || $("#reprsntEmails2${list.LANGCD}").val() != ''){
            $("#reprsntEmails${list.LANGCD}").val($("#reprsntEmails1${list.LANGCD}").val()+"@"+$("#reprsntEmails2${list.LANGCD}").val());
        }
        </c:forEach> */
        $("#submitYN").val("Y");
        <c:if test="${empty baseVo}">
         if(idChk == "N"){
             jsWarningBox("아이디 중복체크를 해주세요.");
             return false;
         }
         </c:if>
         
         <c:if test="${not empty baseVo}"><%-- 회원정보 수정시 변경내용 저장 --%>
             var modConts = new Array();
             /* if($("#nationCode").val() != '${baseVo.nationCode}'){
                 modConts[0] = "[국적]";
             }
             if($("#brthdy").val() != '${baseVo.brthdy}'){
                 modConts[1] = "[생년월일]";
             } */
//              if($("input[name='slrcldLrrLpnhCd']:checked").val() != '${baseVo.slrcldLrrLpnhCd}'){
//                  modConts[2] = "[양력음력윤달코드]"
//              }
             /* if($("input[name='sexdstnCd']:checked").val() != '${baseVo.sexdstnCd}'){
                 modConts[3] = "[성별]";
             }
             if(($("#telno1").val()+"-"+$("#telno2").val()+"-"+$("#telno3").val()) != '${baseVo.telno}'){
                 modConts[4] = "[전화번호]";
             }
             if($("#lxtnTelno").val() != '${baseVo.lxtnTelno}'){
                 modConts[5] = "[내선번호]";
             } */
             if($("#mbtlnum1").val()+"-"+$("#mbtlnum2").val()+"-"+$("#mbtlnum3").val() != '${baseVo.mbtlnum}'){
                 modConts[6] = "[휴대전화]";
             } 
             if($("#email").val() != '${baseVo.email}'){
                 modConts[7] = "[이메일]";
             }
             if($("input[name='emailRecptnAgreCd']:checked").val() != '${baseVo.emailRecptnAgreCd}'){
                 modConts[8] = "[이메일수신여부]";
             }
             /* if(($("#zip1").val()+"-"+$("#zip2").val() != '${baseVo.zip}') && ($("#zip1").val() != '' && $("#zip2").val())){
                 modConts[9] = "[우편번호]";
             }
             if($("#bassAdres").val() != '${baseVo.bassAdres}'){
                 modConts[10] = "[기본주소]";
             }
             if($("#detailAdres").val() != '${baseVo.detailAdres}'){
                 modConts[11] = "[상세주소]";
             } */
             /* if($("select[name='userGradCode'] option:selected").val() != '${baseVo.userGradCode}'){
                 modConts[12] = "[회원등급]";
             }
             if($("select[name='actLevelCd'] option:selected").val() != '${baseVo.actLevelCd}'){
                 modConts[13] = "[회원레벨]";
             }
             if($("select[name='sbscrbTyCd'] option:selected").val() != '${baseVo.sbscrbTyCd}'){
                 modConts[14] = "[가입유형]";
             } */
             if($("#cmpnyNm").val() != '${baseVo.cmpnyNm}'){
                 modConts[15] = "[회사명]";
             }
             /* if($("#cmpnyRprsntvNm").val() != '${baseVo.cmpnyRprsntvNm}'){
                 modConts[16] = "[회사 대표자이름]";
             } */
             if(($("#bizrno1").val()+"-"+$("#bizrno2").val()+"-"+$("#bizrno3").val() != '${baseVo.bizrno}') && ($("#bizrno1").val() != '' && $("#bizrno2").val() != '') && $("#bizrno3").val() != ''){
                 modConts[17] = "[사업자 등록번호]";
             }
             if((($("#cmpnyTelno1").val()+"-"+$("#cmpnyTelno2").val()+"-"+$("#cmpnyTelno3").val()) != '${baseVo.cmpnyTelno}') && ($("#cmpnyTelno1").val() != '' && $("#cmpnyTelno2").val() != '' && $("#cmpnyTelno3").val() !='')){
                 modConts[18] = "[회사 전화번호]";
             }
             /* if($("#cmpnyLxtnTelno").val() != '${baseVo.cmpnyLxtnTelno}'){
                 modConts[19] = "[회사 내선번호]";
             } */
             if((($("#pblinsttTelno1").val()+"-"+$("#pblinsttTelno2").val()+"-"+$("#pblinsttTelno3").val()) != '${baseVo.pblinsttTelno}') && ($("#pblinsttTelno1").val() != '' && $("#pblinsttTelno2").val() != '' && $("#pblinsttTelno3").val() != '')){
                 modConts[20] = "[회사 대표전화번호]";
             }
             /* if((($("#cmpnyReprsntTelno1").val()+"-"+$("#cmpnyReprsntTelno2").val()+"-"+$("#cmpnyReprsntTelno3").val()) != '${baseVo.cmpnyReprsntTelno}') && ($("#cmpnyReprsntTelno1").val() != '' && $("#cmpnyReprsntTelno2").val() != '' && $("#cmpnyReprsntTelno3").val() != '')){
                 modConts[20] = "[회사 대표전화번호]";
             } */
             /* if((($("#cmpnyFaxnum1").val()+"-"+$("#cmpnyFaxnum2").val()+"-"+$("#cmpnyFaxnum3").val()) != '${baseVo.cmpnyFaxnum}')&&($("#cmpnyFaxnum1").val() != '' && $("#cmpnyFaxnum2").val() != '' && $("#cmpnyFaxnum3").val() != '')){
                 modConts[21] = "[회사팩스]";
             } */
             /* if($("#cmpnyEmail").val() != '${baseVo.cmpnyEmail}'){
                 modConts[22] = "[회사이메일]";
             } */
             /* if($("input[name='cmpnyEmailRecptnAgreCd']:checked").val() != '${baseVo.cmpnyEmailRecptnAgreCd}'){
                 modConts[23] = "[회사이메일수신여부]";
             } */
             /* if($("#cmpnyUrl").val() != '${baseVo.cmpnyUrl}'){
                 modConts[24] = "[회사URL]";
             } */
             /* if(($("#cmpnyZip1").val()+"-"+$("#cmpnyZip2").val() != '${baseVo.cmpnyZip}') && ($("#cmpnyZip1").val() != '' && $("#cmpnyZip2").val() != '')){
                 modConts[25] = "[회사 우편번호]";
             } */
             /* if($("#cmpnyBassAdres").val() != '${baseVo.cmpnyBassAdres}'){
                 modConts[26] = "[회사기본주소]";
             }
             if($("#cmpnyDetailAdres").val() != '${baseVo.cmpnyDetailAdres}'){
                 modConts[27] = "[회사상세주소]";
             } */
             if($("#setCtgryCodes").val() != '<c:forEach items="${baseVo.ctgryList}" var="category" varStatus="status">${category.CTGRYCODE}${!status.last? ',' : ''}</c:forEach>'){
                 modConts[28] = "[관심카테고리]";
             }
             /*
             <c:if test="${fn:startsWith(baseVo.userTyCd, '10')}">
              if($("input[name='smsRecptnAgreCd']:checked").val() != '${baseVo.smsRecptnAgreCd}'){
                 modConts[29] = "[SMS수신여부]";
             }
             </c:if>
             */
             /* <c:if test="${fn:startsWith(baseVo.userTyCd, '20')}">
             if($("input[name='faxRecptnAgreCd']:checked").val() != '${baseVo.faxRecptnAgreCd}'){
                 modConts[29] = "[팩스수신여부]";
             }
             </c:if> */
             modConts = modConts.join(' ');
             modConts = modConts.replace(/\s+|\s+$/g, "");
             modConts = modConts.split("][").join("],[");

             $("#modConts").val(modConts);
         </c:if>
         if(emailChk == "N"){
             jsWarningBox("이메일 중복체크를 해주세요.");
             return false;
         }
         <c:if test="${not empty baseVo}">
         //pwdConfirm(el, '회원 정보 수정', 'U', '', '800', '500', '${baseVo.userId}', '${baseVo.userTyCd}', '', '', $("#modConts").val());
         $("#Form").submit();
         </c:if>
         <c:if test="${empty baseVo}">
         $("#Form").submit();
         </c:if>
     };

    <c:if test="${not empty baseVo}">
    updateSettingOptionDate = [{column:'telno', values:'${baseVo.telno}', separation:'-', lang:''}
                              ,{column:'mbtlnum', values:'${baseVo.mbtlnum}', separation:'-', lang:''}
                              ,{column:'email', values:'${baseVo.email}', separation:'@', lang:''}
                              //,{column:'zip', values:'${baseVo.zip}', separation:'-', lang:''}
                              ,{column:'bizrno', values:'${baseVo.bizrno}', separation:'-', lang:''}
                              ,{column:'cmpnyTelno', values:'${baseVo.cmpnyTelno}', separation:'-', lang:''}
                              ,{column:'pblinsttTelno', values:'${baseVo.pblinsttTelno}', separation:'-', lang:''}
                              //,{column:'cmpnyReprsntTelno', values:'${baseVo.cmpnyReprsntTelno}', separation:'-', lang:''}
                              //,{column:'cmpnyFaxnum', values:'${baseVo.cmpnyFaxnum}', separation:'-', lang:''}
                              //,{column:'cmpnyEmail', values:'${baseVo.cmpnyEmail}', separation:'@', lang:''}
                              //,{column:'cmpnyZip', values:'${baseVo.cmpnyZip}', separation:'-', lang:''}
                              ];
    updateSettingStoreDate = [
                          <c:forEach items="${baseVo.userList}" var="store" varStatus="status">
                              ${!status.first ? ',' : ''}
                              {column:'langStoreNms', values:'${store.langStoreNm}', separation:'', lang:'${store.langCode}'}
                             ,{column:'storeChargerNms', values:'${store.storeChargerNm}', separation:'', lang:'${store.langCode}'}
                             ,{column:'reprsntTelnos', values:'${store.reprsntTelno}', separation:'-', lang:'${store.langCode}'}
                             //,{column:'reprsntEmails', values:'${store.reprsntEmail}', separation:'@', lang:'${store.langCode}'}
                             //,{column:'storeUrls', values:'${store.storeUrl}', separation:'', lang:'${store.langCode}'}
                         </c:forEach>
                             ];
    var settingValue = function(setData) {
        $.each(setData, function (i, item) {
            if(item.separation != ''){
                value = item.values.split(item.separation);
                $.each(value, function (j, item2) {
                    if(item.lang != ''){
                        $("#"+item.column+(j+1)+item.lang).val(item2);
                    } else {
                        $("#"+item.column+(j+1)).val(item2);
                    }
                });
            }
            $("#"+item.column+item.lang).val(item.values);
        });
    };
    </c:if>
    var next = 'N'; <%-- 회사 탭 이동시 기본정보 입력 여부 확인 값 --%>

    var readyTab = function() {
        if($("input[name='userTyCd']:checked").val() == '1002' || $("input[name='userTyCd']:checked").val() == '2002' || $("input[name='userTyCd']:checked").val() == '3002'){
            $("#storeTab").show();
            $("#next").show();
            $("#submit").hide();
            <c:if test="${empty baseVo}">
            if($("input[name='userTyCd']:checked").val() == '1002'){
                $("input[name='langStoreNms']").val($("#userNm").val());
            }else{
                $("input[name='langStoreNms']").val($("#cmpnyNm").val());
            }
            </c:if>
        } else {
            $("#storeTab").hide();
            $("#next").hide();
            $("#submit").show();
        }
        /*  if($("input[name='userTyCd']:checked").val() == '1001' || $("input[name='userTyCd']:checked").val() == '1002'){
            $("#faxRecptnAgre").hide();
            $("#smsRecptnAgre").show();
        } else {
            $("#faxRecptnAgre").show();
            $("#smsRecptnAgre").hide();
        }  */
    };

    var jsStoreLangCode = function(lang){
        if($("input[id='storeLang00']").is(":checked") == true && lang == 'KOR'){
            $("#"+lang).show();
            $(".00 *").attr("disabled",false);
        } else if($("input[id='storeLang01']").is(":checked") == true  && lang == 'ENG') {
            $("#"+lang).show();
            $(".01 *").attr("disabled",false);
        } else if($("input[id='storeLang06']").is(":checked") == true && lang == 'ESP'){
            $("#"+lang).show();
            $(".06 *").attr("disabled",false);
        } 
        <c:if test="${not empty baseVo}">
          else if($("input[id='storeLang00']").is(":checked") == false && lang == 'KOR'){
            checkStoreSales(lang, '00');
        } else if($("input[id='storeLang01']").is(":checked") == false && lang == 'ENG'){
            checkStoreSales(lang, '01');
        } else if($("input[id='storeLang06']").is(":checked") == false && lang == 'ESP'){
            checkStoreSales(lang, '06');
        }
        </c:if>
    };

    var checkStoreSales = function(lang, code){    <%-- 스토어 비활성화시 기존 판매중일 서비스가 있는지 확인 후 경고창 출력 없으면 그냥통과 --%>
        if(confirm("선택 해제를 하면 해당 회사정보가 비활성화 됩니다.")){
            $.ajax({
                url      : "ND_checkStoreSales.do",
                type     : "POST",
                data     : {storeLangCode : code,
                            userId : '${baseVo.userId}'},
                async    : false,
                success  : function (response) {
                    if(response == 'true'){
                        $("#"+lang).hide();
                    }else{
                        if(confirm("등록하신 서비스가 있습니다. 확인을 누르시면 서비스가 비활성화 됩니다.")){
                            $("#"+lang).hide();
                        }else{
                            $("input[id='storeLang"+code+"']").attr("checked", true);
                        }
                    }
                }
            });
        } else {
            $("input[id='storeLang"+code+"']").attr("checked", true);
        }
    };

    var jsTab = function (tab) {
        if($("#email1").val() != '' || $("#email2").val() != ''){
            $("#email").val($("#email1").val()+"@"+$("#email2").val());
        }
        /* if($("#cmpnyEmail1").val() != '' || $("#cmpnyEmail2").val() != ''){
            $("#cmpnyEmail").val($("#cmpnyEmail1").val()+"@"+$("#cmpnyEmail2").val());
        }
        <c:forEach items="${langList}" var="list">
        if($("#reprsntEmails1${list.LANGCD}").val() != '' || $("#reprsntEmails2${list.LANGCD}").val() != ''){
            $("#reprsntEmails${list.LANGCD}").val($("#reprsntEmails1${list.LANGCD}").val()+"@"+$("#reprsntEmails2${list.LANGCD}").val());
        }
        </c:forEach> */
        if(tab == "popup"){
            next = 'N';
            $(".popupStore").hide();
            $(".popup").show();
            $("#next").show();
            $("#submit").hide();
        } else {
            $("#submitYN").val("N");
            $("#Form").submit();
        }
    };

     var userSecurity = function (el) {
        $(el).colorbox({
            title : "보안등급정책",
            href : "PD_userSecurity.do",
            width : "800",
            height : "550",
            iframe : true
        });
    };

     var pwdUseYn = function(){  <%-- 비밀번호 적합성 검사 --%>
         var pwd = $("#userPassword").val();
         var userId = $("#userId").val();
         //var brthdy = $("#brthdy").val();
         var email = $("#email1").val();
         var mbtlnum = $("#mbtlnum").val();
         if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
             $("#userPassword").focus();
             alert(Message.msg.passwordCheck2);
             return false;
         }
<%--          개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수 --%>
         vrtn = validPwd(pwd, userId, brthdy, email, mbtlnum);
         if(vrtn != ''){
             $("#pwdGrade").removeClass("tx_green").addClass("tx_red").html("<b>사용불가</b>");
             $("#userPassword").focus();
             alert(vrtn);
             return false;
         } else {
             $("#pwdGrade").removeClass("tx_red").addClass("tx_green").html("<b>사용가능</b>");
             return true;
         }
     };

    var jsZipcodePop = function (el, zcId, adr1, adr2) {
        $("#zipCodeId").val(zcId);
        $("#baseAddrId").val(adr1);
        $("#detailAddrId").val(adr2);
        $(el).colorbox({
            title : "우편번호 검색",
            href : "/intra/zipcode/PD_searchList.do",
            width : "1000",
            height : "800",
            overlayClose : false,
            escKey : false,
            iframe : true
        }); 
    };

    var idCheck = function(){
        if($("#userId").val().length < 5 || $("#userId").val().length > 15){
            alert("아이디는 5자 이상, 15자 이하로 입력해주세요.");
            return false;
        }
        if(!/^[A-Za-z0-9+]*$/.test($("#userId").val())){
            if(!/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/i.test($("#userId").val())){
                jsWarningBox("아이디는 이메일형식 또는 숫자와 영문을 이용하여 입력해주세요.");
                return false;
            }
        }
        $("#Form").ajaxSubmit({
            url      : "ND_checkDupleId.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if(response == 'true'){
                    idChk = "Y";
                    jsSuccessBox("사용가능한 ID입니다.");
                }else{
                    jsWarningBox("사용불가능한 ID입니다.");
                    $('#userId').focus();
                }
            }
        });
    };

    var emailCheck = function(){
        if($("#email1").val() == '' || $("#email2").val() == ''){
            alert("이메일을 입력해주세요.");
            return false;
        }
        $("#email").val($("#email1").val()+"@"+$("#email2").val());
        $("#Form").ajaxSubmit({
            url      : "ND_emailDupleCheck.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if(response == 'true'){
                    emailChk = "Y";
                    jsSuccessBox("사용가능한 이메일입니다.");
                }else if(response == 'duple'){
                    $('#email1').focus();
                    jsWarningBox(Message.msg.dupEmail);
                }else{
                    $('#email1').focus();
                    jsWarningBox(Message.msg.email);
                }
            }
        });
    };

    var passwordUpdete = function(el, vl1, vl3, vl4){
        $(el).colorbox({
            title  : "비밀번호 변경하기",
            href   : "PD_passwordUpdate.do?userId=" + vl1 + "&email="+vl3+"&mbtlnum="+vl4,
            width  : "100%",
            height : "100%",
            overlayClose : false,
            iframe : true
        });
    };

    //파일 삭제
    var jsFileDelete = function(){
        $("#storeImg").empty();
        $("#multiFiles").attr("disabled",false);
    };

    <c:if test="${not empty baseVo}">
    var jsMemberOut = function(){
        if (confirm("정말 탈퇴시키시겠습니까?\n탈퇴 후 정보 복구가 불가능합니다.")) {
            $.ajax({
                url : "ND_deleteAction.do",
                type : "POST",
                dataType : "json",
                data : { userId : '${baseVo.userId}' , userTyCd : '${baseVo.userTyCd}' },
                success : function(response) {
                    if(response.result) {
                        jsSuccessBox(response.message);
                        parent.location.reload();
                        parent.$.fn.colorbox.close();
                    } else {
                        jsErrorBox(response.message);
                    }
                },
                error :  function(response) {
                    jsSysErrorBox(response.responseText);
                    return;
                }
            });
        }
    };
    </c:if>

    var jsCategoryPop = function(el) {
        $(el).colorbox({
            title  : "관심 카테고리 선택하기",
            href   : "/intra/store/goods/PD_categoryPop.do?PID=UM01",
            width  : "900",
            height : "720",
            overlayClose : false,
            iframe : true
        });
    };

    var jsCtgrySel = function() {
        var ctgryCodes = $("#setCtgryCodes").val();
        $(".goodsCtgry00").empty();
        ctgryCodes = ctgryCodes.split(",");
        var ctgryCodeUrl = "";
        for (var i = 0; i < ctgryCodes.length; i++) {
            if (i > 0) {
                ctgryCodeUrl += "&";
            }
            ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i];
        }
        var url = "/intra/store/goods/ND_ctgrySelect.do?" + ctgryCodeUrl;
        $.post(url,
        function(response){
            if(response.length > 0){
//                 $('table#goodsCtgry tr:gt(0)').remove();
                for (var i = 0; i < response.length; i++) {
                    var htmlVal = "";
                    htmlVal  = '<div id="goodsCtgry_' + response[i].ctgryCode+ '" class="goodsCtgry00"><p>' + response[i].ctgryClNm + response[i].ctgryPath;
                    htmlVal += '<input type="image" id="goodsCtgry_' + response[i].ctgryCode + '" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);"></input></p>';
                    htmlVal += '<input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="' + response[i].ctgryCode + '"></input></div>';
                    $("#goodsCtgry").append(htmlVal);
                }
            }
        });
    };

    var jsCategoryDelete = function(el) {
        event.preventDefault(el);
        if ($('input[id^=goodsCtgry_]').length > 1) {
            $('div#' + el.id).remove();
        } else {
            jsWarningBox("카테고리는 최소 한개 이상 존재해야합니다.");
        }
    };

    var storeNmCheck = function(langCd) {
        if($("#langStoreNms"+langCd).val().length < 2){
            alert(Message.msg.storeNmEmpty);
            $("#langStoreNms"+langCd).focus();
            return false;
        }
        $.ajax({
            url      : "ND_checkDupleStoreNm.do",
            type     : "POST",
            data     : {userId : $("#userId").val(),
                        langCode : langCd,
                        langStoreNm : $("#langStoreNms"+langCd).val()},
            async    : false,
            success  : function (response) {
                if(response == 'false') {
                    jsWarningBox("[ "+$("#langStoreNms"+langCode.value).val()+" ]"+"은 사용중인 회사명입니다.\n 다른 이름으로 바꿔주세요.");
                    $("#storeNmChk_"+langCd).val("N");
                } else {
                    jsSuccessBox("사용가능한 회사명입니다.");
                    $("#storeNmChk_"+langCd).val("Y");
                }
            }
        });
    };

    var storeNmReset = function(langCd) {
        $("#storeNmChk_"+langCd).val("N");
    };

    var readURL = function (input) {    <%-- 업로드 파일 미리보기 --%>
    if (input.files && input.files[0]) {
        fileName = input.files[0].name; // 파일명
        $("#storeImgNm").text(fileName);
        ext = fileName.substring(fileName.lastIndexOf('.') + 1);//확장자
        ext = ext.toLowerCase();
        if(ext != 'gif' && ext != 'jpg' && ext !='jpeg' && ext !='png') {  <%-- 확장자 확인 --%>
            $("#delete").trigger("click");
            alert(ext+Message.msg.fileCannotUplaod);
        } else {
            $("#Form").ajaxSubmit({
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
                    if(response != "100") {
                        alert(response);
                        var control = $("#multiFiles");
                        control.replaceWith(control = control.clone(true));
                    }
                }
            });
        }
    }
};
</script>
</head>
<body>
    <input type="hidden" id="submitYN" value="N"/>
    <input type="hidden" id="langCode" value="00" />
    <input type="hidden" id="setCtgryCodes" value="<c:forEach items="${baseVo.ctgryList}" var="category" varStatus="status">${category.CTGRYCODE}${!status.last? ',' : ''}</c:forEach>" />
    <!-- //관심 카테고리용 세팅 데이터 -->
    <!-- 컨텐츠영역 -->
    <form id="Form" onsubmit="return false;">
    	<input type="hidden" id="pblinsttTelno" name="pblinsttTelno" value="" />
        <input type="hidden" id="zipCodeId" value="" />
        <input type="hidden" id="baseAddrId" value="" />
        <input type="hidden" id="detailAddrId" value="" />
        <input type="hidden" id="telno" name="telno" value="" />
        <input type="hidden" id="mbtlnum" name="mbtlnum" value="" />
        <input type="hidden" id="zip" name="zip" value="" />
        <input type="hidden" id="bizrno" name="bizrno" value="" />
        <input type="hidden" id="cmpnyTelno" name="cmpnyTelno" value="" />
        <input type="hidden" id="cmpnyReprsntTelno" name="cmpnyReprsntTelno" value="" />
        <input type="hidden" id="cmpnyFaxnum" name="cmpnyFaxnum" value="" />
        <input type="hidden" id="cmpnyZip" name="cmpnyZip" value="" />
        <input type="hidden" id="modConts" value="" />
        <input type="hidden" id="intrlTelno" name="intrlTelno" value="" class="intrlTelno"/>

        <div id="tabDiv" style="margin-bottom: -1%;">
            <ul style="margin-bottom: 0px;">
                <li id="infoTab"><a href="#" onclick="jsTab('popup');"><span>기본정보</span></a></li>
                <li id="storeTab" style="display: none;"><a href="#" onclick="jsTab('popupStore');"><span>스토어 판매정보</span></a></li>
            </ul>
        </div>
        <div id="popup" class="popup">
            <!-- 탭 -->
            <!-- //탭 -->
            <!-- 기본정보 -->
            <h2 class="mar_t20">기본정보</h2>
            <fieldset>
                <legend>개인회원등록</legend>
                <table class="boardWrite" cellspacing="0" border="0"
                    summary="개인회원등록을 하실 수 있습니다.">
                    <caption class="hidden">개인회원등록</caption>
                    <colgroup>
                        <col width="10%" />
                        <col width="40%" />
                        <col width="10%" />
                        <col width="40%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th colspan="4">
                                <c:set var="userTy">${param.userTy}01</c:set>
                                <op:code id="userTyCd" type="radio" grpCd="5" defaultValues="${baseVo.userTyCd eq null ? userTy : baseVo.userTyCd}"/>
                            </th>
                        </tr>
                        <%-- <tr>
                            <th><span class="tx_red_s">*</span>국적</th>
                            <td colspan="3">
                                <select id="nationCode" name="nationCode">
                                    <c:forEach items="${nation}" var="list">
                                        <option value="${list.NATIONCODE}" <c:if test="${empty baseVo}">${list.NATIONCODE eq '410' ? 'selected' : ''}</c:if><c:if test="${not empty baseVo}">${baseVo.nationCode eq list.NATIONCODE ? 'selected' : ''}</c:if>>${list.LANGNATIONNM}(${list.INTRLTELNL})</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr> --%>
                        <c:if test="${baseVo.userTyCd eq 2001}">
	                            <tr>
	                                <th>
	                                   <span class="tx_red_s">*</span>
	                                   <label for="cmpnyNm" onblur="readyTab();">기업명</label>
	                                </th>
	                                <td colspan="3">
	                                    <input type="text" id="cmpnyNm" size="20" name="cmpnyNm" value="${baseVo.cmpnyNm eq null ? '' : baseVo.cmpnyNm}" />
	                                </td>
	                            </tr>
	                        
                        </c:if>
                        <tr>
                            <th><c:if test="${empty baseVo}"><span class="tx_red_s">*</span></c:if><label for="userId">아이디</label></th>
                            <td class="tx_blue_s">
                                <input type="text" id="userId" class="w80" name="userId" value="${baseVo.userId eq null ? '' : baseVo.userId}" ${not empty baseVo ? 'readonly' : ''}/> (영문/숫자조합 최대15자)
                                <c:if test="${empty baseVo}">
                                    <button type="button" id="idChk" class="gray_s" onclick="idCheck();return false;">아이디 중복확인</button>
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th><c:if test="${empty baseVo}"><span class="tx_red_s">*</span></c:if><label for="userPassword">비밀번호</label></th>
                            <td colspan="3">
                                <c:if test="${empty baseVo}" >
                                    <input type="password" id="userPassword" class="w80" name="userPassword" title="보안등급에 맞게 비밀번호를 입력해주세요" value="" onchange="pwdUseYn()" />
                                    <p class="tx_blue_s">
                                        - 보안등급 : <span id="pwdGrade" class="tx_red"><b>사용불가</b></span>
                                        (최소 10자, 최대 16자/ 영문(대/소문자), 숫자, 특수문자 조합)&nbsp;&nbsp;
                                        <button type="button" onclick="userSecurity(this);return false;" class="gray_s">보안등급정책</button>
                                        <br /> - 비밀번호 등록 또는 변경시 보안등급을 확인하여 안전하게 변경하시기 바랍니다.
                                    </p>
                                </c:if>
                                <c:if test="${not empty baseVo}">
                                    <a href="#"><button onclick="passwordUpdete(this,'${baseVo.userId}', '${baseVo.email}', '${baseVo.mbtlnum}');return false;" class="gray_s">비밀번호변경</button></a>
                                </c:if>
                            </td>
                        </tr>
                        <c:if test="${empty baseVo}" >
                            <tr>
                                <th><span class="tx_red_s">*</span> <label for="userPassword1">비밀번호 확인</label></th>
                                <td colspan="3">
                                    <input type="password" id="userPassword1" class="w80" name="userPassword1" title="비밀번호와 동일하게 입력해주세요" value="" />
                                </td>
                            </tr>
                        </c:if>
                        	<th><c:if test="${empty baseVo}"><span class="tx_red_s">*</span></c:if><label for="userNm">이름</label></th>
                            <td>
                                <input type="text" id="userNm" class="w80" name="userNm" value="${baseVo.userNm eq null ? '' : baseVo.userNm}" <%-- ${not empty baseVo?'readonly':''} --%> onblur="readyTab();" maxlength="100" />
                            </td>
                        <%-- <tr>
                            <th><span class="tx_red_s">*</span><label for="brthdy">생년월일</label></th>
                            <td>
                                <input type="text" id="brthdy" class="w120" name="brthdy" value="${baseVo.brthdy eq null ? '' : baseVo.brthdy}" maxlength="8" />
                                <span class="tx_blue_s">예) 20141231</span> &nbsp;&nbsp;&nbsp;
                                <op:code id="slrcldLrrLpnhCd" grpCd="74" type="radio" defaultValues="${baseVo.slrcldLrrLpnhCd eq null ? '1001' : baseVo.slrcldLrrLpnhCd}"/>
                            </td>
                            <th><span class="tx_red_s">*</span><label for="sexdstnCd">성별</label></th>
                            <td>
                                <op:code id="sexdstnCd" grpCd="75" type="radio" defaultValues="${baseVo.sexdstnCd eq null ? '1001' : baseVo.sexdstnCd}"/>
                            </td>
                        </tr> --%>
                        <tr>
                            <%--<th><span class="tx_red_s">&nbsp;&nbsp;</span><label for="telno1">전화번호</label></th>
                            <td>
                                <input type="text" class="w55 intrlTelno" title="국가번호를 입력해주세요" maxlength="10" value="${baseVo.intrlTelno}" />&nbsp;
                                <input type="text" id="telno1" class="w55" name="telno1" title="국번을 입력해주세요" maxlength="3" value="" />
                                - <input type="text" id="telno2" class="w55" name="telno2" title="앞자리를 입력해주세요" maxlength="4" value="" />
                                - <input type="text" id="telno3" class="w55" name="telno3" title="전화번호를 입력해주세요" maxlength="4" value="" />
                                &nbsp;내선번호&nbsp;<input type="text" id="lxtnTelno" class="w55" name="lxtnTelno" value="${baseVo.lxtnTelno}" maxlength="4"/>
                            </td> --%>
                            <th><span class="tx_red_s">*</span><label for="mbtlnum1">휴대전화</label></th>
                            <td colspan="3">
                                <input type="text" id="intrlTelno" class="w55 intrlTelno" title="국가번호를 입력해주세요" maxlength="10" value="${baseVo.intrlTelno}" readonly="readonly"/>&nbsp;
                                <input type="text"  id="mbtlnum1" class="w55" name="mbtlnum1" title="앞자리를 입력해주세요" maxlength="3" value="" />
                                - <input type="text"  id="mbtlnum2" class="w55" name="mbtlnum2" title="앞자리를 입력해주세요" maxlength="4" value="" />
                                - <input type="text" id="mbtlnum3" class="w55" name="mbtlnum3" title="전화번호를 입력해주세요" maxlength="4" value="" /><br />
                                <%-- <div id="smsRecptnAgre"><op:code id="smsRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.smsRecptnAgreCd eq null ? '1002' : baseVo.smsRecptnAgreCd}"/>이벤트/정보 SMS 수신에 동의합니다.</div> --%>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="tx_red_s">*</span><label for="email">이메일주소</label></th>
                            <td colspan="3">
                                <input type="text" id="email1" class="w80" name="email1" title="이메일을 입력해주세요" value="" />
                                @ <input type="text" id="email2" class="w120" name="email2" title="도메인을 입력해주세요" value="" />
                                <input type="hidden" id="email" name="email" value="${baseVo.email}" />
                                <op:code id="emailList" grpCd="80" defaultLabel="직접입력"/>
                                <button type="button" id="emailChk" class="gray_s" onclick="emailCheck();return false;">이메일 중복확인</button>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="tx_red_s">*</span><label for="email">이메일 수신동의</label></th>
                            <td colspan="3">광고홍보 이메일&nbsp;<op:code id="emailRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.emailRecptnAgreCd eq null ? '1002' : baseVo.emailRecptnAgreCd}"/>
                            <br/>뉴스레터/세미나&nbsp;<op:code id="nsletRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.nsletRecptnAgreCd eq null ? '1002' : baseVo.nsletRecptnAgreCd}"/>
                            <br/>입찰공고 이메일&nbsp;<op:code id="bidRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.bidRecptnAgreCd eq null ? '1002' : baseVo.bidRecptnAgreCd}"/>
                            </td>
                        </tr>
                      <!--   <tr>
                            <th rowspan="2"><span class="tx_red_s">&nbsp;&nbsp;</span><label for="zip1">주소</label></th>
                            <td colspan="3">우편번호 : <input type="text" id="zip1" class="w80" name="zip1" value="" />
                                - <input type="text" id="zip2" class="w80" name="zip2" value="" />&nbsp;&nbsp; 
                                <button type="button" class="gray_s" onclick="jsZipcodePop(this,'zip','bassAdres','detailAdres');return false;">우편번호찾기</button> <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <input type="text" id="bassAdres" name="bassAdres" value="${baseVo.bassAdres eq null ? '' : baseVo.bassAdres}" />&nbsp;
                                <input type="text" id="detailAdres" name="detailAdres" value="${baseVo.detailAdres eq null ? '' : baseVo.detailAdres}" />
                            </td>
                        </tr> -->
                        <%-- <tr>
                            <th><label for="userGradCode">회원등급</label></th>
                            <td>
                                <select id="userGradCode" name="userGradCode">
                                    <option>--선택--</option>
                                    <c:forEach items="${gradeList}" var="list">
                                        <option value="${list.userGradCode}" <c:if test="${(baseVo.userGradCode eq null && list.userGradCode eq 'generalMber') || baseVo.userGradCode eq list.userGradCode}">selected="selected"</c:if>>${list.userGradNm}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <th><label for="actLevelCd">활동레벨</label></th>
                            <td>
                                <op:code id="actLevelCd" grpCd="101" defaultValues="${baseVo.actLevelCd eq null ? '1003' : baseVo.actLevelCd}"/>
                            </td>
                        </tr>
                        <tr>
                            <th><label for="sbscrbTyCd">가입유형</label></th>
                            <td colspan="3">
                                <op:code id="sbscrbTyCd" grpCd="71" defaultValues="${baseVo.sbscrbTyCd eq null ? '1001' : baseVo.sbscrbTyCd}"/>
                            </td>
                            <th><label for="userGradCode">신청상태</label></th>
                            <td>
                               <op:code id="agremStatCd" grpCd="2035" defaultValues="${baseVo.agremStatCd eq null ? '1001' : baseVo.agremStatCd}"/>
                            </td>
                        </tr> --%>
                    </tbody>
                </table>
            </fieldset>
            <c:if test="${baseVo.userTyCd ne '1001' and baseVo.userTyCd ne '2001'}">
            <h2 class="mar_t20" style="margin-top: 1%;">
            	<c:if test="${baseVo.userTyCd eq '3001'}">기관정보</c:if>
                <c:if test="${baseVo.userTyCd ne '3001'}">회사정보</c:if>
            </h2>
            <fieldset>
                <legend>회사정보등록</legend>
                <table class="boardWrite" cellspacing="0" border="0" summary="회사정보를 하실 수 있습니다.">
                    <caption class="hidden">회사정보 등록</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="80%" />
                    </colgroup>
                    <tbody>
                       <c:if test="${baseVo.userTyCd eq '3001'}">
                            <tr>
                                <th>
                                	<span class="tx_red_s">*</span>
                                    <label onblur="readyTab();">기관명</label>
                                </th>
                                <td>
                                    <input type="text" size="20"  readonly="readonly" value="${baseVo.orgnNm eq null ? '' : baseVo.orgnNm}" />
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${baseVo.userTyCd eq '3001'}">
                            <tr>
                                <th>
                                	<span class="tx_red_s">*</span>
                                    <label onblur="readyTab();">부서명</label>
                                </th>
                                <td>
                                    <input type="text" size="20" readonly="readonly" value="${baseVo.orgnNmSt eq null ? '' : baseVo.orgnNmSt}" />
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${baseVo.userTyCd eq '3001'}">
                            <tr>
                                <th>
                                	<span class="tx_red_s">*</span>
                                    <label for="pblinsttTelno1" onblur="readyTab();">담당자 전화</label>
                                </th>
                                <td>
                                    <input type="text" id="pblinsttTelno1" class="w80" name="pblinsttTelno1" value="" />
                                    - <input type="text" id="pblinsttTelno2" class="w80" name="pblinsttTelno2" value="" />
                                    - <input type="text" id="pblinsttTelno3" class="w80" name="pblinsttTelno3" value="" />
                                </td>
                            </tr>
                        </c:if>
                        <%-- <c:if test="${userSetYn.cmpnyRprsntvNm != 1002}">
                            <tr>
                                <th>
                                    <c:if test="${userSetYn.cmpnyRprsntvNm == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyRprsntvNm">회사 대표자이름</label>
                                </th>
                                <td>
                                    <input type="text" id="cmpnyRprsntvNm" class="w80" name="cmpnyRprsntvNm" value="${baseVo.cmpnyRprsntvNm eq null ? '' : baseVo.cmpnyRprsntvNm}" />
                                </td>
                            </tr>
                        </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyNm != 1002}"> --%>
	                       <c:if test="${fn:endsWith(baseVo.userTyCd, '02')}"> 
	                            <tr>
	                                <th>
                                      <%-- <c:if test="${userSetYn.cmpnyNm == 1003}"> --%>
                                   	 	<span class="tx_red_s">*</span>
	                                  <%-- </c:if> --%>
	                                   <label for="cmpnyNm" onblur="readyTab();">기업명</label>
	                                </th>
	                                <td>
	                                    <input type="text" id="cmpnyNm" size="20" name="cmpnyNm" value="${baseVo.cmpnyNm eq null ? '' : baseVo.cmpnyNm}" />
	                                </td>
	                            </tr>
	                       </c:if>
                        <%-- </c:if> --%>
                        <%-- <c:if test="${userSetYn.bizrno != 1002}"> --%>
                        	<c:if test="${fn:endsWith(baseVo.userTyCd, '02')}">
	                            <tr>
	                                <th>
	                                    <%-- <c:if test="${userSetYn.bizrno == 1003}"> --%>
	                                        <span class="tx_red_s">*</span>
	                                    <%-- </c:if> --%>
	                                    <label for="mailingYn">사업자 등록번호</label>
	                                </th>
	                                <td>
	                                    <input type="text" id="bizrno1" class="w80" name="bizrno1" title="사업자 등록번호 앞 3자리를 입력해주세요" maxlength="3" value="" />
	                                    - <input type="text" id="bizrno2" class="w80" name="bizrno2" title="사업자 등록번호 중간 2자리를 입력해주세요" maxlength="2" value="" />
	                                    - <input type="text" id="bizrno3" class="w80" name="bizrno3" title="사업자 등록번호 뒤 5자리를 입력해주세요" maxlength="5" value="" />
	                                </td>
	                            </tr>
                            </c:if>
                        <%-- </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyTelno != 1002}"> --%>
                        	<c:if test="${fn:endsWith(baseVo.userTyCd, '02')}">
	                            <tr>
	                                <th>
	                                    <%-- <c:if test="${userSetYn.cmpnyTelno == 1003}"> --%>
	                                        <span class="tx_red_s">*</span>
	                                    <%-- </c:if> --%>
	                                    <label for="cmpnyTelno1">회사 전화번호</label>
	                                </th>
	                                <td>
	                                    <input type="text" class="w55 intrlTelno" title="국가번호를 입력해주세요" maxlength="10" value="${baseVo.intrlTelno}" readonly="readonly"/>&nbsp;
	                                    <input type="text" id="cmpnyTelno1" class="w55" name="cmpnyTelno1" title="국번을 입력해주세요" maxlength="3" value="" />
	                                    - <input type="text" id="cmpnyTelno2" class="w55" name="cmpnyTelno2" title="앞자리를 입력해주세요" maxlength="4" value="" />
	                                    - <input type="text" id="cmpnyTelno3" class="w55" name="cmpnyTelno3" title="전화번호를 입력해주세요" maxlength="4" value="" />
	                                    <%-- &nbsp;내선번호&nbsp;<input type="text" id="cmpnyLxtnTelno" class="w55" name="cmpnyLxtnTelno" value="${baseVo.cmpnyLxtnTelno}" maxlength="4"/> --%>
	                                </td>
	                            </tr>
                            </c:if>
                        <%-- </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyReprsntTelno != 1002}">
                            <tr>
                                <th>
                                    <c:if test="${userSetYn.cmpnyReprsntTelno == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyReprsntTelno1">회사 대표전화번호</label>
                                </th>
                                <td>
                                    <input type="text" id="intrlTelno" class="w55 intrlTelno" title="국가번호를 입력해주세요" maxlength="10" value="${baseVo.intrlTelno}" />&nbsp;
                                    <input type="text" id="cmpnyReprsntTelno1" class="w55" name="cmpnyReprsntTelno1" title="국번을 입력해주세요" maxlength="3" value="" />
                                    - <input type="text" id="cmpnyReprsntTelno2" class="w55" name="cmpnyReprsntTelno2" title="앞자리를 입력해주세요" maxlength="4" value="" />
                                    - <input type="text" id="cmpnyReprsntTelno3" class="w55" name="cmpnyReprsntTelno3" title="전화번호를 입력해주세요" maxlength="4" value="" />
                                </td>
                            </tr>
                        </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyFaxnum != 1002}">
                            <tr>
                                <th>
                                    <c:if test="${userSetYn.cmpnyFaxnum == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyFaxnum1">회사 팩스</label>
                                </th>
                                <td>
                                    <input type="text" id="intrlTelno" class="w55 intrlTelno" title="국가번호를 입력해주세요" maxlength="10" value="${baseVo.intrlTelno}" />&nbsp;
                                    <input type="text" id="cmpnyFaxnum1" class="w55" name="cmpnyFaxnum1" title="국번을 입력해주세요" maxlength="3" value="" />
                                    - <input type="text" id="cmpnyFaxnum2" class="w55" name="cmpnyFaxnum2" title="앞자리를 입력해주세요" maxlength="4" value="" />
                                    - <input type="text" id="cmpnyFaxnum3" class="w55" name="cmpnyFaxnum3" title="전화번호를 입력해주세요" maxlength="4" value="" /><br />
                                    <div id="faxRecptnAgre"><op:code id="faxRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.faxRecptnAgreCd eq null ? '1002' : baseVo.faxRecptnAgreCd}"/>이벤트/정보 FAX 수신에 동의합니다.</div>
                                </td>
                            </tr>
                        </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyEmail != 1002}">
                            <tr>
                                <th>
                                    <c:if test="${userSetYn.cmpnyEmail == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyEmail1">회사 이메일주소</label>
                                </th>
                                <td>
                                    <input type="text" id="cmpnyEmail1" class="w80" name="cmpnyEmail1" title="이메일을 입력해주세요" value="" />
                                    @ <input type="text" id="cmpnyEmail2" class="w120" name="cmpnyEmail2" title="도메인을 입력해주세요" value="" />
                                    <input type="hidden" id="cmpnyEmail" name="cmpnyEmail" value="" />
                                    <op:code id="cmpnyEmailList" grpCd="80" defaultLabel="직접입력"/>
                                                <span class="align" style="display: none;">
                                    <br /><op:code id="cmpnyEmailRecptnAgreCd" grpCd="77" type="radio" defaultValues="${baseVo.cmpnyEmailRecptnAgreCd eq null ? '1002' : baseVo.cmpnyEmailRecptnAgreCd}"/>이벤트/정보 이메일 수신에 동의합니다.
                                                </span>
                                </td>
                            </tr>
                        </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyUrl != 1002}">
                            <tr>
                                <th>	
                                    <c:if test="${userSetYn.cmpnyUrl == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyUrl">회사 URL</label>
                                </th>
                                <td>
                                    <input type="text" id="cmpnyUrl" class="w200" name="cmpnyUrl" value="${baseVo.cmpnyUrl eq null ? '' : baseVo.cmpnyUrl}" />
                                </td>
                            </tr>
                        </c:if> --%>
                        <%-- <c:if test="${userSetYn.cmpnyZip != 1002 || userSetYn.cmpnyBassAdres != 1002 || userSetYn.cmpnyDetailAdres != 1002}">
                            <tr>
                                <th rowspan="2">
                                    <c:if test="${userSetYn.cmpnyZip == 1003 || userSetYn.cmpnyBassAdres == 1003 || userSetYn.cmpnyDetailAdres == 1003}">
                                        <span class="tx_red_s">*</span>
                                    </c:if>
                                    <label for="cmpnyZip1">회사 주소</label>
                                </th>
                                <c:if test="${userSetYn.cmpnyZip != 1002}">
                                    <td>
                                              	우편번호 : <input type="text" id="cmpnyZip1" class="w80" name="cmpnyZip1" value="" />
                                        - <input type="text" id="cmpnyZip2" class="w80" name="cmpnyZip2" value="" />&nbsp;&nbsp;
                                        <button type="button" class="gray_s" onclick="jsZipcodePop(this,'cmpnyZip','cmpnyBassAdres','cmpnyDetailAdres');return false;">우편번호찾기</button> <br />
                                    </td>
                                </c:if> 
                            </tr>
                            <tr>
                                <td>
                                    <c:if test="${userSetYn.cmpnyBassAdres != 1002}">
                                        <input type="text" id="cmpnyBassAdres" name="cmpnyBassAdres" value="${baseVo.cmpnyBassAdres eq null ? '' : baseVo.cmpnyBassAdres}" />&nbsp;
                                    </c:if>
                                    <c:if test="${userSetYn.cmpnyDetailAdres != 1002}">
                                        <input type="text" id="cmpnyDetailAdres" name="cmpnyDetailAdres" value="${baseVo.cmpnyDetailAdres eq null ? '' : baseVo.cmpnyDetailAdres}" />
                                    </c:if>
                                </td>
                            </tr>
                        </c:if> --%>
                   </tbody>
                </table>
            </fieldset>
            </c:if>
            <h2 class="mar_t20" style="margin-top: 1%;">관심 카테고리<button type="button" id="categorySelect" onclick="jsCategoryPop(this);return false;" class="blue">선택</button></h2>
            <fieldset>
                <legend>관심분야등록</legend>
                <table class="boardWrite" cellspacing="0" border="0" summary="솔루션/서비스, IT전문가서비스의 선택분야 정보를 제공합니다.">
                    <caption class="hidden">관심분야 등록</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="80%" />
                    </colgroup>
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <th>관심 카테고리</th>
                            <td id="goodsCtgry">
                               <c:forEach items="${baseVo.ctgryList}" var="category">
                                   <div id="goodsCtgry_${category.CTGRYCODE}" class="goodsCtgry${category.CATEGORY_LANGCD}">
                                        <p>${category.CTGRYCLNM}${category.CTGRYPATH}
                                            <input type="image" id="goodsCtgry_${category.CTGRYCODE}" src="/resources/openworks/theme/default/images/btn/btn_r_close.gif" onclick="jsCategoryDelete(this);"></input>
                                        </p>
                                        <input type="hidden" name="ctgryCodes" class="getCtgryCodes" value="${category.CTGRYCODE}" />
                                    </div>
                               </c:forEach>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </fieldset>
            <!-- //기본정보 -->
        </div>
        <div id="popup"  class="popupStore" style="display: none;">
            <!-- 탭 -->
            <!-- //탭 -->
            <!-- 기본정보 -->
            <h2 class="mar_t20">회사정보</h2>
            <fieldset>
                <legend>회사정보등록</legend>
                <table class="boardWrite" cellspacing="0" border="0" summary="회사정보등록을 하실 수 있습니다.">
                    <caption class="hidden">회사정보등록</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="80%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><span class="tx_red_s">*</span>회사이미지</th>
                            <td>
                                <input type="file" name="multiFiles" id="multiFiles" class="w470 multi max-1" value="찾아보기" accept=".gif,.jpg,.jpeg,.png" <c:if test="${not empty baseVo.fileList}">disabled="disabled"</c:if> onchange="readURL(this);"/>
                                <div id="storeImg">
                                    <c:forEach items="${baseVo.fileList}" var="fileVo" varStatus="status">
                                        <a href="#" onclick="jsFileDelete();"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                                        ${fileVo.localNm}<c:set var="fileCnt" value="${status.count}" /><c:set var="storeImageFileSeq" value="${fileVo.fileSeq}" />
                                    </c:forEach>
                                    <input type="hidden" id="uploadFileCnt" value="${fileCnt}" />
                                    <c:if test="${not empty baseVo}">
                                        <input type="hidden" id="storeImageFileSeq" name="storeImageFileSeq" value="${empty storeImageFileSeq ? -1 : storeImageFileSeq}" />
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <th><span class="tx_red_s">*</span>언어선택</th>
                            <td>
                                <c:forEach items="${langList}" var="list">
                                    <input type="checkbox" readonly="readonly" name="storeLangCodes" id="storeLang<c:out value="${list.LANGCD}" />" value="<c:out value="${list.LANGCD}" />" onclick="jsStoreLangCode('<c:out value="${list.LANGENGABRV}" />');"/>
                                    <label for="storeLang<c:out value="${list.LANGCD}" />"><c:out value="${list.LANGNM}" /></label>
                                    <input type="hidden" name="storeActvtyAts" id="storeActvtyAts${list.LANGCD}" value="Y" />
                                </c:forEach>
                            </td>
                        </tr>
                    </tbody>
                    <c:forEach items="${langList}" var="list" varStatus="status">
                        <tbody id="<c:out value="${list.LANGENGABRV}" />" class="storeInfo <c:out value="${list.LANGCD}" />" style="display: none;">
                            <%-- <tr>
                                <th colspan="2"><strong><c:out value="${list.LANGNM}" /></strong></th>
                            </tr> --%>
                            <c:if test="${storeSetYn.langStoreNm != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.langStoreNm == 1003}"><span class="tx_red_s">*</span></c:if>회사명</th>
                                    <td>
                                        <input type="text" name="langStoreNms" id="langStoreNms<c:out value="${list.LANGCD}" />" maxlength="60" onchange="storeNmReset('${list.LANGCD}');"/>
                                        <button type="button" id="storeNmChk${list.LANGCD}" class="gray_s" onclick="storeNmCheck('${list.LANGCD}');return false;">회사명 중복확인</button>
                                        <input type="hidden" id="storeNmChk_${list.LANGCD}" value="${empty baseVo ? 'N' : 'Y'}" />
                                    </td>
                                </tr>
                            </c:if>
                            <%-- <c:if test="${storeSetYn.langStoreIntrcn != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.langStoreIntrcn == 1003}"><span class="tx_red_s">*</span></c:if>회사소개</th>
                                    <td>
                                        <textarea name="langStoreIntrcns" id="langStoreIntrcns<c:out value="${list.LANGCD}" />" style="width: 280px; height: 200px;"><c:if test="${not empty baseVo.userList}"><c:forEach items="${baseVo.userList}" var="store"><c:if test="${store.langCode == list.LANGCD}">${store.langStoreIntrcn}</c:if></c:forEach></c:if></textarea>
                                    </td>
                                </tr>
                            </c:if> --%>
                            <%-- <tr><td colspan="2"><input type="checkbox" id="sameUser<c:out value="${list.LANGENGABRV}" />" /> 동일 정보 적용(개인이름, 전화번호, 이메일주소)</td></tr> --%>
                            <c:if test="${storeSetYn.storeChargerNm != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.storeChargerNm == 1003}"><span class="tx_red_s">*</span></c:if>담당자</th>
                                    <td><input type="text" name="storeChargerNms" id="storeChargerNms<c:out value="${list.LANGCD}" />" maxlength="50"/></td>
                                </tr>
                            </c:if>
                            <c:if test="${storeSetYn.reprsntTelno != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.reprsntTelno == 1003}"><span class="tx_red_s">*</span></c:if>전화번호</th>
                                    <td>
                                        <input type="text" name="reprsntTelnos1" class="w80" id="reprsntTelnos1<c:out value="${list.LANGCD}" />" title="국번을 입력해주세요" maxlength="4" value="" />
                                        - <input type="text" name="reprsntTelnos2" class="w80" id="reprsntTelnos2<c:out value="${list.LANGCD}" />" title="앞자리를 입력해주세요" maxlength="4" value="" />
                                        - <input type="text" name="reprsntTelnos3" class="w80" id="reprsntTelnos3<c:out value="${list.LANGCD}" />" title="전화번호를 입력해주세요" maxlength="4" value="" />
                                        <input type="hidden" name="reprsntTelnos" id="reprsntTelnos${list.LANGCD}" value="" />
                                    </td>
                                </tr>
                            </c:if>
                            <%-- <c:if test="${storeSetYn.reprsntEmail != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.reprsntEmail == 1003}"><span class="tx_red_s">*</span></c:if>이메일주소</th>
                                    <td>
                                        <input type="text" name="reprsntEmails1" class="w80" id="reprsntEmails1<c:out value="${list.LANGCD}" />" title="이메일을 입력해주세요" value="" />
                                        @ <input type="text" name="reprsntEmails2" class="w120" id="reprsntEmails2<c:out value="${list.LANGCD}" />" title="도메인을 입력해주세요" value="" />
                                        <input type="hidden" name="reprsntEmails" id="reprsntEmails${list.LANGCD}" value="" />
                                  </td>
                                </tr>
                            </c:if>
                            <c:if test="${storeSetYn.storeUrl != 1002}">
                                <tr>
                                    <th><c:if test="${storeSetYn.storeUrl == 1003}"><span class="tx_red_s">*</span></c:if>URL(홈/블로그)</th>
                                    <td><input type="text" name="storeUrls" id="storeUrls<c:out value="${list.LANGCD}" />" maxlength="50"/></td>
                                </tr>
                            </c:if> --%>
                        </tbody>
                    </c:forEach>
                </table>
            </fieldset>
        </div>
        <div>
            <c:if test="${not empty baseVo}">
                <div class="float_l">
                    <a href="#">
                       <button type="button" onclick="jsMemberOut();return false;" class="blue">탈퇴</button>
                    </a>
                </div>
            </c:if>
            <div class="float_r">
                <a href="#none" id="next" style="display: none;">
                    <button type="button" onclick="jsTab('popupStore');return false;" class="blue">다음</button>
                </a>
                <a href="#none" id="submit">
                    <button type="button" onclick="jsSubmit(this);return false;" class="blue">${empty baseVo?'등록':'수정'}</button>
                </a>
                <a href="#">
                    <button type="button" onclick="parent.$.fn.colorbox.close();return false;" class="blue">취소</button>
                </a>
            </div>
        </div>
    </form>
    <!-- //컨텐츠영역 -->
</body>
</html>