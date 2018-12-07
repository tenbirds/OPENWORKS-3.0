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
	            if(result == "TRUE"){
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
	                alert('의견글 삭제가 실패되었습니다.');
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
    <div id="commentReplyModify" style="display:none;">
        <div class="reply-area">
            <div class="reply">
                <input type="hidden" name="domainCd" id="domainCd" value="" />
                <input type="hidden" name="bbsCd" id="bbsCd" value="" />
                <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
                <input type="hidden" name="cmtSeq" id="cmtSeq" value="" />
                <input type="hidden" name="cmtDp" id="cmtDp" value="" />
                <input type="hidden" name="cmtOrdrNo" id="cmtOrdrNo" value="" />
                <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
                <input type="hidden" name="currentPage" id="currentPage" value=""/>
                <input type="hidden" name="type" id="type" value="UPDATE" />
                <textarea name="nttCmtCn" id="nttCmtCn"></textarea><a href="#" class="btn-enter" onclick="jsReplyInsert('commentModifyForm'); return false;">댓글 수정</a>
            </div>
        </div>
    </div>
    <!-- 댓글/답글 수정 -->

    <!-- 댓글의 답글 등록 -->
    <div id="activeCommentReply" style="display:none;">
        <div class="reply-area">
            <div class="reply">
                <input type="hidden" name="domainCd" id="domainCd" value="" />
                <input type="hidden" name="bbsCd" id="bbsCd" value="" />
                <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="" />
                <input type="hidden" name="cmtSeq" id="cmtSeq" value="" />
                <input type="hidden" name="cmtDp" id="cmtDp" value="" />
                <input type="hidden" name="cmtOrdrNo" id="cmtOrdrNo" value="" />
                <input type="hidden" name="refrnCmtSeq" id="refrnCmtSeq" value="" />
                <input type="hidden" name="currentPage" id="currentPage" value=""/>
                <input type="hidden" name="type" id="type" value="INSERT" />
                <textarea name="nttCmtCn" id="nttCmtCn"></textarea><a href="#" class="btn-enter" onclick="jsReplyInsert('commentReplyForm');  return false;">답글 입력</a>
            </div>
        </div>
    </div>
    <!-- //댓글의 답글 등록 -->

	<!-- 댓글 -->
   	<div class="reply-wrap">
		<p>댓글 <span>${pagerVo.totalNum}</span></p>

        <!-- 기등록 댓글 목록 영역 -->
		<div class="reply-area">
			<c:if test="${!empty pagerVo.list}">
				<div class="section pt10" id="commentList"  style="display: block;">
				    <ul>
						<c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status" >
							<li id="reply${status.index+1}" class="${commentVo.cmtDp ne 0? 're':''}" >
							    <strong>
							        <!-- 댓글 등록자 -->
								    <c:out value='${commentVo.maskRegistId}'/>
								    							
     							    <!-- 등록일자/최종수정일자 -->
								    <span class="ml10 caption">${commentVo.registDt} <c:if test="${!empty commentVo.updtDt}">(최종수정 : <c:out value='${commentVo.updtDt}'/>)</c:if></span>
								
								    <!-- 답글 버튼 -->
								    <c:if test="${commentVo.cmtDp lt 1 and boardConfVo.bbsCd  ne 1010 and commentVo.mngrDeleteAt ne 'Y'}">
									    <c:if test="${commentVo.userDeleteAt ne 'Y' }">
										 <%--    <span id="btnReply${status.index+1}">
										    <a href="#" class="s-btn ml10 type1" onclick="jsCommentReplyForm('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');"><strong><span>답글</span></strong></a>
										    </span> --%>										    
									    </c:if>
								    </c:if>
								
                                    <!-- 답글취소 버튼 -->
								    <span id="btnReplyCancle${status.index+1}" style="display:none;">
                                        <a href="#" class="s-btn ml20 type1" onclick="jsReplyFormRemove2('<c:out value='${status.index+1}'/>');" title="답글취소">답글취소</a>
								    </span>

                                    <!-- 선정 버튼 -->
									<c:if test="${boardConfVo.bbsCd  eq 1010 }">
									    <a href="#" class="s-btn ml20 type1" onclick="jsSelection('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}');" title="선정"  >선정</a>
									</c:if>
							    </strong>
							    
							    <!-- 글 등록 정보 -->
                                <span class="caption" id="comments${status.index+1}">
								    <c:choose>
									    <c:when test="${commentVo.userDeleteAt eq 'Y' }">
										* 사용자 삭제 댓글
									    </c:when>
									    <c:when test="${commentVo.mngrDeleteAt eq 'Y' }">
										* 관리자 삭제 댓글
									    </c:when>
									    <c:otherwise>
										    <op:nrToBr content='${commentVo.nttCmtCn}'/>
									    </c:otherwise>
								    </c:choose>
								</span>

                                <!-- 수정/삭제 버튼 -->
								<div class="fr">
									<c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
										<c:if test="${commentVo.userDeleteAt ne 'Y'}">
											<c:if test="${boardConfVo.bbsCd  ne 1010 }">
								                <!-- 수정취소 버튼 -->
								                <span id="btnModifyCancle${status.index+1}" style="display:none;">
									                [<a href="#" onclick="jsModifyFormRemove2('<c:out value='${status.index+1}'/>');" title="수정취소">수정취소</a>]
								                </span>
								                <!-- 수정 버튼 -->
											    <span id="btnModify${status.index+1}">
											       [<a href="#"  onclick="jsCommentModify('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');" title="수정">수정</a>]
											    </span>
											</c:if>
										 	      [<a href="#"  onclick="jsDeleteComment('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.registId}'/>','<c:out value='${status.index+1}'/>');" title="삭제">삭제</a>]
									    </c:if>
									</c:if>
								</div>
								<!-- //글 등록 정보 -->

                            </li>
                            


							<!-- 댓글/답글 수정 -->
							<li id="commentModifyForm${status.index+1}" style="display:none;"></li>
							<!-- 댓글/답글 수정 -->
							
							<!-- 댓글의 답글 등록 -->
							<li id="activeCommentReply${status.index+1}" style="display:none;"></li>
							<!-- //댓글의 답글 등록 -->
						</c:forEach>

				    </ul>
				</div>
			</c:if>
		    
		</div>
		<!-- //기등록 댓글 목록 영역 -->
		




	    <!-- 댓글 입력란 -->	
		<div class="reply-area">
			<div class="reply">
		        <form id="commentForm" action="ND_cmt.insert.do" method="post" onSubmit="return false">
		            <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>" />
		            <input type="hidden" name="bbsCd" id="bbsCd" value="<c:out value='${param.bbsCd}'/>" />
		            <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='${param.bbscttSeq}'/>" />
		            <input type="hidden" name="cmtSeq" id="cmtSeq" value="<c:out value='0'/>"/>
		            <input type="hidden" name="currentPage" id="currentPage" value="<c:out value='${param.currentPage}'/>" />
		            <input type="hidden" name="type" id="type" value="<c:out value='INSERT'/>"/>
				    <textarea name="nttCmtCn" id="nttCmtCn"></textarea><a href="#" class="btn-enter" onclick="jsReplyInsert('commentForm');  return false;">댓글 입력</a>
		        </form>
			</div>
		</div>
		<!-- //댓글 입력란 -->



	</div>


	<!-- paging -->
	<c:if test="${!empty pagerVo.list}"><op:pager pager="${pagerVo}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" /></c:if>
	<!-- //paging -->