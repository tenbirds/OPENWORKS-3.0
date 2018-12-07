<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>

<head>
    <title>마일리지 그룹 목록 관리</title>
    <op:jsTag type="spi" items="ui,validate,form"/>
    <script type="text/javascript">
    var jsInsertMileageGroup = function(){
        
    };
    </script>
</head>
<body>
<h2>마일리지 그룹 목록</h2>
<div id="popup">
<form name="pagingForm" id="pagingForm" method="post" action="PD_setMileageGroupPop.do">
<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
<input type="hidden" name="q_currPage" value="${param.q_currPage}" />
<input type="hidden" name="q_sortName" value="" />
<input type="hidden" name="q_sortOrder" value="" />
<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
</form>
<form name="searchForm" id="searchForm" method="post" action="PD_setMileageGroupPop.do">
    <!-- 검색 -->
    <div class="search">
        <fieldset>
            <legend>게시글의 마일리지 명,마일리지 그룹명으로 검색하세요.</legend>
            <!-- 검색어 작성-->
            <input class="w215" type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" />

            <!-- 검색버튼 -->
            <button class="gray mar_l5 mar_b5">검색</button>
            
        </fieldset>
    </div>
</form>
<form name="listForm" id="listForm" method="post" action="PD_setMileageGroupPop.do">
<op:pagerParam title="마일리지 그룹 목록" />

    <table class="boardList" cellspacing="0" border="0" summary="마일리지 그룹 리스트입니다.">
        <caption class="hidden">마일리지 그룹 목록</caption>
        <colgroup>
            <col width="10%"/>
            <col width=""/>
            <col width="15%"/>
            <col width="25%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>마일리지 그룹명</th>
                <th>등록자</th>
                <th class="lr_none">등록일시</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="mileageVo" varStatus="status">
                <tr>
                    <td>
                        ${index-status.index}
                    </td>
                    <td class="tx_l">
                        <a href="PD_updaetMileageGrpForm.do?mileageGrpCd=${mileageVo.mileageGrpCd}" onclick="jsMileageGrpForm(this, '${mileageVo.mileageGrpCd}'); return false;">
                            ${mileageVo.mileageGrpNm}
                        </a>
                    </td>
                    <td>
                        ${mileageVo.regNm}
                    </td>
                    <td class="lr_none">
                        <fmt:formatDate value="${mileageVo.regDtm}" pattern="yyyy-MM-dd hh:mm:ss" />
                    </td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="4" />
        </tbody>
    </table>
    <div class="tx_r mar_t10">
        <button class="blue" type="button" onclick="location.href='PD_insertMileageGrpForm.do'">마일리지 그룹 등록</button>
    </div>
</form>
<op:pager pager="${pager}" />
</div>
</body>
</html>