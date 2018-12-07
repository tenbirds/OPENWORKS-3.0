<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>씨앗 마켓</title>	
	<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
	<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
	<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="/new_cloud/js/style.js"></script>
	<script type="text/javascript" src="/new_cloud/js/common.js"></script>
	<!--[if lt IE 9]>
		<script src="/resources/web/theme/common/js/html5shiv.js"></script> 
	<![endif]-->
	
 <script type="text/javascript">

  $( window ).load(function() {
	$('#Vodframe').attr('src', 'https://www.youtube.com/embed/'+parent.$("#vodurl").val());
  });

</script>

</head>
<body>
<!-- layer popup -->
<div class="layer-pop">
	<div class="pop-cont blue">
		 <jsp:include page="INC_TABMENU.jsp" flush="true"></jsp:include>
	
		<!-- pop-detail -->
		<div class="pop-detail">

			<!-- section -->
			<div class="section">
				<div class="moving-area">
					<iframe width="860" height="550" src="" frameborder="0" id="Vodframe" allowfullscreen></iframe>
				</div>
			</div>
			<!-- //section -->

		</div>
		<!-- //pop-detail -->
	</div>
</div>
<!-- //layer popup -->

</body>
</html>

