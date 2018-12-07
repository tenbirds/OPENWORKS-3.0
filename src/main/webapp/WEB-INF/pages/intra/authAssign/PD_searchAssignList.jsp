<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>권한지정 관리</title>
<op:jsTag type="spi" items="form,validate" />
<op:jsTag type="openworks" items="ui" />

<script type="text/javascript">
<!--

	$(document).ready(function() {
	    $("input[name=ck]").click(function() {
	        if($(this).is(":checked")){
	            $(this).parent().parent().addClass("bg_blue");
	        }else{
	            $(this).parent().parent().removeClass("bg_blue");
	        }
	    });
	});

    var authOptionListLoad = function (vl) {
        var doAjax = function (nodeEls) {
            var htmlStr = '';
            for (var i = 0; i < nodeEls.length; i++) {
                htmlStr += '<option value="'+nodeEls[i].authCd+'">'+nodeEls[i].authNm+'</option>';
            }
            $(htmlStr).appendTo('select[name=q_authcd]');
            $('select[name=q_authcd]').val(vl);
        };

        $.ajax({
            type:        'POST',
            url:         'ND_authList.do',
            dataType:    'json',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            async:       false,
            success:     function(data) { doAjax(data); },
            error:       function () { jsErrorBox('정상적으로 처리되지 않았습니다.'); }
        });
    };

    var jsMakeSearchOptionStr = function () {
        var searchOptionStr = '';
        searchOptionStr += $('select[name=q_authType] option:selected').text();
        searchOptionStr += ' > ';
        searchOptionStr += $('select[name=q_authcd] option:selected').text();
        searchOptionStr += ' > ';
        searchOptionStr += $('select[name=q_searchType] option:selected').text();
        if ($('input[name=q_searchText]').val() != '') {
            searchOptionStr += ' > ';
            searchOptionStr += $('input[name=q_searchText]').val();
        }
        $('#searchOptionStr').text(searchOptionStr);
    };

    var jsAssignMrgDeleteAction = function () {

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

    $().ready(function () {
        authOptionListLoad('${param.q_authcd}');
        jsMakeSearchOptionStr();

        $('button:contains("검색")').click(function () {
            $('#sForm input[name=q_currPage]').val(1);
            $('#sForm').submit();
        });
    });

    var jsExcelLoad = function(){
        if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = 'INC_mgrListByAuthExcel.do?q_authType='+$("select[name=q_authType] option:selected").val()+'&q_authcd='+$("select[name=q_authcd] option:selected").val()+'&q_searchType='+$("select[name=q_searchType] option:selected").val()+ '&q_searchText='+$("#q_searchText").val();
        $('#excelFr').attr('src',url);
    };
//-->
</script>
</head>

<body>

    <!-- 검색 -->
    <form id="sForm" action="PD_searchAssignList.do">
    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <select name="q_authType" class="over">
                <option value="">권한구분</option>
                <option value="ALL" <c:if test="${param.q_authType eq 'ALL'}">selected="selected"</c:if>>전체</option>
                <option value="ATH" <c:if test="${param.q_authType eq 'ATH'}">selected="selected"</c:if>>관리자권한</option>
            </select>
            <select name="q_authcd" class="over">
                <option value="">권한선택</option>
                <option value="ALL">전체</option>
            </select>
            <select name="q_searchType" class="over">
                <option value="">선택</option>
                <option value="ALL"   <c:if test="${param.q_searchType eq 'ALL'}">selected="selected"</c:if>>전체</option>
                <option value="mgrNm" <c:if test="${param.q_searchType eq 'mgrNm'}">selected="selected"</c:if>>담당자명</option>
                <option value="mgrId" <c:if test="${param.q_searchType eq 'mgrId'}">selected="selected"</c:if>>ID</option>
            </select>
            <input type="text" name="q_searchText" class="w180" id="q_searchText"
                   value="${param.q_searchText}" title="검색어를 입력하세요." />
            <button type="button" class="gray mar_l5">검색</button>
        </fieldset>
    </div>
    <!-- //검색 -->

    <p class="tx_r"><button class="w_blue" type="button" onclick="jsExcelLoad();">엑셀출력</button></p>
    <div class="mar_b30 mar_t20">
    <table class="boardWrite">
        <colgroup>
            <col width="15%" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>검색조건</th>
                <td id="searchOptionStr"></td>
            </tr>
        </tbody>
    </table>
    </div>

    <op:pagerParam view="plist" title="검색결과" />
    </form>

    <!-- 리스트 -->
    <table class="boardList" summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="6%" />
            <col width="6%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="10%" />
            <col width="*" />
            <col width="10%" />
        </colgroup>
        <thead>
            <tr>
                <th>선택 <input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('ck', this);" /></th>
                <th>번호</th>
                <th>ID</th>
                <th>부서명</th>
                <th>직위</th>
                <th>담당자명</th>
                <th>권한그룹</th>
                <th class="lr_none">사용여부</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:forEach items="${pager.list}" var="_bean" varStatus="status">
            <tr>
                <td><input type="checkbox" value="" name="ck" /></td>
                <td>${_bean.rn}</td>
                <td>${_bean.mgrId}</td>
                <td>${_bean.deptNm}</td>
                <td>${_bean.gradeNm}</td>
                <td>${_bean.mgrNm}</td>
                <td class="tx_l">${_bean.authListString}</td>
                <td class="lr_none">
                    <c:if test="${_bean.useYn eq 'Y'}">사용</c:if>
                    <c:if test="${_bean.useYn ne 'Y'}">미사용</c:if>
                </td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager}" colspan="8" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 버튼 -->
    <div class="tx_l mar_t10 mar_b5">
        <a href="#" class="btn" onclick="jsAssignMrgDeleteAction();"><button type="button" class="blue">삭제</button></a>
    </div>

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>
