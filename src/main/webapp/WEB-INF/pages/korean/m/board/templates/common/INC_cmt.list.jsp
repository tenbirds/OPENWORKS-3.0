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
            if(result > 0){
                alert('의견글이 삭제되었습니다');
//                 parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) - 1);
//                 jsOpenComment();
                //jsReloadTab();
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            } else {
                alert('의견글 삭제가 실패되었습니다.');
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
			<label for="nttCmtCn" class="none">답글작성</label>
			<input type="image" src="/resources/web/theme/default/images/btn/btn_reply.gif" alt="답글입력" onclick="jsReplyInsert('commentModifyForm');">
<!-- 			<img title="button" src="/resources/web/theme/default/images/btn/btn_comment.gif" onclick="jsReplyInsert('commentModifyForm');" alt="등록" /> -->
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
	        <label for="nttCmtCn" class="none">답글작성</label>
<!-- 	        <img title="button" src="/resources/web/theme/default/images/btn/btn_reply.gif" onclick="jsReplyInsert('commentReply');"/> -->

<!-- 	                ]');" alt="답글입력" /> -->
	                <input type="image" src="/resources/web/theme/default/images/btn/btn_reply.gif" alt="답글입력"  onclick="jsReplyInsert('commentReplyForm');">
        </div>
    </div>
    <!-- //댓글의 답글 등록 -->
    



	<!-- 댓글 -->
	<div class="reply_box">
	
	   <span class="totalcount"> 댓글 <em class="tx_orange">${pagerVo.totalNum}</em></span>
	
		<div class="comment_area">
		<!-- 댓글 리스트 -->
			<!-- 댓글 내용 -->
			<c:if test="${!empty pagerVo.list}">
				<div class="comment_list" id="commentList"  style="display: block;">
				    <ul>
						<c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status" >
							<li id="reply${status.index+1}" class="${commentVo.cmtDp ne 0? 'reply_list':''}" ><!-- reply${commentVo.cmtDp+1} 를 지웠음 ㅠㅠ ★★★-->
								<div class="cont_l">
									<strong>${commentVo.registId}</strong>
									<span class="date"> ${commentVo.registDt} <c:if test="${!empty commentVo.updtDt}">(최종수정 : ${commentVo.updtDt})</c:if></span>
									<c:if test="${commentVo.cmtDp lt 1 and boardConfVo.bbsCd  ne 1010 and commentVo.mngrDeleteAt ne 'Y'}">
										<div id="btnReply${status.index+1}" class="btn_reply block">
										  <a href="#" onclick="jsCommentReplyForm('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}','${status.index+1}');" title="답글">답글</a>
										</div>
									</c:if>
									<div id="btnReplyCancle${status.index+1}" class="btn_reply_cancle none">
                                        <a href="#" onclick="jsReplyFormRemove();" title="답글취소">답글취소</a>
									</div>
									<div id="btnModifyCancle${status.index+1}" class="btn_update_cancle none">
									  <a href="#" onclick="jsModifyFormRemove();" title="수정취소">수정취소</a>
									</div>
								</div>
								
								<div class="cont_r">
									<ul>
										<c:if test="${boardConfVo.bbsCd  eq 1010 }">
										     <li><a href="#" onclick="jsSelection('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}');" title="선정"  >선정</a></li>
										</c:if>
										<c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
											<c:if test="${boardConfVo.bbsCd  ne 1010 }">
											     <li><a href="#" onclick="jsCommentModify('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.registId}','${status.index+1}');" title="수정">수정</a></li>
											</c:if>
										         <li><a href="#" onclick="jsDeleteComment('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.refrnCmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');" title="삭제">삭제</a></li>
									    </c:if>
									</ul>
								</div>
							</li>
							<li class="comment" id="comments${status.index+1}">
								<c:choose>
									<c:when test="${commentVo.userDeleteAt eq 'Y' }">
										<c:if test="${commentVo.cmtDp != 0 }"><div class="reply">* 사용자 삭제 댓글</div></c:if>
										<c:if test="${commentVo.cmtDp == 0 }">* 사용자 삭제 댓글</c:if>
									</c:when>
									<c:when test="${commentVo.mngrDeleteAt eq 'Y' }">
										<c:if test="${commentVo.cmtDp != 0 }"><div class="reply">* 관리자 삭제 댓글</div></c:if>
										<c:if test="${commentVo.cmtDp == 0 }">* 관리자 삭제 댓글</c:if>
									</c:when>
									<c:otherwise>
										<c:if test="${commentVo.cmtDp != 0 }"><div class="reply">${commentVo.nttCmtCn}</div></c:if>
										<c:if test="${commentVo.cmtDp == 0 }">${commentVo.nttCmtCn}</c:if>
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
				         <span>등록된 댓글이 없습니다.</span>
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
					<label for="nttCmtCn" class="none">답글작성</label>
                            <input type="image" src="/resources/web/theme/default/images/btn/btn_comment.gif" alt="댓글입력" onclick="jsReplyInsert('commentForm');">
<!-- 					<img title="button" src="/resources/web/theme/default/images/btn/btn_comment.gif" onclick="jsReplyInsert('commentForm');" alt="댓글입력" /> -->
				</div>
				
		    </form>
		    <!-- //의견글등록-->
		    
		</div>
	</div>

	<!-- paging -->
	<c:if test="${!empty pagerVo.list}"><op:pager pager="${pagerVo}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" /></c:if>
	<!-- //paging -->