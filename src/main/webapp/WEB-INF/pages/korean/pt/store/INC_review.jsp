<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>연관솔루션</title>
<op:jsTag type="openworks" items="store-core" />
<script type="text/javascript" src="/new_cloud/js/style.js"></script>
<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
<script type="text/javascript">
$( window ).load(function() {
  
  var height = $(".product_view").height() + 50;
  var frame = $("#reviewFrame", parent.document);
  frame.height(height);
  
});    

var jsReviewView = function(domainCd, bbsCd, bbscttSeq, goodsCode){
     
     var url;
     if(bbscttSeq == '' || bbscttSeq == null){
         url = "/web/board/BD_board.list.do"
     }else{
         url = "/web/board/BD_board.view.do";
	     $("#reviewForm input[name=bbscttSeq]").val(bbscttSeq);
     }
	     $("#reviewForm input[name=domainCd]").val(domainCd);
	     $("#reviewForm input[name=bbsCd]").val(bbsCd);
	     $("#reviewForm input[name=q_product]").val(goodsCode);
     
     document.reviewForm.action = url;
     document.reviewForm.method = "GET";
     document.reviewForm.target = "_parent";
     document.reviewForm.submit();
     
 }

</script>
</head>
<body>	
<!-- layer popup -->
<div class="layer-pop">
	<div class="pop-cont blue">
  		<jsp:include page="INC_TABMENU.jsp" flush="true"></jsp:include>
		  			
		<form id="reviewForm" name="reviewForm">
		    <input type="hidden" name="domainCd" id="domainCd" value="${boardBaseVo.domainCd}"  />
		    <input type="hidden" name="bbsCd" id="bbsCd" value="${boardBaseVo.bbsCd}"  />
		    <input type="hidden" name="bbscttSeq" id="bbscttSeq" value=""/>
		    <input type="hidden" name="q_product" id="q_product" value="${boardBaseVo.goodsCode}"  />
		</form>

		<!-- pop-detail -->
		<div class="pop-detail">
			<!-- btn-area -->
			<div class="btn-area">
				<a href="#" class="b-btn ml10 inquiry type2"><strong><span>리뷰 작성하기</span></strong></a>
			</div>
			<!-- //btn-area -->
			
			<!-- section -->
			<div class="section">
				<!-- list -->
				<div class="type-list">
					<table>
						<caption>리스트</caption>
						<colgroup>
						<col style="width:10%;"/>
						<col style="width:*;"/>
						<col style="width:15%;"/>
						<col style="width:15%;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일자</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${reviewList}" var="reviewVo" varStatus="status">
							<tr>
								<td>11</td>
								<td class="title"> <a href="#" onclick="jsReviewView('${reviewVo.domainCd}','${reviewVo.bbsCd}', '${reviewVo.bbscttSeq}','${reviewVo.goodsCode}'); return false;"><c:out value='${reviewVo.bbscttSj}'/></a></td>								
								<td><c:out value='${reviewVo.maskRegistId}'/></td>
								<td><c:out value='${reviewVo.registDt}'/></td>
							</tr>
						  </c:forEach>
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- paging -->
				<div class="paging">
					<a href="#" class="on">1</a><a href="#">2</a><!-- 선택 클래스 on 적용 -->
				</div>
				<!-- //paging -->
			</div>
			<!-- //section -->

		</div>
		<!-- //pop-detail -->
	</div>
</div>
<!-- //layer popup -->


</body>
</html>
