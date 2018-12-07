<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="../include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="../include/INC_chartPie.jsp" charEncoding="utf-8"/>

<!-- 리스트 -->
<table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
    <caption class='hidden'> 목록 </caption>
    <colgroup>
        <col width='40%'/>
        <col width='20%'/>
        <col width='20%'/>
        <col width='20%'/>
    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sortHead1' onclick='sorting("1");'>검색엔진</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>검색어</span></th>
            <th><span id='sortHead3' onclick='sorting("3");'>방문수</span></th>
            <th class='lr_none'><span id='sortHead4' onclick='sorting("4");'>비율</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/>'><c:out value='${data.title }'/></td>
                <td class='tx_r' title='<c:out value='${data.textValue }'/>'><c:out value='${data.textValue}'/></td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>
                <td class='tx_r lr_none' title='<c:out value='${data.rateValue}'/>'><c:out value='${data.rateValue}'/> %</td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="3">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title=''>-</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
            <td class='tx_r lr_none' title='100'>100 %</td>
        </tr>
    </tfoot>
</table>
<!-- //리스트 -->