<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    
    if('${fn:length(prvList)}' > 0)
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
	            case 'langCodes':
	                if($.trim($(this).val()) == '') {
	                    errorPlace(this);
	                    returnVal = false;
	                }
	                break;
            	case 'grpCds':
	                if($.trim($(this).val()) == '' || $(this).val() <= -1) {
	                    errorPlace(this);
	                    returnVal = false;
	                }
	                break;
	            case 'prvCds':
	                if($.trim($(this).val()) == '' || $(this).val() <= -1) {
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
    
    if(!listVal.eachVal('langCode') || !listVal.eachVal('grpCd') || !listVal.eachVal('prvCd') || !listVal.eachVal('prvNm')) {
        jsWarningBox("올바르지 않은 데이터를 삭제하여 주십시오.");
        return false;
    }
    return true;
    
};

var jsDeleteGrc = function() {
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
	        $('#prvInsertForm').ajaxSubmit({
	            url      : "ND_insertPrvExcelEnBlocAction.do",
	            type     : "POST",
	            dataType : "json",
	            success  : function(response) {
	                if(response.value > 0 && response.message == "") {
	                    jsSuccessBox(Message.msg.insertOk);
	                    parent.$.fn.colorbox.close();
	                } else if(response.value > 0 && response.message != "") {
	                    jsWarningBox(response.message);
	                } else {
	                    jsErrorBox(response.message);
	                }
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
	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="PD_regExcelEnBloc.do" onsubmit="return jsFileVaildate();">
		<h2 class="tx_13">개별코드 엑셀일괄등록</h2>
		<div>
		    <ul class="blet">
		        <li>작성 시 샘플파일에 맞추어 작성해 주시면 정확하게 데이터를 가져올 수 있습니다.
		            <button type="button" class="blue" onclick="document.location.href='/resources/download/Prv_Excel_Sample.xls';">샘플파일 다운로드</button>
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
	
	<c:if test="${not empty prvList}">
	<ul class="blet">
	    <li><span class="tx_b tx_blue">언어코드, 그룹코드, 개별코드, 개별코드명</span>은 <span class="tx_b tx_red">필수 값</span>입니다.</li>
	    <li>개별코드 일괄등록은 언어코드와 그룹코들가 먼저 등록되어 있어야 합니다.</li>
	    <li>개별코드는 정확하게 입력하셔야 합니다.</li>
	</ul>
	
	<form name="prvInsertForm" id="prvInsertForm" method="post">
		<div style="height:246px; width: 835px;" class="border overflow">
		    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다." style="table-layout: fixed;">
		        <caption class="hidden"> 목록 </caption>
		        <colgroup>
		            <col width="70" />
		            <col width="70" />
		            <col width="70" />
		            <col width="90" />
		            <col />
		        </colgroup>
		        <thead>
		            <tr>
		                <th>선택 <input type="checkbox" name="checkAll" id="checkAll" onclick="jsAllCheck('seq', this);" /></th>                
		                <th>언어코드<span class="tx_red tx_b">*</span></th>
		                <th>그룹코드<span class="tx_red tx_b">*</span></th>
		                <th>개별코드<span class="tx_red tx_b">*</span></th>                
		                <th class="lr_none">개별코드명</th>
		            </tr>
		        </thead>
		        <tbody id="odd-color">
		            <c:forEach items="${prvList}" var="prcVo" varStatus="status">
		                <tr>
		                    <td><input type="checkbox" onclick="jsToggleCheck(this);" id="seq_${status.count}" name="seq" value="${status.count}" /></td>
		                    <td>
		                        ${prcVo.langCode}
		                        <input type="hidden" name="langCodes" value="${prcVo.langCode}" />
		                    </td>
		                    <td>
		                        ${prcVo.grpCd}
		                        <input type="hidden" name="grpCds" value="${prcVo.grpCd}" />
		                    </td>                    
		                    <td>
		                        ${prcVo.prvCd}
		                        <input type="hidden" name="prvCds" value="${prcVo.prvCd}" />
		                    </td>
		                    <td>
		                        ${prcVo.prvNm}
		                        <input type="hidden" name="prvNm" value="${prcVo.prvNm}" />
		                    </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>		    
		<div class="btn_r">
		    <button class="blue" type="button" onclick="jsDeleteGrc();">선택 삭제</button>
		    <button class="blue" type="button" onclick="jsInsertAction();">일괄 등록</button>
		</div>
	</form>
	</c:if>
</body>
</html>