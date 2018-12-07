/**
 * 구분     생 성 일     생성자
 * ==========================
 * 신규    2014.05.01   윤연탁   
 * 
 * 해당 메뉴로 찾아가기 위한 신규 생성
 */

//******************************  COMMON  ******************************/

//메뉴URL 변경하기
var jsRequestMenu =  function(formId, action, method, menuCd) {
    
    if(1001 == menuCd) {
        jsRequestUrl(formId, action+"1.do", method);
    } else if(1002 == menuCd) {
        jsRequestUrl(formId, action+"2.do", method);
    } else if(1003 == menuCd) {
        jsRequestUrl(formId, action+"3.do", method);
    } else if(1004 == menuCd) {
        jsRequestUrl(formId, action+"4.do", method);
    } else if(1005 == menuCd) {
        jsRequestUrl(formId, action+"5.do", method);
    } else if(1006 == menuCd) {
        jsRequestUrl(formId, action+"6.do", method);
    } else if(1007 == menuCd) {
        jsRequestUrl(formId, action+"7.do", method);
    } else if(1008 == menuCd) {
        jsRequestUrl(formId, action+"8.do", method);
    } else if(1009 == menuCd) {
        jsRequestUrl(formId, action+"9.do", method);
    } else if(1010 == menuCd) {
        jsRequestUrl(formId, action+"10.do", method);
    } else if(1011 == menuCd) {
        jsRequestUrl(formId, action+"11.do", method);
    } else if(1012 == menuCd) {
        jsRequestUrl(formId, action+"12.do", method);
    } else {
        jsRequestUrl(formId, action+".do", method);
    }
    
};

var jsRequestUrl = function(formId, action, method){
    document.dataForm.action = action;
    document.dataForm.method = method;
    document.dataForm.submit();
};

//******************************  COMMON  ******************************/



//******************************  LIST  ******************************//

//상세보기 바로가기
var jsView = function(domainCd, bbsCd, bbscttSeq, regPwd, openYn, menuCd){
    if(bbscttSeq == "") {
        alert(Messges.msg.noPosts);
        return;
    }
    
    //비공개 글 && 세션 없음 && 비밀번호 존재일 때
    if((OpenWorks.isSession == false) && (regPwd != '') && (openYn == 'N')){
        $.fn.colorbox({
            open  : true,
            title : "Contents Password",
            href  : "PD_pwd.form.do?domainCd="+ domainCd +"&bbsCd=" + bbsCd + "&bbscttSeq=" + bbscttSeq,
            width : "395", height : "275",
            iframe: true
        });
        return;
    }
    
    $("#dataForm input[name=domainCd]").val(domainCd);
    $("#dataForm input[name=bbsCd]").val(bbsCd);S
    $("#dataForm input[name=bbscttSeq]").val(bbscttSeq);
    $("#dataForm input[name=extColumn10]").val(menuCd);
    jsRequestMenu("dataForm", "BD_board.view", "post", menuCd);
};

//검색 버튼
var jsSearch = function(menuCd){
    var searchKey = $("#q_searchKeyType");
    var searchVal = $("#q_searchVal");
    
    if("" == $.trim(searchKey.val())) { searchVal.val(""); }
    
    $("#dataForm input[name=q_sortName]").val("");
    $("#dataForm input[name=q_sortOrder]").val("");
    refreshPage(menuCd);
};

//페이지별 리로드
var refreshPage = function(menuCd){
    if(OpenWorks.pageType == "LIST") { jsListReq(1, menuCd); } 
    else if(OpenWorks.pageType == "VIEW") { jsViewReq(1, menuCd); }
};

//page번호로 목록 페이지를 호출한다.(bbsCd는 기본 셋팅값 사용)
var jsListReq = function(page, menuCd) {
    $("#dataForm input[name=q_currPage]").val(page);
    $("#dataForm input[name=extColumn10]").val(menuCd);
    jsRequestMenu("dataForm", "BD_board.list", "get", menuCd);
};

//테이블 상단 정렬 클릭시
var jsSort = function(item){
    var menuCd = $("#extColumn10").val();
    $("#dataForm input[name=q_sortName]").val(item);
    if($("#dataForm input[name=q_sortOrder]").val() == "ASC"){
        $("#dataForm input[name=q_sortOrder]").val("DESC");
    } else {
        $("#dataForm input[name=q_sortOrder]").val("ASC");
    }
    refreshPage(menuCd);
};

//등록 버튼폼(bbsCd로 구분 refrnSeq=null, bbscttSeq=null)
var jsInsertForm = function(pageType, menuCd){
    $("#dataForm input[name=refrnSeq]").val("");
    $("#dataForm input[name=bbscttSeq]").val("");
    $("#dataForm input[name=pageType]").val(pageType);
    jsRequestMenu("dataForm", "BD_board.insert.form", "post", menuCd);
};

var jsPopView = function(domainCd, bbsCd, bbscttSeq, regPwd, extColumn7, menuCd, el) {
    if(extColumn7 == 1003) {
        $(el).colorbox({
            title : "Video Popup View",
            href : "/web/board/PD_board.view.do?domainCd="+domainCd+"&bbsCd="+bbsCd+"&bbscttSeq="+bbscttSeq,
            width : "680",
            height : "700",
            iframe : true
        });
    } else {
        $(el).colorbox({
            title : "Photo Popup View",
            href : "/web/board/PD_board.view.do?domainCd="+domainCd+"&bbsCd="+bbsCd+"&bbscttSeq="+bbscttSeq,
            width : "680",
            height : "700",
            iframe : true
        });
    }
};

//수정폼버튼(bbsCd, bbscttSeq로 구분 refrnSeq = null)
var jsPopUpdateForm = function(pageType, menuCd){
    $("#dataForm input[name=refrnSeq]").val('');
    $("#dataForm input[name=pageType]").val(pageType);
    jsRequestMenu("dataForm", "PD_board.update.form", "get", menuCd);
};

var jsExtColumn = function(q_extColumn, menuCd) {
    $("#dataForm input[name=q_extColumn7]").val(q_extColumn);
    jsListReq(1, menuCd);
};

//******************************  LIST  ******************************// 


//******************************  FORM  ******************************// 

var jsInsertAction = function(){
    document.dataForm.method = "post";
    $("#dataForm").submit();
    //jsRequestUrl("dataForm", "ND_board.insert.do", "post");
};

var jsUpdateAction = function(){
    document.dataForm.method = "post";
    $("#dataForm").submit();
    //jsRequestUrl("dataForm", "ND_board.update.do", "post");
};

var jsPopUpdateAction = function(){
    document.dataForm.method = "post";
    $("#dataForm").submit();
    //jsRequestUrl("dataForm", "ND_board.pop.update.do", "post");
};

//******************************  FORM  ******************************// 


//******************************  VIEW  ******************************// 

//목록 바로가기
var jsList = function(page, menuCd){
    $("#dataForm input[name=title]").attr("disabled", "disabled");
    $("#dataForm [name=contents]").attr("disabled", "disabled");
    $("#dataForm").unbind("submit", null);
    jsRequestMenu("dataForm", "BD_board.list", "get", menuCd);
};

//수정폼버튼(bbsCd, bbscttSeq로 구분 refrnSeq = null)
var jsUpdateForm = function(pageType, menuCd){
    $("#dataForm input[name=refrnSeq]").val("");
    $("#dataForm input[name=pageType]").val(pageType);
    jsRequestMenu("dataForm", "BD_board.update.form", "get", menuCd);
};

//상세화면 로딩시 Provider Info 출력
//Case(1004) / People(1023) Board
var jsProviderInfo = function() {
    var domainCd = $("#dataForm input[name=domainCd]").val();
    var extColumn = $("#dataForm input[name=extColumn8]").val();
    var target = $("#attachedProviderDiv");
    if(extColumn != "") {
        var extColumnList = extColumn.split("^");
        var extColumn8 = extColumnList[0];
        $.get("INC_providerView.do", {
            domainCd : domainCd,
            extColumn8 : extColumn8,
        }, function(result) {
            if(result != "0") {
                target.empty();
                target.append(result);
                target.slideDown(500);
            }
        });
    }
};

//게시글 완전삭제 버튼
var jsDelete = function(domainCd) {
    if(!confirm(Message.msg.deleteConfirm)) return false;
    var msg = "상세 보기 삭제";
    $("#dataForm input[name=delDesc]").val(msg);
    jsRequest("dataForm", "ND_board.delete.do", "post");
};

//게시글 완전삭제 버튼
var jsPopDelete = function(domainCd) {
    
    if(!confirm(Message.msg.deleteConfirm)) {
        return false;
    }
    /*
    switch(domainCd) {
        case 2: {
            if(!confirm("Please delete material attachments and comments are deleted.\n Are you sure?")) {
                return false;
            }
            break;
        }
        case 3: {
            if(!confirm("자료를 삭제하시면 첨부파일 및 코멘트들도 모두 삭제됩니다.\n삭제 하시겠습니까?")) {
                return false;
            }
            break;
        }
        case 4: {
            if(!confirm("자료를 삭제하시면 첨부파일 및 코멘트들도 모두 삭제됩니다.\n삭제 하시겠습니까?")) {
                return false;
            }
            break;
        }
        default: {
            if(!confirm("자료를 삭제하시면 첨부파일 및 코멘트들도 모두 삭제됩니다.\n삭제 하시겠습니까?")) {
                return false;
            }
            break;
        }
    }*/
        
    var msg = "상세 보기 삭제";
    $("#dataForm input[name=delDesc]").val(msg);
    //jsRequest("dataForm", "ND_board.pop.delete.do", "post");
    
    dataString = $("#dataForm").serialize();
    
    $.ajax({
        url      : "ND_board.pop.delete.do",
        type     : "POST",
        data     : dataString,
        dataType : "text",
        async : false,
        success  : function(response) {
            alert(Message.msg.insertOk);
            jsResetAction();
            parent.self.location.reload();
        }
    });
};

//전문가 답변 등록
var jsExpertAnswer = function(domainCd, bbsCd, bbscttSeq) {
    var replyCn = $("#replyCn").val();
    
    $.ajax({
        url      : "ND_boardAnswerUpdate.do",
        type     : "POST",
        data     : {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            replyCn : replyCn
        },
        dataType : "JSON",
        async : false,
        success  : function(response) {
            alert(response.message);
            alert(Message.msg.insertOk);
        }
    });
};

var jsResetAction = function() {
    parent.$.fn.colorbox.close();
};

//******************************  VIEW  ******************************//



//========================================= 추가 및 수정 ==================================================//

var jsViewReq = function(page, menuType) {
  $("#dataForm input[name=q_currPage]").val(page);
  $("#dataForm input[name=extColumn10]").val(menuType);
  jsRequestMenu("dataForm", "BD_board.view", "get", menuType);
};

var jsReplyForm = function(pageType, bbscttSeq, menuType){
  $("#dataForm input[name=pageType]").val(pageType);
  jsRequestMenu("dataForm", "BD_board.reply.form", "get", menuType);
};
