<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>서비스관리 | 판매하기 | 씨앗 마켓</title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript">
function jsFileDelete(inputId, inputIdFake){
    document.getElementById(inputIdFake).value="";
    $("input[name="+inputId+"]").val("");
}



function jsFileChk(inputId, inputIdFake){
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
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
	var jsPage = function(type){
        $("form[name=dataForm]").attr("method","post");
    	$("form[name=dataForm]").attr("action","/korean/pt/apply/BD_PaaSInsert.do");
    	$("form[name=dataForm]").submit();
};
</script>
</head>
<body>
<c:set var="InfoRequest" value="${pagerRequest}"/>
<c:set var="InfoSupplier" value="${pagerSupplier}"/>
<c:set var="PaaSInfoOne" value="${dataListOne}"/>
<c:set var="PaaSInfoTwo" value="${dataListTwo}"/>
		<div class="conWrap">
			<div class="supAdm answAdm detail">
				<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="BD_PaaSInsert.do">
					<input type="hidden" name="notifyNum" value="${InfoRequest.notifyNum}">
					<input type="hidden" name="notifySeq" value="${InfoRequest.notifySeq}">
					<input type="hidden" name="applyGbn" value="Y">
				<p class="viewTit"><c:out value="${InfoRequest.cmpnyNm}"/></p>
				<!-- 요청자(이용자) 정보 -->
						<h3>요청자 정보</h3>
						<table class="tbl_st4 e4">
							<tr>
								<th class="requ"> 작성자</th>
								<td><c:out value="${InfoRequest.userNm}"/></td>
								<th class="requ"> 휴대전화</th>
								<td><c:out value="${InfoRequest.goodsChargerCttpc}"/></td>
							</tr>
							<tr>
								<th class="requ"> 기업/기관명</th>
								<td><c:out value="${InfoRequest.readDmndOrgn}"/></td>
								<th class="requ"> 이메일</th>
								<td><c:out value="${InfoRequest.emailId}"/></td>
							</tr>
							<tr>
								<th>직책</th>
								<td><c:out value="${InfoRequest.userPosition}"/></td>
								<th>대표전화</th>
								<td><c:out value="${InfoRequest.telnoNum}"/></td>
							</tr>
						</table>
						<h3>시스템 요구</h3>
					<table class="tbl_st4">
						<!-- paaS 테이블 시작 -->
						<c:if test="${ null eq PaaSInfoTwo.langSys}">
							<input type="hidden" name="applytype" id="applytype" value="PaaSInsert">
						</c:if>
						<c:if test="${ null ne PaaSInfoTwo.langSys}">
							<input type="hidden" name="applytype" id="applytype" value="PaaSUpdate">
						</c:if>
						<tr>
							<th>Language</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.langSys}</dd>
									<dd><input name ="langSys" type="text" value="${PaaSInfoTwo.langSys}"/></dd>
								</dl>
							</td>
							</tr>
							<tr>
							<th>Frameworks</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.frameworkSys}</dd>
									<dd><input name="frameworkSys" type="text" value="${PaaSInfoTwo.frameworkSys}"/></dd>
								</dl>
							</td>
							</tr>
							<tr>
							<th>Cache</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.cacheSys}</dd>
									<dd><input name="cacheSys"type="text" value="${PaaSInfoTwo.cacheSys}"/></dd>
								</dl>
							</td>
							</tr>
							<tr>
							<th>DBMS</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.dbmsSys}</dd>
									<dd><input name="dbmsSys"type="text" value="${PaaSInfoTwo.dbmsSys}"/></dd>
								</dl>
							</td>
							</tr>
							<tr>
							<th>Fast Deploy</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.fastDeploySys}</dd>
									<dd><input name="fastDeploySys" type="text" value="${PaaSInfoTwo.fastDeploySys}"/></dd>
								</dl>
							</td>
							</tr>
							<tr>
							<th>Etc</th>
							<td>
								<dl>
									<dd>${PaaSInfoOne.etcSys}</dd>
									<dd><input name="etcSys"type="text" value="${PaaSInfoTwo.etcSys}"/></dd>
								</dl>
							</td>
							</tr>
						<!-- paaS 테이블 시작 끝-->
					</table>
				
				<h3>납품 요구조건</h3>
				<table class="tbl_st4">
					<tr>
						<th>희망 구매가</th>
							<td colspan="3"><fmt:formatNumber value="${InfoRequest.hopePuchAmt}" groupingUsed="true"/>원 &nbsp;/&nbsp; 
								<c:choose>
									<c:when test="${InfoRequest.vatGbn eq 'Y'}">
										<span>VAT포함</span>
									</c:when>
									<c:otherwise>
										<span>VAT미포함</span>
									</c:otherwise>
								</c:choose>	
						</td>
					</tr>
					<tr>
						<th class="requ">납품 기한</th>
						<td>
						<c:if test="${ null eq InfoRequest.delyDt}">
							합의후 결정
						</c:if>
						<c:if test="${ null ne InfoRequest.delyDt}">
							<c:out value="${InfoRequest.delyDt}"/>시
						</c:if>
						</td>
						<th class="requ">응답 만료일	</th>
						<td><c:out value="${InfoRequest.rplyDt}"/></td>
					</tr>
					<tr>
						<th>납품 장소</th>
						<td colspan="3"><c:out value="${InfoRequest.delyPlac}"/></td>
					</tr>
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						<c:if test="${ 0 eq InfoRequest.delyFile}">
							 미 첨부
						</c:if>
						<c:if test="${ 0 ne InfoRequest.delyFile}">
							<c:out value="${InfoRequest.delyFile}"/>
						</c:if>
						
						</td>
					</tr>
					<tr>
						<th>추가문의</th>
						<td colspan="3"><c:out value="${InfoRequest.notifyCont}"/></td>
					</tr>
				</table>
				<div class="replyWrap">
					<table class="tbl_st4">
						<tr>
							<th>제공금액</th>
							<td class="vat">
								<div class="unit">
									<i>원</i>				
									<div>
									<c:choose>
										     <c:when test="${ 0 eq InfoSupplier.splyAmt}">
												<input id="splyAmts" name ="splyAmts"type="text" onkeydown="return jsOnlyNumber(event);"/>
											</c:when>
											<c:when test="${ 0 ne InfoSupplier.splyAmt}">
												<input id="splyAmts" name ="splyAmts"type="text" onkeydown="return jsOnlyNumber(event);" value="${InfoSupplier.splyAmt}"/>
											</c:when>
									</c:choose>
									</div>
								</div>
								<c:choose>
									<c:when test="${InfoRequest.vatGbn eq 'Y'}">
										<input id="vatGbns" name ="vatGbns"type="hidden" value="Y"/>
										<span>VAT포함</span>
									</c:when>
									<c:otherwise>
										<input id="vatGbns" name ="vatGbns"type="hidden" value="N"/>
										<span>VAT미포함</span>
									</c:otherwise>
								</c:choose>	

							</td>
							
						</tr>
						<tr>
							<th>추가답변</th>
							<td><textarea id="addAnswers" name="addAnswers">${InfoSupplier.addAnswer}</textarea></td>
						</tr>
						<tr>
							<th>비고</th>
							<td><textarea id="splyNotes"name="splyNotes">${InfoSupplier.splyNote}</textarea></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
								<div class="uploadFile">
									<input type="text" readonly="readonly" name="optlCntrFileInput" id="optlCntrFileInput" title="파일명"/>
									<div>
										<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="javascript:jsFileDelete('splyFile', 'optlCntrFileInput');" alt="삭제" />							
						            	<span class="btns st3">
						            		파일선택
						            		<input type="file" name="splyFile" id="splyFile" class="splyFile" title="파일찾기" onchange="javascript:jsFileChk('splyFile', 'optlCntrFileInput');"/>
						            	</span>
					            	</div>
					            </div>
							</td>
						</tr>
					</table>
					<h3>제공자 정보</h3>
					<table class="tbl_st4 e4">
						<tr>
							<th class="requ">담당자</th>
							<td><c:out value="${InfoSupplier.userNm}"/></td>
							<th class="requ">휴대전화</th>
							<td><c:out value="${InfoSupplier.mbtlNumber}"/></td>
						</tr>
						<tr>
							<th>직책</th>
							<td><input  name="position"type="text" /></td>
							<th class="requ">이메일</th>
							<td><c:out value="${InfoSupplier.emailId}"/></td>
						</tr>
						<tr> 
							<th class="requ">회사명</th>
							<td><c:out value="${InfoSupplier.cmpnyNm}"/></td>
							<th class="requ">대표전화</th>
							<td><c:out value="${InfoSupplier.cmpnyReprsntTelno}"/></td>
						</tr>
					</table>
				</div>
					<div class="btnArea rig">
					<a href="javascript:" onclick="" class="btns st2 icn icnBck">반 려</a>
					<a href="javascript:" onclick="jsPage();" class="btns st4 icn icnSend">제 출</a>
					<a href="/korean/pt/apply/BD_ApplyList.do" class="btns st4 icn icnList">목록보기</a>
					</div>					
				</form>
			</div>	
		</div>
</body>
</html>
