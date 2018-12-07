<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.web.common.CommonDutyConstant"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>커뮤니티 게시물 관리 등록</title>
	
	<op:jsTag type="openworks" items="ckeditor" />
	
	<script type="text/javascript" src="/resources/cmmnty/common/js/jquery-1.11.1.min.js"></script>
	<op:jsTag type="spi" items="form, validate, cmmultifile" />
	<script type="text/javascript">
		$(document).ready(function() {
		    if(typeof OpenWorks == "undefined"){ OpenWorks = {}; } //게시판 설정값들을 초기화 합니다.
			  <c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1003'  }">
			  
				OpenWorks.maxFileCnt		= 5;
			  </c:if>
			  <c:if test="${ cmUserMenuView.cmmntyBbsTyCd != '1003'  }">
				OpenWorks.maxFileCnt		= 1;
			  </c:if>
				OpenWorks.maxFileSize	= 10240; //각 파일 최대 업로드 크기
				OpenWorks.totalFileSize	= 10240; //전체 파일 최대 업로드 크기
				OpenWorks.filePermExtsn	= "jpg|jpeg|png|gif|zip|hwp|xls|xlsx|docx|doc"; //허용할 파일 확장자
				OpenWorks.closeFileIcon	= "/resources/openworks/theme/default/images/btn/btn_r_close.gif";
				OpenWorks.fileCnt	= <c:out value="${userBoardView.fileCnt}" default="0"/>;
		    	jsSetMultiFile();
		    	<c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1001'  || cmUserMenuView.cmmntyBbsTyCd == '1003'}">
		    	 tagNmArray(); // 태그 컴마로 설정.
		    	 </c:if>
			});
		
		  // 게시판 등록
	    var jsBBSInsert = function(){
	        var parentUrl = parent.document.URL;
		    if(validation.dataForm() === false){
	        	return;
	   		}
		    //alert( $("#tagNm").val());
		    if ( confirm(Message.msg.chkInsert) ) {
		        
	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "ND_cmManageBBSInsert.do",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	                if (response == "true") {
	   	                 	alert(Message.msg.chkCmBoardInsertOk);  
	   	                 	jsCloseWin();
			          		//parent.location.reload(parentUrl);
			          		parent.location.reload("PD_cmManageBBSList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>&langCode=<c:out value='${cmUserMenuView.langCode}'/>&cmmntyBbsTyCd=<c:out value='${cmUserMenuView.cmmntyBbsTyCd}'/>");
		               } else { 
		                   alert(Message.msg.processFail);
		                   return;
		               }
	   	            }
	   	        });
	      	 }
		 };
			
			// 게시판 수정
		    var jsBBSUpdate = function(){
		        //var docUrl = document.URL;
		        var parentUrl = parent.document.URL;
				var cmmntyId  = $("#cmmntyId").val();
				var langCode     = $("#langCode").val();
				var cmmntyMenuCode  = $("#cmmntyMenuCode").val();
				var cmmntyBbsSeq  = $("#cmmntyBbsSeq").val();
				var registId  = "<c:out value='${userBoardView.registId}'/>";
				var cmmntyBbsTyCd = $("#cmmntyBbsTyCd").val();
				
			    if(validation.dataForm() === false){
		        	return;
		   		}
			    if ( confirm(Message.msg.chkModify) ) {
		 	        $("#dataForm").ajaxSubmit({
		   	            url      : "ND_cmManageBBSUpdate.do",
		   	            type     : "POST",
		   	            dataType : "text",
		   	            success  : function(response) {
		   	                if (response == "true") {
		   	                 	alert(Message.msg.chkCmBoardUpdateOk);  
				          		location.reload("PD_cmManageBBSView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsSeq="+cmmntyBbsSeq+"&registId="+registId+"&cmmntyBbsTyCd="+cmmntyBbsTyCd);
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
	    		           //alert(CKEDITOR.instances.bbscttCn.getData().length);
	    		          // var editor = CKEDITOR.instances.bbscttCn
	    		           //displayBytesEditor("20", editor);
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
	    		       if( typeof tagNmif != "undefined"){
		    		       if(tagNm != ""){
		       		     	  if(!checkFilter(tagNm)){  
		       		               $("#tagNm").focus(); 
		       		               $("#tagNm").val(""); 
		       		               return false;
		       		     	 	}else{
		       		     	 	 	$("#tagNm").val(blankTrim(tagNm)); 
		       		     	 	}
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
		    
			//글자수체크 에디터
		    var displayBytesEditor  = function ( nm, id ){
		        var obj  = id.getData();
		            if (id.bytes() > nm){
		                if (event.keyCode != '8'){
		                   // alert(nm+'바이트까지 입력이 가능합니다.'); 
		                    alert(nm+Message.msg.chkFormByteUntill );
		                }
		                obj.value = obj.value.substring(0, id.length-10);
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
				var fileLength = $("#uploadFileCnt").val();
		 	    if(!confirm(Message.msg.deleteFileConfirm)){
					return false;
		 	    }
				var url = "ND_fileDelete.do";
				$.post(url, 
			        { 
				    	atchFileSeq   : fileSeq,
				    	fileId	: fileId,
				    	cmmntyId  : cmmntyId,
				    	cmmntyMenuCode  : cmmntyMenuCode, 
				    	cmmntyBbsSeq : cmmntyBbsSeq,
				    	fileLength	:fileLength
				    }, 
					function(response){
				        //alert(response);
						if(response == "true"){
						    //$(".tx_blue_s").remove();
						    //$(".mar_b5").remove();
						      $("#fileAdd"+count).html("");
						      $("#brAdd"+count).remove();
						      $("#photoMultiFiles").attr("disabled",false); 
						    alert(Message.msg.fileDeleteY);
						} else {
							alert(Message.msg.fileDeleteN);
						}
					}, 'text');
			};
			
			//멀티파일 업로드
			var jsSetMultiFile = function(){
				$('#dataForm input[name=photoMultiFiles]').MultiFile({
					accept: OpenWorks.filePermExtsn,
					max: OpenWorks.maxFileCnt,
					maxfile: OpenWorks.maxFileSize, //각 파일 최대 업로드 크기
			        maxsize: OpenWorks.totalFileSize,  //전체 파일 최대 업로드 크기
					STRING: {
						remove: '<img id="fileDelImg" src="' + OpenWorks.closeFileIcon + '" class="vm" />',
						denied: '$ext ' +Message.msg.chkCmBoardFileExt,           //확장자 제한 문구
						duplicate: '$file ' + Message.msg.fileAlreadyUpload,	   //중복 파일 문구
						toomuch:  Message.msg.chkCmBoardFileSize10,
			            toomany: "업로드할 수 있는 최대 갯수는 $max 개 입니다."
//		 	            toobig: "$file 은 크기가 매우 큽니다. (max $size)",
					},
					list: '#multiFilesListDiv',
					onFileRemove: function(element, value, master_element){
					    //alert(value);
					},
					afterFileRemove: function(element, value, master_element){
					    //alert(value);
						if(eval($("#uploadFileCnt").val()) > 0)
							$("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) - 1);
						else $("#uploadFileCnt").val(0);

						if(eval($("#uploadFileCnt").val()) < OpenWorks.maxFileCnt	)
							$.fn.MultiFile.reEnableEmpty();
						$("#fileCnt").html($("#uploadFileCnt").val());
					},
					onFileAppend: function(element, value, master_element){
						$("#dataForm input[name=photoMultiFiles]").length;
						//alert($("#dataForm input[name=photoMultiFiles]").length);
					},
					afterFileAppend: function(element, value, master_element){
						if(eval($("#uploadFileCnt").val()) < 0){
							$("#uploadFileCnt").val(1);
						}else{
							$("#uploadFileCnt").val(eval($("#uploadFileCnt").val()) + 1);
						}

						if(eval($("#uploadFileCnt").val()) >= OpenWorks.maxFileCnt	)
							$.fn.MultiFile.disableEmpty();
						//alert($("#uploadFileCnt").val());
						$("#fileCnt").html($("#uploadFileCnt").val());
					},
						onFileSelect: function(element, value, master_element){
					},
						afterFileSelect: function(element, value, master_element){
					}
					
				});
				//폼 파일 업로더를 초기화 시킨후, 파일 갯수가 초과시엔 디스에이블 시킨다.
				if(OpenWorks.maxFileCnt	 <= eval($("#uploadFileCnt").val())){
					$.fn.MultiFile.disableEmpty();
				}
			};
			
			//태그 컴마 구분하여 합치기
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
			var jsCloseWinReload = function(){
			    
			    var cmmntyId  = $("#cmmntyId").val();
				var langCode     = $("#langCode").val();
				var cmmntyMenuCode  = $("#cmmntyMenuCode").val();
				var cmmntyBbsTyCd = $("#cmmntyBbsTyCd").val();
			    parent.location.reload("PD_cmManageBBSList.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMenuCode="+cmmntyMenuCode+"&cmmntyBbsTyCd="+cmmntyBbsTyCd);
			    jsCloseWin();
			}
			
	</script>
</head>
<body>
				<!-- 
				1001	기본형
1002	FAQ형
1003	갤러리형
1004	답변형
				 -->
				 
	<div id="popup">
<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data" >
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyMenuCode" name="cmmntyMenuCode" value="<c:out value="${cmUserMenuView.cmmntyMenuCode}"/>"/>
	<input type="hidden" id="cmmntyBbsCd" name="cmmntyBbsCd" value="<c:out value="${cmUserMenuView.cmmntyBbsCd}"/>"/>
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="langCode" name="langCode" value="<c:out value="${cmUserMenuView.langCode}"/>"/>
	
	<input type="hidden" id="inputName" name="inputName" value=""/>
	<input type="hidden" id="maxFileSize" name="maxFileSize" value=""/>
	<input type="hidden" id="maxWidthSize" name="maxWidthSize" value=""/>
	<input type="hidden" id="maxHeightSize" name="maxHeightSize" value=""/>
	<input type="hidden" id="fileExt" name="fileExt" value=""/>
	
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value="<c:out value="${userBoardView.cmmntyBbsSeq}"/>"/>
	<input type="hidden" id="fileId" name="fileId" value=""/>
	<input type="hidden" id="atchFileSeq" name="atchFileSeq" value="<c:out value="${userBoardView.atchFileSeq }"/>"/>
	
        <h2 class="mar_t20">커뮤니티 게시물 관리 등록</h2>
		<fieldset>
		<legend>커뮤니티 게시물 관리 상세</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="커뮤니티 게시물 관리 등록">
            		<caption class="hidden">커뮤니티 게시물 관리 등록</caption>
			<colgroup>
			  <col width="23%" />
			  <col width="77%" />
			</colgroup>
			<tbody>
				<tr>
					<th><span>커뮤니티 이름 <br/>(게시판 이름 / 게시판 형태)</span></th>
					<td><span><strong><c:out value="${cmInfo.cmmntyNm}"/></strong> (<c:out value="${cmUserMenuView.cmmntyMenuNm}"/></span> / <strong><c:out value="${cmUserMenuView.cmmntyBbsTyNm}"/></strong>)</td>
				</tr>
				<tr>
					<th><span>제목</span></th>
					<td><span><input type="text" name="bbscttSj" id="bbscttSj" value="<c:out value="${userBoardView.bbscttSj}"/>"  style="width: 550px;" /></span>
					<c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1001' }">
					<input type="checkbox" id="noticeBbscttAt" name="noticeBbscttAt" value="Y" <c:if test="${userBoardView.noticeBbscttAt == 'Y'}"> checked="checked" </c:if> /><label for="notify">공지</label>
					</c:if>
					</td>
				</tr>
				<tr>
					<th ><span>내용</span></th>
					<td  colspan="2" ><span>
						<div id="contentsErrorDiv"></div>
                        <textarea name="bbscttCn" id="bbscttCn" rows="15" class="w99_p" title="내용을 입력해주세요" ><c:out value="${userBoardView.bbscttCn }" /></textarea>
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
					</span></td>
				</tr>

				<c:if test="${ cmUserMenuView.cmmntyBbsTyCd != '1002' }">
              	<tr>
					<th><span>첨부파일</span></th>
					<td><span>
								<c:if test="${not empty userBoardView.cmUserBoardFileCollection}">
								<p class="tx_blue_s">- 기존 첨부파일을 <span class="tx_red">삭제</span>하시려면 아래 <span class="tx_red">X 아이콘을 클릭</span>하세요. </p>	
								<c:forEach items="${userBoardView.cmUserBoardFileCollection}" var="fileData" varStatus="status">		
									<ul>
										<li class="mar_b5"  id="fileAdd<c:out value='${status.count}'/>" >
									  	 	<a href='#none' onclick="jsFileDelete(this, '<c:out value='${status.count}'/>', '<c:out value='${fileData.fileSeq}'/>','<c:out value='${fileData.fileId}'/>', '<c:out value='${userBoardView.cmmntyId}'/>', '<c:out value='${userBoardView.cmmntyMenuCode}'/>', '<c:out value='${userBoardView.cmmntyBbsSeq}'/>');"><img src='<c:url value='/resources/cmmnty/default/images/icon_cancel_red.png' />' class='vm'/></a><a href='/component/file/ND_fileDownload.do?id=<c:out value='${fileData.fileId}'/>' title='<c:out value='${fileData.fileDesc}'/>'><c:out value='${fileData.localNm}'/></a>(download : <c:out value='${fileData.downCnt}'/>, <c:out value='${fileData.fileSize}'/>)
										</li>
									</ul>
									<br id="brAdd<c:out value='${status.count}'/>" />
								</c:forEach>
								</c:if>
								<div class="mar_t5 mar_b5">
									<input type="hidden"id="file_route1" name="file_route1" title="파일명" >
									<input type="file" id="photoMultiFiles" name="photoMultiFiles" class="file_photo" title="파일업로드"  style="width:500px;" <c:if test="${maxFileCnt <= userBoardView.fileCnt }"> disabled="disabled"</c:if>/>
								</div>
								<div id="multiFilesListDiv" class="regist-file"></div>
								<input type="hidden" id="uploadFileCnt" name="uploadFileCnt" value="<c:out value="${userBoardView.fileCnt}" default='0'/>" />
								<div class="guide_txt">※ <c:out value="${maxFileCnt}" default='0'/> 개 파일 까지 업로드 가능합니다.</div>
						</span></td>
				</tr>
				</c:if>
				<c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1001'  || cmUserMenuView.cmmntyBbsTyCd == '1003'}">
				<tr>
					<th><span>태그</span></th>
					<td><input type="text" id="tagNm" name="tagNm" style="width: 600px;" value="" /></td>
						<c:forEach items="${userBoardView.cmUserBoardTagCollection}" var="tagData" varStatus="status">
								<input type="hidden" id="hidTagNm<c:out value='${status.count}'/>" name="hidTagNm" value="<c:out value="${tagData.tagNm }" />" />
						</c:forEach>
				</tr>
				</c:if>
				<tr>
					<th>공개 설정</th>
					<td>
						<input type="radio" id="othbcSetupCd1" name="othbcSetupCd" value="1001" <c:if test="${userBoardView.othbcSetupCd == '1001' || userBoardView.othbcSetupCd == null }"> checked="checked" </c:if>/><label for="all" class="space">전체 공개</label>
						<input type="radio" id="othbcSetupCd2" name="othbcSetupCd" value="1002" <c:if test="${userBoardView.othbcSetupCd == '1002' }"> checked="checked" </c:if>/><label for="member">멤버 공개</label>
					</td>
				</tr>
				<c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1004' }">
				<tr>
					<th ><span>질문 답변</span></th>
					<td colspan="2">
	                   	<textarea id="answerCn" name="answerCn" style="width:99%;; height:173px;" onkeyup="javascript:displayBytes(1000,'answerCn');" ><c:out value="${userBoardView.answerCn }" escapeXml="false"/></textarea>
					</td>
				</tr>
				</c:if>
			</tbody>
          </table>
        </fieldset>
        <p class="tx_c mar_t20">
        <div>
           <div class="float_l">
           <c:if test="${ cmUserMenuView.cmmntyBbsTyCd == '1004' }">
           		<a href="#" class="btn"><button type="button" onclick="jsBBSAnswerUpdate();" class="blue">답변 저장</button></a>
           </c:if>
           </div>
           <div class="float_r">
           <c:if test="${empty userBoardView }">
           		<a href="#" class="btn"><button type="button" onclick="jsBBSInsert();" class="blue">저장</button></a>
           </c:if>
           <c:if test="${not empty userBoardView }">
				<a href="#" class="btn"><button type="button" onclick="jsBBSUpdate();" class="blue">수정</button></a>
			</c:if>
           		<a href="#" class="btn"><button type="button" onclick="jsCloseWinReload();" class="blue">닫기</button></a>
          </div>
		</div>
		</p>
	</form>
	</div>
	
</body>
</html>