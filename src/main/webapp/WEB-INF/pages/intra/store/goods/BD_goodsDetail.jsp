<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>서비스 상세조회/수정</title>
    <op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
    <script type="text/javascript" src="/resources/intra/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="/resources/intra/js/additional-methods.min.js"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/store/goods.js" />"></script>
	 	<script type="text/javascript">
	    // 파일 변경 버튼 클릭
	    function file_browse(){
	        document.dataForm.imageFile1.click();
	        //document.Form.text1.value=document.Form.file.value;
	    };
	    
	    var jsAsIsViewPop = function(el, goodsCode) {
            $(el).colorbox({
                title : "주요한 서비스정보 변경 이력",
                href : "BD_goodsDetail_v2.do?goodsCode="+goodsCode,
                width : "900",
                height : "550",
                iframe : true
            });
	    };
	    
      
	    var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
	    var rgx2 = /(\d+)(\d{3})/; 
      function getNumber(obj, fl){        
				var num01;
        var num02;
           	
        num01 = obj.value;
        num02 = num01.replace(rgx1,"");
        if (fl == 0) {
        	num01 = setComma(num02);
        }else{
        	num01 = num02;
        }
        obj.value =  num01;
			};

      function setComma(inNum){
    	  var outNum;
        outNum = inNum; 
        
        while (rgx2.test(outNum)){
        	outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
        }
        	return outNum;
     	}
      
      
      var isMarking = function () {
    	  //var test = confirm("해당사항 없음을 선택 하셨습니다. 서비스 인증 정보의 입력하신 내용이 삭제됩니다. 해당사항 없음을 선택 하시겠습니까?");
    	  var checked = $('input:checkbox[name=isMark]').is(':checked');
    	  
    	  if (checked) {
    		  var test = confirm("해당사항 없음을 선택 하셨습니다. \n\n서비스 인증 정보의 입력하신 내용이 삭제됩니다. \n해당사항 없음을 선택 하시겠습니까?");
    		  if (test) {
    			  $("#markCrtfcFile0").val('');
      		  $("#markCrtfcFile1").val('');
      		  $("#markCrtfcFile3").val('');
      			$("#cntrctNo").val('');
      			$("#isMark").val('Y');
      			
      		  $("#markCrtfcFile0").attr('disabled', 'disabled');
      		  $("#markCrtfcFile1").attr('disabled', 'disabled');
      		  $("#markCrtfcFile3").attr('disabled', 'disabled');
      		  $("#cntrctNo").attr('disabled', 'disabled');
    		  }else {
    			  $('input:checkbox[name=isMark]').prop('checked', false);
    			  return;    			  
    		  }
    	  }else{
    		  $("#markCrtfcFile0").removeAttr('disabled');
    		  $("#markCrtfcFile1").removeAttr('disabled');
    		  $("#markCrtfcFile3").removeAttr('disabled');
    		  $("#cntrctNo").removeAttr('disabled');
    		  $("#isMark").val('N');
    	  }
      }
      
      
      var fnEditDis = function(a, b, c) {
    	  
    	  if (a != '') {
    		  eval($('#'+c).removeAttr('disabled'));
    		  eval($('#'+c).focus());
    	  }
    	  if (b != '') {
    		  eval($('#'+c).val(''));
    		  eval($('#'+c).attr('disabled', 'disabled'));
    	  }
    	  
      }
      
      //글자수체크(nm, id)(id, title, maxLength){
      var displayBytes = function(nm, title, id){
    	  var obj = eval($('#'+id));//document.getElementById(id);
    	  
    	  if(nm == null) {
    		  nm = obj.attr("maxLength") != null ? obj.attr("maxLength") : 1000;
    	  }
    	  
    	  if(Number(byteCheck(obj)) > Number(nm)) {
    		  if(event.keyCode != '8' && event.keyCode != '37' && event.keyCode != '38' && event.keyCode != '39' && event.keyCode != '40'){
    			  alert(title + "이(가) 입력가능문자수를 초과하였습니다.\n(영문, 숫자, 일반 특수문자 : " + nm + " / 한글, 한자, 기타 특수문자 : " + parseInt(nm/2, 10) + ").");
    			  obj.focus();
            return false;
    		  }
    	  } 
    	  eval($('#'+id+'_bytes')).text(byteCheck(obj));
      }
      
      var byteCheck = function(el){
    	    var codeByte = 0;
    	    for (var idx = 0; idx < el.val().length; idx++) {
    	        var oneChar = escape(el.val().charAt(idx));
    	        if ( oneChar.length == 1 ) {
    	            codeByte ++;
    	        } else if (oneChar.indexOf("%u") != -1) {
    	            codeByte += 2;
    	        } else if (oneChar.indexOf("%") != -1) {
    	            codeByte ++;
    	        }
    	    }
    	    return codeByte;
    	}
      
      var fnArchtcSeChk = function(obj) {
    	  var checked1 = $('input:checkbox[id=archtcSeArry1]').is(':checked');
    	  var checked2 = $('input:checkbox[id=archtcSeArry2]').is(':checked');
    	  
    	  if (checked1 && checked2) {
    		  $("#archtcSe").val('3');
    	  }else if (checked1 && !checked2) {
    		  $("#archtcSe").val('1');
    	  }else if (!checked1 && checked2) {
    		  $("#archtcSe").val('2');
    	  }else if (!checked1 && !checked2) {
    		  alert("적어도 한개의 아키텍쳐를 선택해야 합니다.");
    		  $('input:checkbox[id=archtcSeArry1]').prop('checked', true);
    		  return false;
    	  }
      }
      
		function jsOnlyNumber(event){
			 var keyID = (event.which) ? event.which : event.keyCode;
			  if (( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) || ( keyID >=37 && keyID <= 40 ) || keyID == 8 || keyID == 9) return;
			else return false;
		}
		
		var fnCexcArea = function(obj) {
			alert(obj);
			if (obj == '1000') {
				$('input:checkbox[id=cExcArea]').attr('disabled', 'disabled');
			}
		}
		
    </script>
</head>
<body>
    <c:if test="${specVo.goodsNum eq null or specVo.goodsNum eq ''}">
    	<c:set var="goodsNum" value="0"/>
    </c:if>
    <c:if test="${specVo.goodsNum > 0}">
    	<c:set var="goodsNum" value="${specVo.goodsNum}"/>
    </c:if>

	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />

    <input type="hidden" id="goodsCode" name="goodsCode" value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId" name="userId" value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus" name="goodsStatus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsStatus" name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svFlag" name="svFlag" value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" name="formNm" value="dataForm" />

    <table class="w_100p mar_b5">
			<tr>
				<td class="tx_l">
        	<input type="button" value="변경신청이력"	class="blue w120" onclick="jsRegHistoryPop(this, '${dataVo.goodsCode}');return false;"></input>
          <%-- <input type="button" value="규격서이력 "	class="blue w120" onclick="jsSpecHistoryPop(this, '${dataVo.goodsCode}');return false;"></input> --%>
	        <input type="button" value="2.0 보기"		class="blue w120" onclick="jsAsIsViewPop(this, '${dataVo.goodsCode}');return false;"></input>
				</td>
				<td class="tx_r">
	        <input type="button" value="목록" class="blue" onclick="jsList('BD_index.do');" />
	        <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm(this);' />
           <%--  <input type="button" value="이력관리"  class="blue w80" onclick="jsHistoryPop(this, '${dataVo.goodsCode}');return false;"></input> --%>
	        <c:if test="${dataVo.goodsRegistSttus < 1008}">
	        <input type="button" value="수정완료" class="blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AA', 'dataForm');" />
	        </c:if>
        </td>
    	</tr>
    </table>
</form>
<!-- class="boardWrite" -->

	<form name="dataForm1" id="dataForm1" enctype="multipart/form-data" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" 					name="goodsNum" 				value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm1" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
    
    <table class="boardWrite mar_t20">
    	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
<!-- 서비스 기본정보 -->
				<tr>
					<td colspan="2">
						<h4>서비스 일반 정보&nbsp;&nbsp;
							<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm1');" />
						</h4>
					</td>
				</tr>
				<!-- 서비스명 -->
				<tr>
					<th><span class="tx_red_s">*</span>서비스명</th>
					<td>
						<input type="text" id="goodsNm" name="goodsNm" value="${dataVo.goodsNm}" class="w85_p" style="ime-mode:active" title="서비스명" />
						<input type="hidden" id="langCode" name="langCode" value="${dataVo.langCode}"/>
					</td>
				</tr>
				<!-- 서비스명 -->
				<!-- 서비스구분선택 [2015.01.18 추가] -->
				<tr>
			    <th><span class="tx_red_s">*</span>서비스구분선택</th>  
	        <td>
			    	<op:code type="radio" id="goodsKndCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${empty dataVo.goodsKndCd ? '1002' : dataVo.goodsKndCd}" onclick="jsCtgryList(this.value)" title="서비스구분선택" />
			    </td>
				</tr>
				<!-- //서비스구분선택 [2015.01.18 추가] -->
				<!-- 카테고리 -->
				<tr>
					<th><span class="tx_red_s">*</span>카테고리</th>
					<td>
						<div>
							<input type="button" id="ctgryBtn" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this);" />
	            <c:set var="setCtgryCodes" value=""/>
	            <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
	            	<c:choose>
	              <c:when test="${status.first}">
	              	<c:set var="setCtgryCodes" value="${_goodsCtgry.CTGRYCODE}"/>
	              </c:when>
	              <c:otherwise>
	              	<c:set var="setCtgryCodes" value="${setCtgryCodes}, ${_goodsCtgry.CTGRYCODE}"/>
	              </c:otherwise>
	              </c:choose>
	            </c:forEach>
	            <input type="hidden" id="setCtgryCodes" name="setCtgryCodes" value="${setCtgryCodes}" />
						</div>
						
						<table id="ctgryTitle">
							<tr>
						  	<td colspan="3">
						    	<div class="mar_t10 tx_b" id="test">연결된 카테고리</div>
						    </td>
						  </tr>
						</table>
						<table id="goodsCtgry">
	          	<c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
	            <tr id="goodsCtgry_${_goodsCtgry.CTGRYCODE}">
	            	<td>[${_goodsCtgry.CTGRYCLNM }]</td>
	              <td>${_goodsCtgry.CTGRYPATH}</td>
	              <td>
	              	<input type="button" id="goodsCtgry_${_goodsCtgry.CTGRYCODE}" value="X" onclick="jsCategoryDelete(this);"/>
	                <input type="hidden" name="ctgryCds" class="getCtgryCodes" value="${_goodsCtgry.CTGRYCODE}"/>
	              </td>
	            </tr>
	            </c:forEach>
						</table>
					</td>
				</tr>
				<!-- //카테고리 -->

				<!-- 과금기준 -->
				<tr>
					<th><span class="tx_red_s">*</span>과금기준</th>
					<td>
						<label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1001" value="1001" <c:if test="${dataVo.dueStdrMumm eq '1001' || dataVo.dueStdrMumm eq null}"> checked="checked" </c:if> /> 월간</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1002" value="1002" <c:if test="${dataVo.dueStdrMumm eq '1002'}"> checked="checked" </c:if> /> 연간</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1003" value="1003" <c:if test="${dataVo.dueStdrMumm eq '1003'}"> checked="checked" </c:if> /> 라이선스</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1004" value="1004" <c:if test="${dataVo.dueStdrMumm eq '1004'}"> checked="checked" </c:if> /> 사용자수</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1005" value="1005" <c:if test="${dataVo.dueStdrMumm eq '1005'}"> checked="checked" </c:if> /> 용량</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1007" value="1007" <c:if test="${dataVo.dueStdrMumm eq '1007'}"> checked="checked" </c:if> /> 사용시간</label>
			      <label><input type="radio" name="dueStdrMumm" id="dueStdrMumm_1006" value="1006" <c:if test="${dataVo.dueStdrMumm eq '1006'}"> checked="checked" </c:if> /> 무료</label>
			  	</td>
				</tr>
				<!-- //과금기준 -->

	      <!-- 서비스 가격 -->
	      <tr>
	      	<th><span class="tx_red_s">*</span>서비스 가격</th>
	        <td>
	        	<select id="svcPcUntCd" name="svcPcUntCd">
	         		<option value=""  <c:if test="${dataVo.svcPcUntCd eq '' or dataVo.svcPcUntCd eq null }"> selected="selected" </c:if>>선택</option>
			        <option value="1001" <c:if test="${dataVo.svcPcUntCd eq 1001}"> selected="selected" </c:if>>원</option>
			        <option value="1002" <c:if test="${dataVo.svcPcUntCd eq 1002}"> selected="selected" </c:if>>달러</option>
			      </select>
			      <fmt:formatNumber value="${dataVo.svcPc}" type="number" var="svcPc" />
			      <input type="text" id="svcPc" name="svcPc" value="${svcPc}" style="width:150px" maxlength="13" style="ime-mode:disabled" onchange="getNumber(this, 0);" onkeyup="getNumber(this, 0);" title="서비스 가격" />
				    <label><input type="checkbox" id="svcPcVat" name="svcPcVat" value="Y" <c:if test="${dataVo.svcPcVat eq 'Y'}">checked="checked"</c:if>> VAT 포함</label>
	        </td>
	      </tr>
	      <!-- //서비스 가격 -->
      
	      <!-- 최소 계약기간 -->
	     	<tr>
	       	<th><span class="tx_red_s">*</span>최소 계약기간</th>
	        <td>
	        	<input type="text" id="mummCntrctpd" style="width:250px"  name="mummCntrctpd" value="${dataVo.mummCntrctpd}" title="최소 계약기간" />
	      	</td>
	      </tr>
	      <!-- //최소 계약기간 -->
      
<%-- 	      <!-- 서비스 언어 -->
	     	<tr>
	     		<th><span class="tx_red_s">*</span>서비스 언어</th>
	        <td>
	        	<input name="langCode" id="langCode" type="hidden" value="${dataVo.langCode}"/>${dataVo.langNm}
	        </td>
	      </tr> --%>
	      <!-- //서비스 언어 -->
            
				<!-- 전시여부 -->
				<tr>
					<th><span class="tx_red_s">*</span>전시여부</th>
					<td>
						<c:if test="${dataVo.goodsRegistSttus < 1008}">
						<op:code type="radio" id="1212" grpCd="1008" ctgCd="DSPYN" defaultValues="${empty dataVo.goodsRegistSttus ? '1006' : dataVo.goodsRegistSttus}" option="disabled" title="전시여부"/>
						</c:if>
						<c:if test="${dataVo.goodsRegistSttus >= 1008}">비전시 변경 중이서 수정이 불가능합니다.</c:if>
					</td>
				</tr>
				<!-- //전시여부 -->

				<!-- 대표 이미지 등록 -->
				<tr>
					<th><span class="tx_red_s">*</span>대표 이미지 등록<br/>사이즈 (300X250)</th>
					<td>
						<input type="hidden" name="goodsImageFileSeq" value="<c:out value='${dataVo.goodsImageFileSeq}'/>"  />
						<!-- 대표이미지가 없을 경우 등록란 표기 -->
				    <span id="imageFile1Div" style="vertical-align: sub;overflow:hidden;" >
				    	<input type="file" name="imageFile1" id="imageFile1" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile1', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',1,'Img', -1, 5);" title="대표 이미지" />
				      <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile1');"/>
				    </span>
				    
				    <!-- 대표이미지가 있을 경우 다운로드 링크와 변경 버튼 표기 -->&nbsp;&nbsp;
				    <c:set var="fileVo" value="${dataVo.imageFile[0]}" />
			      <c:set var="image" value="" />
	          <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
	          <!--<input class="mar_l5" type="button" value="변경" onclick="javascript:file_browse();"/>-->
	          <input type="hidden" name="fileDesc" id="imageFile1Desc" value="" /><br/>
						<img src="${fileVo.fileUrl}" height="80px;">
					</td>
				</tr>
				<!-- //대표 이미지 등록 -->

				<!-- 사용자화면 이미지 -->
				<tr>
					<th>사용자화면 이미지 등록<br/>사이즈 (800X500)</th>
					<td>
						<input type="hidden" name="goodsImageFileSeq" value="<c:out value='${dataVo.goodsImageFileSeq}'/>"  />
			      <!-- 이미지 파일 갯수 -->
			      <c:set var="imgFileCnt" value="${fn:length(dataVo.imageFile)+1}" />
	          <!-- 이미지 파일이 1개 이하이면 타이틀 이미지만 등록된 상태 -->
	          <c:if test="${fn:length(dataVo.imageFile) <= 1}">
	          	<c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
	            <span id="imageFile${i}Div" style="vertical-align: sub;">
	            	<input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',${i},'Img', -1, 5);"/>
	            </span>
	            <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
	            <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
	            <c:if test="${not status.last}"><br/></c:if>
	            </c:forEach>
	          </c:if>
	          <!-- 이미지 파일이 1개 초과면 사용자 이미지가 등록된 상태 -->
	          <c:if test="${fn:length(dataVo.imageFile) > 1}">
	          	<!-- 등록된 사용자 이미지 출력 -->
	            <c:forEach items="${dataVo.imageFile}" var="fileVo" begin="1" end="${imgFileCnt}" varStatus="status">
	            <div class="mar_b5">
	            	<a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}', '', '${dataVo.goodsCode}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
	              <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
	              <c:if test="${not status.last}"><br/></c:if>
	            </div>
	            <input type="hidden" name="image" value="${fileVo.fileUrl}" />
	            </c:forEach>
	            <!-- 추가할 입력 란 -->
	            <c:forEach var="i" begin="${imgFileCnt}" end="11" step="1" varStatus="status">
	            <span id="imageFile${i}Div" style="vertical-align: sub;">
	            	<input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',${i},'Img', -1, 5);"/>
	            </span>
	            <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
	            <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
	            <c:if test="${not status.last}"><br/></c:if>
	            </c:forEach>
	            <div class="mar_b5">
	            	<c:forEach items="${dataVo.imageFile}" var="fileVo" begin="1" end="${imgFileCnt}" varStatus="status">
	              <img src="${fileVo.fileUrl}" height="80px;">
	              </c:forEach></div>
	          </c:if>
					</td>
				</tr>
				<!-- //사용자화면 이미지 -->

				<!-- 체험판 -->
				<tr>
					<th>체험판 URL</th>
					<td>
						<div class="fr">
							<p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
						  <input type="text" name="itemVodUrl" id="itemVodUrl" value="${dataVo.itemVodUrl}" class="w85_p"/>
					  </div>
					</td>
				</tr>
				<!-- //체험판 -->
			
				<!-- 서비스상세 -->
				<tr>
					<th>서비스 안내 URL</th>
					<td>
						<div class="fr ml20">
							<p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
							<input type="text" name="goodsDwldUrl" id="goodsDwldUrl" value="<c:out value='${dataVo.goodsDwldUrl}'/>" class="w85_p" title="서비스 안내 URL" />
						</div>
					</td>
				</tr>
				<!-- //서비스상세 -->
<!-- //서비스기본정보 -->

			<!-- 소개영상 -->
<%-- 	2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함		
				<tr>
				    <th>소개영상</th>
					<td>
						<div class="fr ml20">
							<p class="caption">※ 유투브에 등록된 동영상만 지원 가능합니다.</p>
							<strong><span>https://www.youtube.com/embed/</span></strong>
							<input name="demoExprnUrl" id="demoExprnUrl" type="text" value="<c:out value='${dataVo.demoExprnUrl}'/>" style="width:330px" />
						</div>
					</td>
				</tr> 
--%>
			<!-- //소개영상 -->
			
				<!-- 모니터링 URL -->
				<tr>
					<th>모니터링 URL</th>
					<td>
						<div class="fr ml20">
							<p class="caption">※ 모니터링URL  서비스 상태를  확인할 수 있는 모니터링 URL을 입력해주세요.</p>
							<input name="goodsMonitorUrl" id="goodsMonitorUrl" type="text" value="<c:out value='${dataVo.goodsMonitorUrl}'/>" class="w85_p" title="모니터링 URL" />
						</div>
					</td>
				</tr>
				<!-- //모니터링 URL -->
    	</tbody>
    </table>
	</form>    

<!-- 상세 정보 -->
	<form name="dataForm2" id="dataForm2"  method="post">
		<input type="hidden" id="goodsKndCd" 				name="goodsKndCd" 			value="${dataVo.goodsKndCd}" />
    <input type="hidden" id="goodsCode" 				name="goodsCode" 				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId" 						name="userId" 					value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus" 			name="goodsStatus" 			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag" 					value="" />
    <input type="hidden" id="goodsNum" 					name="goodsNum" 				value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm" 					value="dataForm2" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
    
		<table class="boardWrite mar_t20">
	  	<colgroup>
	      <col width="150" />
	    	<col width="" />
	    </colgroup>
	    <tbody>
	    	<tr>
	    		<td colspan='2'>
	    			<h4>상세 정보&nbsp;&nbsp;
	    				<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm2');" />
	    			</h4>
	    		</td>
	    	</tr>
        <tr>
        	<th><span class="tx_red_s">*</span>서비스개요</th>
        	<td>
        		<textarea name="goodsSumry" id="goodsSumry" rows="15" class="w_85p" onkeyup="javascript:displayBytes(3000,'서비스개요', 'goodsSumry');" title="서비스개요"  >${dataVo.goodsSumry}</textarea>
            <p class="ar mt5">
            	<span class="byte"><span id="goodsSumry_bytes" class="txt-point">0</span><span class="caption">/ 3000 Byte</span></span>
            </p>
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>특장점</th>
          <td>
          	<textarea name="itemSfe" id="itemSfe" rows="15" class="w_85p" title="특장점"  ><c:out value="${dataVo.itemSfe}" escapeXml="false"/></textarea>
              <script type="text/javascript">
              //<![CDATA[
			        CKEDITOR.replace('itemSfe', {
			            height               	: 200,
			            width									: 880,
			            htmlEncodeOutput     	: false,
			            enterMode            	: "2",
			            skin                 	: "moono",
			            toolbar              	: [[ 'BulletedList' ]],
			            filebrowserUploadUrl	: "/component/file/ND_fileUpload.do",
		                            on			: {instanceReady:function(){
		                            								var liStr = /<li>(.*?)<(\/?)li>/gi;
		                                						if($("#goodsSumry").val().trim().match(liStr) == null){this.execCommand( 'bulletedlist' );}
		                                						$("#goodsSumry").focus();}}
			        });
              //]]>
              </script>
                        
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>대상고객</th>
        	<td>
        		<textarea name="cstmrInfo" id="cstmrInfo" rows="15" class="w_85p" title="대상고객"  ><c:out value="${dataVo.cstmrInfo}" escapeXml="false"/></textarea>
             <script type="text/javascript">
             //<![CDATA[
                 CKEDITOR.replace('cstmrInfo', {
                     height               : 200,
                     width								: 880,
                     htmlEncodeOutput     : false,
                     enterMode            : "2",
                     skin                 : "moono",
                     toolbar              : [[ 'BulletedList' ]],
			           		 filebrowserUploadUrl	: "/component/file/ND_fileUpload.do",
                       						 on			: {instanceReady:function(){
			                        								var liStr = /<li>(.*?)<(\/?)li>/gi;
			                            						if($("#cstmrInfo").val().trim().match(liStr) == null){this.execCommand( 'bulletedlist' );}
			                            						$("#cstmrInfo").focus();}}
                 });
             //]]>
             </script>
          </td>
        </tr>    
        <tr>
	        <th><span class="tx_red_s">*</span>주요기능</th>
	        <td>
	        	<textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" class="w_85p" title="주요기능"  ><c:out value="${dataVo.goodsMainFnct}" escapeXml="false"/></textarea>
	            <script type="text/javascript">
	            //<![CDATA[
	            	CKEDITOR.replace('goodsMainFnct', {
	               height               : 200,
	               width									: 880,
	               htmlEncodeOutput     : false,
	               enterMode            : "2",
	               skin                 : "moono",
	               toolbar              : [[ 'BulletedList' ]],
	               filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
	               						on			: {instanceReady:function(){
	                   									var liStr = /<li>(.*?)<(\/?)li>/gi;
	                   									if($("#goodsMainFnct").val().trim().match(liStr) == null){this.execCommand( 'bulletedlist' );}
	                   									$("#goodsMainFnct").focus();}}
	           });
	           //]]>
	           </script>
	        </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>주요 레퍼런스<br />(등록 서비스 기준)</th>
          <td>
          	<textarea id="goodsRefer"	name="goodsRefer" rows="15" class="w_85p" title="주요 레퍼런스"  ><c:out value="${dataVo.goodsRefer}" escapeXml="false"/></textarea>
            <script type="text/javascript">
            //<![CDATA[
            	CKEDITOR.replace('goodsRefer', {
            		height               : 200,
            		width									: 880,
            		htmlEncodeOutput     : false,
            		enterMode            : "2",
            		skin                 : "moono",
            		toolbar              : [[ 'BulletedList' ]],
 	              filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
 	              						  on			: {instanceReady:function(){
 	              							  				var liStr = /<li>(.*?)<(\/?)li>/gi;
 	              							  				if($("#goodsRefer").val().trim().match(liStr) == null){this.execCommand( 'bulletedlist' );}
 	              							  				$("#goodsRefer").focus();}}
              });
            //]]>
            </script>
						<%--<input type="text" id="mainRefer" name="mainRefer" value="${specInfo.mainRefer}"> --%>
            </td>
        </tr>
        <tr>
          <th><span class="tx_red_s">*</span>서비스 기대효과</th>
          <td>
          	<textarea name="goodsExpcEffect" id="goodsExpcEffect" rows="15" class="w_85p" title="서비스 기대효과"  ><c:out value="${dataVo.goodsExpcEffect}" escapeXml="false"/></textarea>
            <script type="text/javascript">
            //<![CDATA[
                CKEDITOR.replace('goodsExpcEffect', {
                    height               : 200,
                    width									: 880,
                    htmlEncodeOutput     : false,
                    enterMode            : "2",
                    skin                 : "moono",
                    toolbar              : [[ 'BulletedList' ]],
   	              	filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
					  										on			: {instanceReady:function(){
																	  				var liStr = /<li>(.*?)<(\/?)li>/gi;
																	  				if($("#goodsExpcEffect").val().trim().match(liStr) == null){this.execCommand( 'bulletedlist' );}
																	  				$("#goodsExpcEffect").focus();}}
                });
                
            //]]>
            </script>
          </td>
        </tr>
        </table>
</form>
<!-- //상세 정보 -->
<c:if test="${dataVo.goodsKndCd ne '1004'}">
<form name="dataForm3" id="dataForm3"  method="post">
		<input type="hidden" id="goodsKndCd" 				name="goodsKndCd" 			value="${dataVo.goodsKndCd}" />
    <input type="hidden" id="goodsCode" 				name="goodsCode" 				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId" 						name="userId" 					value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus" 			name="goodsStatus" 			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag" 					value="" />
    <input type="hidden" id="goodsNum" 					name="goodsNum" 				value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm" 					value="dataForm3" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
    
<!-- 서비스 사양 정보 -->
	  <table class="boardWrite mar_t20">
	  	<colgroup>
	      <col width="150" />
	    	<col width="" />
	    </colgroup>
	    <tbody>
	    	<tr>
	    		<td colspan='2'>
	    			<h4>
	    				서비스 사양 정보&nbsp;&nbsp; 
	    				<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm3');" />
	    			</h4>
	    		</td>
	    	</tr>
				<!-- 서비스 관리 기준-->
	      <tr>
	      	<th><span class="tx_red_s">*</span>서비스 관리 기준</th>
	       	<td>
	         	<input id="metaSvcBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2030, '', '');"></input>
	           <span id="metaSvcNm"><c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status">${_goodsMetaSvc.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
	           <input type="hidden" id="metaSvcs" name="metaSvcs" value="<c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status">${_goodsMetaSvc.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
	      	</td>
	      </tr>
	      <!-- //서비스 관리 기준 -->
	      <!-- 구축방식 -->
	      <tr>
	       	<th><span class="tx_red_s">*</span>구축방식</th>
	        <td>
	        	<input id="metaCnstcMthdBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2032, '', '');"></input>
						<span id="metaCnstcMthdNm"><c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
	          <input type="hidden" name="metaCnstcMthds" id="metaCnstcMthds" value="<c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">${_goodsMetaCnstcMthd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
	        </td>
	      </tr>
	      <!-- //구축방식 -->
				<!-- 서비스 유형 -->
				<tr>
					<th><span class="tx_red_s">*</span>서비스 유형</th>
					<td>
						<op:code id="serviceOfferMethod" grpCd="2034" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="${dataVo.serviceOfferMethod}" type="radio" defaultLabel="구분" title="서비스 유형" />
					</td>
				</tr>
				<!-- //서비스 유형 -->
	      <!-- 아키텍쳐 -->
	      <tr>
	      	<th><span class="tx_red_s">*</span>아키텍쳐</th>
	        <td>
	        	<label><input type="checkbox" id="archtcSeArry1" name="archtcSeArry" value="1" <c:if test="${dataVo.archtcSe eq '1' || dataVo.archtcSe eq '3'}">checked="checked"</c:if> onclick="fnArchtcSeChk(this.value);" />32-BIT</label>
		        <label><input type="checkbox" id="archtcSeArry2" name="archtcSeArry" value="2" <c:if test="${dataVo.archtcSe eq '2' || dataVo.archtcSe eq '3'}">checked="checked"</c:if> onclick="fnArchtcSeChk(this.value);" />64-BIT</label>
						<input name="archtcSe" id="archtcSe" type="hidden" value="${dataVo.archtcSe}"/>
	        </td>
	      </tr>
	      <!-- //아키텍쳐 -->
	      <!-- 지원OS -->
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원OS</th>
	        <td>
	        	<input type="button" id="metaOSsBtn" value="선택" class="blue w80" onclick="jsMetaPop(this, 1020, '', '');"></input>
	          <span id="metaOSnm" class="caption mr10"><c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">${_goodsMetaOS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
	          <input type="hidden" name="metaOSs" id="metaOSs" value="<c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">${_goodsMetaOS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaOS.INDVDLZ_CD == 9001}"><c:set var="metaOSetc" value="${_goodsMetaOS.META_ETC_CN}"/></c:if></c:forEach>"/>
	          <input type="hidden" name="metaOSetc" id="metaOSetc" value="${metaOSetc}"/>
	          <input type="hidden" name="metaOSnms" id="metaOSnms" value=""/>
	        </td>
	      </tr>
	      <!-- //지원OS -->
				<!-- 지원언어 -->
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원언어</th>
	        <td>
	        	<span class="agree">
							<c:set var="metaLangEtcOpen" value="readOnly" scope="page"/>
							<c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
		          	<input type="checkbox" name="metaLangs" id="metaLangs${_goodsMetaLang.LANGCD}" value="${_goodsMetaLang.LANGCD}" <c:if test="${_goodsMetaLang.LANGCD == _goodsMetaLang.METALANGCD}"> checked="checked"</c:if>/>
		            <span id="metaLangs${_goodsMetaLang.LANGCD}Nm"  class="caption mr10">${_goodsMetaLang.LANGNM}</span>
		            <c:if test="${_goodsMetaLang.METALANGCD == 1006}">
		            	<c:set var="metaLangEtcOpen" value="" scope="page"/>
		            </c:if>
		            <c:if test="${status.last}">
		            	<input type="text" name="metaLangEtc" id="metaLangEtc" style="width: 250px;"  value="<c:out value='${_goodsMetaLang.METAETCCN}'/>" <c:out value='${metaLangEtcOpen}'/>/>
		            </c:if>
		          </c:forEach>
		          <input name="metaLangsNm" id="metaLangsNm" type="hidden" value=""/>
						</span>
	        </td>
	      </tr>
	      <!-- //지원언어 -->
	      <!-- A/S방침 -->
	      <tr>
	      	<th><span class="tx_red_s">*</span>A/S방침</th>
	        <td>
	        	<input type="button" id="metaASsBtn" name="metaASsBtn" value="선택" class="blue w80" onclick="jsMetaPop(this, 1021, '1000', '1999');" />
	          <span id="metaASnm" class="caption mr10"><c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
	          <input type="hidden" id="metaASs" 	name="metaASs" 		value="<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaAS.INDVDLZ_CD == 1005}"><c:set var="metaASetc" value="${_goodsMetaAS.META_ETC_CN}"/></c:if></c:forEach>"/>
	          <input type="hidden" id="metaASetc" name="metaASetc"	value="${metaASetc}"/>
	          <input type="hidden" id="metaASnms" name="metaASnms"	value=""/>
	        </td>
	      </tr>
	      <!-- //A/S방침 -->
	      <!-- 호환성(표준) -->
	      <tr>
	       	<th><span>호환성(표준)</span></th>
	        <td>
	        	<input type="button" id="metaStdBtn" name="metaStdBtn" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2031, '', '');" />
						<span id="metaStdNm"><c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status">${_goodsMetaStd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
	          <input type="hidden" id="metaStds" name="metaStds" value="<c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status">${_goodsMetaStd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
	        </td>
				</tr>
	      <!-- //호환성(표준) -->
        <!-- 제조사 -->
        <tr>
        	<th><span class="tx_red_s">*</span>제조사</th>
          <td><input type="text" id="goodsMakr" name="goodsMakr" class="w40_p" value="${dataVo.goodsMakr}" title="제조사" /></td>
        </tr>
        <!-- //제조사 -->
        <!-- 출시일 -->
        <tr>
        	<th><span class="tx_red_s">*</span>출시일</th>
          <td><input type="text" id="comouDe" name="comouDe" class="w40_p" value="${dataVo.comouDe}" maxlength="8" onchange="getNumber(this, 1);" onkeyup="getNumber(this, 1);" title="출시일" /><br/>(입력예시 : 20140501)</td>
        </tr>
        <!-- //출시일 -->
	   	</tbody>
	   </table>
</form>
</c:if>
<!-- //서비스 사양 정보 -->

<c:if test="${dataVo.goodsKndCd ne '1004'}">
<!-- 인증 정보-->
<form name="dataForm4" id="dataForm4" enctype="multipart/form-data" method="post">
		<input type="hidden" id="goodsKndCd" 				name="goodsKndCd" 			value="${dataVo.goodsKndCd}" />
    <input type="hidden" id="goodsCode" 				name="goodsCode" 				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId" 						name="userId" 					value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus" 			name="goodsStatus" 			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag" 					value="" />
    <input type="hidden" id="goodsNum" 					name="goodsNum" 				value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm" 					value="dataForm4" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20" id="certInfo">
     	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>
      				서비스 인증 정보&nbsp;&nbsp;
      				<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm4');" />&nbsp;&nbsp;
      				<label><input type="checkbox" id="isMark" name="isMark" onclick="isMarking();" value="${dataVo.isMark}" <c:if test="${dataVo.isMark eq 'Y'}">checked="checked"</c:if> />해당사항 없음</label>
      			</h4>
<%--       			<div style="padding-left: 200px;margin-top: -26px;position: relative;">
      				<label><input type="checkbox" id="isMark" name="isMark" onclick="isMarking();" value="${dataVo.isMark}" <c:if test="${dataVo.isMark eq 'Y' or dataVo.isMark eq '' or dataVo.isMark eq null}">checked="checked"</c:if> />해당사항 없음</label>
      			</div> --%>
      		</td>
      	</tr>
				<tr>
					<th>인증구분</th>
					<td>
						<table style="width:100%">
							<c:forEach items="${dataVo.goodsMark}" var="_goodsMark" varStatus="statusSeq">
							<c:set var="goodsMarkCnt" value="${fn:length(dataVo.markCrtfcFile[ statusSeq.index ])}" />
							<input type="hidden" id="crtfcSeFileSeqs" name="crtfcSeFileSeqs" value="${_goodsMark.CRTFCSEFILESEQ}" />
							<input type="hidden" id="markCds" name="markCds" value="${_goodsMark.MARKCD}"></input>
							<tr>
						    <td width="200px">
						    	${_goodsMark.MARKNM}
						      <%-- <input type="checkbox" name="goodsMarkCds" value="${_goodsMark.MARKCD}" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>${_goodsMark.MARKNM} --%>
						    </td>
						    <!-- 나라장터 종합쇼핑몰 일경우 -->
						    <c:if test="${_goodsMark.MARKCD == '1005'}">
						    <td>
						    	<input type="text" id="cntrctNo" name="cntrctNo" style="width:630px" value="<c:out value='${dataVo.cntrctNo}'/>" <c:if test="${dataVo.isMark eq 'Y'}">disabled="disabled"</c:if>/>
	                <p class="mt10 caption">* 계약번호는 “-(하이픈)”을 제거하고 입력해주세요.</p>
	              </td>
						    </c:if>
						    
						    <!-- 그 이외[CC/KACI/KISA] -->
	              <c:if test="${_goodsMark.MARKCD != '1005'}">
						    <td>
						    	<!-- 등록된 인증 마크가 있을 경우 다운로드 링크와 삭제버튼 표기 -->
						      <c:if test="${goodsMarkCnt > 0}">
						      <c:forEach items="${dataVo.markCrtfcFile[ statusSeq.index ]}" var="fileVo" varStatus="status">
							    <div class="mar_b5">
								    <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}', '${_goodsMark.MARKCD}', '${dataVo.goodsCode}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
								    <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
								    <c:if test="${not status.last}"><br/></c:if>
								    <input type="hidden" id="crtfcSeFileIds" name="crtfcSeFileIds" value="${fileVo.fileId}"></input>
							    </div>
						      </c:forEach>
						      </c:if>
						        
						      <!-- 등록된 인증 마크가 없을 경우 등록란 표기 -->
						      <c:if test="${goodsMarkCnt == 0}">
						      	<span id="markCrtfcFile${statusSeq.index}Div"  style="vertical-align: sub;">
						        	<input type="file" name="markCrtfcFile${statusSeq.index}" id="markCrtfcFile${statusSeq.index}" class="markCrtfcFile${statusSeq.index} w_92p" onchange="jsFileChk('markCrtfcFile${statusSeq.index}', 5120, '1', -1, 1);" <c:if test="${dataVo.isMark eq 'Y'}">disabled="disabled"</c:if> accept=".pdf"/>
						        </span>
						        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}');"/>
						        <input type="hidden" name="fileDesc" id="markCrtfcFile${statusSeq.index}Desc" value=""></input>
						      </c:if>
						    </td>
						  </c:if>
							</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
</form>
</c:if>
<!-- //인증 정보-->

<c:if test="${dataVo.goodsKndCd ne '1004'}">
<!-- 서비스 기술정보-->
<form name="dataForm5" id="dataForm5" method="post">
		<input type="hidden" id="goodsKndCd" 				name="goodsKndCd" 			value="${dataVo.goodsKndCd}" />
    <input type="hidden" id="goodsCode" 				name="goodsCode" 				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId" 						name="userId" 					value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus" 			name="goodsStatus" 			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag" 					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm" 					value="dataForm5" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>서비스 기술정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm5');" /></h4>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 시작 절차</th>
      		<td><input type="text" id="svcBeginProcss" name="svcBeginProcss" value="${specVo.svcBeginProcss}" class="w_92p" title="서비스 시작 절차" /></td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 종료 절차</th>
      		<td><input type="text" id="svcEndProcss" name="svcEndProcss" value="${specVo.svcEndProcss}" class="w_92p" title="서비스 종료 절차" /></td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 평가판 제공여부 및 제공기간</th>
      		<td>
      			<label><input type="radio" id="atSvcEvl" name="atSvcEvl" value="Y" <c:if test="${specVo.atSvcEvl eq 'Y' || specVo.atSvcEvl ne null || specVo.atSvcEvl ne ''}">checked="checked"</c:if> onClick="fnEditDis('atSvcEvlYes', '', 'svcEvlSuplyPd');"/> YES</label>
      			<label><input type="radio" id="atSvcEvl" name="atSvcEvl" value="N" <c:if test="${specVo.atSvcEvl eq 'N' || specVo.atSvcEvl eq null || specVo.atSvcEvl eq ''}">checked="checked"</c:if> onClick="fnEditDis('', 'atSvcEvlNo', 'svcEvlSuplyPd')"/> NO</label>
      			<input type="text"  id="svcEvlSuplyPd" name="svcEvlSuplyPd" value="${specVo.svcEvlSuplyPd}" class="w85_p" <c:if test="${specVo.atSvcEvl eq 'N' || specVo.atSvcEvl eq null || specVo.atSvcEvl eq ''}">disabled="disabled"</c:if> />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>SLA 적용여부</th>
      		<td>
      			<label><input type="radio"  id="slaApplcAt" name="slaApplcAt" value="Y" <c:if test="${specVo.slaApplcAt eq 'Y' || specVo.slaApplcAt ne null || specVo.slaApplcAt ne ''}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="slaApplcAt" name="slaApplcAt" value="N" <c:if test="${specVo.slaApplcAt eq 'N' || specVo.slaApplcAt eq null || specVo.slaApplcAt eq ''}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 가용성</th>
      		<td>
      			<label><input type="text" id="svcUseful" name="svcUseful" value="${specVo.svcUseful}" style="width:5%; margin-left: 5px; ime-mode:disabled;" title="서비스 가용성"  /> % (소수점 1자리)</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>자동 확장 지원여부</th>
      		<td>
      			<label><input type="radio"  id="atmcEstnSportAt" name="atmcEstnSportAt" value="Y" <c:if test="${specVo.atmcEstnSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="atmcEstnSportAt" name="atmcEstnSportAt" value="N" <c:if test="${specVo.atmcEstnSportAt eq 'N' || specVo.atmcEstnSportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>클러스터링 지원여부</th>
      		<td>
      			<label><input type="radio"  id="clusteringSportAt" name="clusteringSportAt" value="Y" <c:if test="${specVo.clusteringSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="clusteringSportAt" name="clusteringSportAt" value="N" <c:if test="${specVo.clusteringSportAt eq 'N' || specVo.clusteringSportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>셀프서비스 프로비저닝 지원여부</th>
      		<td>
      			<label><input type="radio"  id="sfsrvProvisioningSportAtYes" name="sfsrvProvisioningSportAt" value="Y" <c:if test="${specVo.sfsrvProvisioningSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="sfsrvProvisioningSportAtNo"  name="sfsrvProvisioningSportAt" value="N" <c:if test="${specVo.sfsrvProvisioningSportAt eq 'N' || specVo.sfsrvProvisioningSportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 프로비저닝 시간</th>
      		<td>
      			<input type="text" id="svcProvisioningTime" name="svcProvisioningTime" value="${specVo.svcProvisioningTime}" style="width:5%; margin-left: 5px; text-align: right; ime-mode:disabled;" title="서비스 프로비저닝 시간" /> <label for="svcProvisioningTime">분</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 프로비저닝 해제 시간</th>
      		<td>
      			<input type="text" id="svcProvisioningRelisTime" name="svcProvisioningRelisTime" value="${specVo.svcProvisioningRelisTime}" style="width:5%; margin-left: 5px; text-align: right; ime-mode:disabled;" title="서비스 프로비저닝 해제 시간" /> <label for="svcProvisioningRelisTime">분</label>
      		</td>
      	</tr>
			</tbody>
		</table>
</form>
</c:if>

<c:if test="${dataVo.goodsKndCd ne '1004'}">
<!-- 서비스 및 데이터관리 정보-->
<form name="dataForm6" id="dataForm6" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm6" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>서비스 및 데이터관리 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm6');" /></h4>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>데이터센터 국내, 외 위치 정보</th>
      		<td>
      			<label><input type="radio"  id="dataCnterLcInfo" name="dataCnterLcInfo" value="1001" <c:if test="${specVo.dataCnterLcInfo eq 1001 || specVo.dataCnterLcInfo eq null}">checked="checked"</c:if> /> 국내</label>
      			<label><input type="radio"  id="dataCnterLcInfo" name="dataCnterLcInfo" value="1002" <c:if test="${specVo.dataCnterLcInfo eq 1002}">checked="checked"</c:if> /> 국외</label>
      			<label><input type="radio"  id="dataCnterLcInfo" name="dataCnterLcInfo" value="1003" <c:if test="${specVo.dataCnterLcInfo eq 1003}">checked="checked"</c:if> /> 국내/국외</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>데이터센터 위치 정보</th>
      		<td>
      			<input type="text" id="dataCnterHbrdLcInfo" name="dataCnterHbrdLcInfo" value="${specVo.dataCnterHbrdLcInfo}" style="width:85%; margin-left: 5px;" title="데이터센터 위치 정보"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>재해복구 계획</th>
      		<td>
      			<input type="text" id="dsstrrecovryPlan" name="dsstrrecovryPlan" value="${specVo.dsstrrecovryPlan}" style="width:85%; margin-left: 5px;" title="재해복구 계획"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>데이터 추출 절차</th>
      		<td>
      			<input type="text" id="dataExtrcProcss" name="dataExtrcProcss" value="${specVo.dataExtrcProcss}" style="width:85%; margin-left: 5px;" title="데이터 추출 절차"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>미사용 데이터 보호정책</th>
      		<td>
      			<input type="text" id="unuseDataPrtcPolicy" name="unuseDataPrtcPolicy" value="${specVo.unuseDataPrtcPolicy}" style="width:85%; margin-left: 5px;" title="미사용 데이터 보호정책"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>안전한 데이터 삭제정책</th>
      		<td>
      			<input type="text" id="safeDataDeletePolicy" name="safeDataDeletePolicy" value="${specVo.safeDataDeletePolicy}" style="width:85%; margin-left: 5px;" title="안전한 데이터 삭제정책"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 관리 및 현황정보 제공</th>
      		<td>
      			<label><input type="radio"  id="svcManageSttusInfoSuply" name="svcManageSttusInfoSuply" value="Y" <c:if test="${specVo.svcManageSttusInfoSuply eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="svcManageSttusInfoSuply" name="svcManageSttusInfoSuply" value="N" <c:if test="${specVo.svcManageSttusInfoSuply eq 'N' || specVo.svcManageSttusInfoSuply eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>서비스 이용 로그 제공 여부</th>
      		<td>
      			<label><input type="radio"  id="svcUseLogSuplyAt" name="svcUseLogSuplyAt" value="Y" <c:if test="${specVo.svcUseLogSuplyAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="svcUseLogSuplyAt" name="svcUseLogSuplyAt" value="N" <c:if test="${specVo.svcUseLogSuplyAt eq 'N' || specVo.svcUseLogSuplyAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>장애관리 및 보고 정책</th>
      		<td>
      			<input type="text" id="troblManageReprtPolicy" name="troblManageReprtPolicy" value="${specVo.troblManageReprtPolicy}" style="width:85%; margin-left: 5px;" title="장애관리 및 보고 정책"  />
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>API지원 여부 및 타입</th>
      		<td>
      			<label><input type="radio"  id="apiSportAt" name="apiSportAt" value="Y" <c:if test="${specVo.apiSportAt eq 'Y'}">checked="checked"</c:if> onClick="fnEditDis('apiSportAt', '', 'apiSportTy');"/> YES</label>
      			<label><input type="radio"  id="apiSportAt" name="apiSportAt" value="N" <c:if test="${specVo.apiSportAt eq 'N' || specVo.apiSportAt eq null}">checked="checked"</c:if> onClick="fnEditDis('', 'apiSportAt', 'apiSportTy');"/> NO</label>
      			<input type="text" id="apiSportTy" name="apiSportTy" value="${specVo.apiSportTy}" style="width:77%; margin-left: 5px;" <c:if test="${specVo.apiSportAt eq 'N' || specVo.apiSportAt eq null}">disabled="disabled"</c:if>/>
      		</td>
      	</tr>
      </tbody>
    </table>
</form>
</c:if>

<c:if test="${dataVo.goodsKndCd ne '1004'}">
<!-- 서비스지원 정보-->
<form name="dataForm7" id="dataForm7" method="post">
    <input type="hidden"	id="goodsCode"				name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden"	id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden"	id="goodsStatus"			name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden"	id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden"	id="svcFlag"					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden"	id="formNm"						name="formNm"						value="dataForm7" />
    <input type="hidden"	id="langCode"					name="langCode" 				value="${dataVo.langCode}" />
    <input type="hidden"	id="userMnlInfoAt"		name="userMnlInfoAt"		value="Y"/>
    <input type="hidden"	id="userMnlInfoInput"	name="userMnlInfoInput" value="${specVo.userMnlInfoInput}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>서비스지원 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm7');" /></h4>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>사용자 매뉴얼 제공 여부</th>
      		<td>
      			<label><input type="radio" id="userMnlSuplyAt" name="userMnlSuplyAt" value="Y" <c:if test="${specVo.userMnlSuplyAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio" id="userMnlSuplyAt" name="userMnlSuplyAt" value="N" <c:if test="${specVo.userMnlSuplyAt eq 'N' || specVo.userMnlSuplyAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
<%--       	
      	<tr>
      		<th><span class="tx_red_s">*</span>사용자 매뉴얼 정보 유무 및 설명</th>
      		<td>
      			<label><input type="radio" id="userMnlInfoAt" name="userMnlInfoAt" value="Y" <c:if test="${specVo.userMnlInfoAt eq 'Y'}">checked="checked"</c:if> onClick="fnEditDis('userMnlInfoAt', '', 'userMnlInfoInput');"/> YES</label>
      			<label><input type="radio" id="userMnlInfoAt"	name="userMnlInfoAt" value="N" <c:if test="${specVo.userMnlInfoAt eq 'N' || specVo.userMnlInfoAt eq null}">checked="checked"</c:if> onClick="fnEditDis('', 'userMnlInfoAt', 'userMnlInfoInput');"/> NO</label>
      			<input type="text"   id="userMnlInfoInput"  name="userMnlInfoInput" value="${specVo.userMnlInfoInput}" style="width:77%; margin-left: 5px;" <c:if test="${specVo.userMnlInfoAt eq 'N' || specVo.userMnlInfoAt eq null}">disabled="disabled"</c:if>/>
      		</td>
      	</tr>
--%>
      	<tr>
      		<th><span class="tx_red_s">*</span>사용자 교육 지원 여부 및 정보</th>
      		<td>
      			<label><input type="radio"  id="userEdcSportAt" name="userEdcSportAt" value="Y" <c:if test="${specVo.userEdcSportAt eq 'Y'}">checked="checked"</c:if> onClick="fnEditDis('userEdcSportAt', '', 'userEdcSportInput');"/> YES</label>
      			<label><input type="radio"  id="userEdcSportAt" name="userEdcSportAt" value="N" <c:if test="${specVo.userEdcSportAt eq 'N' || specVo.userEdcSportAt eq null}">checked="checked"</c:if> onClick="fnEditDis('', 'userEdcSportAt', 'userEdcSportInput');"/> NO</label>
      			<input type="text"   id="userEdcSportInput" name="userEdcSportInput" value="${specVo.userEdcSportInput}" style="width:77%; margin-left: 5px;" <c:if test="${specVo.userEdcSportAt eq 'N' || specVo.userEdcSportAt eq null}">disabled="disabled"</c:if>/>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>방문 교육 지원 여부</th>
      		<td>
      			<label><input type="radio"  id="visitEdcSportAt" name="visitEdcSportAt" value="Y" <c:if test="${specVo.visitEdcSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="visitEdcSportAt" name="visitEdcSportAt" value="N" <c:if test="${specVo.visitEdcSportAt eq 'N' || specVo.visitEdcSportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>방문 기술 지원 여부</th>
      		<td>
      			<label><input type="radio"  id="visitTchnlgySportAt" name="visitTchnlgySportAt" value="Y" <c:if test="${specVo.visitTchnlgySportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="visitTchnlgySportAt" name="visitTchnlgySportAt" value="N" <c:if test="${specVo.visitTchnlgySportAt eq 'N' || specVo.visitTchnlgySportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>방문 외 기술 지원 여부(온라인,이메일,전화 등)</th>
      		<td>
      			<label><input type="radio"  id="visitElseTchnlgySportAt" name="visitElseTchnlgySportAt" value="Y" <c:if test="${specVo.visitElseTchnlgySportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
      			<label><input type="radio"  id="visitElseTchnlgySportAt" name="visitElseTchnlgySportAt" value="N" <c:if test="${specVo.visitElseTchnlgySportAt eq 'N' || specVo.visitElseTchnlgySportAt eq null}">checked="checked"</c:if> /> NO</label>
      		</td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>고객센터 운영 여부 및 운영시간</th>
      		<td>
      			<label><input type="radio"  id="cstmrCnterOperAt" name="cstmrCnterOperAt" value="Y" <c:if test="${specVo.cstmrCnterOperAt eq 'Y'}">checked="checked"</c:if> onClick="fnEditDis('cstmrCnterOperAt', '', 'cstmrCnterOperTime');"/> YES</label>
      			<label><input type="radio"  id="cstmrCnterOperAt"	name="cstmrCnterOperAt" value="N" <c:if test="${specVo.cstmrCnterOperAt eq 'N' || specVo.cstmrCnterOperAt eq null}">checked="checked"</c:if> onClick="fnEditDis('', 'cstmrCnterOperAt', 'cstmrCnterOperTime');"/> NO</label>
      			<input type="text" id="cstmrCnterOperTime" name="cstmrCnterOperTime" value="${specVo.cstmrCnterOperTime}" style="width:77%; margin-left: 5px;"  <c:if test="${specVo.cstmrCnterOperAt eq 'N' || specVo.cstmrCnterOperAt eq null}">disabled="disabled"</c:if>/>
      		</td>
      	</tr>
      </tbody>
    </table>
</form>
</c:if>

<!-- 소프트웨어형 서비스(SaaS) 관련 규격정보-->
<c:if test="${dataVo.goodsKndCd eq '1002' }">
<form name="dataForm8" id="dataForm8" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm8" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
      	<col width="160" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="3">
      			<h4>소프트웨어형 서비스(SaaS) 관련 규격정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm8');" /></h4>
      		</td>
      	</tr>
      	<tr>
      		<th rowspan="2">서비스 제공 방식</th>
         	<th><span class="tx_red_s">*</span>사용자용 서비스 제공 방식</th>
         	<td><input type="text" id="sUserSvcSuplyMthd" name="sUserSvcSuplyMthd" value="${specVo.sUserSvcSuplyMthd}" style="width:85%; margin-left: 5px;" title="사용자용 서비스 제공 방식" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>관리용 서비스 제공 방식</th>
         	<td><input type="text" id="sManageSvcSuplyMthd" name="sManageSvcSuplyMthd" value="${specVo.sManageSvcSuplyMthd}" style="width:85%; margin-left: 5px;" title="관리용 서비스 제공 방식" /></td>
        </tr>
        <tr>
        	<th rowspan="5">서비스 보안 관리</th>
        	<th><span class="tx_red_s">*</span>인프라 제공 방식</th>
        	<td><input type="text" id="sInfrstrctrSuplyMthd" name="sInfrstrctrSuplyMthd" value="${specVo.sInfrstrctrSuplyMthd}" style="width:85%; margin-left: 5px;" title="인프라 제공 방식" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>보안 정책 </th>
        	<td><input type="text" id="sScrtyPolicy" name="sScrtyPolicy" value="${specVo.sScrtyPolicy}" style="width:85%; margin-left: 5px;" title="보안 정책"  /></td>
        </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>데이터 암호화 여부 및 방식</th>
	      	<td><input type="text" id="sDataEncptAtMthd" name="sDataEncptAtMthd" value="${specVo.sDataEncptAtMthd}" style="width:85%; margin-left: 5px;" title="데이터 암호화 여부 및 방식" /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>백업 및 복구 정책</th>
	      	<td><input type="text" id="sBackupRecovryPolicy" name="sBackupRecovryPolicy" value="${specVo.sBackupRecovryPolicy}" style="width:85%; margin-left: 5px;" title="백업 및 복구 정책" /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>사용자 인증 및 보안 보호 정책</th>
	      	<td><input type="text" id="sUserCrtfcScrtyPrtcPolicy" name="sUserCrtfcScrtyPrtcPolicy" value="${specVo.sUserCrtfcScrtyPrtcPolicy}" style="width:85%; margin-left: 5px;" title="사용자 인증 및 보안 보호 정책"  /></td>
	      </tr>
	      <tr>
	      	<th rowspan="4">다중 플랫폼 (cross platform)</th>
	      	<th><span class="tx_red_s">*</span>다중 플랫폼 지원 여부</th>
	      	<td>
	      		<label><input type="radio" id="sMultiPltfomSportAt" name="sMultiPltfomSportAt" value="Y" <c:if test="${specVo.sMultiPltfomSportAt eq 'Y' }">checked="checked"</c:if> /> YES</label>
	      		<label><input type="radio" id="sMultiPltfomSportAt" name="sMultiPltfomSportAt" value="N" <c:if test="${specVo.sMultiPltfomSportAt eq 'N' || specVo.sMultiPltfomSportAt eq null }">checked="checked"</c:if> /> NO</label>
	      	</td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원 운영체계 목록</th>
	      	<td><input type="text" id="sSportOpersysmList" name="sSportOpersysmList" value="${specVo.sSportOpersysmList}" style="width:85%; margin-left: 5px;" title="지원 운영체계 목록" /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원 웹브라우저 목록</th>
	      	<td><input type="text" id="sSportWbsrList" name="sSportWbsrList" value="${specVo.sSportWbsrList}" style="width:85%; margin-left: 5px;" title="지원 웹브라우저 목록"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원 모바일 플랫폼 목록</th>
	      	<td><input type="text" id="sSportMobilePltfomList" name="sSportMobilePltfomList" value="${specVo.sSportMobilePltfomList}" style="width:85%; margin-left: 5px;" title="지원 모바일 플랫폼 목록"  /></td>
	      </tr>
	      <tr>
	      	<th rowspan="4">호환성 정보</th>
	      	<th><span class="tx_red_s">*</span>개방형 표준 지원 여부</th>
	      	<td>
	      		<label><input type="radio" id="sOpenStdSportAt" name="sOpenStdSportAt" value="Y" <c:if test="${specVo.sOpenStdSportAt eq 'Y' }">checked="checked"</c:if> /> YES</label>
	      		<label><input type="radio" id="sOpenStdSportAt" name="sOpenStdSportAt" value="N" <c:if test="${specVo.sOpenStdSportAt eq 'N' || specVo.sOpenStdSportAt eq null }">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      <th><span class="tx_red_s">*</span>정부 프레임워크 지원 여부</th>
	      	<td>
	        	<label><input type="radio" id="sGvrnFrmwrkSportAt" name="sGvrnFrmwrkSportAt" value="Y" <c:if test="${specVo.sGvrnFrmwrkSportAt eq 'Y' }">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sGvrnFrmwrkSportAt" name="sGvrnFrmwrkSportAt" value="N" <c:if test="${specVo.sGvrnFrmwrkSportAt eq 'N' || specVo.sGvrnFrmwrkSportAt eq null}">checked="checked"</c:if> /> NO</label>
	      	</td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>오픈소스 SW 호환 여부</th>
          <td>
          	<label><input type="radio" id="sOpenSourcSwAt" name="sOpenSourcSwAt" value="Y" <c:if test="${specVo.sOpenSourcSwAt eq 'Y' }">checked="checked"</c:if> /> YES</label>
            <label><input type="radio" id="sOpenSourcSwAt" name="sOpenSourcSwAt" value="N" <c:if test="${specVo.sOpenSourcSwAt eq 'N' || specVo.sOpenSourcSwAt eq null}">checked="checked"</c:if> /> NO</label>
          </td>
      	</tr>
      	<tr>
      		<th><span class="tx_red_s">*</span>PaaS-Ta 호환 여부</th>
          <td>
          	<label><input type="radio" id="sPaastaAtYes" name="sPaastaAt" value="Y" <c:if test="${specVo.sPaastaAt eq 'Y' }">checked="checked"</c:if>  /> YES</label>
            <label><input type="radio" id="sPaastaAtNo"  name="sPaastaAt" value="N" <c:if test="${specVo.sPaastaAt eq 'N' || specVo.sPaastaAt eq null }">checked="checked"</c:if>  /> NO</label>
          </td>
      	</tr>
      	<tr>
      		<th rowspan="7">개발지원 정보</th>
	      	<th><span class="tx_red_s">*</span>소스 공개 여부</th>
	        <td>
	        	<label><input type="radio" id="sSourcOthbcAt" name="sSourcOthbcAt" value="Y" <c:if test="${specVo.sSourcOthbcAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sSourcOthbcAt" name="sSourcOthbcAt" value="N" <c:if test="${specVo.sSourcOthbcAt eq 'N' || specVo.sSourcOthbcAt eq null }">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>외부 API ACCESS 지원 여부</th>
	        <td>
	        	<label><input type="radio" id="sApiAccessSportAt" name="sApiAccessSportAt" value="Y" <c:if test="${specVo.sApiAccessSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sApiAccessSportAt" name="sApiAccessSportAt" value="N" <c:if test="${specVo.sApiAccessSportAt eq 'N' || specVo.sApiAccessSportAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>DB 마이그레이션 지원 여부</th>
	      	<td>
	        	<label><input type="radio" id="sDbMigrationSportAt" name="sDbMigrationSportAt" value="Y" <c:if test="${specVo.sDbMigrationSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sDbMigrationSportAt" name="sDbMigrationSportAt" value="N" <c:if test="${specVo.sDbMigrationSportAt eq 'N' || specVo.sDbMigrationSportAt eq null }">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>외부 응용프로그램 통합 지원 여부</th>
	      	<td>
	          <label><input type="radio" id="sExtrlApplicationSportAt" name="sExtrlApplicationSportAt" value="Y" <c:if test="${specVo.sExtrlApplicationSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sExtrlApplicationSportAt" name="sExtrlApplicationSportAt" value="N" <c:if test="${specVo.sExtrlApplicationSportAt eq 'N' || specVo.sExtrlApplicationSportAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>Sub-tenancy 지원 여부</th>
	      	<td>
	        	<label><input type="radio" id="sSubTenancySportAt" name="sSubTenancySportAt" value="Y" <c:if test="${specVo.sSubTenancySportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sSubTenancySportAt" name="sSubTenancySportAt" value="N" <c:if test="${specVo.sSubTenancySportAt eq 'N' || specVo.sSubTenancySportAt eq null }">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>커스터마이징 가능 여부</th>
	      	<td>
	        	<label><input type="radio" id="sCstmzngPosblAt" name="sCstmzngPosblAt" value="Y" <c:if test="${specVo.sCstmzngPosblAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="sCstmzngPosblAt" name="sCstmzngPosblAt" value="N" <c:if test="${specVo.sCstmzngPosblAt eq 'N' || specVo.sCstmzngPosblAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>개발지원 조건 및 기타 사항</th>
	      	<td>
	      		<input type="text" id="sDevlopSportEtc" name="sDevlopSportEtc" value="${specVo.sDevlopSportEtc}" style="width: 85%" title="개발지원 조건 및 기타 사항" />
	      	</td>
	      </tr>
      </tbody>
    </table>
</form>
</c:if>
<c:if test="${dataVo.goodsKndCd eq '1001' }">
<form name="dataForm9" id="dataForm9" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm9" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
<!-- 플랫폼형 서비스(Paas) 관련 규격 정보-->
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
      	<col width="160" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="3">
      			<h4>플랫폼형 서비스(Paas) 관련 규격 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm9');" /></h4>
      		</td>
      	</tr>
      	<tr>
      		<th rowspan="2">서비스 제공 방식</th>
         	<th><span class="tx_red_s">*</span>Secure 개발</th>
         	<td><input type="text" id="pSecureDevlop" name="pSecureDevlop" value="${specVo.pSecureDevlop}" style="width:85%" title="Secure 개발" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>Secure design, coding, testing 및 배포</th>
        	<td><input type="text" id="pSecureDctWdtb" name="pSecureDctWdtb" value="${specVo.pSecureDctWdtb}" style="width:85%" title="Secure design, coding, testing 및 배포"  /></td>
        </tr>
   			<tr>
   				<th rowspan="5">아키텍처 계획 수립</th>
   				<th><span class="tx_red_s">*</span>지원 언어</th>
   				<td><input type="text" id="pSportLang" name="pSportLang" value="${specVo.pSportLang}" style="width:85%" title="지원 언어" /></td>
   			</tr>
   			<tr>
   				<th><span class="tx_red_s">*</span>지원 플랫폼</th>
   				<td><input type="text" id="pSportPltfom" name="pSportPltfom" value="${specVo.pSportPltfom}" style="width:85%" title="지원 플랫폼"  /></td>
   			</tr>
   			<tr>
   				<th><span class="tx_red_s">*</span>지원 Container 및 버전</th>
   				<td><input type="text" id="pSportContainerVer" name="pSportContainerVer" value="${specVo.pSportContainerVer}" style="width:85%" title="지원 Container 및 버전"  /></td>
   			</tr>
   			<tr>
   				<th><span class="tx_red_s">*</span>지원 데이터 저장소</th>
   				<td><input type="text" id="pSportDataStorge" name="pSportDataStorge" value="${specVo.pSportDataStorge}" style="width:85%" title="지원 데이터 저장소"  /></td>
   			</tr>
   			<tr>
   				<th><span class="tx_red_s">*</span>Sub-tenancy 지원 여부</th>
   				<td>
   					<label><input type="radio" id="pSubTenancySportAt" name="pSubTenancySportAt" value="Y" <c:if test="${specVo.pSubTenancySportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
   					<label><input type="radio" id="pSubTenancySportAt" name="pSubTenancySportAt" value="N" <c:if test="${specVo.pSubTenancySportAt eq 'N' || specVo.pSubTenancySportAt eq null}">checked="checked"</c:if> /> NO</label>
         	</td>
	      </tr>
	      <tr>
	      	<th rowspan="4">다중 플랫폼<br />(cross platform)</th>
	        <th><span class="tx_red_s">*</span>개발자 도구 정보</th>
	        <td><input type="text" id="pDvlprUntInfo" name="pDvlprUntInfo" value="${specVo.pDvlprUntInfo}" style="width:85%" title="개발자 도구 정보" /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>SDK/API 제공 여부</th>
	      	<td>
	        	<label><input type="radio" id="pSdkApiSuplyAt" name="pSdkApiSuplyAt" value="Y" <c:if test="${specVo.pSdkApiSuplyAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	        	<label><input type="radio" id="pSdkApiSuplyAt" name="pSdkApiSuplyAt" value="N" <c:if test="${specVo.pSdkApiSuplyAt eq 'N' || specVo.pSdkApiSuplyAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>테스트 및 디버깅 지원 여부</th>
	      	<td>
	        	<label><input type="radio" id="pTestDebugingSportAt" name="pTestDebugingSportAt" value="Y" <c:if test="${specVo.pTestDebugingSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="pTestDebugingSportAt" name="pTestDebugingSportAt" value="N" <c:if test="${specVo.pTestDebugingSportAt eq 'N' || specVo.pTestDebugingSportAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>Add-on 서비스 및 마켓플레이스 지원 여부</th>
	        <td>
	        	<label><input type="radio" id="pAddonSvcMarkplaceSportAt" name="pAddonSvcMarkplaceSportAt" value="Y" <c:if test="${specVo.pAddonSvcMarkplaceSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
	          <label><input type="radio" id="pAddonSvcMarkplaceSportAt" name="pAddonSvcMarkplaceSportAt" value="N" <c:if test="${specVo.pAddonSvcMarkplaceSportAt eq 'N' || specVo.pAddonSvcMarkplaceSportAt eq null}">checked="checked"</c:if> /> NO</label>
	        </td>
	      </tr>
	      <tr>
	      	<th rowspan="3">배포 및 운영환경</th>
	        <th><span class="tx_red_s">*</span>CI(Continuous Integration) 지원</th>
	        <td><input type="text" id="pCisportSport" name="pCisportSport" value="${specVo.pCisportSport}" style="width:85%" title="CI(Continuous Integration) 지원"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>로깅/모니터링 지원</th>
	      	<td><input type="text" id="pLogingMntrngSport" name="pLogingMntrngSport" value="${specVo.pLogingMntrngSport}" style="width:85%" title="로깅/모니터링 지원"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>Load Balancing 지원</th>
	      	<td><input type="text" id="pLoadBalancingSport" name="pLoadBalancingSport" value="${specVo.pLoadBalancingSport}" style="width:85%" title="Load Balancing 지원"  /></td>
	      </tr>
      </tbody>
    </table>
</form>
</c:if>
<c:if test="${dataVo.goodsKndCd eq '1003' }">
<form name="dataForm10" id="dataForm10" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm10" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
<!-- 인프라형 서비스(IaaS) 관련 규격 정보 -->
		<table class="boardWrite mar_t20">
			<tbody>
     	<colgroup>
      	<col width="150" />
      	<col width="160" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="3">
      			<h4>인프라형 서비스(IaaS) 관련 규격 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm10');" /></h4>
      		</td>
      	</tr>			
				<tr>
					<th>공개표준지원</th>
					<th><span class="tx_red_s">*</span>공개표준 지원 및 문서</th>
					<td><input type="text" id="iOthbcStdSportDoc" name="iOthbcStdSportDoc" value="${specVo.iOthbcStdSportDoc}" style="width:85%;" title="공개표준 지원 및 문서" /></td>
				</tr>
				<tr>
					<th rowspan="2" class="rb">네트워그와 연결</th>
					<th><span class="tx_red_s">*</span>서비스에 직접 연결하는 네트워크</th>
					<td><input type="text" id="iSvcDirectCnncNtwrk" name="iSvcDirectCnncNtwrk" value="${specVo.iSvcDirectCnncNtwrk}" style="width:85%;" title="서비스에 직접 연결하는 네트워크" /></td>
				</tr>
				<tr>
					<th><span class="tx_red_s">*</span>가상 네트워크 지원</th>
					<td><input type="text" id="iVirtlNtwrkSport" name="iVirtlNtwrkSport" value="${specVo.iVirtlNtwrkSport}" style="width:85%;" title="가상 네트워크 지원" /></td>
				</tr>
				<tr>
					<th rowspan="2" class="rb">접근지원</th>
					<th><span class="tx_red_s">*</span>동기화 지원 여부 </th>
          <td>
          	<label><input type="radio" id="iSynchrnSportAt" name="iSynchrnSportAt" value="Y" <c:if test="${specVo.iSynchrnSportAt eq 'Y'}">checked="checked"</c:if> /> YES</label>
            <label><input type="radio" id="iSynchrnSportAt" name="iSynchrnSportAt" value="N" <c:if test="${specVo.iSynchrnSportAt eq 'N' || specVo.iSynchrnSportAt eq null}">checked="checked"</c:if> /> NO</label>
          </td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>지원 장비 목록</th>
	      	<td><input type="text" id="iSportEqpmnList" name="iSportEqpmnList" value="${specVo.iSportEqpmnList}" style="width:85%;" title="지원 장비 목록"  /></td>
	      </tr>
	      <tr>
	      	<th rowspan="6" class="rb">제공 서비스</th>
	      	<th><span class="tx_red_s">*</span>서버/컴퓨터 서비스</th>
	      	<td><input type="text" id="iServerComputerSvc" name="iServerComputerSvc" value="${specVo.iServerComputerSvc}" style="width:85%;" title="서버/컴퓨터 서비스"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>스토리지 서비스</th>
	      	<td><input type="text" id="iStrgeSvc" name="iStrgeSvc" value="${specVo.iStrgeSvc}" style="width:85%;" title="스토리지 서비스"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>네트워크 서비스</th>
	      	<td><input type="text" id="iNtwrkSvc" name="iNtwrkSvc" value="${specVo.iNtwrkSvc}" style="width:85%;" title="네트워크 서비스"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>보안 서비스</th>
	      	<td><input type="text" id="iScrtySvc" name="iScrtySvc" value="${specVo.iScrtySvc}" style="width:85%;" title="보안 서비스"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>관리 서비스</th>
	      	<td><input type="text" id="iManageSvc" name="iManageSvc" value="${specVo.iManageSvc}" style="width:85%;" title="관리 서비스"  /></td>
	      </tr>
	      <tr>
	      	<th><span class="tx_red_s">*</span>기타 서비스</th>
	      	<td><input type="text" id="iEtcSvc" name="iEtcSvc" value="${specVo.iEtcSvc}" style="width:85%;" title="기타 서비스" /></td>
	      </tr>
			</tbody>
		</table>
</form>
</c:if>
<c:if test="${dataVo.goodsKndCd eq '1004' }">
<form name="dataForm11" id="dataForm11" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm11" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
<!-- 컨설팅 서비스 (SCS) 관련 규격 정보 -->
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
      	<col width="160" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="3">
      			<h4>컨설팅 서비스 (SCS) 관련 규격 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm11');" /></h4>
      		</td>
      	</tr>			
        <tr>
        	<th colspan="2"><span class="tx_red_s">*</span>전문가 구성</th>
        	<td><input type="text" id="cSpcltyRealm" name="cSpcltyRealm" value="${specVo.cSpcltyRealm}" style="width:85%;" title="전문가 구성" /></td>
        </tr>
        <tr>
        	<th rowspan="2" class="rb">컨설팅 주요내용</th>
        	<th><span class="tx_red_s">*</span>도입전반</th>
        	<td><input type="text" id="cIndcWhole" name="cIndcWhole" value="${specVo.cIndcWhole}" style="width:85%;" title="도입전반" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>Setup &amp; Migration</th>
        	<td><input type="text" id="cSetupMgr" name="cSetupMgr" value="${specVo.cSetupMgr}" style="width:85%;" title="Setup & Migration" /></td>
        </tr>
        <tr>
        	<th rowspan="5" class="rb">핵심기술 및 경험</th>
        	<th><span class="tx_red_s">*</span>보유자격</th>
        	<td><input type="text" id="cHoldQualf" name="cHoldQualf" value="${specVo.cHoldQualf}" style="width:85%;" title="보유자격" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>보유기술</th>
        	<td><input type="text" id="cHoldTchnlgy" name="cHoldTchnlgy" value="${specVo.cHoldTchnlgy}" style="width:85%;" title="보유기술" /></td>
        </tr>
        <tr><th><span class="tx_red_s">*</span>컨설팅 가능 인프라</th>
        	<td>
        		<op:code id="cInfrstrctr" grpCd="2080" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 가능 인프라" defaultValues="${specVo.cInfrstrctr}" onclick="fnReadAble(this.value, this.name)" title="컨설팅 가능 인프라"/>
        		<input type="text" id="cInfrstrctrEtc" name="cInfrstrctrEtc" value="${specVo.cInfrstrctrEtc}" readonly="readonly" style="width:17%;" />
        	</td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>컨설팅 가능 플랫폼</th>
        	<td>
        		<op:code id="cPltfom" grpCd="2081" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 가능 플랫폼" defaultValues="${specVo.cPltfom}" onclick="fnReadAble(this.value, this.name)" title="컨설팅 가능 플랫폼"/>
        		<input type="text" id="cPltfomEtc" name="cPltfomEtc" value="${specVo.cPltfomEtc}" readonly="readonly" style="width:47%;" />
        	</td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>프로젝트 경험</th>
        	<td><input type="text" id="cPrjctExprnc" name="cPrjctExprnc" value="${specVo.cPrjctExprnc}" style="width:85%;" title="프로젝트 경험" /></td>
        </tr>
        <tr>
        	<th colspan="2"><span class="tx_red_s">*</span>컨설팅 영역</th>
        	<td>
        		<op:code id="cCnslRelm" grpCd="2082" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 영역" defaultValues="${specVo.cCnslRelm}" onclick="fnReadAble(this.value, this.name)" title="컨설팅 영역"/>
        		<input type="text" id="cCnslRelmEtc" name="cCnslRelmEtc" value="${specVo.cCnslRelmEtc}" readonly="readonly" style="width:32%;" />
        	</td>
        </tr>
        <tr>
        	<th colspan="2"><span class="tx_red_s">*</span>컨설팅 범위</th>
        	<td>
        		<op:code id="cCnslScope" grpCd="2083" ctgCd="GDCTCD" option="style='margin-right: 10px;'" type="checkbox" defaultLabel="컨설팅 범위" defaultValues="${specVo.cCnslScope}" title="컨설팅 범위"/>
        	</td>
        </tr>
        <tr>
        	<th colspan="2"><span class="tx_red_s">*</span>컨설팅 가능 상세 서비스</th>
        	<td>
        	    <!-- 클라우드 서비스 하위 메뉴 /*_userguide.getCtgryList*/ 에서 다중선택할 수있도록 한다. -->
        		<a onclick="jsCtgryListPop(this);" href="javascript:;" class="btns st3">선택</a>
        		<input type="hidden" id="cDetailSvc" name="cDetailSvc"  value="${specVo.cDetailSvc}"/>
        		<span id="cDetailSvcNm">
        			<c:forEach var="tstCateMgmt" items="${tstCateMgmt}" varStatus="status">
        				${tstCateMgmt.indvdlzNm}<c:if test="${status.index lt fn:length(tstCateMgmt)}">,</c:if>
        			</c:forEach>
        		</span>
        	</td>
        </tr>
        <tr>
        	<th  class="requ" colspan="2">컨설팅 수행기간</th>
        	<td>
        		<op:code type="checkbox" id="cExcPd" grpCd="2084" ctgCd="GDCTCD" option="style='margin-right: 10px;'" defaultLabel="컨설팅 수행기간" defaultValues="${specVo.cExcPd}" onclick="fnReadAble(this.value, this.name)" title="컨설팅 수행기간"/>
        		<input type="text"   id="cExcPdEtc" name="cExcPdEtc" value="${specVo.cExcPdEtc}" readonly="readonly">
        	</td>
        </tr>
        <tr><th  class="requ" colspan="2">컨설팅 수행 가능 지역</th>
        	<td>
        		<op:code type="checkbox" id="cExcArea" grpCd="2022" ctgCd="GDCTCD" option="style='margin-right: 10px;'" defaultLabel="컨설팅 수행 가능 지역" defaultValues="${specVo.cExcArea}" title="컨설팅 수행 가능 지역" onclick="fnCexcArea(this.value);"/>
        	</td>
        </tr>
        <tr><th  class="requ" colspan="2">사전 컨설팅 가능 여부</th>
        	<td>
        		<label><input type="radio" id="cBeffatCnslAt" name="cBeffatCnslAt" value="Y" <c:if test="${specVo.cBeffatCnslAt eq 'Y'}">checked="checked"</c:if>>YES</label>
            <label><input type="radio" id="cBeffatCnslAt" name="cBeffatCnslAt" value="N" <c:if test="${specVo.cBeffatCnslAt eq 'N' || specVo.cBeffatCnslAt eq null}">checked="checked"</c:if>>NO</label>
        	</td>
        </tr>
        <!-- <tr><th colspan="2">컨설팅 금액</th><td><input type="hidden" id="cCnslPc" name="cCnslPc" value="0" style="width: 100px; ime-mode:disabled; text-align:right;" onchange="getNumber(this);" onkeyup="getNumber(this);"></td></tr> -->
    	</tbody>
    </table>
</form>
</c:if>

<!-- 제공자 정보-->
<form name="dataForm12" id="dataForm12" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm12" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>제공자 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm12');" /></h4>
      		</td>
      	</tr>
      	<tr>
        	<th><span class="tx_red_s">*</span>회사 명칭</th>
          <td>
          	${dataVo.goodsStore[0].LANGSTORENM}
          	<%-- ${dataVo.cmpnyNm} --%>
          	<input type="hidden" id="cmpnyNm" name="cmpnyNm" value="${dataVo.goodsStore[0].LANGSTORENM}" />
          </td>
        </tr>
      	<tr>
        	<th><span class="tx_red_s">*</span>회사 설립년도</th>
          <td><input type="text" id="cmpnyFondYear" name="cmpnyFondYear" style="width: 100px; ime-mode:disabled" onchange="getNumber(this, 1);" onkeyup="getNumber(this, 1);" maxlength="4" value="<c:out value='${specVo.cmpnyFondYear}'/>" title="회사 설립년도" /> 년</td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>회사 소개</th>
          <td>
          	<textarea rows="15" class="w_85p" id="cmpnyIntrcn" name="cmpnyIntrcn" title="회사 소개" ><c:out value='${specVo.cmpnyIntrcn}'/></textarea>
          	<%-- <input type="text" id="cmpnyIntrcn" name="cmpnyIntrcn" value="<c:out value='${specVo.cmpnyIntrcn}'/>"  style="width:35%;" title="회사 소개" /> --%>
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>사업 분야</th>
          <td><input type="text" id="bsnsRealm" name="bsnsRealm" value="<c:out value='${specVo.bsnsRealm }'/>" style="width:35%;" title="사업 분야" /></td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>공급 유형</th>
        	<td>
        		<label><input type="radio" id="svcEntrprsSuplyTy" name="svcEntrprsSuplyTy" value="1001" <c:if test="${specVo.svcEntrprsSuplyTy eq 1001}"> checked="checked" </c:if> title="공급 유형" /> Reseller</label>    
        		<label><input type="radio" id="svcEntrprsSuplyTy" name="svcEntrprsSuplyTy" value="1002" <c:if test="${specVo.svcEntrprsSuplyTy eq 1002}"> checked="checked" </c:if> title="공급 유형" /> Vendor</label>
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>기업구분</th>
          <td>
          	<label><input type="radio" id="entrprsSe" name="entrprsSe" value="1001" <c:if test="${specVo.entrprsSe eq 1001}"> checked="checked" </c:if> title="기업구분"/> 대기업</label>    
          	<label><input type="radio" id="entrprsSe" name="entrprsSe" value="1002" <c:if test="${specVo.entrprsSe eq 1002}"> checked="checked" </c:if> title="기업구분"/> 중견기업</label>
          	<label><input type="radio" id="entrprsSe" name="entrprsSe" value="1003" <c:if test="${specVo.entrprsSe eq 1003}"> checked="checked" </c:if> title="기업구분"/> 중소기업</label>
          </td>
        </tr>
      </tbody>
    </table>
</form>

<!-- 서비스 담당자 정보-->
<form name="dataForm13" id="dataForm13" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm13" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>서비스 담당자 정보&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm13');" /></h4>
      		</td>
      	</tr>
        <tr>
        	<th><span class="tx_red_s">*</span>담당자</th>
          <td>
          	<input type="text" id="svcChargerNm" name="svcChargerNm" value="${specVo.svcChargerNm}" style="width:35%;" title="담당자" />
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>담당자 이메일</th>
          <td>
            <input type="text" id="svcChargerEmail1" name="svcChargerEmail1" value="${fn:split(specVo.svcChargerEmail,'@')[0]}" style="width:10%;" title="메일 아이디" />
            <span class="space">@</span>
            <input type="text" id="svcChargerEmail2" name="svcChargerEmail2" value="${fn:split(specVo.svcChargerEmail,'@')[1]}" style="width:22%;" title="도메인" />
          </td>
        </tr>
        <tr>
        	<th><span class="tx_red_s">*</span>담당자 연락처</th>
          <td class="tel">
<%--
          	<span class="sel_box">
            <select id="svcChargerCttpc" name="svcChargerCttpc" title="국가 선택" style="width:11%;" >
            	<option value="">국가 선택</option>
              <c:forEach items="${nation}" var="list">
              	<option value="<c:out value='${list.INTRLTELNL}'/>" <c:if test="${specVo.svcChargerCttpc eq list.INTRLTELNL}">selected="selected"</c:if>>
              		<c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)
              	</option>
              </c:forEach>
            </select>
             </span>
--%>
            <input type="hidden" id="svcChargerCttpc" name="svcChargerCttpc" title="국가 선택" value="82">
            <input type="text" id="svcChargerTelno1" name="svcChargerTelno1" title="연락처" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(specVo.svcChargerTelno,'-')[0]}" maxlength="4" style="width:10%;" />
             -
            <input type="text" id="svcChargerTelno2" name="svcChargerTelno2" title="연락처" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(specVo.svcChargerTelno,'-')[1]}" maxlength="4" style="width:10%;" />
             -
            <input type="text" id="svcChargerTelno3" name="svcChargerTelno3" title="연락처" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${fn:split(specVo.svcChargerTelno,'-')[2]}" maxlength="4" style="width:10%;" />
          </td>
        </tr>
        <tr>
          <th><span class="tx_red_s">*</span>담당자 휴대폰</th>
          <td class="tel">
              <input type="text" id="svcChargerMbtlNum1" name="svcChargerMbtlNum1" title="휴대전화번호" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" maxlength="3" value="${fn:split(specVo.svcChargerMbtlNum,'-')[0]}" style="width:10%;" />
               -
              <input type="text" id="svcChargerMbtlNum2" name="svcChargerMbtlNum2" title="휴대전화번호" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" maxlength="4" value="${fn:split(specVo.svcChargerMbtlNum,'-')[1]}" style="width:10%;" />
               -
              <input type="text" id="svcChargerMbtlNum3" name="svcChargerMbtlNum3" title="휴대전화번호" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" maxlength="4" value="${fn:split(specVo.svcChargerMbtlNum,'-')[2]}" style="width:10%;" />
          </td>
        </tr>
      </tbody>
    </table>
</form>

<!-- 가격표 및 첨부파일-->
<form name="dataForm14" id="dataForm14" enctype="multipart/form-data" method="post">
    <input type="hidden" id="goodsCode"					name="goodsCode"				value="${dataVo.goodsCode}" />
    <input type="hidden" id="userId"						name="userId"						value="${dataVo.userId}"></input>
    <input type="hidden" id="goodsStatus"				name="goodsStatus"			value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="goodsRegistSttus"	name="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
    <input type="hidden" id="svcFlag" 					name="svcFlag"					value="" />
    <input type="hidden" id="goodsNum" name="goodsNum" value="${goodsNum}" />
    <input type="hidden" id="formNm" 						name="formNm"						value="dataForm14" />
    <input type="hidden" id="langCode" 					name="langCode" 				value="${dataVo.langCode}" />
		<table class="boardWrite mar_t20">
     	<colgroup>
      	<col width="150" />
        <col width="*" />
      </colgroup>
      <tbody>
      	<tr>
      		<td colspan="2">
      			<h4>가격표 및 첨부파일&nbsp;&nbsp;<input type="submit" value="임시저장" class="w_blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AB', 'dataForm14');" /></h4>
      		</td>
      	</tr>
				<tr>
					<th><span class="tx_red_s">*</span>가격표(업로드)</th>
	        <td>
	        	<input type="hidden" name="priceDnFileSeq" value="${dataVo.priceDnFileSeq}"/>
	          <c:if test="${empty dataVo.priceFile[0]}">
					  	<input type="file" name="priceFile1" id="priceFile1" class="mnlFile w_92p" onchange="jsFileChk('priceFile1', 10240, '1', -1, 5);" title="가격표" />
					    <input type="hidden" name="fileDesc" id="priceFile1Desc" value=""/>
					    <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('priceFile1');"/>
	          </c:if>
						<c:if test="${not empty dataVo.priceFile[0]}">
						<c:set var="priceFileVO" value="${dataVo.priceFile[0]}" />
						<c:set var="image" value="" />
	          	<div class="mar_b5">
	            	<a href="javascript:;" onclick="jsFileDelete(this, ${priceFileVO.fileSeq}, '${priceFileVO.fileId}', '', '${dataVo.goodsCode}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
	              <a href="/component/file/ND_fileDownload.do?id=${priceFileVO.fileId }" title="${priceFileVO.localNm}">${priceFileVO.localNm} <span class="tx_gray">(download ${priceFileVO.downCnt}, ${priceFileVO.fileSize}, ${priceFileVO.fileType})</span></a>
	            </div>
	            <input type="hidden" name="priceFile1" id="priceFile1" value="${priceFileVO.fileUrl}"/>
	            <input type="hidden" name="fileDesc" id="priceFile1Desc" value="${priceFileVO.localNm}"/>
				   </c:if>
					</td>
				</tr>
				<tr>
					<th>사용메뉴얼</th>
					<td>
						<input type="hidden" name="mnlDnFileSeq" value="${dataVo.mnlDnFileSeq}"/>
						<c:if test="${empty dataVo.dnlFile[0]}">
				    	<input type="file" name="dnlFile1" id="dnlFile1" class="mnlFile w_92p" onchange="jsFileChk('dnlFile1', 10240, '1', -1, 5);"></input>
				      <input type="hidden" name="fileDesc" id="dnlFile1Desc" value=""/>
				      <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('dnlFile1');"/>
            </c:if>
						
						<c:if test="${not empty dataVo.dnlFile[0]}">
					    <c:set var="dnlFileVO" value="${dataVo.dnlFile[0]}" />
					    <c:set var="image" value="" />
              <div class="mar_b5">
              	<a href="javascript:;" onclick="jsFileDelete(this, ${dnlFileVO.fileSeq}, '${dnlFileVO.fileId}', '', '${dataVo.goodsCode}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                <a href="/component/file/ND_fileDownload.do?id=${dnlFileVO.fileId }" title="${dnlFileVO.localNm}">${dnlFileVO.localNm} <span class="tx_gray">(download ${dnlFileVO.downCnt}, ${dnlFileVO.fileSize}, ${dnlFileVO.fileType})</span></a>
              </div>
              <input type="hidden" name="dnlFile1" id="dnlFile1" value="${dnlFileVO.fileUrl}"/>
              <input type="hidden" name="fileDesc" id="dnlFile1Desc" value="${dnlFileVO.localNm}"/>
			      </c:if>
					</td>
				</tr>
				
				<tr>
					<th>기타첨부파일</th>
					<td>
						<input type="hidden" id="mnlFilesFileDesc" name="mnlFilesFileDesc" value="" />
						<table style="width:100%">
							<c:forEach var="i" begin="1" end="5" step="1" varStatus="rtstatus">
		          <input type="hidden" name="etcFileSeq" value="${dataVo.etcFileSeq}"/>
					    <!-- 기타 첨부파일이 없을 경우 등록용 필드 노출 -->
					    
					    <c:if test="${empty dataVo.etcFile[i-1]}">
					    <tr>
		            <td>
		            	<input type="file" name="etcFile${i}" id="etcFile${i}" class="mnlFile w_92p" onchange="jsFileChk('etcFile${i}', 'etcfileInput${i}', 10240, '1', -1, 5);"></input>
						      <input type="hidden" name="fileDesc" id="etcFile${i}Desc" value=""/>
						      <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('etcFile${i}');"/>
						    </td>
					    </tr>
					    </c:if>
					    
					    <!-- 기타 첨부파일이 있을 경우 다운로드/삭제 링크 노출 -->
					    <c:if test="${not empty dataVo.etcFile[i-1]}">
					    <tr>
					    	<td>
							    <c:set var="etcFileVO" value="${dataVo.etcFile[i-1]}" />
							    <c:set var="image" value="" />
		              <div class="mar_b5">
		              	<a href="javascript:;" onclick="jsFileDelete(this, ${etcFileVO.fileSeq}, '${etcFileVO.fileId}', '', '${dataVo.goodsCode}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
		                <a href="/component/file/ND_fileDownload.do?id=${etcFileVO.fileId }" title="${etcFileVO.localNm}">${etcFileVO.localNm} <span class="tx_gray">(download ${etcFileVO.downCnt}, ${etcFileVO.fileSize}, ${etcFileVO.fileType})</span></a>
		              </div>
		              <input type="hidden" name="etcFile${i}" id="etcFile${i}" value="${etcFileVO.fileUrl}" />
		              <input type="hidden" name="fileDesc" id="etcFile${i}Desc" value="${etcFileVO.localNm}"/>
						    </td>
					    </tr>
					    </c:if>
							</c:forEach>
						</table>
					</td>
			<!-- //기타첨부파일 -->
      </tbody>
    </table>
</form>
    <!-- 버튼 -->
   
    <div class="mar_t20 mar_b50">
        <c:if test="${dataVo.goodsRegistSttus < 1008}">
        <div class="float_r">
            <input type="button" value="목록" class="blue" onclick="jsList('BD_index.do');" />
            <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm(this);' />
           <!-- <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_goodsPreview.do');" /> -->
           <!-- <input type="button" value="검토반려" class="blue" onclick="jsRegistBack(this, 1003);" /> -->
            <input type="button" value="수정완료" class="blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do', 'AA');" />
        </div>
        </c:if>
    </div>
</body>
</html>