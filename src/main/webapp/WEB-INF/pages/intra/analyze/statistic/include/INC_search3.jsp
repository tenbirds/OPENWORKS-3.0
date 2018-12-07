<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색 -->
<div class='mar_b10'>
    <fieldset class='mar_r20'>
        <label class='tx_b'>
            <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' /> 출력단위
        </label>
        <select id='searchTime' name='searchTime' class='over' onchange='search();'>
            <c:forEach begin="0" end="23" varStatus="idx">
                <c:if test="${idx.index < 10}"><c:set var="pad" value="0"/></c:if>
                <c:if test="${idx.index >= 10}"><c:remove var="pad"/></c:if>
                <option value='<c:out value="${pad}"/><c:out value="${idx.index}"/>'>
                    <c:out value="${pad}"/><c:out value="${idx.index }"/>시 00분 ~ 
                    <c:out value="${pad}"/><c:out value="${idx.index }"/>시 59분 
                </option>
            </c:forEach>
        </select>
        <script>
        $('#searchTime').val('<c:out value="${searchVO.searchTime}"/>');
        </script>
    </fieldset>
</div>
<!-- //검색 -->