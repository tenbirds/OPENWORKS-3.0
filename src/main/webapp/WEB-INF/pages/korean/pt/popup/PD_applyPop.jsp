<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8" />
  <title>POPUP - 계약완료</title>
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />

<script type="text/javascript">
var jsCancel = function() {
    parent.$.fn.colorbox.close();
}
function jsFileDelete(inputId, inputIdFake){
    document.getElementById(inputIdFake).value="";
    $("input[name="+inputId+"]").val("");
}



function jsFileChk(inputId, inputIdFake){
			document.getElementById(inputIdFake).value=$("input[name="+inputId+"]").val();
			
			var inputFile = document.getElementById(inputId);
			var filePath = inputFile.value;
			
			if(filePath == ""){
				return false;
			}
			document.getElementById(inputIdFake).value = $("input[name="+inputId+"]").val();
		}
		
function jsOnlyNumber(event){
    var key = window.event ? event.keyCode : event.which;    

    if ((event.shiftKey == false) && ((key  > 47 && key  < 58) || (key  > 95 && key  < 106)
    || key  == 35 || key  == 36 || key  == 37 || key  == 39  // 방향키 좌우,home,end  
    || key  == 8  || key  == 46 || key == 9 )
    ) {
        return true;
    }else {
        return false;
    }            
}
var jsPageMove = function(){
    $("form[name=Insetdata]").attr("method","post");
	$("form[name=Insetdata]").attr("action","/korean/pt/apply/BD_popUpInsert.do");
	$("form[name=Insetdata]").submit();
	parent.$.fn.colorbox.close();
};
</script>
</head>

 <body class="winPopup ctrCpl">
	<h2>기관명 검색 <a href="#" onclick="jsCancel();">닫기</a></h2>		
	<div>
		<c:set var="_applyPopUp" value="${applyPopUp}"/>
	 <form name="Insetdata" id="Insetdata" method="POST" enctype="multipart/form-data" action="BD_popUpInsert.do">
	 	<input type="hidden" name="cntrctSn" id="cntrctSn" value="${_applyPopUp.cntrctSn}">
	 	<c:if test="${ null eq _applyPopUp.cntrctBeginDe}">
	 		<input type="hidden" name="applytype" id="applytype" value="PopInsert">
		</c:if>
		
		<c:if test="${ null ne _applyPopUp.cntrctBeginDe}">
			<input type="hidden" name="applytype" id="applytype" value="PopUpdate">
		</c:if>
		<table class="tbl_st4 e4">
			<tr>
				<th class="requ">서비스</th>
				<td colspan="3">${_applyPopUp.svcNm}</td>
			</tr>
			<tr>
				<th class="requ">이용자</th>
				<td>${_applyPopUp.userNm}</td>
				<th>기업/기관명</th>
				<td>${_applyPopUp.purchsInsttNm}</td>
			</tr>
			<tr>
				<th class="requ">계약기간</th>
				<td colspan="3" class="term">
					<input type="text" id="dPicker_1" name="dPicker_1" value="${_applyPopUp.cntrctBeginDe}"/> ~ <input type="text" id="dPicker_2"  name="dPicker_2" value="${_applyPopUp.cntrctEndDe}"/>				
				</td>
			</tr>
			<tr>
				<th class="requ">공급가</th>
				<td colspan="3" class="vat">
					<div class="unit">
						<i>원</i>				
						<div><input type="text" value="${_applyPopUp.cntrctaMount}" onkeydown="return jsOnlyNumber(event);"/></div>
					</div>					
					<label>VAT포함</label>
				</td>
			</tr>
			<tr>
				<th class="requ">수 량</th>
				<td colspan="3" class="unit">
					<i>개</i>
					<div><input type="text" value="${_applyPopUp.cntrCount}" onkeydown="return jsOnlyNumber(event);"/></div>
				</td>
			</tr>			
			<tr>
				<th>공급형태</th>
				<td colspan="3">
						<label>
						<input type="radio" name="splyForm" checked="checked"/> 월단위
						</label>
						<label>
						<input type="radio" name ="splyForm"/> 년단위
						</label>
						<span class="ect">
							<label><input name="splyForm" type="radio"/> 기타</label>
							<input type="text" name="splyFormEtc" onkeydown="return jsOnlyNumber(event);" value="${_applyPopUp.splyFormEtc}"/>
						</span>
				</td>
			</tr>
			<tr>
				<th>계약서 파일</th>
				<td colspan="3">
						<div class="uploadFile">
								<input type="text" readonly="readonly" name="optlCntrFileInput" id="optlCntrFileInput" title="파일명"/>
								<div>
									<img src="/cloud_ver2/new_cloud/images/icn_close_2.png" onclick="javascript:jsFileDelete('optlCntrFile', 'optlCntrFileInput');" alt="삭제" />							
						            <span class="btns st3">파일선택
						            	<input type="file" name="optlCntrFile" id="optlCntrFile" class="optlCntrFile" title="파일찾기" onchange="javascript:jsFileChk('optlCntrFile', 'optlCntrFileInput');"/>
						            </span>
					            </div>
					   </div>          
				</td>
			</tr>
		</table>
		<div class="btnArea">		
		<a href="javascript:" onclick="jsPageMove();" class="btns st1">저 장</a>
		</div>
</form>

	</div>


  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
  <script type="text/javascript" src="/resources/cmmnty/common/js/fakeselect.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/notice/jquery.notice.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/printPreview/jquery.print-preview.js"></script>
  <script type="text/javascript" src="/resources/openworks/spi/jquery/cookie/jquery.cookie.js"></script>
  <script type="text/javascript" src="/resources/web/analyze/tracking/js/detector.js"></script>

  <!-- datepicker -->
  <link rel="stylesheet" href="/resources/openworks/spi/jquery/datepicker/jquery.datepicker.css" />
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.ui.core.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script.min.js"></script>
  <script src="/resources/openworks/spi/jquery/datepicker/jquery.script-addon.js"></script>
  <script src="/resources/openworks/spi/openworks/openworks.ui.js"></script>
  <script>
	$(document).ready(function() {
	  $( "#delyDt, #rplyDt" ).datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
	});
  </script>
  <!--// datepicker -->

 </body>

</html>