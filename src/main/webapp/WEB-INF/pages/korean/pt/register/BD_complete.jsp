<%@ page import="zes.core.lang.Validate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!-- content -->
<c:if test="${!empty userTyCd2}">
		<section class="pageTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<img src="/cloud_ver2/new_cloud/images/offer_step_4.png" alt="신청완료" />
				<h2>제공(판매) 권한 신청</h2>
			</div>
			<!--// 타이틀 영역 -->
		</section>
		
		<div class="conWrap complete">
			<h3>
				<i class="quot">클라우드 제공 권한 신청이 완료되었습니다.</i>
			</h3>
			
			<div>	
				<div class="end_info">
						
					<ol>
						<li>제공(판매) 권한 신청 후 영업일 기준 평일7일 이내 승인되며,</li>
						<li>제공권한 승인완료 후 제공자 정보관리가 가능합니다.</li>
					</ol>
								
				</div>
				<div class="btnArea rig">
					<a href="/" class="btns st1 icn icnHome">홈으로</a>
				</div>
			</div>
		</div>
</c:if>
<c:if test="${empty userTyCd2}">
	<c:choose>
	<c:when test="${userTyCd eq '1001'}">
		<section class="pageTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<img src="/cloud_ver2/new_cloud/images/join_step_4.png" alt="가입완료" />
				<h2>일반 회원가입</h2>
			</div>
			<!--// 타이틀 영역 -->
		</section>
		
		<div class="conWrap complete">
			<h3>
				<i class="quot">일반회원으로 가입이 완료되었습니다.</i>
			</h3>
			<p>
				${userNm}님, 클라우드스토어 씨앗에 가입해주셔서 감사합니다.<br />
				${userNm}님의 아이디는 [<em>${userId}</em>]입니다.<br />
				본 아이디로 모든 서비스를 자유롭게 이용하실 수 있습니다.<br /><br />
				
				더욱 다양한 서비스를 통해 회원만족을 실현하는 클라우드스토어 씨앗가 되겠습니다.
			</p>
			
			<div>		
				<a href="/korean/pt/register/BD_userCrtfc.do?nationCode=${nationCode}"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_offer_complete.png" alt="제공(판매) 권한 신청"></a>			
				<div class="btnArea rig">
					<a href="/korean/pt/login/user/BD_index.do" class="btns st1 icn icnLogin">로그인</a>
					<a href="/" class="btns st1 icn icnHome">홈으로</a>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${userTyCd eq '2001'}">
		<section class="pageTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<img src="/cloud_ver2/new_cloud/images/join_step_4.png" alt="가입완료" />
				<h2>기업 회원가입</h2>
			</div>
			<!--// 타이틀 영역 -->
		</section>
		
		<div class="conWrap complete">
			<h3>
				<i class="quot">기업회원으로 가입이 완료되었습니다.</i>
			</h3>
			<p>
				${userNm}님, 클라우드스토어 씨앗에  가입해주셔서 감사합니다.<br />
				${userNm}님의 아이디는 [<em>${userId}</em>]입니다.<br />
				본 아이디로 모든 서비스를 자유롭게 이용하실 수 있습니다.<br /><br />
				
				더욱 다양한 서비스를 통해 회원만족을 실현하는 클라우드스토어 씨앗가 되겠습니다.
			</p>
			
			<div>		
				<a href="/korean/pt/register/BD_userCrtfc.do?nationCode=${nationCode}"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_offer_complete.png" alt="제공(판매) 권한 신청"></a>			
				<div class="btnArea rig">
					<a href="/korean/pt/login/user/BD_index.do" class="btns st1 icn icnLogin">로그인</a>
					<a href="/" class="btns st1 icn icnHome">홈으로</a>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${userTyCd eq '3001'}">
		<section class="pageTit">
			<!-- 타이틀 영역 -->
			<div class="conWrap">
				<img src="/cloud_ver2/new_cloud/images/join_step_4.png" alt="가입완료" />
				<h2>공공기관 회원가입</h2>
			</div>
			<!--// 타이틀 영역 -->
		</section>
		
		<div class="conWrap complete">
			<h3>
				<i class="quot">공공기관 회원으로 가입이 완료되었습니다.</i>
			</h3>
			<p>
				${userNm}님, 클라우드스토어 씨앗에 가입해주셔서 감사합니다.<br />
				${userNm}님의 아이디는 [<em>${userId}</em>]입니다.<br />
				본 아이디로 모든 서비스를 자유롭게 이용하실 수 있습니다.<br /><br />
				
				더욱 다양한 서비스를 통해 회원만족을 실현하는 클라우드스토어 씨앗가 되겠습니다.
			</p>
			
			<div>
				<a href="/korean/pt/register/BD_userCrtfc.do?nationCode=${nationCode}"><img src="/cloud_ver2/new_cloud/images/btn_joinSelect_offer_complete.png" alt="제공(판매) 권한 신청"></a>			
				<div class="btnArea rig">
					<a href="/korean/pt/login/user/BD_index.do" class="btns st1 icn icnLogin">로그인</a>
					<a href="/" class="btns st1 icn icnHome">홈으로</a>
				</div>
			</div>
		</div>
	</c:when>
	<c:otherwise></c:otherwise>
	</c:choose>
</c:if>
<!--// content -->