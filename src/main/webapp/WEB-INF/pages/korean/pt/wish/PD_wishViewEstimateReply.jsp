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
    
    <title>POPUP - 견적서 보기</title>
      
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
      
    <script type="text/javascript">
        var jsClose = function() 
        {
            parent.$.colorbox.close();
        }
    </script>

 </head>

 <body class="winPopup">
    <h2>견적 내용 <a  href="#close" onclick="jsClose();">닫기</a></h2>
    <div>
        
        <p class="title_area"><strong>${dataList.goodsName}</strong>${dataList.langStoreNm}</p>
        
        <!-- p class="title_area2">요청자정보</p>
        
        <h3>시스템 요구사항</h3>
        
        <table class="tbl_st4">
            <caption></caption>
            <colgroup>
                <col width="15%">
                <col width="35%">
                <col width="15%">
                <col width="35%">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th>사용기간</th>
                    <td>${baseList.useFromDt} ~ ${baseList.useToDt}</td>
                    <th>희망 구매가</th>
                    <td>
                        <c:if test="${fn:length(baseList.hopePuchAmt) > 0}">
                            <fmt:formatNumber value="${baseList.hopePuchAmt}" pattern="#,###" />원
                        </c:if>
                    </td>
                </tr>
            </tbody>
        </table -->
        
        <!-- tbl_write -->
        <c:choose>
            <c:when test="${baseList.goodKndCd eq 1001}"><%@include file="goods/PD_Paas2.view.jsp" %></c:when>
            <c:when test="${baseList.goodKndCd eq 1002}"><%@include file="goods/PD_Saas2.view.jsp" %></c:when>
            <c:when test="${baseList.goodKndCd eq 1003}"><%@include file="goods/PD_Iaas2.view.jsp" %></c:when>
            <c:when test="${baseList.goodKndCd eq 1004}"><%@include file="goods/PD_Scs2.view.jsp" %></c:when>
        </c:choose>
        <!-- //tbl_write -->


        <table class="tbl_st9 mt10">
            <caption></caption>
            <colgroup>
                <col width="20%"/>
                <col width="20%"/>
                <col width="80%"/>
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="4">납품 요구조건</th>
                    <th>희망구매가</th>
                    <td>${baseList.puchBudgetAmt}</td>
                </tr>
                <tr>   
                    <th>답변완료일</th>
                    <td>${baseList.rplyDt}</td>
                </tr>
                <tr>   
                    <th>추가문의</th>
                    <td>${baseList.addAnswer}</td>
                </tr>
                <tr>   
                    <th>첨부파일</th>
                    <td>${baseList.delyFileOrgNm}</td>
                </tr>
            </tbody>
        </table>


        
    </div>
    
    
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
 </body>
</html>
