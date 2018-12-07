<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>비밀번호찾기 1단계</title>
	<op:jsTag type="spi" items="form" />
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
    });

    var jsFindAction = function() {
        var numCheck = /[0-9_^\\s]$/i;
		var $clTy = "";
		
		if(!$("input[id='cla03']").is(":checked") && !$("input[id='cla04']").is(":checked")){
			alert(Message.msg.selectUserTy);
            $("#cla03").focus();
            return false;
        }else{
            if($("input[id='cla03']").is(":checked")){
                $clTy = $("input[id='cla03']:checked").val();
            }else{
                $clTy = $("input[id='cla04']:checked").val();
            }
    	}
        if($("#c_userId").val() == '') {
            alert(Message.msg.emptyId);
            $("#c_userId").focus();
            return false;
        }
        if($("#c_name").val() == '') {
            alert(Message.msg.emptyUserNm);
            $("#c_name").focus();
            return false;
        }
        $("#userId").val($("#c_userId").val());
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
  		$("#email").val("");
  		
        $.post("ND_findPwdAction.do", {
            classify 	: $clTy,
            userId		: $("#userId").val(),
            userNm 		: $("#userNm").val(),
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
		if(!$("input[id='cla01']").is(":checked") && !$("input[id='cla02']").is(":checked")){
			alert(Message.msg.selectUserTy);
            $("#cla01").focus();
            return false;
        }else{
            if($("input[id='cla01']").is(":checked")){
                $clTy = $("input[id='cla01']:checked").val();
            }else{
                $clTy = $("input[id='cla02']:checked").val();
            }
    	}
				
        if($("#e_userId").val() == '') {
            alert(Message.msg.emptyId);
            $("#e_userId").focus();
            return false;
        }
        
        if($("#e_name").val() == '') {
            alert(Message.msg.emptyUserNm);
            $("#e_name").focus();
            return false;
        }
        
        $("#userId").val($("#e_userId").val());
        $("#userNm").val($("#e_name").val());
        
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
	    $.post("ND_findPwdAction.do", {
	    	classify 	: $clTy,
	        userId 		: $("#userId").val(),
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
	    if("" != $(obj).val()){
        	$("#email2").val($("option:selected", obj).text());
        } else {
            $("#email2").val("");
            $("#email2").focus();
        }
	};
    </script>
</head>

<body>
		<!-- content -->
	<form id="resultForm" name="resultForm" method="post" action="BD_findPwd2.do">
		<input type="hidden" id="clTy" name="clTy" />
		<input type="hidden" id="resultId" name="resultId" />
		<input type="hidden" id="regDt" name="regDt" />
		<input type="hidden" id="maskEmail" name="maskEmail" />
	</form>
	<form id="dataForm" name="dataForm" action="BD_findPwdAction.do">
		<input type="hidden" id="userId" name="userId" />
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
				<a href="BD_findId.do">아이디 찾기</a>
				<a href="BD_findPwd.do" class="on">비밀번호 찾기</a>
			</span>
			
			<img src="/cloud_ver2/new_cloud/images/findpw_step_1.png" alt="기본정보 입력" />
		</div>
		<!--// 타이틀 영역 -->
		</section>
	
	<div class="conWrap find_idpw pwInput">
		<h2>기본정보 입력</h2>
		<p>회원가입 시 입력하신 <em>회원님의 이메일</em>으로 조회 하세요.</p>
		
		<ul class="tab_menu">
			<li>
				<a href="#Email" id="Email">이메일</a>
				<div class="tab_con">					
					<table class="tbl_st4">
						<tr>
							<th class="requ">회원구분</th>
							<td>
								<c:out value="${param.classify}" />
								<input type="radio" name="classify" id="cla01" value="1" /><label for="cla01">이용자</label>
								<input type="radio" name="classify" id="cla02" value="2" /><label for="cla02">제공자</label>
							</td>
						</tr>
						<tr>	
							<th class="requ">아이디</th>
							<td><input type="text" id="e_userId"/></td>
						</tr>
						<tr>	
							<th class="requ">이 름</th>
							<td><input type="text" id="e_name"/></td>
						</tr>
						<tr>	
							<th class="requ">이메일</th>
							<td class="email">
								<input type="text" id="email1"/> @ 
								<input type="text" id="email2"/>
								<op:code id="emailList"  langCode="00" grpCd="80" title="이메일 주소 선택" onchange="emailSelected(this);" defaultLabel="-- 직접입력 --"/>
							</td>
						</tr>
					</table>					 
					<div class="btnArea rig">
						<a href="javascript:;" onclick="jsResetAction();return false;" class="btns st2">취소</a>
						<a href="javascript:;" onclick="jsFindAction2();" class="btns st1 icn icnPw">비밀번호 재발급 받기</a>						
					</div>
				</div>
			</li>
			<%-- <li>
				<a href="#handphone" id="handphone">휴대전화</a>
				<div class="tab_con">
					<table class="tbl_st4">
						<tr>
							<th class="requ">회원구분</th>
							<td>
								<input type="radio" name="classify" id="cla03" value="1" /> <label for="cla01">이용자</label>
								<input type="radio" name="classify" id="cla04" value="2" /> <label for="cla02">제공자</label>
							</td>
						</tr>
						<tr>
							<th class="requ">아이디</th>
							<td><input type="text" id="c_userId" /></td>
						</tr>
						<tr>	
							<th class="requ">이 름</th>
							<td><input type="text" id="c_name" /></td>
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
								<input type="text" id="mobile2" maxlength="4"/>
								- 
								<input type="text" id="mobile3" maxlength="4"/>
							</td>
						</tr>
					</table>
					<div class="btnArea rig">
						<a href="javascript:;" onclick="jsResetAction();return false;" class="btns st2">취소</a>
						<a href="javascript:;" onclick="jsFindAction();" class="btns st1 icn icnPw">비밀번호 재발급 받기</a>
					</div>					
				</div>
			</li> --%>
		</ul>
		
	</div>  
	<!--// content -->	
</body>
</html>