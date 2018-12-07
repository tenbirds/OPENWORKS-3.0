<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>아이디찾기 3단계</title>
	<script type="text/javascript">CTX_PATH = "<%= request.getContextPath() %>";</script>
	<script type="text/javascript">
		$().ready(function(){
		    <c:if test="${!empty hpSecs}">
		    	alert(Message.msg.smsCrtfc);
		    </c:if>
		    <c:if test="${!empty ipinSecs}">
		    	alert(Message.msg.ipinCrtfc);
		    </c:if>		    
		    <c:if test="${!empty bizNoSecs}">
		    	alert(Message.msg.biznoCrtfc);
		    </c:if>
		});
	</script>
</head>
<body>
	<div id="container" class="join-wrap">

		<!-- contents -->
		<div class="contents">
			
			<!-- section -->
			<div class="section">
				<!-- tab-type1 -->
				<div class="tab-type1">
					<ul>
					<li class="on"><a href="BD_findId.do">아이디 찾기</a></li>
					<li><a href="BD_findPwd.do">비밀번호 찾기</a></li>
					</ul>

					<div class="step">
						<span class="step02"><em>기본정보 입력</em></span>
						<span class="step03"><em>아이디 일부확인 및 인증정보 입력</em></span>
						<span class="step04 on"><em>전체아이디 확인</em></span>
					</div>
				</div>
				<!-- //tab-type1 -->
			</div>
			<!-- //section -->

			<!-- title-area -->
			<div class="title-area">
				<h2>아이디 일부확인</h2>
			</div>
			<!-- //title-area -->
			<!-- section -->
			<div class="section">
				<div class="type-list ac">
					<p class="txt-comform"><strong class="txt-point mr20"><c:out value="${fUserId}" /></strong>가입날짜 : <c:out value="${regDate}" /></p>
				</div>
			</div>
			<!-- //section -->
			<!-- btn -->
			<div class="btn-area ac">
				<a href="/korean/pt/login/user/BD_index.do" class="b-btn type1"><strong><span>로그인</span></strong></a>
				<a href="BD_findPwd.do" class="b-btn type1"><strong><span>비밀번호 찾기</span></strong></a>					
			</div>
			<!-- //btn -->
			<!-- section -->
			<div class="section">					
				<ul class="bor-t mt20 pt30 caption">
				<li>· 개인정보보호를 위해 아이디 끝자리는 ***로 표시됩니다.</li>
				<li>· 동일한 등록정보를 가진 동명이인의 아이디가 함께 검색될 수 있습니다.</li>
				<li>· 아이디 뒷자리를 확인하시려면, 아래의 간단한 본인인증을 거치셔야 합니다.</li>
				</ul>
			</div>
		</div>
</div>
</body>
</html>