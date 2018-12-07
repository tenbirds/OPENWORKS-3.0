<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title>게시물 등록</title>

	<op:jsTag type="openworks" items="validate, ckeditor" />
	<op:jsTag type="spi" items="form, validate, multifile, ui" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/agent.detector.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

	<!-- 사용자 스크립트 시작  -->
	<script type="text/javascript">

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }

		OpenWorks.bbsCd			= "<c:out value='${boardConfVo.bbsCd}'/>";
		OpenWorks.domainCd		= "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.pageType		= "<c:out value='${pageType}'/>";
		OpenWorks.boardNm		= "<c:out value='${boardConfVo.bbsNm}'/>";
		OpenWorks.boardType		= "<c:out value='${boardConfVo.kndCd}'/>";
		OpenWorks.useCategory	= "<c:out value='${boardConfVo.ctgYn}'/>";
		OpenWorks.fileYn		= "<c:out value='${boardConfVo.fileYn}'/>";
		OpenWorks.uploadTy	    = "<c:out value='${boardConfVo.uploadTy}'/>";
		OpenWorks.maxFileCnt	= "<c:out value='${boardConfVo.maxFileCnt}'/>";
		OpenWorks.maxFileSize	= "<c:out value='${boardConfVo.maxFileSize}'/>";
		OpenWorks.totalFileSize	= "<c:out value='${boardConfVo.totalFileSize}'/>";
		OpenWorks.filePermExtsn	= "<c:out value='${boardConfVo.filePermExtsn}'/>";
		OpenWorks.closeFileIcon	= "<c:url value='/resources/openworks/theme/default/images/btn/btn_r_close.gif' />";
		OpenWorks.captchaYn		= "<c:out value='${boardConfVo.captchaYn}'/>";
		OpenWorks.fileCnt		= "<c:out value='${dataVo.fileCnt}'/>";
		OpenWorks.tagYn			= "<c:out value='${boardConfVo.tagYn}'/>";
		OpenWorks.bannedWordYn	= "<c:out value='${boardConfVo.bannedWordYn}'/>";
		OpenWorks.editorYn		= "<c:out value='${boardConfVo.userEditorYn}'/>";

		onReadyEventFunctions();

		$("#brwsrAgent").val(UserAgent);

		//dataForm 유효성 체크
		SharedOpenWorks.jsSetFormValidate = function(){

			var submitFunction = function(form){
				if($("#dataForm input[name=othbcAt]:checked").val() == "N"){
					if($("#registPassword").val() == ""){
						$("#registPassword").focus();
						return;
					}
				}
				<c:choose>
					<c:when test="${boardConfVo.bannedWordYn eq 'Y'}">
						$.post("ND_check.ban.do", {
							bbsCd : OpenWorks.bbsCd,
							bbscttSj : $("#bbscttSj").val(),
							bbscttCn : $("textarea[name=bbscttCn]").val()
						}, function(result){
							if(result.result == true){
							    alert(result.message);
								return;
							}else{
								if($("#dataForm").valid() === true){
									if(OpenWorks.uploadTy == "1001"){
										detectFlashPlayer().flexSubmit();
									}else{
										document.dataForm.submit();
									}
									return true;
								 };
							};
						}, "json");
					</c:when>
					<c:otherwise>
						if($("#dataForm").valid() === true){
							if(OpenWorks.uploadTy == "1001"){
								detectFlashPlayer().flexSubmit();
							}else{
								document.dataForm.submit();
							}
							return true;
						 }
					</c:otherwise>
				</c:choose>
			};

			var jsSetErrorPlacement = function(error, element){
				if(element.attr("name") == "bbscttCn"){
					error.prependTo($("#contentsErrorDiv"));
				}else{
					error.insertBefore(element);
				}
			};

			$("#dataForm").validate({
				//유효성 검증 BEAN Annotation 기반 자동 설정
				//<valid:script type="jquery" />,
				rules: {
					registerNm :		{ required:true, minlength:2, maxlength:10 },
					bbscttSj :		{ required:true, minlength:3, maxlength:200 },
					bbscttCn :	{ required:true, minlength:10 }
					<c:if test="${boardConfVo.ctgYn eq 'Y'}">
						,ctgCd :	{ required:true }
					</c:if>
					<c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
						<c:if test="${!empty extensionVo.columnTy and extensionVo.essntlYn eq 'Y'}">
							,${extensionVo.beanName} :	{ required: true }
						</c:if>
					</c:forEach>
				},
				errorClass: "error",
				errorPlacement: jsSetErrorPlacement,
				submitHandler: submitFunction
			});
		}

		//폼 설정
		jsFormProcess();
	});

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
			document.dataForm.fileSeq.value = fileSeq;
			document.dataForm.submit();
		}
	}

	//첨부된 파일중 ajax를 이용하여 파일 삭제
	var jsFileDelete = function(element, seq, id){
		if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
			return false;

		var url = "ND_file.delete.do";
		$.post(url,
			{ fileId : id, fileSeq : seq, bbsCd : "${dataVo.bbsCd}" },
			function(result){
			    if(result == 1){
                    $(element).parent().remove();
                    
                    if(OpenWorks.maxFileCnt <= OpenWorks.fileCnt) $("#multiFiles").attr("disabled",false); 
                    alert(Message.msg.fileDeleteY);

                    if(eval($("#uploadFileCnt").val()) > 0)
                        $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
                    else $("#uploadFileCnt").val(0);
//                  $.fn.MultiFile.reEnableEmpty();
                }else{
                    alert(Message.msg.fileDeleteN);
                };
			}, 'json');
	};
	
	
	   function jsSubmit() {
	     //구분
           if($("#ctgCd").val() =="" ){
               alert(Message.msg.selctgCd);
               return false;
           }
          
           //제목
           var subject = $("input[name=bbscttSj]").val();
           if(subject.length < 1) {
               alert(Message.msg.chkTitle);
               $("#bbscttSj").focus();
               return false;
           } else if(subject.length > 150) {
               alert(Message.msg.maxLengthTitle);
               $("#bbscttSj").focus();
               return false;
           }

           $("#estnColumn7").val($("#estnColumn7").val());
           
         //내용
           if ("${boardConfVo.userEditorYn}" =='Y'){
               if(CKEDITOR.instances.bbscttCn.getData() == ""){
                   alert(Message.msg.chkContent);
                   $("#bbscttCn").focus();
                   return false;
               }else{
                   if(CKEDITOR.instances.bbscttCn.getData().length < 11){
                       alert(Message.msg.characters10);
                       $("#bbscttCn").focus();
                       return false;
                   }
               }
           }else{
               if($("#bbscttCn").val().length == 0) {
                   alert(Message.msg.chkContent);
                   $("#bbscttCn").focus();
                   return false;
               } else if($("#bbscttCn").val().length < 11) {
                   alert(Message.msg.characters10);
                   $("#bbscttCn").focus();
                   return false;
               }
           }
         
         //태그중복체크
          if(OpenWorks.tagYn == 'Y'){
              var bbsTags = $("#bbsTags").val().split(",");
              
              for(var i =0; i < bbsTags.length; i++){
                  for(var j=0; j< bbsTags.length; j++){
                      if(bbsTags[i] == bbsTags[j] && i !=j){
                          alert("중복된 태그 내용이 포함되어 있습니다.");
                          return;
                      }
                  }
              }
              
          }
         
           $("#dataForm").submit();
	    }
	   
	   var jsCancel = function() {
           location.reload();
       };
	   
	   
	</script>
	<!-- 사용자 스크립트 끝  -->
</head>
<body>

	<c:choose>
		<c:when test="${pageType eq 'INSERT'}">
			<c:set var="action" value="ND_board.insert.do" />
			<c:set var="title" value="작성" />
			<c:set var="button" value="/resources/web/theme/default/images/btn/btn_regist.gif" />
		</c:when>
		<c:when test="${pageType eq 'UPDATE'}">
			<c:set var="action" value="ND_board.update.do" />
			<c:set var="title" value="수정" />
			<c:set var="button" value="/resources/web/theme/default/images/btn/btn_edit.gif" />
		</c:when>
		<c:otherwise>
			<c:set var="action" value="ND_board.reply.do" />
			<c:set var="title" value="답글" />
			<c:set var="button" value="/resources/web/theme/default/images/btn/btn_regist.gif" />
		</c:otherwise>
	</c:choose>


	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">

	<%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
	<op:pagerParam view="view" />

	<input type="hidden" name="domainCd" value="<c:out value='${dataVo.domainCd}'/>"/>
	<input type="hidden" name="bbsCd" value="<c:out value='${dataVo.bbsCd}'/>"/>
	<input type="hidden" name="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}'/>"/>
	<input type="hidden" name="refrnSeq" value="<c:out value='${dataVo.refrnSeq}'/>"/>
	<input type="hidden" name="bbscttOrdrNo" value="<c:out value='${dataVo.bbscttOrdrNo}'/>"/>
	<input type="hidden" name="bbscttDp" value="<c:out value='${dataVo.bbscttDp}'/>"/>
	<input type="hidden" name="mngrId" value="<c:out value='${dataVo.mngrId}'/>"/>
	<input type="hidden" name="brwsrAgent" id="brwsrAgent" value="<c:out value='${dataVo.brwsrAgent}'/>"/>
	<input type="hidden" name="estnColumn3" value="<c:out value='N'/>"/>
	<input type="hidden" name="section" value="<c:out value='myboardQ'/>" />
	

	<!-- contents -->
			<div class="contents">
				<!-- title-area -->
				<div class="title-area">
					<h2>묻고 답하기</h2>					
				</div>
				<!-- //title-area -->
				
				<!-- section -->
				<div class="section">
					<!-- write -->
					<div class="type-write-board">
						<table>
							<caption>글쓰기</caption>
							<colgroup>
							<col style="width:110px;"/>
							<col style="width:;"/>
							</colgroup>							
							<tbody>
								<tr>
									<th><span>구분</span></th>
									<td>
										<c:if test="${boardConfVo.ctgYn eq 'Y'}">
											<!-- static select -->
											<div class="select-area">
												<!-- select box -->
												<div class="sech_form">
													<div class="cont_wrap">
														<div class="selected">
															<select id="ctgCd" name="ctgCd" title="구분을 선택해주세요" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 115px; position: absolute; left: -100000px; height: auto;">
																<option value="">선택해 주세요.</option>
								                                <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
								                                    <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>><c:out value='${ctgVo.ctgNm}'/></option>
								                                </c:forEach>
															</select>
														</div>
													</div>
												</div>
												<!-- //select box -->
											</div>
											<!-- //static select -->
			                            </c:if> 
									</td>
								</tr>
								<tr>
									<th><span>제목</span></th>
									<td>
										<input type="text" name="bbscttSj" id="bbscttSj" class="w700" title="제목을 입력해주세요" value="${dataVo.bbscttSj}" />
									</td>
								</tr>
								<c:if test="${ boardConfVo.noticeBbscttUseYn eq 'Y' }">
				                    <tr>
				                        <th><span>기본 설정 *</span></th>
				                        <td>
				                            <c:choose>
				                                <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
				                                    <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="Y"<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
				                                    <label for="noticeBbscttAt">&nbsp;공지로 지정</label>
				                                </c:when>
				                                <c:otherwise>
				                                    <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="<c:out value='N' />"/>
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                    </tr>
				                </c:if>
				                <tr>
									<td colspan="2">
										<div id="contentsErrorDiv"></div>
										<c:if test="${boardConfVo.userEditorYn eq 'Y'}" >
				                            <textarea name="bbscttCn" id="bbscttCn" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
				                            <script type="text/javascript">
				                                //<![CDATA[
				                                CKEDITOR.replace('bbscttCn', {
				                                    height : 200,
				                                    enterMode : "2",
				                                    skin : "moono",
				                                    allowedContent: true,
				                                    toolbar : toolbar_config.default_toolbar,
				                                    filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
				                                });
				                                //]]>
				                            </script>
				                        </c:if>
				                        <c:if test="${boardConfVo.userEditorYn eq 'N'}" >
				                            <textarea name="bbscttCn" id="bbscttCn" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
				                        </c:if>
									</td>
								</tr>
								<!-- 파일 업로드 -->
				                <c:if test="${boardConfVo.fileYn eq 'Y'}" >
				                    <tr>
				                        <th><span>첨부파일</span></th>
				                        <td>
				                            <c:if test="${pageType eq 'UPDATE'}">
				                                <c:if test="${fn:length(dataVo.fileList) > 0}">
				                                    <p class="tx_blue_s">
				                                        - 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요.
				                                    </p>
				                                    <ul>
				                                        <c:forEach items="${dataVo.fileList}" var="fileVo">
				                                            <li class="mar_b5">
				                                                <a href="#" onclick="jsFileDelete(this, '<c:out value='${fileVo.fileSeq}'/>', '<c:out value='${fileVo.fileId}'/>');"><img src="<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />" alt="삭제" class="vm" /></a>
				                                                <c:out value='${fileVo.localNm}'/> <span class="tx_gray vm">(download <c:out value='${fileVo.downCnt}'/>, <c:out value='${fileVo.fileSize}'/>, <c:out value='${fileVo.fileType}'/>)</span>
				                                            </li>
				                                        </c:forEach>
				                                    </ul>
				                                </c:if>
				                            </c:if>
				                            <input type="hidden" name="fileSeq" id="fileSeq" value="<c:out value='${dataVo.fileSeq}'/>"/>
				                            <input type="file"  name="multiFiles" id="multiFiles" <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기"  style="width:570px; height: 24px;"/>
				                            <div id="multiFilesListDiv" class="regist-file"></div>
				                            <p class="caption mt10">
				                                * <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>최대 ${boardConfVo.maxFileCnt}개까지 업로드 할 수 있습니다.
				                                <c:if test="${boardConfVo.maxFileSize > 0}">파일당 ${boardConfVo.maxFileSize}MB</c:if>
				                                <c:if test="${(boardConfVo.maxFileSize > 0) && (boardConfVo.totalFileSize > 0)}">, </c:if>
				                                <c:if test="${boardConfVo.totalFileSize > 0}">전체 ${boardConfVo.totalFileSize}MB</c:if>
				                                <c:if test="${(boardConfVo.maxFileSize > 0) || (boardConfVo.totalFileSize > 0)}"> 업로드 할 수 있습니다.</c:if>
				                            </p>
				                            <input type="hidden" id="uploadFileCnt" value="<c:out value='${dataVo.fileCnt}'/>"/>
				                        </td>
				                    </tr>
				                </c:if>
				                <c:if test="${ boardConfVo.othbcYn eq 'Y' }">
				                    <tr>
				                        <th><span>공개여부</span></th>
				                        <td>
				                            <c:choose>
				                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
				                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if>  />
				                                    <label for="othbcAtY" class="space">&nbsp;공개</label>
				                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> />
				                                    <label for="othbcAtN">&nbsp;비공개</label>
				                                </c:when>
				                                <c:otherwise>
				                                    <input type="hidden" name="othbcAt" value="<c:out value='Y' />"/>
				                                </c:otherwise>
				                            </c:choose>
				                        </td>
				                    </tr>
				                </c:if>
				                <!-- 태그 입력 -->
				                <c:if test="${boardConfVo.tagYn eq 'Y'}">
				                    <tr>
				                        <th><span>태그</span></th>
				                        <td>
				                        	<input type="text" name="bbsTags" id="bbsTags" class="w700" value="${fn:join(dataVo.bbsTags, ',')}" title="태그"/>
											<p class="caption mt10">* 쉼표로 구분하여 태그를 입력해 주세요.</p>
				                        </td>
				                    </tr>
				                </c:if>
							</tbody>
						</table>
					</div>
					<!-- //write -->
					<!-- btn area -->
					<div class="btn-area ar mt20">
						<a href="#" onclick="jsSubmit();  return false;" class="b-btn save type2"><strong><span>저 장</span></strong></a>
						<a href="#" onclick="jsCancel(); return false;" class="b-btn cancel type1"><strong><span>취 소</span></strong></a>
					</div>
					<!-- //btn area -->
					<div class="btn-area mt20">
				         <ul>
				             <li>고객님의 소중한 의견을 수렴하는 공간입니다. 씨앗 클라우드에 바라는 내용을 등록해 주세요.</li>
				             <li>상업적 글이나 무고, 욕설, 비방, 개인정보등과 관련된 글을 올리는 경우 삭제 될 수 있습니다.</li>
				         </ul>
				     </div>
				</div>
				<!-- //section -->
			</div>
			<!-- //contents -->

</body>
</html>