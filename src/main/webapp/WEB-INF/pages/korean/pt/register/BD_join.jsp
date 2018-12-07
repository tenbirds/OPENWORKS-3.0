<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE>
<html lang="ko">
<head>
</head>
<body>
	<!-- content -->
	<section class="pageTit">
		<!-- 타이틀 영역 -->
		<div class="conWrap">
			<h2>회원 가입</h2>
		</div>
		<!--// 타이틀 영역 -->
	</section>

	<div class="conWrap join">
		<h3>
			<i class="quot">
				<i>클라우드서비스를 한 곳에서 검색/선정/체험/이용할 수 있는</i><br />
				클라우드스토어 씨앗에 오신 것을 환영합니다.
			</i>
		</h3>
		
		<p class="applySelcet">		
			<a href="BD_userCrtfc.do?userTyCd=1001&nationCode=410"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_gen.png" alt="일반 씨앗회원 회원가입" /></a>
			<a href="BD_userCrtfc.do?userTyCd=3001&nationCode=410"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_public.png" alt="공공 씨앗회원 회원가입" /></a>
			<a href="BD_userCrtfc.do?nationCode=410"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_offer.png" alt="제공(판매) 권한 신청" /></a>
		</p>
	</div>
	<!--// content -->
</body>
</html>