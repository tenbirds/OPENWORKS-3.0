<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title>[Main]</title> 
<c:set var="bennerLength" value="${fn:length(PopupZoneList)}"/>

<script type="text/javascript">
//<![CDATA[

    $().ready(function(){
    	
    	
    	//alert($("#board1023").val());
    	//alert($("#board1024").val());    	
    	
        if($("#PopupZoneCount").val() == ""){
            bennerLength  = 0;
        }else{
            bennerLength  = Number($("#PopupZoneCount").val());
            //팝업창이나 레이어 호출
            $.get("<c:url value="/korean/pt/popup/INC_popup.do" />",
                {},
                function(result){
                    $("body").append($(result));
                }
            );
        }
 
        var jsSetErrorPlacement = function(error, element){
			if(element.attr("name") == "userNm" || element.attr("name") == "email"){
			    error.prependTo($("#newsLetterErrorlabel"));
			} else {
				error.insertBefore(element);
			}
		};
		
		
    });
    
    var overMouse = true;
    var loop = 1; // 초기 팝업이미지 번호
    var bennerLength = <c:out value='${bennerLength}' />;
        bennerLength = Number(bennerLength);
    var bennerArray = new Array(bennerLength);

    var jsView = function(vl){
        $("#goodsCode").val(vl);
        document.dataForm.action = "/korean/pt/store/inc/BD_storeView.do?monarea=00004";
        document.dataForm.submit();
    };
    

    var doAjax = function (nodeEls) {
        
    	alert(nodeEls.board1024);
    	
        //var emptStr = '>>>>>';
        //var htmlStr = '<option value="">메뉴를 선택하여 주세요.</option>';
        //for (var i = 0; i < nodeEls.length; i++) {
            //htmlStr += '<option value="'+nodeEls[i].menuCd+'">'+emptStr.substring(1, nodeEls[i].menuLevel)+' '+nodeEls[i].menuNm+'</option>';
        //}
        //$('select[name=menuCd]').each(function () {
            //$(this).append(htmlStr);
        //});
    };    
    


//]]>
</script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post">
	<input type="hidden" name="q_currPage" id="q_currPage" />
	<input type="hidden" name="goodsCode" id="goodsCode" />
	<input type="hidden" name="ctgryCode" id="ctgryCode" />
	<input type="hidden" name="board1023" id="board1023" value="${board1023}"/>		
	<input type="hidden" name="board1024" id="board1024" value="${board1024}"/>		
</form>

	<!-- main slider -->
	<c:if test="${!empty PopupZoneList}">
	<c:set var="bennerLength" value="${fn:length(PopupZoneList)}"/>
	<article>		
		<div class="conWrap mainSliding">
			<ul class="slider_1">
			   <c:forEach items="${PopupZoneList}" var="_pZone" varStatus="pstatus">
				<li>
				<c:if test="${_pZone.linkUrl ne ''}">
				<a href="<c:out value='${_pZone.linkUrl}' />" title="<c:out value='${_pZone.imageAlt}' />"><img src="<c:out value='${_pZone.bannerFilePath}' />" alt="<c:out value='${_pZone.imageAlt}' />" /></a>
			    </c:if>
			    <c:if test="${_pZone.linkUrl eq ''}">
				<img src="<c:out value='${_pZone.bannerFilePath}' />" alt="<c:out value='${_pZone.imageAlt}' />" />
				</c:if>
				</li>
			   </c:forEach>
			</ul>
		</div>
	</article>
	</c:if>
	<!-- main slider -->


	<!-- 씨앗 현황 -->
	<article class="value_product">
		<div class="conWrap value_area">
			<!-- 협약기업 -->
			<dl class="value_bg" style="cursor:pointer;" onclick="location.href='/korean/pt/introduction/BD_index.do'">
				<dt class="txt_name">협약기업</dt>
				<dd><img src="/cloud_ver3/html_web/images/icon_value01.gif" width="25" height="27" alt="협약기업 수"/></dd>
				<dd class="txt_value">${frontInfo.agreement} <%-- <c:out value="${cntInfo.SUPPLY_CNT}"/>--%><span class="txt_value02"> 개</span></dd>
			</dl>
			<!-- 등록서비스 -->
			<dl class="value_bg"  style="cursor:pointer;" onclick="location.href='/korean/pt/store/software/BD_index.do?goodsTyCd=1002'">
				<dt class="txt_name">클라우드서비스</dt>
				<dd><img src="/cloud_ver3/html_web/images/icon_value02.gif" alt="클라우드서비스 수"/></dd>
				<dd class="txt_value"><c:out value="${cntInfo.GOOD_TOT}"/><span class="txt_value02"> 개</span></dd>
			</dl>
			<!-- 수요기관 -->
			<dl class="value_bg">
				<dt class="txt_name">수요기관</dt>
				<dd><img src="/cloud_ver3/html_web/images/icon_value03.gif" alt="수요기관 수"/></dd>
				<dd class="txt_value"><c:out value="${cntInfo.ORGAN_CNT}"/><span class="txt_value02"> 개</span></dd>
			</dl>
			<!-- 이용건수 및 이용금액 -->
			<div class="value_bg">
				<dl>
					<dt class="txt_name">이용계약건수</dt>
					<dd class="txt_value" style="margin-left:20px">${frontInfo.use_cnt}<%-- <c:out value="${cntInfo.CNT_AMT}"/> --%><span class="txt_value02"> 건</span></dd>
				</dl>
				<dl>
					<dt class="txt_name">이용계약금액</dt>
					<dd class="txt_value" style="margin-left:10px"><fmt:formatNumber value="${frontInfo.use_amt}" pattern="#,###" /><%-- <fmt:formatNumber value="${cntInfo.SPLY_AMT}" pattern="#,###" /> --%><span class="txt_value02"> 백만원</span></dd>
				</dl>
			</div>
			<!-- 씨앗통계 더보기 -->
			<div class="btn_analmore">
				<a href="/web/board/BD_board.view.do?domainCd=2&bbsCd=1026&bbscttSeq=${staticInfo}">
				<span class="mt5"><img src="/cloud_ver3/html_web/images/icon_analmore.png" width="33" height="24" alt="씨앗통계 더보기"/></span>
				<span>씨앗통계<br/>더보기</span>
				</a>
			</div>
			<!-- 이용실적증명서 발급 -->
			<div class="btn_analmore">
				<a href="/korean/pt/myCertif/BD_certifRequList.do" class="mr0">
					<span class=""><img src="/cloud_ver3/html_web/images/icon_issue.png" width="24" height="32" style="margin-top:0;" alt="이용실적 증명서발급 더보기"></span>
					<span class="fr">이용실적<br/>증명서발급</span>
				</a>
			</div> 
		</div>

		<div class="conWrap product_area">
		<span class="btn_move btn_prev" style="cursor: pointer;"><img src="/cloud_ver3/html_web/images/btn_prev.png" width="32" height="32" alt="서비스 좌측이동"></span>
		<ul class="thumb">
			<c:if test="${!empty newGoodsList}">
			<c:forEach items="${newGoodsList}" var="goods" varStatus="status">	
			<li class="product">
				<p><img src="/cloud_ver3/html_web/images/img_bar.gif" width="26" height="2" alt="<c:out value="${goods.goodsNm}" />"></p>
                <p><a style="cursor:pointer;" onclick="jsView('<c:out value='${goods.goodsCode}' />');"><c:out value="${goods.goodsNm}" /></a></p>
                <p><a style="cursor:pointer;" onclick="jsView('<c:out value='${goods.goodsCode}' />');"><c:out value="${fn:substring(goods.goodsSumry,0,72)}" /><c:if test="${fn:length(goods.goodsSumry) > 120}">... </c:if></a></p>
			</li>
			</c:forEach>
			</c:if>
		</ul>
		<span class="btn_move btn_next" style="cursor: pointer;"><img src="/cloud_ver3/html_web/images/btn_after.png" width="32" height="32" alt="서비스 우측이동"></span>
		</div>
	</article>

<!-- 매인배너(수요예보조사) -->
<!--
	<article>
		<div class="conWrap">
			<div class="bannerArea">
				<img src="/cloud_ver3/html_web/images/banner_main.png" alt="2019년 클라우드컴퓨팅 수요예보조사" usemap="#bannerMain">
				<map name="bannerMain" id="bannerMain">
					<area shape="rect" coords="214,185,422,215" href="/korean/pt/register/BD_dmandExamin.do" target="_self" alt="수요예보조사 참여" />
					<area shape="rect" coords="454,185,662,215" href="javascript:self.location.href='/component/file/ND_directDownload.do?fp=/upload/contents/2019YearGuide.pdf&fn=' + encodeURIComponent('2019년_수요예보조사_가이드.pdf');"" target="_blank" alt="수요예보조사 작성 매뉴얼" />
					<area shape="rect" coords="693,185,901,215" href="#none" target="_self" alt="자주묻는질문" />
				</map>
			</div>
		</div>
	</article>
-->
<!-- 최신게시물 -->
	<article>
		<div class="conWrap">
			<div class="boardWrap">
				<!--나라장터 입찰공고|수요기관 자체공고 , 정책동향|시장동향-->
				<div class="board">
					<ul>
						<li class="selectab">
							<a class="tab_title" href="#loc_board">나라장터 입찰공고</a>
							<ul class="bor_list">
								<c:forEach items="${bidInfoMainList}" var="bidMainList" varStatus="status">
									<li>
										<a href='http://www.g2b.go.kr:8081/ep/invitation/publish/bidInfoDtl.do?bidno=<c:out value="${bidMainList.bidNotifyNo}" />&bidseq=<c:out value="${bidMainList.bidNotifySeqNo}" />' target="_blank"><c:out value='${bidMainList.bidNm}' /></a>
										<span>
											<fmt:parseDate value='${bidMainList.bidEndDate}' var='bidEndDate' pattern="yyyy-MM-dd HH:mm" scope="page"/>
											<fmt:formatDate value="${bidEndDate}" pattern="yyyy.MM.dd"/>
										</span>
									</li>
								</c:forEach>
							</ul>
							<p class="more_btn"><a href="/korean/pt/g2b/bidInfo/BD_index.do"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="나라장터 입찰공고 더보기"></a></p>
						</li>
						<li class="borR0">
							<a class="tab_title" href="#loc_board">비즈매칭</a>
							<ul class="bor_list">
							<c:forEach items="${list1010}" var="list1010" varStatus="status">
								<li>
									<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${list1010.bbsCd}" />&amp;bbscttSeq=<c:out value="${list1010.bbscttSeq}" />&amp;monarea=00008"><c:out value='${list1010.bbscttSj}' /> </a>
									<c:if test="${list1010.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
									<span class="fr"><c:out value="${list1010.registDt}" /></span>
								</li>
							</c:forEach>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1010"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="비즈매칭 더보기"></a></p>
						</li>
					</ul>
				</div>
				<div class="board">
					<ul>
						<li class="${currDate1001}">
							<a class="tab_title" href="#loc_board">공지사항</a>
							<ul class="bor_list">
								<c:if test="${!empty noticeList}">
								<c:forEach items="${noticeList}" var="notice" varStatus="status">
								<li>
									<c:if test="${notice.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if><a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${notice.bbsCd}" />&amp;bbscttSeq=<c:out value="${notice.bbscttSeq}" />&amp;monarea=00008"><c:out value='${notice.bbscttSj}' /> </a>
									<span class="fr"><c:out value="${notice.registDt}" /></span>
								</li> 
								</c:forEach>
								</c:if>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1001"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="공지사항 더보기"></a></p>
						</li>
						<li class="${currDate1007}">
							<a class="tab_title" href="#loc_board">행사/세미나</a>
							<ul class="bor_list">
								<c:if test="${!empty eventList}">
								<c:forEach items="${eventList}" var="event" varStatus="status">						
								<li>
									<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${event.bbsCd}" />&amp;bbscttSeq=<c:out value="${event.bbscttSeq}" />&amp;monarea=00008"><c:out value='${event.bbscttSj}' /> </a>
									<c:if test="${event.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
									<span class="fr"><c:out value="${event.registDt}" /></span>								
								</li> 
								</c:forEach>
								</c:if>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1007"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="행사/세미나 더보기"></a></p>
						</li>
					</ul>		
				</div>
			</div>
			<div class="boardWrap borB_none">
				<!--공지사항|행사/세미나 , 씨앗블로그|자료실-->
				<div class="board">
					<ul>
						<li class="${currDate1023}">
							<a class="tab_title" href="#loc_board">정책동향</a>
							<ul class="bor_list">
								<c:forEach items="${list1023}" var="list1023" varStatus="status">
								<li>
								<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${list1023.bbsCd}" />&amp;bbscttSeq=<c:out value="${list1023.bbscttSeq}" />&amp;monarea=00008"><c:out value='${list1023.bbscttSj}' /> </a>
								<c:if test="${list1023.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
								<span class="fr"><c:out value="${list1023.registDt}" /></span>
								</li>
								</c:forEach>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1023"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="정책동향 더보기"></a></p>
						</li>
						<li class="${currDate1024}">
							<a class="tab_title" href="#loc_board">시장동향</a>
							
							<ul class="bor_list">
								<c:forEach items="${list1024}" var="list1024" varStatus="status">
								<li>
								<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${list1024.bbsCd}" />&amp;bbscttSeq=<c:out value="${list1024.bbscttSeq}" />&amp;monarea=00008"><c:out value='${list1024.bbscttSj}' /> </a>
								<c:if test="${list1024.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
								<span class="fr"><c:out value="${list1024.registDt}" /></span>
								</li>
								</c:forEach>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1024"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="시장동향 더보기"></a></p>
						</li>
					</ul>
				</div>

				<div class="board">
					<ul>
						<li class="${currDate1029}">
							<a class="tab_title" href="#loc_board">씨앗 블로그</a>
							<ul class="bor_list">
								<c:if test="${!empty list1029}">
								<c:forEach items="${list1029}" var="list1029" varStatus="status">
								<li>
									<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${list1029.bbsCd}" />&amp;bbscttSeq=<c:out value="${list1029.bbscttSeq}" />&amp;monarea=00008"><c:out value='${list1029.bbscttSj}' /> </a>
									<c:if test="${list1029.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
									<span class="fr"><c:out value="${list1029.registDt}" /></span>
								</li> 
								</c:forEach>
								</c:if>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1029"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="씨앗 블로그 더보기"></a></p>
						</li>
						<li class="${currDate1012}">
							<a class="tab_title" href="#loc_board">뉴스레터</a>
							<ul class="bor_list">
								<c:if test="${!empty list1012}">
								<c:forEach items="${list1012}" var="list1012" varStatus="status">
								<li>
									<a href="/web/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${list1012.bbsCd}" />&amp;bbscttSeq=<c:out value="${list1012.bbscttSeq}" />&amp;monarea=00008"><c:out value='${list1012.bbscttSj}' /> </a>
									<c:if test="${list1012.passDay <= 3}"><img src="/cloud_ver2/new_cloud/images/icn_new_2.png" alt="새글" /></c:if>
									<span class="fr"><c:out value="${list1012.registDt}" /></span>								
								</li> 
								</c:forEach>
								</c:if>
							</ul>
							<p class="more_btn"><a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1012"><img src="/cloud_ver3/html_web/images/icon_boardmore.gif" width="15" height="15" alt="뉴스레터 더보기"></a></p>
						</li>
					</ul>	
				</div>
			</div>
		</div>
	</article>
	<!--// 최신게시물 -->
	
	<!-- 이용절차 -->
	<article class="bgcolor_gray">
		<div class="conWrap">
			<!--이용절차-->
			<div class="borB_dot">
				<p class="bottom_title">이용절차</p>
				<ul class="in_txt">
					<li>서비스이용절차<a href="/kor/introduction/ompIntro/use_guide.jsp"><img src="/cloud_ver3/html_web/images/btn_go.png" width="70" height="14" alt="서비스이용절차 바로가기"></a></li>
					<li>클라우드 스토어 씨앗에서 서비스를 이용하기 위한 절차 안내</li>
				</ul> 
				<ul class="in_txt">
					<li>제공자 기본협약절차<a href="/kor/introduction/ompIntro/contract_guide.jsp"><img src="/cloud_ver3/html_web/images/btn_go.png" width="70" height="14" alt="제공자 기본협약절차 바로가기"></a></li>
					<li>클라우드 서비스 제공자와의 기본협약절차 안내</li>
				</ul>
				<ul class="in_txt mr0">
					<li>서비스제공절차<a href="/kor/introduction/ompIntro/support_guide.jsp"><img src="/cloud_ver3/html_web/images/btn_go.png" width="70" height="14" alt="서비스제공절차 바로가기"></a></li>
					<li>클라우드스토어 씨앗에서 서비스를 제공하기 위한 절차 안내</li>
				</ul>
			</div>
			<!--가이드라인-->	
			<div class="borB_dot borB0 borB_none">
				<p class="bottom_title">가이드라인</p>
				<p class="in_download">씨앗 이용자 매뉴얼<a href="/component/file/ND_directDownload.do?fp=/upload/contents/20180604_v.3.0.pdf&fn=클라우드스토어 씨앗 이용자 매뉴얼.pdf"><img src="/cloud_ver3/html_web/images/btn_download.png" alt="씨앗 이용자 매뉴얼 다운로드"></a></p> 
				<!-- <p class="in_download">이용자 가이드<a href="/component/file/ND_directDownload.do?fp=/resources/download/20170705_v.1.5.pdf&fn=씨앗 이용매뉴얼.pdf"><img src="/cloud_ver3/html_web/images/btn_download.png"></a></p> -->
				<p class="in_download">씨앗 제공자 매뉴얼<a href="/component/file/ND_directDownload.do?fp=/resources/download/0614_SupportGudie_v.0.1.pdf&fn=클라우드스토어 씨앗 제공자 매뉴얼.pdf"><img src="/cloud_ver3/html_web/images/btn_download.png" alt="씨앗 제공자 매뉴얼 다운로드"></a></p> 
				<p class="in_download">공공부문 클라우드서비스 유통 및 활용 가이드<a href="/component/file/ND_fileDownload.do?id=d2cc871d-7b62-46bc-9131-7aa8debea456"><img src="/cloud_ver3/html_web/images/btn_download.png" alt="공공부문 클라우드서비스 유통 및 활용 가이드 다운로드"></a></p> 
				<!-- <p class="in_download mr0">공공기관 민간 클라우드 이용가이드<a href="/component/file/ND_fileDownload.do?id=ca5442d7-fdbf-493a-9ca5-c2c7d3180604"><img src="/cloud_ver3/html_web/images/btn_download.png"></a></p> -->
			</div>
		</div>		
	</article>
	<!-- //이용절차 -->
	
	<!-- 기관 배너 -->
	<div class="conWrap">
		<div class="main_banner">
			<a href="http://www.nia.or.kr/" target="_blank"><img alt="한국정보화진흥원" src="/cloud_ver3/html_web/images/footer_logo1.jpg"></a>
			<a href="http://cpcp.ceart.kr/" target="_blank"><img alt="공공클라우드지원센터" src="/cloud_ver3/html_web/images/footer_logo2.jpg"></a>
			<!-- <a href="http://www.seart.kr/korean/pt/index.do" target="_blank"><img alt="SW스토어씨앗" src="/cloud_ver3/html_web/images/footer_logo3.jpg"></a> -->
			<a href="https://paas-ta.kr/" target="_blank"><img alt="Paas-TA" src="/cloud_ver3/html_web/images/footer_logo4.jpg"></a>
			<a href="http://www.msip.go.kr/web/main/main.do" target="_blank"><img alt="과학기술정보통신부" src="/cloud_ver3/html_web/images/footer_logo5.jpg"></a>
			<a href="http://shopping.g2b.go.kr" target="_blank"><img alt="나라장터 종합쇼핑몰" src="/cloud_ver3/html_web/images/footer_logo6.jpg"></a>
		</div>
	</div>
	<!-- // 기관 배너 -->
</body>
</html>