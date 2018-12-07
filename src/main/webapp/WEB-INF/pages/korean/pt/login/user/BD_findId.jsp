<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>아이디찾기 1단계</title>

	<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
    <script type="text/javascript">
    var enterEvent = function(e) {
        if(e.keyCode == 13) {
            return jsFindAction();
        }
    };
    
    $().ready(function() {
        $("#birth").bind("keypress", {}, enterEvent);
        $("#mobile1").bind("keypress", {}, enterEvent);
        $("#mobile2").bind("keypress", {}, enterEvent);
        $("#mobile3").bind("keypress", {}, enterEvent);
        $("#email1").bind("keypress", {}, enterEvent);
        $("#c_email1").bind("keypress", {}, enterEvent);
    });

    var jsFindAction = function() {
        var numCheck = /[0-9_^\\s]$/i;
		var $clTy = "";
		if($("#handphone").parent().is(".on")){
			if(!$("input[name='classify']").is(":checked")){
				alert(Message.msg.selectUserTy);
	            $("#cla01").focus();
	            return false;
	        }else{
	            $clTy = $("input[name='classify']:checked").val();
	        }  
		}  
        if($("#c_name").val() == '') {
        	alert(Message.msg.emptyUserNm);
            $("#c_name").focus();
            return false;
        }
        
        $("#userNm").val($("#c_name").val());
                
        if($("#mobile1").val() == '') {
        	alert(Message.msg.emptyMobile);
            $("#mobile1").focus();
            return false;
        }
        
        if (!numCheck.test($("#mobile1").val())){
        	alert(Message.msg.mobileNumberOnly);
        	$("#mobile1").focus();
        	return false;
        }
        
        if ( $("#mobile1").val().length != 3 ) {
        	alert(Message.msg.mobileExactlyEnter);
            $("#mobile1").focus();
            return false;
        }
        
        if($("#mobile2").val() == '') {
        	alert(Message.msg.emptyMobile);
            $("#mobile2").focus();
            return false;
        }
        
        if ( !numCheck.test($("#mobile2").val()) ){
        	alert(Message.msg.mobileNumberOnly);
    		$("#mobile2").focus();
    		return false;
        }
        
        if ( $("#mobile2").val().length < 3 || $("#mobile2").val().length > 4 ) {
        	alert(Message.msg.mobileChar);
    		$("#mobile2").focus();
    		return false;
        }
        
        if($("#mobile3").val() == '') {
        	alert(Message.msg.emptyMobile);
            $("#mobile3").focus();
            return false;
        }
        
        if ( !numCheck.test($("#mobile3").val()) ){
        	alert(Message.msg.mobileNumberOnly);
        	$("#mobile3").focus();
        	return false;
        }
        
        if ( $("#mobile3").val().length != 4 ) {
        	alert(Message.msg.mobileExactlyEnter);
            $("#mobile3").focus();
            return false;
        }
        
        $("#mbtlnum").val($("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val());
        $("#brthdy").val("");
        $("#sexdstnCd").val("");
        $.post("ND_findIdAction.do", {
        	classify 	: $clTy,
            userNm 		: $("#userNm").val(),
            /* email 		: $("#email").val(), */
            mbtlnum 	: $("#mbtlnum").val()  
        }, function(response) {
        	if(response != "0") {
            	var res1 = response.split(",")[0];
                var res2 = response.split(",")[1];
                var res3 = response.split(",")[2];
                $("#clTy").val($clTy);
                $("#resultId").val(res1);
                $("#regDt").val(res2);
                $("#maskEmail").val(res3);
                document.resultForm.submit();
            } else {
            	alert(Message.msg.notFoundId);
            }
        });
        return false;
    };
    
	var jsFindAction2 = function() {
    	var numCheck = /[0-9_^\\s]$/i;
		var $clTy = "";

		if($("#eporita").parent().is(".on")){
			if(!$("input[name='classify']").is(":checked")){
				alert(Message.msg.selectUserTy);
	            $("#cla01").focus();
	            return false;
	        }else{
	            $clTy = $("input[name='classify']:checked").val();
	        }  
		}
        
		if($("#b_name").val() == '') {
        	alert(Message.msg.emptyUserNm);
            $("#b_name").focus();
            return false;
		}
        
		$("#userNm").val($("#b_name").val());
        
		if($("#email1").val() == '' || $("#email2").val() == ''){
        	alert(Message.msg.emptyEmail);
        	return false;
        }

		//이메일 유효성체크
        $("#email").val($("#email1").val()+"@"+$("#email2").val());
        
		if($.trim($("#email").val()) != ''){
			var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		    if(!emailExp.test($('#email').val())){
		    	alert(Message.msg.validEmail);
		        $('#email').focus();
		        return false;
		    }
		}
        
		$("#brthdy").val("");
		$("#mbtlnum").val("");
		
		$.post("ND_findIdAction.do", {
			classify 	: $clTy,
		    userNm 		: $("#userNm").val(),
            email 		: $("#email").val()
        }, function(response) {
        	if(response != "0") {
            	var res1 = response.split(",")[0];
                var res2 = response.split(",")[1];
                var res3 = response.split(",")[2];
                $("#clTy").val($clTy);
                $("#resultId").val(res1);
                $("#regDt").val(res2);
                $("#maskEmail").val(res3);
                document.resultForm.submit();
            } else {
            	alert(Message.msg.notFoundId);
            }
        });
        return false;
    };

	var jsResetAction = function() {
	    history.back(-1);
	};

	var emailSelected = function(obj){
        var emailCd = $(obj).val();
        if(emailCd == 1001){
            emailNm = "naver.com";
        }else if(emailCd == 1002){
            emailNm = "hanmail.net";
        }else if(emailCd == 1003){
            emailNm = "gmail.com";
        }else if(emailCd == 1004){
            emailNm = "hotmail.com";
        }else if(emailCd == 1005){
            emailNm = "nate.com";
        }else if(emailCd == 1006){
            emailNm = "hanmir.com";
        }else if(emailCd == 1007){
            emailNm = "hitel.net";
        }else if(emailCd == 1008){
            emailNm = "chol.com";
        }else if(emailCd == 1009){
            emailNm = "dreamwiz.com";
        }else if(emailCd == 1010){
            emailNm = "empal.com";
        }else if(emailCd == 1011){
            emailNm = "freechal.com";
        }else if(emailCd == 1012){
            emailNm = "hdsmail.co.kr";
        }else if(emailCd == 1013){
            emailNm = "korea.com";
        }else if(emailCd == 1014){
            emailNm = "lycos.co.kr";
        }else if(emailCd == 1015){
            emailNm = "netian.com";
        }else if(emailCd == 1016){
            emailNm = "qook.co.kr";
        }else if(emailCd == 1017){
            emailNm = "yahoo.co.kr";
        }else if(emailCd == 1018){
        	emailNm = "yahoo.com";
        }
		$("#email2").val(emailNm);
	};
		
	/* 전체 아이디 이메일 발송 추가 */
	var jsFindSend = function(){
	    var numCheck = /[0-9_^\\s]$/i;
		var $clTy = "";

		if($("#eporita").parent().is(".on")){
			if(!$("input[name='classify']").is(":checked")){
				alert(Message.msg.selectUserTy);
	            $("#cla01").focus();
	            return false;
	        }else{
	            $clTy = $("input[name='classify']:checked").val();
	        }  
		}
        
		if($("#b_name").val() == '') {
        	alert(Message.msg.emptyUserNm);
            $("#b_name").focus();
            return false;
		}
        
		$("#userNm").val($("#b_name").val());
        
		if($("#email1").val() == '' || $("#email2").val() == ''){
        	alert(Message.msg.emptyEmail);
        	return false;
        }

		//이메일 유효성체크
        $("#email").val($("#email1").val()+"@"+$("#email2").val());
        
		if($.trim($("#email").val()) != ''){
			var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		    if(!emailExp.test($('#email').val())){
		    	alert(Message.msg.validEmail);
		        $('#email').focus();
		        return false;
		    }
		}
        
		$("#brthdy").val("");
		$("#mbtlnum").val("");
		
		$.post("ND_findIdAction.do", {
			classify 	: $clTy,
		    userNm 		: $("#userNm").val(),
            email 		: $("#email").val()
        }, function(response) {
        	if(response != "0") {
        	    $.post("ND_findIdMailSend.do", {
                  	email : $("#email").val()
	              	}, function(response) {
	                  	if(response) {
	                   	alert(Message.msg.sendMailSucc);
	                      	top.location.href = "/korean/pt/index.do";
	                  	} else {
	                      	alert(Message.msg.sendMailFail);
	                  	}
	    		});
            } else {
            	alert(Message.msg.notFoundId);
            }
        });
        return false;
	};
	
	</script>
</head>

<body>
	<form id="resultForm" name="resultForm" method="post" action="BD_findId2.do">
		<input type="hidden" id="clTy" name="clTy" />
		<input type="hidden" id="resultId" name="resultId" />
		<input type="hidden" id="regDt" name="regDt" />
		<input type="hidden" id="maskEmail" name="maskEmail" />
	</form>
	<form id="dataForm" name="dataForm" action="BD_findIdAction.do">
		<input type="hidden" id="userNm" name="userNm" />
		<input type="hidden" id="email" name="email" />
		<input type="hidden" id="brthdy" name="brthdy" />
		<input type="hidden" id="sexdstnCd" name="sexdstnCd" />
		<input type="hidden" id="mbtlnum" name="mbtlnum" />
	</form>
	
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<span>
				<a href="BD_findId.do" class="on">아이디 찾기</a>
				<a href="BD_findPwd.do">비밀번호 찾기</a>
			</span>
			
			<img src="/cloud_ver2/new_cloud/images/findid_step_1.png" alt="기본정보 입력" />
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap find_idpw idInput">
		<h2>기본정보 입력</h2>
		<p>회원가입 시 입력하신 <em>회원님의 이메일</em>으로 조회 하세요.</p>
		
		<ul class="tab_menu">
			<li>
				<a href="#email" id="eporita">이메일</a>
				<div class="tab_con" id="teb_em">
					<table class="tbl_st4">
						<tr>
							<th class="requ">회원구분</th>
							<td>
								<input type="radio" name="classify" id="cla01" value="1" /> <label for="cla01">이용자</label>
								<input type="radio" name="classify" id="cla02" value="2" /> <label for="cla02">제공자</label>
							</td>							
						</tr>
						<tr>
							<th class="requ">이 름</th>
							<td><input type="text" id="b_name"/></td>
						</tr>
						<tr>	
							<th class="requ">이메일</th>
							<td class="email">
								<input type="text" id="email1"/> @ 
								<input type="text" id="email2"/>
								<op:code id="emailList" langCode="00" grpCd="80" onchange="emailSelected(this)" defaultLabel="-- 직접입력 --"/>
							</td>
						</tr>
					</table>
					<div class="btnArea rig">
						<a href="javascript:;" onclick="jsResetAction();return false;" class="btns st2">취소</a>
						<a href="javascript:;" onclick="jsFindAction2();" class="btns st1 icn icnSearch">아이디 앞3자리 찾기</a>
						<a href="javascript:;" onclick="jsFindSend();" class="btns st1 icn icnEmail">전체 아이디 이메일로 받기</a>						
					</div>				
				</div>
			</li>
			<%-- <li>
				<a href="#handphone" id="handphone">휴대전화</a>
				<div class="tab_con" id="teb_hp">
					<table class="tbl_st4">
						<tr>
							<th class="requ">회원구분</th>
							<td>
								<input type="radio" name="classify" id="cla01" value="1" /> <label for="cla01">이용자</label>
								<input type="radio" name="classify" id="cla02" value="2" /> <label for="cla02">제공자</label>
							</td>
						</tr>
						<tr>	
							<th class="requ">이 름</th>
							<td><input type="text" id="c_name"/></td>
						</tr>
						<tr>	
							<th class="requ">휴대전화</th>
							<td class="tel">
								<select id="mobile1" name="selected">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>									
								</select>
								-
								<input type="text" id="mobile2" maxlength="4" title="휴대전화 가운데 자리 입력" />
								- 
								<input type="text" id="mobile3" maxlength="4" title="휴대전화 마지막 자리 입력" />
							</td>
						</tr>
					</table>
					<div class="btnArea rig">
						<a href="javascript:;" onclick="jsResetAction();return false;" class="btns st2">취소</a>
						<a href="javascript:;" onclick="jsFindAction();" class="btns st1 icn icnSearch">아이디 앞3자리 찾기</a>
						<a href="javascript:;" onclick="jsFindSend();" class="btns st1 icn icnEmail">전체 아이디 이메일로 받기</a>
					</div>
				</div>
			</li> --%>
		</ul>
	</div>
	<!--// content -->	
</body>
</html>