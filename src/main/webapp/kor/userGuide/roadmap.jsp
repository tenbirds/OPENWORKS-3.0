<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>오시는길</title>
<script type="text/javaScript">
var fnView = function(tab) {
		//eval($("#"+tab1).removeAttr('disabled'));
	
	if (tab == 'tab1') {
		$('#tab1').show();
		$('#tab2').hide();
	}else if (tab == 'tab2') {
		$("#tab1").hide();
		$("#tab2").show();
	}		
}
</script>
</head>
<body>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=lnKct2tWg2kxmSVF4feE"></script>	      
	
	<div class="conWrap map">
		<ul class="tab_menu">
			<li>
				<!-- <span onclick="fnView('tab1');">대구 본원</span> -->
				<a href="#">대구 본원</a>
				<div class="tab_con" id="tab1">
					<h3>대구 본원</h3>
					<p>주소 : 대구광역시 동구 첨단로 53 (41068)    /    전화 : 1522-0089</p>
						<div id="map" style="width:900px;height:498px;"></div>
						
						<script>

						var cityhall = new naver.maps.LatLng(35.880824, 128.730652);
						
 						var map = new naver.maps.Map('map', {
						    center: new naver.maps.LatLng(35.880824, 128.730652),
						    zoom: 10
						});

 						
 						var contentString = [
 						                    '<div class="iw_inner">',
 						                    '   <h3>서울특별시청</h3>',
 						                    '   <p>서울특별시 중구 태평로1가 31 | 서울특별시 중구 세종대로 110 서울특별시청<br/>',
 						                    '       <img src="./img/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" /><br/>',
 						                    '       02-120 | 공공,사회기관 > 특별,광역시청<br/>',
 						                    '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
 						                    '   </p>',
 						                    '</div>'
 						                ].join('');
 						
 						
						var marker = new naver.maps.Marker({
						    map: map,
							position: cityhall
						});

						
						var infowindow = new naver.maps.InfoWindow({

						    content: contentString,

						    maxWidth: 140,
						    backgroundColor: "#eee",
						    borderColor: "#2db400",
						    borderWidth: 5,
						    anchorSize: new naver.maps.Size(30, 30),
						    anchorSkew: true,
						    anchorColor: "#eee",

						    pixelOffset: new naver.maps.Point(20, -20)
						});

						naver.maps.Event.addListener(marker, "click", function(e) {
						    if (infowindow.getMap()) {
						        infowindow.close();
						    } else {
						        infowindow.open(map, marker);
						    }
						});						
						
						var map = new naver.maps.Map('map', mapOptions);
						
						
						</script>

					<!-- div>
						<img src="/cloud_ver2/new_cloud/images/img_map_dg.png" alt="대구 본원 약도" /> 
					</div -->
					
					<h4>찾아오시는 방법</h4>
					<table summary="찾아오시는 방법">
					<caption>찾아오시는 방법</caption>
					<colgroup>
						<col width="110px"/>
						<col width="*"/>
					</colgroup>
					<thead style="display: none;">
						<tr>
							<th colspan="2"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_air_massTra.png" alt= "대중교통" /></th>
							<td>
								<h5>서울 출발 기준</h5>
								<p>
									서울 ~ 동대구 (서울 - 동대구 이동)<br />
									동대구역 또는 동대구 고속버스터미널까지 이동 → 지하철 1호선 동대구역 승차 →<br />
									안심역 1번 출구 → 동구4-1번 환승 → 4개 정류장 이동 후 한국정보화진흥원 앞 하차
								</p>					
							</td>
						</tr>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_mycar.png" alt="자가운전" /></th>
							<td>
								<h5>서울 출발 기준</h5>
								<p>
									서울 ~ 동대구 IC (서울 - 동대구 이동)
									동대구 IC → 화랑로 안심방면 우측 → 동부경찰서 좌회전 → 신서로 지하차도 진입 →<br />
									대구지방병무청 방면 우회전 → 동내로 우회전 → 첨단로 우회전 → 한국정보화진흥원 도착
								</p>					
							</td>					
						</tr>
						</tbody>
					<tfoot style="display: none;">
						<tr>
							<th colspan="2"></th>
						</tr>
					</tfoot>
					</table>
				</div>
			</li>
			<li>
				<!-- <span onclick="fnView('tab2');">서울 사무소</span> -->
				<a href="#">서울 사무소</a>
				<div class="tab_con" id="tab2"> <!-- style="display: none" -->
					<h3>서울 사무소</h3>
					<p>주소 : 서울특별시 중구 청계천로 14 (04520)   /   전화 : 1522-0089</p>
						<div id="map1" style="width:900px;height:498px;"></div>
						<script>
	 						var map = new naver.maps.Map('map1', {
							    center: new naver.maps.LatLng(37.568758, 126.978774),
							    zoom: 12
							});
	
							var marker = new naver.maps.Marker({
							    position: new naver.maps.LatLng(37.568758, 126.978774),
							    map: map
							});
							
							var map = new naver.maps.Map('map1', mapOptions); 
						</script>
					<!-- div>
						<img src="/cloud_ver2/new_cloud/images/img_map_se.png" alt="서울 사무소 약도" />
					</div -->
					
					<h4>찾아오시는 방법</h4>
					<table summary="찾아오시는 방법">
					<caption>찾아오시는 방법</caption>
					<colgroup>
						<col width="110px"/>
						<col width="*"/>
					</colgroup>
					<thead style="display: none;">
						<tr>
							<th colspan="2"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_subway.png" alt="지하철" /></th>
							<td>
								<ul>
									<li class="line1"><em>1호선</em>     1호선 시청역 5번출구 → 시청삼거리에서 좌회전(무교로방면) → 서울파이낸스빌딩 옆</li>
									<li class="line2"><em>2호선</em>     2호선 을지로입구역 1번출구 → 시청삼거리에서 우회전(무교로방면) → 코코부르니(커피숍) 건너편</li>
									<li class="line5"><em>5호선</em>     5호선 광화문역 5번출구 → 동아일보사 건너편</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_bus.png" alt="버스" /></th>
							<td>
								<h5>종로 1가에서 하차</h5>
								<p>
									간선버스 : 101, 103, 109, 150, 160, 260, 270, 271, 273, 370, 408, 470, 471, 501, 506, 601, 606, 705, 710, 721, 720, 702A(서오릉)<br />
									지선버스 : 1020, 7018, 7212<br />
									광역버스 : 2500, 9701<br />
									경기버스 : (일반)111	
								</p>
			
								<h5>광화문(역)에서 하차</h5>
								<p>
									간선버스 : 101, 160, 260, 270, 273, 370, 470, 471, 704, 710, 720<br />
									광역버스 : 9709<br />
									경기버스 : (일반)99, 1002 / (급행)8600, 8601 / (직행)9710					
								</p>
			
								<h5>서울신문사에서 하차</h5>
								<p>
									간선버스 : 101, 150, 402, 501, 506, 405A<br />
									지선버스 : 1711, 7016					
								</p>
							</td>
						</tr>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_mycar.png" alt="자가운전" /></th>
							<td>건물뒷편 주차장 입구에서 차량용 리프트를 이용하여 지하 주차장에 주차한 후 엘리베이터를 이용하여<br /> 1F 안내데스크에서 안내를 받아 주십시오.</td>
						</tr>
						<tr>
							<th><img src="/cloud_ver2/new_cloud/images/icn_map_air_bus.png" alt="공항" /></th>
							<td>
								<h5>종로 1가에서 하차</h5>
								<ul>
									<li>- 승차위치 : 인천공항(동4B, 11A), 코리아나호텔 정문 앞</li>
									<li>- 인천공항 → 코리아나호텔
									  (첫차 : 04:45 / 간격 : 20~30분 / 막차 : 22:44분 / 소요시간 : 60~70분)
									</li>
									<li>- 코리아나호텔 → 인천공항
									  (첫차 : 05:00 / 간격 : 20~30분 / 막차 : 19:05분 / 소요시간 : 60~70분)
									</li>
									<li>- 김포공항 → 인천공항
									  (첫차 : 04:00 / 간격 : 10~30분 / 막차 : 21:50분 / 소요시간 : 40분)
									</li>
									<li>- 요금 : 코리아나호텔 ↔ 인천공항 16,000원 / 김포공항 → 인천공항 7,000원</li>
								</ul>
			
								<h5>6005번 (AIRPORT LIMOUSINE BUS)</h5>
								<ul>
									<li>- 승차위치 : 인천공항(동4B, 11A), 코리아나호텔 정문 앞</li>
									<li>- 인천공항 → 코리아나호텔<br />
									(첫차 : 04:45 / 간격 : 20~30분 / 막차 : 22:44분 / 소요시간 : 60~70분)</li>
									<li>- 코리아나호텔 → 인천공항<br />
									(첫차 : 05:00 / 간격 : 20~30분 / 막차 : 19:05분 / 소요시간 : 60~70분)</li>
									<li>- 김포공항 → 인천공항<br />
									(첫차 : 04:00 / 간격 : 10~30분 / 막차 : 21:50분 / 소요시간 : 40분)</li>
									<li>- 요금 : 코리아나호텔 ↔ 인천공항 16,000원 / 김포공항 → 인천공항 7,000원</li>						
								</ul>
			
								<h5>6701번 (KAL LIMOUSINE BUS)</h5>
								<ul>
									<li>- 승차위치 : 인천공항(동4B, 11A), 코리아나호텔 정문 앞</li>
									<li>- 인천공항 → 코리아나호텔<br />
									(첫차 : 04:45 / 간격 : 20~30분 / 막차 : 22:44분 / 소요시간 : 60~70분)</li>
									<li>- 코리아나호텔 → 인천공항<br />
									(첫차 : 05:00 / 간격 : 20~30분 / 막차 : 19:05분 / 소요시간 : 60~70분)</li>
									<li>- 김포공항 → 인천공항<br />
									(첫차 : 04:00 / 간격 : 10~30분 / 막차 : 21:50분 / 소요시간 : 40분)</li>
									<li>- 요금 : 코리아나호텔 ↔ 인천공항 16,000원 / 김포공항 → 인천공항 7,000원</li>
								</ul>
							</td>
						</tr>
						</tbody>
					<tfoot style="display: none;">
						<tr>
							<th colspan="2"></th>
						</tr>
					</tfoot>
					</table>
				</div>
			</li>
		</ul>
	</div>
	<!--// content -->
</body>
</html>