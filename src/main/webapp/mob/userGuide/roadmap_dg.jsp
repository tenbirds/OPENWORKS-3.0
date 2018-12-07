<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>오시는길</title>
    <!-- google map -->
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript" src="/new_cloud_m/js/googlemap01.js"></script>
	<!-- //google map -->
    </head>
<body>
				<!-- title-area -->
				<div class="title-area">
					<h2>찾아오시는 길</h2>
				</div>
				<!-- //title-area -->

				<!-- section -->
				<div class="section tab-list">
					<ul>
					<li class="on"><a href="/mob/userGuide/roadmap_dg.jsp">대구 본원</a></li>
					<li><a href="/mob/userGuide/roadmap_se.jsp">서울 사무소</a></li>
					</ul>
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section mt10">
					<div id="map-canvas" style="width:100%; height:210px;"></div> 
				</div>
				<!-- //section -->

				<!-- section -->
				<div class="section side location">
					<ul class="list">
					<li>주소 : 대구광역시 동구 첨단로 53 (41068)</li>
					<li>전화 : <a href="tel:053-230-1114">053-230-1114</a></li>
					</ul>
					
					<h3>찾아오시는 방법</h3>

					<dl>
						<dt><strong class="green">대중교통</strong></dt>
						<dd>
							<strong>서울 출발 기준</strong>
							<span class="dis-block">서울 ~ 동대구 (서울 - 동대구 이동)</span>
							동대구역 또는 동대구 고속버스터미널까지 이동 → 지하철 1호선 동대구역 승차 → 안심역 1번 출구 → 동구4-1번 환승 → 4개 정류장 이동 후 한국정보화진흥원 앞 하차
						</dd>
						<dt><strong class="blue">자가운전</strong></dt>
						<dd>
							<strong>서울 출발 기준</strong>
							<span class="dis-block">서울 ~ 동대구 IC (서울 - 동대구 이동)</span>
							동대구 IC → 화랑로 안심방면 우측 → 동부경찰서 좌회전 → 신서로 지하차도 진입 → 대구지방병무청 방면 우회전 → 동내로 우회전 → 첨단로 우회전 → 한국정보화진흥원 도착
						</dd>
					</dl>

				</div>
				<!-- //section -->
	</body>
</html>