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
        window.onload = function(){
            if($('#p_bidPgesStat').val() == '1002' || $('#p_bidPgesStat').val() == '1004'){
                $('#bidChngCause').attr('readonly',true);
                $('#cancelCaseTr').hide();
            }else{
                $('#cancelCaseTh').addClass("requ");
                $('#cancelCaseTr').show();
            }
            

            // 낙찰결과에 따른 유찰사유란 readonly
            $(":radio[name='bidPgesStat']").click(function(){
                var chkVal = $(":radio[name='bidPgesStat']:checked").val();
                if(chkVal == '1006'){
                    $('#bidChngCause').val('');
                    $('#bidChngCause').attr('readonly',true);
                    $('#evalCause').attr('readonly',false);
                    $('#evalCauseTh').addClass("requ");
                    $('#cancelCaseTh').removeClass();
                    $('#cancelCaseTr').hide();
                    $('#grundHeader').show();
                    $('#grundTable').show();
                }else if(chkVal == '1007'){
                    $('#bidChngCause').val('');
                    $('#bidChngCause').attr('readonly',false);
                    $('#evalCause').attr('readonly',true);
                    $('#evalCauseTh').removeClass();
                    $('#cancelCaseTh').addClass("requ");
                    $('#cancelCaseTr').show();                    
                    $('#grundHeader').hide();
                    $('#grundTable').hide();
                }else if(chkVal == '1008'){
                    $('#bidChngCause').val('');
                    $('#bidChngCause').attr('readonly',false);
                    $('#evalCause').attr('readonly',false);
                    $('#evalCauseTh').addClass("requ");
                    $('#cancelCaseTh').addClass("requ");
                    $('#cancelCaseTr').show();
                    $('#grundHeader').show();
                    $('#grundTable').show();
                }
            });
        };

	    //  목록보기 버튼
	    function returnList(){
	        document.searchForm.action = "/korean/pt/myCeart/BD_myCeartBidList.do";
		    document.searchForm.method = "POST";
		    document.searchForm.submit();
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

	    // 낙찰처리
	    function jsSuccessAction(){
	        // 낙찰 확정일 경우
	        if($('input:radio[name=bidPgesStat]:checked').val() == "1006" || $('input:radio[name=bidPgesStat]:checked').val() == "1008"){
	            if(commonChkVal()){
	                
	                // 첨부파일 체크
	                
	                if($('input[name=evalSheetFile]').val() == 0 && ($('input[name=evalSheetFileVal]').val() == null || $('input[name=evalSheetFileVal]').val() == "")){
	                    alert("평가서를 첨부하세요.");
	                    return false;
	                }

		            if(confirm("처리 하시겠습니까?")){
		                $('#succBidder').val($('input:radio[name=bidSussGbnChk]:checked').val());
		                
	                    // 첨부파일
	                    $("input[type=file]").each(function(){
	                        if(this.value == ''){
	                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                            $("#"+this.id).attr("disabled","disabled");
	                            
	                        }
	                    });

		                // 실제 저장 처리
		                $("#dataForm").attr("action", "ND_myCeartBidSuccessAction.do");
		                $("#dataForm").submit();
		            }
	            }
	        }else{
	            // 낙찰 취소일 경우
                // 낙찰자 변경 사유 필수 입력 체크
                if($('#bidChngCause').val() == null || $('#bidChngCause').val() == ""){
                    alert("낙찰취소 사유를 입력하세요.");
                    $("#bidChngCause").focus();
                    return false;
                }
                if(confirm("처리 하시겠습니까?")){
	                // 실제 저장 처리
	                $("#dataForm").attr("action", "ND_myCeartBidCancle.do");
	                $("#dataForm").submit();
                }
	        }
	    }
	    
	    // 공통 VAilation 체크
	    function commonChkVal(){
            // 낙찰근거
            if($('#evalCause').val() == null || $('#evalCause').val() == ""){
                alert("낙찰근거를 입력하세요.");
                $("#evalCause").focus();
                return false;
            }

            // 평가서
            if($('#evalSheetFile').val() == null || $('#evalSheetFile').val() == ""){
                alert("평가서를 첨부하세요.");
                return false;
            }

            // 낙찰자 선택
            if($('input:radio[name=bidSussGbnChk]:checked').val() == ""){
                alert("낙찰자를 선택하세요.");
                return false;
            }

            // 순위 체크
            var bidRankCnt = $("[name=bidRankVal] option:selected").length;
            var bidRank = $("[name=bidRankVal] option:selected").val();

            for(var i=0; i<bidRankCnt; i++){
                if($("[name=bidRankVal] option:selected").eq(i).val() == ''){
                    alert("순위를 모두 입력하세요.");
                    return false;
                }
                
                for(var j=0; j<bidRankCnt; j++){
                    var mstRowRank = $("[name=bidRankVal] option:selected").eq(i).val().split('|');;
                    var thisRowRank = $("[name=bidRankVal] option:selected").eq(j).val().split('|');;
	                if(mstRowRank[1] == thisRowRank[1]){
	                    if(i!=j){
		                    alert("중복 순위가 존재합니다.");
		                    return false;
	                    }
	                }
                }
            }

            if($('input:radio[name=bidSussGbnChk]:checked').val() == undefined || $('input:radio[name=bidSussGbnChk]:checked').val() == ''){
                alert("낙찰자를 선택하세요.");
                return false;
            }
            
            // 낙찰자 변경일 경우 낙찰자변경 사유란 필수 입력임.
            if($('input:radio[name=bidPgesStat]:checked').val() == "1008"){
                // 낙찰자 변경 사유
                if($('#bidChngCause').val() == null || $('#bidChngCause').val() == ""){
                    alert("낙찰자 변경 사유를 입력하세요.");
                    $("#bidChngCause").focus();
                    return false;
                }
            }
            return true;
	    }
    </script>

</head>
<body>
    <form name="searchForm" id="searchForm">
        <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     <!--  목록 페이지 조회조건1 -->
        <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     <!--  목록 페이지 조회조건2 -->
        <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   <!--  목록 페이지 검색어 -->
        <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        <!--  현재 페이지 -->
        <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   value="${baseList.notifyNum}"/>  <!--  공고번호 -->
        <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   value="${baseList.notifySeq}"/>  <!--  공고차수 -->
    </form>
    
	<div class="conWrap">
        <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="p_bidPgesStat"  id="p_bidPgesStat"  value="${baseList.bidPgesStat}"/> <!--  공고상태코드 -->
            <input type="hidden" name="notifyNum"      id="notifyNum"      value="${baseList.notifyNum}"/>   <!--  공고번호 -->
            <input type="hidden" name="notifySeq"      id="notifySeq"      value="${baseList.notifySeq}"/>   <!--  공고순번 -->
            <input type="hidden" name="succBidder"     id="succBidder" />   <!--  낙찰자 ID -->
        
			<div class="myceart view">
				<div class="tab_link e2">
					<a href="#" id="executeTitle1" >개찰</a>
					<a href="#" id="executeTitle2" class="on">낙찰선언</a>
				</div>
				<h3>낙찰유형</h3>
				<table class="tbl_st4">
					<tr>
						<th>종류</th>
						<td>
			                <c:choose>
			                    <c:when test="${baseList.bidPgesStat eq '1004'}">
			                        <label><input type="radio" name="bidPgesStat" value="1006" checked="checked"/> 낙찰확정</label>
			                    </c:when>
			                    <c:when test="${baseList.bidPgesStat eq '1006'}">
							        <label><input type="radio" name="bidPgesStat" value="1008" checked="checked"/> 낙찰자변경</label>
							        <label><input type="radio" name="bidPgesStat" value="1007" /> 낙찰취소</label>
			                    </c:when>
			                </c:choose>
						</td>
					</tr>
					<tr id="cancelCaseTr">
						<th id="cancelCaseTh">사유</th>
						<td><textarea name="bidChngCause" id="bidChngCause" ></textarea></td>
					</tr>
				</table>
	
				<h3>응찰현황</h3>
				<table class="tbl_st1">
					<thead>
						<tr>
							<th>응찰No</th>
							<th>사업자번호</th>
							<th>업체명</th>
							<th>응찰금액(원)</th>
							<th>응찰일시</th>
							<th>순위</th>
							<th>낙찰자<br />선택</th>
						</tr>
					</thead>
					<tbody>
	                    <c:forEach items="${pager}" var="bidTenderList" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${bidTenderList.bizrno}</td>
							<td>${bidTenderList.langStoreNm}</td>
							<td><fmt:formatNumber value="${bidTenderList.splyAmt}" groupingUsed="true"/></td>
							<td>${bidTenderList.bidEntrDt}</td>
							<td>
								<span class="sel_box">
									<select name="bidRankVal">
						    <option value="">선택</option>
                            <c:forEach var="i" begin="1" end="${fn:length(pager)}">
                                <c:set var="bidRank" value="${0+i}" />
                                <option value="${bidTenderList.userId}|${bidRank}" <c:if test="${bidTenderList.bidRank == bidRank}">selected="selected"</c:if> >${bidRank} 위</option>
                            </c:forEach>
									</select>
								</span>
							</td>
							<td>
                                <c:choose>
                                    <c:when test="${bidTenderList.bidSussGbn eq 'Y'}">
                                        <input type="radio" name="bidSussGbnChk" value="${bidTenderList.userId}" checked="checked"/>
                                    </c:when>
                                    <c:otherwise>
                                        <input type="radio" name="bidSussGbnChk" value="${bidTenderList.userId}"/>
                                    </c:otherwise>
                                </c:choose>
							</td>
						</tr>
	                    </c:forEach>

					</tbody>
				</table>
	
				<h3 id="grundHeader">낙찰근거</h3>
				<table class="tbl_st4" id="grundTable">
					<tr>
			            <c:choose>
			                <c:when test="${baseList.bidPgesStat eq '1004'}">
			                <th class="requ">평가서 첨부</th>
			                </c:when>
			                <c:when test="${baseList.bidPgesStat eq '1006'}">
			                <th>평가서 첨부</th>
			                </c:when>
			            </c:choose>
						
						<td colspan="3">
							<div class="uploadFile">
								<input type="text" readonly="readonly" name="evalSheetFileInput" id="evalSheetFileInput" title="파일명" />
								<div>							
					            	<span class="btns st3">
					            		파일선택
					            		<input type="file" name="evalSheetFileVal" id="evalSheetFileVal" class="evalSheetFileVal" title="파일찾기" onchange="javascript:jsFileChk('evalSheetFileVal', 'evalSheetFileInput', 'evalSheetFile');"/>
		                                <c:choose>
		                                    <c:when test="${baseList.evalSheetFile == null or baseList.evalSheetFile eq '0'}">
		                                    <input type="hidden" name="evalSheetFile" id="evalSheetFile" value="0"/>
		                                    </c:when>
		                                    <c:when test="${baseList.evalSheetFile != null or baseList.evalSheetFile ne '0'}">
		                                    <input type="hidden" name="evalSheetFile" id="evalSheetFile" value="${baseList.evalSheetFile}"/>
		                                    </c:when>
		                                </c:choose>
					            	</span>
				            	</div>

		            	<c:if test="${baseList.evalSheetFile != null and baseList.evalSheetFile ne '0'}">
			            <p id="uploadedFile" class="uploaded">
			            	<span>
			            	    <a href="/component/file/ND_fileDownload.do?id=${baseList.evalSheetFileId}" title="${baseList.evalSheetFileOrgNm}" class="aDeisable">${baseList.evalSheetFileOrgNm} <span class="tx_gray">(${baseList.evalSheetFileSize}, ${baseList.evalSheetFileTy})</span></a>
			            	    <a href="#" onclick="jsFileDelete('evalSheetFileVal', 'evalSheetFileInput', 'evalSheetFile'); return false;" />삭제</a>
			            	</span>
			            </p>
		            	</c:if>

				            </div>
						</td>
					</tr>

					<tr>
			            <c:choose>
			                <c:when test="${baseList.bidPgesStat eq '1004' or baseList.bidPgesStat eq '1006'}">
			                <th id="evalCauseTh" class="requ">설명</th>
			                </c:when>
			                <c:when test="${baseList.bidPgesStat eq '1006'}">
			                <th>설명</th>
			                </c:when>
			            </c:choose>
						<td><textarea name="evalCause" id="evalCause">${baseList.evalCause}</textarea></td>
					</tr>
				</table>
				
				<div class="btnArea rig">
					<a href="#" onclick="javascript:jsSuccessAction(); return false;" class="btns st1 icn icnSave">등록</a>
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>
		    </div>
        </form>
	</div>

	<!-- popup - 서비스 비교 -->
	<article class="popup serCompare">
		<h2>서비스 비교(10) <a href="#">닫기</a><i>* 최대 10개 까지 비교 가능합니다</i></h2>
		<div class="itemWrap">
		</div>
		<ul>
			<li><button onclick="javascript:jsCompareDetail(this); return false;"><i>선택서비스 비교</i></button></li>
			<li><button onclick="javascript:jsSetCompareClear(); return false;">전체 비우기</button></li>
		</ul>
	</article>
	<!--// popup - 구매요청 -->

    <script>
	$(document).ready(function() {
	    $( "#realOpenDt" ).datepicker({
	        showOn: "both", 
	        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	        buttonImageOnly: false,
	        buttonText: "달력"
	    });

	});
    </script>
  <!--// datepicker -->
</body>
</html>