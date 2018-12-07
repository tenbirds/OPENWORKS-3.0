<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>메타폼 등록</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript">
//<![CDATA[
	var jsUseForm = function(varFormSeq){
	    parent.$.fn.colorbox({
            title : "데이터등록",
            href : "PD_insertDataPop.do?q_metaMasterSeqN="+varFormSeq,
            width : "780",
            height : "540",
            iframe : true
        });
    }
//]]>              
</script>               
</head>
<body>
<!-- 컨텐츠영역 -->
    <div id="popup" style="width:580px;">
        <form name="dataForm"id="dataForm">
        <!-- 기본정보 -->
        <h2 class="mar_t20">
	        	메타정보보기
        </h2>
        <fieldset>
        <legend>메타정보보기</legend>
        <table id="metaFromTab" class="boardWrite" cellspacing="0" border="1" summary="메타폼 등록 입니다.">
            <caption class="hidden"> 메타정보보기</caption>
            <colgroup>
                <col width="30%" />
                <col width="25%" />
                <col width="20%" />
                <col width="25%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>메타정보명</th>
                    <td colspan="3">
                    	${ metaMasterDetail.metaMasterNmV }
                    	<input type="hidden"	name="metaMasterNmV" 	id="metaMasterNmV" 	value="${ metaMasterDetail.metaMasterNmV }" size="60"/>
                    	<input type="hidden" 	name="metaMasterSeqN" 	id="metaMasterSeqN" value="${ metaMasterDetail.metaMasterSeqN }" />
                    	<input type="hidden" 	name="useYnC" 			id="useYnC"		 	value="${ metaMasterDetail.useYnC }" />
                    	<input type="hidden" 	name="propertySeqN"		id="propertySeqN" 	value="${ metaPropertyDetail.propertySeqN }" />
                    	<input type="hidden" 	name="property"			id="property" 		value="${ metaPropertyDetail.property }" />
                    	<input type="hidden" 	name="propertyTypeC"	id="propertyTypeC" 	value="${ metaPropertyDetail.propertyTypeC }" />                    	
                    </td>
                </tr>
                <tr>
                    <th style="text-align:center;">속성명</th>
                    <th style="text-align:center;">속성코드</th>
                    <th style="text-align:center;">필수여부</th>
                    <th style="text-align:center;">데이터타입</th>
                </tr>
                <c:forEach items="${metaValList}" var="metaValVO">
                <tr>
	               	<td>${metaValVO.metaPropNameV}</td>
	               	<td>${metaValVO.metaPropCdV}</td>
	               	<td style="text-align:center;">
	               		<c:if test="${metaValVO.requireYnC eq 'Y'}">예</c:if>
		               	<c:if test="${metaValVO.requireYnC eq 'N'}">아니오</c:if>
	               	</td>
	               	<td style="text-align:center;">
	               		 ${metaValVO.dataKindNmV}
	               	</td>
            	</tr>     
            	</c:forEach>             
            </tbody>            
        </table>
        </fieldset>
         	<p class="tx_c mar_t20">
	         	<a href="#"><button class="blue" type="button" id="butUse" onclick="javaScript:jsUseForm('${ metaMasterDetail.metaMasterSeqN }')">사용하기</button></a> 
	         	<a href="#"><button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">닫기</button></a>
			</p>
        </form>
    </div>
            <!-- //컨텐츠영역 -->
</body>
</html>