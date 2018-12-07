<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
<!--

	$(document).ready(function() {
	    $("input[name=searchCheckMgr]").click(function() {
	        if($(this).is(":checked")){
	            $(this).parent().parent().addClass("bg_blue");
	        }else{
	            $(this).parent().parent().removeClass("bg_blue");
	        }
	    });
	});

    var jsMovePage = function (page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $('#sForm input[name=q_currPage]').val(p);

         $.ajax({
             type:        "POST",
             url:         'ND_mgrList.do',
             data:        $("#sForm").serialize(),
             dataType:    "html",
             contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
             async:       false,
             success:     function(data) { $("#treeDetailDiv").html(data); },
             error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
         });

    };

    var jsCheckMgr = function () {
        if ($('#allCheckMgr').is(':checked')) {
            $.ajax({
                type:        "POST",
                url:         'ND_mgrDeptAllList.do',
                data:        $("#sForm").serialize(),
                dataType:    "json",
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                async:       false,
                success:     function(data) { jsAddMgr2AssignTable(data); },
                error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
            });
            jsAssignMgr();
            return;
        }

        var jsonStr = "";
        $('input[name="searchCheckMgr"]:checked').each(function () {
            var $baseTr = $(this).parent().parent();
            $baseTr.find('td').each(function (index) {
                if (index === 0) {
                    jsonStr += ',{"authListString" : "' + $(this).find('span').text() + '", ';
                } else if (index === 1) {
                    jsonStr += '"mgrId" : "' + $(this).text() + '", ';
                } else if (index === 2) {
                    jsonStr += '"deptNm" : "' + $(this).text() + '", ';
                } else if (index === 3) {
                    jsonStr += '"gradeNm" : "' + $(this).text() + '", ';
                } else if (index === 4) {
                    jsonStr += '"mgrNm" : "' + $(this).text() + '" }';
                }
            });
            $(this).val('Y');
        });

        jsAddMgr2AssignTable($.parseJSON("[" + jsonStr.substring(1) + "]"));
        jsAssignMgr();
    };

    var jsAssignMgr = function(el) {
        $(el).colorbox({
            title : "담당자별 권한지정 관리",
            href  : "PD_assignList.do",
            width : "1000",
            height: "600",
            iframe: true
        });
    };

    var jsSearchAction = function() {
        if ($("#q_searchType").val() != "" && $("#q_searchText").val() == "") {
            jsWarningBox("검색어를 입력하세요.");
            $("#q_searchText").focus();
            return false;
        }

        $("#sForm input[name=q_currPage]").val(1);
        $("#treeDetailDiv").load(VIEW_URL, $('#sForm').serialize());
        return true;
    };
// -->
</script>
<h4 class="tx_13">담당자 목록</h4>


<form id="sForm">
<input type="hidden" name="deptCd"     value="${param.deptCd}" />
<input type="hidden" name="highDeptCd" value="${param.highDeptCd}" />

<!-- 검색 -->
<div class="search">
    <fieldset>
        <legend>게시글의 제목,작성자,내용으로 검색하세요.</legend>
        <select id="q_searchType" name="q_searchType" class="over">
            <option value="">--선택--</option>
            <option value="mgrId" <c:if test="${param.q_searchType eq 'mgrId'}">selected="selected"</c:if>>ID</option>
            <option value="mgrNm" <c:if test="${param.q_searchType eq 'mgrNm'}">selected="selected"</c:if>>담당자명</option>
        </select>
        <input class="w120" type="text" value="${not empty param.q_searchType ? param.q_searchText : ''}" name="q_searchText" id="q_searchText" title="검색어를 입력하세요." />
        <button class="gray mar_l5" type="button" onclick="jsSearchAction();">검색</button>
    </fieldset>
</div>
<!-- //검색 -->

<!-- 리스트 -->
<table class="boardList" summary="담당자목록 리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="10%" />
        <col width="20%" />
        <col width="*" />
        <col width="20%" />
        <col width="20%" />
    </colgroup>
    <thead>
        <tr>
            <th><input type="checkbox" name="checkAll" id="checkAll" onclick="jsChangeCheckbox();" /></th>
            <th>ID</th>
            <th>부서명</th>
            <th>직위</th>
            <th class="lr_none">담당자명</th>
        </tr>
    </thead>
    <tbody id="odd-color">
        <c:forEach items="${pager.list}" var="_bean" varStatus="status">
        <tr>
            <td>
                <input type="checkbox" name="searchCheckMgr" />
                <span style="display: none;">${_bean.authListString}</span>
            </td>
            <td>${_bean.mgrId}</td>
            <td>${_bean.deptNm}</td>
            <td>${_bean.gradeNm}</td>
            <td class="lr_none">${_bean.mgrNm}</td>
        </tr>
        </c:forEach>
        <op:no-data obj="${pager}" colspan="5" />
    </tbody>
</table>
<!-- //리스트 -->

<!-- 페이징 -->
<op:pager pager="${pager}" />
<!-- //페이징 -->

<div class="mar_t10 mar_b20" style="height:18px;">
    <div class="float_l">
        <input type="checkbox" id="allCheckMgr" /> 담당자 전체( <span class="tx_red_b">${pager.totalNum}</span>명 / ${pager.totalNum}명 ) 권한지정
    </div>
    
    <div class="float_r">
        <a href="#" class="btn" onclick="jsCheckMgr();"><button type="button" class="blue">선택</button></a>
    </div>
</div>

<%-- <p class="tx_c clear"><img src="<c:url value="/resources/openworks/theme/default/images/icon/arrow_under.gif" />" class="mar_t20" alt=""/></p> --%>
</form>