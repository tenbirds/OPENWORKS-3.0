<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>회원관리 | 회원관리 | 추가정보등록 - 개인</title>
<op:jsTag type="spi" items="form,validate,colorbox" />
 
 <script type="text/javascript">
 $().ready(function() {
	 
		$("#Form").validate({
		    rules: {
		    	 userId			: { required: true }
// 				<c:if test="${pUserSetYn.wpNmUS != 1002 }">
		        ,wpNm 			:{ maxlength: 30 }
// 		        </c:if>
// 		        <c:if test="${pUserSetYn.gradeNmUS != 1002 }">
		        ,gradeNm 		:{ maxlength: 30 }
// 		        </c:if>
// 		    	<c:if test="${pUserSetYn.wpAddrUS != 1002 }">
 				,wpZipCode1	: { 
//  					<c:if test="${pUserSetYn.wpAddrUS == 1003 }">
 						required: true,
//  					</c:if> 
 					number: true }		
 				,wpZipCode2	: { 
//  					<c:if test="${pUserSetYn.wpAddrUS == 1003 }">
 						required: true,
//  					</c:if> 
 					number: true }
 				,wpBaseAddr	: { 
//  					<c:if test="${pUserSetYn.wpAddrUS == 1003 }">
 						required: true,
//  					</c:if> 
 					maxlength: 100 }
 				,wpDetailAddr	: { 
//  					<c:if test="${pUserSetYn.wpAddrUS == 1003 }">
 						required: true,
//  					</c:if> 
 					maxlength: 100 }
// 				</c:if>
// 				<c:if test="${pUserSetYn.wpTelNumUS != 1002 }">
		        ,wpTelNum1	: { number: true },		wpTelNum2	: { number: true },		wpTelNum3	: { number: true }
// 		        </c:if>
		    },
		    submitHandler : function(form) {
		    	if(${pUserSetYn.wpTelNumUS != 1002 }){
			    	if($("#wpTelNum1").val() != '' && $("#wpTelNum2").val() != '' && $("#wpTelNum3").val() != ''){
			        	var wpTelNum 	= $("#wpTelNum1").val() + "-" + $("#wpTelNum2").val() + "-" + $("#wpTelNum3").val() ;
				       $("#wpTelNum").val(wpTelNum);
			    	}
		    	}
		    	if(${pUserSetYn.wpAddrUS != 1002 }){
			    	if($("#wpZipCode1").val() != '' && $("#wpZipCode2").val() != ''){
			        	var wpZipCode 	= $("#wpZipCode1").val() + "-" + $("#wpZipCode2").val() ;
				       $("#wpZipCode").val(wpZipCode);
			    	}
		    	}
		     	
		    	var interestItem = '';
		    	var selectedItem = jsCheckedArray();
		    	
		    	interestItem = $.makeArray(selectedItem);
		    	$("#interestItem").val(interestItem);
		    	
	 		    $(form).ajaxSubmit({
	 		       	url			: "ND_pOptionInsertAction.do",
		            type		: "POST",		            
		            success	: function(response) {
		                try {
		                    if(eval(response)) {
		                        jsSuccessBox(Message.msg.insertOk);
		                        self.location.href = "PD_pOptionUpdateForm.do?userId=" + $("#userId").val();
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
 
 	var jsCheckedArray = function() {
 	   var selectedItem = new Array();
 	  $("body input.checkbox:checked").each(function (i) {
 	      selectedItem[i] = $(this).val();
 	  });
 	  return selectedItem;
 	};
	
 	var userList = function() {
 	   
 	   parent.$.fn.colorbox.close();
 	   parent.location.href = "BD_index.do?pwdYn="+"Y";
 	};
 
	var topDataToggle = function(id){
		if(id == "base"){
	    	if(confirm("등록하신 회원의 상세정보 페이지로 이동됩니다.\n 이동하시겠습니까?")){
	    		parent.$.colorbox.resize({width : 900, height : 870});
		 	    self.location.href = "PD_pUpdateForm.do?userId=" + $("#userId").val();
	    	}
	 	 }else if(id == "add"){
	 	    self.location.href = "PD_pOptionUpdateForm.do?userId=" + $("#userId").val();
	 	 }else if(id == "mileage"){
	 		alert("등록하신 회원의 마일리지등록 페이지로 이동됩니다.")
	 		parent.$.colorbox.resize({width : 900, height : 880});
	 	    self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
	 	 }
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
				<legend>추가정보등록</legend>
				<table class="boardWrite" cellspacing="0" border="0" summary="추가정보등록을 하실 수 있습니다.">
					<caption class="hidden"> 추가정보등록 </caption>
					<colgroup>
						<col width="15%" />
						<col width="" />
					</colgroup>
					<tbody>
						<c:if test="${pUserSetYn.educationUS != 1002 }">
							<tr>
								<th>
									<c:if test="${pUserSetYn.educationUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									<label for="education">최종학력</label>
								</th>
								<td>
	<!-- 							<select id="education" title="최종학교를 선택해주세요" name="education"> -->
	<%-- 								<option value="1001">중졸</option> --%>
	<%-- 								<option value="1002">고졸</option> --%>
	<%-- 								<option value="1003">전문대학졸업</option> --%>
	<%-- 								<option value="1004">대학교졸업</option> --%>
	<%-- 								<option value="1005">대학원졸업</option> --%>
	<!-- 							</select> -->
								<op:code id="education" grpCd="78" defaultLabel="--선택--"/>
								</td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.marriageUS != 1002 }">
							<tr>
								<th>
									<c:if test="${pUserSetYn.marriageUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									<label for="marriageYn">결혼유무</label>
								</th>
								<td><op:code id="marriageYn" grpCd="79" type="radio"/></td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpNmUS != 1002 }">
							<tr>
								<th>
									<c:if test="${pUserSetYn.wpNmUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									<label for="wpNm">직장명</label>
								</th>
								<td><input type="text" id="wpNm" class="w120" name="wpNm" title="직장명을 입력해주세요" value="" /></td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.gradeNmUS != 1002 }">
							<tr>
								<th>
									<c:if test="${pUserSetYn.gradeNmUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									<label for="gradeNm">직책</label>
								</th>
								<td><input type="text" id="gradeNm" class="w120" name="gradeNm" title="직책을 입력해주세요" value="" /></td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpAddrUS != 1002 }">
							<tr>
								<th rowspan="3">
									<c:if test="${pUserSetYn.wpAddrUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									직장주소
								</th>
								<td>우편번호 : 
									<input type="text" id="wpZipCode1" class="w80" name="wpZipCode1" value="" maxlength="3"/> - 
									<input type="text" id="wpZipCode2" class="w80" name="wpZipCode2" value="" maxlength="3"/> 
									&nbsp;&nbsp;<button type="button" class="gray_s">우편번호찾기</button><br />
								</td>
							</tr>
							<tr>
								<td colspan="3">기본주소 : 
									<input type="text" id="wpBaseAddr" class="w85_p" name="wpBaseAddr" value="" />
								</td>
							</tr>
							<tr>
								<td colspan="3">상세주소 : 
									<input type="text" id="wpDetailAddr" class="w85_p" name="wpDetailAddr" value="" />
								</td>
						</tr>
						</c:if>
						<c:if test="${pUserSetYn.wpTelNumUS != 1002 }">
							<tr>
								<th>
									<c:if test="${pUserSetYn.wpTelNumUS == 1003 }"><span class="tx_red_s">*</span></c:if>
									<label for="wpTelNum1">직장전화번호</label>
								</th>
								<td>
									<input type="text" id="wpTelNum1" class="w80" name="wpTelNum1" title="지역번호를 입력해주세요" maxlength="5" value="" /> - 
									<input type="text" id="wpTelNum2" class="w80" name="wpTelNum2" title="앞자리를 입력해주세요" maxlength="4" value="" /> - 
									<input type="text" id="wpTelNum3" class="w80" name="wpTelNum3" title="전화번호를 입력해주세요" maxlength="4" value="" />
								</td>
							</tr>
						</c:if>
						<c:if test="${pUserSetYn.interestItemUS != 1002 }">
						<tr>
							<th>관심항목</th>
							<td>
								<ul class="mem_item">
									<c:forEach var="item" items="${list}" varStatus="status">
										<c:if test="${item.userGubun eq 'P' }">
										<li>
											<input type="checkbox" name="useYn${item.seq}" id="useYn${item.seq}"  value="${item.seq}" class="checkbox"/> <label for="useYn${item.seq}">${item.itemNm}</label>
										</li>
										</c:if>
									</c:forEach>
								</ul>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
				</fieldset>
				<!-- //기본정보 -->
 
				<p class="tx_c mar_t20">
					<a href="#"><button type="submit" class="blue">등록</button></a> 
					<a href="#"><button type="button" onclick="userList();" class="blue">취소</button></a>
				</p>
				
			</div>
			<!-- //컨텐츠영역 -->
		</form>
</body>
</html>