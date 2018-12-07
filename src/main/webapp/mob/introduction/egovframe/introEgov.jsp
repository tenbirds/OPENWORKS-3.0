<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>표준프레임워크 소개</title>
	</head>
<body>
<!-- container -->
	
	<!-- contents -->
			<div class="contents introduce">
				<!-- section -->
				<div class="section tab-list">
					<ul>
					<li><a href="/mob/introduction/ompIntro/ompIntroduction.jsp">씨앗소프트웨어</a></li>
					<li class="on"><a href="/mob/introduction/egovframe/introEgov.jsp">표준프레임워크</a></li>
					</ul>
				</div>
				<!-- //section -->

				<!-- title-area -->
				<div class="title-area">
					<h2 class="no-style">전자정부 표준프레임워크</h2>
					<!-- <a href="#" class="b-btn application type2"><strong><span>호환성 신청</span></strong></a> -->					
				</div>
				<!-- //title-area -->

				<!-- section -->
				<div class="section side">
					<ul class="underline-list">
					<li><a href="#framework">Ⅰ.전자정부 표준프레임워크란</a></li>
					<li><a href="#compatibility">Ⅱ.호환성 절차 안내</a></li>
					</ul>
				</div>
				<!-- //section -->
				
				<!-- section -->
				<div class="section side" id="framework">
					<!-- 전자정부 표준프레임워크란 -->
					<h3 class="txt-word-d">전자정부 표준프레임워크란</h3>
					<dl class="desc">
						<dt>등장배경 및 목적</dt>
						<dd>개발프레임워크는 정보시스템 개발을 위해 필요한 기능 및 아키텍처를 미리 만들어 제공함으로써 효율적인 어플리케이션 구축을 지원합니다. <span class="txt-word">“전자정부 표준프레임워크”</span>는 공공사업에 적용되는 개발프레임워크의 표준정립으로 <span class="txt-word">응용 SW 표준화, 품질 및 재사용성 향상을 목표</span>로 합니다. 이를 통해“전자정부 서비스의 품질향상”및“정보화 투자 효율성 향상”을 달성하고 대ㆍ중소기업이 동일한 개발기반 위에서 공정경쟁이 가능하게 됩니다.</dd>
					</dl>
					<!-- //전자정부 표준프레임워크란 -->

				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section side mt30">
					<!-- 특징 -->
					<dl class="desc">
						<dt>특징</dt>
						<dd>
							<dl>
								<dt>개방형 표준 준수</dt>
								<dd>
									<ul>
									<li>- 오픈소스 기반의 범용화되고 공개된 기술의 활용으로 특정 사업자에 대한 종속성 배제</li>
									</ul>
								</dd>
								
								<dt>상용 솔루션 연계</dt>
								<dd>
									<ul>
									<li>- 상용 솔루션과 연계가 가능한 표준을 제시하여 상호운용성 보장</li>
									</ul>
								</dd>

								<dt>국가적 표준화 지향</dt>
								<dd>
									<ul>
									<li>- 민.관.학계로 구성된 자문협의회를 통해 국가적 차원의 표준화 수행</li>
									</ul>
								</dd>

								<dt>변화 유연성</dt>
								<dd>
									<ul>
									<li>- 각 서비스의 모듈화로 교체가 용이하며 인터페이스 기반 연동으로 모듈간 변경영향 최소화</li>
									</ul>
								</dd>

								<dt>모바일 환경 지원</dt>
								<dd>
									<ul>
									<li>- 모바일 환경을 위한 모바일 웹(UX/UI) 및 하이브리드 앱 지원</li>
									</ul>
								</dd>

								<dt>편리하고 다양한 환경제공</dt>
								<dd>
									<ul>
									<li>- Eclipse 기반의 모델링(UML,ERD), 에디팅, 컴파일링, 디버깅 환경 제공</li>
									</ul>
								</dd>
							</dl>
						</dd>
					</dl>					
					<!-- //특징 -->
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section side mt30">
					<!-- 적용 가능 시스템 조건 -->
					<dl class="desc">
						<dt>적용 가능 시스템 조건</dt>
						<dd>
							<dl>
								<dt>아래 세가지 조건을 모두 만족하는 경우 표준프레임워크 적용 가능</dt>
								<dd>
									<ul>
									<li>① 자바 기반의 웹 응용 시스템(WAS가 존재하는 경우)</li>
									<li>② (2.7 기준) JavaEE(J2EE) 5 혹은 JDK1.5 이상의 환경 (단, 개발환경 2.7 이상에서는 JDK 1.6 이상 필요)<br />(3.0 기준) JavaEE(J2EE) 6 혹은 JDK1.6 이상의 환경</li>
									<li>③ 신규 개발시스템으로써, 기존 시스템과 물리적 혹은 논리적으로 구분되는 경우<br />☞ 실행환경 내 모바일 표준프레임워크의 사용자 경험(UX) 지원 기능은 프레임워크와 개발 언어 종류에 상관없이 활용가능 (javascript 기반)</li>
									</ul>
								</dd>
							</dl>
						</dd>
					</dl>
					<!-- //적용 가능 시스템 조건 -->
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section side mt30">
					<!-- 적용효과 -->
					<dl class="desc">
						<dt>적용효과</dt>
						<dd>
							<p>정보시스템을 개발하거나 운영할 때 필요한 기본 기능을 미리 구현한것으로 이를 기반으로 추가 기능을 개발하여 조립함으로써 전체 정보시스템을 완성할 수 있습니다.</p>
							<p class="ac mt30"><img src="/new_cloud_m/images/sub/img-framework01.jpg" alt="" class="" /></p>
						</dd>
					</dl>					
					<!-- //적용효과 -->
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section mt30">
					<strong class="dis-block ac">&lt; 표준프레임워크 적용 전/후 비교표 &gt;</strong>
					<dl class="table-list">
						<dt>표준프레임워크 적용 전</dt>
						<dd>
							<ul>
							<li>정보화사업별 동일한 기능들의 중복 개발</li>
							<li>기술 종속으로 인해 선행사업자 의존도 높음</li>
							<li>프레임워크 미 보유업체는 경쟁 불리</li>
							<li>정보시스템간 상호 연계 시 많은 기간과 인력이 소요</li>
							<li>개발표준 미흡으로 유지보수가 어려움</li>
							</ul>
						</dd>
						<dt>표준프레임워크 적용 후</dt>
						<dd>
							<ul>
							<li>공통컴포넌트 재사용으로 중복 예산 절감</li>
							<li>표준화된 개발기반으로 사업자 종속성 해소</li>
							<li>프레임워크 무상제공으로 중소기업 경쟁력 향상</li>
							<li>표준화된 연계모듈 활용으로 상호운용성 향상</li>
							<li>개발표준에 의한 모듈화로 유지보수가 용이</li>
							</ul>
						</dd>
					</dl>
				</div>
				<!-- //section -->

				<!-- 호환성 절차 안내 -->
				<div class="section side" id="compatibility">
					<h3 class="txt-word-d">호환성 절차 안내</h3>
					<dl class="desc">
						<dt>상호호환성 확인 서비스 개요</dt>
						<dd>
							표준프레임워크와 연관된 상용솔루션과 표준프레임워크에서 제공하는 기능이 연동하여 정상 동작하는지 확인하는 서비스로 최종 확인 후 호환레벨에 따른 확인서를 제공합니다.
							<p class="mt20">상호호환성 확인 대상</p>
							- DBMS, WAS 등 표준프레임워크 적용, 연동, 지원 기능을 제공하는 SW를 대상으로 합니다.
						</dd>
					</dl>
				</div>
				<!-- //호환성 절차 안내 -->

				<!-- section -->
				<div class="section mt30">
					<strong class="mb10 dis-block ac">&lt; 상호호환성 호환레벨 &gt;</strong>
					<table class="table">
						<caption>상호호환성 호환레벨</caption>
						<colgroup>
						<col style="width:80px;" />
						<col style="width:*;" />
						</colgroup>
						<tbody>
							<tr>
								<th>호환</th>
								<td>
									<strong>레벨 1</strong>
									<p class="mt10 mb20">표준프레임워크와 호환되는 기능에 대하여 모듈을 수정없이 사용 가능하며, 관련 기능들이 모두 정상 동작함</p>

									<strong>레벨 2</strong>
									<p class="mt10">표준프레임워크와 호환되는 기능 중 일부는 상용 솔루션에서 확장한 라이브러리로 사용해야 관련 기능이 모두 정상 동작함</p>
								</td>
							</tr>
							<tr>
								<th>미호환</th>
								<td>
									<p>표준프레임워크와 호환되는 기능 중 일부는 상용 솔루션에서 확장한 라이브러리로 사용해야 관련 기능이 모두 정상동작함</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section side mt30">
					<dl class="desc">
						<dt>상호호환성 확인 서비스 진행 절차</dt>
						<dd>
							표준프레임워크센터 내 상호호환성 확인 절차에 따라 수행됩니다.
							<p class="ac mt20"><img src="/new_cloud_m/images/sub/img-framework02.jpg" alt="" class="no-bor" /></p>
						</dd>
					</dl>
				</div>
				<!-- //section -->

				<div class="btn-area ac mt30">
					<a href="/korean/m/store/software/BD_index.do?selectItem1=1001" class="b-btn type2"><strong><span>표준프레임워크와의 상호호환성을 확인한 솔루션 보기</span></strong></a>
				</div>
			</div>
			<!-- //contents -->
	</body>
</html>