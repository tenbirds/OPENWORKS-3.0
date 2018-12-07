<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<op:jsTag type="spi" items="form,colorbox" />
<title>마일리지등록</title>

<script type="text/javascript">
// 	$().ready(function() {
// 		parent.$.colorbox.resize({width : 900, height : 880});
// 	});
	
	var doInsert = function(){
	    if(!vaildChk()){
	        return false;
	    }
	    dataString = $("#insertForm").serialize();
		$.ajax({
			type: "POST",
			url: "ND_pUserMileageAction.do",
			data: dataString,
			success: function(response){
			    try {
			        if(eval(response)) {
			            jsSuccessBox(Message.msg.updateOk);
			            userList();
			        } else {
			            jsErrorBox(Message.msg.processFail);
			        }
			    } catch (e) {
			        jsSysErrorBox(response, e);
			        return;
			    }
			}
		});
	};
	
	var userList = function(){        
	    parent.$.fn.colorbox.close();
	    parent.location.href = "BD_index.do?pwdYn="+"Y";	
	};	
	
	// 필수입력 체크...
	var vaildChk = function(){
	    if($('#mileageNm').val() == '' || $('#mileageNm').val() == null){
	        jsWarningBox('마일리지명을 입력하세요.');
	        return false;
	     }else if($('#amount').val() == '' || $('#amount').val() == null){
	         jsWarningBox('부여마일리지를 입력하세요.');
	        return false;
	    } else if($('#accuReason').val() == '' || $('#accuReason').val() == null){
	        jsWarningBox('부여사유를 입력하세요.');
	        return false;
	    }
	    
	    return true;
	};
	
	var topDataToggle = function(id){
		 if('${dataVo.userType}' == 1001){
		 	 if(id == "base"){
		 		parent.$.colorbox.resize({width : 900, height : 870});
		 	     self.location.href = "PD_pUpdateForm.do?userId=" + $("#userId").val();
		 	 }else if(id == "add"){
		 		parent.$.colorbox.resize({width : 900, height : 550});
		 	     self.location.href = "PD_pOptionUpdateForm.do?userId=" + $("#userId").val();
		 	 }else if(id == "mileage"){
		 	     self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
		 	 }
		 }else{
		 	 if(id == "base"){
		 	     parent.$.colorbox.resize({width : 950, height : 720});
		 	     self.location.href = "PD_cpUserUpdateForm.do?userId=" + $("#userId").val();
		 	 }else if(id == "add"){
		 	     parent.$.colorbox.resize({width : 900, height : 520});
		 	     self.location.href = "PD_cpUserUpdateAddForm.do?userId=" + $("#userId").val();
		 	 }else if(id == "mileage"){
		 	     self.location.href = "PD_pUserMileage.do?userId=" + $("#userId").val();
		 	 }
		 }
 	};

</script>

</head>
 
<body>
	
	<!-- 탭 -->
	<ul class="tab">
		<li><a href="#" id="base" onclick="topDataToggle('base');">기본정보</a></li>
		<li><a href="#" id="add" onclick="topDataToggle('add');">추가정보</a></li>
		<li><a href="#" id="mileage" onclick="topDataToggle('mileage');" class="on">마일리지정보</a></li>
	</ul>
	<!-- //탭 -->

    <jsp:include page="/intra/mileage/read/INC_mileageView.do" flush="true"></jsp:include>

	<form id="insertForm" name="insertForm" >
		<input type="hidden" id="userId" name="userId" value="${param.userId}" />
		<!-- 마일리지정보 -->
		<h2 class="mar_t20">마일리지정보</h2>
		
		<fieldset>
		<legend>마일리지정보</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="마일리지정보를 등록 하실 수 있습니다.">
			<caption class="hidden"> 마일리지정보 </caption>
			<colgroup>
				<col width="15%" />
				<col width="" />
			</colgroup>
			<tbody>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="school">마일리지명</label></th>
					<td><input type="text" id="mileageNm" name="mileageNm" title="마일리지명을 입력해주세요" class="w120" /></td>
				</tr>
				<!-- <tr>
					<th>마일리지타입</th>
					<td>관리자입력</td>
				</tr> -->
				<tr>
					<th><span class="tx_red_s">*</span> <label for="mil">부여마일리지</label></th>
					<td><select id="accuType" name="accuType">
	                		 <option value="999999" selected="selected">적립</option>
							 <option value="999998" >차감</option>
						</select>
						<input type="text" id="amount" name="amount" class="w80" title="포인트를 입력해주세요" /> 포인트</td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span> <label for="gik">부여사유</label></th>
					<td><textarea id="accuReason" name="accuReason" rows="8" class="w99_p"></textarea></td>
				</tr>
			</tbody>
		</table>
		</fieldset>
	</form>
	<p class="tx_r mar_t20"><button type="button" onclick="doInsert();" class="blue">등록</button></p>
	<!-- //마일리지정보 -->

</body>
</html>