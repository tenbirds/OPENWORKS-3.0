<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="../include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="../include/INC_chartBar.jsp" charEncoding="utf-8"/>

<!-- 리스트 -->
<table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
    <caption class='hidden'> 목록 </caption>
    <colgroup>
        <col width=''/>
        <col width='16%'/>
        <col width='16%'/>
        <col width='16%'/>
        <col width='16%'/>
        <col width='16%'/>

    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sortHead1' onclick='sorting("1");'>일시</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>페이지뷰</span></th>
            <th><span id='sortHead3' onclick='sorting("3");'>전체방문자수</span></th>
            <th><span id='sortHead4' onclick='sorting("4");'>순방문수</span></th>
            <th><span id='sortHead5' onclick='sorting("5");'>처음방문수</span></th>
            <th><span id='sortHead6' onclick='sorting("6");'>재방문수</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <c:choose>
                    <c:when test="${data.title eq '1'}"><c:set var="title2" value="일"/></c:when>
                    <c:when test="${data.title eq '2'}"><c:set var="title2" value="월"/></c:when>
                    <c:when test="${data.title eq '3'}"><c:set var="title2" value="화"/></c:when>
                    <c:when test="${data.title eq '4'}"><c:set var="title2" value="수"/></c:when>
                    <c:when test="${data.title eq '5'}"><c:set var="title2" value="목"/></c:when>
                    <c:when test="${data.title eq '6'}"><c:set var="title2" value="금"/></c:when>
                    <c:when test="${data.title eq '7'}"><c:set var="title2" value="토"/></c:when>
                </c:choose>
                <td title='<c:out value='${data.title}'/>'>
                    <c:out value='${title2 }'/>       
                </td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>
                <td class='tx_r' title='<c:out value='${data.value2 }'/>'><c:out value='${data.value2}'/></td>
                <td class='tx_r' title='<c:out value='${data.value3 }'/>'><c:out value='${data.value3}'/></td>
                <td class='tx_r' title='<c:out value='${data.value4 }'/>'><c:out value='${data.value4}'/></td>
                <td class='tx_r lr_none' title='<c:out value='${data.value5 }'/>'><c:out value='${data.value5}'/></td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="6">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value2 }'/>'><c:out value='${dataVo.value2 }'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value3 }'/>'><c:out value='${dataVo.value3 }'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value4 }'/>'><c:out value='${dataVo.value4 }'/></td>
            <td class='tx_r lr_none' title='<c:out value='${dataVo.value5 }'/>'><c:out value='${dataVo.value5 }'/></td>
        </tr>
    </tfoot>
</table>
<!-- //리스트 -->