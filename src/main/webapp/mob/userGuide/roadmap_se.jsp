<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>오시는길</title>
    <!-- google map -->
	<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript" src="/new_cloud_m/js/googlemap02.js"></script>
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
					<li><a href="/mob/userGuide/roadmap_dg.jsp">대구 본원</a></li>
					<li class="on"><a href="/mob/userGuide/roadmap_se.jsp">서울 사무소</a></li>
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
					<li>주소 : 서울특별시 중구 청계천로 14(04520)</li>
					<li>전화 : <a href="tel:070-4870-4015">070-4870-4015</a></li>
					</ul>

					<h3>찾아오시는 방법</h3>

					<dl>
						<dt><strong class="green">지하철</strong></dt>
						<dd>
							<strong class="blue">1호선</strong>
							1호선 시청역 5번출구 → 시청삼거리에서 좌회전(무교로방면)→ 서울파이낸스빌딩 옆
							<strong class="green">2호선</strong>
							2호선 을지로입구역 1번출구 → 시청삼거리에서 우회전(무교로방면) → 코코부르니(커피숍) 건너편
							<strong class="purple">5호선</strong>
							5호선 광화문역 5번출구 → 동아일보사 건너편
						</dd>

						<dt><strong class="red">버스</strong></dt>
						<dd>
							<strong>종로 1가에서 하차</strong>
							<ul>
							<li><strong class="blue">간선버스</strong>101, 103, 109, 150, 160, 260, 270, 271, 273, 370, 408, 470, 471, 501, 506, 601, 606, 705, 710, 721, 720, 702A(서오릉)</li>
							<li><strong class="green">지선버스</strong>1020, 7018, 7212</li>
							<li><strong class="red">광역버스</strong>2500, 9701</li>
							<li><strong class="gray">경기버스</strong>(일반)111</li>
							</ul>

							<strong>광화문(역)에서 하차</strong>
							<ul>
							<li><strong class="blue">간선버스</strong>101, 160, 260, 270, 273, 370, 470, 471, 704, 710, 720</li>
							<li><strong class="red">광역버스</strong>9709</li>
							<li><strong class="gray">경기버스</strong>(일반)99, 1002 / (급행)8600, 8601 / (직행)9710</li>
							</ul>

							<strong>서울신문사에서 하차</strong>
							<ul>
							<li><strong class="blue">간선버스</strong>101, 150, 402, 501, 506, 405A</li>
							<li><strong class="green">광역버스</strong>1711, 7016</li>
							</ul>
						</dd>

						<dt><strong class="blue">승용차</strong></dt>
						<dd>건물뒷편 주차장 입구에서 차량용 리프트를 이용하여 지하 주차장에 주차한 후 엘리베이터를 이용하여 1F 안내데스크에서 안내를 받아 주십시오.</dd>

						<dt><strong class="black">공항</strong></dt>
						<dd>
							<strong>KAL LIMOUSINE BUS</strong>
							<ul class="list-type">
							<li>- 승차위치 : 인천공항(동4B, 11A), 코리아나호텔 정문 앞</li>
							<li>- 인천공항 → 코리아나호텔<br />(첫차 : 04:45 / 간격 : 20~30분 / 막차 : 22:44분 / 소요시간 : 60~70분)</li>
							<li>- 코리아나호텔 → 인천공항<br />(첫차 : 05:00 / 간격 : 20~30분 / 막차 : 19:05분 / 소요시간 : 60~70분)</li>
							<li>- 김포공항 → 인천공항<br />(첫차 : 04:00 / 간격 : 10~30분 / 막차 : 21:50분 / 소요시간 : 40분)</li>
							<li>- 요금 : 코리아나호텔 ↔ 인천공항 16,000원 / 김포공항 → 인천공항 7,000원</li>					
							</ul>

							<strong>6005번 (AIRPORT LIMOUSINE BUS)</strong>
							<ul class="list-type">
							<li>- 승차위치 : 코리아나호텔 옆 마을버스 정류장</li>
							<li>- 인천공항 → 광화문<br />(첫차 : 06:35 / 간격 : 15분 / 막차 : 23:00분 / 소요시간 : 80~90분)</li>
							<li>- 광화문 → 인천공항<br />(첫차 : 04:33 / 간격 : 20~40분 / 막차 : 20:45분 / 소요시간 : 80~85분)</li>
							<li>- 요금 : 광화문 → 인천공항 10,000원</li>					
							</ul>

							<strong>6701번 (KAL LIMOUSINE BUS)</strong>
							<ul class="list-type">
							<li>- 승차위치 : 코리아나호텔 앞 공항버스 정류장</li>
							<li>- 인천공항 → 코리아나호텔<br />(첫차 : 04:45 / 간격 : 20~40분 / 막차 : 22:44분 / 소요시간 : 60~70분)</li>
							<li>- 코리아나호텔 → 인천공항<br />(첫차 : 05:15 / 간격 : 20~25분 / 막차 : 18:50분 / 소요시간 : 60~70분)</li>
							<li>- 요금 : 코리아나호텔 → 인천공항 16,000원</li>					
							</ul>
						</dd>
					</dl>

				</div>
				<!-- //section -->
	</body>
</html>