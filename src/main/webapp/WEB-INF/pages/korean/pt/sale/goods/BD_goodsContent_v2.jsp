<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<div class="supAdm view">
	
	<h3>서비스 등록 단계별 입력정보</h3>
      <p class="txt_cen"><img src="/cloud_ver2/new_cloud/images/img_Servicereg01.png" alt="서비스 등록 단계별 입력정보" /></p>
      <p>5단계까지 진행하시면 [클라우드스토어 씨앗]에서 서비스를 검토 후 승인이 처리와 동시에 전시서비스로 변경됩니다.</p>
      <p class="txt_sub">- 등록된 서비스는 제공자씨앗 - 제공서비스관리 - 서비스목록에서 확인할 수 있습니다.</p>
      <p>※ 서비스 규격서 정보는 제공자 매뉴얼을 확인하여 사전에 준비하시면 편리하게 이용하실 수 있습니다. 
      <span><a href="/component/file/ND_directDownload.do?fp=/resources/download/0614_SupportGudie_v.0.1.pdf&fn=클라우드스토어 씨앗 제공자 매뉴얼.pdf" class="btns st3">제공자 매뉴얼</a></span></p>

      <h3>서비스 등록 시 유의사항</h3>
      <ul class="ul_txt">
        <li>서비스의 정상적인 사용을 위해 IE 10 이상 또는 Chrome 브라우저를 사용하시기 바랍니다.</li>
        <li>입력 작업 진행 중에 임시저장은 계속 하실 수 있습니다.</li>
        <li>2~3단계는 서비스 규격서로서 전체가 필수항목이며 검색필터에 적용되므로 정확히 입력하시기 바랍니다.</li>
        <li>서비스 등록신청을 위해서는 필수항목(*)으로 표시된 부분은 모두 입력하셔야 합니다.</li>
        <li>가격표, 첨부파일은 모든 정보의 임시저장 후 4단계에서 첨부</li>
        <li>첨부파일 업로드시 오류가 발생되는 경우 아래 씨앗 고객센터로 문의하시기 바랍니다.</li>
      </ul>
      <p>[문의] 씨앗 고객센터 : 1522-0089(평일 9:00~18:00) | 이메일 : ceart@ceart.kr</p>

      <h3>필수 입력서류 양식</h3>
      <p><a href="/component/file/ND_directDownload.do?fp=/resources/download/0606_StandardPrice.hwp&fn=클라우드서비스 가격표 양식.hwp" class="btns st3">서비스가격표</a></p>      
      <div style="text-align:  center;">

		<a onclick='jsView();'  href="#none" class="btns st4 Write btn_reg">서비스등록시작하기</a>
	</div>
      
</div>

<form name="dataForm" id="dataForm" method="get">
	 	<input type="hidden" name="updateYn" id="updateYn" />	 
</form>	 	
<script type="text/javascript">
  var jsView = function(){

      $("#updateYn").val("insert");      
    	document.dataForm.action = "BD_goodsForm.do";
      document.dataForm.submit(); 
  };
  </script>
