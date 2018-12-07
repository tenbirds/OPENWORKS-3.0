<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<html>
<head>
    <title>만족도평가</title>

    <op:jsTag type="openworks" items="ui, form" />

    <script type="text/javascript">
    
        $().ready(function(){
    
        });

    </script>
</head>

<body>

    <form name="dataForm" id="dataForm" method="get" action="PD_SatisfyView.do">
    
    <input type="hidden" id="domainCd" name="domainCd" value="${param.domainCd}" />
    <input type="hidden" id="menuCode" name="menuCode" value="${param.menuCode}" />
    
    <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
    <op:pagerParam title="만족도평가 상세 목록" />

    </form>
    <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup>
            <col width="70px" />
            <col width="80px" />
            <col width="80px" />
            <col width="100px" />
            <col width="100px" />
            <col width="" />
        </colgroup>
        <thead>
            <tr>
                <th>일련번호</th>
                <th>등록자(ID)</th>
                <th>IP Addr</th>
                <th>평점</th>
                <th>등록일</th>
                <th>코멘트</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:forEach items="${pager.list}" var="dataDetlVO" varStatus="status">
                <c:set var="class" value="${status.count % 2 == 1 ? 'even' : 'odd'}" />
            <tr>
                <td>
                    ${dataDetlVO.seqNo}
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty dataDetlVO.regId and dataDetlVO.regId ne 'NULL_GUEST'}">
                            ${dataDetlVO.regNm}(${dataDetlVO.regId})
                        </c:when>
                        <c:otherwise>비회원</c:otherwise>
                    </c:choose>
                </td>
                <td>
                    ${dataDetlVO.regIp}
                </td>
                <td>
                    ${dataDetlVO.itemNo}
                </td>
                <td>
                    ${dataDetlVO.regDt}
                </td>
                <td class="tl">
                    ${dataDetlVO.comments}
                </td>
            </tr>
            </c:forEach>
            
            <op:no-data obj="${pager}" colspan="5"/>

        </tbody>
    </table>

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
</body>
</html>