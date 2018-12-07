<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<op:jsTag type="spi" items="form,ui" />
<title>서비스권 발송 처리</title>

<script type="text/javascript">
	
	$().ready(function() {
	    var clareCalendar = {
			dateFormat: 'yy-mm-dd',
            showOn : 'button',
            defaultDate : null,
            buttonImage : '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
	    };
	    
	    if($('#regId').val() != '' && '${param.kindFlag}' == 'U'){
	        $('#divTbody').show();
	        $('.inF').attr('style','display:none');
	        $('.upF').attr('style','');
	    }else if($('#regId').val() == '' && '${param.kindFlag}' == 'U'){
	        parent.location.href = "PD_voucherGiveList.do";
	        parent.$.fn.colorbox.close();
	    }else{
		    $('#appStDate').datepicker(clareCalendar); 	
	    }
	    
	    $('#appStDate').css("ime-mode", "disabled"); 
	    $('#giveScale').css("ime-mode", "disabled"); 
	    
	    
	});
	
	// 지급 기준일 수정
	var jsGiveSetUpdate = function(){
	    if(validChk()){
    	    if(confirm("수정 하시겠습니까?")){
    		    $('#giveScale').val($('#giveScale').val().replace(/[^0-9]/gi,""));
    		    $('#appStDate').val($('#appStDate').val().replace(/[^0-9]/gi,""));
    	        
    		    dataString = $("#form").serialize();
    			$.ajax({
    				type: "POST",
    				url: "ND_voucherGiveSetUpdate.do",
    				data: dataString,
    				success: function(response){
    				    jsSuccessBox(response);
                        parent.location.href = "PD_voucherGiveList.do";
    					parent.$.fn.colorbox.close();
    				},
    			    error :  function(response) {
    			        jsSysErrorBox(response.responseText);
    			        return;
			        }
    			});
    		}
	    }
	};
	
	// 지급 기준일 저장
	var jsGiveSetInsert = function(){
	    if(validChk()){
   		    $('#appStDate').val($('#appStDate').val().replace(/[^0-9]/gi,""));
   		    $('#giveScale').val($('#giveScale').val().replace(/[^0-9]/gi,""));
   	        
   		    dataString = $("#form").serialize();
   			$.ajax({
   				type: "POST",
   				url: "ND_voucherGiveSetInsert.do",
   				data: dataString,
   				success: function(response){
   				    jsSuccessBox(response);
                    parent.location.href = "PD_voucherGiveList.do";
                    parent.$.fn.colorbox.close();
   				},
   			    error :  function(response) {
       			     jsSysErrorBox(response.responseText);
       			     return;
   			     }
   			});
	    }
	};
	
	// 지급 기준일 삭제
	var jsGiveSetDelete = function(){
		var checkdBool = false;
	    var checkCount = 0;
	    var checkSeqNo = []; 
	    $("input[name=seqNos]:checked").each(function (i){
	        checkdBool = true;
	        checkSeqNo[i] = $(this).val();
	        checkCount++;
        });
	    
	    
	    if(!checkdBool) {
	        jsWarningBox("삭제할 지급기준을 선택하여 주십시오.");
	        return false;
	    }
	    
	    if(!confirm(checkCount + "건 삭제 하시겠습니까?")){
	        return false;
	    }
	    
	    $.ajax({
            url     : "ND_voucherGiveSetDelete.do",
            type    : "POST",
            data    : {
                			arraySeqNo  : checkSeqNo,
                			appStDate   : $('#form input[name=appStDate]').val(),
            		  },
            success : function(response) {
                $('#regId').val() == '' && '${param.kindFlag}' == 'U'
                jsSuccessBox(response);
                self.location.reload();
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
	};
	
	// 필수 항목 체크
	var validChk = function(){
	    if($('#giveScale').val() == ''){
	        jsWarningBox('서비스권 지급 기준 설정을 입력하세요.');
	        $('#giveScale').focus();
	        return false;
	    }else if($('#appStDate').val() == ''){
	        jsWarningBox('적용시작일을 입력하세요.');
	        $('#appStDate').focus();
	        return false;
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
	    
	    // 날짜 입력시..
	    if(obj.id == 'appStDate' && event.keyCode != 8){
		    var qStDate = $("#appStDate").val();
	    	if(qStDate.length > 10){
	    		return;
	    	}
	
	    	if(qStDate.length == 4){
	    		$("#appStDate").val(qStDate+"-");
	    	}else if(qStDate.length == 7){
	    		$("#appStDate").val(qStDate+"-");
	    	}
	    }
	 };
</script>

</head>
 
<body>
<h2>서비스권 지급 기준설정 수정</h2>
	<ul class="blet">
		<li>회원의 마일리지에 대해 서비스권으로 지급하기 위한 기준을 설정합니다.</li>
		<li>설정한 금액이상일때에만 서비스권 신청 및 지급이 가능합니다.</li>
	</ul>
	
<form id="form" name="form">
	<input type="hidden" id="regId" value="${dataVo.regId}" />
	<input type="hidden" id="modId" value="${dataVo.modId}" />
	<!-- 서비스권지급기준설정 -->
	<div class="search">
		<fieldset>
			<legend>기준설정</legend>
			<span class="tx_b">서비스권 지급 기준설정 : </span>
			<c:set var="giveScaleVal"><fmt:formatNumber value="${dataVo.giveScale}" type="number" /></c:set>
			<input class="w80" type="text" name="giveScale" id="giveScale"  maxlength="15" onkeydown="handlerNum(this);" style="TEXT-ALIGN: center" value="${giveScaleVal}" /> 점 단위 <br/><br/>
			
			<span class="tx_b upF" style="display: none;">서비스권 적용 시작일 : ${dataVo.appStDate}</span>
			
			<span class="tx_b inF" >서비스권 적용 시작일 : </span>
			<input class="w80 inF" type="text" name="appStDate" id="appStDate" maxlength="10" onkeydown="handlerNum(this);" value="${dataVo.appStDate}" style="TEXT-ALIGN: center"/>
		</fieldset>
	</div>
    <c:if test="${not empty dataVo.regId}">
	   <p class="tx_r mar_b10">
		  <button type="button" onclick="jsGiveSetUpdate();" class="blue">수정</button>
	   </p>
   </c:if>
</form>

<div id="divTbody" class="mar_b20" style="display: none;">
    <form id="updateForm" name="updateForm">
    	<table class="boardWrite" cellspacing="0" border="0">
    	
    		<caption class="hidden"> 서비스권지급처리상태 </caption>
    		<colgroup>
    			<col width="20%" />
    			<col width="30%" />
    			<col width="20%" />
    			<col width="30%" />
    		</colgroup>
    		<tbody>
    			<tr>
    				<th>등록자(ID)</th>
    				<td>${dataVo.regNm}</td>
    				<th>등록일시</th>
    				<td><fmt:formatDate value="${dataVo.regDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    			</tr>
    			<c:if test="${not empty dataVo.modId}">
    				<tr>
    					<th>최종 수정자(ID)</th>
    					<td>${dataVo.modNm}</td>
    					<th>최종수정일시</th>
    					<td><fmt:formatDate value="${dataVo.modDtm}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
    				</tr>
    			</c:if>
    		</tbody>
    	</table>
    </form>	
    <br/>	
    <form id="listForm" name="listForm" method="post" >
    	<table class="boardList" cellspacing="0" border="0" summary="리스트">
    		<caption class="hidden"> 서비스권신청목록 </caption>
    		<colgroup>
    			<col width="5%" />
    			<col width="7%" />
    			<col width="15%" />
    			<col width="15%" />
    			<col width="15%" />
    			<col width="15%" />
    			<col width="" />
    		</colgroup>
    		<thead>
    			<tr>
    				<th>선택</th>
    				<th>번호</th>
    				<th>지급기준</th>
    				<th>등록자</th>
    				<th>등록일자</th>
    				<th>수정자</th>
    				<th class="lr_none">수정일자</th>
    			</tr>
    		</thead>
    		<tbody>
    			<c:set var="itemSize" value="${dataListSize}" />
    			<c:forEach var="item" items="${dataList}" varStatus="status">
    			<tr <c:if test="${status.index % 2 != 0 }"> class="bg_yellow"</c:if>>
    				<td>
    					<input type="checkbox" id="seqNos_${status.count}" name="seqNos" value="${item.seqNo}"/>
    				</td>
    				<td>${itemSize - (status.index)}</td>
    				<td>${item.giveScale}</td>
    				<td>${item.regNm}</td>
    				<td><fmt:formatDate value="${item.regDtm}" pattern="yyyy-MM-dd" /></td>
    				<td>${item.modNm}</td>
    				<td><fmt:formatDate value="${item.modDtm}" pattern="yyyy-MM-dd" /></td>
    			</tr>
    			</c:forEach>
    		</tbody>
    	</table>	
    </form>
</div>
	<p class="tx_r mar_t20">
		<c:choose>
			<c:when test="${empty dataVo.regId}">
				<button type="button" onclick="jsGiveSetInsert();" class="blue">저장</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="jsGiveSetDelete();" class="blue">선택삭제</button>
			</c:otherwise>
		</c:choose>
<!-- 		<button type="button" onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button> -->
	</p>
				
</body>
</html>