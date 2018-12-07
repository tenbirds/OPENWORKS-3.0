<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>POPUP - 계약완료</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
 
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <script type="text/javascript">
	    // 닫기
	    var jsClose = function(){
	        parent.$.fn.colorbox.close();
	    };

	    /* 
	     * 첨부파일 반영
	     */
	    var jsFileChk = function(inputId, inputIdFake, fileId){
	        // 기등록 첨부파일의 ID 제거
	        $("input[name="+fileId+"]").val("0");
		    
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
	    };

	
	    /* 
	     * 첨부파일 삭제
	     */
	    var jsFileDelete = function(inputId, inputIdFake, fileId){
	        // 기등록 첨부파일의 ID 제거
	        $("input[name="+fileId+"]").val("0");
	
		    document.getElementById(inputIdFake).value="";
		    $("input[name="+inputId+"]").val("");
		    
		    $('#uploadedFile').hide();
	    };

	    // 저장버튼 클릭
	    var jsCntrctCmpl = function(){
	        if(checkEditor()){
	            
	            var confirmMsg = "";
	            if($("#cntrctSn").val() > 0){
	                confirmMsg = "계약내용을 변경 하시겠습니까?";
	            }else{
	                confirmMsg = "계약체결 완료처리를 하시겠습니까?";
	            }
	            if(confirm(confirmMsg)) {
                    // 첨부파일
                    $("input[type=file]").each(function(){
                        if(this.value == ''){
                            $("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
                            $("#"+this.id).attr("disabled","disabled");
                        }
                    });

                    $("#dataForm").attr("action", "ND_cntrctCmplAction.do");
                    $("#dataForm").submit();
	            }
	        }
	    };

	    // 저장 vaildation 체크
	    function checkEditor(){
	        // 계약일 체크
	        if($('#cntrDt').val() == ''){
	            alert("계약일을 입력하세요.");
	            $('#cntrDt').focus();
	            return false;
	        }
	        // 계약기간 체크
	        if($('#cntrctBeginDe').val() == ''){
	            alert("계약기간을 선택하세요.");
	            $('#cntrctBeginDe').focus();
	            return false;
	        }
	        if($('#cntrctEndDe').val() == ''){
	            alert("계약기간을 선택하세요.");
	            $('#cntrctEndDe').focus();
	            return false;
	        }
	        // 계약종료일은 계약시작일 보다 클 수 없음.
	        var cntrctBeginDe = $('#cntrctBeginDe').val().replace(/-/gi,"");;
	        var cntrctEndDe = $('#cntrctEndDe').val().replace(/-/gi,"");;
	        if(cntrctBeginDe > cntrctEndDe){
	            alert("계약종료일은 계약시작일 보다 클 수 없습니다.");
	            $('#cntrctBeginDe').focus();
	            return false;
	        }
	        
	        // 공급가 체크
	        if($('#cntrctamount').val() == ''){
	            alert("공급가를 입력하세요.");
	            $('#cntrctamount').focus();
	            return false;
	        }
	        // 수량 체크
	        if($('#cntrCount').val() == ''){
	            alert("수량을 입력하세요.");
	            $('#cntrCount').focus();
	            return false;
	        }
	        return true;
	    }
	    
	    function jsOnlyNumber(event){
	        var key = window.event ? event.keyCode : event.which;    

	        if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
	        || key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
	        || key  == 8  || key  == 46 || key == 9 )
	        ) {
	            return true;
	        }else {
	            return false;
	        }            
	    }
    </script>
</head>

<body class="winPopup ctrCpl">
	<h2>
	    <c:if test="${baseList.cntrctSn != null and baseList.cntrctSn ne '' && !TypeCheck}">계약변경</c:if>
        <c:if test="${baseList.cntrctSn == null or baseList.cntrctSn eq '' or baseList.cntrctSn eq '0' && !TypeCheck}">계약체결 완료처리</c:if>
	    <c:if test="${TypeCheck}">계약 정보 확인</c:if>
	    <a href="#" onclick="jsClose();">닫기</a></h2>	
	<div>
	    <form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
	        <input type="hidden" name="cntrctSn"      id="cntrctSn"      value="${baseList.cntrctSn}"/>      <!-- 계약순서(PK) -->
	        <input type="hidden" name="notifyNum"     id="notifyNum"     value="${baseList.notifyNum}"/>     <!-- 공고번호 -->
	        <input type="hidden" name="notifySeq"     id="notifySeq"     value="${baseList.notifySeq}"/>     <!-- 공고차수 -->
	        <input type="hidden" name="svcNm"         id="svcNm"         value="${baseList.svcNm}"/>         <!-- 견적의 사업명 -->
		    <input type="hidden" name="purchsInsttNm" id="purchsInsttNm" value="${baseList.purchsInsttNm}"/> <!-- 구매기관(이용자명) -->
		    <input type="hidden" name="sleInsttNm"    id="sleInsttNm"    value="${baseList.sleInsttNm}"/>    <!-- 판매기관(제공자명) -->
	        <input type="hidden" name="goodsCode"     id="goodsCode"     value="${baseList.goodsCode}"/>     <!-- 서비스코드 -->
	        <input type="hidden" name="commUserId"    id="commUserId"    value="${baseList.commUserId}"/>    <!-- 이용자ID -->
	        <input type="hidden" name="bidGbnCd"      id="bidGbnCd"      value="${baseList.bidGbnCd}"/>      <!-- 입찰종류여부 -->

			<table class="tbl_st4 e4">
				<tr>
					<th >사업명</th>
					<td colspan="3">${baseList.svcNm}</td>
				</tr>
				<tr>
					<th>서비스</th>
					<td colspan="3">${baseList.goodsNm}</td>
				</tr>
				<tr>
					<th>이용자</th>
					<td>${baseList.purchsInsttNm}</td>
					<th>기업/기관명</th>
					<td>${baseList.realDmndOrgn}</td>
				</tr>
				<c:if test="${TypeCheck}">
					<tr>
						<th class="requ">계약일</th>
						<td colspan="3" class="term"><input type="text" readonly="readonly" value="${baseList.cntrDt}"></td>
					</tr>
					<tr>
						<th class="requ">계약기간</th>
						<td colspan="3" class="term"><input type="text" readonly="readonly" value="${baseList.cntrctBeginDe}"> ~ <input type="text" readonly="readonly" value="${baseList.cntrctEndDe}">				
						</td>
					</tr>
					<tr>
						<th class="requ">공급가</th>
						<td colspan="3" class="vat">
							<div class="unit">
								<i>원</i>				
								<div><input type="text" readonly="readonly" value="${baseList.cntrctamount}"></div>
							</div>
							<label>(VAT 포함)</label>
						</td>
					</tr>
					<tr>
						<th class="requ">수량</th>
						<td colspan="3"><input type="text" readonly="readonly" value="${baseList.cntrCount}"></td>
					</tr>			
					<tr>
						<th>공급형태</th>
						<td colspan="3">
							<label>
								<c:if test="${baseList.splyForm eq '1' or baseList.splyForm == null}">
									<input type="radio" name="splyForm" value="1" checked="checked"> 월단위
								</c:if>
								<c:if test="${baseList.splyForm eq '2'}">
									<input type="radio" name="splyForm" value="2" checked="checked"> 년단위
								</c:if>
								<c:if test="${baseList.splyForm eq '0'}">
									<input type="radio" name="splyForm" value="0" checked="checked"> 기타
									<span class="ect">
										<input type="text" readonly="readonly" value="${baseList.splyFormEtc}">
									</span>
								</c:if>
							</label>
						</td>
					</tr>
				</c:if>
				<c:if test="${!TypeCheck}">
					<tr>
						<th class="requ">계약일</th>
						<td colspan="3" class="term">
	                        <input type="text" name="cntrDt" id="cntrDt" value="${baseList.cntrDt}"/>
						</td>
					</tr>
					<tr>
						<th class="requ">계약기간</th>
						<td colspan="3" class="term">
							<input type="text" name="cntrctBeginDe" id="cntrctBeginDe" value="${baseList.cntrctBeginDe}"/> ~ <input type="text" name="cntrctEndDe" id="cntrctEndDe" value="${baseList.cntrctEndDe}"/>				
						</td>
					</tr>
					<tr>
						<th class="requ">공급가</th>
						<td colspan="3" class="vat">
							<div class="unit">
								<i>원</i>				
								<div><input type="text" name="cntrctamount" id="cntrctamount" onkeydown="return jsOnlyNumber(event);"value="${baseList.cntrctamount}"/></div>
							</div>
							<label>(VAT 포함)</label>
						</td>
					</tr>
					<tr>
						<th class="requ">수량</th>
						<td colspan="3"><input type="text" name="cntrCount" id="cntrCount" onkeydown="return jsOnlyNumber(event);" value="${baseList.cntrCount}"/></td>
					</tr>			
					<tr>
						<th>공급형태</th>
						<td colspan="3">
							<label><input type="radio" name="splyForm" value="1" <c:if test="${baseList.splyForm eq '1' or baseList.splyForm == null}">checked="checked"</c:if> /> 월단위</label>
							<label><input type="radio" name="splyForm" value="2" <c:if test="${baseList.splyForm eq '2'}">checked="checked"</c:if> /> 년단위</label>
							<span class="ect">
								<label><input type="radio" name="splyForm" value="0" <c:if test="${baseList.splyForm eq '0'}">checked="checked"</c:if> /> 기타</label>
								<input type="text" name="splyFormEtc" id="splyFormEtc" <c:if test="${baseList.splyForm ne '0'}">readonly="readonly"</c:if> value="${baseList.splyFormEtc}"/>
							</span>
						</td>
					</tr>
				</c:if>
				<tr>
					<th>계약서 파일 </th>
					<td colspan="3">
						<c:if test="${TypeCheck}">
							<div class="uploadFile">
								<c:if test="${baseList.ctrtcSn != null and baseList.ctrtcSn ne '0'}">
						            <p id="uploadedFile" class="uploaded">
						            	<a href="/component/file/ND_fileDownload.do?id=${baseList.ctrtcSnId}" title="${baseList.ctrtcSnOrgNm}" class="aDeisable">${baseList.ctrtcSnOrgNm} <span class="tx_gray">(${baseList.ctrtcSnSize}, ${baseList.ctrtcSnTy})</span></a>
						            </p>
				            	</c:if>
						</c:if>
						<c:if test="${!TypeCheck}">
						<div class="uploadFile">
						    <input type="text" readonly="readonly" name="ctrtcSnInput" id="ctrtcSnInput" title="파일명"/>
							<div>
				            	<span class="btns st3">
				            		파일선택
				            		<input type="file" name="ctrtcSnVal" id="ctrtcSnVal" class="ctrtcSnVal" title="파일찾기" onchange="javascript:jsFileChk('ctrtcSnVal', 'ctrtcSnInput', 'ctrtcSn');"/>
	                                <c:choose>
	                                    <c:when test="${baseList.ctrtcSn == null or baseList.ctrtcSn eq '0'}">
	                                    <input type="hidden" name="ctrtcSn" id="ctrtcSn" value="0"/>
	                                    </c:when>
	                                    <c:when test="${baseList.ctrtcSn != null or baseList.ctrtcSn ne '0'}">
	                                    <input type="hidden" name="ctrtcSn" id="ctrtcSn" value="${baseList.ctrtcSn}"/>
	                                    </c:when>
	                                </c:choose>
				            	</span>
			            	</div>
				            	<c:if test="${baseList.ctrtcSn != null and baseList.ctrtcSn ne '0'}">
					            <p id="uploadedFile" class="uploaded">
					            	<span>
					            	    <a href="/component/file/ND_fileDownload.do?id=${baseList.ctrtcSnId}" title="${baseList.ctrtcSnOrgNm}" class="aDeisable">${baseList.ctrtcSnOrgNm} <span class="tx_gray">(${baseList.ctrtcSnSize}, ${baseList.ctrtcSnTy})</span></a>
					            	    <a href="#" onclick="jsFileDelete('ctrtcSnVal', 'ctrtcSnInput', 'ctrtcSn'); return false;" />삭제</a>
					            	</span>
					            </p>
				            	</c:if>
			            </div>	
			            </c:if>            
					</td>
				</tr>
			</table>
        </form>
        <br />
		<div class="btnArea">	
			<c:if test="${!TypeCheck}">
				<input type="submit" value="저장" class="btns st1" onclick="jsCntrctCmpl(); return false;"/>
			</c:if>
		</div>
	</div>
	

  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
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
	    $( "#cntrDt, #cntrctBeginDe, #cntrctEndDe" ).datepicker({
	        showOn: "both", 
	        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	        buttonImageOnly: false,
	        buttonText: "달력"
	    });

	    /*
	     * 공급형태 라디오 선택 이벤트
	     */
        $(":radio[name='splyForm']").click(function(){
            var chkVal = $(":radio[name='splyForm']:checked").val();

            $("#splyFormEtc").val('');
            if(chkVal == '0'){
                $("#splyFormEtc").attr("readonly",false);
            }else{
                $("#splyFormEtc").attr("readonly",true);
            }
        });

	    // 공급가 및 수량 컬럼 선택시 전체선택 되도록(초기값이 0이므로)
        $("#cntrctamount").focus(function() { $(this).select(); } ); 
        $("#cntrCount").focus(function() { $(this).select(); } ); 
	});

  </script>
  <!--// datepicker -->

  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>