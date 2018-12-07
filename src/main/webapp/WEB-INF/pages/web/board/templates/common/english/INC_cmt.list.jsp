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

            $.post("ND_check.ban.do", {
                domainCd : "<c:out value='${param.domainCd}'/>",
                bbsCd : "<c:out value='${param.bbsCd}'/>",
                bbscttSeq : "<c:out value='${param.bbscttSeq}'/>",
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
        var target = $("#attachedCommentsDiv");
        if($.trim(target.text()) == "" || curpage != $("#commentForm input[name=currentPage]")) {
            $.get("INC_cmt.list.do", {
                domainCd : "<c:out value='${param.domainCd}'/>",
                bbsCd : "<c:out value='${param.bbsCd}'/>",
                bbscttSeq   : "<c:out value='${param.bbscttSeq}'/>",
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
        
        if(!confirm(Message.msg.commentAllDelete)) {
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
            if(result == "TRUE"){
                alert(Message.msg.commentDeleteOk);
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            } else {
                alert(Message.msg.commentDeleteNo);
            }
        }, 'text');
    };

    //취소 버튼 클릭시
    var jsCommentFormReset = function(){
        $("#commentForm").validate().resetForm();
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

        <div class="textarea">
            <textarea name="nttCmtCn" id="nttCmtCn" rows="3" cols="30" ></textarea>
            <label for="nttCmtCn" class="none">Response entry</label>
            <input type="image" src="/resources/web/theme/english/images/btn/btn_reply.gif" alt="Response entry" onclick="jsReplyInsert('commentModifyForm'); return false;">
<!--            <img title="button" src="/resources/web/theme/default/images/btn/btn_comment.gif" onclick="jsReplyInsert('commentModifyForm');" alt="등록" /> -->
        </div>
    </div>
    <!-- 댓글/답글 수정 -->
    
    <!-- 댓글의 답글 등록 -->
    <div id="activeCommentReply" class="none">
        <input type="hidden" name="domainCd" id="domainCd" value="" />
        <input type="hidden" name="bbsCd" id="bbsCd" value="" />
        <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
        <input type="hidden" name="cmtSeq" id="cmtSeq" value="" />
        <input type="hidden" name="cmtDp" id="cmtDp" value="" />
        <input type="hidden" name="cmtOrdrNo" id="cmtOrdrNo" value="" />
        <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
        <input type="hidden" name="currentPage" id="currentPage" value=""/>
        <input type="hidden" name="type" id="type" value="INSERT" />
        
        <div class="textarea">
            <textarea id="nttCmtCn" name="nttCmtCn" rows="3" cols="30"></textarea>
            <label for="nttCmtCn" class="none">Response entry</label>
               <input type="image" src="/resources/web/theme/english/images/btn/btn_reply.gif" alt="Response entry"  onclick="jsReplyInsert('commentReplyForm');  return false;">
        </div>
    </div>
    <!-- //댓글의 답글 등록 -->
    



    <!-- 댓글 -->
    <div class="reply_box">
    
       <span class="totalcount"> Reply <em class="tx_orange">${pagerVo.totalNum}</em></span>
    
        <div class="comment_area">
        <!-- 댓글 리스트 -->
            <!-- 댓글 내용 -->
            <c:if test="${!empty pagerVo.list}">
                <div class="comment_list" id="commentList"  style="display: block;">
                    <ul>
                        <c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status" >
                            <li id="reply${status.index+1}" class="${commentVo.cmtDp ne 0? 'reply_list':''}" ><!-- reply${commentVo.cmtDp+1} 를 지웠음 ㅠㅠ ★★★-->
                                <div class="cont_l">
                                    <strong><c:out value='${commentVo.maskRegistId}'/></strong>
                                    <span class="date"> ${commentVo.registDt} <c:if test="${!empty commentVo.updtDt}">(최종수정 : <c:out value='${commentVo.updtDt}'/>)</c:if></span>
                                    <c:if test="${commentVo.cmtDp lt 1 and boardConfVo.bbsCd  ne 1010 and commentVo.mngrDeleteAt ne 'Y'}">
                                        <c:if test="${commentVo.userDeleteAt ne 'Y' }">
                                            <div id="btnReply${status.index+1}" class="btn_reply block">
                                              <a href="#" onclick="jsCommentReplyForm('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');" title="Response">Response</a>
                                            </div>
                                        </c:if>
                                    </c:if>
                                    <div id="btnReplyCancle${status.index+1}" class="btn_reply_cancle none">
                                        <a href="#" onclick="jsReplyFormRemove();" title="Response Cancel">Response Cancel</a>
                                    </div>
                                    <div id="btnModifyCancle${status.index+1}" class="btn_update_cancle none">
                                      <a href="#" onclick="jsModifyFormRemove();" title="Edit Cancel">Edit Cancel</a>
                                    </div>
                                </div>
                                
                                <div class="cont_r">
                                    <ul>
                                        <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
                                            <c:if test="${commentVo.userDeleteAt ne 'Y'}"> 
                                                <c:if test="${boardConfVo.bbsCd  ne 1010 }"> 
                                                     <li><a href="#" onclick="jsCommentModify('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');" title="Edit">Edit</a></li>
                                                </c:if>
                                                     <li><a href="#" onclick="jsDeleteComment('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');" title="Delete">Delete</a></li>
                                            </c:if>
                                        </c:if>
                                    </ul>
                                </div>
                            </li>
                            <li class="comment" id="comments${status.index+1}">
                                <c:choose>
                                    <c:when test="${commentVo.userDeleteAt eq 'Y' }">
                                        <c:if test="${commentVo.cmtDp != 0 }"><div class="reply">* Reply deleted by user</div></c:if>
                                        <c:if test="${commentVo.cmtDp == 0 }">* Reply deleted by user</c:if>
                                    </c:when>
                                    <c:when test="${commentVo.mngrDeleteAt eq 'Y' }">
                                        <c:if test="${commentVo.cmtDp != 0 }"><div class="reply">* Reply deleted by administrator</div></c:if>
                                        <c:if test="${commentVo.cmtDp == 0 }">* Reply deleted by administrator</c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${commentVo.cmtDp != 0 }"><div class="reply"><op:nrToBr content='${commentVo.nttCmtCn}'/></div></c:if>
                                        <c:if test="${commentVo.cmtDp == 0 }"><op:nrToBr content='${commentVo.nttCmtCn}'/></c:if>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            
                            <!-- 댓글/답글 수정 -->
                            <li class="replyUp none" id="commentModifyForm${status.index+1}" ></li>
                            <!-- 댓글/답글 수정 -->
                            <!-- 댓글의 답글 등록 -->
                            <li class="reply none" id="activeCommentReply${status.index+1}" ></li>
                            <!-- //댓글의 답글 등록 -->
                        
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <c:if test="${empty pagerVo.list}">
                <div class="comment_list" >
                    <ul>
                     <li class="comment">
<!--                          <span>등록된 댓글이 없습니다.</span> -->
                     </li>
                    </ul>
                </div>
            </c:if>
          <!-- //의견글내용-->
        
            <!-- 의견글등록-->
            <form id="commentForm" action="ND_cmt.insert.do" method="post" onSubmit="return false">
                <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
                <input type="hidden" name="bbsCd" id="bbsCd" value="<c:out value='${param.bbsCd}'/>" />
                <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='${param.bbscttSeq}'/>" />
                <input type="hidden" name="cmtSeq" id="cmtSeq" value="<c:out value='0'/>"/>
                <input type="hidden" name="currentPage" id="currentPage" value="<c:out value='${param.currentPage}'/>" />
                <input type="hidden" name="type" id="type" value="<c:out value='INSERT'/>"/>
                
                <div class="textarea">
                    <textarea name="nttCmtCn" id="nttCmtCn" rows="3" cols="30"></textarea>
                    <label for="nttCmtCn" class="none">Reply entry</label>
                        <input type="image" src="/resources/web/theme/english/images/btn/btn_comment.gif" alt="Reply entry" onclick="jsReplyInsert('commentForm');  return false;">
<!--                    <img title="button" src="/resources/web/theme/default/images/btn/btn_comment.gif" onclick="jsReplyInsert('commentForm');" alt="댓글입력" /> -->
                </div>
                
            </form>
            <!-- //의견글등록-->
            
        </div>
    </div>

    <!-- paging -->
    <c:if test="${!empty pagerVo.list}"><op:pager pager="${pagerVo}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" /></c:if>
    <!-- //paging -->