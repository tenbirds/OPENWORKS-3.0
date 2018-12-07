<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="../include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="../include/INC_chartPie.jsp" charEncoding="utf-8"/>

<!-- 리스트 -->
<div class="float_l w_100p mar_t30">
    <op:pagerParam title="종료페이지 목록" />
</div>
<c:import url="../include/INC_search5.jsp" charEncoding="utf-8"/>
<table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
    <caption class='hidden'> 목록 </caption>
    <colgroup>
        <col width='60%'/>
        <col width='20%'/>
        <col width='20%'/>
    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sort' id='1'>URL</span></th>
            <th><span id='sort' id='2'>횟수</span></th>
            <th class='lr_none'><span id='sort' id='3'>비율</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${pager.list}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/>'><c:out value='${data.title }'/></td>
                <td class='tx_r' title='<c:out value='${data.value}'/>'><c:out value='${data.value}'/></td>
                <td class='tx_r lr_none' title='<c:out value='${data.rateValue}'/> %'><c:out value='${data.rateValue}'/> %</td>
            </tr>
        </c:forEach>
        <op:no-data obj="${pager}" colspan="3" />
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
            <td class='tx_r lr_none' title=''>-</td>
        </tr>
    </tfoot>
</table>
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
<!-- //리스트 -->