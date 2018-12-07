<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색영역 -->
<c:import url="../include/INC_search1.jsp" charEncoding="utf-8"/>

<!-- 통계그래프영역 -->
<c:import url="../include/INC_chartBar.jsp" charEncoding="utf-8"/>

<!-- 검색영역2 -->
<c:import url="../include/INC_search2.jsp" charEncoding="utf-8"/>

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
            <th><span id='sortHead1' onclick='sorting("1");'>일시</span></th>
            <th><span id='sortHead2' onclick='sorting("2");'>페이지뷰</span></th>
            <th><span id='sortHead3' onclick='sorting("3");'>
                <c:choose>
                    <c:when test='${searchVO.compareFlag eq "1"}'>전일 비교</c:when>
                    <c:when test='${searchVO.compareFlag eq "7"}'>1주일 비교</c:when>
                    <c:when test='${searchVO.compareFlag eq "30"}'>1개월(30일) 비교</c:when>
                </c:choose></span>
            </th>
            <th class='lr_none'><span id='sortHead4' onclick='sorting("4");'>증감</span></th>
        </tr>
    </thead>
    <tbody id='listBody'>
        <c:forEach items='${dataList}' var='data' varStatus='idx'>
            <tr <c:if test='${(idx.count mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                <td title='<c:out value='${data.title }'/> <c:if test='${searchVO.searchUnit eq "HOUR"}'>시</c:if>'>
                    <c:out value='${data.title }'/>
                    <c:if test='${searchVO.searchUnit eq "HOUR"}'>시</c:if>                    
                </td>
                <td class='tx_r' title='<c:out value='${data.value }'/>'><c:out value='${data.value}'/></td>
                <c:forEach items='${data.values}' var='etc'>
                    <td class='tx_r' title='<c:out value='${etc}'/>'><c:out value='${etc}'/></td>
                </c:forEach>
                <td class='tx_r lr_none' title='<c:out value='${data.variation}'/>'>
                    <c:if test='${data.variation > 0}'>
                    <span class='tx_red_b'>↑</span>
                    </c:if>
                    <c:if test='${data.variation < 0}'>
                    <span class='tx_blue'>↓</span>
                    </c:if>
                    <c:out value='${data.variation}'/>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty dataList}">
            <tr>
                <td colspan="4">데이터가 존재하지 않습니다.</td>
            </tr>
        </c:if>        
    </tbody>
    <tfoot>
        <tr class='bg_gray'>
            <td title='합계'>합계</td>
            <td class='tx_r' title='<c:out value='${dataVo.value }'/>'><c:out value='${dataVo.value }'/></td>
            <c:forEach items='${dataVo.values}' var='etc'>
                <td class='tx_r' title='<c:out value='${etc}'/>'><c:out value='${etc}'/></td>
            </c:forEach>
            <td class='tx_r lr_none' title='<c:out value='${dataVo.variation}'/>'>
                <c:if test='${dataVo.variation > 0}'>
                <span class='tx_red_b'>↑</span>
                </c:if>
                <c:if test='${dataVo.variation < 0}'>
                <span class='tx_blue'>↓</span>
                </c:if>
                <c:out value='${dataVo.variation}'/>
            </td>
        </tr>
    </tfoot>
</table>
<!-- //리스트 -->