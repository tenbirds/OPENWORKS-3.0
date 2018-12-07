<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색 -->
<div class='mar_b10'>
    <fieldset class='mar_r20'>
        <label class='tx_b'>
            <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' /> 출력단위
        </label>
        <select id='searchWeekDate' name='searchWeekDate' class='over' onchange='search();'>
                <option value='1' <c:if test="${searchVo.searchWeekDate eq '1'}">selected='selected'</c:if>>일</option>
                <option value='2' <c:if test="${searchVo.searchWeekDate eq '2'}">selected='selected'</c:if>>월</option>
                <option value='3' <c:if test="${searchVo.searchWeekDate eq '3'}">selected='selected'</c:if>>화</option>
                <option value='4' <c:if test="${searchVo.searchWeekDate eq '4'}">selected='selected'</c:if>>수</option>
                <option value='5' <c:if test="${searchVo.searchWeekDate eq '5'}">selected='selected'</c:if>>목</option>
                <option value='6' <c:if test="${searchVo.searchWeekDate eq '6'}">selected='selected'</c:if>>금</option>
                <option value='7' <c:if test="${searchVo.searchWeekDate eq '7'}">selected='selected'</c:if>>토</option>

        </select>
    </fieldset>
</div>
<!-- //검색 -->