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
	    // 서비스 선택
	    var jsSelectGoods = function(goodsNm,goodsCode){
	        
	        $(parent.document).find('#goodsArea').html(goodsNm);
            $(parent.document).find('#goodsCode').val(goodsCode);	        
	        parent.$.fn.colorbox.close();
	    };
    </script>
</head>

 <body class="winPopup serSel">
	<h2>계약서비스 선택 <a href="#" onclick="jsClose();">닫기</a></h2>
	<div>
		<!-- ul class="notice">
			<li>※ 비즈매칭 구분 선택은 회원님이 궁굼하신 사항이나 요청사항에 빠르게 판매자들이 답변을 할 수 있도록 하기위한 설정입니다.</li>
			<li>※ 솔루션/서비스, IT전문가서비스 카테고리에서 최대 2개까지 등록 가능합니다.</li>
			<li>※ 반드시 1개 이상의 카테고리를 선택해주세요.</li>
		</ul -->
	
		<table class="tbl_st1">
			<thead>
				<tr>
					<th>서비스 명</th>					
					<th>선택</th>					
				</tr>
			</thead>
			<tbody>
			    <c:forEach items="${baseList}" var="baseList" varStatus="status">
				<tr>
					<td>${baseList.goodsNm}</td>					
					<td><a href="#" onclick="jsSelectGoods('${baseList.goodsNm}','${baseList.goodsCode}'); return false;" class="btns st3">선택</a></td>
				</tr>
			    </c:forEach>
                <!-- 데이터가 없을 때 알림 문구 -->
                <c:if test="${empty baseList}">
                    <op:no-data obj="${baseList}" colspan="2" />
                </c:if>
			</tbody>
		</table>
	</div>

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>