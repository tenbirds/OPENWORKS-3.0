<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title>수요정보조사 설명회 신청</title>
	<op:jsTag type="openworks" items="ui" />
	<op:jsTag type="spi" items="form,validate" />

	<!-- 사용자 스크립트 시작 -->
	<script type="text/javascript">	
		$().ready(function(){
		    
		});
		
	    var jsAprsltCancl = function(se) {
	        if(confirm('클라우드 도입 사전평가 설명회의 \n신청을 취소하시겠습니까?')) {
		        $("#dataForm").ajaxSubmit({
	                url      : "ND_aprsltCanclAction.do",		//회원 정보 수정 하는 곳 
	                type     : "POST",
	                dataType : "json",
	                success  : function (response) {
	                    try {
	                        if(response.result) {
	                            alert('클라우드 도입 사전평가 설명회의 \n신청이 취소되었습니다.');
	                            self.location.href="/korean/pt/index.do";
	                        } else {
	                            alert(response.message);
	                        }
	                    } catch (e) {
	                        alert(response, e);
	                        return;
	                    }
	                },
	                error :  function(response) {
	                    alert(response.responseText);
	                    return;
	                }
				});
	        }
	    };
	</script>
	<!-- 사용자 스크립트 끝 -->
</head>
<body>
	<form name="dataForm" id="dataForm" method="post">
	
	<!--title-area-->
	<div class="title-area">
		<h2>수요정보조사 설명회 신청결과</h2>
	</div>
	<div class="chart mt20">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tableStyle">
			<caption class="hidden">board</caption>
		    <colgroup>
		    	<col width="129px;"/>
		    	<col width="702px;"/>
		    </colgroup>
		    <tr>
		    	<th>신청자명</th>
		        <td><c:out value="${baseVo.userNm}"/></td>
		    </tr>
		    <tr>
                <th>소속기관</th>
                <td><c:out value="${baseVo.pblinsttNm}"/></td>
            </tr>
            <tr>
                <th>신청행사</th>
                <td><c:if test="${baseVo.partcptSe == 1001}">10월 10일 서울행사</c:if><c:if test="${baseVo.partcptSe == 1002}">10월 11일 대구행사</c:if></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><c:out value="${baseVo.mbtlnum}"/></td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><c:out value="${baseVo.email}"/></td>
            </tr>
            <tr>
                <th>참가신청일</th>
                <td><c:out value="${baseVo.partcptReqstDt}"/></td>
            </tr>

		</table>
	</div>
	<c:if test="${baseVo.partcptAt1 eq 'Y'}">
	<p class="btn_participate mt20"><a href="javascript:;" onclick="jsAprsltCancl();"></a></p>
	</c:if>
	<div class="map_guide mt30">
		<p class="txt_map mb16">수요정보조사 설명회 행사장 안내</p>
		<c:if test="${baseVo.partcptSe == 1001}">
		<div class="map_box mb20">
			<p class="txt_map_b mb16">주소 : 서울시 마포구 성암로 301 (03923) | 전화 : 02-2031-9100</p>
		    <p><img src="/new_cloud/images/sub/map_seoul.gif" width="760" height="408"/></p>
		    <p class="txt_map_b ac">행사 당일 주차는 불가하오니 대중교통을 이용해주시기 바랍니다.</p>
		    <p class="txt_map_b mt30 mb16">찾아오시는 방법</p>
		    <div class="map_area">
		    	<span class="traffic_area">
		        <ul>
		        	<li class="traffic_icon">아이콘</li>
		            <li><strong>대중교통</strong></li>
		        </ul>
		        </span>
		        <div class="traffic_txt">
		        	<p class="trafftt_a"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>서울역에서 오는 방법</strong></p>
		            <p>서울역 공항철도 승차 후, 디지털미디어시티역 하차 → 디지털미디어시티역 7번 출구로 나와, 출구 앞 버스정류장으로 이동 → 마포18 마을버스 승차 후 우리기술사옥, 한국지역정보개발원 정류장에서 하차 → 한국지역정보개발원까지 약 10m 이동　</p>
		            <p class="trafftt_a mt20"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>정부서울청사(광화문)에서 오는 방법</strong></p>
		            <p>사직동주민센터 버스정류장(경복궁역 1번 출구 방향)에서 171번 버스 승차 → 월드컵파크5단지(상암중고등학교입구) 정류장에서 하차 → 한국지역정보개발원까지 약 283m 이동　</p>
	                <p class="trafftt_a mt20"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>지하철 6호선 이용시</strong></p>
	                <p>디지털미디어시티역 2번 또는 3번 출구 → 누리꿈스퀘어 방향 마을버스 또는 지선버스 이용</p>
	                <p class="trafftt_a mt20"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>지하철 2호선 이용시</strong></p>
	                <p>홍대입구역 1번 출구 → 7711, 7737 지선버스 이용</p>
	                <p class="trafftt_a mt20"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>경의중앙선 이용시</strong></p>
	                <p>수색역 1번 출구 → 서쪽(일산) 방향으로 50m 이동 → 수색치안센터 옆 지하보도 이용(650m 정도) * 일산쪽 방향에서 버스를 타고 오는 경우, 수색역 주변에서 하차하여 지하보도 이용</p>
	                <p class="trafftt_a mt20"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>버스</strong></p>
	                <p>- (파란버스) 171, 710, 271번
						- (녹색버스) 마포18, 6715, 7711, 7730, 7737번
						* 마포18번 버스 이용 시 우리기술사옥,한국지역정보개발원에서 하차.
						* 6715, 7711, 7730 버스 이용 시 월드컵파크 5단지에서 하차하여 도보.
						* 7737 버스 이용 시 DMC첨단산업센터에서 하차하여 MBC 건물방향으로 도보.</p>
				</div>
			</div>
		</div>
		</c:if>
		<c:if test="${baseVo.partcptSe == 1002}">
		<div class="map_box mb50" style="height:850px;">
			<p class="txt_map_b mb16">대구광역시 동구 첨단로 53 (41068) | 전화 : 1522-0089</p>
		    <p><img src="/new_cloud/images/sub/img-location01.jpg"/></p>
		    <p class="txt_map_b mt30 mb16">찾아오시는 방법</p>
		    <div class="map_area pb20 bdrBo">
		    	<span class="traffic_area">
		        <ul>
		        	<li class="traffic_icon">아이콘</li>
		            <li><strong>대중교통</strong></li>
				</ul>
		        </span>
		        <div class="traffic_txt">
		        	<p class="trafftt_a"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>서울 출발 기준</strong></p>
		            <p>서울 ~ 동대구 (서울 - 동대구 이동)<br/>
							동대구역 또는 동대구 고속버스터미널까지 이동 → 지하철 1호선 동대구역 승차 →<br/>
							안심역 1번 출구 → 동구4-1번 환승 → 4개 정류장 이동 후 한국정보화진흥원 앞 하차</p>
				</div>
	        </div>
			<div class="map_area mt20">
		    	<span class="car_area">
		        <ul>
		        	<li class="car_icon">아이콘</li>
		            <li><strong>자가운전</strong></li>
		        </ul>
		        </span>
		        <div class="traffic_txt">
		        	<p class="trafftt_b"><img src="/new_cloud/images/sub/bullet_green.gif" width="3" height="3"/>  <strong>서울 출발 기준</strong></p>
		            <p>서울 ~ 동대구 (서울 - 동대구 이동)<br/>
							동대구역 또는 동대구 고속버스터미널까지 이동 → 지하철 1호선 동대구역 승차 →<br/>
							안심역 1번 출구 → 동구4-1번 환승 → 4개 정류장 이동 후 한국정보화진흥원 앞 하차</p>
				</div>
			</div>
		</div>
		</c:if>
	</div>
	</form>
</body>
</html>