<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title>게시물 ${pageType eq 'INSERT'? '등록':'수정'}</title>

	<op:jsTag type="openworks" items="validate, ckeditor" />
	<op:jsTag type="spi" items="form, validate, multifile, ui" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/agent.detector.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/intra/board/board.js"></script>

	<!-- 사용자 스크립트 시작  -->	
	<script type="text/javascript">

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }
		
        OpenWorks.domainCd      = "${boardConfVo.domainCd}";
		OpenWorks.bbsCd			= "${boardConfVo.bbsCd}";
		OpenWorks.pageType		= "${pageType}";
		OpenWorks.boardNm		= "${boardConfVo.bbsNm}";
		OpenWorks.boardType		= "${boardConfVo.kndCd}";
		OpenWorks.useCategory	= "${boardConfVo.ctgYn}";
		OpenWorks.fileYn		= "${boardConfVo.fileYn}";
		OpenWorks.uploadTy	    = "${boardConfVo.uploadTy}";
		OpenWorks.maxFileCnt	= "${boardConfVo.maxFileCnt}";
		OpenWorks.maxFileSize	= "${boardConfVo.maxFileSize}";
		OpenWorks.totalFileSize	= "${boardConfVo.totalFileSize}";
		OpenWorks.filePermExtsn	= "${boardConfVo.filePermExtsn}";
		OpenWorks.closeFileIcon	= "<c:url value='/resources/openworks/theme/default/images/btn/btn_r_close.gif' />";
		OpenWorks.captchaYn		= "${boardConfVo.captchaYn}";
		OpenWorks.fileCnt		= ${dataVo.fileCnt};
		OpenWorks.tagYn			= "${boardConfVo.tagYn}";
		OpenWorks.bannedWordYn	= "${boardConfVo.bannedWordYn}";
		OpenWorks.editorYn		= "${boardConfVo.mngrEditorYn}";

		onReadyEventFunctions();

		$("#brwsrAgent").val(UserAgent);

		//dataForm 유효성 체크 
		SharedOpenWorks.jsSetFormValidate = function(){

			var submitFunction = function(form){
			    $("#aditCtgNm").val($("#aditCtgCd option:selected").text());
			    var bbsCd = $("#bbsCd").val();
			    //내용
		         if ("${boardConfVo.mngrEditorYn}" =='Y'){
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
		             };
		         }else{
		             if($("#bbscttCn").val().length == 0) {
		                 alert(Message.msg.chkContent);
		                 $("#bbscttCn").focus();
		                 return false;
		             } else if( bbsCd == 1008){
		                 if($("#bbscttCn").val().length < 200) {
		                     alert("최소 200자 이상입력해주세요");
		                     $("#bbscttCn").focus();
		                     return false;
		                 };
		             }else if( bbsCd != 1008){
		                 if($("#bbscttCn").val().length < 11) {
		                     alert(Message.msg.characters10);
		                     $("#bbscttCn").focus();
		                     return false;
		                 }
		             }
		         }
			    var bbsCd= $("input[name=bbsCd]").val();
		       //첨부파일 없을 경우 확인사항
		         <c:choose>
		             <c:when test="${pageType == 'INSERT'}">
		             if(bbsCd == 1009) {
		                 if($("#multiFiles").val() == "") {
		                     alert(Message.msg.chkImage);
		                     $("#multiFiles").focus();
		                     return false;
		                 }
		             }
		             </c:when>
		             <c:when test="${pageType == 'UPDATE'}">
		             if(bbsCd == 1009){
		                 if($("#multiFiles").val() == "" && $("#fileSeq").val() == "") {
		                     alert(Message.msg.chkImage);
		                     $("#multiFiles").focus();
		                     return false;
		                 }
		             }
		             </c:when>
		         </c:choose>
		         
		         
			    
				<c:choose>
					<c:when test="${boardConfVo.bannedWordYn eq 'Y'}">
						$.post("ND_check.ban.do", {
	                        domainCd : OpenWorks.domainCd,
							bbsCd : OpenWorks.bbsCd,
							bbscttSj : $("#bbscttSj").val(),
							bbscttCn : $("textarea[name=bbscttCn]").val()
						}, function(result){
							if(result.result == true){
								var msg = result.message.replace("\n\n", "<br />");
								jsWarningBox(msg);
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
	
	//2depth 조회
	function aditCtgSel(){

	    var ctgCd = $("#ctgCd option:selected").val();
	    $.ajax({
            url: 'ND_aditCtgList.do',
            type: "GET",
            data: {domainCd : OpenWorks.domainCd,
                bbsCd : OpenWorks.bbsCd,
                ctgCd : ctgCd}, 
            dataType: "JSON",
            async:false,
            success: function(datalist) {
                var selectString = "";
                if(datalist.length > 0) {
                    $("td[id='aditCtgList']").empty();
                    selectString += "<select id='aditCtgCd' name='aditCtgCd' title='분류를 선택해주세요'>";
                    selectString += "<option value='''>- 구분선택 2 -</option>";
                    for(var i = 0; i < datalist.length; i++) {
                        selectString += "<option value='"+datalist[i].aditCtgCd+"'>"+datalist[i].aditCtgNm+"</option>";
                    }
                    selectString += " </select>";
                    $("td[id='aditCtgList']").append(selectString);
                    
                }
                
            }
        });



	}

	//첨부된 파일중 ajax를 이용하여 파일 삭제
	var jsFileDelete = function(element, seq, id){
		if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
			return false;

		var url = "ND_file.delete.do";
		$.post(url, 
			{ fileId : id, 
			fileSeq : seq, 
			bbsCd : "${dataVo.bbsCd}",
	        domainCd : "${dataVo.domainCd}"	 }, 
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
			<c:set var="button" value="등록" />
		</c:when>
		<c:when test="${pageType eq 'UPDATE'}">
			<c:set var="action" value="ND_board.update.do" />
			<c:set var="title" value="수정" />
			<c:set var="button" value="수정" />
		</c:when>
		<c:otherwise>
			<c:set var="action" value="ND_board.reply.do" />
			<c:set var="title" value="답글" />
			<c:set var="button" value="등록" />
		</c:otherwise>
	</c:choose>

	<div class="po_rel">
		<h4>${boardConfVo.bbsNm} ${bbscttSj}</h4>
		<div class="h4_r">
			<span class="tx_red tx_b">*</span> 표시는 필수입력사항입니다.
		</div>
	</div>

	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" action="${action}" onsubmit="return false;">

	<%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
	<op:pagerParam view="view" />

    <input type="hidden" name="domainCd" id="domainCd" value='${dataVo.domainCd}' />
	<input type="hidden" name="bbsCd" value='${dataVo.bbsCd}' />
	<input type="hidden" name="bbscttSeq" value='${dataVo.bbscttSeq}' />
	<input type="hidden" name="refrnSeq" value='${dataVo.refrnSeq}' />
	<input type="hidden" name="bbscttOrdrNo" value='${dataVo.bbscttOrdrNo}' />
	<input type="hidden" name="bbscttDp" value='${dataVo.bbscttDp}' />
	<input type="hidden" name="mngrId" value='${dataVo.mngrId}' />
	<input type="hidden" name="brwsrAgent" id="brwsrAgent" value='${dataVo.brwsrAgent}' />
	<input type="hidden" name="aditCtgNm" id="aditCtgNm" value='' />

	<!-- 내용쓰기 -->
	<fieldset>
		<legend>글입력</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="게시판 내용 작성페이지입니다.">
			<caption class="hidden">게시판 글입력 페이지</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="registerNm">작성자 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<input type="text" name="registerNm" id="registerNm" value="${dataVo.registerNm}" />
						<valid:msg name="registerNm" />
					</td>
				</tr>
				<tr>
					<th><label for="bbscttSj">제목 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<input type="text" name="bbscttSj" id="bbscttSj" class="w85_p" title="제목을 입력해주세요" value="${dataVo.bbscttSj}" />
						
						<valid:msg name="bbscttSj" />
					</td>
				</tr>
				<c:if test="${boardConfVo.ctgYn eq 'Y' or boardConfVo.noticeBbscttUseYn eq 'Y' or boardConfVo.othbcYn eq 'Y'}">
                    <tr>
                        <th><label for="basicConf">기본 설정 (1depth) <span class="tx_red tx_b">*</span></label></th>
                        <td>
                            <c:if test="${boardConfVo.ctgYn eq 'Y'}">
                                <select id="ctgCd" name="ctgCd" title="분류를 선택해주세요" onchange="aditCtgSel();">
                                    <option value="">- 구분선택 1 -</option>
                                    <c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
                                        <option value="${ctgVo.ctgCd}"<c:if test="${ctgVo.ctgCd == dataVo.ctgCd}" > selected="selected"</c:if>>${ctgVo.ctgNm}</option>
                                    </c:forEach>
                                </select>
                                <valid:msg name="ctgCd" />
                            </c:if>

                            <c:choose>
                                <c:when test="${boardConfVo.noticeBbscttUseYn eq 'Y' && (pageType != 'REPLY')}">
                                    <input type="checkbox" class="checkbox" name="noticeBbscttAt" id="noticeBbscttAt" value="Y"<c:if test="${dataVo.noticeBbscttAt == 'Y'}"> checked='checked'</c:if> />
                                    <label for="noticeBbscttAt">&nbsp;공지로 지정</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="noticeBbscttAt" id="noticeBbscttAt" value="N" />
                                </c:otherwise>
                            </c:choose>

                            <c:choose>
                                <c:when test="${boardConfVo.othbcYn eq 'Y'}">
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtN" value="N"<c:if test="${dataVo.othbcAt == 'N'}"> checked='checked'</c:if> />
                                    <label for="othbcAtN">&nbsp;비공개</label>
                                    <input type="radio" class="radio" name="othbcAt" id="othbcAtY" value="Y"<c:if test="${(dataVo.othbcAt == null) || (dataVo.othbcAt != 'N')}"> checked='checked'</c:if> />
                                    <label for="othbcAtY">&nbsp;공개</label>
                                </c:when>
                                <c:otherwise>
                                    <input type="hidden" name="othbcAt" value="Y" />
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:if>
				<tr>
					<th><label for="bbscttCn">내용 <span class="tx_red tx_b">*</span></label></th>
					<td>
						<div id="contentsErrorDiv"></div>
						<c:if test="${boardConfVo.mngrEditorYn eq 'Y'}" >
							<textarea name="bbscttCn" id="bbscttCn" rows="15" class="w99_p" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
							<!-- <textarea name="bbscttCn" id="htmlContent" rows="10" cols="30" class="textarea" style="width:100%;">${dataVo.bbscttCn}</textarea> -->
								<script type="text/javascript">
								//<![CDATA[
								CKEDITOR.replace('bbscttCn', {
									height : 200,
									enterMode : "2",
									skin : "moono",
									toolbar : toolbar_config.default_toolbar,
									filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
								});
								//]]>
								</script>
						</c:if>
						<c:if test="${boardConfVo.mngrEditorYn eq 'N'}" >
							<textarea name="bbscttCn" id="bbscttCn" rows="15" class="w99_p" title="내용을 입력해주세요">${dataVo.bbscttCn}</textarea>
						</c:if>
						<valid:msg name="bbscttCn" />
					</td>
				</tr>
				<!-- <tr>
					<th><label for="registPassword">비밀번호</label></th>
					<td>
						<input type="password" name="registPassword" id="registPassword" value="${dataVo.registPassword}" />

						<valid:msg name="registPassword" />
					</td>
				</tr> -->
				<c:forEach var="extensionVo" items="${boardConfVo.formColunms}">
					<c:if test="${!empty extensionVo.columnTy}">
						<tr>
							<th scope="row">${extensionVo.columnNm}<c:if test="${extensionVo.essntlYn eq 'Y'}"><span class="tx_red tx_b"> *</span></c:if></th>
							<td>
								<c:choose>
									<c:when test="${extensionVo.columnTy eq 'TEXT'}">
										<input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" class="w85_p" />
									</c:when>
									<c:when test="${extensionVo.columnTy eq 'TEXTAREA'}">
										<textarea name="${extensionVo.beanName}" id="${extensionVo.beanName}" cols="30" rows="3" class="w99_p"><op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/></textarea>
									</c:when>
									<c:when test="${extensionVo.columnTy eq 'DATE'}">
										<input name="${extensionVo.beanName}" id="${extensionVo.beanName}" value="<op:bean-util field="${extensionVo.columnId}" obj="${dataVo}"/>" type="text" maxlength="14" /> 예 : 20120101093000
										<p class="tx_blue_s">- 반드시 년월일시분초(14자리)까지 입력해야 합니다.</p>
									</c:when>
									<c:when test="${extensionVo.columnTy eq 'EMAIL'}">
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
						<th><label for="file">첨부파일</label></th>
						<td>
							<c:if test="${pageType eq 'UPDATE'}">
								<c:if test="${fn:length(dataVo.fileList) > 0}">
									<p class="tx_blue_s">
										- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요.
									</p>
									<ul>
										<c:forEach items="${dataVo.fileList}" var="fileVo">
											<li class="mar_b5">
												<!-- <input type="checkbox" name="fileIds" value="${fileVo.fileId }" />
												<a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}">${fileVo.localNm}</a> -->
												<a href="#" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
												${fileVo.localNm} <span class="tx_gray vm">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
											</li>
										</c:forEach>
									</ul>
								</c:if>
							</c:if>

							<div class="mar_t5 mar_b5">
								<input type="hidden" name="fileSeq" id="fileSeq" value="${dataVo.fileSeq}" />
								<input type="file" name="multiFiles" id="multiFiles" class="max-${boardConfVo.maxFileCnt} w470"  <c:if test="${boardConfVo.maxFileCnt <= dataVo.fileCnt}"> disabled="disabled"</c:if> value="찾아보기" />
								<div id="multiFilesListDiv" class="regist-file"></div>
							</div>
	
							<p class="tx_blue_s">
								- <c:if test="${fn:length(boardConfVo.filePermExtsn) >= 3 }"><script type="text/javascript">document.write("${boardConfVo.filePermExtsn}".replace(/\|/g, ', ')); </script> 파일 첨부 가능, </c:if>
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
						<th><label for="tagYn">태그 입력</label></th>
						<td>
							<input type="text" name="bbsTags" id="bbsTags" class="w85_p" value="${fn:join(dataVo.bbsTags, ',')}" title="태그" />
							<p class="tx_blue_s">- 쉼표로 구분하여 태그를 입력해 주세요.</p>
						</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</fieldset>
	<!-- //내용쓰기 -->

	<!-- 버튼 -->
	<div class="btn_r">
		<ul>
			<li><input type="button" value="취소" class="w_blue" onclick="location.reload();" /></li>
			<li><input type="submit" value="${button}" class="w_blue" /></li>
			<li><input type="button" value="목록" class="blue" onclick="jsList();" /></li>
		</ul>
	</div>
	<!-- //버튼 -->

	</form>

</body>
</html>