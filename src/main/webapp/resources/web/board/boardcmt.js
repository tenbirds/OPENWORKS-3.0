
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
        
        if(result == "notLogin"){
            alert(Message.msg.requiredLogin); 
        }else{
            
            if(result.result == true) {
                if(jsFindReplyForm() == 0) {
                    //alert("num : " + num);
                    
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
            } else {
                alert(Message.msg.requiredLogin); 
                location.href = result.message;
            }
        }
    }, 'json');
};

//답글 폼 찾기
var jsFindReplyForm = function() {
    var seq = 0;
    
    for(var i = 0; i < $("#commentList").find("li div[id^='comments']").length; i++) {
        if($("#activeCommentReply"+(i+1)).filter('.none').length == 0) seq = i + 1 ;
    }
    return seq;
};

//댓글의 답글폼 추가
var jsReplyFormAdd = function(seq) {
    //$("#activeCommentReply"+seq).removeClass('none');
    //$("#activeCommentReply"+seq).addClass('block');

    // 열려있는 모든 답글란 닫기
    for(var i = 1; i <= $("#commentList").find("li div[id^='comments']").length; i++) {
        jsReplyCancleBtnHide(i);
        $("#activeCommentReply"+i).empty();
        $("#activeCommentReply"+i).hide();
    }
    
    $("#activeCommentReply"+seq).show();
    
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
    $("#activeCommentReply"+seq).hide();

    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
    jsReplyCancleBtnHide(seq);
};

//댓글의 답글폼 삭제
var jsReplyFormRemove2 = function(seq) {
    $("#activeCommentReply"+seq).empty();
    //$("#activeCommentReply"+seq).removeClass('block');
    //$("#activeCommentReply"+seq).addClass('none');
    $("#activeCommentReply"+seq).hide();

    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
    jsReplyCancleBtnHide(seq);
};


// 기존 답글버튼 감추고 답글취소버튼 보이기
var jsReplyCancleBtnShow = function(seq){
    //$("#btnReply"+seq).removeClass('block');
    //$("#btnReply"+seq).addClass('none');
    $("#btnReply"+seq).hide();
    
    //$("#btnReplyCancle"+seq).removeClass('none');
    //$("#btnReplyCancle"+seq).addClass('block');
    $("#btnReplyCancle"+seq).show();
    
};

//기존 답글버튼 보이고 답글취소버튼 감추기
var jsReplyCancleBtnHide = function(seq){
    //$("#btnReply"+seq).removeClass('none');
    //$("#btnReply"+seq).addClass('block');
    $("#btnReply"+seq).show();
    
    //$("#btnReplyCancle"+seq).removeClass('block');
    //$("#btnReplyCancle"+seq).addClass('none');
    $("#btnReplyCancle"+seq).hide();
};









/* ============================== 댓글 및 답글 수정 ============================== */

//댓글/답글 수정폼
var jsCommentModify = function(domainCd, bbsCd, bbscttSeq, cmtSeq, uid, num) {
    $.post("ND_comment.update.form.do", {
        domainCd : domainCd,
        bbsCd : bbsCd,
        bbscttSeq : bbscttSeq,
        cmtSeq : cmtSeq,
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
            $("#commentModifyForm"+num).find('textarea[name=nttCmtCns]').focus();
            $("#commentModifyForm"+num).find('#commentLength').text($("#nttCmtCn").val().length);
            $("html, body").animate({scrollTop:$("#reply"+num).position().top}, 10);
        } else {
            alert(Message.msg.requiredLogin);
        }
    }, 'json');
};

//수정 폼 찾기
var jsFindModifyForm = function() {
    var seq = 0;
    for(var i=0; i<$("#commentList").find("li[id^='comments']").length; i++) {
        if($("#commentModifyForm"+(i+1)).filter('.none').length == 0) { seq = i + 1; }
    }
    return seq;
};

//댓글/답글 수정폼 추가
var jsModifyFormAdd = function(seq) {
    //$("#reply"+seq).find('p').removeClass('block');
    //$("#reply"+seq).find('p').addClass('none');
    //$("#commentModifyForm"+seq).removeClass('none');
    //$("#commentModifyForm"+seq).addClass('block');
    
    // 열려있는 모든 답글란 닫기
    for(var i = 1; i <= $("#commentList").find("li div[id^='comments']").length; i++) {
        jsModifyCancleBtnHide(i);
        $("#commentModifyForm"+i).empty();
        $("#commentModifyForm"+i).hide();
    }

    $("#commentModifyForm"+seq).show();

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

//댓글수정폼 삭제
var jsModifyFormRemove2 = function(seq) {
    //$("#commentModifyForm"+seq).removeClass('block');
    //$("#commentModifyForm"+seq).addClass('none');
    //$("#commentModifyForm"+seq).empty();
    //$("#reply"+seq).find('p').removeClass('none');
    //$("#reply"+seq).find('p').addClass('block');
    $("#commentModifyForm"+seq).empty();
    $("#commentModifyForm"+seq).hide();
    
    $("html, body").animate({scrollTop:$("#commentForm").position().top}, 10);
    jsModifyCancleBtnHide(seq);
};

//수정취소버튼 보이고 기존수정버튼 감추기
var jsModifyCancleBtnShow = function(seq) {
    //$("#btnModifyCancle"+seq).removeClass('none');
    //$("#btnModifyCancle"+seq).addClass('block');
    $("#btnModifyCancle"+seq).show();
    $("#btnModify"+seq).hide();
};

//기존수정버튼 보이고 수정취소버튼 감추기
var jsModifyCancleBtnHide = function(seq) {
    //$("#btnModifyCancle"+seq).removeClass('block');
    //$("#btnModifyCancle"+seq).addClass('none');
    $("#btnModifyCancle"+seq).hide();
    $("#btnModify"+seq).show();
};


/* ============================== 댓글의 답글 등록 및 댓글/답글 수정 ============================== */

var jsReplyInsert = function(form) {
    
    var divName = "";
    if(form == "commentReplyForm") {
        divName = "activeCommentReply";
        $("#commentForm *").attr('disabled', true);
    } else if(form == "commentModifyForm"){
        divName = "commentReplyModify";
        $("#commentForm *").attr('disabled', true);
    } else {
        divName = "commentForm";
    }
    
    var _contents = new String($.trim($("#"+form+" #nttCmtCn").val()));
    if(_contents.length == 0 || _contents == ''  ){
        alert(Message.msg.commentChack);
        $("#"+form+" #nttCmtCn").focus();
        return;
    }else if( _contents.length > 500){
        alert(Message.msg.commentCharacters);
        $("#"+form+" #nttCmtCn").focus();
        return;
    }else if( _contents.length < 10){
        alert(Message.msg.characters10);
        $("#"+form+" #nttCmtCn").focus();
        return;
    }
    var domainCd = $("#"+form+" #domainCd").val();
    var bbsCd = $("#"+form+" #bbsCd").val();
    var bbscttSeq = $("#"+form+" #bbscttSeq").val();
    var nttCmtCn = $("#"+form+" #nttCmtCn").val();

    actionType = $("#"+form+" input[name=type]").val();
    dataString = $("#"+form).serialize();
    $.ajax({
        url      : "ND_cmt.insert.do",
        type     : "POST",
        data     : dataString,
        dataType : "JSON",
        async : false,
        success  : function(response) {
            if(response == "notLogin"){
                alert(Message.msg.requiredLogin);
            }else if(response.result == true){
                alert(response.message);
                if(actionType == "INSERT") parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
                //jsReloadTab();
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            }else{
                alert(response.message);
            }
        }
    });
    
    return;
};

