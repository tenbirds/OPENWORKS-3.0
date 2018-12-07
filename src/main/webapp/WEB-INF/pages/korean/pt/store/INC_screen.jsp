<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	<title>씨앗 마켓</title>	
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">	
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
</head>
 <body class="winPopup usrScr">
<jsp:include page="INC_TABMENU.jsp" flush="true"></jsp:include>
		
	<div class="sliderWrap">
			<ul class="slider_3">
					<c:forEach items="${dataList}" var="fileVo" varStatus="status">
					<!-- 2016.05.10 BH.YANG 대표이미지를 제외한 서비스사용화면 이미지 가져오기  -->
					<c:if test="${fileVo.orderNo > 1}">
					<li>
						<img src="${fileVo.fileUrl}" alt=""/>
					</li>
					</c:if>
					<!--}} -->
					</c:forEach>
				</ul>
		</div>

</div>
<!-- //layer popup -->
<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>