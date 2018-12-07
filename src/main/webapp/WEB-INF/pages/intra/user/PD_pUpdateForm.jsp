<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>회원상세정보-개인</title>
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
<script type="text/javascript">
	$().ready(function(){

		$(".tx_red").show();
		$(".tx_green").hide();

		$("#Form").validate({
			rules: {
				 userId : { required: true }
				,jumin1 : { required: true, number: true, minlength: 6 }
				,jumin2	: {	required: true, number: true, minlength: 7 }
				,email1	: {	required: true, maxlength: 70 }
				,email2 : {	required: true, maxlength: 30 }
				<c:if test="${pUserSetYn.telNumUS == 1003}">
				,telNum1 : { required: true, number: true }
				,telNum2 : { required: true, number: true }
				,telNum3 : { required: true, number: true }
				</c:if>
				,mobile1 : { required: true, number: true }
				,mobile2 : { required: true, number: true }
				,mobile3 : { required: true, number: true }
				,zipCode1 : { required: true, number: true }
				,zipCode2 : { required: true, number: true }
				,baseAddr : { required: true, maxlength: 100 }
				,detailAddr : { required: true, maxlength: 100 }
				,birthday : { required: true, minlength: 8, number: true }
			},
			submitHandler : function(form){

				if(${pUserSetYn.juminNumUS} != 1002){
					if($("#jumin1").val() != '' && $("#jumin2").val() != ''){
					var juminNum = $("#jumin1").val() + "-" + $("#jumin2").val();
		 				$("#juminNum").val(juminNum);
					}
			 	}
				if(${pUserSetYn.emailUS} != 1002){
					if($("#email1").val() != '' && $("#email2").val() != ''){
					var email = $("#email1").val() + "@" + $("#email2").val();
						$("#email").val(email);
					}
			 	}
				if(${pUserSetYn.telNumUS} != 1002){
					if($("#telNum1").val() != '' && $("#telNum2").val() != '' && $("#telNum3").val() != ''){
					var telNum = $("#telNum1").val() + "-" + $("#telNum2").val() + "-" + $("#telNum3").val() ;
		 				$("#telNum").val(telNum);
					}
			 	}
			 	if(${pUserSetYn.mobileUS} != 1002){
					if($("#mobile1").val() != '' && $("#mobile2").val() != '' && $("#mobile3").val() != ''){
					var mobile = $("#mobile1").val() + "-" + $("#mobile2").val() + "-" + $("#mobile3").val() ;
		 				$("#mobile").val(mobile);
					}
			 	}
			 	if(${pUserSetYn.addrUS} != 1002){
					if($("#zipCode1").val() != '' && $("#zipCode2").val() != ''){
					var zipCode = $("#zipCode1").val() + "-" + $("#zipCode2").val() ;
		 				$("#zipCode").val(zipCode);
					}
			 	}

	 			$(form).ajaxSubmit({
					url	: "ND_pUpdateAction.do",
					type : "POST",

					success	: function(response){
					    try {
					        if(eval(response)) {
					            jsSuccessBox(Message.msg.updateOk);
					        } else {
					            jsErrorBox(Message.msg.processFail);
					        }
					    } catch (e) {
					        jsSysErrorBox(response, e);
					        return;
					    }
					}
	 			});
 		 	}
 		});
 	});

	var topDataToggle = function(id){
		if(id == "base"){
			self.location.href = "PD_pUpdateForm.do?userId=" + $("#userId").val();
		}else if(id == "add"){
			parent.$.colorbox.resize({width : 900, height : 600});
			self.location.href = "PD_pOptionUpdateForm.do?userId=" + $("#userId").val();
		}else if(id == "mileage"){
			parent.$.colorbox.resize({width : 900, height : 880});
			self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
		}
	};

	var checkedYn = "N";
	var birDateTypes = function(value){
		if(value == "1001" || value == "1002"){
			$("#birDateType3").attr("checked", false);
			$("#birDateType").val(value);
		}else{
			if(checkedYn == 'N'){
				$("#birDateType2").selected();
				$("#birDateType").val(value);
				checkedYn = 'Y';
			}else{
				$("#birDateType").val("1002");
				checkedYn = 'N';
			}
		}
	};

	var emailSelected = function(){
		var emailCd = $("#emailList").val();
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

	var userSecurity = function(el){
		$(el).colorbox({
			title : "보안등급정책",
			href : "PD_userSecurity.do",
			width : "1000",
			height : "550",
			iframe : true
		});
	};

	var pUpdateAction = function(el, userId, userType){
		var returnUrl = "PD_pUpdateAction.do";
		$(el).colorbox({
			title : "개인 회원 상세 정보",
			href : "PD_pwdConfirm.do?userId=" + userId + "&title1=회원 정보 수정&menuType=U&returnUrl=" + returnUrl,
			width : "700",
			height : "550",
			iframe : true
		});
	};

	var pwdUseYn = function(){
		var pwdUseYn = 'Y';
		if($("#userPwd").val().length < 4){
			pwdUseYn = 'N';
		}

		if(pwdUseYn == 'Y'){
			$(".tx_red").hide();
			$(".tx_green").show();
		}else{
			$(".tx_red").show();
			$(".tx_green").hide();
		}
 	};

 	var passwordUpdete = function(el, vl){
		$(el).colorbox({
			title  : "비밀번호 변경하기",
			href   : "PD_passwordUpdate.do?userId=" + vl + "&userType=1001",
			width  : "800",
			height : "600",
			iframe : true
		});
	};

	var pwdConfirm1 = function(el){
 		var sexCon = document.getElementsByName('sex');
		for(i=0; i<sexCon.length; i++){
			if(sexCon[i].checked){
				$("#sexCon").val(sexCon[i].value);
			}
		}

 		var mailingYnCon = document.getElementsByName('mailingYn');
		for (i=0; i<mailingYnCon.length; i++){
			if(mailingYnCon[i].checked){
				$("#mailingYnCon").val(mailingYnCon[i].value);
			}
		}

 		var smsCallYnCon = document.getElementsByName('smsCallYn');
		for(i=0; i<smsCallYnCon.length; i++){
			if(smsCallYnCon[i].checked){
				$("#smsCallYnCon").val(smsCallYnCon[i].value);
			}
		}

 		var userStateCon = document.getElementsByName('userState');
		for(i=0; i<userStateCon.length; i++){
			if(userStateCon[i].checked){
				$("#userStateCon").val(userStateCon[i].value);
			}
		}

		var modConts = new Array();
		if($("#jumin1").val() != $("#jumin1_modItem").val() || $("#jumin2").val() != $("#jumin2_modItem").val()){
			modConts[0] = "[주민번호]";
		}

		if($("#email1").val() != $("#email1_modItem").val() || $("#email2").val() != $("#email2_modItem").val()){
			modConts[1] = "[이메일]";
		}

		if($("#userGradeCd").val() != $("#userGrade_modItem").val()){
			modConts[2] = "[회원등급]";
		}

		if($("#telNum1").val() != $("#telNum1_modItem").val() || $("#telNum2").val() != $("#telNum2_modItem").val() || $("#telNum3").val() != $("#telNum3_modItem").val()){
			modConts[3] = "[전화번호]";
		}

		if($("#mobile1").val() != $("#mobile1_modItem").val() || $("#mobile2").val() != $("#mobile2_modItem").val() || $("#mobile3").val() != $("#mobile3_modItem").val()){
			modConts[4] = "[휴대전화]";
		}

		if($("#zipCode1").val() != $("#zipCode1_modItem").val() || $("#zipCode2").val() != $("#zipCode2_modItem").val()){
			modConts[5] = "[우편번호]";
		}

		if($("#baseAddr").val() != $("#baseAddr_modItem").val() || $("#detailAddr").val() != $("#detailAddr_modItem").val()){
			modConts[6] = "[주소]";
		}

		if($("#birthday").val() != $("#birthday_modItem").val() || $("#birthdayTypeCon").val() != $("#birDateType_modItem").val()){
			modConts[7] = "[생년월일]";
		}

		if($("#sexCon").val() != $("#sex_modItem").val()){
			modConts[8] = "[성별]";
		}

		if($("#mailingYnCon").val() != $("#mailingYn_modItem").val()){
			modConts[9] = "[메일링서비스]";
		}

		if($("#smsCallYnCon").val() != $("#smsCallYn_modItem").val()){
			modConts[10] = "[sms수신]";
		}

		if($("#userStateCon").val() != $("#userState_modItem").val()){
			modConts[11] = "[회원상태]";
		}

		modConts = modConts.join(' ');

		modConts = modConts.replace(/\s+|\s+$/g, "");
		modConts = modConts.split("][").join("],[");

		$("#modConts").val(modConts);

		pwdConfirm(el, '회원 정보 수정', 'U', 'ND_pUpdateAction.do', '800', '850', $("#userId").val(), '', '', $("#modConts").val());
	};

	var userList = function(){
 	   parent.$.fn.colorbox.close();
 	   parent.location.href = "BD_index.do?pwdYn=Y";
 	};

 	var jsZipcodePop = function(el){
		$(el).colorbox({
			title : "우편번호 검색",
			href : "/intra/zipcode/PD_searchList.do",
			width : "700",
			height : "800",
			iframe : true
		});
	};
</script>
</head>
<body>
	<!-- 컨텐츠영역 -->
	<form id="Form" name='Form'>
		<input type="hidden" id="userId" name="userId" value="${dataVo.userId}"/>
		<input type="hidden" id="juminNum" name="juminNum" value="${dataVo.juminNum}"/>
		<input type="hidden" id="email" name="email" value="${dataVo.email}"/>
		<input type="hidden" id="telNum" name="telNum" value="${dataVo.telNum}"/>
		<input type="hidden" id="mobile" name="mobile" value="${dataVo.mobile}"/>
		<input type="hidden" id="zipCode" name="zipCode" value="${dataVo.zipCode}"/>
		<input type="hidden" id="birDateType" name="birDateType" value="${dataVo.birDateType}"/>

		<input type="hidden" id="modConts" name="modConts" value=""/>

		<input type="hidden" id="sexCon" name="sexCon" value=""/>
		<input type="hidden" id="mailingYnCon" name="mailingYnCon" value=""/>
		<input type="hidden" id="smsCallYnCon" name="smsCallYnCon" value=""/>
		<input type="hidden" id="userStateCon" name="userStateCon" value=""/>

		<input type="hidden" id="userId_modItem" name="userId_modItem" value="${dataVo.userId}"/>
		<input type="hidden" id="userNm_modItem" name="userNm_modItem" value="${dataVo.userNm}"/>
		<input type="hidden" id="userPwd_modItem" name="userPwd_modItem" value="${dataVo.userPwd}"/>
		<input type="hidden" id="jumin1_modItem" name="jumin1_modItem" value="${jumin1}"/>
		<input type="hidden" id="jumin2_modItem" name="jumin2_modItem" value="${jumin2}"/>
		<input type="hidden" id="email1_modItem" name="email1_modItem" value="${email1}"/>
		<input type="hidden" id="email2_modItem" name="email2_modItem" value="${email2}"/>
		<input type="hidden" id="userGrade_modItem" name="userGrade_modItem" value="${dataVo.userGradeCd}"/>
		<input type="hidden" id="telNum1_modItem" name="telNum1_modItem" value="${telNum1}"/>
		<input type="hidden" id="telNum2_modItem" name="telNum2_modItem" value="${telNum2}"/>
		<input type="hidden" id="telNum3_modItem" name="telNum3_modItem" value="${telNum3}"/>
		<input type="hidden" id="mobile1_modItem" name="mobile1_modItem" value="${mobile1}"/>
		<input type="hidden" id="mobile2_modItem" name="mobile2_modItem" value="${mobile2}"/>
		<input type="hidden" id="mobile3_modItem" name="mobile3_modItem" value="${mobile3}"/>
		<input type="hidden" id="zipCode1_modItem" name="zipCode1_modItem" value="${zipCode1}"/>
		<input type="hidden" id="zipCode2_modItem" name="zipCode2_modItem" value="${zipCode2}"/>
		<input type="hidden" id="baseAddr_modItem" name="baseAddr_modItem" value="${dataVo.baseAddr}"/>
		<input type="hidden" id="detailAddr_modItem" name="detailAddr_modItem" value="${dataVo.detailAddr}"/>
		<input type="hidden" id="birthday_modItem" name="birthday_modItem" value="${dataVo.birthday}"/>
		<input type="hidden" id="birDateType_modItem" name="birDateType_modItem" value="${dataVo.birDateType}"/>
		<input type="hidden" id="sex_modItem" name="sex_modItem" value="${dataVo.sex}"/>
		<input type="hidden" id="mailingYn_modItem" name="mailingYn_modItem" value="${dataVo.mailingYn}"/>
		<input type="hidden" id="smsCallYn_modItem" name="smsCallYn_modItem" value="${dataVo.smsCallYn}"/>
		<input type="hidden" id="userState_modItem" name="userState_modItem" value="${dataVo.userState}"/>

		<div id="popup">

			<!-- 탭 -->
			<ul class="tab">
				<li><a href="#" id="base" onclick="topDataToggle('base');" class="on">기본정보</a></li>
				<li><a href="#" id="add" onclick="topDataToggle('add');">추가정보</a></li>
				<c:if test="${pUserSetYn.mileageUS != 1002}">
					<li><a href="#" id="mileage" onclick="topDataToggle('mileage');">마일리지정보</a></li>
				</c:if>
			</ul>
			<!-- //탭 -->

			<!-- 기본정보 -->
			<h2 class="mar_t20">기본정보</h2>

			<fieldset>
			<legend>개인회원 상세정보</legend>
			<table class="boardWrite" cellspacing="0" border="0" summary="개인회원등록을 하실 수 있습니다.">
				<caption class="hidden"> 개인회원 상세정보 </caption>
				<colgroup>
					<col width="15%" />
					<col width="35%" />
					<col width="15%" />
					<col width="35%" />
				</colgroup>
				<tbody>
					<tr>
						<th>
							<span class="tx_red_s">*</span>
							<label for="userId">아이디</label>
						</th>
						<td colspan="3" class="tx_blue_s">
							${dataVo.userId}
						</td>
					</tr>
					<tr>
						<th>
							<span class="tx_red_s">*</span>
							<label for="userNm">성명</label>
						</th>
						<td colspan="3">
							${dataVo.userNm}
						</td>
					</tr>
					<tr>
						<th>
							<span class="tx_red_s">*</span>
							<label for="userPwd">비밀번호</label>
						</th>
						<td colspan="3">
							<a href="#"><button onclick="passwordUpdete(this,'${dataVo.userId}');" class="gray_s">비밀번호변경</button></a>
						</td>
					</tr>
					<c:if test="${pUserSetYn.juminNumUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.juminNumUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="jumin1">주민등록번호</label>
							</th>
							<td colspan="3">
								<input type="text" id="jumin1" class="w80" name="jumin1" title="주민번호 앞자리를 입력해주세요." maxlength="6" value="${jumin1}" /> -
								<input type="password" id="jumin2" class="w80" name="jumin2" title="주민번호 뒷자리를 입력해주세요." maxlength="7" value="${jumin2}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.emailUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.emailUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="email">이메일</label>
							</th>
							<td colspan="3">
								<input type="text" id="email1" class="w80" name="email1" title="이메일 아이디를 입력해주세요." value="${email1}" /> @
								<input type="text" id="email2" class="w120" name="email2" title="이메일 도메인을 입력해주세요." value="${email2}" />
								<op:code id="emailList" grpCd="80" onchange="emailSelected();" />
							</td>
						</tr>
					</c:if>
					<tr>
						<th>
							<label for="userGrade">회원등급</label>
						</th>
						<td>
							<select name="userGradeCd" id="userGradeCd">
								<option value="">--선택하세요--</option>
								<c:forEach items="${dataList}" var="_bean">
									<option <c:if test="${_bean.userGradeCd == dataVo.userGradeCd}">selected="selected"</c:if> value="${_bean.userGradeCd}">${_bean.userGradeNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>가입유형</th>
						<td>
							<op:code id="regType" grpCd="71" defaultValues="${dataVo.regType}" />
						</td>
					</tr>
					<c:if test="${pUserSetYn.telNumUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.telNumUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="telNum1">일반전화</label>
							</th>
							<td colspan="3">
								<input type="text" id="telNum1" class="w80" name="telNum1" title="지역번호를 입력해주세요." maxlength="5" value="${telNum1}" /> -
								<input type="text" id="telNum2" class="w80" name="telNum2" title="전화번호 앞자리를 입력해주세요." maxlength="4" value="${telNum2}" /> -
								<input type="text" id="telNum3" class="w80" name="telNum3" title="전화번호 뒷자리를 입력해주세요." maxlength="4" value="${telNum3}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.mobileUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.mobileUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="mobile1">휴대전화</label>
							</th>
							<td colspan="3">
                                <op:code id="mobile1" grpCd="66" defaultValues="${mobile1}" defaultLabel="선택" /> -
								<input type="text" id="mobile2" class="w80" name="mobile2" title="휴대전화 중간 4자리를 입력해주세요." maxlength="4" value="${mobile2}" /> -
								<input type="text" id="mobile3" class="w80" name="mobile3" title="휴대전화 뒤 4자리를 입력해주세요." maxlength="4" value="${mobile3}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.addrUS != 1002}">
						<tr>
							<th rowspan="3">
								<c:if test="${pUserSetYn.addrUS == 1003}"><span class="tx_red_s">*</span></c:if>
								주소
							</th>
							<td colspan="3">우편번호 :
								<input type="text" id="zipCode1" name="zipCode1" value="${zipCode1}" class="w80" maxlength="3" /> -
								<input type="text" id="zipCode2" name="zipCode2" value="${zipCode2}" class="w80" maxlength="3" />
								&nbsp;&nbsp;<button class="gray_s" onclick="jsZipcodePop();return false;">우편번호찾기</button><br />
							</td>
						</tr>
							<tr>
								<td colspan="3">기본주소 :
									<input type="text" id="baseAddr" class="w85_p" name="baseAddr" value="${dataVo.baseAddr}" />
								</td>
							</tr>
							<tr>
								<td colspan="3">상세주소 :
									<input type="text" id="detailAddr" class="w85_p" name="detailAddr" value="${dataVo.detailAddr}" />
								</td>
							</tr>
					</c:if>
					<c:if test="${pUserSetYn.birthdayUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.birthdayUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="birthday">생년월일</label>
							</th>
							<td colspan="3">
								<input type="text" id="birthday" class="w120" name="birthday" value="${dataVo.birthday}" />
								<span class="tx_blue_s">예) 20111115</span> &nbsp;&nbsp;&nbsp;
								<input type="hidden"  id="birthdayTypeCon" value="${dataVo.birDateType}"/>
								<input type="radio" name="birDateType1" id="birDateType1" onclick="birDateTypes('1001')" <c:if test="${dataVo.birDateType == 1001}">checked="checked"</c:if> />
								<label for="birDateType1">양력</label>
								<input type="radio" name="birDateType1" id="birDateType2" onclick="birDateTypes('1002')" <c:if test="${dataVo.birDateType == 1002 || dataVo.birDateType == 1003}">checked="checked"</c:if> />
								<label for="birDateType2">음력</label>
								<input type="checkbox" name="birDateType3" id="birDateType3" onclick="birDateTypes('1003')" <c:if test="${dataVo.birDateType == 1003}">checked="checked"</c:if> />
								<label for="birDateType3">윤달</label>
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.sexUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.sexUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="people">성별</label>
							</th>
							<td colspan="3">
								<op:code id="sex" grpCd="75" type="radio" defaultValues="${dataVo.sex}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.mailingUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.mailingUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="mailingYn">메일링서비스</label>
							</th>
							<td colspan="3">
								<op:code id="mailingYn" grpCd="76" type="radio" defaultValues="${dataVo.mailingYn}" />
							</td>
						</tr>
					</c:if>
					<c:if test="${pUserSetYn.smsCallUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.smsCallUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="smsCallYn">sms수신</label>
							</th>
							<td colspan="3">
								<op:code id="smsCallYn" grpCd="77" type="radio" defaultValues="${dataVo.smsCallYn}" />
							</td>
						</tr>
					</c:if>
					<tr>
						<th>
							<label for="userState">회원상태</label>
						</th>
						<td colspan="3">
							<op:code id="userState" grpCd="73" type="radio" defaultValues="${dataVo.userState}" />
						</td>
					</tr>
					<tr>
						<th>
							<label for="regDtm">가입일시</label>
						</th>
						<td>${dataVo.regDtm}</td>
						<th>
							<label for="regDtm">최근로그인일시</label>
						</th>
						<td>${dataVo.latestLoginDtm}</td>
					</tr>
				</tbody>
			</table>
			</fieldset>
			<!-- //기본정보 -->

			<p class="tx_c mar_t20">
				<a href="#">
					<button type="button" onclick="pwdConfirm1(this);" class="blue">수정</button>
					</a>
				<a href="#">
					<button type="button" onclick="userList();" class="blue">취소</button>
				</a>
			</p>

		</div>
	</form>
	<!-- //컨텐츠영역 -->

</body>
</html>