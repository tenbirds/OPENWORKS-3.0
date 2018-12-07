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
    
    if('${fn:length(mgrList)}' > 0)
        parent.$.colorbox.resize({width : 900, height: 700});
    
    $("#mrgExcelFile").MultiFile({ max: 1 });
});

var ListValidation = function(){
    
    this.isEmpty = function(){
        if(!$("table.boardList tbody tr").length > 0) {
            jsWarningBox("데이터가 없습니다.");
            return false;
        }
        return true;
    };
    
    this.eachVal = function(target){
        var returnVal = true;
        
        $("input[name="+target+"]").each(function(){
            switch(target){
                case 'ofcpsCds':
                    if($.trim($(this).val()) == '' || $(this).val() <= -1 || $.trim($(this).next().html()) == '') {
                        errorPlace(this);
                        returnVal = false;
                    }
                    break;
                case 'deptCode':
                    if($.trim($(this).val()) == '' || $.trim($(this).next().html()) == '') {
                        errorPlace(this);
                        returnVal = false;
                    }
                    break;
                case 'mngrPassword':
                    if($.trim($(this).val()) == '' || $(this).val().length < 9) {
                        errorPlace(this);
                        returnVal = false;
                    }
                    break;
                default :
                    if($.trim($(this).val()) == '') {
                        errorPlace(this);
                        returnVal = false;
                    }
            }
        });
        
        return returnVal;
    };
    
    var errorPlace = function(obj){
        $(obj).parent().parent().removeClass("bg_yellow");
        $(obj).parent().parent().addClass("bg_red");
        $(obj).parent().css({'border': '2px solid #f3574b'});
    };
};

var validate = function() {
    var listVal = new ListValidation();
    
    if(!listVal.isEmpty()) return false;
    
    if( !listVal.eachVal('mngrId') || !listVal.eachVal('mngrNm') || !listVal.eachVal('ofcpsCds') 
            || !listVal.eachVal('deptCode') || !listVal.eachVal('mngrPassword') ) {
        jsWarningBox("올바르지 않은 데이터를 삭제하여 주십시오.");
        return false;
    }
    
    return true;
    
};

var jsDeleteMgr = function() {
    $("input[id^=seq_]:checked").each(function(){
        $(this).parent().parent().remove();
    });
};

var jsFileVaildate = function() {
    if($("#mrgExcelFile").val() == '') {
        jsWarningBox("파일을 첨부해주십시오.");
        return false;
    }
    
    return true;
};

var jsInsertAction = function() {
try{
    if(!validate()){
        return;
    }else{
        $('#mgrInsertForm').ajaxSubmit({
            url      : "ND_insertMrgExcelEnBlocAction.do",
            type     : "POST",
            dataType: "json",
            success  : function(response) {
                if(response.result) {
                    jsSuccessBox(response.value + "개의 " +response.message);
                    parent.$.fn.colorbox.close();
                    parent.$("#treeDetailDiv").load(parent.VIEW_URL, $('#mgrInsertForm').serialize());
                } else {
                    jsErrorBox(Message.msg.processFail);
                }
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    }
}catch(e){
    alert(e);
}
};
//-->
</script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="PD_registerExcelEnBloc.do" onsubmit="return jsFileVaildate();">
<h2 class="tx_13">담당자 엑셀일괄등록</h2>
<div>
    <ul class="blet">
        <li>작성 시 샘플파일에 맞추어 작성해 주시면 정확하게 데이터를 가져올 수 있습니다.
            <button type="button" class="blue" onclick="document.location.href='/resources/download/Mgr_Excel_Sample.xls';">샘플파일 다운로드</button>
        </li>
    </ul>
    
    <p class="gray_box_tx tx_c">
        <input type="file" name="mrgExcelFile" id="mrgExcelFile" accept="xls" class="w470" style="background-color: #fff;" />
    </p>
    
    <div class="btn_r">
        <button class="blue">불러오기</button>
    </div>
</div>
</form>

<c:if test="${not empty mgrList}">
<ul class="blet">
    <li><span class="tx_b tx_blue">아이디, 이름, 부서코드, 비밀번호</span>는 <span class="tx_b tx_red">필수 값</span>입니다.</li>
    <li><span class="tx_b tx_red">비밀번호는 10자 이상</span>으로 등록하셔야 합니다.</li>
    <li>직위코드와 부서코드는 정확하게 입력하셔야 합니다.</li>
</ul>

<form name="mgrInsertForm" id="mgrInsertForm" method="post">
<div style="height:246px; width: 835px;" class="border overflow">
    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다." style="table-layout: fixed;">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="40" />
            <col width="80" />
            <col width="70" />
            <col width="90" />
            <col width="90" />
            <col width="90" />
            <col width="100" />
            <col width="100" />
            <col width="100" />
            <col width="150" />
            <col width="100" />
        </colgroup>
        <thead>
            <tr>
                <th>선택 <input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('seq', this);" /></th>
                <th>아이디<span class="tx_red tx_b">*</span></th>
                <th>이름<span class="tx_red tx_b">*</span></th>
                <th>직위코드</th>
                <th>부서코드<span class="tx_red tx_b">*</span></th>
                <th>비밀번호<span class="tx_red tx_b">*</span></th>
                <th>전화번호</th>
                <th>팩스번호</th>
                <th>휴대폰번호</th>
                <th>이메일</th>
                <th class="lr_none">주요업무</th>
            </tr>
        </thead>
        <tbody id="odd-color">
            <c:forEach items="${mgrList}" var="mgrVo" varStatus="status">
                <tr>
                    <td><input type="checkbox" onclick="jsToggleCheck(this);" id="seq_${status.count}" name="seq" value="${status.count}" /></td>
                    <td>
                        ${mgrVo.mngrId}
                        <input type="hidden" name="mngrId" value="${mgrVo.mngrId}" />
                    </td>
                    <td>
                        ${mgrVo.mngrNm}
                        <input type="hidden" name="mngrNm" value="${mgrVo.mngrNm}" />
                    </td>
                    <td>
                        ${mgrVo.ofcpsCd}
                        <input type="hidden" name="ofcpsCds" value="${mgrVo.ofcpsCd}" />
                        [<span>${mgrVo.gradeNm}</span>]
                    </td>
                    <td>
                        ${mgrVo.deptCode}
                        <input type="hidden" name="deptCode" value="${mgrVo.deptCode}" />
                        [<span>${mgrVo.deptNm}</span>]
                    </td>
                    <td>
                        ${mgrVo.mngrPassword}
                        <input type="hidden" name="mngrPassword" value="${mgrVo.mngrPassword}" />
                    </td>
                    <td>
                        ${mgrVo.telno}
                        <input type="hidden" name="telno" value="${mgrVo.telno}" />
                    </td>
                    <td>
                        ${mgrVo.fxnum}
                        <input type="hidden" name="fxnum" value="${mgrVo.fxnum}" />
                    </td>
                    <td>
                        ${mgrVo.mbtlnum}
                        <input type="hidden" name="mbtlnum" value="${mgrVo.mbtlnum}" />
                    </td>
                    <td style="word-break:break-all;">
                        ${mgrVo.email}
                        <input type="hidden" name="email" value="${mgrVo.email}" />
                    </td>
                    <td style="word-break:break-all;" class="lr_none">
                        ${mgrVo.chrgJob}
                        <input type="hidden" name="chrgJob" value="${mgrVo.chrgJob}" />
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
    
<div class="btn_r">
    <button class="blue" type="button" onclick="jsDeleteMgr();">선택 삭제</button>
    <button class="blue" type="button" onclick="jsInsertAction();">일괄 등록</button>
</div>
</form>
</c:if>
</body>
</html>