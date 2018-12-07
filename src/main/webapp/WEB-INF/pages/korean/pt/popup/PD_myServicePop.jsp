<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>POPUP - 계약서비스 선택</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
 
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <script type="text/javascript">
	    // 닫기
	    var jsClose = function(){
	        parent.$.fn.colorbox.close();
	    };
	    
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        var userId = $("#userId").val();
	        
	        document.dataForm.action = "/korean/pt/popup/PD_myServicePop.do?userId="+userId;
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    
	    // 서비스 선택
	    var jsSelectGoods = function(goodsNm,goodsCode,suplerId,suplerStoreNm){
	        $(parent.document).find('#goodsArea${idx}').html(goodsNm + " ["+suplerStoreNm+"] ");
            $(parent.document).find('#goodsCode${idx}').val(goodsCode);
            $(parent.document).find('#suplerId').val(suplerId);
            $(parent.document).find('#sleInsttNm').val(suplerStoreNm);
            
	        parent.$.fn.colorbox.close();
	    };
    </script>
</head>



 <body class="winPopup serSel">
	<h2>계약서비스 선택 <a href="#" onclick="jsClose();">닫기</a></h2>
	<div>
		<form name="dataForm" id="dataForm">	        
	        <input type="hidden" name="q_currPage"  id="q_currPage"  value="${currPage}"/>  <!--  현재 페이지 -->
			<input type="hidden" name="userId"          id="userId"          value="${sessionScope['__usk'].userId}"/>         <!--  이용자ID -->
			
			<!--// 검색영역 -->
			<div class="list_st1">
				<p class="head">
					<span>총 ${pager.totalNum}개</span>
				    <span class="sel_box">
						<select name="searchDiv02" id="searchDiv02" onchange="jsListSearch(1);">
						    <option value="">전체</option>
						    <c:forEach items="${codeList_goodKndCd}" var="goodKndCdList" varStatus="status">
						        <option value="${goodKndCdList.prvCd}" <c:if test="${searchDiv02 == goodKndCdList.prvCd}">selected="true"</c:if> >${goodKndCdList.prvNm}</option>
						    </c:forEach>
						</select>
					</span>
				</p>
				<table class="tbl_st1">
					<thead>
						<tr>
						    <th>번호</th>
							<th>서비스 구분</th>
							<th>서비스 명</th>
							<th>공급사</th>
							<th>선택</th>					
						</tr>
					</thead>
					<tbody>
					    <c:set var="index" value="${pager.indexNo}"/>
					    <c:forEach items="${pager.list}" var="baseList" varStatus="status">
						<tr>
						    <td>${index-status.index}</td>
						    <td>${baseList.goodKndNm}</td>
							<td>${baseList.goodsNm}</td>
							<td>${baseList.suplerStoreNm}</td>					
							<td><a href="#" onclick="jsSelectGoods('${baseList.goodsNm}','${baseList.goodsCode}','${baseList.suplerId}','${baseList.suplerStoreNm}'); return false;" class="btns st3">선택</a></td>
						</tr>
					    </c:forEach>
		                <!-- 데이터가 없을 때 알림 문구 -->
		                <c:if test="${empty baseList}">
		                    <op:no-data obj="${baseList}" colspan="2" />
		                </c:if>
					</tbody>
				</table>
			</div>
		</form>
	</div>

    <!-- 페이징 -->
    <div class="paging">
        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
    </div>
    <!-- //페이징 -->

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>