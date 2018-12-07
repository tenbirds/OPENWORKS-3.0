<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

       <op:jsTag type="spi" items="form, validate, multifile" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
    <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<!-- 사용자 스크립트 시작 -->
<script type="text/javascript">
    $().ready(function() {
        var commentSubmitHandler = function(form){
            //수정일때 비공개인경우
            if($("#commentForm input[name=type]").val() == "UPDATE") {
                $("#commentForm input[name=bizMatchingOthbcAt]").val("Y");
            }

            var bizPhone = $("#bizMatchingCttpc1").val() +"-"+ $("#bizMatchingCttpc2").val() +"-"+ $("#bizMatchingCttpc3").val();
            $("#bizMatchingCttpc").val(bizPhone);

            <c:choose>
                <c:when test="${boardConfVo.bannedWordYn eq 'Y'}">
                    $.post("ND_check.ban.do", {
                    domainCd : "${param.domainCd}",
                    bbsCd : "${param.bbsCd}",
                    bbscttSj : "${param.bbscttSj}",
                    nttCmtCn : $("#nttCmtCn").val()
                    }, function(result){
                        if(result.result == true){
                            alert(result.message);
                            return;
                        }else{
                            if($("#commentForm").valid() === true){
                                if(OpenWorks.uploadTy == "1001"){
                                    detectFlashPlayer().flexSubmit();
                                }else{
                                    actionType = $("input[name=type]").val();
                                    dataString = $("#commentForm").serialize();
                                    $("#commentForm").ajaxSubmit({
                                        url      : "ND_cmt.insert.do",
                                        type     : "POST",
                                        data     : dataString,
                                        dataType : "json",
                                        success  : function(response){
                                            alert(response.message);  
                                            parent.location.reload("BD_board.view.do?domainCd=<c:out value='${param.domainCd}'/>&bbsCd=<c:out value='${param.bbsCd}'/>&bbscttSeq=<c:out value='${param.bbscttSeq}'/>");

                                            if(actionType == "INSERT")
                                                parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
                                            jsCmtPageMove($("#commentForm input[name=currentPage]").val());
                                        }
                                    });
                                }
                                return true;
                            };
                        };
                    }, "json");
                </c:when>
                <c:otherwise>
                    if($("#commentForm").valid() === true){
                        if(OpenWorks.uploadTy == "1001"){
                            detectFlashPlayer().flexSubmit();
                        }else{
                            //현재 비즈매칭에서는 이부분이 동작한다. 2015.09.16
                            actionType = $("input[name=type]").val();
                            dataString = $("#commentForm").serialize();
                            $("#commentForm").ajaxSubmit({
                                url      : "ND_cmt.insert.do",
                                type     : "POST",
                                //data     : dataString,
                                dataType : "json",
                                success  : function(response){
                                    alert(response.message);  
                                    parent.location.reload("BD_board.view.do?domainCd=<c:out value='${param.domainCd}'/>&bbsCd=<c:out value='${param.bbsCd}'/>&bbscttSeq=<c:out value='${param.bbscttSeq}'/>");

                                    if(actionType == "INSERT"){
                                        parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
                                    }
                                    jsCmtPageMove($("#commentForm input[name=currentPage]").val());
                                }
                            });
                        }
                        return true;
                    }
                </c:otherwise>
            </c:choose>

            //기존 동작 부분 주석 처리 2015.09.16
            //$.post("ND_check.ban.do", {
            //    domainCd : "${param.domainCd}",
            //    bbsCd : "${param.bbsCd}",
            //    bbscttSj : "${param.bbscttSj}",
            //    nttCmtCn : $("#nttCmtCn").val()
            //}, function(result) {
            //    if(result.result == true) {
            //        //var msg = result.message.replace("\n\n", "<br />");
            //        alert(result.message);
            //        return;
            //    }else{
            //        actionType = $("input[name=type]").val();
            //        dataString = $("#commentForm").serialize();
            //        $.ajax({
            //            url      : "ND_cmt.insert.do",
            //            type     : "POST",
            //            data     : dataString,
            //            dataType : "json",
            //            success  : function(response) {
            //                alert(response.message);
            //                if(actionType == "INSERT")
            //                    parent.$("#cmtCnt").text(parseInt($("#cmtCnt").text()) + 1);
            //                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            //                //location.reload();
            //            }
            //        });
            //    }
            //}, "json");
        };

        //commentForm 유효성 체크
        $("#commentForm").validate({
            errorClass : "error",
            rules : {
                bizMatchingCmpnyNm : {required : true, maxlength : 50 },
                bizMatchingCttpc1 : { required : true, maxlength : 4, number : true },
                bizMatchingCttpc2 : { required : true, maxlength : 4, number : true },
                bizMatchingCttpc3 : { required : true, maxlength : 4, number : true },
                bizMatchingEmail : { required : true, maxlength : 50, email : true }
            },
            messages : {
                bizMatchingCmpnyNm : {
                    required : "회사명을 입력해주세요."
                },
                bizMatchingEmail : {
                    required : "이메일을 입력해주세요.",
                    email : "예시 (tester@abc.com)"
                },
                bizMatchingCttpc1 : {
                    required : "휴대전화번호를 입력해주세요.",
                },
                bizMatchingCttpc2 : {
                    required : "휴대전화번호를 입력해주세요.",
                },
                bizMatchingCttpc3 : {
                    required : "휴대전화번호를 입력해주세요.",
                }
            },
            submitHandler : commentSubmitHandler
        });

    });

    $(function(){
        $('#multiFiles').MultiFile({
            accept: OpenWorks.filePermExtsn,
            max: OpenWorks.maxFileCnt,
            maxfile: OpenWorks.maxFileSize, //각 파일 최대 업로드 크기
            maxsize: OpenWorks.totalFileSize,  //전체 파일 최대 업로드 크기
            STRING: { 
                remove: '<img id="fileDelImg" src="' + OpenWorks.closeFileIcon + '" class="vm" />',
                denied: '[ $ext ]'+Message.msg.fileCannotUplaod ,           //확장자 제한 문구
                duplicate: '[ $file ]\n'+Message.msg.fileAlreadyUpload,       //중복 파일 문구
                toomany: Message.msg.fileToomany+" : $max )"
//            toobig: "$file 은 크기가 매우 큽니다. (max $size)",
            },
            list: '#multiFilesListDiv',
            onFileRemove: function(element, value, master_element){
            },
            afterFileRemove: function(element, value, master_element){
                if(eval($("#uploadFileCnt").val()) > 0)
                    $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
                else $("#uploadFileCnt").val(0);

                if(eval($("#uploadFileCnt").val()) < OpenWorks.maxFileCnt   )
                    $.fn.MultiFile.reEnableEmpty();
                $("#fileCnt").html($("#uploadFileCnt").val());
            },
            onFileAppend: function(element, value, master_element){
                $("#multiFiles").length;
            },
            afterFileAppend: function(element, value, master_element){
                if(eval($("#uploadFileCnt").val()) < 0){
                    $("#uploadFileCnt").val(1);
                }else{
                    $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) + 1);
                }

                if(eval($("#uploadFileCnt").val()) >= OpenWorks.maxFileCnt  )
                    $.fn.MultiFile.disableEmpty();
                //alert($("#uploadFileCnt").val());
                $("#fileCnt").html($("#uploadFileCnt").val());
            },
                onFileSelect: function(element, value, master_element){
            },
                afterFileSelect: function(element, value, master_element){
            }
        });
    });
    
    //선정 버튼 클릭시
    var jsSelection = function(domainCd, bbsCd, bbscttSeq, cmtSeq){

        if(!confirm("선정은 한번만 가능하며 변경은 불가능합니다. 선택한 요청글을 선정하시겠습니까? "))
            return false;

        var estnColumn5 = "Y_" + cmtSeq;

        $.ajax({
            url      : "ND_selectionUpdate.do",
            type     : "POST",
            data     : {
                domainCd : domainCd,
                bbsCd : bbsCd,
                bbscttSeq : bbscttSeq,
                cmtSeq : cmtSeq,
                estnColumn5 : estnColumn5
                }, 
            dataType : "json",
            success  : function(result) {
                if(result.result == true) {
                    alert("선정되었습니다.");

                    $("#btn_modify_trash").hide();

                    $("#tbl_comment td").each(function(i) {
                        if($(this).attr("id") != cmtSeq){
                            $("#"+$(this).attr("id")).empty();
                        }
                    });

                    $("#"+cmtSeq).empty();

                    var html ="";
                    html += '선정완료';
                    $("#"+cmtSeq).append(html);

                }else{
                    alert("선정 실패하였습니다.");
                }
            }
        });
    };

    //댓글 수정 클릭 시
    var jsModifyCommentAction = function(domainCd, bbsCd, bbscttSeq, cmtSeq, mid, uid){

        $.post("ND_comment.update.form.do", {
            domainCd : domainCd,
            bbsCd : bbsCd,
            bbscttSeq : bbscttSeq,
            cmtSeq : cmtSeq,
            mngrId : mid,
            updtId : uid
        }, function(result) {            
            if(result.result == true) {
                $("#commentForm input[name=bbsCd]").val(result.value.bbsCd);
                $("#commentForm input[name=bbscttSeq]").val(result.value.bbscttSeq);
                $("#commentForm input[name=cmtSeq]").val(result.value.cmtSeq);
                $("#commentForm textarea[name=nttCmtCn]").val(result.value.nttCmtCn);
                $("#commentForm input[name=bizMatchingCmpnyNm]").val(result.value.bizMatchingCmpnyNm);
                $("#commentForm input[name=bizMatchingCttpc1]").val(result.value.bizMatchingCttpc.split("-")[0]);
                $("#commentForm input[name=bizMatchingCttpc2]").val(result.value.bizMatchingCttpc.split("-")[1]);
                $("#commentForm input[name=bizMatchingCttpc3]").val(result.value.bizMatchingCttpc.split("-")[2]);
                $("#commentForm input[name=bizMatchingEmail]").val(result.value.bizMatchingEmail);
                if(result.value.bizMatchingOthbcAt == "Y") {
                    $("#commentForm input[name=bizMatchingOthbcAt]").attr("checked", true);
                }
                $("#commentForm input[name=type]").val("UPDATE");
                $("#commentForm input[name=currentPage]").val(result.value.currentPage);
                $("#commentForm textarea[name=nttCmtCn]").focus();
                $("#nttCmtCnLength").text($("#nttCmtCn").val().length);

                $("#commentForm input[name=fileSeq]").val(result.value.fileSeq);
                $("#commentForm input[name=fileCnt]").val(result.value.fileCnt);

                //alert("result.value.fileCnt:" + result.value.fileCnt);
                if(OpenWorks.maxFileCnt <= result.value.fileCnt){
                    $("#multiFiles").attr("disabled",true);
                }else{
                    $("#multiFiles").attr("disabled",false);
                }

                var innerHtml = "";
                $("#fileView").empty();
                if(result.value.fileList.length > 0){
                    innerHtml += '<p class="tx_blue_s">';
                    innerHtml += '- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요.';
                    innerHtml += '</p>';
                    innerHtml += '<ul>';
                    for(i = 0; i < result.value.fileList.length; i++){
                        innerHtml += '<li class="mar_b5">';
                        innerHtml += '<a href="#" onclick="jsFileDelete(this, &#39;' + result.value.fileList[i].fileSeq + '&#39;,&#39;' + result.value.fileList[i].fileId + '&#39;);"><img src="<c:url value="/resources/cmmnty/default/images/icon_cancel_red.png" />" alt="삭제" class="vm"/></a>';
                        innerHtml += result.value.fileList[i].localNm + '<span class="tx_gray vm">(download ' + result.value.fileList[i].downCnt + ', ' + result.value.fileList[i].fileSize + ', ' + result.value.fileList[i].fileType + ')</span>';
                        innerHtml += '</li>';
                    }
                    innerHtml += '</ul>';
                    $("#fileView").append(innerHtml);
                }

                window.scrollTo(1, $("#commentForm").position().top);
                $("#btnCancel").show();
            }else{
                alert("요청이 실패되었습니다.");  
            }
        }, 'json');
    };

    //댓글 페이지 번호이벤트 함수
    var jsCmtPageMove = function(curpage){
        var target = $("#attachedCommentsDiv2");
        if($.trim(target.text()) == "" || curpage != $("#commentForm input[name=currentPage]")) {
            $.get("INC_cmt.list.do", {
                domainCd : "<c:out value='${param.domainCd}'/>",
                bbsCd : "<c:out value='${param.bbsCd}'/>",
                bbscttSeq : "<c:out value='${param.bbscttSeq}'/>",
                q_currPage : curpage
            }, function(result) {
                target.empty();
                target.append(result);
            });
        }
    };

    //댓글 완전 삭제 클릭 시
    var jsDeleteCommentAction = function(domainCd, bbsCd, bbscttSeq, cmtSeq, refrnCmtSeq, uid){

        if(!confirm("요청글을 완전 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다.")) {
            return;
        }

        $.post("ND_comment.delete.do", {
            domainCd    : domainCd,
            bbsCd       : bbsCd,
            bbscttSeq   : bbscttSeq,
            cmtSeq      : cmtSeq,
            refrnCmtSeq : refrnCmtSeq,
            registId    : uid
        }, function(result) {
            if(result == "TRUE"){
                alert('요청글이 삭제되었습니다');
                parent.location.reload("BD_board.view.do?domainCd=<c:out value='${param.domainCd}'/>&bbsCd=<c:out value='${param.bbsCd}'/>&bbscttSeq=<c:out value='${param.bbscttSeq}'/>");
                jsCmtPageMove($("#commentForm input[name=currentPage]").val());
            }else{
                alert('요청글 삭제가 실패되었습니다.');
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

    var jsSubmit = function(){

        if(!confirm("비즈매칭 선정시 연락처(휴대전화번호)와 이메일이 비즈매칭 요청자에게 공개됩니다.\n등록하시겠습니까?"))
            return false;

        if("${__usk.userKey}" == "${ cmtBoardVo.userKey}"){
            //본인의 글에는 글등록자가 댓글등록이 불가능
            alert("본인이 등록한 글에는 매칭이 불가능합니다.");
            return false;
        }

        //구매회원도 댓글등록 가능하도록 수정 2015.09.16
        //if("${__usk.userTyCd}" == 1001 || "${__usk.userTyCd}" == 2001){
        //    //판매권한이없으면 댓글등록이 불가능
        //    alert("판매권한이 없으므로 매칭이 불가능합니다.");
        //    return false;
        //}

        var _contents = new String($.trim($("#nttCmtCn").val()));
        if(_contents.length == 0 || _contents == ''){
            alert(Message.msg.commentChack);
            $("#nttCmtCn")[0].focus();
            return false;
        } else if(_contents.length > 20000){
            alert(Message.msg.commentCharacters);
            $("#nttCmtCn")[0].focus();
            return false;
        } else if(_contents.length < 10){
            alert(Message.msg.characters10);
            $("#nttCmtCn")[0].focus();
            return false;
        }

        $("#commentForm").submit();
    };

    //2015.09.15
    //플래쉬 파일 업로드 창
    function detectFlashPlayer(){
        var flashPlayer = null;
        if(navigator.appName.indexOf("Microsoft") != -1){
            flashPlayer = window.OpenWorksMultiFileUploader;
            if(flashPlayer == undefined){
                flashPlayer = window.document.OpenWorksMultiFileUploader;
            }
        }else{
            flashPlayer = window.document.OpenWorksMultiFileUploader;
        }
        return flashPlayer;
    }

    //업로드 완료 이벤트핸들러
    function uploadComplete(){
        var msg = arguments[0];
        if(msg === "UPLOAD_COMPLETE" || msg === "UPLOAD_DONE"){
            var fileSeq = arguments[1];
            document.commentForm.fileSeq.value = fileSeq;
            document.commentForm.submit();
        }
    }

    //첨부된 파일중 ajax를 이용하여 파일 삭제
    var jsFileDelete = function(element, seq, id){
        if(!confirm(Message.msg.chkFileDelete))
            return false;

        var url = "ND_file.delete.do";
        $.post(url, {
            fileId  : id,
            fileSeq : seq,
            bbsCd   : "${commentVo.bbsCd}"
        }, function(result){
            if(result == 1){
                $(element).parent().remove();
                //if(OpenWorks.maxFileCnt <= OpenWorks.fileCnt) $("#multiFiles").attr("disabled",false);
                //파일 삭제 이후 파일 첨부 활성화
                $("#multiFiles").attr("disabled",false);
                alert(Message.msg.fileDeleteY);

                if(eval($("#uploadFileCnt").val()) > 0)
                    $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
                else $("#uploadFileCnt").val(0);
                //$.fn.MultiFile.reEnableEmpty();
            }else{
                alert(Message.msg.fileDeleteN);
            };
        }, 'json');
    };
    //2015.09.15

</script>

<!-- 사용자 스크립트 끝 -->
<!-- 의견글등록-->
<c:if test="${cmtBoardVo.bizProgression eq 'PRO'}">
    <form id="commentForm" name="commentForm" action="ND_cmt.insert.do" method="post" enctype="multipart/form-data" onsubmit="return false;">
        <input type="hidden" name="domainCd" value="<c:out value='${param.domainCd}'/>"/> 
        <input type="hidden" name="bbsCd" value="<c:out value='${param.bbsCd}'/>"/> 
        <input type="hidden" name="bbscttSeq" value="<c:out value='${param.bbscttSeq}'/>"/> 
        <input type="hidden" name="cmtSeq" value="0" /> 
        <input type="hidden" name="currentPage" value="<c:out value='${param.currentPage}'/>"/> 
        <input type="hidden" name="type" value="INSERT" />
        <input type="hidden" name="bizMatchingCttpc" value="" id="bizMatchingCttpc"/> 

		<!-- section -->
		<div class="section mt20">							
			<div class="type-write bor-t">
				<table>
					<colgroup>
						<col style="width:100px;" />
						<col style="width:*;" />
						<col style="width:100px;" />
						<col style="width:*;" />
						<col style="width:100px;" />
						<col style="width:*;" />
					</colgroup>
					<tbody>
						<tr>
							<th><span>회사명</span></th>
							<c:choose>
		                        <c:when test="${dataVo2.userTyCd eq '1001' || dataVo2.userTyCd eq '1002'}">
		                            <td><input type="text" class="w194" id="bizMatchingCmpnyNm" name="bizMatchingCmpnyNm" title="회사명 입력" value="${dataVo2.indvdlCmpnyNm}"/></td>
		                        </c:when>
		                        <c:otherwise>
		                            <td><input type="text" class="w194" id="bizMatchingCmpnyNm" name="bizMatchingCmpnyNm" title="회사명 입력" value="${dataVo2.entrprsCmpnyNm}"/></td>
		                        </c:otherwise>
		                    </c:choose>
							<th><span>휴대전화</span></th>
							<c:choose>
		                        <c:when test="${dataVo2.userTyCd eq '1001' || dataVo2.userTyCd eq '1002'}">
		                            <td>
		                                <input type="text" class="w74" id="bizMatchingCttpc1" name="bizMatchingCttpc1" title="휴대전화번호 입력" value="${fn:split(dataVo2.indvdlCmpnyReprsntTelno,'-')[0]}" maxlength="4"/><span class="space">-</span>
		                                <input type="text" class="w74" id="bizMatchingCttpc2" name="bizMatchingCttpc2" title="휴대전화번호 입력" value="${fn:split(dataVo2.indvdlCmpnyReprsntTelno,'-')[1]}" maxlength="4"/><span class="space">-</span>
		                                <input type="text" class="w74" id="bizMatchingCttpc3" name="bizMatchingCttpc3" title="휴대전화번호 입력" value="${fn:split(dataVo2.indvdlCmpnyReprsntTelno,'-')[2]}" maxlength="4"/>
		                            </td>
		                        </c:when>
		                        <c:otherwise>
		                            <td>
		                                <input type="text" class="w74" id="bizMatchingCttpc1" name="bizMatchingCttpc1" title="휴대전화번호 입력" value="${fn:split(dataVo2.entrprsCmpnyReprsntTelno,'-')[0]}" maxlength="4"/><span class="space">-</span>
		                                <input type="text" class="w74" id="bizMatchingCttpc2" name="bizMatchingCttpc2" title="휴대전화번호 입력" value="${fn:split(dataVo2.entrprsCmpnyReprsntTelno,'-')[1]}" maxlength="4"/><span class="space">-</span>
		                                <input type="text" class="w74" id="bizMatchingCttpc3" name="bizMatchingCttpc3" title="휴대전화번호 입력" value="${fn:split(dataVo2.entrprsCmpnyReprsntTelno,'-')[2]}" maxlength="4"/>
		                            </td>
		                        </c:otherwise>
		                    </c:choose>
							<th><span>이메일</span></th>
							<c:choose>
		                        <c:when test="${dataVo2.userTyCd eq '1001' || dataVo2.userTyCd eq '1002'}">
		                            <td><input type="text" class="w194" id="bizMatchingEmail" name="bizMatchingEmail" title="이메일 입력" value="${dataVo2.indvdlCmpnyEmail}"/></td>
		                        </c:when>
		                        <c:otherwise>
		                            <td><input type="text" class="w194" id="bizMatchingEmail" name="bizMatchingEmail" title="이메일 입력" value="${dataVo2.entrprsCmpnyEmail}"/></td>
		                        </c:otherwise>
		                    </c:choose>
						</tr>
						<tr>
							<th><span>내용</span></th>
							<td colspan="5">
								<textarea class="h210" id="nttCmtCn" name="nttCmtCn" title="내용 입력" placeholder="장시간 내용 작성시 세션이 끊겨 작성중인 내용이 사라질 수 있으니 주의하시기 바랍니다."></textarea>
							</td>
						</tr>
						<tr>
							<th><span>첨부파일</span></th>
							<td colspan="5" class="file-save">
								<div>
									<div id="fileView"></div>					
									<div class="file-area">
										<!-- file upload -->
										<input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${cmtBoardVo.fileSeq}' />" />
			                            <input type="file" name="multiFiles" id="multiFiles" <c:if test="${1 <= cmtBoardVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"  style="width:500px;"/>
			                            <div id="multiFilesListDiv" class="regist-file"></div>
			                            <!-- //file upload -->
									</div>
									<div class="btn-area">
										<a href="#" class="b-btn save3 type2" onclick="jsSubmit();"><strong><span>저 장</span></strong></a>
										<p><span class="agree"><input type="checkbox" id="bizMatchingOthbcAt" name="bizMatchingOthbcAt" class="rach" value="Y"/><label>공개</label></span></p>
									</div>
								</div>
								<input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}' />" />
	                            <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }">
	                                <c:set var="split_filePermExtsn" value="${fn:split(boardConfVo.filePermExtsn, '|')}" />
	                                <c:set var="join_filePermExtsn" value="${fn:join(split_filePermExtsn, ', ')}" />
	                                <p class="caption">※${join_filePermExtsn} 파일 첨부 가능</p>
	                            </c:if>
	                            <p class="caption">※  ${boardConfVo.maxFileSize}MB 미만 파일만 업로드 가능합니다.</p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<!-- //section -->
    </form>
</c:if>
<!-- //의견글등록-->



<!-- 의견글내용-->
<c:if test="${!empty pagerVo.list}">
	<!-- section -->
	<div class="section">							
		<div class="type-write">
			<table id="tbl_comment">
				<colgroup>									
					<col style="width:*;" />
					<col style="width:130px;" />
					<col style="width:130px;" />
				</colgroup>
				<tbody>
					<c:forEach items="${pagerVo.list}" var="commentVo" varStatus="status">
						<c:choose>
	                        <c:when test="${commentVo.mngrDeleteAt eq 'Y'}">
	                            <!-- 관리자 삭제댓글 -->
	                            <tr>
									<td>관리자에 의해 삭제되었습니다.</td>
									<td></td>
									<td></td>
								</tr>
	                        </c:when>
	                        <c:when test="${commentVo.bizMatchingOthbcAt eq 'N' and (!empty __usk.userKey && (__usk.userKey eq commentVo.userKey or __usk.userKey eq cmtBoardVo.userKey ))}">
	                        	<!-- 비공개인경우(댓글작성자 또는 글등록자 인경우)-->
								<tr>
									<td><op:nrToBr content='${commentVo.nttCmtCn}'/></td>
									<c:choose>
			                            <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq)}">
			                            	<!-- 비공개인경우(댓글작성자 또는 글등록자 인경우)에서 댓글작성자 또는 선정인경우 회사정보 공개-->
			                            	<td>회사명</td>
											<td><c:out value='${commentVo.bizMatchingCmpnyNm}'/></td>
			                            </c:when>
			                            <c:otherwise>
			                                <td>회사명</td>
											<td><c:out value='${commentVo.bizMatchingCmpnyNm}'/></td>
			                            </c:otherwise>
			                        </c:choose>
								</tr>
								<tr>
									<td>
										<c:choose>
			                                <c:when test="${fn:length(commentVo.fileList) > 0}">
			                                    <p class="file-add al">
			                                        <c:forEach items="${commentVo.fileList}" var="fileVo">
			                                            <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">
			                                            	<img src="/new_cloud/images/icon-btn/icon-file-add.gif" alt="" />${fileVo.localNm}
			                                            </a> (${fileVo.fileSize})
			                                        </c:forEach>
			                                    </p>
			                                </c:when>
			                                <c:otherwise>
			                                    <p class="file-add al">첨부 파일이 없습니다.</p>
			                                </c:otherwise>
			                            </c:choose>
									</td>
									<c:choose>
			                            <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq)}">
			                                <!-- 비공개인경우(댓글작성자 또는 글등록자 인경우)에서 댓글작성자 또는 선정인경우 휴대전화번호, 이메일 공개-->
			                                <td>연락처</td>
											<td><c:out value='${commentVo.bizMatchingCttpc}'/></td>
			                            </c:when>
			                            <c:otherwise>
			                            	<c:set var="Cttpc" value="${fn:length(commentVo.bizMatchingCttpc)-4}" />
			                                <td>연락처</td>
											<td><c:out value='${fn:substring(commentVo.bizMatchingCttpc,0,Cttpc)}'/>****</td>
			                            </c:otherwise>
			                        </c:choose>
								</tr>
								<tr>
									<td>
										<c:out value='${commentVo.registDt}'/>
										<c:if test="${empty cmtBoardVo.bizCmtSeq and commentVo.mngrDeleteAt != 'Y'}">
				                            <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
				                                <c:if test="${empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq ne commentVo.cmtSeq}">
				                                     | <a href="#" onclick="jsModifyCommentAction('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>');">수정</a>
				                                     | <a href="#" onclick="jsDeleteCommentAction('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>');">삭제</a>
				                                </c:if>
				                            </c:if>
				                        </c:if>
			                        </td>
			                        <c:choose>
			                            <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq)}">
			                                <!-- 비공개인경우(댓글작성자 또는 글등록자 인경우)에서 댓글작성자 또는 선정인경우 휴대전화번호, 이메일 공개-->
			                                <td>이메일</td>
											<td><c:out value='${commentVo.bizMatchingEmail}'/></td>
			                            </c:when>
			                            <c:otherwise>
			                                <c:set var="Email" value="${fn:length(commentVo.bizMatchingEmail)-3}" />
			                                <td>이메일</td>
											<td><c:out value='${commentVo.maskBizMatchingEmail}'/></td>
			                            </c:otherwise>
			                        </c:choose>
								</tr>
								<c:if test="${!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey}">
		                        	<c:if test="${empty cmtBoardVo.bizCmtSeq}">
		                            	<tr>
		                             		<td id="${commentVo.cmtSeq}"><a href="#" onclick="jsSelection('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>');">선정</a></td>
		                             		<td></td>
											<td></td>
		                             	</tr>
		                            </c:if>
		                        </c:if>
		                        <c:if test="${!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq}">
		                        	<tr>
		                            	<td id="${commentVo.cmtSeq}">선정${empty cmtBoardVo.bizCmtSeq? '' :'완료'}</td>
		                            	<td></td>
										<td></td>
		                            </tr>
		                        </c:if>
							</c:when>
	                        <c:when test="${commentVo.bizMatchingOthbcAt eq 'N' and (!empty __usk.userKey && (__usk.userKey ne commentVo.userKey and __usk.userKey ne cmtBoardVo.userKey ))}">
	                            <!-- 비공개인경우(댓글작성자와 글등록자가 아닌경우) -->
	                            <tr>
									<td>비공개 글입니다.</td>
			                        <td></td>
									<td></td>
								</tr>
	                        </c:when>
	                        <c:when test="${commentVo.bizMatchingOthbcAt eq 'Y' and commentVo.mngrDeleteAt eq 'N'}">
                            <!-- 비공개가 아니며 관리자 삭제댓글이 아닌경우(공개일때) -->
                            	<tr>
									<td><op:nrToBr content='${commentVo.nttCmtCn}'/></td>
									<c:choose>
	                                    <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or ((!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey) and (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq))}">
	                                        <!-- 공개이지만 본인의 글인경우, 글등록자가 선정한경우 -->
	                                        <td>회사명</td>
											<td><c:out value='${commentVo.bizMatchingCmpnyNm}'/></td>
	                                    </c:when> 
	                                    <c:otherwise>
	                                        <!-- 공개이지만 본인의 글이 아닌 경우 -->
	                                        <td>회사명</td>
											<td><c:out value='${commentVo.bizMatchingCmpnyNm}'/></td>
	                                    </c:otherwise>
	                                </c:choose>
								</tr>
								<tr>
									<td>
										<c:choose>
	                                    <c:when test="${fn:length(commentVo.fileList) > 0}">
	                                        <p class="file-add al">
	                                            <c:forEach items="${commentVo.fileList}" var="fileVo">
	                                                <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}" title="${fileVo.fileDesc}">
	                                                <img src="/new_cloud/images/icon-btn/icon-file-add.gif" alt="" />${fileVo.localNm}</a> (${fileVo.fileSize})
	                                            </c:forEach>
	                                        </p>
	                                    </c:when>
	                                    <c:otherwise>
	                                        <p class="file-add al">첨부 파일이 없습니다.</p>
	                                    </c:otherwise>
	                                </c:choose>
									</td>
									<c:choose>
	                                    <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or ((!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey) and (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq))}">
	                                        <!-- 공개이지만 본인의 글인경우, 글등록자가 선정한경우 -->
	                                        <td>연락처</td>
											<td><c:out value='${commentVo.bizMatchingCttpc}'/></td>
	                                    </c:when> 
	                                    <c:otherwise>
	                                        <!-- 공개이지만 본인의 글이 아닌 경우 -->
	                                        <c:set var="Cttpc" value="${fn:length(commentVo.bizMatchingCttpc)-4}" />
	                                        <td>연락처</td>
											<td><c:out value='${fn:substring(commentVo.bizMatchingCttpc,0,Cttpc)}'/>****</td>
	                                    </c:otherwise>
	                                </c:choose>
								</tr>
								<tr>
									<td>
										<c:out value='${commentVo.registDt}'/>
										<c:if test="${empty cmtBoardVo.bizCmtSeq and commentVo.mngrDeleteAt != 'Y'}">
	                                        <c:if test="${!empty __usk.userKey && __usk.userKey eq commentVo.userKey}">
	                                        	 | <a href="#" onclick="jsModifyCommentAction('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>');">수정</a>
	                                    		 | <a href="#" onclick="jsDeleteCommentAction('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>', '<c:out value='${commentVo.mngrId}'/>', '<c:out value='${commentVo.registId}'/>');">삭제</a>
	                                        </c:if>
	                                    </c:if>
                                    </td>
                                    <c:choose>
	                                    <c:when test="${(!empty __usk.userKey && __usk.userKey eq commentVo.userKey) or ((!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey) and (!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq))}">
	                                        <!-- 공개이지만 본인의 글인경우, 글등록자가 선정한경우 -->
	                                        <td>이메일</td>
											<td><c:out value='${commentVo.bizMatchingEmail}'/></td>
	                                    </c:when> 
	                                    <c:otherwise>
	                                        <!-- 공개이지만 본인의 글이 아닌 경우 -->
	                                        <c:set var="Email" value="${fn:length(commentVo.bizMatchingEmail)-3}" />
	                                        <td>이메일</td>
											<td><c:out value='${commentVo.maskBizMatchingEmail}'/></td>
	                                    </c:otherwise>
	                                </c:choose>
								</tr>
								<c:if test="${!empty __usk.userKey && __usk.userKey eq cmtBoardVo.userKey}">
		                        	<c:if test="${empty cmtBoardVo.bizCmtSeq}">
		                            	<tr>
		                             		<td id="${commentVo.cmtSeq}"><a href="#" onclick="jsSelection('<c:out value='${commentVo.domainCd}'/>','<c:out value='${commentVo.bbsCd}'/>', '<c:out value='${commentVo.bbscttSeq}'/>', '<c:out value='${commentVo.cmtSeq}'/>');">선정</a></td>
		                             		<td></td>
											<td></td>
		                             	</tr>
		                            </c:if>
		                        </c:if>
		                        <c:if test="${!empty cmtBoardVo.bizCmtSeq and cmtBoardVo.bizCmtSeq eq commentVo.cmtSeq}">
		                        	<tr>
		                            	<td id="${commentVo.cmtSeq}">선정${empty cmtBoardVo.bizCmtSeq? '' :'완료'}</td>
		                            	<td></td>
										<td></td>
		                            </tr>
		                        </c:if>
	                        </c:when>
	                    </c:choose>
	                </c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- //section -->
</c:if>

<c:if test="${commentVo.mngrDeleteAt eq 'Y'}">
	<!-- section -->
	<div class="section">							
		<div class="type-write"> 관리자에 의해 삭제되었습니다. </div>
	</div>
	<!-- //section -->
</c:if>
<!-- //의견글내용-->
<!-- paging -->
<c:if test="${!empty pagerVo.list}">
    <op:pager pager="${pagerVo}" page="pager/webCmtPager.jsp" script="jsCmtPageMove" />
</c:if>
<!-- //paging -->