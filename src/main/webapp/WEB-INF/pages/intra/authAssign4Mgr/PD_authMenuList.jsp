<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
<!--
    var jsMakeAuthTypeStr = function (authTypeCd) {
        if (authTypeCd.indexOf('A') > -1) {
            return '모든 권한';
        }

        var returnVal = '';
        if (authTypeCd.indexOf('R') > -1) {
            returnVal += '조회 ';
        }
        if (authTypeCd.indexOf('C') > -1) {
            returnVal += '등록 ';
        }
        if (authTypeCd.indexOf('D') > -1) {
            returnVal += '삭제 ';
        }

        return returnVal + '권한';
    };

    $().ready(function () {
        $('table.boardList > tbody > tr > td.lr_none').each(function () {
            $(this).text(jsMakeAuthTypeStr($(this).text()));
        });

        var listLength = $('table.boardList > tbody > tr').length;
        $('div > span').text(listLength);
        if (listLength == 0) {
            $('table.boardList > tbody').html('<tr><td colspan="2" class="lr_none">권한지정된 메뉴가 없습니다.</td></tr>');
        }
    });
//-->
</script>


<div class="tx_r mar_b10">지정권한 : <span class="tx_red tx_b">0</span>건</div>
<!-- 리스트 -->
<table class="boardList" summary="리스트">
    <caption class="hidden">지정권한목록 </caption>
    <colgroup>
        <col width="50%" />
        <col width="50%" />
    </colgroup>
    <thead>
        <tr>
            <th>메뉴명</th>
            <th class="lr_none">사용권한</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach items="${dataList}" var="_bean">
        <tr>
            <td>${_bean.menuNm}</td>
            <td class="lr_none">${_bean.assignTypeCd}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<!-- //리스트 -->