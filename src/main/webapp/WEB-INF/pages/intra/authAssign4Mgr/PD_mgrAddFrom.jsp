<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>개인별 권한지정 등록</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
<!--

	$(document).ready(function() {
	    $("input[name=mgrIdCk]").click(function() {
	        if($(this).is(":checked")){
	            $(this).parent().parent().addClass("bg_blue");
	        }else{
	            $(this).parent().parent().removeClass("bg_blue");
	        }
	    });
	});

    var jsAssign4MgrAdd = function () {
        var hasMgrIds = false;
        var mgrNames = '';

        var $baseDiv = parent.$('#MgrAuthList');
        $('input[name=mgrIdCk]:checked').each(function () {
            var htmlStr = '';
            htmlStr += '<li>';
            htmlStr += '    <span class="tx_b" mgrId="'+$(this).val()+'">'+$(this).parent().siblings().eq(3).text()+'</span>';
            htmlStr += '    <span class="tx_blue_l cs_pointer">[보기]</span>';
            htmlStr += '</li>';

            if ($baseDiv.find('ul.panList').length > 0) {
                if ($baseDiv.find('span[mgrId="'+$(this).val()+'"]').length > 0) {
                    hasMgrIds = true;
                    mgrNames += ',' + $(this).parent().siblings().eq(3).text();
                    return;
                }
                $baseDiv.find('ul.panList').append(htmlStr);
            } else {
                $baseDiv.html('<ul class="panList">'+htmlStr+'</ul>');
            }

        });
        $baseDiv.next('p').html('개인별 권한수 : <span class="tx_b">'+$baseDiv.find('li').length+'개</span>');

        // 이벤트 바인딩
        parent.jsMakeMgrListClick();

        if (hasMgrIds) {
            jsWarningBox('개인별 권한 목록에 ' + mgrNames.substring(1) + ' 가 있습니다.');
            return;
        }
        parent.$.colorbox.close();
    };

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

    <form id="sForm" action="PD_mgrAddFrom.do" method="post">
    <input type="hidden" name="q_currPage"   value="${param.q_currPage}" />
    <input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
    <input type="hidden" name="q_sortName"   value="${param.q_sortName}" />
    <input type="hidden" name="q_sortOrder"  value="${param.q_sortOrder}" />

    <!-- 검색 -->
    <div class="search">
        <fieldset>
            <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
            <select name="q_searchType" class="over">
                <option value="mgrId">ID</option>
                <option value="mgrNm">담당자명</option>
            </select>
            <input class="w120" type="text" value="" name="q_searchText" title="검색어를 입력하세요." />
            <button class="gray mar_l5">검색</button>
        </fieldset>
    </div>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" summary="담당자목록 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="8%" />
            <col width="20%" />
            <col width="20%" />
            <col width="10%" />
            <col width="15%" />
            <col width="" />
        </colgroup>
        <thead>
            <tr>
                <th>선택</th>
                <th>ID</th>
                <th>부서명</th>
                <th>직위</th>
                <th>담당자명</th>
                <th class="lr_none">현재지정권한</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
            <tr>
                <td><input type="checkbox" name="mgrIdCk" value="${_bean.mgrId}" /></td>
                <td>${_bean.mgrId}</td>
                <td>${_bean.deptNm}</td>
                <td>${_bean.gradeNm}</td>
                <td>${_bean.mgrNm}</td>
                <td class="lr_none">${_bean.authListString}</td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager}" colspan="6" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <p class="mar_t10 mar_b20 tx_r">
        <a href="#" onclick="jsAssign4MgrAdd();"><button type="button" class="blue">등록</button></a>
    </p>
    </form>
</body>
</html>