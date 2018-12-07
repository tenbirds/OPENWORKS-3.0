<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색 -->
<div class='mar_b10'>
    <fieldset class='mar_r20'>
        <label class='tx_b'>
            <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' /> 출력단위
        </label>
        <select id='searchUnit' name='searchUnit' class='over' onchange='search();'>
            <option value='HOUR' <c:if test='${searchVO.searchUnit eq "HOUR"}'>selected='selected'</c:if>>시간 단위</option>
            <option value='DATE' <c:if test='${searchVO.searchUnit eq "DATE"}'>selected='selected'</c:if>>일 단위</option>
            <option value='WEEK' <c:if test='${searchVO.searchUnit eq "WEEK"}'>selected='selected'</c:if>>주간 단위</option>
            <option value='MONTH' <c:if test='${searchVO.searchUnit eq "MONTH"}'>selected='selected'</c:if>>월 단위</option>
        </select>
        <span class='mar_l20 tx_b'>비교 평균값 :</span>
        
        <button id='compareBtn1' class='s_blue mar_l5 mar_b5' onclick='compareSearch("1");'>전일</button>
        <button id='compareBtn7' class='s_blue mar_l5 mar_b5' onclick='compareSearch("7");'>일주일</button>
        <button id='compareBtn30' class='s_blue mar_l5 mar_b5' onclick='compareSearch("30");'>1개월</button>
    </fieldset>
</div>
<!-- //검색 -->