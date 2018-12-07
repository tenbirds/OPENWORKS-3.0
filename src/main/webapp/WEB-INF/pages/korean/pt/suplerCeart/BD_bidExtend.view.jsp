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
    <title>응찰 - 공고현황 - 입찰공고</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
	    $(document).ready(function() {
		    // 공급가 및 수량 컬럼 선택시 전체선택 되도록(초기값이 0이므로)
	        $("#splyAmt").focus(function() { $(this).select(); } );
	        $("#amountSys").focus(function() { $(this).select(); } );
	        $("[name=amountItem]").focus(function() { $(this).select(); } );
	        
	    });

	    //  목록보기 버튼
	    var returnList = function(){
	        document.listForm.action = "/korean/pt/suplerCeart/BD_bidPartcptnList.do";
		    document.listForm.method = "GET";
		    document.listForm.submit();
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
         * [SaaS] 시스템요구 - 단위 selectbox 변경 이벤트
         */
        var funUnitSysChange = function(){
            //alert($('#unitSys').val());
            if($('#unitSys').val() == '1006'){
                $('#etcUnitSys').show();
            }else{
                $('#etcUnitSys').hide();
            }
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

        // 공급서비스 찾기 팝업 호출
        function jsServiceSearchPopup(el){
            $(el).colorbox({
                title : "계약서비스 선택",
                href : "/korean/pt/popup/PD_suplerServicePop.do?goodKndCd="+$('#goodKndCd').val(),
                width : "640",
                height : "320",
                overlayClose : false,
                escKey : false,
                iframe : true
            });
        }
        
        // 응찰버튼 클릭 이벤트
        var bidExtend = function(){
            if(!$("input:checkbox[id='confirmChk']").is(":checked")){
                alert("확인사항을 체크하세요.");
                $("input:checkbox[id='confirmChk']").focus();
                return false;
            }
            if($('#goodsCode').val()==''){
                alert("공급서비스를 등록하세요.");
                $("#goodsSelectBtn").focus();
                return false;                
            }
            if($('#splyAmt').val()==''){
                alert("입찰금액을 입력하세요.");
                $("#splyAmt").focus();
                return false;                
            }
            
            if(confirm("응찰 하시겠습니까?")){
                // 첨부파일
                $("input[type=file]").each(function(){
                    if(this.value == ''){
                        $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                        $("#"+this.id).attr("disabled","disabled");
                    }
                });

                // 실제 저장 처리
                $("#dataForm").attr("action", "ND_bidExtendAction.do");
                $("#dataForm").submit();
            }
        }
    </script>

</head>
<body>
	<div class="conWrap">
	    <form name="listForm" id="listForm">
	        <input type="hidden" name="searchDiv01"     id="searchDiv01"     value="${searchDiv01}"/>         <!--  목록 페이지 조회조건1 -->	        
	        <input type="hidden" name="searchDiv02"     id="searchDiv02"     value="${searchDiv02}"/>         <!--  목록 페이지 조회조건2 -->
            <input type="hidden" name="searchKeyWord"   id="searchKeyWord"   value="${searchKeyWord}"/>       <!--  목록 페이지 검색어1 -->	        
	        <input type="hidden" name="q_currPage"      id="q_currPage"      value="${currPage}"/>            <!--  현재 페이지 -->
	    </form>

	    <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
	        <input type="hidden" name="notifyNum" id="notifyNum" value="${baseList.notifyNum}"/>  <!--  공고번호 -->
	        <input type="hidden" name="notifySeq" id="notifySeq" value="${baseList.notifySeq}"/>  <!--  공고차수 -->
	        <input type="hidden" name="vatGbn"    id="vatGbn"    value="Y"/>                      <!--  VAT여부 -->
	        <input type="hidden" name="goodKndCd" id="goodKndCd" value="${baseList.goodKndCd}"/>  <!--  서비스 구분코드 -->

			<div class="bidNoti bid">
				<h4>입찰참가자격 변경등록 불이행에 따른 입찰무효 안내사항</h4>
				<div>
					국가계약법 시행규칙 제44조 및 지방계약법 시행규칙 제42조, 입찰유의서에는 무효로 하는 입찰을 규정하고 있습니다.<br />
					특히, “입찰참가자격 등록사항 중 상호, 대표자의 성명,을 변경등록하지 아니하고 입찰서를 제출하여 입찰무효되는 사례가 발생하고 있습니다.<br />
					입찰참여자는 입찰참가자격 등록사항(씨앗 홈페이지의 제공자씨앗>제공자정보관리) 확인 및 입찰공고 내용을 숙지하시어 불이익이 없도록하시기 바랍니다.
				</div>
	
				<h4>입찰자 등록관련 입찰무효 방지 안내사항</h4>
				<ul>
					<li>
						귀하는 현재 귀사의 대표자 또는 임직원이 맞습나까?<br />
						- 임원은 법인등기부등본에 등재되어 있어야하며, 직원은 4대 보험 중 어느 하나에 가입되어 있어야 합니다.
					</li>
					<li>
						만일 귀하가 이미 퇴사 등으로 해당 업체의 입찰대리인 자격을 상실한 경우<br />
						- 본 입찰에는 법인등기부등본에 등재되어 있는 대표자나 다른 임직원, 입찰대리인이 투찰하여야 합니다.
					</li>
				</ul>
				
				<p class="agree">
					위 사항을 모두 확인하셨습니까!
					<label><input type="checkbox" name="confirmChk" id="confirmChk" <c:if test="${dataList.vatGbn != null}">checked="checked"</c:if>/> 예</label>
				</p>
	
				
				<table class="tbl_st4 e4">
					<tr>
						<th>입찰공고명</th>
						<td colspan="3">${baseList.bidNotifyNm}</td>
					</tr>
					<tr>
						<th>공고번호</th>
						<td colspan="3">${baseList.notifyNum}-${baseList.notifySeq}</td>
					</tr>
					<tr>
						<th>공고기관</th>
						<td>${baseList.endsUserNm}</td>
						<th>수요기관</th>
						<td>${baseList.realDmndOrgn}</td>						
					</tr>
					<tr>
						<th class="requ">공급서비스</th>
						<td colspan="3">
						    <i id="goodsArea">${dataList.goodsName}</i>
						    <input type="hidden" name="goodsCode" id="goodsCode" value="${dataList.goodsCode}"/>
						    <!-- 지명경쟁일 경우 공급서비스를 선택할 필요 없음. -->
						    <c:if test="${baseList.cntrMothod != '1004'}">
						        <a href="#" id="goodsSelectBtn" onclick="jsServiceSearchPopup(this); return false;" class="btns st3">검색</a>
						        <p class="desc import">※ 클라우드스토어 씨앗에 등록된 제공자님의 서비스로만 응찰 가능합니다.</p>
						    </c:if>
						</td>
					</tr>
					<tr>
						<th class="requ">입찰금액</th>
						<td colspan="3" class="unit">
							<i>원 / VAT 포함</i>
							<div><input type="text" name="splyAmt" id="splyAmt" style="ime-mode:disabled" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${dataList.splyAmt}"/></div>					
							<!-- <p class="desc">※ 입찰금액을 입력하시지 않으시면 해당 서비스의 가격표가 첨부 됩니다.</p> -->
						</td>
					</tr>
				</table>
	
				<h3>시스템 요구조건</h3>
				<table class="tbl_st4">
					<tr>
						<th>제품군</th>
						<td>${baseList.goodKndNm}</td>
					</tr>
				</table>
	
	            <!-- tbl_write -->
	            <c:choose>
	                <c:when test="${baseList.goodKndCd eq 1001}">
	                    <%@include file="../bidSttus/goods/BD_Bid_Paas.form.jsp" %>
	                </c:when>
	                <c:when test="${baseList.goodKndCd eq 1002}">
	                    <%@include file="../bidSttus/goods/BD_Bid_Saas.form.jsp" %>
	                </c:when>
	                <c:when test="${baseList.goodKndCd eq 1003}">
	                    <%@include file="../bidSttus/goods/BD_Bid_Iaas.form.jsp" %>
	                </c:when>
	            </c:choose>
	            <!-- //tbl_write -->
	
				<h3>납품 요구조건</h3>
				<table class="tbl_st4">
					<tr>
						<th>희망 구매가</th>
						<td><fmt:formatNumber value="${baseList.hopePuchAmt}" groupingUsed="true"/> 원 /
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
					</tr>
					<tr>
						<th>납품 장소</th>
						<td>${baseList.delyPlac}</td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td>
						    <c:if test="${baseList.delyFileId != null}">
						    <a href="/component/file/ND_fileDownload.do?id=${baseList.delyFileId}" title="${baseList.delyFileOrgNm}" class="aDeisable">${baseList.delyFileOrgNm} <span class="tx_gray">(${baseList.delyFileSize}, ${baseList.delyFileTy})</span></a>
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>공고설명</th>
						<td colspan="3">${baseList.notifyCont}</td>
					</tr>
				</table>
	
				<div class="replyWrap">
					<table class="tbl_st4">
						<tr>
							<th>판매조건</th>
							<td><textarea name="splyNote" id="splyNote" >${dataList.splyNote}</textarea></td>
						</tr>
						<tr>
							<th>추가제안</th>
							<td><textarea name="addAnswer" id="addAnswer">${dataList.addAnswer}</textarea></td>
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
	
					<table class="tbl_st4">
						<tr>
							<th>상호명</th>
							<td>${dataList.cmpnyNm}</td>
						</tr>
						<tr>
							<th>사업자등록번호</th>
							<td>${dataList.bizrno}</td>
						</tr>
						<tr>
							<th>대표자성명</th>
							<td>${dataList.cmpnyRprsntvNm}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td class="tel">${dataList.reprsntTelno}</td>
						</tr>
					</table>
				</div>
				<div class="btnArea rig">
				    <a href="#" onclick="javascript:bidExtend(); return false;" class="btns st1 icn icnWrite">응찰</a>
				    <!-- a href="#" class="btns st1 icn icnSave">임시저장</a -->
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>	
			</div>
		</form>
	</div>
</body>
</html>