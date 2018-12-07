<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
<title>지정권한 목록</title>
<script type="text/javascript">
<!--
//     var jsMakeAuthTypeStr = function (assignTypeCd) {
// 	    if (assignTypeCd.indexOf('A') > -1) {
// 	    	return '모든 권한';
// 	    }

// 	    var returnVal = '';
// 	    if (assignTypeCd.indexOf('G') > -1) {
// 	    	returnVal += '그룹 ';
// 	    }
// 	    if (assignTypeCd.indexOf('R') > -1) {
// 	    	returnVal += '조회 ';
// 	    }
// 	    if (assignTypeCd.indexOf('C') > -1) {
// 	    	returnVal += '등록 ';
// 	    }
// 	    if (assignTypeCd.indexOf('D') > -1) {
// 	    	returnVal += '삭제 ';
// 	    }

//         return returnVal + '권한';
//     };
//     $().ready(function () {
//     	$('table.boardList > tbody > tr > td.lr_none').each(function () {
//     		$(this).text(jsMakeAuthTypeStr($(this).text()));
//     	});
//     });
//-->
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
        <div class="mar_b10 clear pop_tab_s">
            <h2 class="float_l">정보화담당관</h2>
            <div class="float_r mar_t5" style="width:150px;text-align:right;">지정권한 :
                <span class="tx_red tx_b">
                    <c:if test="${empty dataVo.assignCount}">0</c:if>
                    <c:if test="${not empty dataVo.assignCount}">${dataVo.assignCount}</c:if>
                </span>건
            </div>
        </div>
        <!-- 리스트 -->
        <table class="boardList">
            <colgroup>
                <col width="50%" />
                <col width="50%" />
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;" class="lr_none">관리자 권한</th>
                </tr>
                <c:forEach items="${dataList}" var="_bean">
                <tr>
                    <td>
                        <c:if test="${_bean.authTypeCd eq 'G'}">그룹권한</c:if><c:if test="${_bean.authTypeCd eq 'P'}">개별권한</c:if>
                        <input type="hidden" name="authTypeCd" value="${_bean.authTypeCd}" />
                    </td>
                    <td class="lr_none">
                        ${_bean.authNm}
                    </td>
                </tr>
            	</c:forEach>
            	<c:if test="${empty dataList}">
            		<tr>
            			<td colspan="2" class="lr_none">지정된 권한이 없습니다.</td>
            		</tr>
            	</c:if>
            </tbody>
        </table>
        <!-- //리스트 -->
    <!-- //컨텐츠영역 -->
</body>
</html>