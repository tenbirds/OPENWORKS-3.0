<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">
    $().ready(function(){

    });
    
    var jsCommentModifyAction = function(seq) {
        var commentSubmitHandler = function(form){
            var _contents = new String($.trim($("#nttCmtCn").val()));
            if(_contents == '' || _contents.length < 0 || _contents.length > 500){
                alert("내용을 확인하세요.(최대 500글자)");
                $("#nttCmtCn")[0].focus();
                return false;
            }

            $.post("ND_check.ban.do", {
                domainCd : "${param.domainCd}",
                bbsCd : "${param.bbsCd}",
                bbscttSeq : "${param.bbscttSeq}",
                contents : $("#commentReplyModifyForm #nttCmtCn").val()
            }, function(result){
                if(result.result == true){
                    //var msg = result.message.replace("\n\n", "<br />");
                    //jsWarningBox(msg);
                    alert(result.message);
                    return;
                }else{
                    actionType = $("input[name=type]").val();
                    dataString = $("#commentReplyModifyForm"+seq).serialize();
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
        };
    };

    //댓글 페이지 번호이벤트 함수
    var jsCmtPageMove = function(curpage) {
        /*var bbsCd =  "${param.bbsCd}";
        var bbscttSeq = "${param.bbscttSeq}";
        var url = "INC_cmt.list.do?bbsCd=" + bbsCd + "&bbscttSeq=" + bbscttSeq + "&q_currPage=" + curpage;
        if(cmtTabz){
            var selectedIndex = cmtTabz.tabs("option", "selected");
            cmtTabz.tabs("url", selectedIndex, url);
            cmtTabz.tabs("load", selectedIndex);
        }*/
        var target = $("#attachedCommentsDiv");
        if($.trim(target.text()) == "" || curpage != $("#commentForm input[name=currentPage]")) {
            $.get("INC_cmt.list.do", {
                domainCd : "${param.domainCd}",
                bbsCd : "${param.bbsCd}",
                bbscttSeq   : "${param.bbscttSeq}",
                q_currPage : curpage
            },
            function(result){
                target.empty();
                target.append(result);
            });
        }
    };

    //댓글 완전 삭제 클릭 시
    var jsDeleteComment = function(domainCd, bbsCd, bbscttSeq, cmtSeq, refrnCmtSeq, mid, uid) {
        
        if(!confirm("의견글을 완전 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다.")) {
            return;
        }

        $.post("ND_comment.delete.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            refrnCmtSeq : refrnCmtSeq,
            mngrId : mid,
            registId : uid
        }, function(result){
            if("TRUE" == result){
                alert('의견글이 삭제되었습니다');
                parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) - 1);
                jsOpenComment();
                //jsReloadTab();
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            } else {
                alert(result);
            }
        }, 'text');
    };

    //댓글 플래그 삭제 클릭 시
    var jsFlagDeleteComment = function(domainCd, bbsCd, bbscttSeq, cmtSeq, mid, uid, refrnCmtSeq){
        if(!confirm("의견글을 삭제하시겠습니까?\n삭제 후 사용자화면에서 관리자 삭제글로 표시됩니다.")) return;

        $.post("ND_comment.flag.delete.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            mngrId : mid,
            registId : uid,
            refrnCmtSeq : refrnCmtSeq
        }, function(result){
            if(result == 1){
                alert('의견글이 삭제되었습니다');
                //parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) - 1);
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            }else{
                jsWarningBox(result);
            }
        }, 'json');
    };

    //취소 버튼 클릭시
    var jsCommentFormReset = function(){
        $("#commentForm").validate().resetForm();
        //$("#commentForm input[name=registerNm]").attr("readonly", "");
        $("#btnCancel").hide();
    };

    var jsReloadTab = function(){
        if(cmtTabz){
            var selectedIndex = cmtTabz.tabs("option", "selected");
            cmtTabz.tabs("load", selectedIndex);
        }
    };
    
</script>
<!-- 사용자 스크립트 끝 -->

<h4 class="tx_13 mar_t10">댓글 : <span id="cmtCnt" class="tx_orange_u">${pagerVo.totalNum}</span>개</h4>

<!-- 비즈매칭은 등록을 하지않음-->
<c:if test="${boardConfVo.bbsCd  ne 1010 }">
	<!-- 의견글등록-->
	<form id="commentForm" action="ND_cmt.insert.do" method="post">
	    <input type="hidden" name="domainCd" id="domainCd" value="${param.domainCd}" />
	    <input type="hidden" name="bbsCd" id="bbsCd" value="${param.bbsCd}" />
	    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="${param.bbscttSeq}" />
	    <input type="hidden" name="cmtSeq" id="cmtSeq" value="0" />
	    <input type="hidden" name="currentPage" id="currentPage" value="${param.currentPage}" />
	    <input type="hidden" name="type" id="type" value="INSERT" />
	    
	    <fieldset>
	        <legend>댓글입력영역</legend>
	        <div class="comment_wrap">
	            <div class="titbox">
	                <strong>
	                    (<span id="commentLength" class="tx_orange_b">0</span>/500자)&nbsp;&nbsp;
	                    <button type="button" id="btnCancel" class="gray none" onclick="jsCommentFormReset();">취소</button>
	                </strong>
	            </div>
	            <div class="wrtbox">
	                <label class="skip" for="nttCmtCn">댓글작성</label>
	                <textarea name="nttCmtCn" id="nttCmtCn" rows="3" cols="30"></textarea>
	                <a href="#" onclick="jsReplyInsert('commentForm');" title="등록">
	                    <img src="/resources/openworks/theme/default/images/btn/btn_comment_new.gif" class="btn_comment" alt="등록" class="vm" />
	                </a>
	            </div>
	        </div>
	    </fieldset>
	</form>
	<!-- //의견글등록-->
	
	<!-- 댓글/답글 수정 -->
	<div id="commentReplyModify" class="none">
	    <input type="hidden" name="domainCd" id="domainCd" value="" />
	    <input type="hidden" name="bbsCd" id="bbsCd" value="" />
	    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
	    <input type="hidden" name="cmtSeq" id="cmtSeq" value="" />
	    <input type="hidden" name="cmtDp" id="cmtDp" value="" />
	    <input type="hidden" name="cmtOrdrNo" id="cmtOrdrNo" value="" />
	    <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
	    <input type="hidden" name="currentPage" id="currentPage" value=""/>
	    <input type="hidden" name="type" id="type" value="UPDATE" />
	    </br>
	    <fieldset>
	        <legend>답글 글입력 영역</legend>
	        <div class="wrtbox">
	            <label class="skip" for="nttCmtCn">답글작성</label>
	            <textarea name="nttCmtCn" id="nttCmtCn" rows="3" cols="30">${commentVo.nttCmtCn}</textarea>
	            <a href="#" onclick="jsReplyInsert('commentModifyForm');" title="등록">
	                <img src="/resources/openworks/theme/default/images/btn/btn_comment_new.gif" class="btn_comment" alt="등록" class="vm" />
	            </a>
	        </div>
	    </fieldset>
	    </br>
	</div>
	<!-- 댓글/답글 수정 -->
	
	<!-- 댓글의 답글 등록 -->
	<div id="activeCommentReply" class="replyWrap none">
	    <input type="hidden" name="domainCd" id="domainCd" value="" />
	    <input type="hidden" name="bbsCd" id="bbsCd" value="" />
	    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
	    <input type="hidden" name="cmtSeq" id="cmtSeq" value="" />
	    <input type="hidden" name="cmtDp" id="cmtDp" value="" />
	    <input type="hidden" name="cmtOrdrNo" id="cmtOrdrNo" value="" />
	    <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
	    <input type="hidden" name="currentPage" id="currentPage" value=""/>
	    <input type="hidden" name="type" id="type" value="INSERT" />
	    <fieldset>
	        <legend>답글 글입력 영역</legend>
	        <div class="comment_wrap">
	            <div class="info">
	                <strong>${commentVo.registerNm}</strong>
	                <a href="#" onclick="jsReplyFormRemove();" class="a" title="답글취소"><img src="/resources/openworks/theme/default/images/btn/btn_reply_cancel_new.gif" alt="답글 취소" class="vm" /></a>
	            </div>
	        </div>
	        <div class="wrtbox">
	            <label class="skip" for="nttCmtCn">답글작성</label>
	            <textarea id="nttCmtCn" name="nttCmtCn" rows="3" cols="30"></textarea>
	            <a href="#" onclick="jsReplyInsert('commentReplyForm');" title="등록">
	                <img src="/resources/openworks/theme/default/images/btn/btn_comment_new.gif" class="btn_comment" alt="등록" class="vm" />
	            </a>
	        </div>
	    </fieldset>
	</div>
	<!-- //댓글의 답글 등록 -->
</c:if>


<!-- 의견글내용-->
<c:if test="${!empty pagerVo.list}">
<div id="commentList" class="comment">
<c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status" >
    <div id="reply${status.index+1}" class="reply${commentVo.cmtDp+1}">
        <div class="inner">
            <div class="info">
                <c:if test="${!empty commentVo.iconKey}"><img src="/resources/openworks/theme/default/images/icon/${commentVo.iconKey}.gif" alt="웃음" class="vm"/></c:if>
                    <strong>${commentVo.registerNm}</strong>
                    <span>${commentVo.registDt} <c:if test="${!empty commentVo.updtDt}">(최종수정 : ${commentVo.updtDt})</c:if></span>
                <c:if test="${commentVo.cmtDp lt 1 and boardConfVo.bbsCd  ne 1010}">
                    <div id="btnReply${status.index+1}" class="block">
                        <a href="#" onclick="jsCommentReplyForm('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}','${status.index+1}');" title="답글">
                        <img src="/resources/openworks/theme/default/images/btn/btn_reply_new.gif" alt="답글" class="vm" /></a>
                    </div>
                </c:if>
                <div id="btnReplyCancle${status.index+1}" class="none">
                    <a href="#" onclick="jsReplyFormRemove();" title="답글취소"><img src="/resources/openworks/theme/default/images/btn/btn_reply_cancel_new.gif" alt="답글취소" class="vm" /></a>
                </div>
                <div id="btnModifyCancle${status.index+1}" class="none">
                    <a href="#" onclick="jsModifyFormRemove();" title="수정취소"><img src="/resources/openworks/theme/default/images/btn/btn_modify_cancel_new.gif" alt="수정취소" class="vm" /></a>
                </div>
                
                <c:if test="${commentVo.mngrDeleteAt eq 'Y'}">
                    <div class="tx_orange_u mar_b10">* 관리자 삭제 댓글</div>
                </c:if>
                <c:if test="${commentVo.userDeleteAt eq 'Y'}">
                    <div class="tx_orange_u mar_b10">* 사용자 삭제 댓글</div>
                </c:if>
            </div>
            <div class="etc">
<%--                 <a href="#" onclick="jsSelection('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}');" title="선정"  >선정</a> --%>
                <c:if test="${commentVo.bbsCd ne 1010}">
                    <a href="#" onclick="jsCommentModify('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}','${status.index+1}');" title="수정"><img src="/resources/openworks/theme/default/images/btn/btn_modify_new.gif" alt="수정" class="vm" /></a>
                </c:if>
                <a href="#" onclick="jsFlagDeleteComment('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}' , '${commentVo.refrnCmtSeq}');" title="플래그삭제"><img src="/resources/openworks/theme/default/images/btn/btn_del_p_new.gif" alt="플래그삭제" class="vm" /></a>
                <a href="#" onclick="jsDeleteComment('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.refrnCmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');" title="완전삭제"><img src="/resources/openworks/theme/default/images/btn/btn_del_new.gif" alt="완전삭제" class="vm" /></a>
            </div>
        </div>
        <p id="textBox${status.index+1}" class="txtbox block <c:if test="${commentVo.userDeleteAt eq 'Y'}">tx_gray_u</c:if> <c:if test="${commentVo.mngrDeleteAt eq 'Y'}">tx_gray_u</c:if>"><c:out value="${commentVo.nttCmtCn}" /></p>
        <!-- 댓글/답글 수정 -->
        <div id="commentModifyForm${status.index+1}" class="none"></div>
        <!-- 댓글/답글 수정 -->
        <!-- 댓글의 답글 등록 -->
        <div id="activeCommentReply${status.index+1}" class="replyWrap none"></div>
        <!-- //댓글의 답글 등록 -->
    </div>
</c:forEach>
</div>
</c:if>
<c:if test="${empty pagerVo.list}">
    <div class="comment_area">
        <ul>
            <li class="tx_c mar_t5">        
                <span>등록된 댓글이 없습니다.</span>
            </li>
        </ul>
    </div>
</c:if>
<!-- //의견글내용-->

<!-- paging -->
<c:if test="${!empty pagerVo.list}"><op:pager pager="${pagerVo}" page="pager/mgrCmtPager.jsp" script="jsCmtPageMove" /></c:if>
<!-- //paging -->