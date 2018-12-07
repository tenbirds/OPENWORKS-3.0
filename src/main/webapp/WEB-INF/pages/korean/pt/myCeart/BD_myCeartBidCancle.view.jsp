<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>상세정보(견적)요청서 Saas</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript">
        //  목록보기 버튼
        function returnList(){
            document.listForm.action = "/korean/pt/myCeart/BD_myCeartBidList.do";
    	    document.listForm.method = "POST";
    	    document.listForm.submit();
        }
        
        
        /* 
         * 숫자만 입력하도록 체크
         */
        function jsOnlyNumber(event){
        	var keyID = (event.which) ? event.which : event.keyCode;
			if(( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8)
			{
				return;
			}
			else
			{
			   return false;
			}
			            
        }

        /* 크롬- 숫자만 입력하도록 체크*/
		function removeChar(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
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
         * 등록 이벤트
         */
        function jsBidCancel(){
            var confirmMsg = "";
            var vaildState = true;
            var chkVal = $(":radio[name='bidPgesStat']:checked").val();
            
            // 공통 필수값 체크 성공시
            if(checkCommonEditor()){
                // 변경 상태가 연기/변경일 경우에만 필수값 체크
                if(chkVal == 1009 || chkVal == 1010){
                    vaildState = checkEditor(chkVal);
                    confirmMsg = "등록하시겠습니까?";
                }else{
                    confirmMsg = "해당공고를 취소처리 하시겠습니까?";
                }
                
                if(vaildState){
                    if(confirm(confirmMsg)) {
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

                        // 첨부파일
                        $("input[type=file]").each(function(){
                            if(this.value == ''){
                                $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                                $("#"+this.id).attr("disabled","disabled");
                            }
                        });

                        // 실제 저장 처리
                        $("#dataForm").attr("action", "ND_myCeartBidCancelAction.do");
                        $("#dataForm").submit();
                    }
                }
            }

        }
        
        /*
         * 필수값 체크
         */
        function checkCommonEditor(){
            // 입찰 접수 마감 일시
            if($('#bidChngCause').val() == ""){
                alert("사유를 입력하세요.");
                $("#bidChngCause").focus();
                return false;
            }
            return true;
        }
        /*
         * 필수값 체크
         */
        function checkEditor(chkVal){
            
            var bidKndCd = $('#bidKndCd').val();

            if(bidKndCd == '1001'){
                //본공고일 경우
                // 입찰서 접수 일시
                if($('#strtDtExec').val() == ""){
                    alert("시작일자를 입력하세요.");
                    $("#strtDtExec").focus();
                    return false;
                }
                
                if($("#strtTimeExec option:selected").val() == ""){
                    alert("시작시간을 입력하세요.");
                    $("#strtTimeExec").focus();
                    return false;
                }
                
                // 입찰 접수 마감 일시
                if($('#clseDtExec').val() == ""){
                    alert("마감일자를 입력하세요.");
                    $("#clseDtExec").focus();
                    return false;
                }

                if($("#clseTimeExec option:selected").val() == ""){
                    alert("마감시간을 입력하세요.");
                    $("#clseTimeExec").focus();
                    return false;
                }

                // 개찰일시
                if($('#openDtExec').val() == ""){
                    alert("개찰 일자를 입력하세요.");
                    $("#openDtExec").focus();
                    return false;
                }

                if($("#openTimeExec option:selected").val() == ""){
                    alert("개찰 시간을 입력하세요.");
                    $("#openTimeExec").focus();
                    return false;
                }

            }else{
                // 시작 일시
                if($('#strtDtResv').val() == ""){
                    alert("공고 시작일자를 입력하세요.");
                    $("#strtDtResv").focus();
                    return false;
                }
                if($("#strtTimeResv option:selected").val() == ""){
                    alert("공고 시작시간을 입력하세요.");
                    $("#strtTimeResv").focus();
                    return false;
                }
                
                // 마감 일시
                if($('#clseDtResv').val() == ""){
                    alert("공고 마감 일자을 입력하세요.");
                    $("#clseDtResv").focus();
                    return false;
                }
                if($("#clseTimeResv option:selected").val() == ""){
                    alert("공고 마감 시간을 입력하세요.");
                    $("#clseTimeResv").focus();
                    return false;
                }
            }

            // 내용변경시 필수값 체크
            if(chkVal == '1010'){
                // 입찰공고명
                if($('#bidNotifyNm').val() == ""){
                    alert("입찰공고명을 입력하세요.");
                    $("#bidNotifyNm").focus();
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

                // 수의계약일 경우 수의계약 사유공문 파일 체크
                var cntrMothod = $(":radio[name='cntrMothod']:checked").val();
                if(cntrMothod == '1003'){
                    if($('#optlCntrFileInput').val() == ""){
                        alert("수의계약 사유공문을 입력하세요.");
                        return false;
                    }
                }
            }

            return true;
        }
    </script>

</head>
<body>
    <form name="listForm" id="listForm" method="post">
        <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     <!--  목록 페이지 조회조건1 -->
        <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     <!--  목록 페이지 조회조건2 -->
        <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   <!--  목록 페이지 검색어 -->
        <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        <!--  현재 페이지 -->
        
        <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   value="${baseList.notifyNum}"/>   <!-- 공고번호 -->
        <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   value="${baseList.notifySeq}"/>   <!-- 공고차수 -->
        <input type="hidden" name="p_cntrMothod"  id="p_cntrMothod"  value="${p_cntrMothod}" />        <!-- 계약방법 -->
        <input type="hidden" name="p_bidKndCd"    id="p_bidKndCd"    value="${p_bidKndCd}" />          <!-- 서비스구분 -->
        <input type="hidden" name="p_bidPgesStat" id="p_bidPgesStat" value="${p_bidPgesStat}" /> <!-- 입찰진행상태 -->
    </form>

	<div class="conWrap">
        <form name="dataForm" id="dataForm" method="post">
            <input type="hidden" name="notifyNum"   id="notifyNum"   value="${baseList.notifyNum}"/>   <!-- 공고번호 -->
            <input type="hidden" name="notifySeq"   id="notifySeq"   value="${baseList.notifySeq}"/>   <!-- 공고차수 -->

            <input type="hidden" name="catyLimitEntr" id="catyLimitEntr" value="" />      <!-- 중소기업확인 -->
            <input type="hidden" name="catyLimitVntr" id="catyLimitVntr" value="" />      <!-- 벤처기업확인 -->
            <input type="hidden" name="catyLimitSoc"  id="catyLimitSoc"  value="" />      <!-- 사회적기업확인 -->
            <input type="hidden" name="catyLimitWomn" id="catyLimitWomn" value="" />      <!-- 여성기업확인 -->
            <input type="hidden" name="catyLimitDiad" id="catyLimitDiad" value="" />      <!-- 중증장애인확인 -->
            <input type="hidden" name="catyLimitEtc"  id="catyLimitEtc"  value="" />      <!-- 기타자격확인 -->

			<div class="myceart view change">				
				<h3>공고변경/취소</h3>
				<table class="tbl_st4 e2">
					<thead>
						<tr>
							<th colspan="2">
								<label><input type="radio" name="bidPgesStat" value="1009" checked='checked'/> 공고연기</label>
								<label><input type="radio" name="bidPgesStat" value="1010" /> 내용변경</label>
								<label><input type="radio" name="bidPgesStat" value="1011" /> 공고취소</label>
							</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th class="requ" id="cancleTitle">연기사유</th>
							<td>
								<textarea name="bidChngCause" id="bidChngCause" ></textarea>
							</td>
						</tr>
					</tbody>
				</table>

				<h3>공고일반 </h3>
				<table class="tbl_st4">
					<tr>
						<th>공고번호</th>
						<td colspan="3">${baseList.notifyNum}-${baseList.notifySeq}</td>
					</tr>
					<tr>
						<th class="requ">공고종류</th>
						<td>
						    <label>${baseList.bidKndNm}</label>
						    <input type="hidden" name="bidKndCd" id="bidKndCd" value="${baseList.bidKndCd}"/>
						</td>
						<th class="requ">공고분류</th>
						<td>
				            <c:forEach items="${bidClassCdCodeList}" var="bidClassCdCode" varStatus="status">
				                <label><input type="radio" name="bidClassCd" value="${bidClassCdCode.PRVCD}" <c:if test="${(bidClassCdCode.PRVCD == baseList.bidClassCd)}"> checked='checked'</c:if>/> ${bidClassCdCode.PRVNM}</label>
				            </c:forEach>
						</td>
					</tr>
					<tr>
						<th class="requ">계약방법</th>
						<td colspan="3">
				            <c:forEach items="${cntrMothodCodeList}" var="cntrMothodCode" varStatus="status">
				                <label><input type="radio" name="cntrMothod" value="${cntrMothodCode.PRVCD}" <c:if test="${(cntrMothodCode.PRVCD == baseList.cntrMothod)}"> checked='checked'</c:if> /> ${cntrMothodCode.PRVNM}</label>
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
								<input type="text" readonly="readonly" name="optlCntrFileInput" id="optlCntrFileInput" title="파일명" value="${tcnBidNotifyInfo.optlCntrFileOrgNm}"/>
								<div>
									<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="javascript:jsFileDelete('optlCntrFileVal', 'optlCntrFileInput', 'optlCntrFile');" alt="삭제" />							
					            	<span class="btns st3">
					            		파일선택
					            		<input type="file" name="optlCntrFileVal" id="optlCntrFileVal" class="optlCntrFileVal" title="파일찾기" onchange="javascript:jsFileChk('optlCntrFileVal', 'optlCntrFileInput', 'optlCntrFile');"/>
		                                <c:choose>
		                                    <c:when test="${tcnBidNotifyInfo.optlCntrFile == null or tcnBidNotifyInfo.optlCntrFile eq '0'}">
		                                    <input type="hidden" name="optlCntrFile" id="optlCntrFile" value="0"/>
		                                    </c:when>
		                                    <c:when test="${tcnBidNotifyInfo.optlCntrFile != null or tcnBidNotifyInfo.optlCntrFile ne '0'}">
		                                    <input type="hidden" name="optlCntrFile" id="optlCntrFile" value="${optlCntrFile}"/>
		                                    </c:when>
		                                </c:choose>
					            	</span>
				            	</div>
				            </div>
						</td>
					</tr>

					<tr>
						<th>발주(공고) 기관</th>
						<td>${sessionScope['__usk'].userNm}</td>
						<th class="requ">실수요 기관</th>
						<td><input type="text" name="realDmndOrgn" id="realDmndOrgn" value="${baseList.realDmndOrgn}"/></td>
					</tr>
					<tr>
						<th class="requ">담당자 명</th>
						<td><input type="text" name="goodsChargerNm" id="goodsChargerNm" value="${baseList.goodsChargerNm}"/></td>
						<th class="requ">연락처</th>
						<td class="tel">
							<input type="text" maxlength="4" id="goodsChargerCttpc1" name="goodsChargerCttpc1" style="ime-mode:disabled; width:92px !important;" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(baseList.goodsChargerCttpc,'-')[0]}" /> - 
							<input type="text" maxlength="4" id="goodsChargerCttpc2" name="goodsChargerCttpc2" style="ime-mode:disabled; width:92px !important;" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(baseList.goodsChargerCttpc,'-')[1]}"/> - 
							<input type="text" maxlength="4" id="goodsChargerCttpc3" name="goodsChargerCttpc3" style="ime-mode:disabled; width:93px !important;" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(baseList.goodsChargerCttpc,'-')[2]}"/>
						</td>
					</tr>
					<tr>
						<th>연계기관 공고URL</th>
						<td colspan="3" class="unit">
							<i>http:// 또는 https://를 함께 작성</i>
							<div><input type="text" name="linkOrgnUrl" id="linkOrgnUrl" value="${baseList.linkOrgnUrl}"/></div>					
						</td>
					</tr>
					<tr>
						<th class="requ">입찰공고명</th>
						<td colspan="3"><input type="text" name="bidNotifyNm" id="bidNotifyNm" value="${baseList.bidNotifyNm}" /></td>
					</tr>
				</table>
				
				<!-- 본 공고 일경우 -->				
				<h3 id="bidExecuteHeader">입찰집행</h3>
				<table class="tbl_st4 e4 term" id="bidExecuteTable">
					<tr>
						<th class="requ">시작일시</th>
						<td>
							<input type="text" name="strtDtExec" id="strtDtExec" readonly="readonly"  value="${baseList.strtDt}"/>
							<span class="sel_box">
					            <select id="strtTimeExec" name="strtTimeExec">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="0" end="23">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.strtTime == timeOption}">selected=selected</c:if>>${timeOption} 시</option>
                                       </c:forEach>
					            </select>
							</span>
						</td>
						<th class="requ">마감일시</th>
						<td>
							<input type="text" name="clseDtExec" id="clseDtExec" readonly="readonly"  value="${baseList.clseDt}"/>
							<span class="sel_box">
					            <select id="clseTimeExec" name="clseTimeExec">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="0" end="23">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.clseTime == timeOption}">selected=true</c:if>>${timeOption} 시</option>
                                       </c:forEach>
					            </select>
							</span>
						</td>
					</tr>
					<tr>
						<th class="requ">개찰일시</th>
						<td colspan="3">
							<input type="text" name="openDtExec" id="openDtExec" readonly="readonly"  value="${baseList.openDt}"/>
							<span class="sel_box">
					            <select id="openTimeExec" name="openTimeExec">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="0" end="23">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.openTime == timeOption}">selected=true</c:if>>${timeOption} 시</option>
                                       </c:forEach>
					            </select>	
							</span>
						</td>
					</tr>
				</table>
				<!--// 본 공고 일경우 -->				
				
				<!-- 예비공고일 경우 -->
				<h3 id="bidReserveHeader">공고기간</h3>
				<table class="tbl_st4 e4 term" id="bidReserveTable">
					<tr>
						<th class="requ">시작일시</th>
						<td>
							<input type="text" name="strtDtResv" id="strtDtResv"  readonly="readonly"  value="${baseList.strtDt}"/>
							<span class="sel_box">
					            <select id="strtTimeResv" name="strtTimeResv">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="0" end="23">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.strtTime == timeOption}">selected=true</c:if>>${timeOption} 시</option>
                                       </c:forEach>
					            </select>
							</span>
						</td>
						<th class="requ">마감일시</th>
						<td>
							<input type="text" name="clseDtResv" id="clseDtResv" readonly="readonly"  value="${baseList.clseDt}"/>
							<span class="sel_box">
					            <select id="clseTimeResv" name="clseTimeResv">
					                <option value="">선택</option>
                                       <c:forEach var="i" begin="0" end="23">
                                           <c:set var="timeOption" value="${0+i}" />
                                           <option value="${timeOption}" <c:if test="${baseList.clseTime == timeOption}">selected=true</c:if>>${timeOption} 시</option>
                                       </c:forEach>
					            </select>
							</span>
						</td>
					</tr>
				</table>					
				<!--// 예비공고일 경우 -->

				<!-- 제한경쟁/지명경쟁일 경우 노출  -->
				<h3 id="bidLimitHeader" >응찰제한</h3>
				<table class="tbl_st4" id="bidLimitTable" >
					<tr>
						<th>지역제한</th>
						<td class="term">
							참가지역1
						    <span class="sel_box">
								<select id="areaLimit1" name="areaLimit1" >
							        <option value="">선택</option>
							        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
							            <option value="${areaLimitCode.PRVCD}" <c:if test="${baseList.areaLimit1 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
							        </c:forEach>
								</select>
							</span>
							참가지역2
						    <span class="sel_box">
								<select id="areaLimit2" name="areaLimit2">
							        <option value="">선택</option>
							        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
							            <option value="${areaLimitCode.PRVCD}" <c:if test="${baseList.areaLimit2 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
							        </c:forEach>
								</select>
							</span>
							참가지역3
						    <span class="sel_box">
								<select id="areaLimit3" name="areaLimit3">
							        <option value="">선택</option>
							        <c:forEach items="${areaLimitCodeList}" var="areaLimitCode" varStatus="status">
							            <option value="${areaLimitCode.PRVCD}" <c:if test="${baseList.areaLimit3 == areaLimitCode.PRVCD}">selected=selected</c:if>>${areaLimitCode.PRVNM}</option>    
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
							<label><input type="checkbox" id="catyLimitEntrChk" name="catyLimitEntrChk" <c:if test="${baseList.catyLimitEntr == 'Y'}">checked=checked</c:if>/> 중소기업확인서</label>
							<label><input type="checkbox" id="catyLimitVntrChk" name="catyLimitVntrChk" <c:if test="${baseList.catyLimitVntr == 'Y'}">checked=checked</c:if>/> 벤처기업확인서</label>
							<label><input type="checkbox" id="catyLimitSocChk" name="catyLimitSocChk" <c:if test="${baseList.catyLimitSoc == 'Y'}">checked=checked</c:if>/> 사회적기업 확인서</label>
							<label><input type="checkbox" id="catyLimitWomnChk" name="catyLimitWomnChk" <c:if test="${baseList.catyLimitWomn == 'Y'}">checked=checked</c:if>/> 여성기업 확인서</label>
							<label><input type="checkbox" id="catyLimitDiadChk" name="catyLimitDiadChk" <c:if test="${baseList.catyLimitDiad == 'Y'}">checked=checked</c:if>/> 중증장애인 생산시설</label>
							<div class="ect">
								<label><input type="checkbox" id="catyLimitEtcChk" name="catyLimitEtcChk" onclick="jsCatyLimitEtcChk();" <c:if test="${baseList.catyLimitEtc == 'Y'}">checked=checked</c:if>/> 기타자격</label>
								<input type="text" id="catyLimitEtcComt" name="catyLimitEtcComt" <c:if test="${baseList.catyLimitEtc ne 'Y'}">readonly="readonly"</c:if> value="${baseList.catyLimitEtcComt}" />
							</div>
						</td>
					</tr>
		
				</table>
				<!--// 제한경쟁/지명경쟁일 경우 노출  -->

				<!-- 지명경쟁일 경우 노출  -->
				<h3 id="bidDesignHeader" >응찰지명</h3>
				<table class="tbl_st4" id="bidDesignTable" >
					<tr>
						<th>업체지명 (2곳이상)</th>
						<td>
						<c:forEach items="${pager}" var="myWishList" varStatus="status">
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
						    ${baseList.goodKndNm}
						</td>
					</tr>
				</table>

				<div class="btnArea rig">
					<a href="#" onclick="javascript:jsBidCancel(); return false;" class="btns st1 icn icnSave">등록</a>
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
			</div>
		</form>
	</div>
	<!--// content -->
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
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
	    var cntrMothod = $('#p_cntrMothod').val();
	    // 계약방법에 따른 화면 설정
        if(cntrMothod == 1004){
            $('#bidLimitHeader').show();  // 응찰제한
            $('#bidLimitTable').show();
            $('#bidDesignHeader').show(); // 응찰지명
            $('#bidDesignTable').show();
            $('#optlCntrFileTr').hide();  // 수의계약 사유 공문 첨부
            $("[name=cntrMothod]:not(:checked)").attr("disabled","disabled");
        }else if(cntrMothod == 1003){
            $('#bidLimitHeader').hide();  // 응찰제한
            $('#bidLimitTable').hide();
            $('#bidDesignHeader').hide(); // 응찰지명
            $('#bidDesignTable').hide();
            $('#optlCntrFileTr').show();  // 수의계약 사유 공문 첨부
        }else if(cntrMothod == 1002){
            $('#bidLimitHeader').show();  // 응찰제한
            $('#bidLimitTable').show();
            $('#bidDesignHeader').hide(); // 응찰지명
            $('#bidDesignTable').hide();
            $('#optlCntrFileTr').hide();  // 수의계약 사유 공문 첨부
        }else if(cntrMothod == 1001){
            $('#bidLimitHeader').hide();  // 응찰제한
            $('#bidLimitTable').hide();
            $('#bidDesignHeader').hide(); // 응찰지명
            $('#bidDesignTable').hide();
            $('#optlCntrFileTr').hide();  // 수의계약 사유 공문 첨부
        }

        var bidKndCd = $('#p_bidKndCd').val();
        // 공고종류에 따른 화면설정
        if(bidKndCd == 1001){
            $('#bidReserveHeader').hide();  // 공고기간
            $('#bidReserveTable').hide();
            $('#bidExecuteHeader').show();
            $('#bidExecuteTable').show();
        }else if(bidKndCd == 1002){
            $('#bidReserveHeader').show();  // 공고기간
            $('#bidReserveTable').show();
            $('#bidExecuteHeader').hide();
            $('#bidExecuteTable').hide();
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
        
        // 공고 연기/취소 사유 라디오에 따른 타이틀 전환
        $(":radio[name='bidPgesStat']").click(function(){
            var chkVal = $(":radio[name='bidPgesStat']:checked").val();
            if(chkVal == 1009){
                $('#cancleTitle').html('연기사유');
            }else if(chkVal == 1010){
                $('#cancleTitle').html('변경사유');
            }else if(chkVal == 1011){
                $('#cancleTitle').html('취소사유');
            }
        });
	};
  </script>
  <!--// datepicker -->

  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>
</html>