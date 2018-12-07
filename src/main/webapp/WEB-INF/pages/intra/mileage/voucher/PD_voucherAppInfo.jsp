<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<op:jsTag type="spi" items="form" />
<title>서비스권신청</title>

<script type="text/javascript">
	$().ready( function() {
	    chkAmount();
	});
	// 서비스권 신청정보 수정
	var updateVoucherApp = function(){
	    if(!prcTypeCheck()){
	        return;
	    }
	    
	    dataString = $("#form").serialize();
		$.ajax({
			type: "POST",
			url: "ND_voucherAppUpdate.do",
			data: dataString,
			async: false,
			success: function(response){
			    jsSuccessBox(response);
				parent.$.fn.colorbox.close();
				parent.location.href = "BD_index.do?"+$("#pagingform").serialize()+"&checkSeqNo=${dataVo.seqNo}";
			},
		    error :  function(response) {
		        jsSysErrorBox(response.responseText);
		        return;
	        }
		});
	};
	
	// 미승인, 취소 시 사유 입력 체크
	var prcTypeCheck = function(){
		var bool = true;
	    var prcTypeCd = $('input[id^=prcType_rb]:checked').val();
	    
	    if(prcTypeCd==null){
	        jsWarningBox("서비스권 신청 승인여부를 선택하세요.");
	        return false;
	    }
	    
	    if((prcTypeCd == 1002 || prcTypeCd == 1003)
	            && ($('#prcReason').val() == '' ||  $('#prcReason').val() == null)){
	        jsWarningBox('미승인/(신청)취소 선택시 사유를 입력하세요. ');
	        bool = false;
	        return bool;
	    }
	    
	    var amount = '${dataVo.curAmount}' - '${dataVo.reqAmount}' ;
	    if(prcTypeCd == 1001 && amount < 0){
	        jsWarningBox('신청 후 잔여 마일리지가 부족하여 승인 할 수 없습니다. ');
	        return false;
	    }
	    
	    if($('#q_tabFlag').val() == 2){
		    if(prcTypeCd == 1002 || prcTypeCd == 1003){
		    	$("#pagingform input[name=q_tabFlag]").val('1');
		    }else{
		        $("#pagingform input[name=q_tabFlag]").val('2');
		        parent.$.fn.colorbox.close();
		        return false;
		    }
	    }
	    
	    return bool;
	};
	
	var chkAmount = function(){
	    var amount = '${dataVo.curAmount}' - '${dataVo.reqAmount}' ;
	    if(amount < 0){
	        $('#prcType_rb_2').attr("disabled","disabled");
	        $('#afterAmount').css({color:"red"});
	    }
	};
</script>

</head>
 
<body>
<!-- 컨텐츠영역 -->
<form name="pagingform" id="pagingform" method="post">
    <input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
    <input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
    <input type="hidden" name="q_currPage" value="${param.q_currPage}" />
    <input type="hidden" name="q_searchPrcType" value="${param.q_searchPrcType}" />
    <input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
    <input type="hidden" id="q_tabFlag" name="q_tabFlag" value="${param.q_tabFlag }" />
    <input type="hidden" name="pwdYn" value="${param.pwdYn}"/>
</form>
<h2>[${dataVo.userNm}]님 서비스권 신청정보</h2>
	<div id="popup">
		
		<ul class="blet">
			<li>회원이  적립된 마일리지에 대해 서비스권을 신청한 경우이며, 회원이  신청을 취소하기 전에는 관리자는 신청내역에 대해 승인, 미승인, 취소의 단계만을 지정할 수 있습니다.</li>
			<li>회원이 유선 등으로 취소를 요청하거나, 기타의 사유로 관리자가  회원의 신청을 취소해야할 경우에는 “취소”를 선택하시기 바랍니다.</li>
			<li><span class="tx_red">관리자가 회원의 서비스권 신청을 승인한 경우에는 회원은 서비스권 신청을 취소할 수 없으며,</span>  서비스권 발송 전  유선 등의 취소요청이 있는 경우 <span class="tx_red">관리자는 “승인”한 경우에라도 서비스권 발송 전인 경우는  취소</span>할 수 있습니다.</li>
		</ul>
		
		
		<form id="form" name="form" >
			<input type="hidden" id="prcTypeold" name="prcTypeold" value="${dataVo.prcType}" />
			<input type="hidden" id="prcReasonold" name="prcReasonold" value="${dataVo.prcReason}" />
			<input type="hidden" id="seqNo" name="seqNo" value="${dataVo.seqNo}" />
			<input type="hidden" id="userId" name="userId" value="${dataVo.userId}" />
			<input type="hidden" id="regId" name="regId" value="${dataVo.regId}" />
			<input type="hidden" id="reqAmount" name="reqAmount" value="${dataVo.reqAmount}" />
			
			<div class="mar_b20">
			<table class="boardWrite" cellspacing="0" border="0">
				
				<caption class="hidden"> 신청정보 </caption>
				<colgroup>
					<col width="22%" />
					<col width="28%" />
					<col width="22%" />
					<col width="28%" />
				</colgroup>
				<tbody>
					<tr>
						<th>신청자명</th>
						<td colspan="3">${dataVo.userNm}</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${dataVo.userId}</td>
						<th>신청일시</th>
						<td><fmt:formatDate value="${dataVo.reqDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th>현재마일리지</th>
						<td><fmt:formatNumber value="${dataVo.curAmount}" type="number" /></td>
						<th>서비스권 신청 마일리지</th>
						<td><fmt:formatNumber value="${dataVo.reqAmount}" type="number" /></td>
					</tr>
					<c:if test="${dataVo.voucherPrcType ne 1001}">
						<tr>
							<th>신청후 잔여 마일리지</th>
							<td id="afterAmount"><fmt:formatNumber value="${dataVo.curAmount - dataVo.reqAmount}" type="number" /></td>
							<th>서비스권 신청여부</th>
							<td>${dataVo.reqType}</td>
						</tr>
					</c:if>
					<tr>
						<th><span class="tx_red_b">*</span> 서비스권 신청 승인여부</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${empty dataVo.voucherPrcType or dataVo.voucherPrcType ne '1001'}">
							    	<op:code id="prcType" grpCd="69" type="radio" ctgCd="PROC" defaultValues="${dataVo.prcType}" />
								</c:when>
								<c:when test="${dataVo.voucherPrcType eq '1001'}">
									${dataVo.prcTypeNm}
								</c:when>
							</c:choose>
						</td>
					</tr>
					<c:if test="${dataVo.voucherPrcType eq 1001}">
						<tr>
							<th>서비스권 지급 처리상태</th>
							<td colspan="3">${dataVo.voucherPrcTypeNm}</td>
						</tr>
					</c:if>
					<tr>
						<th><span class="tx_red_b">*</span> 서비스권 신청<br/>미승인/취소사유</th>
						<td colspan="3">
							<textarea id=prcReason name="prcReason"  rows="6" class="w99_p" 
								<c:if test="${not empty dataVo.voucherPrcType and dataVo.voucherPrcType eq '1001'}">
								 readonly="readonly" </c:if>>${dataVo.prcReason}</textarea>
						</td>
					</tr>
					<tr <c:if test="${dataVo.regId eq null}" > style="display: none;" </c:if>>
						<th>승인자(ID)</th>
						<td>${dataVo.regNm}(${dataVo.regId})</td>
						<th>승인일시</th>
						<td><fmt:formatDate value="${dataVo.regDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr <c:if test="${dataVo.modId eq null}" > style="display: none;" </c:if>>
						<th>최종수정자(ID)</th>
						<td>${dataVo.modNm}(${dataVo.modId})</td>
						<th>최종수정일시</th>
						<td><fmt:formatDate value="${dataVo.modDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr <c:if test="${dataVo.modId eq null}" > style="display: none;" </c:if>>
						<th>최종수정내용</th>
						<td colspan="3">
							${dataVo.prcTypeoldNm}<c:if test="${not empty dataVo.prcReasonold}">(${dataVo.prcReasonold})</c:if>&nbsp;->&nbsp;
							<span class="tx_red">${dataVo.prcTypeNm}</span>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		
		<!-- //신청정보 -->
		<p class="tx_c mar_t20">
			<c:choose>
				<c:when test="${empty dataVo.voucherPrcType or dataVo.voucherPrcType ne '1001'}">
					<button onclick="updateVoucherApp();"  class="blue">저장</button>
				</c:when>
				<c:otherwise>
	 				<button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button>
	 			</c:otherwise>
	 		</c:choose>
	 	</p>

		</form>
	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>