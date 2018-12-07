<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title></title>

	<op:jsTag type="openworks" items="validate, ckeditor" />
	<op:jsTag type="spi" items="form, validate, multifile" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/agent.detector.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>

	<!-- 사용자 스크립트 시작  -->
	<script type="text/javascript">

	$().ready(function(){

		//게시판 설정값들을 초기화 합니다.
		if(typeof OpenWorks == "undefined"){ OpenWorks = {}; }

		OpenWorks.domainCd		= "<c:out value='${boardConfVo.domainCd}'/>";
		OpenWorks.bbsCd			= "<c:out value='${boardConfVo.bbsCd}'/>";
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
				    bbscttSj : { required:true }
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
	
	
    var jsProductPop = function (el) {

	var domainCd="${boardConfVo.domainCd}";
	var bbsCd="${boardConfVo.bbsCd}";
	var purchs="${dataVo.estnColumn7}";
	var estnColumn7=$("#estnColumn7").val();
	var bbscttSeq=$("#bbscttSeq").val();
	var chkPurchsNo =$("#chkPurchsNo").val();
	
	var purchsNo=purchs.split("_");
        $(el).colorbox({
            title : Message.msg.prdouct01,
            href : "/web/board/PD_product.do?domainCd="+domainCd+"&bbsCd="+bbsCd+"&estnColumn7="+estnColumn7+"&orderNo="+purchsNo[0]+"&bbscttSeq="+bbscttSeq+"&chkPurchsNo="+chkPurchsNo,
            width : "700",
            height : "600",
            overlayClose : false,
            escKey : false,
            iframe : true
        });

    };
	
	function jsSubmit() {
	        
	   var bbsCd= $("input[name=bbsCd]").val();
	    
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
            
        //첨부파일 없을 경우 확인사항
         <c:choose>
             <c:when test="${pageType == 'INSERT'}">
             if(bbsCd == 1008) {
                 if($("#multiFiles").val() == "") {
                     alert(Message.msg.chkImage);
                     $("#multiFiles").focus();
                     return false;
                 }
             }
             </c:when>
             <c:when test="${pageType == 'UPDATE'}">
             if(bbsCd == 1008){
                 if($("#multiFiles").val() == "" && $("#fileSeq").val() == "") {
                     alert(Message.msg.chkImage);
                     $("#multiFiles").focus();
                     return false;
                 }
             }
             </c:when>
         </c:choose>
         
         //서비스
         if(bbsCd == 1008 &&  $("#estnColumn7").val() == ""){
             alert(Message.msg.selProduct);
             return;
         }else{
             $("#estnColumn7").val($("#purchsNo").val());
         }
         
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
                 };
             };
         }else{
             if($("#bbscttCn").val().length == 0) {
                 alert(Message.msg.chkContent);
                 $("#bbscttCn").focus();
                 return false;
             } else if( bbsCd == 1008){
                 if($("#bbscttCn").val().length < 200) {
	                 alert(Message.msg.characters200);
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
	
	// textarea 글자수 제한 
    function fc_chk_byte(aro_name, ari_max, span) {
	    
        if($("input[name=bbsCd]").val() == 1008){
          ari_max = 5000;   
        }
        var ls_str = aro_name.value; // 이벤트가 일어난 컨트롤의 value 값 
        var li_str_len = ls_str.length; // 전체길이 

        // 변수초기화 
        var li_max = ari_max; // 제한할 글자수 크기 
        var i = 0; // for문에 사용 
        var li_byte = 0; // 한글일경우는 2 그밗에는 1을 더함 
        var li_char = 0;
        // var li_len      = 0;  // substring하기 위해서 사용 
        var ls_one_char = ""; // 한글자씩 검사한다 
        var ls_str2 = ""; // 글자수를 초과하면 제한할수 글자전까지만 보여준다. 

        for(i = 0; i < li_str_len; i++) {
            // 한글자추출 
            ls_one_char = ls_str.charAt(i);

            // 한글이면 2를 더한다. 
            if(escape(ls_one_char).length > 4) {
                li_byte = li_byte + 3;
                li_char++;
            }
            // 그외의 경우는 1을 더한다. 
            else {
                li_byte++;
                li_char++;
            }

            // 전체 크기가 li_max를 넘지않으면 
            if(li_byte <= li_max * 3) {
                li_len = i + 1;
            }
        }

        // 전체길이를 초과하면 li_byte 
//         document.getElementById(span).innerHTML = "<em>" + li_char + "</em>" + "/" + li_max;
        if(li_char > li_max) {
            //aro_name.value=li_char; 
            alert(li_max + " 글자를 초과 입력할 수 없습니다. \n 초과된 내용은 자동으로 삭제 됩니다. ");
            ls_str2 = ls_str.substr(0, li_max);
            aro_name.value = ls_str2;
            fc_chk_byte(aro_name, ari_max, span);
        }
        aro_name.focus();
    };
	
    var jsCancel = function() {
        location.reload();
    };
    
	//2depth 조회
	function aditCtgSel(val){
	    var ctgCd = val;//$("#q_searchKeyType option:selected").val();
	    alert(ctgCd);
	    $.ajax({
            url: 'ND_aditCtgList.do',
            type: "GET",
            data: {domainCd : OpenWorks.domainCd,
                bbsCd : OpenWorks.bbsCd,
                ctgCd : ctgCd}, 
            dataType: "JSON",
            async:false,
            success: function(datalist) {
            	console.log(datalist);
                var selectString = "";
                if(datalist.length > 0) {
                		
                	selectString = "<select id=\"q_searchKeyType\" name=\"q_searchKeyType\" title=\"분류를 선택해주세요\" style=\"width: 115px; position: absolute; left: -100000px; height: auto;\">";
                  selectString += "<option value='''>- 구분선택 2 -</option>";
                    for(var i = 0; i < datalist.length; i++) {
                        selectString += "<option value='"+datalist[i].aditCtgCd+"'>"+datalist[i].aditCtgNm+"</option>";
                    }
                  selectString += " </select>";
                  $("#aditCtgList").append(selectString);
               }
            }
        });
	}
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

    <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${dataVo.domainCd}' />" />
    <input type="hidden" name="bbsCd"  id="bbsCd" value="<c:out value='${dataVo.bbsCd}' />" />
    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value="<c:out value='${dataVo.bbscttSeq}' />" />
    <input type="hidden" name="refrnSeq" id="refrnSeq" value="<c:out value='${dataVo.refrnSeq}' />" />
    <input type="hidden" name="bbscttOrdrNo"  id="bbscttOrdrNo" value="<c:out value='${dataVo.bbscttOrdrNo}' />" />
    <input type="hidden" name="bbscttDp" id="bbscttDp" value="<c:out value='${dataVo.bbscttDp}' />" />
    <input type="hidden" name="mngrId" id="mngrId" value="<c:out value='${dataVo.mngrId}' />" />
    <input type="hidden" name="brwsrAgent" id="brwsrAgent" value="<c:out value='${dataVo.brwsrAgent}' />" />
    <input type="hidden" name="purchsNo" id="purchsNo" value="<c:out value='' />" />
    <input type="hidden" name="chkPurchsNo" id="chkPurchsNo" value="<c:out value='' />" />
	        
         <!-- tbl_write -->
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
         <!-- //tbl_write -->
    </form>

</body>
</html>