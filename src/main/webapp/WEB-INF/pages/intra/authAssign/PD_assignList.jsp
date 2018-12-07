<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
<title>담당자별 권한지정 관리</title>
<op:jsTag type="spi" items="form,validate" />
<script type="text/javascript">
<!--

    $().ready(function () {
        var button = '<button type="button" class="blue" onclick="jsAssignMgrSaveAction();">저장</button> '
            			+ '<button type="button" class="blue" onclick="parent.$.fn.colorbox.close();">담당자 추가</button> '
        				+ '<button type="button" class="blue" onclick="jsDeleteMngToList();">선택한 담당자 제거</button>';
        $("#assignMgr").html(parent.$("#assignMgrHidden").html());
        $("#btn").append(button);

        $("input[name=mgrId]").click(function() {
	        if($(this).is(":checked")){
	            $(this).parent().parent().addClass("bg_blue");
	        }else{
	            $(this).parent().parent().removeClass("bg_blue");
	        }
	    });

        jsChangeCheckbox();

        $("#odd-color tr:even").addClass("");
        $("#odd-color tr:odd").addClass("bg_yellow");
    });

	var jsChangeCheckbox = function() {
	    if($("#checkAll").is(":checked")){
	        $("#selectedMgrList input[name=mgrId]").attr("checked", true);
	        $("#selectedMgrList input[name=mgrId]").parent().parent().addClass("bg_blue");
	    }else{
	        $("#selectedMgrList input[name=mgrId]").attr("checked", false);
	        $("#selectedMgrList input[name=mgrId]").parent().parent().removeClass("bg_blue");
	    }
	};

	var jsAssignMgrSaveAction = function () {
        var authCds = '';

        $('#selectedAuthList li').each(function () {
            authCds += ',' + $(this).attr('authCd');
        });
        $("#assignMgrForm input[name=authCds]").val(authCds.substring(1));


        if (authCds == '') {
            jsWarningBox('선택된 권한이 없습니다.');
            return;
        }
        if ($("#assignMgrForm input[name=mgrId]:checked").length == 0) {
            jsWarningBox('선택된 담당자가 없습니다.');
            return;
        }

        $("#assignMgrForm").ajaxSubmit({
            url      : "ND_assignMgrSaveAction.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if ( jsSuccessBox(response) ) {
                    parent.$.fn.colorbox.close();
                    parent.document.location.reload();
                }
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    };

	var jsDeleteMngToList = function () {
	    if ($("#assignMgrForm input[name=mgrId]:checked").length == 0) {
	        jsWarningBox('선택된 담당자가 없습니다.');
	        return;
	    }

	    $("#assignMgrForm input[name=mgrId]:checked").each(function (index) {
	        $("#tr_"+$(this).val()).remove();
	        parent.$("#tr_"+$(this).val()).remove();
	    });

	    if($('#selectedMgrList > tbody tr').length == 0){
	        $('#selectedMgrList > tbody').append('<tr id="selectedMgrListTr"><td colspan="6" class="lr_none">담당자를 선택하십시요.</td></tr>');
	    }

	    $('h4.tx_13').find('.tx_red_b').text($('#selectedMgrList > tbody tr').length);
	};
//-->
</script>
</head>

<body>

	<div class="buser" id="assignMgr"></div>

</body>
</html>
