<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<div class="supAdm view">
	<h3>서비스 등록 안내</h3>
	<h4>서비스등록 및 승인 절차 안내</h4>
	<img src="/cloud_ver2/new_cloud/images/img_srvRgst.png" alt="" />
	
	<dl>
		<dt>서비스 규격서</dt>
		<dd>
			<a href="/resources/download/SpecSample.xlsx" target="_blank" class="btns st3">양식 엑셀 다운로드</a>
			<a href="/resources/download/SpecSampleViewPDFdownload.pdf" target="_blank"  class="btns st3">작성 설명 PDF다운로드</a>
		</dd>
	</dl>
	
	<div class="btnArea rig">

							
		<a onclick='jsView();'  href="#none" class="btns st4 icn icnWrite">등록하기1111</a>							
							
							
	</div>
</div>
<form name="dataForm" id="dataForm" method="get">
	 	<input type="hidden" name="updateYn" id="updateYn" />	 
</form>	 	
<script type="text/javascript">
  var jsView = function(){

      $("#updateYn").val("insert");      
      //document.dataForm.action = "BD_goodsView.do";
//    	document.dataForm.action = "BD_goodsForm.do";
      document.dataForm.submit(); 
  };
  </script>
