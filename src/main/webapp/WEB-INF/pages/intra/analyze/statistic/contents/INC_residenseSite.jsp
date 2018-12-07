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
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='7%'/>
        <col width='8%'/>
        <col width=''/>
    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sortHead1' onclick='sorting("1");'>일자</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>페이지뷰</span></th>
            <th><span id='sortHead3' onclick='sorting("3");'>방문수</span></th>
            <th><span id='sortHead4' onclick='sorting("4");'>1분 미만</span></th>
            <th><span id='sortHead5' onclick='sorting("5");'>3분 미만</span></th>
            <th><span id='sortHead6' onclick='sorting("6");'>7분 미만</span></th>
            <th><span id='sortHead7' onclick='sorting("7");'>15분 미만</span></th>
            <th><span id='sortHead8' onclick='sorting("8");'>20분 미만</span></th>
            <th><span id='sortHead9' onclick='sorting("9");'>30분 미만</span></th>
            <th><span id='sortHead10' onclick='sorting("10");'>1시간 미만</span></th>
            <th><span id='sortHead11' onclick='sorting("11");'>1시간 이상</span></th>
            <th><span id='sortHead12' onclick='sorting("12");'>총시간</span></th>
            <th><span id='sortHead13' onclick='sorting("13");'>페이지뷰당 평균</span></th>
            <th class='lr_none'><span id='sortHead14' onclick='sorting("14");'>방문당 평균</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/>'><c:out value='${data.title }'/></td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>
                <td class='tx_r' title='<c:out value='${data.value2 }'/>'><c:out value='${data.value2}'/></td>
                <td class='tx_r' title='<c:out value='${data.value3 }'/>'><c:out value='${data.value3}'/></td>
                <td class='tx_r' title='<c:out value='${data.value4 }'/>'><c:out value='${data.value4}'/></td>
                <td class='tx_r' title='<c:out value='${data.value5 }'/>'><c:out value='${data.value5}'/></td>
                <td class='tx_r' title='<c:out value='${data.value6 }'/>'><c:out value='${data.value6}'/></td>
                <td class='tx_r' title='<c:out value='${data.value7 }'/>'><c:out value='${data.value7}'/></td>
                <td class='tx_r' title='<c:out value='${data.value8 }'/>'><c:out value='${data.value8}'/></td>
                <td class='tx_r' title='<c:out value='${data.value9 }'/>'><c:out value='${data.value9}'/></td>
                <td class='tx_r' title='<c:out value='${data.value10}'/>'><c:out value='${data.value10}'/></td>
                <td class='tx_r' title='<c:out value='${data.textValue }'/>'><c:out value='${data.textValue}'/></td>
                <td class='tx_r' title='<c:out value='${data.textValue2 }'/>'><c:out value='${data.textValue2}'/></td>
                <td class='tx_r lr_none' title='<c:out value='${data.textValue3}'/>'><c:out value='${data.textValue3}'/></td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="14">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value2 }'/>'><c:out value='${dataVo.value2}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value3 }'/>'><c:out value='${dataVo.value3}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value4 }'/>'><c:out value='${dataVo.value4}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value5 }'/>'><c:out value='${dataVo.value5}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value6 }'/>'><c:out value='${dataVo.value6}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value7 }'/>'><c:out value='${dataVo.value7}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value8 }'/>'><c:out value='${dataVo.value8}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value9 }'/>'><c:out value='${dataVo.value9}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.value10}'/>'><c:out value='${dataVo.value10}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.textValue }'/>'><c:out value='${dataVo.textValue}'/></td>
            <td class='tx_r' title='<c:out value='${dataVo.textValue2 }'/>'><c:out value='${dataVo.textValue2}'/></td>
            <td class='tx_r lr_none' title='<c:out value='${dataVo.textValue3}'/>'><c:out value='${dataVo.textValue3}'/></td>            
        </tr>
    </tfoot>
</table>
<!-- //리스트 -->