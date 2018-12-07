<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>담당자 검색</title>
<script type="text/javascript">
<!--
    var jsMovePage = function (page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $('#sForm input[name=q_currPage]').val(p);
        $('#sForm').submit();
    };
//-->
</script>
</head>

<body>

<form id="sForm">
<input type="hidden" name="authCode" value="${param.authCode}" />
<input type="hidden" name="menuCd" value="${param.menuCd}" />

<!-- 검색 -->
<div class="search">
    <fieldset>
        <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
        <select name="q_searchKey" class="over">
            <option value="mngrId" <c:if test="${param.q_searchKey eq 'mngrId'}">selected="selected"</c:if>>ID</option>
            <option value="mngrNm" <c:if test="${param.q_searchKey eq 'mngrNm'}">selected="selected"</c:if>>담당자명</option>
        </select>
        <input class="w120" type="text" value="${param.q_searchVal}" name="q_searchVal" id="q_searchVal" title="검색어를 입력하세요." />
        <button class="gray mar_l5">검색</button>
    </fieldset>
</div>

<op:pagerParam view="plist" title="담당자목록" />
</form>
<!-- //검색 -->

<!-- 리스트 -->
<table class="boardList" summary="담당자목록 리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="20%" />
        <col width="*" />
        <col width="20%" />
        <col width="25%" />
    </colgroup>
    <thead>
        <tr>
            <th>ID</th>
            <th>부서명</th>
            <th>직위</th>
            <th class="lr_none">담당자명</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach items="${pager.list}" var="_bean" varStatus="status">
        <tr>
            <td>${_bean.mngrId}</td>
            <td>${_bean.deptNm}</td>
            <td>${_bean.gradeNm}</td>
            <td class="lr_none">${_bean.mngrNm}</td>
        </tr>
        </c:forEach>
        <op:no-data obj="${pager}" colspan="4" />
    </tbody>
</table>
<!-- //리스트 -->

<!-- 페이징 -->
<op:pager pager="${pager}" />
<!-- //페이징 -->


</body>
</html>