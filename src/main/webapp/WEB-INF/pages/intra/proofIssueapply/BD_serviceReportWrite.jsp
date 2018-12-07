<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    
    <title></title>
	<style>
		ul{list-style:none;}


		.wrap{
			background-image: url(/cloud_ver2/new_cloud/images/ceartResultImage01.png);
			background-size: auto 100%;
			background-repeat: no-repeat;
			padding:18%;
			width: 740px;
		  	height: 1040px;
		  	margin:0 auto;
		}
		.txt_title{
			font-size: 18pt;
			margin-bottom: 60pt;
			text-align: center;
		}
		.txt_01{
			margin-bottom: 20pt;
			font-size: 12pt;
			font-weight: bold;
			line-height: 1.8;
		}
		.content0{
			margin-top:-185px;
            margin-left:-95px;
			font-size:22pt;
			text-align: left;
			font-weight:bold;
		}
		.content1{
			margin-top:268px;
            margin-left:0%;
			font-size:22pt;
			text-align: left;
			font-weight:bold;
		}
		.content2{
			margin-top:18px;
            margin-left:92px;
			font-size:22pt;
			text-align: left;
			font-weight:bold;
		}
		.content_table{
			width: 900px;
			margin-top:65px;
            margin-left:-153px;
			border-color:#ccc;
			font-size:10pt;
			text-align: center;
		}

		.content3{
			margin-top:-278px;
            margin-left:720px;
			font-size:22pt;
			text-align: left;
			font-weight:bold;
		}


		.content_table tr td{
			padding: 2px 0;
		}
		.content_table th, .content_table tfoot{
			background-color: #b4d8ff;
		}
		.txt_02{
			position: absolute;
			left:50%;
			bottom: 25%;
			width: 450px;
			margin-left: -225px;
			text-align: center;
			font-size: 12pt;
		}
		.txt_03{
			position: absolute;
			left: 50%;
			bottom: 20%;
			width: 170px;
			margin-left: 140px;
			font-size:10pt;
		}
		.txt_04{
			position: absolute;
			left: 50%;
			bottom: 5%;
			width: 450px;
			margin-left:-225px;
			font-size:18pt;
			font-weight:bold;
			text-align: center;
		}
		.img_watermark{
			position: absolute;
			top:50%;
			left:50%;
			margin-top:-113px;
			margin-left: -113px;
		}
	</style>
</head>
<body>
	<page size="A4">

		<div class="wrap">
			<div class="content0">
				&nbsp;
			</div>
			<div class="content1">
				${proofIssueapply.organNm}
			</div>
			<div class="content2">
				2018년 10월 01일 ~ 2018년 10월 31일 
			</div>
			<table class="content_table" border="1" cellpadding="0" cellspacing="0">
				<caption>이용내역</caption>
				<colgroup>
					<col width="5%" height="40px">
					<col width="30%">
					<col width="10%">
					<col width="5%">
					<col width="10%">
					<col width="10%">
					<col width="5%">
					<col width="10%">
					<col width="15%">
				</colgroup>
				<thead>
					<tr>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>번호</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>클라우드서비스명</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>서비스구분</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>단위</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>계약개시일</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>계약종료일</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>수량</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>납품금액(원)</b></th>
						<td scope='col' height="25x" style="text-align:center;background-color: #b4d8ff;"><b>공급자</b></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td scope='row' style="text-align:center;" height="23"><b>1</b></td>
						<td><b>차세대 업무환경 NiCloud</b></td>
						<td style="text-align:center;"><b>SaaS</b></td>
						<td style="text-align:center;"><b>-</b></td>
						<td style="text-align:center;"><b>2017-07-01</b></td>
						<td style="text-align:center;"><b>2018-06-30</b></td>
						<td style="text-align:center;"><b>1</b></td>
						<td style="text-align:right;"><b>6,600,000</b></td>
						<td><b>한국정보화진흥원</b></td>
					</tr>
					<tr>
						<td scope='row' style="text-align:center;" height="23"><b>2</b></td>
						<td><b>차세대 업무환경 NiCloud</b></td>
						<td style="text-align:center;"><b>SaaS</b></td>
						<td style="text-align:center;"><b>-</b></td>
						<td style="text-align:center;"><b>2017-07-01</b></td>
						<td style="text-align:center;"><b>2018-06-30</b></td>
						<td style="text-align:center;"><b>1</b></td>
						<td style="text-align:right;"><b>6,600,000</b></td>
						<td><b>한국정보화진흥원</b></td>
					</tr>
					<tr>
						<td scope='row' style="text-align:center;" height="23"><b>3</b></td>
						<td><b>차세대 업무환경 NiCloud</b></td>
						<td style="text-align:center;"><b>SaaS</b></td>
						<td style="text-align:center;"><b>-</b></td>
						<td style="text-align:center;"><b>2017-07-01</b></td>
						<td style="text-align:center;"><b>2018-06-30</b></td>
						<td style="text-align:center;"><b>1</b></td>
						<td style="text-align:right;"><b>6,600,000</b></td>
						<td><b>한국정보화진흥원</b></td>
					</tr>
					<tr>
						<td scope='row' style="text-align:center;" height="23"><b>4</b></td>
						<td><b>차세대 업무환경 NiCloud</b></td>
						<td style="text-align:center;"><b>SaaS</b></td>
						<td style="text-align:center;"><b>-</b></td>
						<td style="text-align:center;"><b>2017-07-01</b></td>
						<td style="text-align:center;"><b>2018-06-30</b></td>
						<td style="text-align:center;"><b>1</b></td>
						<td style="text-align:right;"><b>6,600,000</b></td>
						<td><b>한국정보화진흥원</b></td>
					</tr>

				</tbody>
				<tfoot>
					<tr>
						<td colspan="6" style="text-align:right; font-weight:bold;" height="25">합 계&nbsp;</td>
						<td colspan="3" style="text-align:right; font-weight:bold;">29,609,280 &nbsp;</td>
					</tr>
				</tfoot>
			</table>
			
		</div>
		<div class="content3">
			2018년 10월 01일 
		</div>
	</page>
</body>
</html>