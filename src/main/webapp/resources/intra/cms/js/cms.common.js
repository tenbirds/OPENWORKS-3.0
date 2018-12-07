
/** 레이아웃 프리뷰 URL */
var layoutPreviewUrl = CTX_PATH + "/intra/cms/layout/PD_LayoutPreView.do";

/** 사용자미리보기 */
var jsUserPreview = function(userUrl) {
    var url = "";
    if(userUrl) {
        url = userUrl;
    } else {
        url = $("#userMenuUrl").val();

        if (url.length == 0) {
            jsErrorBox("미리보기 URL 정보가 없습니다.");
            return;
        }
    }

    var domainNm = $("#domainNm").val();
    var portNo = $("#portNo").val();

    url = "http://"+domainNm+":"+portNo+url;

    window.open(url,"userPreView","");

};

/** 관리자미리보기 */
var jsAdminPreview = function(adminMenuUrl) {

    var url = adminMenuUrl;
    if(!adminMenuUrl) {
        url = $("#adminMenuUrl").val();
    }

    if (url.length == 0) {
        jsWarningBox("미리보기 URL 정보가 없습니다.");
        return;
    } else {
        if(url.indexOf("/intra/cms/") >= 0) {
            var option = "chrome,centerscreen,dependent=yes, dialog=yes,modal=yes, resizable=yes, scrollbars=yes, location=0, status=0, menubar=0, toolbar=0";
                 window.open(url, "adminPreView", option);
        } else {
            window.open(url, "jsAdminPreview", "");
        }
    }

};

/** 레이아웃미리보기 */
var jsLayoutPreview = function(domainCd, layoutCode, menuCode, contentSeqNo) {
    var url = layoutPreviewUrl;
    
    if(!domainCd) {
        domainCd = $("#domainCd").val();
    }

    if(!layoutCode) {
        layoutCode = $("#layoutCode").val();
    }

    url += "?q_domainCd=" + domainCd + "&q_layoutCode=" + layoutCode;

    if(menuCode) {
        url += "&q_menuCode=" + menuCode;
    }

    if(contentSeqNo) {
        url += "&q_contentSeqNo=" + contentSeqNo;
    }

    window.open(url, "layoutPreview","");
};

/** 레이아웃삭제 */
var jsLayoutDelete = function(domainCd, layoutCode) {
    if(confirm("정말 삭제 하시겠습니까?")) {
        $("#domainCd").val(domainCd);
        $("#layoutCode").val(layoutCode);
        $("#dataForm").attr("action", "ND_DeleteLayoutAction.do");
        $("#dataForm").attr("method", "post");

        $("#dataForm").ajaxSubmit({
            url      : "ND_DeleteLayoutAction.do",
            type     : "POST",
            dataType : "JSON",
            success  : function(response) {
                if (response.result) {
                    jsSuccessBox(response.message);
                    document.location.reload();
                } else { 
                    jsErrorBox(response.message);
                }
            }
        });
    }
};

/** 컨텐츠 등록/편집 */
var jsContentForm = function() {
    var contentTypeRadio = $("input[name=contentType]:checked").val();
    var contentTypeText = $("input[name=contentType]").val();

    if(!contentTypeRadio && !contentTypeText) {
        jsWarningBox("컨텐츠 유형을 선택해야 합니다.");
        return;
    }

    var q_domainCd = $("#q_domainCd").val();
    var q_menuCode = $("#q_menuCode").val();
    var q_contentSeqNo = $("#q_contentSeqNo").val();

    var link = "content/BD_ContentForm.do?q_domainCd="+q_domainCd+"&q_menuCode="+q_menuCode;
    link += "&q_contentSeqNo="+q_contentSeqNo;

    window.open(link, "contentPop", "");
};

/** ExtJs Tab Panel에 해당 URL을 오픈한다. */
var jsOpenTabPanel = function(menuNm, url, uniqueId, type) {
    if(!type) {
        type = "ADD";
    }

    top.mainFrame.contentPanel.loadClass(menuNm, url, uniqueId, type);
};

/** 발행목록 텝 이동 */
var jsPublishTabList = function(url, q_approvalSt) {
    $("#q_approvalSt").val(q_approvalSt);

    jsList(url);

};

/** 멀티파일 업로드 */
var jsSetMultiFile = function() {
    $('input:file').MultiFile({
        max: 1,
        accept: "jpg|jpeg|gif|png"
    }); 
};
