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
    <title>마이씨앗-사전견적 관리</title>
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
        document.dataForm.action = "/korean/pt/myCeart/BD_myCeartBeforeRequestList.do";
    	document.dataForm.method = "POST";
    	document.dataForm.submit();     
    }
    </script>

</head>
<body>
 		
    <form name="dataForm" id="dataForm">
        <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     <!--  목록 페이지 조회조건1 -->
        <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     <!--  목록 페이지 조회조건2 -->
        <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   <!--  목록 페이지 검색어 -->
        <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        <!--  현재 페이지 -->
    </form>

		<!-- <div class="conWrap"> -->			
			<div class="myceart detail">
				<h3>상세정보(견적)요청</h3>
				<p class="viewTit">문의서비스 : ${dataList.goodsName} [${dataList.langStoreNm}]</p>
				
				<h3>제공자 정보</h3>
				<table class="tbl_st4 e4" summary="제공자 정보">
					<caption>제공자 정보</caption>
					<colgroup>
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>회사명</th>
							<td colspan="3">${dataList.langStoreNm}</td>
						</tr>
						<tr>
							<th>담당자</th>
							<td>${dataList.storeChargerNm}</td>
							<th>대표전화</th>
							<td>${dataList.reprsntTelno}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><a href="#">${dataList.reprsntEmail}</a></td>
							<th>대표번호</th>
							<td>${dataList.mbtlnum}</td>
						</tr>
					</tbody>
				</table>

                
                <!-- tbl_write -->
                <c:choose>
                    <c:when test="${baseList.goodKndCd eq 1001}"><%@include file="goods/BD_Paas.view.jsp" %></c:when>
                    <c:when test="${baseList.goodKndCd eq 1002}"><%@include file="goods/BD_Saas.view.jsp" %></c:when>
                    <c:when test="${baseList.goodKndCd eq 1003}"><%@include file="goods/BD_Iaas.view.jsp" %></c:when>
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
						<!-- <th class="requ">납품 기한</th>
						<td>
						    <c:choose>
						        <c:when test="${baseList.talkGbn eq 'Y'}">합의후 결정</c:when>
						        <c:when test="${baseList.talkGbn eq 'N'}">${baseList.delyDt} (${baseList.delyTime} 시)</c:when>
						    </c:choose>
						</td>-->
						<th class="requ">답변 만료일</th>
						<td>${baseList.rplyDt}</td>
					</tr>
					<!-- <tr>
						<th>납품 장소</th>
						<td colspan="3">${baseList.delyPlac}</td>
					</tr> -->
					<tr>
						<th>첨부파일</th>
						<td colspan="3">
						    <c:if test="${baseList.delyFileId != null}">
						        <a href="/component/file/ND_fileDownload.do?id=${baseList.delyFileId}" title="${baseList.delyFileOrgNm}" class="aDeisable">${baseList.delyFileOrgNm} <span class="tx_gray">(${baseList.delyFileSize}, ${baseList.delyFileTy})</span></a>
						    </c:if>
						</td>
					</tr>
					<tr>
						<th>추가 문의</th>
						<td colspan="3">${baseList.addCont}</td>
					</tr>
				</table>
				<div class="replyWrap">
					<table class="tbl_st4">
						<tr>
							<th>제공금액</th>
							<td>
					        <c:choose>
                                <c:when test="${dataList.askApplyCd == '1004'}">
                                    <fmt:formatNumber value="${dataList.splyAmt}" groupingUsed="true"/> 원 /
                                    	<c:choose>
                                            <c:when test="${dataList.vatGbn eq 'Y'}">VAT 포함</c:when>
                                            <c:when test="${dataList.vatGbn eq 'N'}">VAT 미포함</c:when>
                                        </c:choose>
                                </c:when>
                            </c:choose>
							</td>
						</tr>
						<tr>
							<th>기타제안</th>
							<td>${dataList.addAnswer}</td>
						</tr>
						<tr>
							<th>비고</th>
							<td>${dataList.splyNote}</td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td>
							    <c:if test="${dataList.splyFileId != null}">
							        <a href="/component/file/ND_fileDownload.do?id=${dataList.splyFileId}" title="${dataList.splyFileOrgNm}" class="aDeisable">${dataList.splyFileOrgNm} <span class="tx_gray">(${dataList.splyFileSize}, ${dataList.splyFileTy})</span></a>
							    </c:if>
							</td>
						</tr>
					</table>
				</div>
				
				<div class="btnArea rig">
					<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
				</div>	
			</div>
		<!-- </div> -->
	<!--// content -->
 </body>
</html>