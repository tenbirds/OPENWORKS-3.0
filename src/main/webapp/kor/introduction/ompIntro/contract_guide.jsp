<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="ko">
 	<head>  
	  	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	  	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	  	<title></title>
	  	<style type="text/css">
				.borright {border-right:1px solid #ebebeb; height:40px;}
				#txt_center {text-align:center;}
				.txt_box p {line-height:30px;}
				.txt_blue {color:#0079c7; font-size:14px; font-weight:600;}
				.txt_orange a {color:#ec4f02; font-size:14px; font-weight:600;}
				.txt_indent20 {text-indent:20px}
				.btn_Tmore {display:inline-block; font-size:12px;  color:#fff; margin-left:8px; background-color:#999; padding:0px 10px; line-height:25px; text-align:center; border-radius:4px }
				.btn_Tmore:hover {text-decoration:none; background-color:#666;}	
				.txt_underline { font-size:14px; color:#1b81bc; font-weight:600; text-decoration:underline; }
				.txt_underline:hover {color:#00C; }		
				.down_area {width:100%;  height:56px;}
				.down_area dd {display:inline-block; width:33%; margin-bottom:10px;}
				.down_area dd a {display:inline-block; width:250px;  background-color:#37a8e9; padding:8px 10px; font-size:14px; font-weight:600; color:#fff; vertical-align:middle;}
				.down_area dd a:hover {text-decoration:none; background-color:#219ae0;}
				.down_area dd a span {float:right; margin-right:7px; }	
				.mb0 p {margin-bottom:0;}	
				.mb10 p {margin-bottom:10px;}		
				/*.intro h4 {margin-bottom:10;}*/
				.intro ul {margin-bottom:15px;}	
				.mt15 {margin-top:15px;}
				.txt_left {float:left; }
				.w216 {width:216px; margin-right:6px; }
				.w570 {width:570px; float:right;}
				.w570 p {font-size:14px; line-height:20px; letter-spacing:-1px}
				#mt40 {margin-top:10px;}
				#mt52 {margin-top:40px;}
				#mt60 {margin-top:40px;}				
				#mt68 {margin-top:65px;}
				#mt82 {margin-top:60px;}
				.pt30 {padding-top:30px !important;}
				.num_box {margin-right:8px;}
				.fs15 {font-size:15px}
				.fs16 {font-size:16px}
				.mb20{margin-bottom:20px; clear:both; overflow:hidden;}
				.ml30 {margin-left:30px;}
				.txt_b01 {display:inline-block; font-size:14px; padding-bottom:5px; width:70%;}					
				.txt_b02 {display:inline-block; font-size:14px; padding-left:20px;}
				.txt_b03 {display:inline-block; font-size:14px; padding-bottom:5px; width:80%;}	
				.txt_b04 {display:inline-block; font-size:14px; padding-bottom:5px; width:85%;}	
				.co_box {border:1px solid #d1d3d4; padding:8px 5px;}
				.co_box tr th {padding:5px 10px; }
				.co_box tr td {font-size:14px; font-weight:500; line-height:22px; padding:5px 10px 5px 0px; color:#000;}
				.mr10 {margin-right:10px;}
				.co_box_b {border-top:1px solid #d1d3d4; border-bottom:1px solid #d1d3d4; padding:24px 0 35px 0; position:relative; z-index:1; padding-left:125px;}
				.img_diagram {position:absolute; top:0; left:0; z-index:10; margin-top:24px;}
				.orange_box {border-radius:3px; padding:2px 6px 2px 7px; background-color:#f1640f; color:#fff; font:11px "돋움",Dotum,sans-serif; margin-right:5px;}
				.blue_box {border-radius:3px; padding:2px 6px 2px 7px; background-color:#3e85e5; color:#fff; font:11px "돋움",Dotum,sans-serif; margin-right:5px;}
				.co_box_b tr th {font-size:15px; color:#0d3d6a; background-color:#efefef; height:82px; border-radius:40px 0 0 40px; border:1px solid #d1d3d4; text-align:center; padding-left:70px; }
				.co_box_b tr td {background-color:#fff; border:1px solid #d1d3d4; border-left:none; padding-left:11px; font:13px "nanumgothic",Arial,"돋움",Dotum,sans-serif; line-height:20px; color:#333;}
				.mt7 {margin-top:7px;}
				.fs11 {font-size:11px; border:none;}
				.height100 {height:38px;}
				.txt_red {color:#d33505; line-height:13px;}
				.basic_table {border-left:1px solid #d1d3d4; border-top:1px solid #d1d3d4; width:330px;}
				.basic_table tr th {background-color:#efefef; height:45px; border-bottom:1px solid #d1d3d4; border-right:1px solid #d1d3d4; text-align:left; padding-left:10px; font-size:15px}
				.basic_table tr td {/*height:45px;*/ border-right:1px solid #d1d3d4; border-bottom:1px solid #d1d3d4; padding-left:6px; font-size:13px !important; line-height:16px; color:#333; padding-top:6px; padding-bottom:6px;}
				.fL {float:left;}
				.mr4 {margin-right:4px;}
				.mt14 {margin-top:14px;}
				.mr34 {margin-right:34px;}
				.in_inbox {display:block; border:1px solid #d1d3d4; font-size:14px; height:141px; width:330px; vertical-align:middle; padding:60px 10px 10px 14px; color:#333;}
				#no_bottom {border-bottom:none;}
				.txt_blue15 {color:#0d3d6a; font-size:15px}
				.fs14 {font-size:14px}
				.down_btn {border:1px solid #a7a9ac; display:inline-block; min-width:245px;}
				.down_btn dt {float:left;}
				.down_btn dd {float:left; font-size:14px; height:56px; line-height:56px; margin-left:10px; color:#333;}
				/* .down_btn dd:last-child {float:right; margin:0 6px 0 0; padding-top:20px;} */
				.down_btn dd.btn_download {float:right; margin:0 6px 0 10px; padding-bottom:20px;}
				.bullet_position {margin:0 5px 0 7px;}
				.bullet_position img {margin-top:-2px;}
            </style>
 	</head>

 	<body>
 				
		  <div class="intro supContract ">
				<h3>기본협약 개념 </h3>
				<!--h4>기본협약이란?</h4-->
				<p style="text-indent:13px">
					클라우드스토어 씨앗을 통해 공공기관에 클라우드서비스를 제공하려는 기업을 대상으로 제공자의 자격, 의무, 서비스 제공절차 등 <br />운영규정, 정보보호 등을 규정한 협약서로 한국정보화진흥원의 심사를 통해 협약체결 자격이 부여되어 이용자에게 서비스와 제공기업의<br /> 신뢰성 보장을 목적으로 합니다. 
                </p>
				<h4>특징</h4>
				<p><img src="/images/img_agreement03.jpg" width="100%" alt="특징" /></p>
                
				<h3>협약체결 방법</h3>
        <table class="co_box" summary="협약체결 방법">
        <caption>협약체결 방법</caption>
          <colgroup>
          	<col width="40px" />
            <col width="*" />
          </colgroup>
          <thead style="display: none;">
          	<tr>
          		<th colspan="2"></th>
          	</tr>
          </thead>
          <tbody>
	          <tr>
	            <th><img src="/images/icon_num01.png" width="27" height="27" alt="기본협약은 차수(次數)가 존재하며 협약의 체결은 시행중인 차수나 차기 차수를 선택하여 협약을 체결합니다."/></th>
	            <td>기본협약은 차수(次數)가 존재하며 협약의 체결은 시행중인 차수나 차기 차수를 선택하여 협약을 체결합니다.</td>
	          </tr>
	          <tr>
	            <th><img src="/images/icon_num02.png" width="27" height="27" alt="기본협약을 체결하였어도 차기 차수에 서비스를 제공하려면 차기 차수의 협약을 추가 체결하여야 합니다." /></th>
	            <td>기본협약을 체결하였어도 차기 차수에 서비스를 제공하려면 차기 차수의 협약을 추가 체결하여야 합니다.</td>
	          </tr>
	          <tr>
	            <th><img src="/images/icon_num03.png" width="27" height="27" alt="한국정보화진흥원은 발효중인 협약에 대해 연장선언을 할 수 있습니다. 이 경우 연장선언된 협약은 제공자와 별도의 협약 수정절차 없이 종료시점이 자동 연장됩니다." /></th>
	            <td>한국정보화진흥원은 발효중인 협약에 대해 연장선언을 할 수 있습니다. <br />이 경우 연장선언된 협약은 제공자와 별도의 협약 수정절차 없이 종료시점이 자동 연장됩니다.</td>
	          </tr>
	          <tr>
	            <th><img src="/images/icon_num04.png" width="27" height="27" alt="협약 개시일 이후에도 한국정보화진흥원이 인정하는 경우 새로운 제공자와 협약을 체결할 수 있습니다. 협약 개시일 이후 체결된 협약도 해당 차수의 종료일이 적용됩니다." /></th>
	            <td>협약 개시일 이후에도 한국정보화진흥원이 인정하는 경우 새로운 제공자와 협약을 체결할 수 있습니다.<br />협약 개시일 이후 체결된 협약도 해당 차수의 종료일이 적용됩니다.</td>
	          </tr>
          </tbody>
          <tfoot style="display: none;">
          	<tr>
          		<th colspan="2"></th>
          	</tr>
          </tfoot>
        </table>
        
        <h3 class="mt30">협약 차수 개념도</h3>
   	    <img src="/images/img_agreement02.jpg" width="794" height="304" alt="협약 차수 개념도" />
   	    <h3 class="mt30">협약체결 세부절차</h3>
				<div class="co_box_b">
        	<table border="0" cellspacing="0" cellpadding="0" class="round_table" summary="협약체결 세부절차">
        	<caption>협약체결 세부절차</caption>
          	<colgroup>
            	<col width="186px" />
              <col width="*" />
            </colgroup>
            <thead style="display: none;">
            	<tr>
            		<th colspan="2"></th>
            	</tr>
            </thead>
            <tbody>
	            <tr>
	            	<th>서류 준비</th>
	              <td>날인된 기본협약서와 구비서류(필수, 선택)를 PDF파일로 준비합니다
	              	<div class="fs11 mt5" style="color:#333;"><span class="orange_box">필수</span>등기부등본사본, 기업신용평가등급확인서, 최근 3년 기업재무제표</div>
	                <div class="fs11" style="color:#333;"><span class="blue_box">선택</span>벤처기업인증서, 직접생산증명서, 인증정보에 대한 인증서 (해당 서류가 있는 경우만 제출)</div>
	              </td>
	            </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
          </table>
          <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="제공권한 신청">
          <caption>제공권한 신청</caption>
            <colgroup>
            	<col width="186px" />
              <col width="*" />
            </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
            <tr>
              <th>제공권한 신청</th>
              <td>클라우드스토어 씨앗에 회원 가입 후 제공권한을 신청합니다.</td>
            </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
          </table> 
          <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="사업자 인증">
          	<caption>사업자 인증</caption>
          	<colgroup>
            	<col width="186px" />
               <col width="*" />
            </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
	          	<tr>
	            	<th>사업자 인증</th>
	              <td>사업자 인증 후 제공권한 신청이 시작됩니다. </td>
	            </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table>  
           
           <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="서류 제출">
           <caption>서류 제출</caption>
             <colgroup>
             	<col width="186px" />
               <col width="*" />
             </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
             <tr>
               <th>서류 제출</th>
               <td>서류준비단계에서 준비한 날인된 기본협약서와 구비서류를 온라인으로 제출합니다</td>
             </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table> 

           <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="자격심사">
           <caption>자격심사</caption>
             <colgroup>
             	<col width="186px" />
               <col width="*" />
             </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
             <tr>
               <th>자격심사</th>
               <td>제출된 서류에 따라 심사진행(업무일 기준 5일)하며, 자격미달시 협약체결이 거부되고 제공권한이 부여되지 않습니다. 필요 시 서류보완을 요청할 수 있습니다.
                 <div class="fs11 txt_red mt5">
                 	<span class="bullet_position">
                 		<img src="/images/bullet_tray.gif" width="4" height="7" alt="자격미달로 협약체결이 거부된 신청자는 자격 보완 후 재 신청할 수 있습니다."/>
                 	</span>자격미달로 협약체결이 거부된 신청자는 자격 보완 후 재 신청할 수 있습니다.
                 </div>
                </td>
             </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table>
           <div class="height100"></div>
           <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="협약승인">
           <caption>협약승인</caption>
           	<colgroup>
            	<col width="186px" />
              <col width="*" />
            </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
             <tr>
               <th>협약승인</th>
               <td>서류심사를 통과한 기업에 기본협약승인 후 확정협약서를 시스템에 등록해 드립니다.</td>
             </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table> 
           <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="체결완료">
           <caption>체결완료</caption>
             <colgroup>
             	<col width="186px" />
               <col width="*" />
             </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
             <tr>
               <th>체결완료</th>
               <td>기본협약체결이 완료되면 유선 또는 e-mail로 협약체결 완료를 안내합니다.<br /> 제공자는 통보 접수 후 서비스 등록 및 판매를 진행할 수 있습니다</td>
             </tr>
             </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table>                                                              
           <table border="0" cellspacing="0" cellpadding="0" class="round_table mt7" summary="등록/판매">
           <caption>등록/판매</caption>
             <colgroup>
             	<col width="186px" />
               <col width="*" />
             </colgroup>
            <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
            <tbody>
             <tr>
               <th>서비스<br />등록/판매</th>
               <td>제공자격 획득 후 제공하려는 서비스를 등록/판매합니다</td>
             </tr>
            </tbody>
            <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
           </table>
           <span class="img_diagram"><img src="/images/img_diagram03.png" width="215" height="759" alt="반려" /></span>	
         </div>
         <h3 class="pt30" style="clear:both; overflow:hidden;">기본협약서 작성방법</h3>
         	<dl class="fL mr34">
          	<dt class="txt_blue fs16"><span class="num_box"><img src="/images/num_box01.png" width="21" height="21" style="margin-top:-6px;" alt="1.표지작성"/></span>표지작성</dt>
            <dd class="fL mr4 mt14"><img src="/images/subject01.jpg" width="112" height="148" alt="표지샘플"/></dd>
            <dd class="fL mt14">
              <table border="0" cellspacing="0" cellpadding="0" class="basic_table" summary="표지작성">
              <caption>표지작성</caption>
              	<colgroup>
                	<col width="90px" />
                  <col width="*" />
                </colgroup>
                <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
                <tbody>
	                <tr>
	                  <th>제공업체명</th>
	                  <td>사업자등록증상 회사명 기입</td>
	                </tr>
	                <tr>
	                  <th>협약일</th>
	                  <td>협약서를 제출하는 날짜 기입</td>
	                </tr>
	              </tbody>
	              <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
              </table>
            </dd>
          </dl>
          <dl class="fL">
          	<dt class="txt_blue fs16"><span class="num_box"><img src="/images/num_box02.png" width="21" height="21" style="margin-top:-6px;" alt="2.계약서 정보 작성" /></span>계약서 정보 작성</dt>
            	<dd class="fL mr4 mt14"><img src="/images/subject02.jpg" width="111" height="139" alt="계약정보 샘플"/></dd>
              <dd class="fL mt14">
              	<table border="0" cellspacing="0" cellpadding="0" class="basic_table" summary="계약서 정보 작성">
              	<caption>계약서 정보 작성</caption>
                	<colgroup>
                		<col width="90px" />
                		<col width="*" />
                	</colgroup>
	                <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
	                <tbody>
                      <tr>
                        <th>회사</th>
                        <td>사업자등록증상 회사명 기입</td>
                      </tr>
                      <tr>
                        <th>대표자명</th>
                        <td>사업자등록증상 대표자명 기입</td>
                      </tr>
                      <tr>
                        <th>사업자번호</th>
                        <td>사업자번호</td>
                      </tr>
                      <tr>
                        <th>제공자인</th>
                        <td style="line-height:20px;">
                        	법인인감<br />
                        	<span class="txt_red fs11">
                        		<span class="bullet_position" style="margin:0 4px 0 5px; letter-spacing:-1px" >
                        			<img src="/images/bullet_tray.gif" width="4" height="7" alt="계약시 사용인감을 사용하는 경우"/></span>계약시 사용인감을 사용하는 경우는</br>
                        		</span>
                        		<span class="txt_red fs11" style="margin-left:12px;">사용인감 날인</span>
                        </td>
                      </tr>
                  </tbody>
                  <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
                </table>
              </dd>
            </dl> 
            
            <dl class="fL mr34 mt30">
            	<dt class="txt_blue fs16"><span class="num_box"><img src="/images/num_box03.png" width="21" height="21" style="margin-top:-6px;" alt="간인 작성"/></span>간인 작성</dt>
                <dd class="fL mr4 mt14"><img src="/images/subject03.jpg" alt="협약서를 상하로 접어 우측에 간인 날인"/></dd>
                <dd class="fL mt14 in_inbox">협약서를 상하로 접어 우측에 간인 날인</dd>
            </dl>
            
            
            <dl class="fL mt30">
            	<dt class="txt_blue fs16">
            		<span class="num_box"><img src="/images/num_box04.png" width="21" height="21" style="margin-top:-6px;" alt="협약서 제출" /></span>협약서 제출
            	</dt>
              <dd class="fL mr4 mt14"><img src="/images/subject04.jpg" alt="제공자가 날인한 협약서를 1열 pdf파일로 변환하여 클라우드스토어 씨앗 제공권한 신청시 온라인 제출" /></dd>
              <dd class="fL mt14 in_inbox" style=" padding:40px 10px 10px 14px;">제공자가 날인한 협약서를 1열 pdf파일로 변환하여 클라우드스토어 씨앗 제공권한 신청시 온라인 제출</dd>
            </dl>
            <h3 class="pt30" style="clear:both; overflow:hidden;">첨부서류</h3>
            <table border="0" cellspacing="0" cellpadding="0" class="basic_table" style="width:100%; border-left:none;" summary="첨부서류">
            <caption>첨부서류</caption>
            	<colgroup>
              	<col width="150px" />
                <col width="*" />
              </colgroup>
              <thead style="display: none;"><tr><th colspan="2"></th></tr></thead>
	            <tbody>
	              <tr>
	                <th rowspan="2" id="txt_center" class="txt_blue15" style="background-color:#f9f9f9; padding-left:0;">필수서류</th>
	                <td id="no_bottom" style="border-right:none; font-size:14px; line-height:18px; padding:15px 0 0 14px; letter-spacing:-0.5px">
	                	법인등기부등본 1부, 기업신용평가등급확인서 1부, 최근 3년 기업재무제표 1부 <br />(모든 문서는 PDF 파일로 제출)
	                </td>
	              </tr>
	              <tr>
	                <td style="border-right:none; padding:13px 0 17px 14px;">
	                	<span class="txt_red"  style="font-size:13px">
	                		<span class="bullet_position" style="margin:0 6px 0 10px;" ><img src="/images/bullet_tray.gif" width="4" height="7" alt="법인설립 후 1년 미만 등의 사유로 재무제표 미발행시 ‘가재무제표’ 제출" /></span>법인설립 후 1년 미만 등의 사유로 재무제표 미발행시 ‘가재무제표’ 제출
	                		</span>
	               	</td>
	              </tr>
	              <tr>
	                <th rowspan="3" id="txt_center" class="txt_blue15" style="background-color:#f9f9f9; padding-left:0;">선택서류</th>
	                <td id="no_bottom" style="border-right:none; font-size:14px; line-height:18px; padding:15px 0 0 14px; letter-spacing:-0.5px">
	                	벤처기업인증서, 직접생산증명서, CC인증, 클라우드보안인증, GS인증 등 각 인증정보에 대한 인증서 각 1부<br />(모든 문서는 PDF 파일로 제출)
	                </td>
	              </tr>
	              <tr>
	                <td style="border-right:none; border-bottom:none; padding:8px 0 6px 14px;">
	                	<span class="txt_red" style="font-size:13px">
	                		<span class="bullet_position" style="margin:0 6px 0 10px; letter-spacing:-1px" ><img src="/images/bullet_tray.gif" width="4" height="7" alt="선택 서류는 해당 업체가 보유하고 제출이 필요하다고 판단되는 경우 제출합니다."/></span>선택 서류는 해당 업체가 보유하고 제출이 필요하다고 판단되는 경우 제출합니다.
	                	</span>
	                </td>
	              </tr>
	              <tr>
	                <td style="border-right:none;  padding:0px 0 12px 14px;">
	                	<span class="txt_red"  style="font-size:13px;">
	                		<span class="bullet_position" style="margin:0 6px 0 10px; " ><img src="/images/bullet_tray.gif" width="4" height="7" alt="제공하려는 클라우드서비스에 대한 인증자료는 해당 클라우드서비스 등록 시 제출할 수 있습니다."/></span>제공하려는 클라우드서비스에 대한 인증자료는 해당 클라우드서비스 등록 시 제출할 수 있습니다.
	                	</span>
	                </td>
	              </tr>
              </tbody>
              <tfoot style="display: none;"><tr><th colspan="2"></th></tr></tfoot>
            </table>
						<h3 class="mt30">관련문서</h3>
            <dl class="down_btn">
            	<dt><img src="/images/icon_docu08.png" alt="관련문서"/></dt>
                <dd>기본협약서 양식</dd>
                <%--/component/file/ND_fileDownload.do?id=0a25b492-4fb1-409e-9872-b8746b309a6e --%>
                <dd class="btn_download"><a href="/resources/download/Agreement2.hwp"><img src="/images/btn_download.jpg" width="63" height="16" alt="관련문서 다운로드"/></a></dd>
            </dl>
		<!-- contents -->	
	  </div>	
	</body>
</html>