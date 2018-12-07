<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.utils.Converter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>클라우드스토어 씨앗</title>
    
    <!--공통css--><!-- 
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" /> -->
    <link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_pop.css" />
     <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
     var jsClose = function(){
        parent.$.fn.colorbox.close();
     };
	</script>
</head>

 <body class="winPopup">
	<h2>서비스 비교 <a href="#"  onclick="jsClose();">닫기</a></h2>
	<div>
       <table class="tbl_st3">
	        <colgroup>
	           <col width="10%">
	           <c:forEach varStatus="status" begin="0" end="${bgGoodsCnt}">
	           <col width="${90/bgGoodsCnt}%">
	           </c:forEach>
	        </colgroup>
	        <thead>
            <tr>
                 <th>서비스명</th>
                 <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                 <th>${_bgGoodsList.GOODS_NM}</th>
                 </c:forEach>
            </tr>
            </thead>
			<tr>
            	<td colspan="${bgGoodsCnt+1}" class="bg_st3"><label><input type="checkbox"/>기업정보 비교항목</label></td>
            </tr>
            <tr>
            	<th>제공자</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.LANG_STORE_NM }</td>
                </c:forEach>
            </tr> 
            <tr>
            	<th>기업구분</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.SMLPZ_CHK }</td>
                </c:forEach>
            </tr> 
            <tr>
            	<th>제조사</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.GOODS_MAKR }</td>
                </c:forEach>
            </tr> 
            <tr>
            	<th>제조국</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.ORG_PLCE }</td>
                </c:forEach>
            </tr>
            <tr>
            	<th>출시일</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.COMOU_DE }</td>
                </c:forEach>   
            </tr>
			<tr>
				<td colspan="${bgGoodsCnt+1}" class="bg_st3"><label><input type="checkbox"/>서비스단가 비교항목</label></td>               
            </tr>
            <tr>
            	<th>계약단위</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_CNTRCT_UNIT}" var="_goodsMetaCntrctUnit" varStatus="statusIdx">
                		${_goodsMetaCntrctUnit}
                	</c:forEach>
                </td>
                </c:forEach>                        
            </tr>
            <tr>
            	<th>단가</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.GOODS_PC }</td>
                </c:forEach>  
            </tr>
			<tr>
				<td colspan="${bgGoodsCnt+1}" class="bg_st3"><label><input type="checkbox"/>시스템사양 비교항목</label></td>
            </tr>
            <tr>
            	<th>서비스분류</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_CTGRY}" var="_goodsCtgry" varStatus="statusIdx">
                		${_goodsCtgry}
                	</c:forEach>
                </td>
                </c:forEach>
            </tr>
            <tr>
            	<th>서비스관리기준</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_SVC}" var="_goodsMetaSvc" varStatus="statusIdx">
                		${_goodsMetaSvc }
                	</c:forEach>
               	</td>
                </c:forEach> 
            </tr>
            <tr>
            	<th>호환성</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_STD}" var="_goodsMetaStd" varStatus="statusIdx">
                		${_goodsMetaStd}
                	</c:forEach>
                </td>
                </c:forEach>                     
            </tr>
            <tr>
            	<th>지원언어</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.LANG_NM}" var="_langNm" varStatus="statusIdx">
                		${_langNm}
                	</c:forEach>
                </td>
                </c:forEach> 
            </tr>
            <tr>
            	<th>구축방식</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_CNSTC_MTHD}" var="_goodsMetaCnstcMthd" varStatus="statusIdx">
                		${_goodsMetaCnstcMthd}
                	</c:forEach>
                </td>
                </c:forEach>
            </tr>
            <tr>
            	<th>서비스유형</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.SERVICE_OFFER_METHOD_NM }</td>
                </c:forEach> 
            </tr>
            <tr>
            	<th>아키텍처</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>${_bgGoodsList.ARCHTC_SE }</td>
                </c:forEach>
            </tr>
            <tr>
            	<th>A/S</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_AS}" var="_goodsMetaAs" varStatus="statusIdx">
                		${_goodsMetaAs}
                	</c:forEach>
                </td>
                </c:forEach>
            </tr>
            <tr>
            	<th>지원OS</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_META_OS}" var="_goodsMetaOs" varStatus="statusIdx">
                		${_goodsMetaOs}
                	</c:forEach>
                </td>
                </c:forEach>
            </tr>
            <tr>
            	<th>인증정보</th>
            	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
                <td>
                	<c:forEach items="${_bgGoodsList.GOODS_MARK_LIST}" var="_goodsMarkList" varStatus="statusIdx">
                		${_goodsMarkList}
                	</c:forEach>
                </td>
                </c:forEach>  
            </tr>
        </table>
	</div>
</body>
</html>