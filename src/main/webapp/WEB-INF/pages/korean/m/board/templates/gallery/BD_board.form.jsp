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

		OpenWorks.bbsCd			= "${boardConfVo.bbsCd}";
		OpenWorks.pageType		= "${pageType}";
		OpenWorks.boardNm		= "${boardConfVo.bbsNm}";
		OpenWorks.boardType		= "${boardConfVo.kindCd}";
		OpenWorks.useCategory	= "${boardConfVo.ctgYn}";
		OpenWorks.fileYn		= "${boardConfVo.fileYn}";
		OpenWorks.uploadType	= "${boardConfVo.uploadType}";
		OpenWorks.maxFileCnt	= "${boardConfVo.maxFileCnt}";
		OpenWorks.maxFileSize	= "${boardConfVo.maxFileSize}";
		OpenWorks.totalFileSize	= "${boardConfVo.totalFileSize}";
		OpenWorks.fileExts		= "${boardConfVo.fileExts}";
		OpenWorks.closeFileIcon	= "<c:url value='/resources/openworks/theme/default/images/btn/btn_r_close.gif' />";
		OpenWorks.captchaYn		= "${boardConfVo.captchaYn}";
		OpenWorks.fileCnt		= ${dataVo.fileCnt};
		OpenWorks.tagYn			= "${boardConfVo.tagYn}";
		OpenWorks.bannedWordYn			= "${boardConfVo.bannedWordYn}";
		OpenWorks.editorYn		= "${boardConfVo.usrEditorYn}";

		onReadyEventFunctions();

		$("#agent").val(UserAgent);

		//dataForm 유효성 체크
		SharedOpenWorks.jsSetFormValidate = function(){

			var submitFunction = function(form){
				if($("#dataForm input[name=openYn]:checked").val() == "N"){
					if($("#regPwd").val() == ""){
						$("#regPwd").focus();
						return;
					}
				}
				<c:choose>
					<c:when test="${boardConfVo.bannedWordYn eq 'Y'}">
						$.post("ND_check.ban.do", {
							bbsCd : OpenWorks.bbsCd,
							bbscttSj : $("#bbscttSj").val(),
							contents : $("textarea[name=contents]").val()
						}, function(result){
							if(result.result == true){
							    alert(result.message);
								return;
							}else{
								if($("#dataForm").valid() === true){
									if(OpenWorks.uploadType == "1001"){
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
							if(OpenWorks.uploadType == "1001"){
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
				if(element.attr("name") == "contents"){
					error.prependTo($("#contentsErrorDiv"));
				}else{
					error.insertBefore(element);
				}
			};

			$("#dataForm").validate({
				//유효성 검증 BEAN Annotation 기반 자동 설정
				//<valid:script type="jquery" />,
				rules: {
					regNm :		{ required:true, minlength:2, maxlength:10 },
					bbscttSj :		{ required:true, minlength:3, maxlength:200 },
					contents :	{ required:true, minlength:10 }
					<c:if test="${boardConfVo.ctgYn eq 'Y'}">
						,ctgCd :	{ required:true }
					</c:if>
					<c:if test="${boardConfVo.fileYn eq 'Y' and dataVo.fileCnt eq 0}">
						,multiFiles :	{ required:true }
					</c:if>
					<c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
						<c:if test="${!empty extensionVo.columnType and extensionVo.requireYn eq 'Y'}">
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

					if(OpenWorks.maxFileCnt <= OpenWorks.fileCnt)
						self.location.reload();

					if(eval($("#uploadFileCnt").val()) > 0)
						$("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
					else $("#uploadFileCnt").val(0);

					$.fn.MultiFile.reEnableEmpty();

				}else{
					alert('파일을 삭제하지 못했습니다.');
				}
			}, 'json');
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

	<h4>${boardConfVo.bbsNm} ${bbscttSj}</h4>
	<p><span class="tx_red tx_b mar_b10 mar_l5">*</span> 표시는 필수입력사항입니다.</p>

	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">

	<%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
	<op:pagerParam view="view" />

	<input type="hidden" name="bbsCd" value='${dataVo.bbsCd}' />
	<input type="hidden" name="seq" value='${dataVo.seq}' />
	<input type="hidden" name="refSeq" value='${dataVo.refSeq}' />
	<input type="hidden" name="orderNo" value='${dataVo.orderNo}' />
	<input type="hidden" name="depth" value='${dataVo.depth}' />
	<input type="hidden" name="mgrId" value='${dataVo.mgrId}' />
	<input type="hidden" name="agent" id="agent" value='${dataVo.agent}' />

	<!-- 내용쓰기 -->
	<fieldset>
		<legend>글입력</legend>
		<table class="gray_write" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
			<caption class="hidden">게시판 글입력 페이지</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="regNm">작성자 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<input type="text" name="regNm" id="regNm" value="${dataVo.regNm}" />
						<valid:msg name="regNm" />
					</td>
				</tr>
				<tr>
					<th><label for="title">제목 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<input type="text" name="bbscttSj" id="bbscttSj" class="w85_p" title="제목을 입력해주세요" value="${dataVo.bbscttSj}" />
						<valid:msg name="bbscttSj" />
					</td>
				</tr>
				<c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeYn eq 'Y' or boardConfVo.openYn eq 'Y'}">
					<tr>
						<th>기본 설정 <span class="tx_red tx_b">*</span></th>
						<td>
							<c:if test="${boardConfVo.ctgYn eq 'Y'}">
								<select id="ctgCd" name="ctgCd" title="분류를 선택해주세요">
									<option value="">분류 선택</option>
									<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
										<option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
									</c:forEach>
								</select>
								<valid:msg name="ctgCd" />
							</c:if>

							<c:choose>
								<c:when test="${boardConfVo.noticeYn eq 'Y' && (pageType != 'REPLY')}">
									<input type="checkbox" class="checkbox" name="noticeYn" id="noticeYn" value="Y"<c:if test="${dataVo.noticeYn == 'Y'}"> checked='checked'</c:if> />
									<label for="noticeYn">&nbsp;공지로 지정</label>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="noticeYn" id="noticeYn" value="N" />
								</c:otherwise>
							</c:choose>

							<c:choose>
								<c:when test="${boardConfVo.openYn eq 'Y'}">
									<input type="radio" class="radio" name="openYn" id="openYnN" value="N"<c:if test="${dataVo.openYn == 'N'}"> checked='checked'</c:if> onclick="$('#regPwdTR').show();" />
									<label for="openYnN">&nbsp;비공개</label>
									<input type="radio" class="radio" name="openYn" id="openYnY" value="Y"<c:if test="${(dataVo.openYn == null) || (dataVo.openYn != 'N')}"> checked='checked'</c:if> onclick="$('#regPwdTR').hide();" />
									<label for="openYnY">&nbsp;공개</label>
								</c:when>
								<c:otherwise>
									<input type="hidden" name="openYn" value="Y" />
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</c:if>

				<!-- 비공개 선택 시 비밀번호 입력 -->
				<tr id="regPwdTR"<c:if test="${dataVo.openYn eq 'Y'}"> class="none"</c:if>>
					<th><label for="regPwd">비밀번호<span class="tx_red tx_b"> *</span></label></th>
					<td>
						<input type="password" name="regPwd" id="regPwd" value="${dataVo.regPwd}" maxlength="20" />
						<valid:msg name="regPwd" />
					</td>
				</tr>

				<tr>
					<th><label for="contents">내용 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<div id="contentsErrorDiv"></div>
						<c:if test="${boardConfVo.usrEditorYn eq 'Y'}" >
							<textarea name="contents" id="htmlContent" rows="15" cols="30" class="w99_p" title="내용을 입력해주세요">${dataVo.contents}</textarea>
							<!-- <textarea name="contents" id="htmlContent" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.contents}</textarea> -->
								<script type="text/javascript">
								//<![CDATA[
								CKEDITOR.replace('htmlContent', {
									height : 200,
									enterMode : "2",
									skin : "moono",
									toolbar : toolbar_config.default_toolbar,
									filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
								});
								//]]>
								</script>
						</c:if>
						<c:if test="${boardConfVo.usrEditorYn eq 'N'}" >
							<textarea name="contents" id="textContent" rows="15" class="w99_p" title="내용을 입력해주세요">${dataVo.contents}</textarea>
						</c:if>
						<valid:msg name="contents" />
					</td>
				</tr>
				<c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
					<c:if test="${!empty extensionVo.columnType}">
						<tr>
							<th scope="row">${extensionVo.columnNm}<c:if test="${extensionVo.requireYn eq 'Y'}"><span class="tx_red tx_b"> *</span></c:if></th>
							<td>
								<c:choose>
									<c:when test="${extensionVo.columnType eq 'TEXT'}">
										<input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w85_p" />
									</c:when>
									<c:when test="${extensionVo.columnType eq 'TEXTAREA'}">
										<textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p"><op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/></textarea>
									</c:when>
									<c:when test="${extensionVo.columnType eq 'DATE'}">
										<input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" maxlength="14" /> 예 : 20120101093000
										<p class="tx_blue_s">- 반드시 년월일시분초(14자리)까지 입력해야 합니다.</p>
									</c:when>
									<c:when test="${extensionVo.columnType eq 'EMAIL'}">
										<input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w200" />
									</c:when>
								</c:choose>
								<c:if test="${not empty extensionVo.columnCm}">
									<p class="tx_blue_s">- ${extensionVo.columnCm}</p>
								</c:if>
							</td>
						</tr>
					</c:if>
				</c:forEach>

				<!-- 파일 업로드 -->
				<c:if test="${boardConfVo.fileYn eq 'Y'}" >
					<tr>
						<th>첨부파일 <span class="tx_red tx_b">*</span></th>
						<td>
							<c:if test="${pageType eq 'UPDATE'}">
								<c:if test="${fn:length(dataVo.fileList) > 0}">
									<p class="tx_blue_s">
										- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요.
									</p>
									<ul>
										<c:forEach items="${dataVo.fileList}" var="fileVo">
											<li class="mar_b5">
												<a href="#" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/web/theme/default/images/icon/icon_del_red.gif' />" alt="삭제" class="vm"></img></a>
												${fileVo.localNm} <span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
											</li>
										</c:forEach>
									</ul>
								</c:if>
							</c:if>

							<div class="mar_t5 mar_b5">
								<input type="hidden" name="fileSeq" id="fileSeq" value="${dataVo.fileSeq}" />
								<input type="file" name="multiFiles" id="multiFiles" class="multi max-${boardConfVo.maxFileCnt} w470" accept="${boardConfVo.fileExts}"<c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기" />
								<div id="multiFilesListDiv" class="regist-file"></div>
							</div>

							<p class="tx_blue_s">
								- <c:if test="${fn:length(boardConfVo.fileExts) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.fileExts}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>
								최대 ${boardConfVo.maxFileCnt}개까지 업로드 할 수 있습니다.
								<c:if test="${boardConfVo.maxFileSize > 0}">파일당 ${boardConfVo.maxFileSize}MB</c:if>
								<c:if test="${(boardConfVo.maxFileSize > 0) && (boardConfVo.totalFileSize > 0)}">, </c:if>
								<c:if test="${boardConfVo.totalFileSize > 0}">전체 ${boardConfVo.totalFileSize}MB</c:if>
								<c:if test="${(boardConfVo.maxFileSize > 0) || (boardConfVo.totalFileSize > 0)}"> 업로드 할 수 있습니다.</c:if>
							</p>
							<input type="hidden" id="uploadFileCnt" value="${dataVo.fileCnt}" />
						</td>
					</tr>
				</c:if>

				<!-- 태그 입력 -->
				<c:if test="${boardConfVo.tagYn eq 'Y'}">
					<tr>
						<th><label for="contents">태그 입력</label></th>
						<td>
							<input type="text" name="bbsTags" id="bbsTags" class="w85_p" value="${fn:join(dataVo.bbsTags, ',')}" title="태그" />
							<p class="tx_blue_s">- 쉼표로 구분하여 태그를 입력해 주세요.</p>
						</td>
					</tr>
				</c:if>

				<!-- 자동 작성 방지 -->
				<c:if test="${boardConfVo.captchaYn eq 'Y'}">
					<tr>
						<th><label for="contents">자동 작성 방지 <span class="tx_red tx_b">*</span></label></th>
						<td>
							<img src="<c:url value="/simpleCaptcha.do" />" alt="자동작성방지"/>
							<p>위의 이미지에 나타나는 문자를 입력해 주세요 : <input type="text" id="answer" name="answer" /></p>
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</fieldset>
	<!-- //내용쓰기 -->

	<!-- 버튼 -->
	<div class="float_r">
		<input type="image" alt="저장" src="${button}" />
		<input type="image" alt="취소" src="/resources/web/theme/default/images/btn/btn_cancel.gif" onclick="jsResetForm(); return false;" />
		<input type="image" alt="목록" src="/resources/web/theme/default/images/btn/btn_list.gif" onclick="jsList(); return false;" />
	</div>
	<!-- //버튼 -->

	</form>

</body>
</html>