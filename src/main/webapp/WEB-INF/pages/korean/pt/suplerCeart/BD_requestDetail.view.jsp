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
    <title>견적 요청서</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript">
        $(document).ready(function() {
    	    // 제공가 및 수량 컬럼 선택시 전체선택 되도록(초기값이 0이므로)
            $("#splyAmt").focus(function() { $(this).select(); } );
    	});

	    //  목록보기 버튼
	    function returnList(){
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_buyingRequestList.do";
	    	document.dataForm.method = "POST";
	    	document.dataForm.submit();        
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
	
	    // 숫자만 입력하도록 체크
	    var jsOnlyNumber = function(event){
	        var key = window.event ? event.keyCode : event.which;    
	
	        if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
	        || key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
	        || key  == 8  || key  == 46 || key  == 9)
	        ) {
	            return true;
	        }else {
	            return false;
	        }
	    };
	    
	    // 반려처리 이벤트
	    var returnRequest = function(){
	        if(confirm("반려처리 하시겠습니까?")){
	            // 실제 저장 처리
	            $("#dataForm").attr("action", "ND_suplerReturnRequestAction.do");
	            $("#dataForm").submit();
	        }
	    };
	    
	    // 발송처리
	    var sendRequest = function(){
	        if($('#splyAmt').val()==''){
	            alert("제공금액을 입력하세요.");
	            $('#splyAmt').focus();
	            return false;
	        }
	        if(confirm("발송 하시겠습니까?")){
	            // 첨부파일
	            $("input[type=file]").each(function(){
	                if(this.value == ''){
	                    $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
	                    $("#"+this.id).attr("disabled","disabled");
	                }
	            });
	
	            // 실제 저장 처리
	            $("#dataForm").attr("action", "ND_suplerSendRequestAction.do");
	            $("#dataForm").submit();
	        }
	    };
    </script>

</head>
<body>
    <!-- <div class="conWrap"> -->
		<div class="supAdm answAdm detail">
			<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
            <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     	<!--  목록 페이지 조회조건1 -->
            <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     	<!--  목록 페이지 조회조건2 -->
            <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   	<!--  목록 페이지 검색어 -->
            <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        	<!--  현재 페이지 -->
            <input type="hidden" name="notifyNum"    id="notifyNum"      value="${dataList.notifyNum}"/><!--  공고번호 -->
            <input type="hidden" name="notifySeq"    id="notifySeq"      value="${dataList.notifySeq}"/><!--  공고차수 -->
            <input type="hidden" name="goodKndCd"    id="goodKndCd"      value="${baseList.goodKndCd}"/><!--  서비스구분 -->
				
				<p class="viewTit">${dataList.goodsName}&nbsp;[${dataList.suplerNm}]</p>
				<h3>요청자 정보</h3>
				<table class="tbl_st4 e4">
					<tr>
						<th>작성자</th>
						<td>${baseList.endsUserNm}</td>
						<th>휴대전화</th>
						<td>${baseList.goodsChargerCttpc}</td>
					</tr>
					<tr>
						<th>기업/기관명</th>
						<td>${baseList.realDmndOrgn}</td>
						<th>이메일</th>
						<td>${baseList.endsEmail}</td>
					</tr>
					<tr>
						<th>직책</th>
						<td>${baseList.userPosition}</td>
						<th>대표전화</th>
						<td>${baseList.endsMbtlnum}</td>
					</tr>
				</table>

                <!-- tbl_write -->
                <c:choose>
                    <c:when test="${baseList.goodKndCd eq 1001}"><%@include file="goods/BD_Paas2.view.jsp" %></c:when>
                    <c:when test="${baseList.goodKndCd eq 1002}"><%@include file="goods/BD_Saas2.view.jsp" %></c:when>
                    <c:when test="${baseList.goodKndCd eq 1003}"><%@include file="goods/BD_Iaas2.view.jsp" %></c:when>
                </c:choose>
                <!-- //tbl_write -->

				<h3>납품 요구조건</h3>
				<table class="tbl_st4">
					<tr>
						<th>희망 구매가</th>
						<td colspan="3"><fmt:formatNumber value="${baseList.hopePuchAmt}" groupingUsed="true"/> 원 / 
					                    <c:choose>
                                            <c:when test="${baseList.vatGbn eq 'Y'}">VAT 포함</c:when>
                                            <c:when test="${baseList.vatGbn eq 'N'}">VAT 미포함</c:when>
                                        </c:choose>
						</td>
					</tr>
					<tr>
						<th>납품 기한</th>
						<td>
						    <c:choose>
						        <c:when test="${baseList.talkGbn eq 'Y'}">합의후 결정</c:when>
						        <c:when test="${baseList.talkGbn eq 'N'}">${baseList.delyDt} (${baseList.delyTime} 시)</c:when>
						    </c:choose>
                        </td>
						<th>응답 만료일</th>
						<td>${baseList.rplyDt} (${baseList.rplyTime} 시)</td>
					</tr>
					<tr>
						<th>납품 장소</th>
						<td colspan="3">${baseList.delyPlac}</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						    <c:if test="${baseList.delyFileId != null}">
						        <a href="/component/file/ND_fileDownload.do?id=${baseList.delyFileId}" title="${baseList.delyFileOrgNm}" class="aDeisable">${baseList.delyFileOrgNm} <span class="tx_gray">(${baseList.delyFileSize}, ${baseList.delyFileTy})</span></a>
						    </c:if>
                        </td>
					</tr>
					<tr>
						<th>추가문의</th>
						<td colspan="3">${baseList.notifyCont}</td>
					</tr>
				</table>
				<div class="replyWrap">
					<table class="tbl_st4">
						<tr>
							<th>제공금액</th>
							<td class="vat">
								<div class="unit">
									<i>원</i>				
									<div><input type="text" name="splyAmt" id="splyAmt" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" value="<fmt:formatNumber value="${dataList.splyAmt}" groupingUsed="true"/>"/></div>
								</div>
								<span>VAT포함</span>
							</td>
							
						</tr>
						<tr>
							<th>추가답변</th>
							<td><textarea name="addAnswer" id="addAnswer" >${dataList.addAnswer}</textarea></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><textarea name="splyNote" id="splyNote">${dataList.splyNote}</textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class="uploadFile">
									<input type="text" readonly="readonly" name="splyFileInput" id="splyFileInput" title="파일명"/>
									<div>
						            	<span class="btns st3">
						            		파일선택
						            		<input type="file" name="splyFileVal" id="splyFileVal" class="splyFileVal" title="파일찾기" onchange="javascript:jsFileChk('splyFileVal', 'splyFileInput', 'splyFile');"/>
			                                <c:choose>
			                                    <c:when test="${dataList.splyFile == null or dataList.splyFile eq '0'}">
			                                    <input type="hidden" name="splyFile" id="splyFile" value="0"/>
			                                    </c:when>
			                                    <c:when test="${dataList.splyFile != null and dataList.splyFile ne '0'}">
			                                    <input type="hidden" name="splyFile" id="splyFile" value="${dataList.splyFile}"/>
			                                    </c:when>
			                                </c:choose>
						            	</span>
					            	</div>
					            	<c:if test="${dataList.splyFile != null and dataList.splyFile ne '0'}">
						            <p id="uploadedFile" class="uploaded">
						            	<span>
						            	    <a href="/component/file/ND_fileDownload.do?id=${dataList.splyFileId}" title="${dataList.splyFileOrgNm}" class="aDeisable">${dataList.splyFileOrgNm} <span class="tx_gray">(${dataList.splyFileSize}, ${dataList.splyFileTy})</span></a>
						            	    <a href="#" onclick="jsFileDelete('splyFileVal', 'splyFileInput', 'splyFile'); return false;" />삭제</a>
						            		
						            	</span>
						            </p>
					            	</c:if>

					            </div>
							</td>
						</tr>
					</table>

					<h3>제공자 정보</h3>
					<table class="tbl_st4 e4">
						<tr>
							<th>회사명</th>
							<td colspan="3">${sessionScope['__usk'].userNm}</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td>${dataList.storeChargerNm}</td>
							<th>대표전화</th>
							<td>${dataList.reprsntTelno}</td>
						</tr>
						<tr>
							<!-- <th>직책</th>
							<td></td> -->
							<th>이메일</th>
							<td>${dataList.reprsntEmail}</td>
							<th>휴대전화</th>
							<td>${dataList.mbtlnum}</td>
						</tr>
					</table>
				</div>
				
				<div class="btnArea rig">
                    <c:choose>
                        <c:when test="${dataList.askApplyCd eq '1001'}">
                            <!-- 반려상태의 견적은 반려/발송버튼 숨김 -->
					        <a href="#" onclick="javascript:returnRequest(); return false;" class="btns st2 icn icnBck">반려</a>
					        <a href="#" onclick="javascript:sendRequest(); return false;" class="btns st4 icn icnSend">발송</a>
                        </c:when>
                    </c:choose>
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st4 icn icnList">목록보기</a>
				</div>
			</form>
		</div>
	    
	<!-- </div> -->
	<!--// content -->
 </body>
</html>