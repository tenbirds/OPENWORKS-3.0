<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>	
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	
	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}
	String nowURL = request.getRequestURI().toString();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
<c:if test="${userBoardView.othbcSetupCd == '1002' }">
	<c:if test="${cmMberInfo.cmmntyMberId != sessionScope['__usk'].userId}">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		//}}
	</script>
	</c:if>
	<c:if test="${empty cmMberInfo.cmmntyMberId }">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		//}}
	</script>
	</c:if>
	<c:if test="${empty sessionScope['__usk'].userId}">
	<script  type="text/javascript">
		alert(Message.msg.chkCmMemberOk); // 맴버만 공개된 글일경우
		// 이전소스
		//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		
		//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
		//}}
	</script>
	</c:if>
</c:if>
</c:if>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>Q&amp;A | 씨앗 마켓</title>
	<op:jsTag type="openworks" items="ckeditor" />
	<op:jsTag type="spi" items="form, validate, multifile" />
	<script type="text/javascript">
	$(document).ready(function() {
	    
	    tagNmArray(); // 태그 컴마로 설정.
	    <c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
	    cleanHtml();
	    </c:if>
	});
	
 	// 페이지 이동
   	var jrMove = function(movepage){
        $("#dataForm").attr("action",movepage).submit();
  	}; 
    // 게시판 등록
    var jsCmBoardInsert = function(){
	    if(validation.dataForm() === false){
        	return;
   		}
	    //alert( $("#tagNm").val());
	    if ( confirm(Message.msg.chkInsert) ) {
 	        $("#dataForm").ajaxSubmit({
   	            url      : "INC_cmQnABoardInsert.do",
   	            type     : "POST",
   	            dataType : "text",
   	            success  : function(response) {
   	                if (response == "true") {
   	                 	alert(Message.msg.chkCmBoardInsertOk);  
	                    jrMove("BD_cmQnABoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
	               } else { 
	                   alert(Message.msg.processFail);
	                   return;
	               }
   	            }
   	        });
      	 }
	 };
		
		// 게시판 수정
	    var jsCmBoardUpdate = function(){
		    if(validation.dataForm() === false){
	        	return;
	   		}
		    if ( confirm(Message.msg.chkModify) ) {
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmQnABoardUpdate.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.chkCmBoardUpdateOk);  
		                    jrMove("BD_cmQnABoardView.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
		               } else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
	   	            }
	   	        });
	      	 }
		};
    var validation = {     
            /** ajax submit validation **/
    		   dataForm : function() {
    		       
    		       var tagNm = $("#tagNm").val();
    		       /** 지역변수 **/
    		       if($("#bbscttSj").val() == ""){
    		           	//alert("제목을 입력 하시지 않았습니다.");
    		           	alert(Message.msg.chkCmBoardbbscttSj);
                       	$("#bbscttSj").focus();
    		            return false;
    		       } 
    		       if( typeof CKEDITOR.instances.bbscttCn != "undefined"){
	    		       if(CKEDITOR.instances.bbscttCn.getData() == ""){
	    		           alert(Message.msg.chkCmBoardbbscttCn);
	                       $("#bbscttCn").focus();
	                       return false;
	                   }else{
	                       $("#bbscttCn").val(CKEDITOR.instances.bbscttCn.getData());    
	                   }
    		       }else{
    		           if($("#bbscttCn").val()  == ""){
	    		           alert(Message.msg.chkCmBoardbbscttCn);
	                       $("#bbscttCn").focus();
	                       return false;
	                   }
    		       }
    		   }
    	};
    
	 	//글자수체크
	    var displayBytes  = function ( nm, id ){
	        var obj  = document.getElementById( id );
	            if (obj.value.bytes() > nm){
	                if (event.keyCode != '8'){
	                   // alert(nm+'바이트까지 입력이 가능합니다.'); 
	                    alert(nm+Message.msg.chkFormByteUntill );
	                }
	                obj.value = obj.value.substring(0, obj.value.length-10);
	            }
	            //eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
	    };
	    
	  //글자수체크 bytes 계산 속성 추가
	    String.prototype.bytes = function(){
	        var str = this;
	        var size = 0;
	        for (var i=0; i<str.length; i++){
	        	size += (str.charCodeAt(i) > 128) ? 2 : 1;
	        }
	        return size;
	    };
	    
	    var fileSel = function(el, inputNm){
		    $("#"+inputNm).val(el.value);
		    
// 		    jsPreview('file_add',inputNm, 0, 0, 5120,"exe,jsp,zip,class,alz");
		    //jsPreview('pfile1', '', inputNm , 1000, 170, 1024, "zip,alz,egg,jpg,jpeg,png,gif");
		    jsPreview('pfile1', inputNm , 3000, 3000, 10240, 'jpg,jpeg,png,gif,hwp,doc,docx,xls,xlsx,ppt,pptx,pdf,zip,rar,gz,tar');
		};
		//서비스이미지 용량,크기,비율 확인
		var jsPreview = function(inputId, inputNm, w, h, s, fileExt) {
	    	
		   // $("#"+inputNm).val();
		    var inputField = document.getElementById(inputId);        
	    	var source = inputField.value;
	    	//alert(inputField);
	    	//확장자 잘라내기
	    	var lastDot = source.lastIndexOf('.');
	   		var ext = source.substring(lastDot + 1);
	   		//alert(ext);
	   		//alert(ext.toLowerCase());
	   		//alert(fileExt.indexOf(ext.toLowerCase()));
	   		if(fileExt.indexOf(ext.toLowerCase()) == -1){
		        //alert( "지원하지 않는 이미지 형식입니다.\n jpg, png 형식만 가능합니다." );
		        alert(Message.msg.chkCmBoardFileExt);
		        inputField.value = "";
		        $("#"+inputNm).val("");
		    }else{
		
			    $("#inputName").val(inputId);
			    $("#maxFileSize").val(s);
			    $("#maxWidthSize").val(w);
			    $("#maxHeightSize").val(h);
			    $("#fileExt").val(fileExt);
			    		    
		        $("#dataForm").ajaxSubmit({
		            url      : "ND_uploadImgChk.do",
		            type     : "POST",
		            dataType : "text",
		            async    : false,
		            success  : function(response){
		                //alert(response);  
		                        if(response == "100") {
		                            //preview(inputId, imageId, '', w, h, s, true);       
		                            //alert(Message.msg.processOk); 
		                                                 
		                        }else if(response == "200") {
		                            //preview(inputId, imageId, '', w, h, s, true);       
		                            alert(Message.msg.chkCmBoardFileSize10); 
		                            $("#"+inputNm).val("");                     
		                        }else{
		                           // preview(inputId, imageId, '', w, h, s, false);    
			                        //jsErrorBox(response);                        
		    	                    alert(response);     
		    	                    $("#"+inputNm).val("");                      
		                        }     
		            }
		        });
		    } 
		};
		
		 // 특수 문자 입력 체크  
		 var checkFilter =    function (cmid){
			 var chkId = blankTrim(cmid);
			 var chktext = /[ \{\}\[\]\/?.;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi; 
			 if(chktext.test(chkId)){
			     
			     alert(Message.msg.chkCmOpenFormSpecial2);
			     //alert("컴마를 제외한 특수문자는 입력하실 수 없습니다.");
			     return false;
			 }
			 return true;
		};
		// 공백 체크
		var blankTrim = function (name){
			return name.replace(/(\s*)/g, "");
		};
		
		//첨부된 파일중 ajax를 이용하여 파일 삭제
		var jsFileDelete = function(element, count, fileSeq, fileId, cmmntyId, cmmntyMenuCode, cmmntyBbsSeq ){
			
	 	    if(!confirm(Message.msg.deleteFileConfirm)){
				return false;
	 	    }
			var url = "ND_fileDelete.do";
			$.post(url, 
		        { 
			    	atchFileSeq   : fileSeq,
			    	fileId			: fileId,
			    	cmmntyId  : cmmntyId,
			    	cmmntyMenuCode  : cmmntyMenuCode, 
			    	cmmntyBbsSeq : cmmntyBbsSeq
			    }, 
				function(response){
			        //alert(response);
					if(response == "true"){
					    $(".tx_blue_s").remove();
					    $(".mar_b5").remove();
					    alert(Message.msg.fileDeleteY);
					    $("#pfile"+count).attr("disabled",false); 
					    $("#file_route"+count).val("");
					} else {
						alert(Message.msg.fileDeleteN);
					}
				}, 'text');
		};
		
		var tagNmArray = function (){
		    var valueArr = new Array();
		    var list = $("input[name='hidTagNm']");
		    for(var i = 0; i < list.length; i++){
		         valueArr.push(list[i].value);
		    }
		    //alert(valueArr);
		    $("#tagNm").val(valueArr);
		    //$("#multiCkSize").val(valueArr.length);
		};
		var cleanHtml = function(){
		    var bbscttCn = $("#bbscttCn").val();
		    //alert(bbscttCn);
		    bbscttCn = bbscttCn.replace(/<br />/ig, "\n"); // <br />을 엔터로 변경
		    bbscttCn = bbscttCn.replace(/&nbsp;/ig, " "); // 공백      
		    bbscttCn = bbscttCn.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, ""); // HTML 태그제거
		    $("#bbscttCn").val(bbscttCn);
		    //alert(bbscttCn);
		};
	</script>
</head>
<body>
	<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/>
	<input type="hidden" id="cmmntyBbsCd" name="cmmntyBbsCd" value="<c:out value="${cmUserMenuView.cmmntyBbsCd}"/>"/>
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq }"/>"/>
	
	<input type="hidden" id="inputName" name="inputName" value=""/>
	<input type="hidden" id="maxFileSize" name="maxFileSize" value=""/>
	<input type="hidden" id="maxWidthSize" name="maxWidthSize" value=""/>
	<input type="hidden" id="maxHeightSize" name="maxHeightSize" value=""/>
	<input type="hidden" id="fileExt" name="fileExt" value=""/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value="<c:out value="${userBoardView.atchFileSeq }"/>"/>
	
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<!-- view -->
				<table class="tbl_view">
					<colgroup>
						<col style="width:20%">
						<col style="width:*">
					</colgroup>
					<tbody>
						<tr>
							<td class="tit">제목</td>
							<td class="last"><input type="text" id="bbscttSj" name="bbscttSj" title="제목 입력" value="<c:out value="${userBoardView.bbscttSj }"/>" class="input" style="width:570px;" maxlength="100"></td>
						</tr>
						<c:if test="${cmInfo.userId == sessionScope['__usk'].userId}">
						<tr>
							<td colspan="2" class="last">
							   <div id="contentsErrorDiv"></div>
			                        <textarea name="bbscttCn" id="bbscttCn" rows="15" class="w99_p" title="내용을 입력해주세요"><c:out value="${userBoardView.bbscttCn }" /></textarea>
			                            <script type="text/javascript">
			                            //<![CDATA[
			                            CKEDITOR.replace('bbscttCn', {
			                                height : 300,
			                                enterMode : "2",
			                                skin : "moono",
			                                allowedContent: true,
			                                toolbar : toolbar_config.default_toolbar,
			                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do"
			                            });
			                            //]]>
			                            </script>                    
			                   	<valid:msg name="bbscttCn" /> 
                   			</td>
						</tr>
						</c:if>
						<c:if test="${cmInfo.userId != sessionScope['__usk'].userId}">
						<tr>
							<td colspan="2" class="last">
							<textarea id="bbscttCn" name="bbscttCn" style="width:725px; height:360px;" onkeyup="javascript:displayBytes(1000,'bbscttCn');"  ><c:out value="${userBoardView.bbscttCn }" escapeXml="false"/></textarea>
							</td>
						</tr>
						</c:if>
						<tr>
							<td class="tit">첨부파일</td>
							<td class="last">
							<c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">
								<div class="file">
									<input type="text"id="file_route<c:out value='${status.count}'/>" name="file_route<c:out value='${status.count}'/>" title="파일명"  value="<c:out value="${fileData.localNm }"/>" readonly="readonly" style="width:500px;">
									<div class="fake_input">
										<input type="file" id="pfile<c:out value='${status.count}'/>" name="pfile<c:out value='${status.count}'/>" class="file_photo" title="파일업로드" onchange="fileSel(this,'file_route<c:out value='${status.count}'/>');" disabled="disabled"/>
									</div>
									<span class="btn"><img src="/resources/cmmnty/default/images/btn/btn_file.gif" alt="파일 선택" style="cursor: pointer;"></span>
									
									<p class="tx_blue_s">- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요. </p>
									<ul>
										<li class="mar_b5">
										    <a href="#none" onclick="jsFileDelete(this, '<c:out value='${status.count}'/>', '<c:out value='${fileData.fileSeq}'/>', '<c:out value='${fileData.fileId}'/>', '<c:out value='${userBoardView.cmmntyId}'/>', '<c:out value='${userBoardView.cmmntyMenuCode}'/>', '<c:out value='${userBoardView.cmmntyBbsSeq}'/>');">
										    <img src="/resources/cmmnty/default/images/icon_cancel_red.png" alt="삭제" class="vm" /></a>
										    <a href="/component/file/ND_fileDownload.do?id=<c:out value='${fileData.fileId}'/>" title="<c:out value='${fileData.fileDesc}'/>"><c:out value='${fileData.localNm}'/></a><span class="tx_gray vm">(download : <c:out value='${fileData.downCnt}'/>, <c:out value='${fileData.fileSize}'/>, <c:out value='${fileData.fileType}'/>)</span>
										</li>
									</ul>
								</div>
							</c:forEach>
							<c:if test="${empty userBoardView.cmUserBoardFileCollection}">
									<div class="file">
									<input type="text"id="file_route1" name="file_route1" title="파일명" readonly="readonly" style="width:500px;">
									<div class="fake_input">
										<input type="file" id="pfile1" name="pfile1" class="file_photo" title="파일업로드" onchange="fileSel(this,'file_route1');" />
									</div>
									<span class="btn">
										<img src="/resources/cmmnty/default/images/btn/btn_file.gif" alt="파일선택" style="cursor: pointer;">
									</span>
								</div>
							</c:if>
								<div class="guide_txt">※ jpg, jpeg, png, gif, hwp, doc, docx, xls, xlsx, ppt, pptx, pdf, zip, rar, gz, tar 형식의<br />&nbsp;&nbsp;&nbsp;&nbsp;10MB 미만 파일만 업로드 가능합니다.</div>
							</td>
						</tr>
						<tr>
							<td class="tit">공개 설정</td>
							<td class="last">
								<input type="radio" id="othbcSetupCd1" name="othbcSetupCd" value="1001" <c:if test="${userBoardView.othbcSetupCd == '1001' || userBoardView.othbcSetupCd == null }"> checked="checked" </c:if>/><label for="all" class="space">전체 공개</label>
								<input type="radio" id="othbcSetupCd2" name="othbcSetupCd" value="1002" <c:if test="${userBoardView.othbcSetupCd == '1002' }"> checked="checked" </c:if>/><label for="member">멤버 공개</label>
								<input type="radio" id="othbcSetupCd3" name="othbcSetupCd" value="1003" <c:if test="${userBoardView.othbcSetupCd == '1003' }"> checked="checked" </c:if>/><label for="member">작성자만</label>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->

				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmQnABoardList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
					</div>
					<div class="btn_r">
						<c:if test="${empty userBoardView }" >
						<div class="btn_navi_g"><a href="#none" onclick="jsCmBoardInsert();"><span class="disk">저장</span></a></div>
						</c:if>
						<c:if test="${not empty userBoardView }" >
						<div class="btn_navi_g"><a href="#none" onclick="jsCmBoardUpdate();"><span class="disk">수정</span></a></div>
						</c:if>
					</div>
				</div>
				<!-- //버튼 -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->

</body>
</html>
    