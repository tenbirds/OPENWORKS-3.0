
/** 신규 등록 */
var jsContentInsert = function() {

    if ($.trim($("#bodyContent").val()) == "") {
        jsWarningBox("BODY 컨텐츠 내용을 입력해야 합니다.");
        return;
    }

	$("#dataForm").attr("action", INSERT_URL);
	$("#dataForm").submit();
/*
    $("#dataForm").ajaxSubmit({
        url : INSERT_URL,
        type : "POST",
        dataType : "json",
        success : function(result) {
            if (result.value != "") {
                if (result.message) {
                    jsMsgBox(result.message);
                    jsClose();
                } else {
                    jsMsgBox("요청하신 정보를 등록했습니다.");
                }
            } else {
                jsErrorBox("정보를 등록하는데 실패했습니다.");
            }
        }
    });
*/
};

/** 수정 */
var jsContentUpdate = function() {

    if ($.trim($("#bodyContent").val()) == "") {
        jsWarningBox("BODY 컨텐츠 내용을 입력해야 합니다.");
        return;
    }

    $("#dataForm").ajaxSubmit({
        url : UPDATE_URL,
        type : "POST",
        dataType: "json",
        success : function(response) {
            if (response.result) {
                jsSuccessBox(response.message);
            } else { 
                jsErrorBox(response.message);
            }
        }
    });

};

/** 컨텐츠 삭제 */
var jsContentDelete = function() {
    var confirmMessage = "정말 삭제 하시겠습니까?";

    if (confirm(confirmMessage)) {
    	$("#headContent").attr("disabled", "disabled");
    	$("#bodyContent").attr("disabled", "disabled");
    	$("#dataForm").attr("action", DELETE_URL);
    	$("#dataForm").submit();
    	/*
        $("#dataForm").ajaxSubmit({
            url : DELETE_URL,
            type : "POST",
            success : function(result) {
                if (result.value == "1") {
                    if (result.message) {
                    	opener.jsMsgBox(result.message);
                    } else {
                    	opener.jsMsgBox("요청하신 정보를 삭제했습니다.");
                        window.close();
                    }
                } else {
                    jsErrorBox("정보를 삭제하는데 실패했습니다.");
                }
            }
        });
        */
    }
};

/** BODY 컨텐츠 내용 반환 */
var jsGetContents = function() {

	return $('#bodyContent').val();
};

/** 컨텐츠 미리보기 */
var jsContentPreview = function() {
    $("#previewContent").val(jsGetContents());
    $("#dataForm").attr("action", PRE_VIEW_URL);
    $("#dataForm").attr("target", "_blank");
    $("#dataForm").submit();
    $("#dataForm").removeAttr("target");
};

/** 자동승인 발행 */
var jsDeploy = function() {
    if($.trim($("#publishReason").val()) == "") {
        jsWarningBox("발행사유를 등록해야 합니다.");
        $("#approvalReason").focus();
        return;
    }

    $("#approvalSt").val("1040");
    jsContentUpdate();
};

/** 컨텐츠 발행 요청 */
var jsDeployRequest = function() {
    if($.trim($("#publishReason").val()) == "") {
        jsWarningBox("발행사유를 등록해야 합니다.");
        $("#approvalReason").focus();
        return;
    }

    $("#approvalSt").val("1020");
    jsContentUpdate();
};

/** 컨텐츠 발행 요청 취소 */
var jsDeployCancel = function() {
    $("#approvalSt").val("1010");
    jsContentUpdate();
};

/** 열린 창을 닫으며 부모창 텝 리로드 */
var jsClose = function(closeYn) {

    var openWin = opener;
    if (!opener && window.showModalDialog) {
        openWin = window.dialogArguments;
    }

    if(openWin && openWin.reloadTab)
        openWin.reloadTab();

    if(!closeYn || closeYn == "Y")
        self.close();
};

