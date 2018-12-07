<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
<title>지정 권한 메뉴</title>
<script type="text/javascript">
<!--
    var jsMakeAuthTypeStr = function (assignTypeCd) {
        if (assignTypeCd.indexOf('A') > -1) {
            return '모든 권한';
        }

        var returnVal = '';
        if (assignTypeCd.indexOf('R') > -1) {
            returnVal += '조회 ';
        }
        if (assignTypeCd.indexOf('C') > -1) {
            returnVal += '등록 ';
        }
        if (assignTypeCd.indexOf('D') > -1) {
            returnVal += '삭제 ';
        }

        return returnVal + '권한';
    };
    $().ready(function () {
        $('table.boardList > tbody > tr > td.lr_none').each(function () {
            $(this).text(jsMakeAuthTypeStr($(this).text()));
        });
    });
//-->
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
        <div class="mar_b10 clear pop_tab_s">
        	<h2 class="float_l">${param.authNm}</h2>
            <div class="float_r mar_t5">지정권한 : <span class="tx_red tx_b">${dataVo.authMenuAssignCount }</span>건</div>
        </div>
        <!-- 리스트 -->
        <table class="boardList" summary="리스트">
            <caption class="hidden">지정권한목록 </caption>
            <colgroup>
                <col width="50%"/>
                <col width="50%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>메뉴명</th>
                    <th class="lr_none">사용권한</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${dataList}" var="_bean" varStatus="status">
                <tr>
                    <td>${_bean.menuCd }</td>
                    <td class="lr_none">${_bean.assignTypeCd }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <!-- //리스트 -->
    <!-- //컨텐츠영역 -->
</body>
</html>