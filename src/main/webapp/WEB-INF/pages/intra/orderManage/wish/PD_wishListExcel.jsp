<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.net.URLEncoder" %>
<c:set var="excelNm" value="${wishListInfo[0].auditlogNm}"/>
<%
//******************************MS excel******************************
    // MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
    response.setHeader("Content-Disposition","attachment;filename=\"" + URLEncoder.encode("이용희망목록-" + (String)pageContext.getAttribute("excelNm") + ".xls", "UTF-8") + "\";");
    response.setHeader("Content-Description", "JSP Generated Data");
    
    //이걸 풀어주면 열기/저장 선택창이 뜨는 게 아니라 그냥 바로 저장된다.
	response.setContentType("application/vnd.ms-excel");
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">
	<head>
		<meta http-equiv='Content-Type' content="application/vnd.ms-excel; charset=utf-8"/>
		<meta name='ProgId' content='Excel.Sheet'/>
		<meta name='Generator' content="Microsoft Excel 14"/>
		<!-- <link rel=File-List href="이용희망목록_다운로드_양식.files/filelist.xml"> -->
		<style id="이용희망목록_다운로드_양식_2800_Styles">
		<!--table
			{mso-displayed-decimal-separator:"\.";
			mso-displayed-thousand-separator:"\,";}
		.xl152800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl632800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:none;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl642800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl652800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border:.5pt solid windowtext;
			background:#D6DCE4;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl662800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:1.0pt solid windowtext;
			border-bottom:.5pt solid windowtext;
			border-left:.5pt solid windowtext;
			background:#D6DCE4;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl672800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl682800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:none;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl692800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:General;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl702800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl712800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:1.0pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl722800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:General;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl732800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl742800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:1.0pt solid windowtext;
			border-bottom:.5pt dotted windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl752800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:General;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl762800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl772800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt dotted windowtext;
			border-right:1.0pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl782800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:1.0pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:.5pt solid windowtext;
			border-left:1.0pt solid windowtext;
			background:#ACB9CA;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl792800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:none;
			border-left:1.0pt solid windowtext;
			background:#ACB9CA;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl822800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:12.0pt;
			font-weight:700;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid #5B9BD5;
			border-right:none;
			border-bottom:2.0pt double #5B9BD5;
			border-left:none;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl842800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:"yyyy\/mm\/dd\\ hh\:mm";
			text-align:left;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl862800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:1.0pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl892800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:left;
			vertical-align:middle;
			border:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl912800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:.5pt solid windowtext;
			background:#D6DCE4;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl932800
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:left;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:.5pt solid windowtext;
			border-left:.5pt solid windowtext;
			background:white;
			mso-pattern:#464646 none;
			white-space:nowrap;}
		.xl64225
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl91225
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl92225
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:center;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:.5pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:none;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl93225
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:none;
			border-bottom:1.0pt solid windowtext;
			border-left:.5pt solid windowtext;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		.xl95225
			{padding-top:1px;
			padding-right:1px;
			padding-left:1px;
			mso-ignore:padding;
			color:#464646;
			font-size:11.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-number-format:General;
			text-align:general;
			vertical-align:middle;
			border-top:.5pt solid windowtext;
			border-right:1.0pt solid windowtext;
			border-bottom:1.0pt solid windowtext;
			border-left:none;
			mso-background-source:auto;
			mso-pattern:auto;
			white-space:nowrap;}
		ruby
			{ruby-align:left;}
		rt
			{color:windowtext;
			font-size:8.0pt;
			font-weight:400;
			font-style:normal;
			text-decoration:none;
			font-family:"맑은 고딕", monospace;
			mso-font-charset:129;
			mso-char-type:none;}
		-->
		</style>
	</head>

	<body>
		<!--[if !excel]>　　<![endif]-->
		<!--다음 내용은 Microsoft Excel의 웹 페이지로 게시 마법사를 사용하여 작성되었습니다.-->
		<!--같은 내용의 항목이 다시 게시되면 DIV 태그 사이에 있는 내용이 변경됩니다.-->
		<!----------------------------->
		<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 시작 -->
		<!----------------------------->
		<div id="이용희망목록_다운로드_양식_2800" align="center" x:publishsource="Excel">
			<table border="0" cellpadding="0" cellspacing="0" width="977" style='border-collapse:collapse;table-layout:fixed;width:734pt'>
			 <col width="33" style='mso-width-source:userset;mso-width-alt:1056;width:25pt'/>
			 <col class="xl672800" width="88" style='mso-width-source:userset;mso-width-alt:2816;width:66pt'/>
			 <col class="xl672800" width="107" style='mso-width-source:userset;mso-width-alt:3424;width:80pt'/>
			 <col width="170" style='mso-width-source:userset;mso-width-alt:5440;width:128pt'/>
			 <col width="109" style='mso-width-source:userset;mso-width-alt:3488;width:82pt'/>
			 <col width="262" style='mso-width-source:userset;mso-width-alt:8384;width:197pt'/>
			 <col width="208" style='mso-width-source:userset;mso-width-alt:6656;width:156pt'/>
			 <tr height="32" style='mso-height-source:userset;height:24.0pt'>
			  <td height="32" class="xl152800" width='33' style='height:24.0pt;width:25pt'></td>
			  <td colspan="6" class="xl822800" width='944' style='width:709pt'>클라우드서비스 씨앗 이용희망목록</td>
			 </tr>
			 <tr height="24" style='height:18.0pt'>
			  <td height="24" class='xl152800' style='height:18.0pt'></td>
			  <td class='xl672800'></td>
			  <td class='xl672800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			 </tr>
			 <tr height='31' style='mso-height-source:userset;height:23.25pt'>
			  <td height='31' class='xl152800' style='height:23.25pt'></td>
			  <td class='xl782800'>사업명</td>
			  <td colspan='5' class='xl862800' style='border-right:1.0pt solid black;border-left:none'><c:out value="${wishListInfo[0].auditlogNm}"/></td>
			 </tr>
			 <tr height='12' style='mso-height-source:userset;height:9.0pt'>
			  <td height='12' class='xl152800' style='height:9.0pt'></td>
			  <td class='xl682800' style='border-top:none'>　</td>
			  <td class='xl672800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl632800' style='border-top:none'>　</td>
			 </tr>
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td class='xl792800' style='border-top:none'>기준</td>
			  <td class='xl652800' style='border-left:none'>사용자아이디</td>
			  <td class='xl632800'><c:out value="${wishListInfo[0].userId}"/></td>
			  <td class='xl652800'>적용일시</td>
			  <td colspan='2' class='xl842800' style='border-right:1.0pt solid black;border-left:none'><c:out value="${wishListInfo[0].srcDt}"/></td>
			 </tr>
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td rowspan='2' class='xl792800' style='border-bottom:.5pt solid black'>검색조건</td>
			  <td class='xl652800' style='border-top:none;border-left:none'>검색어</td>
			  <td class='xl642800' style='border-top:none;border-left:none'><c:out value="${wishListInfo[0].keyWord}"/></td>
			  <td class='xl652800' style='border-top:none;border-left:none'>카테고리</td>
			  <td colspan='2' class='xl932800' style='border-right:1.0pt solid black;border-left:none'><c:out value="${wishListInfo[0].ctgryCode}"/></td>
			 </tr>
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td class='xl652800' style='border-top:none;border-left:none'>필터조건</td>
			  <td colspan='4' class='xl892800' style='border-right:1.0pt solid black;border-left:none'><c:out value="${wishListInfo[0].filterCon}"/></td>
			 </tr>
			 <tr height='14' style='mso-height-source:userset;height:10.5pt'>
			  <td height='14' class='xl152800' style='height:10.5pt'></td>
			  <td class='xl682800' style='border-top:none'>　</td>
			  <td class='xl672800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl152800'></td>
			  <td class='xl632800' style='border-top:none'>　</td>
			 </tr>
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td rowspan='<c:out value="${fn:length(wishListExcel) + 1}" />' class='xl792800' style='border-bottom:1.0pt solid black;border-top:none'>서비스목록</td>
			  <td class='xl652800' style='border-left:none'>번호</td>
			  <td class='xl652800' style='border-left:none'>선택여부</td>
			  <td colspan='2' class='xl912800' style='border-right:.5pt solid black;border-left:none'>서비스명</td>
			  <td class='xl662800' style='border-top:none;border-left:none'>제조사</td>
			 </tr>
			 <c:forEach items="${wishListExcel}" var="wishList" varStatus="status">
			 <c:if test="${fn:length(wishListExcel) == 1}">
			 <tr height='23' style='height:17.25pt'>
			  <td height='23' class='xl64225' style='height:16.5pt'></td>
			  <td class='xl91225' align='right' style='border-top:none;border-left:none'><c:out value="${status.index + 1}"/></td>
			  <td class='xl92225' style='border-top:none'><c:out value="${wishList.selChk eq 'Y' ? '선택':'미선택'}"/></td>
			  <td colspan='2' class='xl93225' style='border-right:.5pt solid black;border-left:none'><c:out value="${wishList.goodsNm}"/></td>
			  <td class='xl95225' style='border-top:none'><c:out value="${wishList.langStoreNm}"/></td>
			 </tr>
			 </c:if>
			 <c:if test="${fn:length(wishListExcel) > 1}">
			 <c:choose>
			 <c:when test="${status.first}">
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td class='xl692800' style='border-top:none;border-left:none'><c:out value="${status.index + 1}"/></td>
			  <td class='xl702800' style='border-top:none;border-left:none'><c:out value="${wishList.selChk eq 'Y' ? '선택':'미선택'}"/></td>
			  <td colspan='2' class='xl692800' style='border-left:none'><c:out value="${wishList.goodsNm}"/></td>
			  <td class='xl712800' style='border-top:none;border-left:none'><c:out value="${wishList.langStoreNm}"/></td>
			 </tr>
			 </c:when>
			 <c:when test="${status.last}">
			 <tr height='23' style='height:17.25pt'>
			  <td height='23' class='xl152800' style='height:17.25pt'></td>
			  <td class='xl752800' style='border-top:none;border-left:none'><c:out value="${status.index + 1}"/></td>
			  <td class='xl762800' style='border-top:none;border-left:none'><c:out value="${wishList.selChk eq 'Y' ? '선택':'미선택'}"/></td>
			  <td colspan='2' class='xl752800' style='border-left:none'><c:out value="${wishList.goodsNm}"/></td>
			  <td class='xl772800' style='border-top:none;border-left:none'><c:out value="${wishList.langStoreNm}"/></td>
			 </tr>
			 </c:when>
			 <c:otherwise>
			 <tr height='22' style='height:16.5pt'>
			  <td height='22' class='xl152800' style='height:16.5pt'></td>
			  <td class='xl722800' style='border-top:none;border-left:none'><c:out value="${status.index + 1}"/></td>
			  <td class='xl732800' style='border-top:none;border-left:none'><c:out value="${wishList.selChk eq 'Y' ? '선택':'미선택'}"/></td>
			  <td colspan='2' class='xl722800' style='border-left:none'><c:out value="${wishList.goodsNm}"/></td>
			  <td class='xl742800' style='border-top:none;border-left:none'><c:out value="${wishList.langStoreNm}"/></td>
			 </tr>
			 </c:otherwise>
			 </c:choose>
			 </c:if>
			 </c:forEach>
			 <![if supportMisalignedColumns]>
			 <tr height='0' style='display:none'>
			  <td width='33' style='width:25pt'></td>
			  <td width='88' style='width:66pt'></td>
			  <td width='107' style='width:80pt'></td>
			  <td width='170' style='width:128pt'></td>
			  <td width='109' style='width:82pt'></td>
			  <td width='262' style='width:197pt'></td>
			  <td width='208' style='width:156pt'></td>
			 </tr>
			 <![endif]>		 
			</table>
		</div>
		<!----------------------------->
		<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 끝-->
		<!----------------------------->
	</body>
</html>
