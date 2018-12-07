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
<script  type="text/javascript">
	alert("<c:out value="${cmUserMenuView.cmmntyMenuNm}"/>은/는 "+Message.msg.chkCmOptFormOk); // FAQ은 운영자만 작성 
	// 이전소스
	//location.href="http://<c:out value='${SubDomain}'/>.ceart.kr/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
	
	
	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	// 변경소스
	location.href="http://<%=GlobalConfig.DOMAIN_SUBNM %>/<c:out value='${SubDomain}'/>/cm/user/cmUserMain/BD_index.do?cmmntyMenuCode=0&cmmntyId=<c:out value="${cmUserMenuView.cmmntyId}"/>";
	//}}
</script>
</c:if>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<op:jsTag type="openworks" items="ckeditor" />
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
		$(document).ready(function() {
		   
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
		    if ( confirm(Message.msg.chkInsert) ) {
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmFaqBoardInsert.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.chkCmBoardInsertOk);  
		                    jrMove("BD_cmFaqBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
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
		   	            url      : "INC_cmFaqBoardUpdate.do",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                 	alert(Message.msg.chkCmBoardUpdateOk);  
			                    jrMove("BD_cmFaqBoardList.do");
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
	</script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post" >
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/>
	<input type="hidden" id="cmmntyBbsCd" name="cmmntyBbsCd" value="<c:out value="${cmUserMenuView.cmmntyBbsCd}"/>"/>
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq }"/>"/>
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
							<td class="last"><input type="text"  id="bbscttSj" name="bbscttSj" title="제목 입력" value="<c:out value="${userBoardView.bbscttSj }"/>"  class="input" style="width:570px;" maxlength="100"></td>
						</tr>
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
						<tr>
							<td class="tit">공개 설정</td>
							<td class="last">
								<input type="radio" id="othbcSetupCd1" name="othbcSetupCd" value="1001" <c:if test="${userBoardView.othbcSetupCd == '1001' || userBoardView.othbcSetupCd == null }"> checked="checked" </c:if>/><label for="all" class="space">전체 공개</label>
								<input type="radio" id="othbcSetupCd2" name="othbcSetupCd" value="1002" <c:if test="${userBoardView.othbcSetupCd == '1002' }"> checked="checked" </c:if>/><label for="member">멤버 공개</label>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- //view -->
				<!-- 버튼 -->
				<div class="btn_area">
					<div class="btn_l">
						<div class="btn_navi"><a href="#none" onclick="jrMove('BD_cmFaqBoardList.do?cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>')"><span class="list">목록</span></a></div>
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
	</form>

</body>
</html>
