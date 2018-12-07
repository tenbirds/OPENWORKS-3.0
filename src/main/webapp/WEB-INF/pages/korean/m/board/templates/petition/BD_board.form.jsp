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

	<op:jsTag type="openworks" items=" ckeditor" />
	<op:jsTag type="spi" items="form, validate ,multifile" />

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
		if(!confirm(Message.msg.deleteFileConfirm))
			return false;

		var url = "ND_file.delete.do";
		$.post(url,
			{ fileId : id, fileSeq : seq, bbsCd : "${dataVo.bbsCd}" },
			function(result){
				if(result == 1){
					$(element).parent().remove();
					if(OpenWorks.maxFileCnt <= OpenWorks.fileCnt) $("#multiFiles").attr("disabled",false); 
                    alert(Message.msg.fileDeleteY);

					if(eval($("#uploadFileCnt").val()) > 0) {
					    $("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
					}else{
					    $("#uploadFileCnt").val(0);  
					} 
					
					$.fn.MultiFile.reEnableEmpty();
				}else{
				    alert(Message.msg.fileDeleteN);
				};
			}, 'json');
	};
	
	
   function jsSubmit() {
       
       //구분
		if($("#ctgCd").val() == "" ){
			alert(Message.msg.selctgCd);
			$("#ctgCd").focus();
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
        }else if(subject.length < 3 ) {
             alert(Message.msg.minLengthTitle);
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
                          alert(Message.msg.chkTagOverLap);
                          return;
                      }
                  }
              }
          }
         
        $("#dataForm").submit();
    }
   
// 목록보기 버튼
   var jsList2 = function(page) {
       
       $("#dataForm input[name=q_currPage]").val(page);
       $("#dataForm input[name=q_searchKeyType]").val("");
       $("#dataForm input[name=q_searchVal]").val("");
       
       document.dataForm.action = "BD_board.list.do";
       document.dataForm.method = "get";
       document.dataForm.submit();
       
   };
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
	

	   <c:choose>
            <c:when test="${domCd eq 2}">
                <%@include file="korean/INC_board.form.jsp" %>
            </c:when>
            <c:when test="${domCd eq 3}">
                <%@include file="english/INC_board.form.jsp" %>
            </c:when>
            <c:when test="${domCd eq 4}">
                <%@include file="spanish/INC_board.form.jsp" %>
            </c:when>
         </c:choose>

	</form>

</body>
</html>