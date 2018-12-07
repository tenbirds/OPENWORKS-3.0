<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="zes.core.utils.Converter"%>
<html lang="ko">
 	<head>  
	  	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	  	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	  	<title></title>
	  	<style type="text/css">
				.lay_lnb .conWrap > div {padding-top:26px;}
				.txt_box p {line-height:30px;}

				.txt_orange {color:#ec4f02; font-size:14px; font-weight:600;}
				.txt_indent20 {text-indent:20px; float:left;}
				.btn_Tmore {display:inline-block; font-size:12px;  color:#fff; margin-left:8px; background-color:#999; padding:0px 10px; line-height:25px; text-align:center; border-radius:4px }
				.btn_Tmore:hover {text-decoration:none; background-color:#666;}
				.down_area {display:inline-block; margin-right:22px; }
				.down_area a:hover {text-decoration:none;}
				.down_area p {display:inline-block; float:left;}
				.down_area p:last-child {background-color:#eeeeee; height:64px; width:177px;}
				.down_area a:hover p:last-child {background-color:#e5e5e5;}
				.down_area p:last-child span {display:inline-block; font-size:13px; padding-left:12px; padding-top:22px;}
				#line2txt {line-height:20px; padding-top:12px; }
				#width305 a {width:305px;}
				.down_area dd a span {float:right; margin-right:7px; }
				<!-- 스타일 추가및수정 6월27일-->
				.txt_b05 {display:inline-block; font-size:14px; width:72%; padding-left:5px; padding-top:5px;}
				.txt_b06 {display:inline-block; font-size:14px; width:86%; padding-left:5px;}
				.txt_b07 {font-size:14px;}
				.txt_blue {color:#0079c7; font-size:14px; font-weight:600; padding-right:10px; float:left;}
				.basic_table {border-left:1px solid #d1d3d4; border-top:1px solid #d1d3d4; width:262px;}
				.basic_table tr th {background-color:#efefef; height:45px; border-bottom:1px solid #d1d3d4; border-right:1px solid #d1d3d4; text-align:left; padding-left:8px; font-size:15px}
				.basic_table tr td {height:45px; border-right:1px solid #d1d3d4; border-bottom:1px solid #d1d3d4; padding-left:10px; font:14px "nanumgothic",Arial,"돋움",Dotum,sans-serif; line-height:24px; color:#333;}
				.fL {float:left;}
				.mr4 {margin-right:4px;}
				.mt14 {margin-top:14px;}
				.mr34 {margin-right:34px;}
				.in_inbox {display:block; border:1px solid #d1d3d4; font-size:14px; height:141px; width:260px; vertical-align:middle; padding:10px;}
				#no_bottom {border-bottom:none;}
				.txt_blue15 {color:#0d3d6a; font-size:15px}
				#txt_center {text-align:center;}
				.fs14 {font-size:14px}
				.txt_red {color:#d33505;}
				.btn_detail a {display:inline-block; border:1px solid #a7a9ac; border-radius:2px; background-color:#e0e0e0; font:11px "돋움",Dotum,sans-serif; padding:3px 7px; float:right; margin-top:4px; text-decoration:none; margin-right:10px;}
				.btn_detail a:hover {background-color:#c8c8c8;}
				.down_btn {border:1px solid #a7a9ac; display:inline-block; min-width:245px; margin-right:23px;}
				.down_btn dt {float:left;}
				.down_btn dd {float:left; font-size:14px; height:56px; line-height:56px; margin-left:10px; color:#333;}
				/* .down_btn dd:last-child {float:right; margin:0 6px 0 10px; padding-top:20px;} */
				.down_btn dd.btn_download {float:right; margin:0 6px 0 10px; padding-bottom:20px;}
				.basic_table tr th img {margin-left:9px;}
				.w180 {width:180px; font-size:14px; color:#333; border:1px solid red;}
				
						.deco_bl {display:table; margin-bottom:10px; }
						.deco_bl dt, .deco_bl dd {display:table-cell; font-size:14px; color:#333;}
						.deco_bl dt img {margin-right:3px;}
						.deco_bl dd {line-height:18px;}
						
						/*1017수정*/.down_btn {border:1px solid #a7a9ac; display:inline-block; min-width:253px; margin-right:3px;}
            </style>
      <script type="text/javascript">
		var jsBizPop = function(el) {
			$(el).colorbox({
				title : "비즈매칭",
				href : "/kor/introduction/ompIntro/intro_consumer_counsel.jsp",
				 width : "830",
				height : "750",
				overlayClose : false,
				escKey : false,
				iframe : true
			});
		};

		var jsCertiPop= function(el) {
			$(el).colorbox({
				title : "증명서발급",
				href : "/kor/introduction/ompIntro/intro_certi.jsp",
				width : "830",
				height : "750",
				overlayClose : false,
				escKey : false,
				iframe : true
			});
		};
    </script>
 	</head>

 	<body>
 		<div class="intro contract">
    <h3>클라우드서비스 이용절차</h3>
    	<p><img src="/images/img_diagram01.png" alt="클라우드서비스 이용절차" /></p>
    	<h3>이용절차 설명</h3>
    	<table border="0" cellspacing="0" cellpadding="0" class="basic_table" style="width:100%; border-left:none;" summary="이용절차 설명">
    	<caption>이용절차 설명</caption>
	      <colgroup>
	      	<col width="30px"/>
	        <col width="150px"/>
	        <col width="*"/>
	      </colgroup>
	      <thead style="display: none;"><tr><th colspan="3"></th></tr></thead>
	      <tbody>
	      	<tr>
	        	<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;">
	          	<img src="/images/icon_num01.png" width="27" height="27" alt="01"/></th>
	          <th class="txt_blue15" style="background-color:#f9f9f9;">회원가입(로그인)</th>
	          <td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">민간기업 및 개인은 일반회원으로, 정부(부처) 및 공공기관은 공공회원으로 가입합니다.</td>
	        </tr>
	        <tr>
	        	<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
	          	<img src="/images/icon_num02.png" width="27" height="27" alt="02"/>
	          </th>
	          <th class="txt_blue15" style="background-color:#f9f9f9;">서비스검색 및 비교</th>
	          <td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">서비스카테고리 브라우징이나 검색, 필터 기능을 이용하여 서비스를 검색합니다. 하단의 ‘서비스비교 담기’ 를<br/>클릭하여 서비스별 사양을 비교합니다.</td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;">
	           	<img src="/images/icon_num03.png" width="27" height="27" alt="03"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9;">이용희망목록 저장</th>
	           <td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">사업명을 선택 또는 생성하여 선택한 서비스를 이용희망목록에 저장합니다.</td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none; ">
	           	<img src="/images/icon_num04.png" width="27" height="27" alt="04"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9;">서비스 선정 및<br/>이용계약체결</th>
	           <td class="fs15" style="border-right:none; padding:15px 0 10px 15px;">
	           		이용계약은 이용자와 제공자 간 직접 체결하며, 씨앗은 다음과 같은 계약 지원 기능을 제공합니다.
	           		<ol>
	           			<li>(1) 견적요청 : 이용희망목록에 있는 서비스에 대한 견적요청을 통해 견적서에 근거한 계약체결 지원</li>
	           			<li>(2) 수요공고 : 수요기관의 납품조건을 상세화하여 공고할 수 있도록, 수요 공고기능을 제공 <p class="fs11 txt_red ml20">(* 전자조달시스템 공지 대상인 경우 씨앗에 병행 공고 가능하지만, 전자조달시스템을 대체하지는 못함)</p></li>
	           			<li>(3) 지명공고 : 2개 이상의 공급자를 지명하여 경쟁입찰 할 수 있는 기능 지원</li>
	           			<li>(4) 나라장터 종합쇼핑몰 연계 : 씨앗과 나라장터 종합쇼핑몰에 동시 등록된 서비스 연계 구매 가능</li>
	           		</ol>
	           </td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;">
	           	<img src="/images/icon_num05.png" width="27" height="27" alt="05"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9;">계약결과 등록</th>
	           <td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">이용자는 서비스이용 계약을 체결한 후 '마이씨앗 > 계약결과관리' 에서 계약결과를 등록합니다.</td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
	           	<img src="/images/icon_num06.png" width="27" height="27" alt="06"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9; ">서비스 이용</th>
	           <td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">이용 계약한 클라우드서비스를 계약기간 동안 이용합니다.</td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
	           	<img src="/images/icon_num07.png" width="27" height="27" alt="07"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9; ">이용실적증명 발급신청</th>
	           <td class="fs15" style="border-right:none; padding:25px 0 25px 15px; letter-spacing:-0.3px">
	           	공공기관은 계약 완료된 클라우드서비스 이용 건에 대해 '마이씨앗 > 이용실적 증명 신청 관리' 에서<br/>민간 클라우드 이용실적 증명서 발급을 신청할 수 있습니다.
	           	<span class="btn_detail"><a href="#" style="margin-right:23px;"  onclick="jsCertiPop(this); return false;">자세히보기</a></span>
	           </td>
	         </tr>
	         <tr>
	           <th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
	           	<img src="/images/icon_num08.png" width="27" height="27" alt="08"/>
	           </th>
	           <th class="txt_blue15" style="background-color:#f9f9f9; ">비즈매칭</th>
	           <td class="fs15" style="border-right:none; padding:25px 0 25px 15px; letter-spacing:-0.5px">
	           	클라우드스토어 씨앗에서 원하는 서비스를 찾지 못했거나, 어떤 서비스를 선택해야 할지 모르는 경우<br/>비즈매칭 서비스를 이용하여 다수의 제공자에게 서비스 추천을 요청할 수 있습니다.
	           	<span class="btn_detail" ><a href="#" style="margin-right:23px;" onclick="jsBizPop(this); return false;">자세히보기</a></span> 
	           </td>
	         </tr>
	         </tbody>
	         <tfoot style="display: none;"><tr><th colspan="3"></th></tr></tfoot>
	       </table>
                <h3 class="mt30" >관련문서</h3>
                <dl class="down_btn">
                	<dt><img src="/images/icon_docu08.png" alt="관련문서"/></dt>
                    <dd>씨앗 이용자 매뉴얼</dd>
                    <dd class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/upload/contents/20180604_v.3.0.pdf&fn=씨앗 이용자 매뉴얼.pdf"><img src="/images/btn_download.jpg" width="63" height="16" alt="씨앗 이용자 매뉴얼 다운로드"/></a></dd>
                </dl>
<!--                 
                <dl class="down_btn" style="margin-right:0;">
                    <dt><img src="/images/icon_docu08.png" alt="관련문서"/></dt>
                    <dd style="line-height:15px; padding-top:6px;">공공기관<br/>민간클라우드 이용<br/>가이드(행정안전부)</dd>
                    <dd class="btn_download"><a href="/component/file/ND_fileDownload.do?id=ca5442d7-fdbf-493a-9ca5-c2c7d3180604"><img src="/images/btn_download.jpg" width="63" height="16" alt="공공기관 민간클라우드 이용 가이드(행정안전부) 다운로드"/></a></dd>
                </dl>
 -->                
                <dl class="down_btn" style="margin-right:0;">
                	<dt><img src="/images/icon_docu08.png" alt="관련문서"/></dt>
                    <!--1017수정--><dd style="line-height:15px; padding-top:6px;">공공부문 클라우드서비스<br/>유통 및 활용 가이드라인<br/>(과학기술정보통신부)</dd>
                    <!--다운로드 버튼 수정--><dd class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/resources/download/Public_sector_cloud_service_distribution_and_utilization_guidelines_2017.pdf&fn=공공부문 클라우드서비스 유통 및 활용 가이드라인.pdf"><img src="/images/btn_download.jpg" width="63" height="16" alt="공공부문 클라우드서비스 유통 및 활용 가이드라인 (과학기술정보통신부) 다운로드"/></a></dd>
                </dl> 
<!--            
     			<dl class="down_btn" id="doc">
                    <dt><img src="/images/icon_docu08.png"></dt>
                    <dd style="line-height:15px; padding-top:6px;">공공부문<br/>클라우드서비스<br/>가입이용지침(씨앗)</dd>
                    <dd class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/upload/contents/20171017-useguide.pdf&fn=공공부문클라우드서비스가입이용지침.pdf"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
                </dl> 
-->
			</div>
<script> 	
<% String str = Converter.XSS(request.getParameter("link"));
 if ( str != null && str.equals("doc") )  {  %>
 $().ready(function(){
  	$(document).scrollTop($('#doc').offset().top);
  });
<% } %>
</script> 
	</body>
</html>