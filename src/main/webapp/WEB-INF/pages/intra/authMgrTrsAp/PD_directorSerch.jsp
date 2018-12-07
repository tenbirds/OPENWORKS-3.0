<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
<title>담당자 검색</title>
<script type="text/javascript">
    var jsSearchAction = function() {
        if (  $("#q_searchKey").val() != "" && $("#q_searchVal").val() == "" ) {
            jsWarningBox("검색어를 입력하세요."); $("#q_searchVal").focus(); return false;
        }
        if ( $("#q_searchVal").val() != "" && $("#q_searchKey").val() == "" ) {
            jsWarningBox("검색 조건을 선택하세요."); $("#q_searchKey").focus(); return false;
        }
        document.dataForm.action = "PD_directorSerch.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action= "PD_directorSerch.do";
        document.dataForm.submit();
    };

    var sendData = function(mgrId, deptNm, gradeNm, mgrNm){

        $(parent.document).find('label[for=targetMgrId]').remove();
        $(parent.document).find('label[for=targetDeptNm]').remove();
        $(parent.document).find('label[for=targetGradeNm]').remove();
        $(parent.document).find('label[for=targetMgrNm]').remove();

        $(parent.document).find('input[id=targetMgrId]').parent().append('<label for="targetMgrId">'+ mgrId +'</label>');
        $(parent.document).find('input[id=targetDeptNm]').parent().append('<label for="targetDeptNm">'+ deptNm +'</label>');
        $(parent.document).find('input[id=targetGradeNm]').parent().append('<label for="targetGradeNm">'+ gradeNm +'</label>');
        $(parent.document).find('input[id=targetMgrNm]').parent().append('<label for="targetMgrNm">'+ mgrNm +'</label>');

        parent.document.getElementById("targetMgrId").value = mgrId;

        parent.$.fn.colorbox.close();
    };
    
    var classOn = function(no){
    	$("tr[id^=index_").attr("style", "");
    	$("#index_"+no).attr("style", "font-weight:bold; background-color:#bdcae2;");
    };
    var classOut = function(no){
    	$("#index_"+no).attr("style", "");
    };
</script>
</head>
<body>
    <!-- 컨텐츠영역 -->
        <form id="dataForm" name="dataForm" action="PD_directorSerch.do" method="post">

            <!-- 검색 -->
            <div class="search">
                 <fieldset>
                <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
                     <select name="q_searchKey" id="q_searchKey" class="over">
                         <option value="">-- 선택 --</option>
                         <option value="1001" <c:if test="${param.q_searchKey eq '1001'}">selected="selected"</c:if>>ID</option>
                         <option value="1002" <c:if test="${param.q_searchKey eq '1002'}">selected="selected"</c:if>>담당자명</option>
                     </select>
                     <input class="w215" type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" title="검색어를 입력하세요."/>
                     <button class="gray mar_l5 mar_b5" type="button" onclick="jsSearchAction();">검색</button>
                </fieldset>
            </div>
        <!-- //검색 -->
        <op:pagerParam title="담당자목록" />
        <br/>
        </form>
        <!-- 리스트 -->
        <table class="boardList" summary="담당자목록 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="20%"/>
                <col width=""/>
                <col width="20%"/>
                <col width="25%"/>
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
            <c:set var="index" value="${pager.indexNo}"/>
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
                <tr id="index_${status.index}" onclick="sendData('${_bean.mgrId}', '${_bean.deptNm}', '${_bean.gradeNm}', '${_bean.mgrNm}')" onmouseover="classOn('${status.index}');" onmouseout="classOut('${status.index}');">
                    <td>${_bean.mgrId}</td>
                    <td>${_bean.deptNm}</td>
                    <td>${_bean.gradeNm}</td>
                    <td class="lr_none">${_bean.mgrNm}</td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager}" colspan="4" />
            </tbody>
        </table>
        <!-- //리스트 -->

        <!-- 페이징 -->
        <div class="paging">
            <op:pager pager="${pager}" />
        </div>
        <!-- //페이징 -->
    <!-- //컨텐츠영역 -->
</body>
</html>