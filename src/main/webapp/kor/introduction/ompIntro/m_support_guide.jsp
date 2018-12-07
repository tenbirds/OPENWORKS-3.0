<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="zes.core.utils.Converter"%>
<html lang="ko">
 	<head>  
	  	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	  	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	  	<title>클라우드서비스 등록ㆍ제공 절차</title>
	  	<style type="text/css">
	  		img {max-width:100%; height:auto}
				.intro {position:relative;} 
				.txt_box p {line-height:30px;}

				.txt_orange {color:#ec4f02; font-size:14px; font-weight:600;}
				.txt_indent20 {text-indent:20px}
				.btn_Tmore {display:inline-block; font-size:12px;  color:#fff; margin-left:8px; background-color:#999; padding:0px 10px; line-height:25px; text-align:center; border-radius:4px }
				.btn_Tmore:hover {text-decoration:none; background-color:#666;}	
				.txt_underline {text-decoration:underline; font-size:15px; color:#1b81bc;}		
				.down_area {display:inline-block; margin-right:22px; height:64px; margin-bottom:12px;}
				.down_area a:hover {text-decoration:none;}
				.down_area p {display:inline-block; float:left;}
				.down_area p:last-child {background-color:#eeeeee; height:64px; width:177px;}
				.down_area a:hover p:last-child {background-color:#e5e5e5;}
				.down_area p:last-child span {display:inline-block; font-size:13px; padding-left:12px; padding-top:22px;}
				#line2txt {line-height:20px; padding-top:12px; }
				.mr0 {margin-right:0;}	
				
				<!-- 스타일 추가및수정 6월27일-->
				.txt_b05 {display:inline-block; font-size:14px; width:72%; padding-left:5px; padding-top:5px;}	
				.txt_b06 {display:inline-block; font-size:14px; width:86%; padding-left:5px;}
				.txt_b07 {font-size:14px;}		
				.txt_b08 {display:inline-block; font-size:14px; width:72%; padding-left:5px;}	
				.txt_blue {color:#0079c7; font-size:14px; font-weight:600; padding-right:10px; float:left;}	
				
				.basic_table {border-left:1px solid #d1d3d4; border-top:1px solid #d1d3d4; width:262px;}
				.basic_table tr th {background-color:#efefef; height:45px; border-bottom:1px solid #d1d3d4; border-right:1px solid #d1d3d4; text-align:left; padding-left:8px; font-size:15px}
				.basic_table tr td {/*height:45px;*/ border-right:1px solid #d1d3d4; border-bottom:1px solid #d1d3d4; padding-left:6px; font-size:14px; line-height:18px; color:#333; padding-top:6px; padding-bottom:6px; color:#333;}
				
				.btn_detail a { display:inline-block; border:1px solid #a7a9ac; border-radius:2px; background-color:#e0e0e0; font:11px "돋움",Dotum,sans-serif; padding:3px 7px; float:right; text-decoration:none; margin-right:10px;}
				.btn_detail a:hover {background-color:#c8c8c8;}
				
				.down_btn {border:1px solid #a7a9ac; display:inline-block; min-width:253px; margin-right:13px;}
				.down_btn dt {float:left;}
				.down_btn dd {float:left; font-size:13px; height:56px; line-height:56px; margin-left:10px; color:#333;}
				/* .down_btn dd:last-child {float:right; margin:0 6px 0 10px; padding-top:20px;} */
				.down_btn dd.btn_download {float:right; margin:0 6px 0 10px; padding-bottom:20px;}
				
				.basic_table tr th img {margin-left:9px;}
				.txt_blue15 {color:#0d3d6a; font-size:15px}
						
				.deco_bl {display:table; margin-bottom:10px; }
				.deco_bl dt, .deco_bl dd {display:table-cell; font-size:14px; color:#333;}
				.deco_bl dt img {margin-right:3px;}
				.deco_bl dd {line-height:18px;}
			</style>
			
	<script type="text/javascript">
		 var jsBizPop = function(el) {
	        $(el).colorbox({
	            title : "비즈매칭",
	            href : "/kor/introduction/ompIntro/intro_supply_counsel.jsp",
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
			<h3>클라우드서비스 등록ㆍ제공 절차</h3>
			<p class="mt10"><img src="/images/img_diagram02.png"></p>
			<h3>제공절차 설명</h3>
			<table border="0" cellspacing="0" cellpadding="0" class="basic_table" style="width:100%; border-left:none;">
			<colgroup>
				<col width="30px">
				<col width="140px">
				<col width="*">
			</colgroup>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;">
				<img src="/images/icon_num01.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9;">제공권한 신청</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">민간기업 및 개인은 일반회원으로, 정부(부처), 공공기관은 공공회원으로 가입한 후 제공권한을 신청합니다.</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
				<img src="/images/icon_num02.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9;">사업자 인증</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">사업자 인증을 이용하여 제공자 기본 검증을 진행합니다.</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
				<img src="/images/icon_num03.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9;">기본협약체결</th>
				<td class="fs15" style="border-right:none; padding:15px 0 15px 15px;">
					한국정보화진흥원과 서비스제공자 간 기본협약 체결을 위한 협약서 및 구비서류(필수서류)를 등록합니다.
					<p class="fs11">(자세한 협약절차는 ‘기본협약절차’를 참고해 주시기 바랍니다.)</p>
				</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none; ">
					<img src="/images/icon_num04.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9;">서비스 등록</th>
				<td class="fs15" style="border-right:none; padding:15px 0 15px 15px;">
					기본협약 체결 후 ‘제공자씨앗 > 제공서비스관리 > 서비스 등록’ 메뉴에서 제공할 서비스 정보를 등록합니다.
					<p class="fs11">(서비스 일반정보, 상세정보, 규격정보, 제공자 정보, 가격표 등 서비스 등록비용은 무료입니다.)</p>
				</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
					<img src="/images/icon_num05.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9;">서비스승인 및 전시</th>
				<td style="border-right:none; padding:15px 0 15px 15px;">
					<dl class="deco_bl">
						<dt><img src="/images/table_bullet.jpg" width="3" height="3">&nbsp;</dt>
						<dd>등록한 서비스는 씨앗운영단 검토와, 한국정보화진흥원의 승인 후 전시됩니다.</dd>
					</dl>
					<dl class="deco_bl">
						<dt><img src="/images/table_bullet.jpg" width="3" height="3">&nbsp;</dt>
						<dd>서비스 수요기관과 제공자간 직접 계약체결 후 계약내용에 따라 서비스를 제공합니다.</dd>
					</dl>
					<dl class="deco_bl">
						<dt><img src="/images/table_bullet.jpg" width="3" height="3">&nbsp;</dt>
						<dd>수요기관은 이용희망목록 견적요청과 공고 등을 통해 서비스 상세 내용을 요청합니다.</dd>
					</dl>
					<dl class="deco_bl">
						<dt><img src="/images/table_bullet.jpg" width="3" height="3">&nbsp;</dt>
						<dd>수요기관과 제공기업간 서비스 제공계약을 체결한 후 별도의 합의가 없는 한 서비스 등록시 제시한 기간 내에<br/>서비스를 제공합니다.</dd>
					</dl>
					<dl class="deco_bl">
						<dt><img src="/images/table_bullet.jpg" width="3" height="3">&nbsp;</dt>
						<dd>이용자가 요청한 상세옵션 내용 중 제공자가 제공하기로 한 규격 이상의 것을 요청한 경우 거부 가능합니다.</dd>
					</dl>
				</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
					<img src="/images/icon_num06.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9; ">계약결과 등록</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">제공자는 서비스 제공 계약을 체결한 후 ‘제공자씨앗 > 제공현황’에 계약결과를 등록합니다.</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
				<img src="/images/icon_num07.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9; ">서비스홍보</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">서비스 판매를 위해 클라우드스토어 씨앗 고객센터로 별도 홍보요청을 할 수 있습니다.</td>
			</tr>
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
				<img src="/images/icon_num08.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9; ">추가ID생성</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">사업자등록번호당 1개의 마스터 ID가 부여되며, 추가 사용자 ID의 관리는 제공자씨앗 > 마스터/서브관리를 통해<br/>등록할 수 있습니다.</td>
			</tr> 
			<tr>
				<th class="txt_blue15" style="background-color:#f9f9f9; border-right:none;  ">
				<img src="/images/icon_num09.png" width="27" height="27"></th>
				<th class="txt_blue15" style="background-color:#f9f9f9; ">비즈매칭</th>
				<td class="fs15" style="border-right:none; padding:25px 0 25px 15px;">수요기관에서 요구한 서비스를 보유한 경우, 서비스를 제안할 수 있습니다.<span class="btn_detail"><a href="#" onclick="jsBizPop(this); return false;">자세히보기</a></span></td>
			</tr>
			</table>
			<h3 class="mt30">관련문서</h3>
			<dl class="down_btn">
				<dt><img src="/images/icon_docu08.png"></dt>
				<dd>기본협약서 양식</dd>
				<%--/component/file/ND_fileDownload.do?id=0a25b492-4fb1-409e-9872-b8746b309a6e --%>
				<dd  class="btn_download"><a href="/resources/download/Agreement2.hwp"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
			</dl>
			<dl class="down_btn">
				<dt><img src="/images/icon_docu08.png"></dt>
				<dd>씨앗 제공자 매뉴얼</dd>
				<dd  class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/resources/download/0614_SupportGudie_v.0.1.pdf&fn=클라우드스토어 씨앗 제공자 매뉴얼.pdf"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
			</dl>    
			<dl class="down_btn" style="margin-right:0;">
				<dt><img src="/images/icon_docu08.png"></dt>
				<dd>서비스규격 양식</dd>
				<dd  class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/resources/download/SpecSample.xlsx&fn=서비스규격 양식.xlsx"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
			</dl>
			<dl class="down_btn" style="margin-top:7px;">
				<dt><img src="/images/icon_docu08.png"></dt>
				<dd>서비스가격표 양식</dd>
				<dd  class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/resources/download/0606_StandardPrice.hwp&fn=%ED%81%B4%EB%9D%BC%EC%9A%B0%EB%93%9C%EC%84%9C%EB%B9%84%EC%8A%A4%20%EA%B0%80%EA%B2%A9%ED%91%9C%20%EC%96%91%EC%8B%9D.hwp"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
			</dl> 
			<dl class="down_btn"  id="doc" style="margin-right:0; margin-top:7px;">
				<dt><img src="/images/icon_docu08.png"></dt>
				<dd>표준계약서 양식</dd>
				<dd  class="btn_download"><a href="/component/file/ND_directDownload.do?fp=/upload/contents/standard_contract.zip&fn=표준계약서.zip"><img src="/images/btn_download.jpg" width="63" height="16"></a></dd>
			</dl> 
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