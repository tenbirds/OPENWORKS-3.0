<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>	

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>상세정보(견적)요청서</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form, ckeditor" />
    <op:jsTag type="spi" items="form,datepicker, validate, multifile" />
	
    <script type="text/javascript">
        var date = new Date();
        var year  = date.getFullYear();
        var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
        var day   = date.getDate();
        if (("" + month).length == 1) { month = "0" + month; }
        if (("" + day).length   == 1) { day   = "0" + day;   }
        var nowDate = "" + year + month + day;
        /* 
         * [SaaS] 시스템요구 - 단위 selectbox 변경 이벤트
         */
        function funUnitSysChange(){
            if($('#unitSys').val() == '1006'){
                $('#etcUnitSys').show();
            }else{
                $('#etcUnitSys').hide();
            }
        }
        /* 
         * [SaaS] 옵션정보 행추가
         */
        function jsSaasAddRow(){
            $("#saasFromTab").append($("#sassAddRow").val());
        }

        /* 
         * [SaaS] 옵션정보 행삭제
         */
        function jsSaasDeleteRow(obj){
            $(obj).parent().parent().parent().remove();
        }

        // [IaaS] Server 영역 행추가
    	function jsIaasAddRow(){	   
    	    $("#serverTable01").append($("#serverAddRow01").val());
    	    $("#serverTable02").append($("#serverAddRow02").val());
    	};

    	// [IaaS] Server 영역 행삭제
    	function jsIaaSServerDeleteRow(obj){
    	    var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
    	    $("#serverTable02 > tbody").children("tr:eq("+trNum+")").remove();
    	    $(obj).parent().parent().parent().remove();
        };

        // DB 영역 행추가
    	function jsDbAddRow(){	   
    	    $("#dbTable01").append($("#dbAddRow01").val());
    	    $("#dbTable02").append($("#dbAddRow02").val());
    	};

    	// DB 영역 행삭제
    	function jsDbDeleteRow(obj){
    	    var trNum = $(obj).parent().closest('tbody').prevAll().length - 1;
    	    $("#dbTable02 > tbody").children("tr:eq("+trNum+")").remove();
    	    $(obj).parent().parent().parent().remove();
        };

        // 숫자만 입력하도록 체크
		function jsOnlyNumber(event){
			 var keyID = (event.which) ? event.which : event.keyCode;
    		  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
			else return false;
		}
		
		// 숫자만 입력하도록 체크2
		function removeChar(event) {
			event = event || window.event;
			 var keyID = (event.which) ? event.which : event.keyCode;
			  if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 || keyID == 9 ) return;
			else event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
        /* 
         * 첨부파일 반영
         */
		function jsFileChk(inputId, inputIdFake, fileId){
            // 기등록 첨부파일의 ID 제거
            $("input[name="+fileId+"]").val("0");
		    
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
		}

        /* 
         * 첨부파일 삭제
         */
		function jsFileDelete(inputId, inputIdFake, fileId){
            // 기등록 첨부파일의 ID 제거
            $("input[name="+fileId+"]").val("0");

		    document.getElementById(inputIdFake).value="";
		    $("input[name="+inputId+"]").val("");

		    $('#uploadedFile').hide();
		}

        /*
         * 응찰제한 - 자격제한 - 기타자격 체크박스 선택 이벤트
         */
        function jsCatyLimitEtcChk(){
            $("#catyLimitEtcComt").val('');
            
            if($("input:checkbox[id='catyLimitEtcChk']").is(":checked")){
                $("#catyLimitEtcComt").attr("readonly",false);
            }else{
                $("#catyLimitEtcComt").attr("readonly",true);
            }
        }
        /*
         * 납품 요구조건 - 납품 기한 - 체크박스 선택 시 날짜 초기화
         */
        function jstalkGbnChk(){
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                $("#delyDt").attr("readonly",false);
                $("#delyTime").prop("disabled", false);
            }else{
                $("#delyDt").val('');
                $("#delyDt").attr("readonly",true);
                $("#delyTime").val("");
                $("#delyTime").parents('span').find("span").html($("#delyTime option:selected").text());
                $("#delyTime").prop("disabled", true);
            }
        }

        /* 
         * 입찰 등록
         */
        function jsRequestRegist(bidGbnCd){

            var confirmMsg = "";
            var chkVal = true;
            
            // 공통 vaildation 체크
            var commonChkVal = checkEditorCommon();
            
            if(commonChkVal){
                if(bidGbnCd=='1001'){
                    msg = "입찰공고를 등록 하시겠습니까?";
                    // 정식 등록 vaildation 체크
                    chkVal = checkEditor();
                }else if(bidGbnCd=='1003'){
                    msg = "임시저장 하시겠습니까?";
                }
            }else{
                return false;
            }

            
            // 입력 필수값 체크
            if(chkVal){

                if(confirm(msg)) {
                    $('#bidGbnCd').val(bidGbnCd);// 입찰종류여부(1001:입찰/1003:임시저장)
                    
                    if($('input:radio[name=vatGbnRadio]:checked').attr("id") == "vatGbnY"){
                        $("#vatGbn").val("Y");
                    }else{
                        $("#vatGbn").val("N");
                    }
                    // 중소기업확인
                    if($('#catyLimitEntrChk').is(":checked") == true){
                        $("#catyLimitEntr").val("Y");
                    }else{
                        $("#catyLimitEntr").val("N");
                    }
                    // 벤처기업확인
                    if($('#catyLimitVntrChk').is(":checked") == true){
                        $("#catyLimitVntr").val("Y");
                    }else{
                        $("#catyLimitVntr").val("N");
                    }
                    // 사회적기업확인
                    if($('#catyLimitSocChk').is(":checked") == true){
                        $("#catyLimitSoc").val("Y");
                    }else{
                        $("#catyLimitSoc").val("N");
                    }
                    // 여성기업확인
                    if($('#catyLimitWomnChk').is(":checked") == true){
                        $("#catyLimitWomn").val("Y");
                    }else{
                        $("#catyLimitWomn").val("N");
                    }
                    // 중증장애인확인
                    if($('#catyLimitDiadChk').is(":checked") == true){
                        $("#catyLimitDiad").val("Y");
                    }else{
                        $("#catyLimitDiad").val("N");
                    }
                    // 기타자격확인
                    if($('#catyLimitEtcChk').is(":checked") == true){
                        $("#catyLimitEtc").val("Y");
                    }else{
                        $("#catyLimitEtc").val("N");
                    }
                    // 협의후 결정
                    if($('#talkGbnChkbox').is(":checked") == true){
                        $("#talkGbn").val("Y");
                    }else{
                        $("#talkGbn").val("N");
                    }
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });
                    // 실제 저장 처리
                    $("#dataForm").attr("action", "ND_requestRegistAction.do");
                    $("#dataForm").submit();
                }
            }
        }

        /* 
         * 입찰 등록시 입력 필수값 체크
         */
        function checkEditor(){
            // 공고종류 체크
            if($('input:radio[name=bidKndCd]:checked').attr("id") == "" || $('input:radio[name=bidKndCd]:checked').attr("id") == "undefined" ){
                alert("공고종류를 선택하세요.");
                $("#bidKndCd").focus();
                return false;
            }
            // 공고분류 체크
            if($('input:radio[name=bidClassCd]:checked').attr("id") == "" || $('input:radio[name=bidClassCd]:checked').attr("id") == "undefined" ){
                alert("공고분류를 선택하세요.");
                $("#bidClassCd").focus();
                return false;
            }
            // 계약방법 체크
            if($('input:radio[name=cntrMothod]:checked').attr("id") == "" || $('input:radio[name=cntrMothod]:checked').attr("id") == "undefined" ){
                alert("계약방법을 선택하세요.");
                $("#cntrMothod").focus();
                return false;
            }
            // 실수요 기관
            if($('#realDmndOrgn').val() == ""){
                alert("실수요 기관을 입력하세요.");
                $("#realDmndOrgn").focus();
                return false;
            }
            // 담당자명
            if($('#goodsChargerNm').val() == ""){
                alert("담당자명을 입력하세요.");
                $("#goodsChargerNm").focus();
                return false;
            }
            // 연락처 체크
            if($('#goodsChargerCttpc1').val() == ""){
                alert("연락처를 입력하세요.");
                $("#goodsChargerCttpc1").focus();
                return false;
            }
            if($('#goodsChargerCttpc2').val() == ""){
                alert("연락처를 입력하세요.");
                $("#goodsChargerCttpc2").focus();
                return false;
            }
            if($('#goodsChargerCttpc3').val() == ""){
                alert("연락처를 입력하세요.");
                $("#goodsChargerCttpc3").focus();
                return false;
            }

            //본공고일 경우 입찰진행
            if($('input:radio[name=bidKndCd]:checked').attr("value") == '1001'){
                // 입찰서 접수 일시
                if($('#strtDtExec').val() == ""){
                    alert("입찰서 접수 일을 입력하세요.");
                    $("#strtDtExec").focus();
                    return false;
                }
                
                if($("#strtTimeExec option:selected").val() == ""){
                    alert("입찰서 접수 시간을 입력하세요.");
                    $("#strtTimeExec").focus();
                    return false;
                }
                // 입찰서 접수일이 현재일 이전일 경우 return
                var strtDtExec = $("#strtDtExec").val().replace(/-/gi,"");
                if(nowDate > strtDtExec){
                    alert("입찰서 접수일은 현재일 이전일수 없습니다.");
                    $("#strtDtExec").focus();
                    return false;
                }

                // 입찰 접수 마감 일시
                if($('#clseDtExec').val() == ""){
                    alert("입찰서 접수 마감 일을 입력하세요.");
                    $("#clseDtExec").focus();
                    return false;
                }
                if($("#clseTimeExec option:selected").val() == ""){
                    alert("입찰서 접수 마감 시간을 입력하세요.");
                    $("#clseTimeExec").focus();
                    return false;
                }
                // 입찰서 마감일이 현재일 이전일 경우 return
                var clseDtExec = $("#clseDtExec").val().replace(/-/gi,"");
                if(nowDate > clseDtExec){
                    alert("입찰서 마감일은 현재일 이전일수 없습니다.");
                    $("#clseDtExec").focus();
                    return false;
                }

                // 개찰일시
                if($('#openDtExec').val() == ""){
                    alert("개찰 일을 입력하세요.");
                    $("#openDtExec").focus();
                    return false;
                }
                if($("#openTimeExec option:selected").val() == ""){
                    alert("개찰 시간을 입력하세요.");
                    $("#openTimeExec").focus();
                    return false;
                }
                // 입찰서 개찰일이 현재일 이전일 경우 return
                var openDtExec = $("#openDtExec").val().replace(/-/gi,"");
                if(nowDate > openDtExec){
                    alert("개찰일은 현재일 이전일수 없습니다.");
                    $("#openDtExec").focus();
                    return false;
                }

            }else{
                // 시작 일시
                if($('#strtDtResv').val() == ""){
                    alert("공고 시작일을 입력하세요.");
                    $("#strtDtResv").focus();
                    return false;
                }
                if($("#strtTimeResv option:selected").val() == ""){
                    alert("공고 시작시간을 입력하세요.");
                    $("#strtTimeResv").focus();
                    return false;
                }
                // 시작일이 현재일 이전일 경우 return
                var strtDtResv = $("#strtDtResv").val().replace(/-/gi,"");
                if(nowDate > strtDtResv){
                    alert("공고 시작일은 현재일 이전일수 없습니다.");
                    $("#strtDtResv").focus();
                    return false;
                }
                
                // 마감 일시
                if($('#clseDtResv').val() == ""){
                    alert("공고 마감 일을 입력하세요.");
                    $("#clseDtResv").focus();
                    return false;
                }
                if($("#clseTimeResv option:selected").val() == ""){
                    alert("공고 마감 시간을 입력하세요.");
                    $("#clseTimeResv").focus();
                    return false;
                }
                // 마감일이 현재일 이전일 경우 return
                var clseDtResv = $("#clseDtResv").val().replace(/-/gi,"");
                if(nowDate > clseDtResv){
                    alert("공고 마감일은 현재일 이전일수 없습니다.");
                    $("#clseDtResv").focus();
                    return false;
                }
            }
            
            // 납품요구조건 - 납품기한
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                // 납품기한 일자
                if($("#delyDt").val() == null || $("#delyDt").val() == ""){
                    alert("납품기한을 입력해주세요.");
                    $("#delyDt").focus();
                    return false;
                }else{
                    // 납품기한 일자가 현재일 이전일 경우 return
                    var delyDt = $("#delyDt").val().replace(/-/gi,"");
                    if(nowDate > delyDt){
                        alert("납품기한은 현재일 이전일수 없습니다.");
                        $("#delyDt").focus();
                        return false;                    
                    }
                }

                // 납품기한 일자
                if($("#delyTime option:selected").val() == null || $("#delyTime option:selected").val() == ""){
                    alert("납품기한을 입력해주세요.");
                    $("#delyTime").focus();
                    return false;
                }
            }
            return true;
        }

        /* 
         * 정식등록/임시등록 공통 입력 필수값 체크
         */
        function checkEditorCommon(){
            // 입찰공고명
            if($('#bidNotifyNm').val() == ""){
                alert("공고명을 입력하세요.");
                $("#bidNotifyNm").focus();
                return false;
            }

            // 납품기한 (협의후 결정이 아니면서 납품일자또는 납품시간만 입력한 경우 - 둘다 없거나 둘다 있어야함.)
            if(!$("input:checkbox[id='talkGbnChkbox']").is(":checked")){
                if($("#delyDt").val() != "" && $("#delyTime option:selected").val() == ""){
                    alert("납품시간을 입력하세요.");
                    $("#delyTime").focus();
                    return false;
                }else if($("#delyDt").val() == "" && $("#delyTime option:selected").val() != ""){
                    alert("납품일자를 입력하세요.");
                    $("#delyDt").focus();
                    return false;
                }
            }

            // 입찰진행 / 공고기간 (일자또는 시간만 입력한 경우 - 둘다 없거나 둘다 있어야함.)
            if($('input:radio[name=bidKndCd]:checked').attr("value") == '1001'){
                // 입찰 접수 일시
                if($("#strtDtExec").val() != "" && $("#strtTimeExec option:selected").val() == ""){
                    alert("입찰서 접수시간을 입력하세요.");
                    $("#strtTimeExec").focus();
                    return false;
                }else if($("#strtDtExec").val() == "" && $("#strtTimeExec option:selected").val() != ""){
                    alert("입찰서 접수 일자를 입력하세요.");
                    $("#strtDtExec").focus();
                    return false;
                }

                // 입찰 접수 마감 일시
                if($("#clseDtExec").val() != "" && $("#clseTimeExec option:selected").val() == ""){
                    alert("입찰서 접수 마감시간을 입력하세요.");
                    $("#clseTimeExec").focus();
                    return false;
                }else if($("#clseDtExec").val() == "" && $("#clseTimeExec option:selected").val() != ""){
                    alert("입찰서 접수 마감일자를 입력하세요.");
                    $("#clseDtExec").focus();
                    return false;
                }

                // 개찰일시
                if($("#openDtExec").val() != "" && $("#openTimeExec option:selected").val() == ""){
                    alert("개찰시간을 입력하세요.");
                    $("#openTimeExec").focus();
                    return false;
                }else if($("#openDtExec").val() == "" && $("#openTimeExec option:selected").val() != ""){
                    alert("개찰일자를 입력하세요.");
                    $("#openDtExec").focus();
                    return false;
                }

            }else{
                // 시작 일시
                if($("#strtDtResv").val() != "" && $("#strtTimeResv option:selected").val() == ""){
                    alert("공고 시작시간을 입력하세요.");
                    $("#strtTimeResv").focus();
                    return false;
                }else if($("#strtDtResv").val() == "" && $("#strtTimeResv option:selected").val() != ""){
                    alert("공고 시작일자를 입력하세요.");
                    $("#strtDtResv").focus();
                    return false;
                }
                
                // 마감 일시
                if($("#clseDtResv").val() != "" && $("#clseTimeResv option:selected").val() == ""){
                    alert("공고 마감시간을 입력하세요.");
                    $("#clseTimeResv").focus();
                    return false;
                }else if($("#clseDtResv").val() == "" && $("#clseTimeResv option:selected").val() != ""){
                    alert("공고 마감일자를 입력하세요.");
                    $("#clseDtResv").focus();
                    return false;
                }
            }

            return true;
        }
    </script>

</head>
<body>
<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
    <input type="hidden" name="bidGbnCd"     id="bidGbnCd"     />                  <!-- 입찰종류 (그룹코드 :2037 중 1001:입찰/1002:견적요청/1003:임시저장/사전견적:1004) -->
    <input type="hidden" name="userId"       id="userId"       value="<c:out value="${q_userId}" />" />    <!-- 이용자 ID -->
    <input type="hidden" name="userNm"       id="userNm"       value="${sessionScope['__usk'].userNm}" />  <!-- 이용자명 -->
    <input type="hidden" name="grpSeq"       id="grpSeq"       value="<c:out value="${p_grpSeq}" />" />    <!--  -->
    <input type="hidden" name="goodsTyCd"    id="goodsTyCd"    value="<c:out value="${p_goodsTyCd}" />" /> <!-- 서비스구분(SaaS:1002,PaaS:1001,IaaS:1003,Scs:1004) -->
    <input type="hidden" name="vatGbn"       id="vatGbn"       value="" />                                 <!-- VAT 여부 -->
    <input type="hidden" name="talkGbn"      id="talkGbn"      value="" />                                 <!-- 납품기한 합의여부 -->
    
    <input type="hidden" name="catyLimitEntr" id="catyLimitEntr" value="" />      <!-- 중소기업확인 -->
    <input type="hidden" name="catyLimitVntr" id="catyLimitVntr" value="" />      <!-- 벤처기업확인 -->
    <input type="hidden" name="catyLimitSoc"  id="catyLimitSoc"  value="" />      <!-- 사회적기업확인 -->
    <input type="hidden" name="catyLimitWomn" id="catyLimitWomn" value="" />      <!-- 여성기업확인 -->
    <input type="hidden" name="catyLimitDiad" id="catyLimitDiad" value="" />      <!-- 중증장애인확인 -->
    <input type="hidden" name="catyLimitEtc"  id="catyLimitEtc"  value="" />      <!-- 기타자격확인 -->
    
    <input type="hidden" name="p_cntrMothod" id="p_cntrMothod" value="${p_cntrMothod}" />                  <!-- 계약방법 -->
    <input type="hidden" name="p_bidKndCd"   id="p_bidKndCd"   value="${p_bidKndCd}" />                    <!-- 공고종류 -->
    
    <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   value="${tcnBidNotifyInfo.notifyNum}" />  <!-- 공고번호 -->
    <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   value="${tcnBidNotifyInfo.notifySeq}" />  <!-- 공고차수 -->

	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>공고등록</h2>  <!--입찰공고등록-->
		</div>
		<!--// 타이틀 영역 -->
	</section>
	
	<div class="conWrap detailRequ">
		<h3>공고등록</h3> <!--입찰공고등록-->
		<table class="tbl_st4">
			<tr>
				<th>공고번호</th>
				<td colspan="3">
                    <c:choose>
                        <c:when test="${tcnBidNotifyInfo.notifyNum != null and tcnBidNotifyInfo.notifyNum ne ''}">
                            ${tcnBidNotifyInfo.notifyNum}-${tcnBidNotifyInfo.notifySeq}
                        </c:when>
                    </c:choose>
				</td>
			</tr>
			<tr>
				<th class="requ">공고종류</th>
				<td>
				    <c:forEach items="${bidKndCdCodeList}" var="bidKndCdCode" varStatus="status">
				        <label><input type="radio" name="bidKndCd" value="${bidKndCdCode.PRVCD}" <c:if test="${(bidKndCdCode.PRVCD == p_bidKndCd)}"> checked='checked'</c:if> /> ${bidKndCdCode.PRVNM}</label>
				    </c:forEach>
				</td>
				<th class="requ">공고분류</th>
				<td>
				    <c:forEach items="${bidClassCdCodeList}" var="bidClassCdCode" varStatus="status">
				        <label><input type="radio" name="bidClassCd" value="${bidClassCdCode.PRVCD}" <c:if test="${(bidClassCdCode.PRVCD == p_bidClassCd)}"> checked='checked'</c:if>/> ${bidClassCdCode.PRVNM}</label>
				    </c:forEach>
				</td>
			</tr>
			<tr>
				<th class="requ">계약방법</th>
				<td colspan="3">
				    
				    <c:forEach items="${cntrMothodCodeList}" var="cntrMothodCode" varStatus="status">
				        <label><input type="radio" name="cntrMothod" value="${cntrMothodCode.PRVCD}" <c:if test="${(cntrMothodCode.PRVCD == p_cntrMothod)}"> checked='checked'</c:if> /> ${cntrMothodCode.PRVNM}</label>
				    </c:forEach>
				</td>
			</tr>
			<tr id="optlCntrFileTr" style="display:none">
				<th class="requ">
					수의계약 사유<br />
					공문 첨부
				</th>
				<td colspan="3">
					<div class="uploadFile">
						<input type="text" readonly="readonly" name="optlCntrFileInput" id="optlCntrFileInput" title="파일명"/>
						<div>
														
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="optlCntrFileVal" id="optlCntrFileVal" class="optlCntrFileVal" title="파일찾기" onchange="javascript:jsFileChk('optlCntrFileVal', 'optlCntrFileInput', 'optlCntrFile');"/>
                                <c:choose>
                                    <c:when test="${tcnBidNotifyInfo.optlCntrFile == null or tcnBidNotifyInfo.optlCntrFile eq '0'}">
                                    <input type="hidden" name="optlCntrFile" id="optlCntrFile" value="0"/>
                                    </c:when>
                                    <c:when test="${tcnBidNotifyInfo.optlCntrFile != null or tcnBidNotifyInfo.optlCntrFile ne '0'}">
                                    <input type="hidden" name="optlCntrFile" id="optlCntrFile" value="${tcnBidNotifyInfo.optlCntrFile}"/>
                                    </c:when>
                                </c:choose>
			            	</span>
		            	</div>
		            	<c:if test="${tcnBidNotifyInfo.optlCntrFile != null and tcnBidNotifyInfo.optlCntrFile ne '0'}">
			            <p id="uploadedFile" class="uploaded">
			            	<span>
			            	    <a href="/component/file/ND_fileDownload.do?id=${tcnBidNotifyInfo.optlCntrFileId}" title="${tcnBidNotifyInfo.optlCntrFileOrgNm}" class="aDeisable">${tcnBidNotifyInfo.optlCntrFileOrgNm} <span class="tx_gray">(${tcnBidNotifyInfo.optlCntrFileSize}, ${tcnBidNotifyInfo.optlCntrFileTy})</span></a>
			            	    <a href="#" onclick="jsFileDelete('optlCntrFileVal', 'optlCntrFileInput', 'optlCntrFile'); return false;" />삭제</a>
			            		
			            	</span>
			            </p>
		            	</c:if>
		            </div>
				</td>
			</tr>
			<tr>
				<th>발주(공고) 기관</th>
				<td>${sessionScope['__usk'].userNm}</td>
				<th class="requ">실수요 기관</th>
				<td><input type="text" name="realDmndOrgn" id="realDmndOrgn" value="${tcnBidNotifyInfo.realDmndOrgn}"/></td>
			</tr>
			<tr>
				<th class="requ">담당자 명</th>
				<td><input type="text" name="goodsChargerNm" id="goodsChargerNm" value="${tcnBidNotifyInfo.goodsChargerNm}"/></td>
				<th class="requ">연락처</th>
				<td class="tel">
					<input type="text" maxlength="4" id="goodsChargerCttpc1" name="goodsChargerCttpc1" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(tcnBidNotifyInfo.goodsChargerCttpc,'-')[0]}"/> -
					<input type="text" maxlength="4" id="goodsChargerCttpc2" name="goodsChargerCttpc2" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(tcnBidNotifyInfo.goodsChargerCttpc,'-')[1]}"/> -
					<input type="text" maxlength="4" id="goodsChargerCttpc3" name="goodsChargerCttpc3" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(tcnBidNotifyInfo.goodsChargerCttpc,'-')[2]}"/>
				</td>
			</tr>
			<tr>
				<th>연계기관 공고URL</th>
				<td colspan="3" class="unit">
					<i>http:// 또는 https://를 함께 작성</i>
					<div><input type="text" name="linkOrgnUrl" id="linkOrgnUrl" value="${tcnBidNotifyInfo.linkOrgnUrl}"/></div>
				</td>
			</tr>
			<tr>
				<th class="requ">공고명</th>
				<td colspan="3"><input type="text" name="bidNotifyNm" id="bidNotifyNm" value="${tcnBidNotifyInfo.bidNotifyNm}"/></td>
			</tr>
		</table>

		<h3 id="bidExecuteHeader" >공고집행</h3>  <!--입찰집행//-->
		<table class="tbl_st4" id="bidExecuteTable">
			<tr>
				<th class="requ">공고서 접수 일시</th>
				<td class="term">
					<input type="text" name="strtDtExec" id="strtDtExec" readonly="readonly" value="${tcnBidNotifyInfo.strtDt}"/>
				    <span class="sel_box">
						<select id="strtTimeExec" name="strtTimeExec">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${tcnBidNotifyInfo.strtTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                            </c:forEach>
						</select>
					</span>
				</td>
				<th class="requ">공고 접수 마감 일시</th>
				<td class="term">
					<input type="text" name="clseDtExec" id="clseDtExec" readonly="readonly" value="${tcnBidNotifyInfo.clseDt}"/>
				    <span class="sel_box">
						<select id="clseTimeExec" name="clseTimeExec">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${tcnBidNotifyInfo.clseTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                            </c:forEach>
						</select>
					</span>
				</td>
			</tr>
			<tr>
				<th class="requ">개찰일시</th>
				<td colspan="3" class="term">
					<input type="text" name="openDtExec" id="openDtExec" readonly="readonly" value="${tcnBidNotifyInfo.openDt}"/>
				    <span class="sel_box">
						<select id="openTimeExec" name="openTimeExec">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${tcnBidNotifyInfo.openTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                            </c:forEach>
						</select>
					</span>
				</td>
			</tr>
		</table>

		<!-- 예비공고일 경우 입찰집행 대신 출력 -->
		<h3 id="bidReserveHeader">공고기간</h3>
		<table class="tbl_st4" id="bidReserveTable">
			<tr>
				<th class="requ">시작일시</th>
				<td class="term">
					<input type="text" name="strtDtResv" id="strtDtResv" value="${tcnBidNotifyInfo.strtDt}"/>
				    <span class="sel_box">
						<select id="strtTimeResv" name="strtTimeResv">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${tcnBidNotifyInfo.strtTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                            </c:forEach>
						</select>
					</span>
				</td>
				<th class="requ">마감일시</th>
				<td class="term"> 
					<input type="text" name="clseDtResv" id="clseDtResv" value="${tcnBidNotifyInfo.clseDt}"/>
                    <span class="sel_box">
						<select id="clseTimeResv" name="clseTimeResv">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${tcnBidNotifyInfo.clseTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                            </c:forEach>
						</select>
					</span>
				</td>
			</tr>
		</table>
		<!--// 예비공고일 경우 입찰집행 대신 출력 -->
		
		<!-- 지명경쟁일 경우 노출  -->
		<h3 id="bidLimitHeader" >참여제한</h3>
		<table class="tbl_st4" id="bidLimitTable" >
			<tr>
				<th>지역제한</th>
				<td class="term">
					참가지역1
				    <span class="sel_box">
						<select id="areaLimit1" name="areaLimit1" >
					        <option value="">선택</option>
					        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
					            <option value="${areaLimitCode.PRVCD}" <c:if test="${tcnBidNotifyInfo.areaLimit1 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
					        </c:forEach>
						</select>
					</span>
					참가지역2
				    <span class="sel_box">
						<select id="areaLimit2" name="areaLimit2">
					        <option value="">선택</option>
					        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
					            <option value="${areaLimitCode.PRVCD}" <c:if test="${tcnBidNotifyInfo.areaLimit2 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
					        </c:forEach>
						</select>
					</span>
					참가지역3
				    <span class="sel_box">
						<select id="areaLimit3" name="areaLimit3">
					        <option value="">선택</option>
					        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
					            <option value="${areaLimitCode.PRVCD}" <c:if test="${tcnBidNotifyInfo.areaLimit3 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
					        </c:forEach>
						</select>
					</span>
					<p class="desc">
						※ 선택된 지역의 소재 업체만 투찰가능<br />
						※ 3개지역 입력 가능(3개 이상일 경우 제한 없음)
					</p>
				</td>
			</tr>
			<tr>
				<th>자격제한</th>
				<td>
					<label><input type="checkbox" id="catyLimitEntrChk" name="catyLimitEntrChk" <c:if test="${tcnBidNotifyInfo.catyLimitEntr == 'Y'}">checked=checked</c:if>/> 중소기업확인서</label>
					<label><input type="checkbox" id="catyLimitVntrChk" name="catyLimitVntrChk" <c:if test="${tcnBidNotifyInfo.catyLimitVntr == 'Y'}">checked=checked</c:if>/> 벤처기업확인서</label>
					<label><input type="checkbox" id="catyLimitSocChk" name="catyLimitSocChk" <c:if test="${tcnBidNotifyInfo.catyLimitSoc == 'Y'}">checked=checked</c:if>/> 사회적기업 확인서</label>
					<label><input type="checkbox" id="catyLimitWomnChk" name="catyLimitWomnChk" <c:if test="${tcnBidNotifyInfo.catyLimitWomn == 'Y'}">checked=checked</c:if>/> 여성기업 확인서</label>
					<label><input type="checkbox" id="catyLimitDiadChk" name="catyLimitDiadChk" <c:if test="${tcnBidNotifyInfo.catyLimitDiad == 'Y'}">checked=checked</c:if>/> 중증장애인 생산시설</label>
					<div class="ect">
						<label><input type="checkbox" id="catyLimitEtcChk" name="catyLimitEtcChk" onclick="jsCatyLimitEtcChk();" <c:if test="${tcnBidNotifyInfo.catyLimitEtc == 'Y'}">checked=checked</c:if>/> 기타자격</label>
						<input type="text" id="catyLimitEtcComt" name="catyLimitEtcComt" <c:if test="${tcnBidNotifyInfo.catyLimitEtc ne 'Y'}">readonly="readonly"</c:if> value="${tcnBidNotifyInfo.catyLimitEtcComt}"/>
					</div>
				</td>
			</tr>

		</table>
		<!--// 지명경쟁일 경우 노출  -->
		
		<!-- 지명경쟁일 경우 노출  -->
		<h3 id="bidDesignHeader" >지명참여</h3>
		<table class="tbl_st4" id="bidDesignTable" >
			<tr>
				<th>업체지명 (2곳이상)</th>
				<td><c:forEach items="${pager.list}" var="myWishList" varStatus="status">
				        ${myWishList.langStoreNm},&nbsp;
			        </c:forEach>
			    </td>
			</tr>
		</table>
		
		<h3>구매 물품 요건</h3>
		<table class="tbl_st4">
			<tr>
				<th>제품군</th>
				<td>
				    <c:forEach items="${goodsKndCdCodeList}" var="goodsKndCdCode" varStatus="status">
				        <c:if test="${(goodsKndCdCode.PRVCD == p_goodsTyCd)}"> ${goodsKndCdCode.PRVNM} </c:if>
				    </c:forEach>
				</td>
			</tr>
		</table>

        <!-- tbl_write -->
        <c:choose>
            <c:when test="${p_goodsTyCd eq 1001}">
                <%@include file="goods/BD_Paas.form.jsp" %>
            </c:when>
            <c:when test="${p_goodsTyCd eq 1002}">
                <%@include file="goods/BD_Saas.form.jsp" %>
            </c:when>
            <c:when test="${p_goodsTyCd eq 1003}">
                <%@include file="goods/BD_Iaas.form.jsp" %>
            </c:when>
        </c:choose>
        <!-- //tbl_write -->
         
		<h3>납품 요구조건</h3>
		<table class="tbl_st4">
			<tr>
				<th>희망 구매가</th>
				<td colspan="3" class="vat">
					<div class="unit">
						<i>원</i>
						<div><input type="text" id="hopePuchAmt" name="hopePuchAmt" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${tcnBidNotifyInfo.hopePuchAmt}"/></div>
					</div>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnY" value="Y" <c:if test="${(tcnBidNotifyInfo.vatGbn == 'Y') || (tcnBidNotifyInfo.vatGbn eq null)}">checked="checked"</c:if>/> VAT포함</label>
					<label><input type="radio" name="vatGbnRadio" id="vatGbnN" value="N" <c:if test="${(tcnBidNotifyInfo.vatGbn == 'N')}">checked="checked"</c:if>/> VAT미포함</label>
				</td>
			</tr>
			<tr>
				<th class="requ">납품 기한</th>
				<td colspan="3" class="term">
					<input type="text" id="delyDt" name="delyDt" readonly="readonly" value="${tcnBidNotifyInfo.delyDt}"/>
				    <span class="sel_box">
					    <select id="delyTime" name="delyTime">
						    <option value="">시간선택</option>
                            <c:forEach var="i" begin="9" end="18">
                                <c:set var="timeOption" value="${0+i}" />
                                <option value="${timeOption}" <c:if test="${(tcnBidNotifyInfo.delyTime == timeOption)}">selected="selected"</c:if>>${timeOption} 시</option>
                            </c:forEach>
					    </select>
					</span>
					<label><input type="checkbox" id="talkGbnChkbox" name="talkGbnChkbox" onclick="jstalkGbnChk();" <c:if test="${(tcnBidNotifyInfo.talkGbn == 'Y')}">checked="checked"</c:if>/> 합의후 결정</label>
				</td>
			</tr>
			<tr>
				<th>납품 장소</th>
				<td colspan="3"><input type="text" id="delyPlac" name="delyPlac" value="${tcnBidNotifyInfo.delyPlac}"/></td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td colspan="3">
					<div class="uploadFile">
						<input type="text" readonly="readonly" name="delyFileInput" id="delyFileInput" title="파일명"/>
						<div>
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="delyFileVal" id="delyFileVal" class="delyFileVal" title="파일찾기" onchange="jsFileChk('delyFileVal', 'delyFileInput', 'delyFile');"/>
                                <c:choose>
                                    <c:when test="${tcnBidNotifyInfo.delyFile == null or tcnBidNotifyInfo.delyFile eq '0'}">
                                    <input type="hidden" name="delyFile" id="delyFile" value="0"/>
                                    </c:when>
                                    <c:when test="${tcnBidNotifyInfo.delyFile != null or tcnBidNotifyInfo.delyFile ne '0'}">
                                    <input type="hidden" name="delyFile" id="delyFile" value="${tcnBidNotifyInfo.delyFile}"/>
                                    </c:when>
                                </c:choose>
			            	</span>
		            	</div>
		            	<c:if test="${tcnBidNotifyInfo.delyFile != null and tcnBidNotifyInfo.delyFile ne '0'}">
			            <p id="uploadedFile" class="uploaded">
			            	<span>
			            	    <a href="/component/file/ND_fileDownload.do?id=${tcnBidNotifyInfo.delyFileId}" title="${tcnBidNotifyInfo.delyFileOrgNm}" class="aDeisable">${tcnBidNotifyInfo.delyFileOrgNm} <span class="tx_gray">(${tcnBidNotifyInfo.delyFileSize}, ${tcnBidNotifyInfo.delyFileTy})</span></a>
			            	    <a href="#" onclick="jsFileDelete('delyFileVal', 'delyFileInput', 'delyFile'); return false;" />삭제</a>
			            		
			            	</span>
			            </p>
		            	</c:if>
		            </div>
				</td>
			</tr>
			<tr>
				<th>공고 설명</th>
				<td colspan="3"><textarea id="notifyCont" name="notifyCont" >${tcnBidNotifyInfo.notifyCont}</textarea></td>
			</tr>
		</table>
		
		
		<div class="btnArea rig">
			<a href="#" class="btns st1 icn icnSave" onclick="javascript:jsRequestRegist('1001'); return false;"> 등 록 </a>
			<a href="#" class="btns st1 icn icnSave" onclick="javascript:jsRequestRegist('1003'); return false;">임시저장</a>
		</div>
		<p class="alert_btn_bot">
			※ 임시저장 또는 등록된 공고는 마이씨앗 > 공고관리에서 확인 가능합니다.
		</p>
	</div>
	<!--// content -->
</form>

  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <!--<script type="text/javascript" src="/component/javascript/MD_globalConfig.do"></script>-->
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <!--<script type="text/javascript" src="/component/javascript/MD_massageConfig.do"></script>-->
  <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
  <script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>
    
  <script type="text/javascript" src="/resources/openworks/spi/jquery/notice/jquery.notice.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/printPreview/jquery.print-preview.js"></script>
     
  <script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>
   
  <script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>

  <!-- datepicker -->
  <link rel="stylesheet" href="/resources/openworks/spi/jquery/datepicker/jquery.datepicker.css" />
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.ui.core.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script.min.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script-addon.js"></script>
  <script src="/resources/openworks/spi/openworks/openworks.ui.js"></script>
  <script>
	$(document).ready(function() {
	    $( "#strtDtExec, #clseDtExec, #openDtExec, #strtDtResv, #clseDtResv, #delyDt" ).datepicker({
	        showOn: "both", 
	        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	        buttonImageOnly: false,
	        buttonText: "달력"
	    });

	});
	
	window.onload = function(){
	    // 계약방법
	    var cntrMothod = $('#p_cntrMothod').val();

	    // 계약방법에 따른 입력란 표기
        if(cntrMothod == 1004){
            // 지명경쟁
            $('#bidLimitHeader').show();
            $('#bidLimitTable').show();
            $('#bidDesignHeader').show();
            $('#bidDesignTable').show();
            $("[name=cntrMothod]:not(:checked)").attr("disabled","disabled");
        }else if(cntrMothod == 1003){
            // 수의계약
            $('#bidLimitHeader').hide();
            $('#bidLimitTable').hide();
            $('#bidDesignHeader').hide();
            $('#bidDesignTable').hide();
            $('#optlCntrFileTr').show(); // 수의계약 사유 공문 첨부
        }else if(cntrMothod == 1002){
            // 제한경쟁
            $('#bidLimitHeader').show();
            $('#bidLimitTable').show();
            $('#bidDesignHeader').hide();
            $('#bidDesignTable').hide();
        }else if(cntrMothod == 1001){
            // 일반경쟁
            $('#bidLimitHeader').hide();
            $('#bidLimitTable').hide();
            $('#bidDesignHeader').hide();
            $('#bidDesignTable').hide();
        }

	    // 공고종류
	    var bidKndCd = $('#p_bidKndCd').val();
	    // 공고종류에 따른 입력란 표기
        if(bidKndCd == 1001){
            // 본공고일 경우 입찰집행란 표기/공고기간란 숨김
            $('#bidExecuteHeader').show();
            $('#bidExecuteTable').show();
            
            $('#bidReserveHeader').hide();
            $('#bidReserveTable').hide();
        }else{
            // 예비공고일 경우 입찰집행란 숨김/공고기간란 표기
            $('#bidExecuteHeader').hide();
            $('#bidExecuteTable').hide();
            
            $('#bidReserveHeader').show();
            $('#bidReserveTable').show();
        }
		

        // 계약방법 라디오버튼 체크 이벤트
        $(":radio[name='cntrMothod']").click(function(){
            var chkVal = $(":radio[name='cntrMothod']:checked").val();
            
            // 지명경쟁이 아닌 상태에서 지명경쟁을 선택할수 없도록 처리
            if(cntrMothod != '1004' && chkVal == '1004'){
                return false;    
            }else{
                if(chkVal == 1003){
                    // 수의계약
                    $('#bidLimitHeader').hide();
                    $('#bidLimitTable').hide();
                    $('#bidDesignHeader').hide();
                    $('#bidDesignTable').hide();
                    
                    $('#optlCntrFileTr').show(); // 수의계약 사유 공문 첨부
                }else if(chkVal == 1002){
                    // 제한경쟁
                    $('#bidLimitHeader').show();
                    $('#bidLimitTable').show();
                    $('#bidDesignHeader').hide();
                    $('#bidDesignTable').hide();
                    
                    $('#optlCntrFileTr').hide(); // 수의계약 사유 공문 첨부
                }else if(chkVal == 1001){
                    // 일반경쟁
                    $('#bidLimitHeader').hide();
                    $('#bidLimitTable').hide();
                    $('#bidDesignHeader').hide();
                    $('#bidDesignTable').hide();
                    
                    $('#optlCntrFileTr').hide(); // 수의계약 사유 공문 첨부
                }
            }
        });
        
        // 공고종류 라디오버튼 체크 이벤트
        $(":radio[name='bidKndCd']").click(function(){
            var chkVal = $(":radio[name='bidKndCd']:checked").val();

            if(chkVal == 1001){
                $('#bidExecuteHeader').show();
                $('#bidExecuteTable').show();
                
                $('#bidReserveHeader').hide();
                $('#bidReserveTable').hide();
            }else{
                $('#bidReserveHeader').show();
                $('#bidReserveTable').show();
                
                $('#bidExecuteHeader').hide();
                $('#bidExecuteTable').hide();
            }
        });
	};
  </script>
  <!--// datepicker -->


</body>
</html>