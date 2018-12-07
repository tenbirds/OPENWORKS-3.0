<%@page import="zes.core.spi.commons.configuration.Config"%>
<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="../include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="../include/INC_chartPie.jsp" charEncoding="utf-8"/>

<!-- 리스트 -->
<%
String[] engines = Config.getStringArray("analyze.search-engines.id");
int tdWidth = (80 / (engines.length + 2));
%>
<table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
    <caption class='hidden'> 목록 </caption>
    <colgroup>
        <col width='15%'/>
<%
int i = 0;
for (i = 0 ; i < engines.length-1 ; i++) {
%>        
        <col width='<%=tdWidth %>%'/>
<%
}
%>
        <col width=''/>
    </colgroup>
    <thead id='listHead'>
        <tr>
            <th><span id='sortHead1' onclick='sorting("1");'>검색어</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>검색전체</span></th>
            <%
            for (i = 0 ; i < engines.length ; i++) {
                String engineId = engines[i];
            %>
                <th><span id='sortHead<%=i+3%>' onclick='sorting("<%=i+3%>");'><%=engineId %></span></th>
            <%
            }
            %>
            
            <th class='lr_none'><span id='sortHead<%=i+4%>' onclick='sorting("<%=i+4%>");'>기타</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/>'><c:out value='${data.title }'/></td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>

                <c:forEach items='${data.values}' var='etc'>
                    <td class='tx_r' title='<c:out value='${etc}'/>'><c:out value='${etc}'/></td>
                </c:forEach>
                
                <td class='tx_r lr_none' title='<c:out value='${data.value2}'/>'><c:out value='${data.value2}'/></td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="<%=engines.length+1%>">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>
    </tbody>
    <c:if test="${not empty dataVo}">
        <tfoot>
            <tr class='bg_gray'>
                <td title='합계'>합계</td>
                <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
                <c:forEach items='${dataVo.values}' var='etc'>
                    <td class='tx_r' title='<c:out value='${etc}'/>'><c:out value='${etc}'/></td>
                </c:forEach>
                <td class='tx_r lr_none' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value2 }'/></td>
            </tr>
        </tfoot>    
    </c:if>
</table>
<!-- //리스트 -->