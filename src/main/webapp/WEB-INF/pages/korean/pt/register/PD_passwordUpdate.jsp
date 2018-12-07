<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>비밀번호 변경</title>
    <op:jsTag type="openworks" items="web-core"/>
    <op:jsTag type="spi" items="form,validate,colorbox" />
    <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" />
    <script type="text/javascript" src="/resources/openworks/login/js/validationOfPassword.js"></script>
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
<!-- 	  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script> -->
<!--  	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>   -->
<!--   	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  -->
	<script type="text/javascript">
    $().ready(function(){
        $("#passwordForm").validate({
            rules: {
                    userPassword           : { required: true }
                    ,userPassword2         : { required: true, rangelength: [10, 16] }
                    ,confirm_userPassword2 : { required: true, equalTo: "#userPassword2" }
            },
            submitHandler : function(form){
                <%-- 비밀번호 적합성 검사 --%>
                 var pwd = $("#userPassword2").val();
                if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
                    $("#userPassword").focus();
                    alert(Message.msg.passwordCheck2);
                    return false;
                }
                <%--개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수--%>
                vrtn = validPwd(pwd, '${dataVo.userId}', '${dataVo.brthdy}', '${dataVo.email}', '${dataVo.mbtlnum}');
                 if(vrtn != ''){
                    $("#userPassword2").focus();
                    alert(vrtn);
                    return false;
                } else {
                 
                    $(form).ajaxSubmit({
                        url    : "ND_passwordUpdateAction.do",
                        type : "POST",
                        dataType : "json",
                        success : function(response){
                            if(response.result) {
                                alert(Message.msg.updateOk);
                                parent.$.fn.colorbox.close();
                            } else {
                                alert(response.message);
                            }
                        },
                        error : function(xhr, status, error){
                        //	alert("error:"+xhr+"  "+status+" : "+error);
                      	}
                    });
                }
            }
        });
    });
    var jsPasswordSubmit = function() {
        $("#passwordForm").submit();
    }
    var jsCancel = function() {
        parent.$.fn.colorbox.close();
    }
    </script>
</head>

<body class="winPopup pwChng">
<form id="passwordForm" name="passwordForm">
    <h2>비밀번호 변경하기 <a href="#" onclick="jsCancel();">닫기</a></h2>
    <div style="padding:10px 10px 10px 10px;">
		<p>
			개인정보보호와 안전한 서비스 이용을 위해 비밀번호 변경을 안내하고 있습니다. <br />
			비밀번호를 주기적으로 변경하시면 더욱 안전하게 개인정보 및 시스템을 보호할 수 있습니다.
			<i>※ 변경된 비밀번호는 이후 90일간 사용가능합니다. 90일 이후에는 비밀번호를 다시 변경하셔야합니다.</i>
		<p>
		
		<table class="tbl_st4">
			<tr>
				<th>기존 비밀번호</th>
				<td><input type="password" id="userPassword" name="userPassword" title="기존 비밀번호를 입력해주세요" value="" maxlength="32"/></td>						
			</tr>					
			<tr>
				<th>새 비밀번호</th>
				<td><input type="password"  id="userPassword2" name="userPassword2" title="새 비밀번호를 입력해주세요" value="" /></td>
			</tr>					
			<tr>
				<th>새 비밀번호 확인</th>
				<td><input type="password" id="confirm_userPassword2" name="confirm_userPassword2" title="새 비밀번호를 입력해주세요" value=""/></td>
			</tr>
		
		</table>
		
		<ul>
			<li style="padding-bottom:5px;">
				사용 : 10~16자의 영문 대소문자, 숫자, 특수문자로 조합 변경<br />
				(사용 가능한 특수문자 : ! ” # $ % & ’ ( ) * + , - . / : ; &gt; = &lt; ?@ [ \ ] ^ _ ` { | } ~ )
			</li>
			<li>불가 : 현재 비밀번호, 아이디, 동일한 글자 4번 이상, 휴대전화번호</li>
		</ul> 
		<div class="btnArea" style="padding-top:5px;">
			<a href="#"  onclick="jsPasswordSubmit();return false;" class="btns st1">변경하기</a>
			<a href="#"  onclick="jsCancel();" class="btns st1">다음에 변경하기</a>
		</div>
		
	</div>
	</form>
</body>
</html>