<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">
$().ready(function(){
    var commentSubmitHandler = function(form){
        var _contents = new String($.trim($("#nttCmtCn").val()));
        if(_contents == '' || _contents.length < 0 || _contents.length > 500){
            alert("내용을 확인하세요.(최대 500글자)");
            $("#nttCmtCn")[0].focus();
            return false;
        }

        //수정일때 비공개인경우
        if($("#commentForm input[name=type]").val() == "UPDATE"){
            $("#commentForm input[name=bizMatchingOthbcAt]").val("Y");
        }

        $.post("ND_check.ban.do", {
            domainCd : "${param.domainCd}",
            bbsCd : "${param.bbsCd}",
            bbscttSj : "${param.bbscttSj}",
            nttCmtCn : $("#nttCmtCn").val()
        }, function(result){
            if(result.result == true){
                //var msg = result.message.replace("\n\n", "<br />");
                alert(result.message);
                return;
            }else{
                actionType = $("input[name=type]").val();
                dataString = $("#commentForm").serialize();
                $.ajax({
                    url      : "ND_cmt.insert.do",
                    type     : "POST",
                    data     : dataString,
                    dataType : "json",
                    success  : function(response){
                        alert(response.message);
                        if(actionType == "INSERT") parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
                        jsCmtPageMove($("#commentForm input[name=currentPage]").val());
                        location.reload();
                    }
                });
            }
        }, "json");
    };

    //commentForm 유효성 체크
    $("#commentForm").validate({
        errorClass: "error",
        rules : {
            nttCmtCn : { required : true, maxlength : 500 },
            bizMatchingCmpnyNm : { required : true, maxlength : 50 },
            bizMatchingCttpc : { required : true, maxlength : 20 },
            bizMatchingEmail : { required : true, maxlength : 50 ,  email:true },
        },
        submitHandler: commentSubmitHandler
    });

    //커멘트 글자수 표시 및 길이 제한 - 파폭, ie에서 keyup이벤트가 다르게 적용됨...!!!
    $("#nttCmtCn").keyup(function(){
        var str = new String($("#nttCmtCn").val());
        var length = str.length;
        if(length > 500){
            alert("작성글은 최대 500자 입니다.");
            $("#nttCmtCn")[0].focus();
        } 
        $("#nttCmtCnLength").text(length);
        return false;
    });             

});
    
    //선정 버튼 클릭시
	var jsSelection = function(domainCd, bbsCd, bbscttSeq, cmtSeq) {
	    
	    if(!confirm("선정은 한번만 가능하며 변경은 불가능합니다. 선택한 댓글을 선정하시겠습니까? "))
	        return false;
	    
	    var estnColumn5 = "Y_"+cmtSeq;
	    
	    $.post("ND_selectionUpdate.do", {
	        domainCd : domainCd,
	        bbsCd : bbsCd,
	        bbscttSeq : bbscttSeq,
	        cmtSeq : cmtSeq,
	        estnColumn5 : estnColumn5
	    },
	    function(result) {
	        if(result.result == true) {
	            alert("매칭선정 되었습니다.");
	            location.reload();
	        } else {
	            alert("매칭선정 실패하였습니다.");
	        }
	    }, 'json');
	}
	
//댓글 수정 클릭 시  
var jsModifyCommentAction = function(domainCd, bbsCd, bbscttSeq, cmtSeq, mid, uid){
    $.post("ND_comment.update.form.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            mngrId : mid,
            updtId : uid
        },
        function(result){
            
            if(result.result == true){
                $("#commentForm input[name=bbsCd]").val(result.value.bbsCd);
                $("#commentForm input[name=bbscttSeq]").val(result.value.bbscttSeq);
                $("#commentForm input[name=cmtSeq]").val(result.value.cmtSeq);
                $("#commentForm textarea[name=nttCmtCn]").val(result.value.nttCmtCn);
                $("#commentForm input[name=bizMatchingCmpnyNm]").val(result.value.bizMatchingCmpnyNm);
                $("#commentForm input[name=bizMatchingCttpc]").val(result.value.bizMatchingCttpc);
                $("#commentForm input[name=bizMatchingEmail]").val(result.value.bizMatchingEmail);
                if(result.value.bizMatchingOthbcAt == "Y"){
                    $("#commentForm input[name=bizMatchingOthbcAt]").attr("checked", true);
                }
//                 $("#commentForm input[name=userKey]").val(result.value.userKey);
//                 $("#commentForm input[name=mgrId]").val(result.value.mgrId);
//                 $("#commentForm input[name=regNm]").val(result.value.regNm);
                $("#commentForm input[name=type]").val("UPDATE");
//                 $("#commentForm input:radio[name=iconKey][value='" + result.value.iconKey + "']").attr("checked","'checked'");
//                 $("#commentForm select[name=score]").val(result.value.score);
                $("#commentForm input[name=currentPage]").val(result.value.currentPage);
                $("#commentForm textarea[name=nttCmtCn]").focus();
                //$("#commentForm input[name=regNm]").attr("readonly", "readonly");
                $("#nttCmtCnLength").text($("#nttCmtCn").val().length);
                window.scrollTo(1, $("#commentForm").position().top);
                $("#btnCancel").show();
                
            }else{
                jsWarningBox(result.message);
            }
        }, 'json');
};

    //댓글 페이지 번호이벤트 함수
    var jsCmtPageMove = function(curpage) {
        var target = $("#attachedCommentsDiv2");
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
    var jsDeleteCommentAction = function(domainCd, bbsCd, bbscttSeq, cmtSeq, refrnCmtSeq, uid) {
        
        if(!confirm("의견글을 완전 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다.")) {
            return;
        }

        $.post("ND_comment.delete.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            refrnCmtSeq : refrnCmtSeq,
            registId : uid
        }, function(result){
            if(result > 0){
                alert('의견글이 삭제되었습니다');
                window.scrollTo(1, $("#commentForm").position().top);
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
//                 parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) - 1);
//                 jsOpenComment();
                //jsReloadTab();
                location.reload();
            } else {
                alert('의견글 삭제가 실패되었습니다.');
            }
        }, 'text');
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
   <!-- 의견글등록-->
   <c:if test="${cmtBoardVo.bizProgression eq 'PRO'}">
        <form id="commentForm" name="commentForm" action="ND_cmt.insert.do" method="post">
	        <input type="hidden" name="domainCd" value="${param.domainCd}" />
	        <input type="hidden" name="bbsCd" value="${param.bbsCd}" />
	        <input type="hidden" name="bbscttSeq" value="${param.bbscttSeq}" />
	        <input type="hidden" name="cmtSeq" value="0" />
	        <input type="hidden" name="currentPage" value="${param.currentPage}" />
	        <input type="hidden" name="type" value="INSERT" />
	
	        <table class="tbl_view borb_n">
		        <colgroup>
		            <col style="width:10%">
		            <col style="width:23%">
		            <col style="width:10%">
		            <col style="width:23%">
		            <col style="width:*">
		            <col style="width:23%">
		        </colgroup>
		        <tbody>
		            <tr>
		                <td class="tit"><label for="bizMatchingCmpnyNm">회사명</label></td>
		                <td>
		                    <input type="text" id="bizMatchingCmpnyNm" name="bizMatchingCmpnyNm" title="회사명 입력" value="" class="input" style="width:170px;">
		                </td>
		                <td class="tit"><label for="bizMatchingCttpc">연락처</label></td>
		                <td>
		                    <input type="text" id="bizMatchingCttpc" name="bizMatchingCttpc" title="연락처 입력" value="" class="input" style="width:170px;" maxlength="20">
		                </td>
		                <td class="tit"><label for="bizMatchingEmail">이메일</label></td>
		                <td class="last">
		                    <input type="text" id="bizMatchingEmail" name="bizMatchingEmail" title="이메일 입력" value="" class="input" style="width:170px;">
		                </td>
		            </tr>
		            <tr>
		                <td colspan="6" class="last">
		                    <div class="cont_wrap">
		                        <textarea id="nttCmtCn" name="nttCmtCn" cols="72" rows="50" style="width:877px; height:62px;" title="내용 입력"></textarea>
		                        <input type="submit" title="등록" class="btn_register">
		                    </div>
		                    <div class="check">
		                        <input type="checkbox" id="bizMatchingOthbcAt" name="bizMatchingOthbcAt" class="rach" value="Y" > <label for="closed">공개</label>
		                    </div>
		                </td>
		            </tr>
		        </tbody>
		    </table>
        </form>
    </c:if>
    <!-- //의견글등록-->

    <!-- 의견글내용-->
    <c:if test="${!empty pagerVo.list}">
        <c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status">
	        <table class="tbl_comment margin">
		        <colgroup>
		            <col style="width:60%">
		            <col style="width:25%">
		            <col style="width:*">
		        </colgroup>
		        <tbody>
		            <tr>
		                <c:choose>
		                    <c:when test="${commentVo.mngrDeleteAt eq 'Y'}">
		                    <!-- 관리자 삭제댓글 -->
		                    <td class="txt" colspan="2"> 관리자에 의해 삭제되었습니다. </td><td></td>
		                    </c:when>
		                    <c:when test="${commentVo.bizMatchingOthbcAt eq 'N' and (!empty __usk.userKey && (__usk.userKey eq commentVo.userKey or __usk.userKey eq cmtBoardVo.userKey ))}">
                            <!-- 비공개인경우(댓글작성자 또는 글등록자 인경우)-->
                                <td class="txt">
                                    <div clas="con">${commentVo.nttCmtCn}</div>
                                    <div class="c_date">${commentVo.registDt}</div>
                                    <div class="modify_del">
                                        <c:if test="${empty cmtBoardVo.bizCmtSeq and commentVo.mngrDeleteAt != 'Y'}">
                                           <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
                                                <span><a href="#" onclick="jsModifyCommentAction('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');">수정</a></span>
                                                <span><a href="#" onclick="jsDeleteCommentAction('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');">삭제</a></span>
                                           </c:if>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <ul>
                                        <li class="company"><span class="tit">회사명</span>${commentVo.bizMatchingCmpnyNm}</li>
                                        <li class="address"><span class="tit">연락처</span>${commentVo.bizMatchingCttpc}</li>
                                        <li class="id"><span class="tit">이메일</span>${commentVo.bizMatchingEmail}</li>
                                    </ul>
                                </td>
                                <td>
	                                <c:if test ="${!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey}"> 
	                                    <c:if test ="${empty cmtBoardVo.bizCmtSeq}"> 
	                                        <div class="btn_b_round" onclick="jsSelection('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}');" ><a href="#">선정</a></div>
	                                    </c:if>
	                                    <c:if test ="${!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq}">
	                                        <div class="btn_b_round" >선정${empty cmtBoardVo.bizCmtSeq? '' :'완료'}</div>
	                                    </c:if>
                                    </c:if>
                                </td>
                            </c:when>
                            <c:when test="${commentVo.bizMatchingOthbcAt eq 'N' and (!empty __usk.userKey && (__usk.userKey ne commentVo.userKey and __usk.userKey ne cmtBoardVo.userKey ) )  }">
                            <!-- 비공개인경우(댓글작성자와 글등록자가 아닌경우) -->
                                <td class="txt" colspan="3">
                                    <div clas="con"> <strong>비공개 글입니다.</strong></div>
                                </td>
                                <td>
                                </td>
                            </c:when>
                            
                            <c:when test="${commentVo.bizMatchingOthbcAt eq 'Y' and commentVo.mngrDeleteAt eq 'N'}">
                            <!-- 비공개가 아니며 관리자 삭제댓글이 아닌경우(공개일때) -->
                                <td class="txt">
                                    <div clas="con">${commentVo.nttCmtCn}</div>
                                    <div class="c_date">${commentVo.registDt}</div>
                                    <div class="modify_del">
                                        <c:if test="${empty cmtBoardVo.bizCmtSeq and commentVo.mngrDeleteAt != 'Y'}">
                                           <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
                                                <span><a href="#" onclick="jsModifyCommentAction('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');">수정</a></span>
                                                <span><a href="#" onclick="jsDeleteCommentAction('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}', '${commentVo.mngrId}', '${commentVo.registId}');">삭제</a></span>
                                           </c:if>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
                                    <!-- 공개이지만 본인의 글인경우 -->
	                                    <ul> 
	                                        <li class="company"><span class="tit">회사명</span>${commentVo.bizMatchingCmpnyNm}</li>
	                                        <li class="address"><span class="tit">연락처</span>${commentVo.bizMatchingCttpc}</li>
	                                        <li class="id"><span class="tit">이메일</span>${commentVo.bizMatchingEmail}</li>
	                                    </ul>
                                    </c:if>
                                    <c:if test="${!empty __usk.userKey && __usk.userKey ne commentVo.userKey}">
                                    <!-- 공개이지만 본인의 글이 아닌 경우 -->
		                                <c:set var="CmpnyNm" value="${fn:length(commentVo.bizMatchingCmpnyNm)-3}"/>
		                                <c:set var="Cttpc" value="${fn:length(commentVo.bizMatchingCttpc)-3}"/>
		                                <c:set var="Email" value="${fn:length(commentVo.bizMatchingEmail)-3}"/>
	                                    <ul> 
	                                        <li class="company"><span class="tit">회사명</span>${fn:substring(commentVo.bizMatchingCmpnyNm,0,CmpnyNm)}***</li>
	                                        <li class="address"><span class="tit">연락처</span>${fn:substring(commentVo.bizMatchingCttpc,0,Cttpc)}***</li>
	                                        <li class="id"><span class="tit">이메일</span>${fn:substring(commentVo.bizMatchingEmail,0,Email)}***</li>
	                                    </ul>
                                    
                                    </c:if>
                                </td>
                                <td>
	                                <c:if test ="${!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey}">
		                                <c:if test ="${empty cmtBoardVo.bizCmtSeq}"> 
		                                    <div class="btn_b_round" onclick="jsSelection('${commentVo.domainCd}','${commentVo.bbsCd}', '${commentVo.bbscttSeq}', '${commentVo.cmtSeq}');" ><a href="#">선정</a></div>
		                                </c:if>
		                                <c:if test ="${!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq}">
		                                    <div class="btn_b_round" >선정${empty cmtBoardVo.bizCmtSeq? '' :'완료'}</div>
		                                </c:if>
	                                </c:if>
                                </td>
                            </c:when>
		                        
		                </c:choose>
		            </tr>
		        </tbody>
		    </table>
        </c:forEach>
    </c:if>
    
	<c:if test="${commentVo.mngrDeleteAt eq 'Y'}">  관리자에 의해 삭제되었습니다.  </c:if>
	<c:if test="${empty pagerVo.list}">
		<table class="tbl_comment margin">
		    <colgroup>
		        <col style="width:60%">
		        <col style="width:25%">
		        <col style="width:*">
		    </colgroup>
		    <tbody>
		        <tr>
		            <td class="txt" colspan="2"> <strong>등록된 댓글이 없습니다. </strong></td>
		            <td></td>
		        </tr>
		    </tbody>
		</table>
	</c:if>

               
               
               
    <!-- //의견글내용-->
	<!-- paging -->
	<c:if test="${!empty pagerVo.list}"><op:pager pager="${pagerVo}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" /></c:if>
	<!-- //paging -->