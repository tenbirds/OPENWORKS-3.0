<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>체험하기</title></head>
<body><div class="exp_tab">
					<div class="cate_tab tab_array">
						<ul>
							<li>
								<a href="#category1" class="on" onclick="viewCategory('1'); return false;">이용자 체험</a>
							</li>
							<li>
								<a href="#category2" onclick="viewCategory('2'); return false;">판매자 체험</a>
							</li>
							<li>
								<a href="#category3" onclick="viewCategory('3'); return false;">비즈매칭 체험</a>
							</li>
							<li>
								<a href="#category4" onclick="viewCategory('4'); return false;">커뮤니티 체험</a>
							</li>
							<li>
								<a href="#category5" onclick="viewCategory('5'); return false;">커뮤니케이션 활동</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- //tab -->
<script type="text/javascript">
	$(function(){
		$("#slider_area1").imageScroller({
			next:"btn1_1",                   //다음 버튼 ID값
			prev:"btn1_2",                   //이전 버튼 ID값
			frame:"scrollerFrame1",         //스크롤러 프레임 ID값 
			width:755,                     //이미지 가로 크기
			child:"li",                    //스크롤 지정 태그
			auto: false                      //오토 롤링 (해제는 false)
		});
	});
</script>
				<div id="category1" class="category">
					<h4>이용자 체험</h4>
					<div id="slider_area1">
						<ul id="scrollerFrame1" class="scrollerFrame">
							<li>
								<p class="title"><em>01.</em> 서비스 리스트 조회</p>
								<p class="summary">표준프레임워크호환, 솔루션/서비스, IT전문가서비스 메뉴에서 각각의 서비스를 추천서비스, 인기서비스 등을 조회할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_01.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>02.</em> 서비스 찾기</p>
								<p class="summary">원하는 서비스가 한번에 찾기가 어려우시면 카테고리 내 검색을 통해 검색할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_02.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>03.</em> 서비스 구매</p>
								<p class="summary">원하는 서비스를 찾으셨나요? 서비스 상세페이지에서 서비스에 대한 정보를 확인하고<br /><em>"구매/신청하기"</em> 버튼을 클릭해보세요.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_03.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>04.</em> 서비스 구매내역 확인</p>
								<p class="summary">구매/신청을 한 서비스는 <em>마이페이지 &gt; 구매내역 리스트</em>에서 확인할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_04.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>05.</em> 서비스평가</p>
								<p class="summary">서비스에 대한 평가를 해보세요.<br />별점을 1개부터 5개까지 부여할 수 있고 코멘트도 남길 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_05.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>06.</em> 서비스 리뷰 등록</p>
								<p class="summary">서비스에 대한 리뷰를 작성해 보세요.<br />다른 이용자들이 구매시 참고할만한 좋은 자료가 될 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/purchaser_06.jpg" alt="">
								</div>
							</li>
						</ul>						
						<a href="#none" id="btn1_1" class="left"><img src="/resources/web/theme/default/images/btn/btn_clamp_l.gif" alt="이전"></a>
						<a href="#none" id="btn1_2" class="right" style="position:absolute; top:248px; right:0;"><img src="/resources/web/theme/default/images/btn/btn_clamp_r.gif"alt="다음"></a>					
					</div>
				</div>
<script type="text/javascript">
	$(function(){
		$("#slider_area2").imageScroller({
			next:"btn2_1",                   //다음 버튼 ID값
			prev:"btn2_2",                   //이전 버튼 ID값
			frame:"scrollerFrame2",         //스크롤러 프레임 ID값 
			width:755,                     //이미지 가로 크기
			child:"li",                    //스크롤 지정 태그
			auto: false                      //오토 롤링 (해제는 false)
		});
	});
</script>
				<div id="category2" class="category hide">
					<h4>판매자 체험</h4>
					<div id="slider_area2">
						<ul id="scrollerFrame2" class="scrollerFrame">
							<li>
								<p class="title"><em>01.</em> 서비스등록</p>
								<p class="summary">판매하기 메뉴에서 서비스를 등록할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_01.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>02.</em> 서비스 등록대기</p>
								<p class="summary">서비스 등록은 등록 후 관리자의 검토, 승인이 되어야 서비스를 전시할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_02.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>03.</em> 서비스 전체목록관리</p>
								<p class="summary">관리자의 검토, 승인이 끝난 서비스를 모두 확인할 수 있으며 전시, 비전시 할 수 있습니다.<br />단, 서비스 수저신청을 한 경우에도 관리자의 검토, 승인이 되어야 전시할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_03.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>04.</em> 구매/신청(IT전문가서비스 신청) 관리</p>
								<p class="summary">이용자들이 신청한 서비스 및 컨설팅 신청내역을 확인할 수 있고 이용자 정보를 조회하여<br /> 이용자들과 직접 연락할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_04.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>05.</em> 서비스문의 관리</p>
								<p class="summary">이용자들이 서비스(IT전문가서비스)에 대한 궁금한 사항들을 등록한 내역을<br />서비스별로 확인하고 답변을 할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_05.jpg" alt="" />
								</div>
							</li>
							<li>
								<p class="title"><em>06.</em> 판매통계</p>
								<p class="summary">어느 서비스가 언제 많이 팔리고 어느 서비스이 조회수가 많은 지,<br />이용자들이 관심이 많은 서비스는 무엇인지 등 서비스에 대한 통계 내역을 조회할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/seller_06.jpg" alt="" />
								</div>
							</li>
						</ul>						
						<a href="#none" id="btn2_1" class="left" ><img src="/resources/web/theme/default/images/btn/btn_clamp_l.gif" alt="이전" /></a>
						<a href="#none" id="btn2_2" class="right" style="position:absolute;top:248px;right:0;"><img src="/resources/web/theme/default/images/btn/btn_clamp_r.gif"alt="다음" /></a>					
					</div>
				</div>
<script type="text/javascript">
	$(function(){
		$("#slider_area3").imageScroller({
			next:"btn3_1",                   //다음 버튼 ID값
			prev:"btn3_2",                   //이전 버튼 ID값
			frame:"scrollerFrame3",         //스크롤러 프레임 ID값 
			width:755,                     //이미지 가로 크기
			child:"li",                    //스크롤 지정 태그
			auto: false                      //오토 롤링 (해제는 false)
		});
	});
</script>
				<div id="category3" class="category hide">
					<h4>비즈매칭 체험</h4>
					<div id="slider_area3">
						<ul id="scrollerFrame3" class="scrollerFrame">
							<li class="item exp_first">
								<p class="title"><em>01.</em> 비즈매칭 서비스란?</p>
								<p class="summary">이용자(이용자)가 찾고자 하는 솔루션, 컨설팅이 없을 경우 또는 어떤 솔루션, 컨설팅을 선택해야 하는지 모를 때<br />이용자(이용자)가 찾고자 하는 서비스(컨설팅)을 등록하면 판매자(제공자)들과 매칭시켜주는 비즈매칭 서비스를 제공합니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/biz_01.jpg" alt="" />
								</div>
							</li>
							<li class="item">
								<p class="title"><em>02.</em> 비즈매칭 설정</p>
								<p class="summary">판매자 권한으로 회원 가입 시 또는 <em>판매하기 &gt; 비즈매칭 내역 메뉴</em>에서 비즈매칭 설정 항목을 등록해 놓으세요<br />그러면 이용자가 등록한 비즈매칭 서비스 신규내역과 구분항목이 일치하는 내역이 있으면 바로 알려드립니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/biz_02.jpg" alt="" />
								</div>
							</li>
							<li class="item">
								<p class="title"><em>03.</em> 비즈매칭 등록/선정</p>
								<p class="summary">찾고자 하는 솔루션, 컨설팅 내용을 등록 후 판매자가 회원분들이 댓글을 올려주시면 구매회원 분들은 본인이 찾고자<br />하는 내용과 일치하는 댓글을 등록하신 판매자의 댓글을 선정해주시면 판매자 회원이 직접 연락을 드릴 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/biz_03.jpg" alt="" />
								</div>
							</li>
						</ul>						
						<a href="#none" id="btn3_1" class="left"><img src="/resources/web/theme/default/images/btn/btn_clamp_l.gif" alt="이전" /></a>
						<a href="#none" id="btn3_2" class="right" style="position:absolute;top:248px;right:0;"><img src="/resources/web/theme/default/images/btn/btn_clamp_r.gif"alt="다음" /></a>					
					</div>
				</div>
<script type="text/javascript">
	$(function(){
		$("#slider_area4").imageScroller({
			next:"btn4_1",                   //다음 버튼 ID값
			prev:"btn4_2",                   //이전 버튼 ID값
			frame:"scrollerFrame4",         //스크롤러 프레임 ID값 
			width:755,                     //이미지 가로 크기
			child:"li",                    //스크롤 지정 태그
			auto: false                      //오토 롤링 (해제는 false)
		});
	});
</script>
				<div id="category4" class="category hide">
					<h4>커뮤니티 체험</h4>
					<div id="slider_area4">
						<ul id="scrollerFrame4" class="scrollerFrame">
							<li class="item exp_first">
								<p class="title"><em>01.</em> 커뮤니티 개설</p>
								<p class="summary">보유하고 있는 솔루션, 컨설팅 서비스들을 회원분들과 자유롭게, 다양하게 커뮤니케이션을 할 수 있도록<br />클라우드스토어 씨앗 회원 분들이라면 누구나 개별 커뮤니티 공간을 제공해 드립니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/community_01.jpg" alt="" />
								</div>
							</li>
							<li class="item">
								<p class="title"><em>02.</em> 커뮤니티 가입</p>
								<p class="summary">커뮤니티 가입은 회원이면 누구나 가입하여 활동할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/community_02.jpg" alt="" />
								</div>
							</li>
							<li class="item">
								<p class="title"><em>03.</em> 커뮤니티 운영</p>
								<p class="summary">커뮤니티를 개설한 회원은 운영자로써 커뮤니티의 회원가입 승인 및<br />게시판 관리 등 카페의 모든 운영권한을 가지고 자유롭게 운영할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/community_03.jpg" alt="" />
								</div>
							</li>
						</ul>						
						<a href="#left" id="btn4_1" class="left" onclick="return false;"><img src="/resources/web/theme/default/images/btn/btn_clamp_l.gif" alt="이전" /></a>
						<a href="#right" id="btn4_2" class="right"onclick="return false;" style="position:absolute;top:248px;right:0;"><img src="/resources/web/theme/default/images/btn/btn_clamp_r.gif"alt="다음" /></a>					
					</div>
				</div>
				<div id="category5" class="category hide">
					<h4>커뮤니케이션 활동</h4>
					<div id="slider_area5">
						<ul class="scrollerFrame">
							<li>
								<p class="title"><em>01.</em> 커뮤니케이션 활동 영역</p>
								<p class="summary">클라우드스토어 씨앗의 회원이라면 지식 나눔 공간, 기술 및 산업동향, 입찰정보 등 다양한 정보를<br />얻을 수 있고 정보를 등록하여 공유할 수 있습니다.</p>
								<div class="img_area">
									<img src="/resources/web/theme/default/images/introduce/communication_01.jpg" alt="" />
								</div>
							</li>
						</ul>						
						<!-- a href="#none" class="left"><img src="/resources/web/theme/default/images/btn/btn_clamp_l.gif" alt="이전" /></a>
						<a hef="#none" class="right" style="position:absolute;top:248px;right:0;"><img src="/resources/web/theme/default/images/btn/btn_clamp_r.gif"alt="다음" /></a -->					
					</div>
				</div></body>
</html>