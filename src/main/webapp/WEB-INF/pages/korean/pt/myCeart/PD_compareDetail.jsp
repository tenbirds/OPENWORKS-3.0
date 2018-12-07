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
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript">
    // 닫기
    var jsClose = function(){
        parent.$.fn.colorbox.close();
    };
    
    var reportAction = function(ctg){
        var reportSection = '';
        if(ctg == '1001'){
            reportSection = '5001';
        } else if(ctg == '1002') {
            reportSection = '5002';
        } else {
            
        }
        var notifyNum = $("#p_notifyNum").val();
        var notifySeq = $("#p_notifySeq").val();
        var goodsCodes = $("#q_compGoodsCode").val();
        var goodsCode = "";
        var goodsCdArray = goodsCodes.split('|');
        for(i=0; i<goodsCdArray.length; i++){
            if(i > 0){
                goodsCode += ",";
            }
            goodsCode += goodsCdArray[i];
        }
        var commUserId = '<c:out value="${sessionScope['__usk'].userId}" />';
        
        var open = "http://korean.ceart.kr/report/reporting.jsp?reportSection="+reportSection+"&notifyNum="+notifyNum+"&notifySeq="+notifySeq+"&goodsCode="+goodsCode+"&userId="+commUserId;
        window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
    };
    </script>

</head>
<body class="winPopup view_spec">
    <form name="dataForm" id="dataForm" method="post" action="BD_buyingRequestList.do">
        <input type="hidden" name="searchDiv01"   id="searchDiv01"   value="${searchDiv01}"/>     <!--  목록 페이지 조회조건1 -->
        <input type="hidden" name="searchDiv02"   id="searchDiv02"   value="${searchDiv02}"/>     <!--  목록 페이지 조회조건2 -->
        <input type="hidden" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>   <!--  목록 페이지 검색어 -->
        <input type="hidden" name="q_currPage"    id="q_currPage"    value="${currPage}"/>        <!--  현재 페이지 -->
        <input type="hidden" name="p_notifyNum"     id="p_notifyNum"     value="${p_notifyNum}"/>
        <input type="hidden" name="p_notifySeq"     id="p_notifySeq"     value="${p_notifySeq}"/>
        <input type="hidden" name="q_compGoodsCode" id="q_compGoodsCode" value="${q_compGoodsCode}"/>
    </form>

 	<a href="javascript:;" class="print" onclick="reportAction('${baseList.goodKndCd}');"><img src="/cloud_ver2/new_cloud/images/btn_printNsave.png" alt="프린트" /></a>
 
 	    <div class="tab_link">
 		    <a href="#" class="on">답변서 비교</a>
 		    <!-- a href="#">서비스 비교</a -->
 		    <!-- a href="#">규격서 비교</a -->
 	    </div>
 		<div style="width:1460px">	
		<c:forEach items="${dataList}" var="dataList" varStatus="status">
		<c:set var="langStoreId" value="${dataList.userId}"/>
			<div>
				<div class="myceart detail">
					<p class="viewTit">${dataList.goodsName} [${dataList.langStoreNm}]</p>
					
					<h3>제공자 정보</h3>
					<table class="tbl_st4 e4">
						<tr>
							<th>담당자</th>
							<td>${dataList.storeChargerNm}</td>
							<th>휴대전화</th>
							<td>${dataList.mbtlnum}</td>
						</tr>
						<tr>
							<th>직책</th>
							<td></td>
							<th>이메일</th>
							<td><a href="#">${dataList.reprsntEmail}</a></td>
						</tr>
						<tr>
							<th>회사명</th>
							<td>${dataList.langStoreNm}</td>
							<th>대표전화</th>
							<td>${dataList.reprsntTelno}</td>
						</tr>
					</table>

	                <!-- tbl_write -->
	                <c:choose>
	                    <c:when test="${baseList.goodKndCd eq '1001'}">
	                        <%@include file="goods/BD_Paas.compare.jsp" %>
	                    </c:when>
	                    <c:when test="${baseList.goodKndCd eq '1002'}">
	                        <%@include file="goods/BD_Saas.compare.jsp" %>
	                    </c:when>
	                    <c:when test="${baseList.goodKndCd eq '1003'}">
	                        <%@include file="goods/BD_Iaas.compare.jsp" %>
	                    </c:when>
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
							<th>추가 문의</th>
							<td colspan="3">${baseList.notifyCont}</td>
						</tr>
					</table>
					<div class="replyWrap">
						<table class="tbl_st4">
							<tr>
								<th>제공금액</th>
								<td>
						        <c:choose>
	                                <c:when test="${dataList.askApplyCd == '1003'}">
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
								<th>추가답변</th>
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
				</div>
			</div>
		</c:forEach>


	</div>
	<script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>
</html>