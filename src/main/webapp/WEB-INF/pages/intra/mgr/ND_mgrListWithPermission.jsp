<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>담당자 목록</title>
<op:jsTag type="spi" items="highlight" />
<op:jsTag type="openworks" items="ui, form" />

<script type="text/javascript">

    var getParameter = function(){
    	return "&deptCode="+$("#deptCode").val()+"&q_currPage="+$("#q_currPage").val()+"&q_rowPerPage="+$("#q_rowPerPage").val()+"&q_searckKey="+$("#q_searckKey").val()+"&q_searckValue="+$("#q_searckValue").val();
    };

    var update = function(el, vl) {
        $(el).colorbox({
            title : "담당자 정보 상세",
            href : "PD_updateForm.do?mngrId=" + vl + getParameter(),
            width : "900",
            height : "880",
            iframe : true
        });
    };

    // 담당자 정보 삭제
    var jsDeleteAction = function() {
        var selectedMgrIds = jsCheckedArray();
        if (selectedMgrIds.length == 0) {
            alert("담당자를 선택해 주세요.");
            return;
        }

        var mgrIds = selectedMgrIds.join(",");

        if (confirm("정말 삭제 하시겠습니까?")) {
            $.ajax({
                url : "INC_deleteListAction.do",
                type : "POST",
                data : { mgrIds : mgrIds },
                success : function(response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.deleteOk);
                            $("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                }
            });
        }
    };

    //일괄권한지정 띄우기
    var assignAuthPopup = function(el) {
        var selectedMgrIds = jsCheckedArray();
        if (selectedMgrIds.length == 0) {
            alert("담당자를 선택해 주세요.");
            $(el).removeClass('cboxElement');
            return false;
        } else {
            $(el).colorbox({
                title  : "일괄권한지정",
                href   : "PD_assignInsertList.do?mgrIds=" + selectedMgrIds + getParameter(),
                width  : "600",
                height : "400",
                iframe : true
            });
        }

    };

    //부서이동 팝업 띄우기
    var deptTransferPopup = function(el) {
         var selectedMgrIds = jsCheckedArray();
         if (selectedMgrIds.length == 0) {
             alert("담당자를 선택해 주세요.");
             $(el).removeClass('cboxElement');
            return false;
        } else {
            $(el).colorbox({
                title  : "부서이동",
                href   : "PD_deptTransfer.do?mgrIds=" + selectedMgrIds,
                width  : "500",
                height : "400",
                iframe : true
            });
        }
    };

    //페이지 이동
    var jsMovePage = function(cpage) {
        $("#pagingForm input[name=q_currPage]").val(cpage);
        $("#treeDetailDiv").load(VIEW_URL, $('#pagingForm').serialize());
    };

    var submitEvent = function() {
        if(event.keyCode == 13) {
            jsSearchAction();
        }
    };

    var jsSearchAction = function() {
        if ($("#q_searckKey").val() != "" && $("#q_searckValue").val() == "") {
            jsWarningBox("검색어를 입력하세요.");
            $("#q_searckValue").focus();
            return false;
        }

        $("#dataForm input[name=q_currPage]").val(1);
        $("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
        return true;
    };

    // 페이지당 로우 수 변경 시
    var jsFormSubmit = function() {
        $("#dataForm input[name=q_currPage]").val(1);
        $("#treeDetailDiv").load(VIEW_URL, $('#dataForm').serialize());
        return false;
    };

    var targetAssignPop = function(el, vl, popType) {
        var ptitle = '지정 권한 등록';
        if(popType == 'Update') ptitle = '지정 권한 수정';

        $(el).colorbox({
            title  : ptitle,
            href   : "PD_authAssignForm.do?mngrId="+vl+ getParameter(),
            width  : "630",
            height : "550",
            iframe : true
        });
    };

    var targetAssignListPop = function(el, vl, authCode) {
        $(el).colorbox({
            title : "지정 권한 목록",
            href : "PD_targetAssign.do?mngrId="+vl,
            width : "550",
            height : "550",
            iframe : true
        });
    };


    //체크된 담당자 아이디 가져오기
    var jsCheckedArray = function() {
        var selectedMgrId = [];

        $("input[name=ck]:checked").each(function(i) {
            selectedMgrId[i] = $(this).val();
        });

        return selectedMgrId;
    };

    //체크된 담당자명 가져오기
    var jsCheckedArray1 = function() {
        var selectedMgrNm = [];

        $("input[name=ck]:checked").each(function(i) {
            selectedMgrNm[i] = $(this).parent().parent().find('td:eq(4) span').text();
        });

        return selectedMgrNm;
    };

    var downExcel = function() {
        if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = 'INC_mgrListExcel.do?deptCode=' + treePanel.getSelectionModel().getSelectedNode().id;
        $('#excelFr').attr('src',url);
    };
</script>
</head>

<body>
<form id="pagingForm" name="pagingForm">
<input type="hidden" name="q_currPage" value="${searchMap.q_currPage}" />
<input type="hidden" name="q_sortName" value="${searchMap.q_sortName}" />
<input type="hidden" name="q_rowPerPage" value="${searchMap.q_rowPerPage}" />
<input type="hidden" name="q_searckKey" value="${param.q_searckKey}" />
<input type="hidden" name="q_searckValue" value="${param.q_searckValue}" />
<input type="hidden" name="deptCode"   value="${param.deptCode}" />
</form>
<div class="float_r mar_b10">
    <a href="#"><button class="w_blue" id="insertBtn" onclick="insertPop('${param.deptCode}');">담당자등록</button></a>
    <a href="#"><button class="w_blue"  id="excelEnBloc" onclick="jsRegisterExcelEnBloc();">엑셀일괄등록</button></a>
    <a href="#"><button class="w_blue" onclick="downExcel();">엑셀출력</button></a>
    <!-- <a href="#"><button class="w_blue" onclick="alert('준비 중..');">내부연계</button></a> -->
</div>
<!-- 컨텐츠영역 -->
<div>
<%--         <h4 class="tx_13">[${deptNm}] 담당자 목록</h4> --%>

<!-- 페이지당 목록선택-->
<form name="dataForm" id="dataForm" method="post" onsubmit="return jsFormSubmit();">
    <input type="hidden" name="deptCode"   id="deptCode"   value="${param.deptCode}" />
    <input type="hidden" name="nodePath" id="nodePath" value=""/>
<%--         <op:pagerParam view="view" /> --%>

    <div class="search">
        <fieldset>
            <legend>ID,담당자명으로 검색하세요.</legend>
            <select id="q_searckKey" name="q_searckKey" class="over">
                <option value="">--검색조건--</option>
                <option value="1001"
                    <c:if test="${param.q_searckKey == '1001'}">selected="selected"</c:if>>ID</option>
                <option value="1002"
                    <c:if test="${param.q_searckKey == '1002'}">selected="selected"</c:if>>담당자명</option>
            </select>
            <input class="w215" type="text" value="${param.q_searckValue}" id="q_searckValue" name="q_searckValue" onkeypress="submitEvent();" title="검색어를 입력하세요." />
            <button class="gray mar_l5" type="button" onclick="jsSearchAction();" id="searchBtn">검색</button>
        </fieldset>
    </div>

    <op:pagerParam title="[${deptNm}] 담당자 목록" />

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
        <caption class="hidden">목록</caption>
        <colgroup>
            <col width="6%" />
            <col width="6%" />
            <col width="10%" />
            <col width="7%" />
            <col width="10%" />
            <col width="150px" />
            <col width="16%" />
            <col width="16%" />
            <col width="*" />
        </colgroup>
        <thead>
            <tr>
                <th><input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('ck', this);" /></th>
                <th>번호</th>
                <th>ID</th>
                <th>직위</th>
                <th>담당자명</th>
                <th>권한그룹</th>
                <th>접속이력</th>
                <th>변경이력</th>
                <th class="lr_none">사용여부</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="mgrVo" varStatus="status">
                <tr>
                    <td class="ch">
                        <input type="checkbox" value="${mgrVo.mngrId}" name="ck" id="ck_${mgrVo.mngrId}" class="ck" <c:if test="${mgrVo.useYn ne 'Y'}"> disabled="disabled"</c:if> onclick="jsToggleCheck(this);" />
                    </td>
                    <td>${pager.indexNo - status.index}</td>
                    <td>${mgrVo.mngrId}</td>
                    <td>${mgrVo.gradeNm}</td>
                    <td>
                        <a href="#" onclick="update(this,'${mgrVo.mngrId}');"><span>${mgrVo.mngrNm}</span></a>
                    </td>
                    <td>
                        <c:if test="${not empty mgrVo.authCode}">
                            <a href="#" onclick="targetAssignListPop(this,'${mgrVo.mngrId}');"><button class="gray_s">보기</button></a>&nbsp;&nbsp;
                            <button class="gray_s" type="button" onclick="targetAssignPop(this,'${mgrVo.mngrId}', 'Update'); return false;">수정</button>
                        </c:if>
                        <c:if test="${empty mgrVo.authCode}">
                            <button class="gray_s" type="button" onclick="targetAssignPop(this,'${mgrVo.mngrId}', 'Insert'); return false;">등록</button>
                        </c:if>
                    </td>
                    <td><c:out value="${mgrVo.loginDt}" default="-" /></td>
                    <td><c:out value="${mgrVo.modiDt}" default="-" /></td>
                    <td class="lr_none">
                        <c:if test="${mgrVo.useYn ne 'Y'}">
                            <a href="javaScript:jsUseYn(this,'${mgrVo.mngrId}');">
                            <span id="UseYn_${mgrVo.mngrId}" class="tx_red" title="클릭 시 사용으로 변경">미사용</span> <img src="/resources/intra/mgr/icon_cancel_red.png" style="vertical-align:middle;" />
                            </a>
                        </c:if>
                        <c:if test="${mgrVo.useYn eq 'Y'}">
                            <a href="javaScript:jsUseYn(this,'${mgrVo.mngrId}');">
                            <span id="UseYn_${mgrVo.mngrId}" class="ico-chk" title="클릭 시 미사용으로 변경">사용</span> <img src="/resources/intra/mgr/icon_chk_blue.png" style="vertical-align:middle;" />
                            </a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="9" />
        </tbody>
    </table>
</form>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <div class="mar_b20">
    <c:if test="${param.deptCode ne '0'}">
        <div class="float_l">
            <a href="#" class="btn"><button onclick="deptTransferPopup(this);" class="blue">부서이동</button> </a>
            <a href="#" class="btn"><button onclick="assignAuthPopup(this);" class="blue">일괄권한지정</button></a>
        </div>
    </c:if>
        <div class="float_r">
            <a href="#" class="btn"><button onclick="jsDeleteAction();" class="blue">삭제</button></a>
        </div>
    </div>
</div>
<!-- //컨텐츠영역 -->
</body>
</html>