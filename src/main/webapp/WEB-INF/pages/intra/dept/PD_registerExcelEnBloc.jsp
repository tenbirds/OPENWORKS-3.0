<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
<title>엑셀일괄등록</title>
<op:jsTag type="spi" items="multifile, form"/>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
//<!--
$(document).ready(function() {
    
    if('${fn:length(deptList)}' > 0)
        parent.$.colorbox.resize({width : 700, height: 700});
    
    $("#deptExcelFile").MultiFile({ max: 1 });
});

var validate = function() {
    
    var returnVal = true;

    if(!$("table.boardList tbody tr").length > 0) return false;
    $("input[name=deptCode]").each(function(){
        if($.trim($(this).val()) == '' || $.trim($(this).next().html()) != '') {
            returnVal = false;
            cssSetting(this);
        }
    });

    $("input[name=deptNm]").each(function(){
        if($.trim($(this).val()) == '') {
            returnVal = false;
            cssSetting(this);
        }
    });

    return returnVal;
    
};

function cssSetting(obj){
    $(obj).parent().parent().removeClass("bg_yellow");
    $(obj).parent().parent().addClass("bg_red");
    $(obj).parent().css({'border': '2px solid #f3574b'});
}

var jsDeleteDept = function() {
    $("input[id^=seq_]:checked").each(function(){
        $(this).parent().parent().remove();
    });
};

var jsFileVaildate = function() {
    if($("#deptExcelFile").val() == '') {
        alert("파일을 첨부해주십시오.");
        return false;
    }
    
    return true;
};

var jsInsertAction = function() {
    if(!validate()){
        jsWarningBox("올바르지 않은 데이터가 포함되어 있습니다.");
        return;
    }else{
        $('#deptInsertForm').ajaxSubmit({
            url      : "ND_insertDeptExcelEnBlocAction.do",
            type     : "POST",
            success  : function(response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.insertOk);
                        parent.$.fn.colorbox.close();
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
//-->
</script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="PD_registerExcelEnBloc.do" onsubmit="return jsFileVaildate();">
<h2 class="tx_13">부서 엑셀일괄등록</h2>
<div>
    <ul class="blet">
        <li>작성 시 샘플파일에 맞추어 작성해 주시면 정확하게 데이터를 가져올 수 있습니다.
            <button type="button" class="blue" onclick="document.location.href='/resources/download/Dept_Excel_Sample.xls';">샘플파일 다운로드</button>
        </li>
    </ul>
    
    <p class="gray_box_tx tx_c">
        <input type="file" name="deptExcelFile" id="deptExcelFile" accept="xls" class="w470" style="background-color: #fff;" />
    </p>
    
    <div class="btn_r">
        <button class="blue">불러오기</button>
    </div>
</div>
</form>
<!-- class="clear float_r"  -->
<c:if test="${not empty deptList}">
<ul class="blet">
    <li>※ <span class="tx_b tx_red">부서명, 부서코드는 필수 값</span>입니다.</li>
    <li>※ 부서코드는 중복될 수 없습니다.</li>
</ul>

<form name="deptInsertForm" id="deptInsertForm" method="post">
<div style="height:270px;" class="border overflow">
<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="5%" />
        <col width="20%" />
        <col width="15%" />
        <col width="17%" />
        <col width="17%" />
        <col width="" />
    </colgroup>
    <thead>
        <tr>
            <th>선택 <input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('seq', this);" /></th>
            <th>부서명<span class="tx_red tx_b">*</span></th>
            <th>부서코드<span class="tx_red tx_b">*</span></th>
            <th>부서 전화번호</th>
            <th>부서 팩스번호</th>
            <th class="lr_none">주요업무</th>
        </tr>
    </thead>
    <tbody id="odd-color">
        <c:forEach items="${deptList}" var="deptVo" varStatus="status">
            <tr>
                <td><input type="checkbox" onclick="jsToggleCheck(this);" id="seq_${status.count}" name="seq" value="${status.count}" /></td>
                <td>
                    ${deptVo.deptNm}
                    <input type="hidden" name="deptNm" value="${deptVo.deptNm}" />
                </td>
                <td>
                    ${deptVo.deptCode}
                    <input type="hidden" name="deptCode" value="${deptVo.deptCode}" />
                    <c:if test="${deptVo.deptCdDupCnt > 0}">
                        [<span class="tx_red">중복</span>]
                    </c:if>
                </td>
                <td>
                    ${deptVo.telno}
                    <input type="hidden" name="telno" value="${deptVo.telno}" />
                </td>
                <td>
                    ${deptVo.fxnum}
                    <input type="hidden" name="fxnum" value="${deptVo.fxnum}" />
                </td>
                <td style="word-break:break-all;" class="lr_none">
                    ${deptVo.mainDuty}
                    <input type="hidden" name="mainDuty" value="${deptVo.mainDuty}" />
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>
</div>
    
<div class="btn_r">
    <button class="blue" type="button" onclick="jsDeleteDept();">선택 삭제</button>
    <button class="blue" type="button" onclick="jsInsertAction();">일괄 등록</button>
</div>
</form>
</c:if>
</body>
</html>