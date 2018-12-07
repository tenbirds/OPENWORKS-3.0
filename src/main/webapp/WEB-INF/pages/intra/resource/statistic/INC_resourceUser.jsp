<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="./include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="./include/INC_chartBar3.jsp" charEncoding="utf-8"/>

<!-- 검색영역2 -->
<%-- <c:import url="./include/INC_search5.jsp" charEncoding="utf-8"/> --%>
<br/>
<!-- 리스트 -->
<table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
    <caption class='hidden'> 목록 </caption>
    <colgroup>
        <col width='25%'/>
        <col width='25%'/>
        <col width='25%'/>
        <col width='25%'/>
    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sortHead1' onclick='sorting("1");'>사용자ID</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>이용횟수</span></th>
            </th>
<!--             <th class='lr_none'><span id='sortHead4' onclick='sorting("4");'>증감</span></th> -->
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/>'>
                    <c:out value='${data.title }'/>
                                       
                </td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="2">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>        
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
        </tr>
    </tfoot>
</table>
<!-- //리스트 -->