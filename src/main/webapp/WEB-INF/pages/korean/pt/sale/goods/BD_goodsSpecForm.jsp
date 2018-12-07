<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>수요정보조사</title>
	<op:jsTag type="openworks" items="ui" />
	<op:jsTag type="spi" items="form,validate" />
	<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
	<script type="text/javascript">
	    $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
	</script>
	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">	
		$(document).ready(function(){
			$("#loading-container").hide();
		//	jsSelectDetailList($("#userId").val());
		});
		var jsLoading = function(){
			$("#loading-container").show();
			return true;
		};
		// 입력값 체크
		var checkFormValue = function(){
			//수요조사 엑셀 파일
			if(($("input[name=dmandExaminFile1]").val() == null || $("input[name=dmandExaminFile1]").val() == "")  && $("input[name=dmandExaminFileVal1]").val() == ""){
				alert("서비스 규격서 엑셀파일 등록해주세요.");
				document.getElementById("dmandExaminFileBtn").focus();
				return false;
			}
			
			return true;
		};
		
		// 저장버튼 클릭
		var jsSaveAction = function() {
			
			if(checkFormValue()){
				if(confirm("저장 하시겠습니까?")){
					$("input[type=file]").each(function(){
						if(this.value == ''){
							$("input[name=fileDesc][id="+this.id+"Desc]").attr("disabled","disabled");
							$("#"+this.id).attr("disabled","disabled");
						}
					});
					
					$("#dummyForm").ajaxSubmit({
						url		: "DummyGet.do",
						type	: "POST",
						async	: false,
						success	: function (response) {
							if(response == "true"){
								$("#loading-container").show();
								$("#dataForm").attr("action", "BD_goodsSpecSaveAction.do");
								$("#dataForm").submit();
							}
						}
					});
				}else{
					
				}
			}else{
				
			}
		};
		
		
		jsViewAction = function(){
		    location.href="BD_goodsSpecView.do?goodsCode=${goodsCode}";
		};
		
		var jsGoodsView = function(){
		      location.href = "BD_goodsView.do?goodsCode=${goodsCode}&pageUrlNm=";
		  };
		
		//파일종류 및 용량 체크
		var jsFileChk = function(inputId, inputIdFake, s, fileExt, fileSeq, maxCnt){
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			
			var fileExt = filePath.substring(filePath.lastIndexOf(".") + 1, filePath.length).toLowerCase();
			var fileExtPermit = "xls,xlsx";
			var htmlVal = "";
			
			if(fileExtPermit.indexOf(fileExt) <= 0){
				alert(fileExt + Message.msg.fileCannotUplaod);
				jsInputFileReset(inputId, inputIdFake);
				return false;
			}
			
			if(inputFile.files[0].size > (s * 1024) && s != 0){
				alert(Message.msg.fileSizeOver);
				jsInputFileReset(inputId, inputIdFake);
				return false;
			}
			
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
			
		};
		
		// 첨부파일 삭제 X버튼 클릭
		var jsInputFileReset = function(fileId, textId){
			$("#" + textId).val("");
			var control = $("#" + fileId);
			control.replaceWith( control = control.clone( true ) );
		};
						
		//첨부된 파일중 ajax를 이용하여 파일 삭제
		var jsFileDelete = function(element, seq, id){
			if(!confirm("선택한 파일을 정말 삭제하시겠습니까?\n삭제 후 복구는 불가능 합니다."))
				return false;
			
			var url = "ND_fileDelete.do";
			$("#dummyForm").ajaxSubmit({
				url		: "DummyGet.do",
				type	: "POST",
				async	: false,
				success	: function (response) {
					if(response == "true"){
						$.post(url,
							{ fileId : id, fileSeq : seq },
							function(result){
								if(result == 1){
									$(element).parent().remove();
										 self.location.reload();
								}else{
									alert('파일을 삭제하지 못했습니다.');
								}
							}, 'json');
					}
				}
			});
		};
	
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>

	<div class="supAdm view register">
		<img src="/cloud_ver2/new_cloud/images/srvRgst_step_2.png" alt="서비스 규격서 등록" />
		<h3>서비스 규격서 등록</h3>
				
	<form name="dummyForm" id="dummyForm">
	</form>
	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
		<input type="hidden" id="userId" name="userId" value="${dataVo.userId}" />
		<input type="hidden" id="goodsCode" name="goodsCode" value="${goodsCode}" />
		
		<table class="tbl_st4">
			<tr>
				<th>규격서 엑셀 파일첨부</th>
				<td>
					<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
					<div class="uploadFile" <c:if test="${not empty specVo.specExcelFile[i-1]}"> style="display:none;"</c:if>>
						<input type="text" readonly="readonly" id="dmandExaminFileInput${i}" />
						<div>
							<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="jsInputFileReset('dmandExaminFile${i}','dmandExaminFileInput${i}');" alt="삭제" />
			            	<span class="btns st3">
			            		파일선택
			            		<input type="file" name="dmandExaminFile${i}" id="dmandExaminFile${i}" class="dmandExaminFile" title="파일찾기" <c:if test="${not empty dataVo.dmandExaminFile[i-1]}">disabled</c:if> onchange="jsFileChk('dmandExaminFile${i}', 'dmandExaminFileInput${i}', 10240, '1','${dataVo.fileSeq}', 1); "/>
								<input type="hidden" name="fileDesc" id="dmandExaminFile${i}Desc" value=""/>
			            	</span>
		            	</div>
		            </div>		
		            <input type="hidden" name="dmandExaminFileVal${i}" value="${dataVo.specExcelFile[i-1].fileId}" />
					<c:if test="${not empty specVo.specExcelFile[i-1]}">		
		            <p class="uploaded">
		            	<span>
		            		<a href="/component/file/ND_fileDownload.do?id=<c:out value='${specVo.specExcelFile[i-1].fileId}'/>" title="<c:out value='${specVo.specExcelFile[i-1].localNm}'/>" class="aDeisable"><c:out value='${specVo.specExcelFile[i-1].localNm}'/></a>
		            		<a href="#none" onclick="jsFileDelete(this, ${specVo.specExcelFile[i-1].fileSeq}, '${specVo.specExcelFile[i-1].fileId}'); return false;" class="aDeisable">삭제</a>
		            	</span>
		            </p>
		            </c:if>
		            </c:forEach>
				</td>
			</tr>
		</table>
		<c:if test="${empty dataVo.dmandExaminFile[0]}">
		<!-- 	<p class="btn_infodownload">
				<a href="/component/file/ND_fileDownload.do?id=c68016fd-2d21-4587-9a14-dcec3905eaf2">
					가격조사 다운롣드 
				</a>
			</p> -->
		</c:if>
			
		<div class="btnArea rig">
		<a href="#"  onclick="jsGoodsView()" class="f_l btns st2 icn icnBck2">이전</a>		
		<c:if test="${empty specVo.specExcelFile[0]}">
			<a href="#"  onclick="jsSaveAction()" class="btns st1 icn icnPaper">규격서 업로드</a>
		</c:if>	
		<c:if test="${not empty specVo.specExcelFile[0]}">
			<a href="#"  onclick="jsViewAction()" id="nexMove"  class="btns st1 icn_r next">다음</a>
		</c:if>						
		</div>
				
		<!-- Detail List Area -->
		
		<div class="mt10 downloadarea">
			
		<%-- 	<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
				<ul class="upload_box" <c:if test="${not empty dataVo.dmandExaminFile[i-1]}">style="display:none;"</c:if>>
					<li><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/> 가격조사 </li>
					<li>
						<input type="text" id="dmandExaminFileInput${i}" readonly="readonly" title="파일명" class="fileup" style="width:265px !important;"/>
						<span class="file_del">
							<img onclick="jsInputFileReset('dmandExaminFile${i}','dmandExaminFileInput${i}');" src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제"/>
						</span>
					</li>
					<li>
						<div class="fake_input" style="top:auto !important;">
							<a id="dmandExaminFileBtn" href="#" class="b-btn" style="background-image: none !important;"><strong><span><img src="/new_cloud/images/sub/btn_selectfile.gif" width="72" height="31"/></span></strong></a>
							<span id="dmandExaminFile${i}Span">
								<input type="file" name="dmandExaminFile${i}" id="dmandExaminFile${i}" class="dmandExaminFile" title="파일찾기" <c:if test="${not empty dataVo.dmandExaminFile[i-1]}">disabled</c:if> onchange="jsFileChk('dmandExaminFile${i}', 'dmandExaminFileInput${i}', 10240, '1','${dataVo.fileSeq}', 1); "/>
								<input type="hidden" name="fileDesc" id="dmandExaminFile${i}Desc" value=""/>
							</span>
						</div>
					</li>
				</ul>
				<input type="hidden" name="dmandExaminFileVal${i}" value="${dataVo.dmandExaminFile[i-1].fileId}" />
				<c:if test="${not empty dataVo.dmandExaminFile[i-1]}">
					<div class="fr" style="width:400px; text-align:right;"> <!-- style="float:right;" -->
						<strong class="dis-block fl mr10">현재등록파일&nbsp;:&nbsp;</strong>
						<p class="pre_file" id="pre_file${i}">
							<a href="/component/file/ND_fileDownload.do?id=<c:out value='${dataVo.dmandExaminFile[i-1].fileId}'/>" title="<c:out value='${dataVo.dmandExaminFile[i-1].localNm}'/>" class="aDeisable"><c:out value='${dataVo.dmandExaminFile[i-1].localNm}'/></a>
							<a href="#none" onclick="jsFileDelete(this, ${dataVo.dmandExaminFile[i-1].fileSeq}, '${dataVo.dmandExaminFile[i-1].fileId}'); return false;" class="aDeisable">
								<img src="/new_cloud/images/icon-btn/btn-close.png" alt="삭제" class="vm"/>
							</a>
						</p>
					</div> 
				</c:if>
			</c:forEach> --%>
			<!-- //file upload -->
		</div>
		
		
	    <div id="loading-container" class="loading-container">
	        <div class="loading"></div>
	        <div id="loading-text">loading</div>
	    </div>
		
	</form>
</body>
</html>