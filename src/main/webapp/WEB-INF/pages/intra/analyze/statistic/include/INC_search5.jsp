<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<!-- 검색 -->
<div class='search'>
    <fieldset>
        <legend>검색하세요.</legend>
        <span class='tx_b mar_l10'>검색어 :</span> 
        <input class='w120' id='searchText' type='text' value='<c:out value="${searchVo.searchText }"/>' name='searchText' title='검색어를 입력하세요.'/>
        <button class='gray mar_l5 mar_b5' onclick="search();">검색</button>
    </fieldset>
</div>
<!-- //검색 -->