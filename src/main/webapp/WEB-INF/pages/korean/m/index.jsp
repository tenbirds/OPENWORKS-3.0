<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<op:jsTag type="spi" items="form,validate" />
<title>[Main]</title>
<script defer src="/new_cloud_m/js/jquery.flexslider.js"></script>
<link rel="stylesheet" href="/new_cloud_m/css/flexslider.css" type="text/css" media="screen" />
<script type="text/javascript">
//<![CDATA[
    $(window).load(function() {
        /* $('.flexslider').flexslider({
            animation: "slide"
          }); */
        $('.flexslider_2').flexslider({
            animation: "slide",
            animationLoop: false,
            itemWidth: 250,
            minItems: 2,
            maxItems: 2        
          });
    });

    var jsView = function(domainCd,bbsCd,bbscttSeq,registPassword,othbcAt){
        $("#domainCd").val(domainCd);
        $("#bbsCd").val(bbsCd);
        $("#bbscttSeq").val(bbscttSeq);
        $("#registPassword").val(registPassword);
        $("#othbcAt").val(othbcAt);
        document.viewForm.action = "/korean/m/board/BD_board.view.do";
        document.viewForm.submit();
    };
    var jsGoosView = function(goodsCode,goodsKndCd){
        $("#goodsCode").val(goodsCode);
        $("#goodsTyCd").val(goodsKndCd);
        document.dataForm.action = "/korean/m/store/software/BD_view.do";
        document.dataForm.submit();
    };
    
    var jsTabSelect = function(tabNm, num) {
        $("div[id*=" + tabNm + "]").hide();
          $("div[id=" + tabNm + num + "]").show();  
    };
    
    var tab1pg = "1";
    var tab2pg = "1";
    
    var jsTabPage = function(tabNum, tabNm, page) {
        if(eval('tab' + tabNum + 'pg') == page){
           alert('마지막페이지 입니다.');
           } else {
               $("ul[id*=" + tabNm + "]").hide();
              $("ul[id=" + tabNm + page + "]").show();
              if(tabNum == '1') {tab1pg = page;}
              if(tabNum == '2') {tab2pg = page;}
           }
    };
    
    
    
    $(function() {	
    	//main > 슬라이더
    	$('.btn_prev').on('click',function(){
    		$('.thumb li:first')
    			.appendTo('.thumb')
    	});
    	$('.btn_next').on('click',function(){
    		$('.thumb li:last')
    			.prependTo('.thumb')
    	});

    	//main > board
    	$('.board ul > li > a').on('click',function(){
    		$(this).parent().addClass('selectab');
    		$(this).parent().siblings('li').removeClass('selectab');
    		$('.selectab > .more_btn').css('display','block');
    	});
    	
    	//sub > tab
    	$('.tab_con').eq(0).css('display','block').siblings('.tab_con').css('display','none');
        $('.tab_st01 li').eq(0).addClass('on').siblings().removeClass('on');
        $('.tab_st01 li').on('click', function() {
           this.idx = $(this).index();
           $('.tab_st01 li').removeClass('on');
           $(this).addClass("on");
           $('.tab_con').css('display','none');
           $('.tab_con').eq(this.idx).css('display','block');
           return false;
        });
    });



    
//]]>
</script>
</head>
<body>
	<form name="dataForm" id="dataForm" method="post">
	    <input type="hidden" name="goodsCode" id="goodsCode" />
	    <input type="hidden" name="goodsTyCd" id="goodsTyCd"/>
	    <input type="hidden" name="ctgryPath" id="ctgryPath" value="0"/>
	    <input type="hidden" name="_pathLang" id="_pathLang" value="korean"/>
	</form>
	<form name="viewForm" id="viewForm" method="post" >
	    <input name="domainCd" id="domainCd" type="hidden">
	    <input name="bbsCd" id="bbsCd" type="hidden">
	    <input name="bbscttSeq" id="bbscttSeq" type="hidden">
	    <input name="registPassword" id="registPassword" type="hidden">
	    <input name="othbcAt" id="othbcAt"type="hidden">
	</form> 
	<div id="container">
		<article class="value_product">
			<div class="value_area">
			<!-- 협약기업 -->
				<div class="value_bg">
					<dl>
						<dt class="txt_name">협약기업</dt>
						<dd class="txt_value">${frontInfo.agreement} <%-- <c:out value="${cntInfo.SUPPLY_CNT}"/>--%></dd>
					</dl>
				</div>
			<!-- 등록서비스 -->
				<div class="value_bg">
					<dl>
						<dt class="txt_name">등록서비스</dt>
						<dd class="txt_value">${cntInfo.GOOD_TOT}</dd>
					</dl>
				</div>
			<!-- 수요기관 -->
				<div class="value_bg mg0">
					<dl>
						<dt class="txt_name">수요기관</dt>
						<dd class="txt_value"><!-- 860 -->${cntInfo.ORGAN_CNT}</dd>
					</dl>
				<!-- <img src="/cloud_ver3/html_m/images/icon_value03.gif" width="20" height="20"> -->
				</div>
			<!-- 이용건수 -->
				<div class="value_bg">
					<dl>
						<dt class="txt_name">이용건수</dt>
						<dd class="txt_value">${frontInfo.use_cnt}</dd>
					</dl>
					<dl>
						<dt class="txt_name">이용금액</dt>
						<dd class="txt_value"><fmt:formatNumber value="${frontInfo.use_amt}" pattern="#,###" /><%-- <fmt:formatNumber value="${cntInfo.SPLY_AMT}" type="NUMBER" groupingUsed="true" /> --%> 백만원</dd>
					</dl>
				</div>
			<!-- 씨앗통계 더보기 -->
				<div class="btn_analmore">
					<c:forEach items="${staticList}" var="notice" varStatus="status">
						<c:if test="${status.first}">	                
			      	<a href="#" onclick="jsView('<c:out value='${notice.domainCd}'/>','<c:out value='${notice.bbsCd}'/>', '<c:out value='${notice.bbscttSeq}'/>', '', ''); return false;">씨앗통계<br />더보기</a> 
			      </c:if>				
					</c:forEach>				
				</div>
			</div>
		
			<div class="product_area">
				<a href="#none" class="btn_move btn_prev"><img src="/cloud_ver3/html_m/images/btn_prev.png"></a>
					<ul class="thumb">
						<c:if test="${!empty newTop10List}">
            	<c:forEach items="${newTop10List}" var="goods" varStatus="status">    
              <li class="product">
              	<p><a href="javascript:;" onclick="jsGoosView('<c:out value='${goods.goodsCode}' />','<c:out value='${goods.goodsKndCd}' />');"><c:out value="${goods.goodsNm}" /></a></p>
              	<p>${goods.goodsSumry}</p>
              </li>
              </c:forEach>
            </c:if>
					</ul>
					<a href="#none" class="btn_move btn_next"><img src="/cloud_ver3/html_m/images/btn_after.png"></a>
			</div>
		</article>

    <section class="board">
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
          <!-- <a href="#" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a> -->
        </li>
      </ul>
    </section>
    <section class="board">
        <ul>
            <li class="selectab">
                <a class="tab_title" href="#loc_board">공지사항</a>
                <ul class="bor_list">
                    <c:forEach items="${noticeList}" var="notice" varStatus="status">
                    <li>
                        <a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${notice.bbsCd}" />&amp;bbscttSeq=<c:out value="${notice.bbscttSeq}" />&amp;monarea=00008"><c:out value='${notice.bbscttSj}' /></a>
                        <span><c:out value="${notice.registDt}" /></span>
                    </li>
                    </c:forEach>
                    <c:if test="${empty noticeList}">
                    <li>등록된 정보가 없습니다.</li>
                    </c:if>
                </ul>
                <a href="/korean/m/board/BD_board.list.do?domainCd=2&amp;bbsCd=1001&amp;monarea=00008" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
            </li>
            <li><a class="tab_title" href="#loc_board">행사/세미나</a>
                <ul class="bor_list">
                    <c:forEach items="${eventList}" var="event" varStatus="status">
                    <li>
                        <a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${event.bbsCd}" />&amp;bbscttSeq=<c:out value="${event.bbscttSeq}" />&amp;monarea=00008"><c:out value='${event.bbscttSj}' /> </a>
                        <span class="fr"><c:out value="${event.registDt}" /></span>                                         
                    </li> 
                    </c:forEach>
                    <c:if test="${empty eventList}">
                    <li>등록된 정보가 없습니다.</li>
                    </c:if>
                </ul>
                <a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1007" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
            </li>
        </ul>
	</section>
	<section class="board">
		<ul>
			<li class="selectab">
                <a class="tab_title" href="#loc_board">정책동향</a>
				<ul class="bor_list">
					<c:forEach items="${policyList}" var="policy" varStatus="status">                                
		                <li>
		                	<a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${policy.bbsCd}" />&amp;bbscttSeq=<c:out value="${policy.bbscttSeq}" />&amp;monarea=00008"><c:out value='${policy.bbscttSj}' /></a>
                            <span><c:out value="${policy.registDt}" /></span>
		                </li>                    
		            </c:forEach>
                    <c:if test="${empty policyList}">
                    <li>등록된 정보가 없습니다.</li>
                    </c:if>
            	</ul>
				<a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1023" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
			</li>
			<li>
      	<a class="tab_title" href="#loc_board">시장동향</a>
        	<ul class="bor_list">
          	<c:forEach items="${marketList}" var="market" varStatus="status">
            <li>
            	<a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${market.bbsCd}" />&amp;bbscttSeq=<c:out value="${market.bbscttSeq}" />&amp;monarea=00008"><c:out value='${market.bbscttSj}' /></a>
              <span><c:out value="${market.registDt}" /></span>
            </li> 
            </c:forEach>
            <c:if test="${empty marketList}">
            	<li>등록된 정보가 없습니다.</li>
            </c:if>
        	</ul>
      	<a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1024" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
      </li>
		</ul>
	</section>
	<section class="board">
     <ul>
         <li class="selectab">
             <a class="tab_title" href="#loc_board">씨앗 블로그</a>
             <ul class="bor_list">
                 <c:forEach items="${ceartblogList}" var="ceartblog" varStatus="status">                                
                     <li>
                         <a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${ceartblog.bbsCd}" />&amp;bbscttSeq=<c:out value="${ceartblog.bbscttSeq}" />&amp;monarea=00008"><c:out value='${ceartblog.bbscttSj}' /></a>
                         <span><c:out value="${ceartblog.registDt}" /></span>
                     </li>                    
                 </c:forEach>
                 <c:if test="${empty ceartblogList}">
                 <li>등록된 정보가 없습니다.</li>
                 </c:if>
             </ul>
             <a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1029" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
         </li>
         <li>
             <a class="tab_title" href="#loc_board">뉴스레터</a>
             <ul class="bor_list">
                 <c:forEach items="${newsletterList}" var="newsletter" varStatus="status">
                     <li>
                         <a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${newsletter.bbsCd}" />&amp;bbscttSeq=<c:out value="${newsletter.bbscttSeq}" />&amp;monarea=00008"><c:out value='${newsletter.bbscttSj}' /></a>
                         <span><c:out value="${newsletter.registDt}" /></span>
                     </li> 
                 </c:forEach>
                 <c:if test="${empty newsletterList}">
                 <li>등록된 정보가 없습니다.</li>
                 </c:if>
             </ul>
             <a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1012" class="more_btn"><img src="/cloud_ver3/html_m/images/icon_boardmore.png" /></a>
         </li>
     </ul>   
	</section>
	
	<article class="guide_area">
		<!--이용절차-->
		<div class="sub_area">
			<p class="tit_guide">이용절차</p>
			<ul>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/kor/introduction/ompIntro/m_use_guide.jsp'">서비스이용절차<a href="/kor/introduction/ompIntro/m_use_guide.jsp" class="btn_go"></a></li>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/kor/introduction/ompIntro/m_contract_guide.jsp'">제공자 기본협약절차<a href="/kor/introduction/ompIntro/m_contract_guide.jsp" class="btn_go"></a></li>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/kor/introduction/ompIntro/m_support_guide.jsp'">서비스제공절차<a href="/kor/introduction/ompIntro/m_support_guide.jsp" class="btn_go"></a></li>
			</ul>
		</div>
		<!--가이드라인-->
		<div class="sub_area">
			<p class="tit_guide">가이드라인</p>
			<ul>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/upload/contents/ceart_user_manual_v.3.0.pdf;'">씨앗 이용자 매뉴얼<a href="/upload/contents/ceart_user_manual_v.3.0.pdf"  class="btn_down"></a></li>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/resources/download/ceart_supplier_manual_v.0.1.pdf;'">씨앗 제공자 매뉴얼<a href="/resources/download/ceart_supplier_manual_v.0.1.pdf" class="btn_down"></a></li>
				<li style="cursor: pointer;" onmousedown="javascript:location.href='/upload/board/2016/10/7/cloud_distribution_guide.pdf;'">공공부문 클라우드서비스<br/>유통 및 활용 가이드<a href="/upload/board/2016/10/7/cloud_distribution_guide.pdf" class="btn_down"></a></li>
				<!-- <li style="cursor: pointer;" onmousedown="javascript:location.href='/files/private_cloud_use_guide.pdf;'">공공기관 민간 클라우드 이용가이드<a href="/files/private_cloud_use_guide.pdf" class="btn_down"></a></li> -->
			</ul>
		</div>
	</article>
	
	</div>    
            
            
            
            

        <!-- container -->
        <div id="container">

            <!-- contents -->
            <div class="contents">
               
                <!-- 클라우드 조달 -->
                <div class="section">
                    <div class="box success">
                       <%-- 
                        <h2>
                            클라우드 조달
                            <a href="http://law.go.kr/lsSc.do?menuId=0&p1=&submenu=1&nwYn=1&section=&tabNo=&query=%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C%EC%BB%B4%ED%93%A8%ED%8C%85%20%EB%B0%9C%EC%A0%84%20%EB%B0%8F%20%EC%9D%B4%EC%9A%A9%EC%9E%90%20%EB%B3%B4%ED%98%B8%EC%97%90%20%EA%B4%80%ED%95%9C%20%EB%B2%95%EB%A5%A0#undefined" target="_blank" class="underline">법률보기 +</a>
                        </h2>
                        <div class="section law">
                            <h3>클라우드컴퓨팅 발전 및 이용자 보호에 관한 법률</h3>
                            <ul>
                            <li> 제12조 (국가기관 등 클라우드 도입 촉진)
                                <ol>
                                <li>① 국가기관등은 클라우드컴퓨팅을 도입하도록 노력하여야 한다.</li>
                                <li>② 정부는 「국가정보화 기본법」에 따른 국가정보화 정책이나 사업 추진에 필요한 예산을 편성할 때에는 클라우드컴퓨팅 도입을 우선적으로 고려하여야 한다.</li>
                                </ol>
                            </li>
                            <li>제20조(공공기관의 클라우드컴퓨팅서비스 이용 촉진)
                                <ol>
                                <li>① 정부는 공공기관이 업무를 위하여 클라우드컴퓨팅서비스 제공자의 클라우드 컴퓨팅서비스를 이용할 수 있도록 노력하여야 한다.</li>
                                </ol>
                            </li>
                            </ul>
                        </div>
                        <!-- 모바일 메인 화면 -->
                        <div class="section traits">
                            <h3>클라우드스토어 씨앗 특징<a href="/mob/introduction/ompIntro/ompIntroduction.jsp" class="underline">더보기 +</a></h3>
                            <ul>
                            <li><span>국내 최다 클라우드서비스 정보제공</span></li>
                            <li><span>다양한 이용 방식 지원</span></li>
                            <li><span>이용컨설팅, 모니터링, 이용증빙 제공</span></li>
                            <li><span>공공부분 13,000여개 대상 종합 홍보창구</span></li>
                            <li><span>제공자 등록에서 서비스 전시까지 모든 절차 무료</span></li>
                            <li><span>서비스 제공, Q&A, 계약까지 통합 접점 채널 제공</span></li>
                            </ul>
                        </div>
                        
                            <div class="section lastest">
                                <h3>클라우드 정책동향<a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1023" class="underline">더보기 +</a></h3>
                                <dl>
                                <c:forEach items="${policyList}" var="policy" varStatus="status">                                
                                     <a href="javaScript:" onclick="jsView('<c:out value='${policy.domainCd}'/>','<c:out value='${policy.bbsCd}'/>', '<c:out value='${policy.bbscttSeq}'/>', '<c:out value='${policy.registPassword}'/>', '<c:out value='${policy.othbcAt}'/>'); return false;">
                                         <dt><b>${fn:substring(policy.bbscttSj,0,55)} <c:if test="${fn:length(policy.bbscttSj) > 55}">...</c:if></b></dt>
                                        <dd>${fn:substring(policy.bbscttCn,0,150)}<c:if test="${fn:length(policy.bbscttCn) > 150}">...</c:if><dd>
                                        <dd><c:out value="${policy.cnSumry}" /></dd>
                                    </a>
                                </c:forEach>
                                
                                </dl>
                            </div>

                        <div class="section lastest">
                            <h3>클라우드 시장동향<a href="/korean/m/board/BD_board.list.do?domainCd=2&bbsCd=1024" class="underline">더보기 +</a></h3>
                            <dl>
                            <c:forEach items="${marketList}" var="market" varStatus="status">
                                <a href="javaScript:" onclick="jsView('<c:out value='${market.domainCd}'/>','<c:out value='${market.bbsCd}'/>', '<c:out value='${market.bbscttSeq}'/>', '<c:out value='${market.registPassword}'/>', '<c:out value='${market.othbcAt}'/>'); return false;">
                                    <dt><b>${fn:substring(market.bbscttSj,0,55)} <c:if test="${fn:length(market.bbscttSj) > 55}">...</c:if></b></dt>
                                    <dd><c:out value="${market.cnSumry}" /></dd>
                                </a>
                            </c:forEach>
                            </dl>
                        </div>                        
                        <div class="section notice">
                            <h3>공지사항<a href="/korean/m/board/BD_board.list.do?domainCd=2&amp;bbsCd=1001&amp;monarea=00008" class="underline">더보기 +</a></h3>
                            <table>
                                <c:forEach items="${noticeList}" var="notice" varStatus="status">
                                <tr>
                                    <td><a href="/korean/m/board/BD_board.view.do?domainCd=2&amp;bbsCd=<c:out value="${notice.bbsCd}" />&amp;bbscttSeq=<c:out value="${notice.bbscttSeq}" />&amp;monarea=00008"><c:out value='${notice.bbscttSj}' /></a></td>
                                    <td><c:out value="${notice.registDt}" /></td>
                                </tr>
                                </c:forEach>
                                <c:if test="${empty noticeList}">
                                <tr>
                                    <td colspan="2">등록된 정보가 없습니다.</td>
                                </tr>
                                </c:if>
                            </table>
                            <ul>
                                
                            </ul>
                        </div> --%>                        
                    </div>
                </div>
                <!-- //클라우드 조달 -->
            </div>
            <!-- //contents -->
        </div>
        <!-- //container -->
</body>
</html>