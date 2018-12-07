
/* ============================== 댓글의 답글 등록 ============================== */

// 댓글의 답글 입력폼 붙이기(단, 기존의 입력폼 제거)
var jsCommentReplyForm = function(domainCd, bbsCd, bbscttSeq, cmtSeq, mid, uid, num) {
    $.post("ND_comment.update.form.do", {
        domainCd : domainCd,
        bbsCd : bbsCd,
        bbscttSeq : bbscttSeq,
        cmtSeq : cmtSeq,
        mngrId : mid,
        updtId : uid
    },
    function(result) {
        if(result.result == true) {
            if(jsFindReplyForm() == 0) {
                jsReplyFormAdd(num);
                jsReplyCancleBtnShow(num);
            } else {   //답글이 하나라도 있을 경우 기본 html 삭제 후 신규 html 추가
                var newNum = jsFindReplyForm();
                jsReplyFormRemove();
                jsReplyCancleBtnHide(newNum);
                jsReplyFormAdd(num);
                jsReplyCancleBtnShow(num);
            }
            
            //댓글의 답글 작성이 필요한 정보 넣기
            $("#activeCommentReply"+num).find('input[name=domainCd]').val(result.value.domainCd);
            $("#activeCommentReply"+num).find('input[name=bbsCd]').val(result.value.bbsCd);
            $("#activeCommentReply"+num).find('input[name=bbscttSeq]').val(result.value.bbscttSeq);
            $("#activeCommentReply"+num).find('input[name=cmtSeq]').val(result.value.cmtSeq);
            $("#activeCommentReply"+num).find('input[name=cmtDp]').val(result.value.cmtDp);
            $("#activeCommentReply"+num).find('input[name=refrnCmtSeq]').val(result.value.refrnCmtSeq);
            $("#activeCommentReply"+num).find('input[name=cmtOrdrNo]').val(result.value.cmtOrdrNo);
            $("#activeCommentReply"+num).find('input[name=currentPage]').val(result.value.currentPage);
            //$("#activeCommentReply"+num).find('textarea[name=nttCmtCn]').val(result.value.nttCmtCn);
        }
    }, 'json');
};

//답글 폼 찾기
var jsFindReplyForm = function() {
    var seq = 0;
    for(var i=0; i < $("#commentList").find('p').length; i++) {
        if($("#activeCommentReply"+(i+1)).filter('.none').length == 0) seq = i + 1 ;
    }
    return seq;
};

//댓글의 답글폼 추가
var jsReplyFormAdd = function(seq) {
    $("#activeCommentReply"+seq).removeClass('none');
    $("#activeCommentReply"+seq).addClass('block');
    var formName = "<form id='commentReplyForm' name='commentReplyForm' method='post'>";
    $("#activeCommentReply"+seq).append(formName + $("#activeCommentReply").html() + "</form>");
    $("#activeCommentReply"+seq).find('textarea[name=nttCmtCn]').focus();
    $("html, body").animate({scrollTop:$("#reply"+seq).position().top}, 10);
};

//댓글의 답글폼 삭제
var jsReplyFormRemove = function() {
    var seq = jsFindReplyForm();
    $("#activeCommentReply"+seq).empty();
    $("#activeCommentReply"+seq).removeClass('block');
    $("#activeCommentReply"+seq).addClass('none');
    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
    jsReplyCancleBtnHide(seq);
};

// 기존 답글버튼 감추고 답글취소버튼 보이기
var jsReplyCancleBtnShow = function(seq){
    $("#btnReply"+seq).removeClass('block');
    $("#btnReply"+seq).addClass('none');
    $("#btnReplyCancle"+seq).removeClass('none');
    $("#btnReplyCancle"+seq).addClass('block');
};

//기존 답글버튼 보이고 답글취소버튼 감추기
var jsReplyCancleBtnHide = function(seq){
    $("#btnReply"+seq).removeClass('none');
    $("#btnReply"+seq).addClass('block');
    $("#btnReplyCancle"+seq).removeClass('block');
    $("#btnReplyCancle"+seq).addClass('none');
};


/* ============================== 댓글 및 답글 수정 ============================== */

//댓글/답글 수정폼
var jsCommentModify = function(domainCd, bbsCd, bbscttSeq, cmtSeq, mid, uid, num) {
    $.post("ND_comment.update.form.do", {
        domainCd : domainCd,
        bbsCd : bbsCd,
        bbscttSeq : bbscttSeq,
        cmtSeq : cmtSeq,
        mngrId : mid,
        updtId : uid
    },
    function(result) {
        if(result.result == true) {
            //타 댓글수정폼 삭제 
            jsModifyFormRemove();
            //댓글수정폼 추가
            jsModifyFormAdd(num);
            jsModifyCancleBtnShow(num);
            //댓글수정폼 정보채우기
            $("#commentModifyForm"+num).find('input[name=domainCd]').val(result.value.domainCd);
            $("#commentModifyForm"+num).find('input[name=bbsCd]').val(result.value.bbsCd);
            $("#commentModifyForm"+num).find('input[name=bbscttSeq]').val(result.value.bbscttSeq);
            $("#commentModifyForm"+num).find('input[name=cmtSeq]').val(result.value.cmtSeq);
            $("#commentModifyForm"+num).find('input[name=cmtDp]').val(result.value.cmtDp);
            $("#commentModifyForm"+num).find('input[name=refrnCmtSeq]').val(result.value.refrnCmtSeq);
            $("#commentModifyForm"+num).find('input[name=cmtOrdrNo]').val(result.value.cmtOrdrNo);
            $("#commentModifyForm"+num).find('input[name=currentPage]').val(result.value.currentPage);
            $("#commentModifyForm"+num).find('textarea[name=nttCmtCn]').val(result.value.nttCmtCn);
            //입력폼에 포커스 저장 및 글자수 확인 /  스크롤 위치변경
            $("#commentModifyForm"+num).find('textarea[name=nttCmtCn]').focus();
            $("#commentModifyForm"+num).find('#commentLength').text($("#nttCmtCn").val().length);
            $("html, body").animate({scrollTop:$("#reply"+num).position().top}, 10);
        } else {
            jsWarningBox(result.message);
        }
    }, 'json');
};

//수정 폼 찾기
var jsFindModifyForm = function() {
    var seq = 0;
    for(var i=0; i<$("#commentList").find('p').length; i++) {
        if($("#commentModifyForm"+(i+1)).filter('.none').length == 0) { seq = i + 1; }
    }
    return seq;
};

//댓글/답글 수정폼 추가
var jsModifyFormAdd = function(seq) {

    
    $("#reply"+seq).find('p').removeClass('block');
    $("#reply"+seq).find('p').addClass('none');
    $("#commentModifyForm"+seq).removeClass('none');
    $("#commentModifyForm"+seq).addClass('block');
    var formName = "<form id='commentModifyForm' name='commentModifyForm' method='post'>";
    $("#commentModifyForm"+seq).append(formName + $("#commentReplyModify").html() + '</form>');
    $("#commentModifyForm"+seq).find('textarea[name=nttCmtCn]').focus();
};

//댓글수정폼 삭제
var jsModifyFormRemove = function() {
    var seq = jsFindModifyForm();
    $("#commentModifyForm"+seq).removeClass('block');
    $("#commentModifyForm"+seq).addClass('none');
    $("#commentModifyForm"+seq).empty();
    $("#reply"+seq).find('p').removeClass('none');
    $("#reply"+seq).find('p').addClass('block');
    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
    jsModifyCancleBtnHide(seq);
};

//수정취소버튼 보이고 기존수정버튼 감추기
var jsModifyCancleBtnShow = function(seq) {
    $("#btnModifyCancle"+seq).removeClass('none');
    $("#btnModifyCancle"+seq).addClass('block');
};

//기존수정버튼 보이고 수정취소버튼 감추기
var jsModifyCancleBtnHide = function(seq) {
    $("#btnModifyCancle"+seq).removeClass('block');
    $("#btnModifyCancle"+seq).addClass('none');
};


/* ============================== 댓글의 답글 등록 및 댓글/답글 수정 ============================== */

var jsReplyInsert = function(form) {
    var divName = "";
    if(form == "commentReplyForm") {
        divName = "activeCommentReply";
        $("#"+divName+" *").attr('disabled', true);
    } else if(form == "commentModifyForm"){
        divName = "commentReplyModify";
        $("#"+divName+" *").attr('disabled', true);
    } else {
        divName = "commentForm";
    }
    
    var a = $.trim($("#"+form+" #nttCmtCn").val());
    var _contents = new String($.trim($("#"+form+" #nttCmtCn").val()));
    
    if(_contents == '' || _contents.length < 0 || _contents.length > 500){
        alert("내용을 확인하세요.(최대 500글자)");
        $("#nttCmtCn")[0].focus();
        return false;
    }
    
    var domainCd = $("#"+form+" #domainCd").val();
    var bbsCd = $("#"+form+" #bbsCd").val();
    var bbscttSeq = $("#"+form+" #bbscttSeq").val();
    var contents = $("#"+form+" #nttCmtCn").val();

    $.post("ND_check.ban.do", {
        domainCd : domainCd,
        bbsCd : bbsCd,
        bbscttSeq : bbscttSeq,
        contents : contents
    }, function(result){
        if(result.result == true){
            //var msg = result.message.replace("\n\n", "<br />");
            //jsWarningBox(msg);
            alert(result.message);
            return;
        } else {
            actionType = $("#"+form+" input[name=type]").val();
            dataString = $("#"+form).serialize();
            $.ajax({
                url      : "ND_cmt.insert.do",
                type     : "POST",
                data     : dataString,
                dataType : "json",
                success  : function(response){
                    alert(response.message);
                    if(actionType == "INSERT") parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
                    //jsReloadTab();
                    jsCmtPageMove($("#commentForm input[name=currentPage]").val());
                }
            });
        }
    }, "json");
    
    return;
};


/* ============================== 전문가상담 댓글(매칭) 선정 ============================== */
        
    var jsSelection = function(domainCd, bbsCd, bbscttSeq, cmtSeq) {
        
        if(!confirm("선택한 댓글을 선정하시겠습니까? "))
            return false;
        
        var estnColumn5 = "Y_"+cmtSeq;
        
        $.post("ND_selectionUpdate.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            estnColumn5 : estnColumn5,
        },
        function(result) {
            if(result.result == true) {
            } else {
                jsWarningBox(result.message);
            }
        }, 'json');
    }
            
            