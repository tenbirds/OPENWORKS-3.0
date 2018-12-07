<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*, java.text.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
	<title>게시물 등록</title>

	<op:jsTag type="openworks" items="validate, ckeditor" />
	   <op:jsTag type="spi" items="form, validate, multifile, datepicker" />

	<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/agent.detector.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
	<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>

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
		OpenWorks.endDt         = "<c:out value='${param.estnColumn6}'/>";

		onReadyEventFunctions();
		
		$('#endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/new_cloud/images/icon-btn/btn-calendar.gif" />',
            buttonImageOnly : true
        });
		
		$("#brwsrAgent").val(UserAgent);
		
		//종료일 세팅
		if(OpenWorks.pageType == "UPDATE"){
		    var estnColumn6Temp = $("#estnColumn6").val();
		    //alert(estnColumn6Temp);
		    if(estnColumn6Temp.substring(0,10) != "2030.12.31"){
		        $("#endDt").val(estnColumn6Temp.substring(0,4)+"-"+estnColumn6Temp.substring(5,7)+"-"+estnColumn6Temp.substring(8,10));
		    }
		}
		//내용 길이 표시
		cal_pre();

		//dataForm 유효성 체크
		SharedOpenWorks.jsSetFormValidate = function(){

			var submitFunction = function(form){
			    
			    var estnColumn6Temp = $("#endDt").val().split("-").join("") + $("#endHH").val() +$("#endMM").val()+"00";
                $("#estnColumn6").val(estnColumn6Temp);
                
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
					bbscttSj :		{ required:true,  maxlength:200 },
					bbscttCn :	{ required:true, minlength:10, maxlength:20000 }
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
	
	function jsSubmit() {
	    
	    
	    //카테고리선택여부
	    var ctgryCodes;
	    var ctgryDate =$("#ctgryCds").val();
	    
	    if(OpenWorks.pageType == "UPDATE"){
	        if(ctgryDate == null || ctgryDate == ""){//새로운카테고리로 수정한경우
	            ctgryCodes = $("#setCtgryCodes").val();
	        } else{
                ctgryCodes = $("#ctgryCds").val(); 
	        }
	    }else if(OpenWorks.pageType == "INSERT"){
	        ctgryCodes = $("#setCtgryCodes").val();
	    }
	    
	    if($.trim(ctgryCodes) == null || $.trim(ctgryCodes) == ''){
             alert(Message.msg.selctctgCd);
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
         
         
         <%
         Date date = new Date();
         SimpleDateFormat simpleDate = new SimpleDateFormat("yyyyMMdd");
         String strdate = simpleDate.format(date);
         %>
         
         //종료일
         var endDt = $("#endDt").val().split("-").join("");
         if(endDt.length < 1 ) {
             //alert(Message.msg.chkEndDt);
             //$("#endDt").focus();
             //return false;
             //$("#endDt").val("2030-12-31");
             //종료일이 입력 안되었을 경우 현재일자의 30일을 더한 날짜로 수정
             var date = new Date();
             date.setDate(date.getDate() + 30);
             var endDtYear = date.getFullYear().toString();
             var endDtMonth = (date.getMonth()+1).toString();
             var endDtDay = date.getDate().toString();
             endDt = endDtYear + "-" + (endDtMonth[1]?endDtMonth:"0"+endDtMonth[0]) + "-" + (endDtDay[1]?endDtDay:"0"+endDtDay[0]);
             $("#endDt").val(endDt);
         }else if(<%= strdate%> > endDt || <%= strdate%> == endDt){
             alert(Message.msg.chkEndDtAfterToday);
             $("#endDt").focus();
             return false;
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
        //내용길이 체크
        var size_check = document.getElementById("bbscttCn").value;
        if (size_check.bytes() > 20000){
            alert("작성하신 글은 "+size_check.bytes()+" Byte 이며 20,000 Byte 이하로 해주세요");
            $("#bbscttCn").focus();
            return false;
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
		if(!confirm(Message.msg.chkFileDelete))
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
    
	var jsCtgrySelPop = function(el) {
        
        $(el).colorbox({
            title : Message.msg.biz03,
             href : "PD_categoryPop.do?PID=BM01",
            width : "900",
            height : "740",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
    };
    
    var jsCtgrySel = function() {
        var ctgryCodes = $("#setCtgryCodes").val();
		if (ctgryCodes == "") {
        	$('table#goodsCtgry tr:lt(1)').remove();
            htmlVal = '<tr style="height: 62px;">';
            htmlVal += '<td class="tit"><label for="cs">'+Message.msg.biz01+'</label></td>';
            htmlVal += '<td class="last" id ="ctgryCodes" style="padding-top: 0px;">';
            htmlVal += '<span class="btn_light_gray02" ><a href="#" class="big" onclick="jsCtgrySelPop(this);" >'+Message.msg.biz02+'</a></span>';
            htmlVal += '<span> </span>';
            htmlVal += '</td>';
            htmlVal += '</tr>';
        }else {
			ctgryCodes = ctgryCodes.split(",")
             
            var ctgryCodeUrl = "";
            for (var i = 0; i < ctgryCodes.length; i++) {
                if (i > 0) {
                    ctgryCodeUrl += "&";
                }
                ctgryCodeUrl += "ctgryCodes=" + ctgryCodes[i]     
            }
             
            var url = "ND_ctgrySelect.do?" + ctgryCodeUrl;
            $.post(url, function(response){
                if(response.length > 0){
                    $('table#goodsCtgry tr:lt(1)').remove();
                    var htmlVal = "";
                    htmlVal += '<tr>';
                    htmlVal += '<th><span>' + Message.msg.biz02 + '</span></th>';
                    htmlVal += '<td>';
                    htmlVal += '<a href="#" onclick="jsCtgrySelPop(this);" class="s-btn radius type1"><strong><span>카테고리 선택</span></strong></a>';
                    htmlVal += '<span id="ctgry" style="position: absolute;">';
                    for (var i = 0; i < response.length; i++) {                         
                        if( i == 0){
                            htmlVal += '<input type="hidden" name="estnColumn8" id="estnColumn8" value="' + response[i].ctgryCode + '"/>';
                        }else if( i == 1){
                            htmlVal += '<input type="hidden" name="estnColumn9" id="estnColumn9" value="' + response[i].ctgryCode + '"/>';
                        }else{
                            htmlVal += '<input type="hidden" name="estnColumn10" id="estnColumn10" value="' + response[i].ctgryCode + '"/>';
                        }   
                        htmlVal += '['+response[i].ctgryClNm+']'+ response[i].ctgryPath+'<br/>';
                        htmlVal +='<input type="hidden" name="ctgryCds" id="ctgryCds" class="getCtgryCodes" value="' + response[i].ctgryCode + '" />';
                    }
                    htmlVal += '</span>';
                    htmlVal += '</td>';
		 			htmlVal += '</tr>';
		 			$('table#goodsCtgry tr:lt(1)').before(htmlVal);
        		}                
    		});
		}
	};
    
 
 var jsCancel = function() {
     location.reload();
 };

    //2015.09.11
    String.prototype.bytes = function(){
        var str = this;
        var l = 0;
        for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
        return l;
    }

    function cal_pre(){
        var size_check = document.getElementById("bbscttCn").value;
        document.getElementById("contentsByteCntDiv").value = size_check.bytes();
        document.getElementById("contentsByteCntDiv").value = size_check.bytes();
        document.getElementById("contentByteCntEm").innerHTML = size_check.bytes();
    }

    //function check(){
    //    var size_check = document.form.comment.value;
    //    if (size_check.bytes() > 200){
    //        alert("작성하신 글은 "+size_check.bytes()+" Byte 이며 200 Byte 이하로 해주세요");
    //    }else{
    //        alert("작성하신 글은 "+size_check.bytes()+" Byte 입니다.");
    //    }
    //}
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

</body>
</html>