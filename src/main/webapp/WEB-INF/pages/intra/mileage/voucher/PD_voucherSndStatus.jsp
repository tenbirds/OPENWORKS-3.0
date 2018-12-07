<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<op:jsTag type="spi" items="validate,form,ui" />
<title>서비스권신청</title>

<script type="text/javascript">
	
	$().ready(function() {
	    var voucherPrcType = $('input[id^=voucherPrcType_rb]:checked').val();
	    voucherSndSelect(voucherPrcType);
	    voucherTypechk($('#voucherType').val());
	    chkAmount();
	    
	    if('${voucherSndVO.voucherPrcType}' == 1001){
	        $('#voucherPrcDt').attr("readonly",true);
	        $('#voucherNm').attr("readonly",true);
	        $('#chkVoucherType').attr("disabled",true);
	        $('#voucherCd').attr("readonly",true);
	        $('#voucherSndCd').attr("readonly",true);
	    }
	    
	    $("input:checkbox[name='chkVoucherType']").click(function() {
            var checkedStatus = this.checked;
            if (checkedStatus) {
             $('#voucherType').val('Y');
            }else{
             $('#voucherType').val('N');
            }
            voucherTypechk($('#voucherType').val());
        });
	    
	    
	    $("input[id^=voucherPrcType_rb]").click(function() {
	        var voucherType = $(this).val();
	        voucherSndSelect(voucherType);
	    });
	    
	    
	    var clareCalendar = {
			dateFormat: 'yy-mm-dd',
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
	    };
	    $('#voucherPrcDt').datepicker(clareCalendar);
	    $('#voucherPrcDt').css("ime-mode", "disabled"); 
	});
	
	var voucherSndSelect = function(code){
	    
	    if(code == '1002'){
	        $('#voucherPrcDt').attr("disabled",true);
	        $('#voucherNm').attr("disabled",true);
	        $('#chkVoucherType').attr("disabled",true);
	        $('#voucherCd').attr("disabled",true);
	        $('#voucherSndCd').attr("disabled",true);
	        $('#starLabel_1').html('<span class="tx_red_s"></span>');
	        $('#starLabel_2').html('<span class="tx_red_s"></span>');
	        $('#starLabel_3').html('<span class="tx_red_s"></span>');
	        $('#starLabel_4').html('<span class="tx_red_s"></span>');
	    } else{
	        $('#voucherPrcDt').attr("disabled",false);
	        $('#voucherNm').attr("disabled",false);
	        $('#chkVoucherType').attr("disabled",false);
	        $('#voucherCd').attr("disabled",false);
	        $('#voucherSndCd').attr("disabled",false);
	        $('#starLabel_1').html('<span class="tx_red_s">*</span>');
	        $('#starLabel_2').html('<span class="tx_red_s">*</span>');
	        $('#starLabel_3').html('<span class="tx_red_s">*</span>');
	        $('#starLabel_4').html('<span class="tx_red_s">*</span>');
	        voucherTypechk($('#voucherType').val());
	    }
	    
	};
	
	var voucherTypechk = function(type){
	    if(type == 'Y'){
	        $('#voucherSndCd').val('');
	        $('#voucherSndCd').attr("disabled",true);
	    }else{
	        $('#voucherSndCd').attr("disabled",false);
	    }
	};
	
	// 신청 후 마일리지가 부족할 경우...
	var chkAmount = function(){
	    var amount = '${voucherAppVO.curAmount}' - '${voucherAppVO.reqAmount}' ;
	    if(amount < 0){
	        $('#voucherPrcType_rb_2').attr("disabled","disabled");
	        $('#afterAmount').css({color:"red"});
	    }
	    
	};
	
	var updateVoucherSnd = function(){
	    if(confirm("저장 하시겠습니까?")){
		    if(!prcTypeCheck()){
		        return false;
		    }
		    var voucherPrcDt = $('#voucherPrcDt').val().replace(/-/gi,"");
	     	$('#voucherPrcDt').val(voucherPrcDt);
	     	
		    dataString = $("#form").serialize();
			$.ajax({
				type: "POST",
				url: "ND_voucherSndUpdate.do",
				data: dataString,
				success: function(response){
				    jsSuccessBox(response);
					parent.$.fn.colorbox.close();
					parent.location.href = "BD_index.do?"+$("#pagingform").serialize()+"&checkSeqNo=${voucherAppVO.seqNo}"+"&q_tabFlag=2";
				},
			    error :  function(response) {
			        jsSysErrorBox(response.responseText);
			        return;
		        }
			});
	    }
	};
	
	var prcTypeCheck = function(){
	    var voucherPrcType = $('input[id^=voucherPrcType_rb]:checked').val();
	    
	    if(voucherPrcType == '1001'){
	        if($('#voucherPrcDt').val() == ''|| $('#voucherPrcDt').val() == null){
	            jsWarningBox('처리일자는 필수 항목입니다.');
	            return false;
	        }
	        else if($('#voucherNm').val() == '' || $('#voucherNm').val() == null){
	            jsWarningBox('서비스권 명은 필수 항목입니다.');
	            return false;
	        }
	        else if($('#voucherCd').val() == '' || $('#voucherCd').val() == null){
	            jsWarningBox('서비스권 일련번호는 필수 항목입니다.');
	            return false;
	        }
	        else if($('#voucherType').val() == 'N' && 
	                 ($('#voucherSndCd').val() == '' || $('#voucherSndCd').val() == null)){
	            jsWarningBox('등기발송 일련번호는 필수 항목입니다.');
	            return false;
	        }
		}else{
		    $('#voucherType').val('N');
		}
	    return true;
	};
	
	//숫자만 입력 받게끔 하는 함수.
	function handlerNum(obj) {
	    //입력 허용 키
	    if ((event.keyCode >= 48 && event.keyCode <= 57) ||   //숫자열 0 ~ 9 : 48 ~ 57
	        (event.keyCode >= 96 && event.keyCode <= 105) ||  //키패드 0 ~ 9 : 96 ~ 105
			 event.keyCode == 8  || event.keyCode == 46 ||    //BackSpace, Delete
			 event.keyCode == 37 || event.keyCode == 39 ||    //좌 화살표, 우 화살표
			 event.keyCode == 35 || event.keyCode == 36 ||    //End 키, Home 키
			 event.keyCode == 9  || event.keyCode == 45) {    //Tab 키
	        event.returnValue = true;
	    }else{
	        event.returnValue = false;
	    }
	    
	    if(event.keyCode != 8){
	        var qStDate = $("#voucherPrcDt").val();
	    	if(qStDate.length > 10){
	    		return;
	    	}
			
	    	if(qStDate.length == 4){
	    	    $("#voucherPrcDt").val(qStDate+"-");
	    	}else if(qStDate.length == 7){
	    		$("#voucherPrcDt").val(qStDate+"-");
	    	}
	    }
	 };
</script>

</head>
 
<body>
<form name="pagingform" id="pagingform" method="post">
    <input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
    <input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
    <input type="hidden" name="q_currPage" value="${param.q_currPage}" />
    <input type="hidden" name="q_searchPrcType" value="${param.q_searchPrcType}" />
    <input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
    <input type="hidden" name="pwdYn" value="${param.pwdYn}"/>
</form>
<h2>[${voucherAppVO.userNm}]님 서비스권 지급 처리상태</h2>
<!-- 컨텐츠영역 -->
	<div id="popup">
		<ul class="blet">
			<li>관리자에 의해 <span class="tx_red">최종 승인</span>이 확인된 건에 한해서 서비스권 신청을 처리(발송)할 수 있습니다.</li>
			<li>서비스권 발송을 위한 <span class="tx_red">회원의 상세정보(전화번호, 주소 등)는 회원관리</span>에서 확인하시기 바랍니다.</li>
		</ul>
		
		<form id="form" name="form" >
			<input type="hidden" id="seqNo" name="seqNo" value="${voucherAppVO.seqNo}" />
			<input type="hidden" id="userId" name="userId" value="${voucherAppVO.userId}" />
			<input type="hidden" id="regId" name="regId" value="${voucherAppVO.regId}" />
			<input type="hidden" id="reqAmount" name="reqAmount" value="${voucherAppVO.reqAmount}" />
			
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
						<td colspan="3">${voucherAppVO.userNm}</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>${voucherAppVO.userId}</td>
						<th>신청일시</th>
						<td><fmt:formatDate value="${voucherAppVO.reqDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr>
						<th>현재마일리지</th>
						<td><fmt:formatNumber value="${voucherAppVO.curAmount}" type="number" /></td>
						<th>서비스권 신청 마일리지</th>
						<td><fmt:formatNumber value="${voucherAppVO.reqAmount}" type="number" /></td>
					</tr>
					<c:if test ="${voucherSndVO.voucherPrcType ne 1001}">
						<tr>
							<th>신청후 잔여 마일리지</th>
							<td id="afterAmount"><fmt:formatNumber value="${voucherAppVO.curAmount - voucherAppVO.reqAmount}" type="number" /></td>
							<th>서비스권 신청여부</th>
							<td>${voucherAppVO.reqType}</td>
						</tr>
					</c:if>
					<tr>
						<th>서비스권 신청 승인여부</th>
						<td colspan="3">${voucherAppVO.prcTypeNm}</td>
					</tr>
					<tr <c:if test="${voucherAppVO.regId eq null}" > style="display: none;" </c:if>>
						<th>승인자(ID)</th>
						<td>${voucherAppVO.regNm}(${voucherAppVO.regId})</td>
						<th>승인일시</th>
						<td><fmt:formatDate value="${voucherAppVO.regDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr <c:if test="${voucherAppVO.modId eq null}" > style="display: none;" </c:if>>
						<th>최종수정자(ID)</th>
						<td>${voucherAppVO.modNm}(${voucherAppVO.modId})</td>
						<th>최종수정일시</th>
						<td><fmt:formatDate value="${voucherAppVO.modDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					<tr <c:if test="${voucherAppVO.modId eq null}" > style="display: none;" </c:if>>
						<th>최종수정내용</th>
						<td colspan="3">${voucherAppVO.prcTypeoldNm}(${voucherAppVO.prcReasonold})&nbsp;->&nbsp;
							<span class="tx_red">${voucherAppVO.prcTypeNm}</span>
						</td>
					</tr>
					<tr>
						<th>처리상태<br/>(서비스권 발송여부)</th>
						<td colspan="3">
							<c:if test ="${voucherSndVO.voucherPrcType ne 1001}">
								<op:code id="voucherPrcType" grpCd="70" type="radio" defaultValues="1002" />
							</c:if>
							<c:if test ="${voucherSndVO.voucherPrcType eq 1001}">
								${voucherSndVO.voucherPrcTypeNm}
							</c:if>
						</td>
					</tr>
					<tr>
						<th>처리자(ID)</th>
						<td colspan="3">${voucherSndVO.voucherPrcNm}</td>
					</tr>
					<tr>
						<th><span id="starLabel_1" ></span> 처리일자</th>
						<td colspan="3">
							<c:if test ="${voucherSndVO.voucherPrcType ne 1001}">
								<input type="text" name="voucherPrcDt" id="voucherPrcDt" maxlength="10" onkeydown="handlerNum(this);" value="${voucherSndVO.voucherPrcDt}"/>
							</c:if>
							<c:if test ="${voucherSndVO.voucherPrcType eq 1001}">
								${voucherSndVO.voucherPrcDt}
							</c:if>
						</td>
					</tr>
					<tr>
						<th><span id="starLabel_2" ></span> 서비스권명</th>
						<td colspan="3">
							<input type="text" name="voucherNm" id="voucherNm" class="w150" maxlength="50" value="${voucherSndVO.voucherNm}" />
							<input type="checkbox" name="chkVoucherType" id="chkVoucherType" <c:if test="${voucherSndVO.voucherType == 'Y'}">checked="checked"</c:if>/>
							<label for="just">전자서비스권</label>
							<input type="hidden" name="voucherType" id="voucherType" value="${voucherSndVO.voucherType}" />
						</td>
					</tr>
					<tr>
						<th><span id="starLabel_3" ></span> 서비스권 일련번호</th>
						<td colspan="3">
							<input type="text" name="voucherCd" id="voucherCd" maxlength="50" class="w150" value="${voucherSndVO.voucherCd}" />
						</td>
					</tr>
					<tr>
						<th><span id="starLabel_4" ></span> 등기발송 일련번호</th>
						<td colspan="3">
							<input type="text" name="voucherSndCd" id="voucherSndCd" maxlength="50" class="w150"  value="${voucherSndVO.voucherSndCd}" /> 
							<span class="tx_11 mar_l10">* 발송 영수증상의 등기번호 13자리</span>
						</td>
					</tr>
				</tbody>
			</table>
			</div>
		
		<!-- //신청정보 -->

		</form>
		<p class="tx_c mar_t20">
			<c:choose>
				<c:when test="${empty voucherSndVO.voucherPrcType or voucherSndVO.voucherPrcType ne '1001'}">
					<button onclick="updateVoucherSnd();"  class="blue">저장</button>
				</c:when>
				<c:otherwise>
			 		<button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button>
				</c:otherwise>
			</c:choose>
	 	</p>
	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>