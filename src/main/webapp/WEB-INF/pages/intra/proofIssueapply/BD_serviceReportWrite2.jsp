<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%
	Calendar cal = Calendar.getInstance();

	String year = Integer.toString(cal.get(Calendar.YEAR));
	String month = Integer.toString(cal.get(Calendar.MONTH)+1);
	String date = Integer.toString(cal.get(Calendar.DATE));

	String todayDate =  year + "년 " + month + "월 " + date + "일";
	
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    
    <title></title>
	<style>
		ul{list-style:none;}


		.wrap{
			background-image: url(/cloud_ver2/new_cloud/images/ceartResultImage02.png);
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
			margin-top:261px;
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
			margin-top:90px;
            margin-left:-153px;
			border-color:#ccc;
			font-size:10pt;
			text-align: center;
		}

		.content3{
			margin-top:-283px;
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
						<td scope='col' height="45x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">번호</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">클라우드서비스명</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">서비스구분</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">단위</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">계약개시일</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">계약종료일</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">수량</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">납품금액(원)</td>
						<td scope='col' height="25x" style="text-align:center;font-weight:bold;background-color: #b4d8ff; font-size:16px;">공급자</td>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${serviceReportWrite}" var="baseVo" varStatus="status">
					<tr>
						<td scope='row' style="text-align:center; font-size:14px;" height="40"><b>${status.index+1}</b></td>
						<td style="text-align:left; font-size:14px;"><b>${baseVo.svcNm}</b></td>
						<td style="text-align:center; font-size:14px;"><b>${baseVo.goodsKndCd}</b></td>
						<td style="text-align:center; font-size:14px;"><b>-</b></td>

						<td style="text-align:center; font-size:14px;"><b>${baseVo.cntrctBeginDe}</b></td>
						<td style="text-align:center; font-size:14px;"><b>${baseVo.cntrctEnd}</b></td>
						<td style="text-align:center; font-size:14px;"><b>1</b></td>
						<td style="text-align:right; font-size:14px;"><b><fmt:formatNumber value="${baseVo.cntrctAmount}" type="NUMBER" groupingUsed="true"/></b></td>
						<td style="text-align:center; font-size:14px;"><b>${baseVo.storeNm}</b></td>
					</tr>					
					</c:forEach>				
				</tbody>
				<tfoot>
					<tr>
						<td colspan="6" style="text-align:right; font-weight:bold; font-size:17px;" height="50">합 계&nbsp;</td>
						<td colspan="3" style="text-align:right; font-weight:bold; font-size:17px;"><fmt:formatNumber value="${proofIssueapply3.cntrctAmount}" type="NUMBER" groupingUsed="true"/> &nbsp;</td>
					</tr>
				</tfoot>
			</table>
			
		</div>
		<div class="content3">
			<%=todayDate %> 
		</div>
	</page>
</body>
</html>