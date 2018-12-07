<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>추가정보등록 - 개인</title>
<op:jsTag type="spi" items="form,validate,colorbox" />
 
<script type="text/javascript" src="<c:url value="/resources/intra/js/user.pwdConfirm.js" />"></script>
 
<script type="text/javascript">
$().ready(function(){
	
	$("#Form").validate({
		rules: {
			 userId	: { required: true }
			,wpNm : { maxlength: 30 }
			,gradeNm : { maxlength: 30 }
			<c:if test="${pUserSetYn.wpAddrUS eq 1003}">
			,wpZipCode1	: {	required: true, number: true }
			,wpZipCode2	: { required: true, number: true }
			,wpBaseAddr	: { required: true, maxlength: 100 }
			,wpDetailAddr : { required: true, maxlength: 100 }
			</c:if>
			<c:if test="${pUserSetYn.wpTelNumUS eq 1003}">
			,wpTelNum1 : { number: true }
			,wpTelNum2 : { number: true }
			,wpTelNum3 : { number: true }
			</c:if>
		},

		submitHandler : function(form){
			if(${pUserSetYn.wpTelNumUS} != 1002){
				if($("#wpTelNum1").val() != '' && $("#wpTelNum2").val() != '' && $("#wpTelNum3").val() != ''){
					var wpTelNum = $("#wpTelNum1").val() + "-" + $("#wpTelNum2").val() + "-" + $("#wpTelNum3").val();
					$("#wpTelNum").val(wpTelNum);
				}
			}
			if(${pUserSetYn.wpAddrUS} != 1002){
				if($("#wpZipCode1").val() != '' && $("#wpZipCode2").val() != ''){
					var wpZipCode = $("#wpZipCode1").val() + "-" + $("#wpZipCode2").val() ;
					$("#wpZipCode").val(wpZipCode);
				}
			}

			$(form).ajaxSubmit({
				url : "ND_pOptionUpdateAction.do",
				type : "POST",
				success : function(response){
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
		parent.$.colorbox.resize({width : 900, height : 870});
		self.location.href = "PD_pUpdateForm.do?userId=" + $("#userId").val();
	}else if(id == "add"){
		self.location.href = "PD_pOptionUpdateForm.do?userId=" + $("#userId").val();
	}else if(id == "mileage"){
		parent.$.colorbox.resize({width : 900, height : 880});
		self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
	}
};

var pwdConfirm1 = function(el){
	var marriageYnCon = document.getElementsByName('marriageYn');

	for(i=0; i<marriageYnCon.length; i++){
		if(marriageYnCon[i].checked){
			$("#marriageYnCon").val(marriageYnCon[i].value);
		}
	}

	var modConts = new Array();
	if($("#education").val() != $("#education_modItem").val()){
		modConts[0] = "[최종학력]";
	}
	if($("#marriageYnCon").val() != $("#marriageYn_modItem").val()){	
		modConts[1] = "[결혼유무]";
	}
	if($("#wpNm").val() != $("#wpNm_modItem").val()){
		modConts[2] = "[직장명]";
	}
	if($("#gradeNm").val() != $("#gradeNm_modItem").val()){
		modConts[3] = "[직책]";
	}
	if($("#wpZipCode1").val() != $("#wpZipCode1_modItem").val() || $("#wpZipCode2").val() != $("#wpZipCode2_modItem").val()){
		modConts[4] = "[직장우편번호]";
	}
	if($("#wpBaseAddr").val() != $("#wpBaseAddr_modItem").val() || $("#wpDetailAddr").val() != $("#wpDetailAddr_modItem").val()){
		modConts[5] = "[직장주소]";
	}
	if($("#wpTelNum1").val() != $("#wpTelNum1_modItem").val() || $("#wpTelNum2").val() != $("#wpTelNum2_modItem").val() || $("#wpTelNum3").val() != $("#wpTelNum3_modItem").val()){
		modConts[6] = "[직장전화번호]";
	}
	if($("#interestItem").val() != $("#interestItem_modItem").val()){
		modConts[7] = "[관심항목]";
	}

	modConts = modConts.join(' ');

	modConts = modConts.replace(/\s+|\s+$/g, "");
	modConts = modConts.split("][").join("],[");

	$("#modConts").val(modConts);

	var interestItem ='';
	var selectedItem = jsCheckedArray();
	interestItem = $.makeArray(selectedItem);
	$("#interestItem").val(interestItem);

	pwdConfirm(el, '회원 정보 수정', 'U', 'ND_pUpdateAction.do', '800', '850', $("#userId").val(),'','',$("#modConts").val());
};

var jsCheckedArray = function(){
	var selectedItem = new Array();
	$("body input.checkbox:checked").each(function(i){
		selectedItem[i] = $(this).val();
	});
	return selectedItem;
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
	<form id="Form">
		<input type="hidden" id="userId" name="userId" value="${param.userId }"/>
		<input type="hidden" id="wpTelNum" name="wpTelNum" value=""/>
		<input type="hidden" id="wpZipCode" name="wpZipCode" value=""/>
		<input type="hidden" id="interestItem" name="interestItem" value=""/>

		<input type="hidden" id="modConts" name="modConts" value=""/>

		<input type="hidden" id="marriageYnCon" name="marriageYnCon" value=""/>

		<input type="hidden" id="education_modItem" name="education_modItem" value="${dataVo.education}"/>
		<input type="hidden" id="marriageYn_modItem" name="marriageYn_modItem" value="${dataVo.marriageYn}"/>
		<input type="hidden" id="wpNm_modItem" name="wpNm_modItem" value="${dataVo.wpNm}"/>
		<input type="hidden" id="gradeNm_modItem" name="gradeNm_modItem" value="${dataVo.gradeNm}"/>
		<input type="hidden" id="wpZipCode1_modItem" name="wpZipCode1_modItem" value="${wpZipCode1}"/>
		<input type="hidden" id="wpZipCode2_modItem" name="wpZipCode2_modItem" value="${wpZipCode2}"/>
		<input type="hidden" id="wpBaseAddr_modItem" name="wpBaseAddr_modItem" value="${dataVo.wpBaseAddr}"/>
		<input type="hidden" id="wpDetailAddr_modItem" name="wpDetailAddr_modItem" value="${dataVo.wpDetailAddr}"/>
		<input type="hidden" id="wpTelNum1_modItem" name="wpTelNum1_modItem" value="${wpTelNum1}"/>
		<input type="hidden" id="wpTelNum2_modItem" name="wpTelNum2_modItem" value="${wpTelNum2}"/>
		<input type="hidden" id="wpTelNum3_modItem" name="wpTelNum3_modItem" value="${wpTelNum3}"/>
		<input type="hidden" id="interestItem_modItem" name="interestItem_modItem" value="${dataVo.interestItem}"/>

		<div id="popup">

			<!-- 탭 -->
			<ul class="tab">
				<li><a href="#" id="base" onclick="topDataToggle('base');" >기본정보</a></li>
				<li><a href="#" id="add" onclick="topDataToggle('add');" class="on" >추가정보</a></li>
				<c:if test="${pUserSetYn.mileageUS != 1002 }">
				<li><a href="#" id="mileage" onclick="topDataToggle('mileage');" >마일리지정보</a></li>
				</c:if>
			</ul>
			<!-- //탭 -->

			<!-- 기본정보 -->
			<h2 class="mar_t20">추가정보</h2>

			<fieldset>
				<legend>추가정보상세</legend>
				<table class="boardWrite" cellspacing="0" border="0" summary="추가정보등록을 하실 수 있습니다.">
					<caption class="hidden"> 개인회원 추가상세정보 </caption>
					<colgroup>
						<col width="15%" />
						<col width="" />
					</colgroup>
					<tbody>
						<c:if test="${pUserSetYn.educationUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.educationUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="education">최종학력</label>
							</th>
							<td>
							<op:code id="education" grpCd="78" defaultValues="${dataVo.education}" defaultLabel="-선택-"/>
							</td>
						</tr>
						</c:if>
						<c:if test="${pUserSetYn.marriageUS != 1002}">
						<tr>
							<th>
								<c:if test="${pUserSetYn.marriageUS == 1003}"><span class="tx_red_s">*</span></c:if>
								<label for="marriageYn">결혼유무</label>
							</th>
							<td>
								<op:code id="marriageYn" grpCd="79" type="radio" defaultValues="${dataVo.marriageYn}" />
							</td>
						</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpNmUS != 1002}">
							<tr>
								<th><label for="wpNm">직장명</label></th>
								<td><input type="text" id="wpNm" class="w120" name="wpNm" title="직장명을 입력해주세요" value="${dataVo.wpNm}" /></td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.gradeNmUS != 1002}">
							<tr>
								<th>
									<c:if test="${pUserSetYn.gradeNmUS == 1003}"><span class="tx_red_s">*</span></c:if>
									<label for="gradeNm">직책</label>
								</th>
								<td><input type="text" id="gradeNm" class="w120" name="gradeNm" title="직책을 입력해주세요" value="${dataVo.gradeNm}" /></td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpAddrUS != 1002}">
							<tr>
								<th rowspan="3">
									<c:if test="${pUserSetYn.wpAddrUS == 1003}"><span class="tx_red_s">*</span></c:if>
									직장주소
								</th>
								<td>우편번호 : 
									<input type="text" id="wpZipCode1" name="wpZipCode1" value="${wpZipCode1}" class="w80" maxlength="3" /> - 
									<input type="text" id="wpZipCode2" name="wpZipCode2" value="${wpZipCode2}" class="w80" maxlength="3"/> 
									&nbsp;&nbsp;<button class="gray_s" onclick="jsZipcodePop();return false;">우편번호찾기</button><br />
								</td>
							</tr>
							<tr>
								<td>기본주소 : 
									<input type="text" id="wpBaseAddr" class="w85_p" name="wpBaseAddr" value="${dataVo.wpBaseAddr}" />
								</td>
							</tr>
							<tr>
								<td>상세주소 : 
									<input type="text" id="wpDetailAddr" class="w85_p" name="wpDetailAddr" value="${dataVo.wpDetailAddr}" />
								</td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpTelNumUS != 1002}">
							<tr>
								<th>
									<c:if test="${pUserSetYn.wpTelNumUS == 1003}"><span class="tx_red_s">*</span></c:if>
									<label for="wpTelNum1">직장전화번호</label>
								</th>
								<td>
									<input type="text" id="wpTelNum1" class="w80" name="wpTelNum1" title="지역번호를 선택해주세요" maxlength="5" value="${wpTelNum1}" /> -
									<input type="text" id="wpTelNum2" class="w80" name="wpTelNum2" title="앞자리를 입력해주세요" maxlength="4" value="${wpTelNum2}" /> - 
									<input type="text" id="wpTelNum3" class="w80" name="wpTelNum3" title="전화번호를 입력해주세요" maxlength="4" value="${wpTelNum3}" />
								</td>
							</tr>
						</c:if>
						<tr>
							<th>관심항목</th>
							<td>
								<ul class="mem_item">
									<c:set var="i" value="${fn:split(dataVo.interestItem, ',')}"/>
									<c:forEach items="${list}" var="item" varStatus="status">
										<c:if test="${item.userGubun eq 'P'}">
										<li>
											<input type="checkbox" name="useYn${item.itemNm}" id="useYn${item.itemNm}" value="${item.itemNm}" class="checkbox"
											<c:forEach items="${i}" var="loop1" varStatus="status1">
												<c:if test="${i[status1.index] == item.itemNm}">checked="checked"</c:if>
											</c:forEach> />
											<input type="hidden" name="useYn${item.seq}" id="useYn${item.seq}" value="${item.seq}"/> 
											<label for="useYn${item.seq}">${item.itemNm}</label>
										</li>
										</c:if>
									</c:forEach>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
			<!-- //기본정보 -->

			<p class="tx_c mar_t20">
				<a href="#"><button type="button" onclick="pwdConfirm1(this);" class="blue">수정</button></a>
				<a href="#"><button type="button" onclick="userList();" class="blue">취소</button></a>
			</p>

		</div>
		<!-- //컨텐츠영역 -->
	</form>
</body>
</html>