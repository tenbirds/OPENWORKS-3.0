<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.net.URLEncoder" %>
<%
//******************************MS excel******************************
    // MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
    response.setHeader("Content-Disposition","attachment;filename=\"" + URLEncoder.encode("기본협약관리목록.xls", "UTF-8") + "\";");
    response.setHeader("Content-Description", "JSP Generated Data");
    
    //이걸 풀어주면 열기/저장 선택창이 뜨는 게 아니라 그냥 바로 저장된다.
	response.setContentType("application/vnd.ms-excel");
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=utf-8"/>
<meta name="ProgId" content="Excel.Sheet"/>
<meta name="Generator" content="Microsoft Excel 14"/>
<!-- <link rel="File-List" href="기본협약관리목록.files/filelist.xml"/> -->
<style id="통합 문서1_27869_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font513743
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.xl1513743
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
.xl6313743
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:18.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:General;
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6413743
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#C5D9F1;
	mso-pattern:#464646 none;
	white-space:nowrap;}
.xl6513743
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:11.0pt;
	font-weight:700;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
	background:#C5D9F1;
	mso-pattern:#464646 none;
	white-space:normal;}
.xl6613743
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
	mso-number-format:"0_ ";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6713743
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
	mso-number-format:"\@";
	text-align:general;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6813743
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
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border:.5pt solid windowtext;
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

<div id="통합 문서1_27869" align="center" x:publishsource="Excel">

<table border=0 cellpadding=0 cellspacing=0 width=1179 style='border-collapse:collapse;table-layout:fixed;width:885pt'>
 <col width=51 style='mso-width-source:userset;mso-width-alt:1632;width:38pt'>
 <col width=206 style='mso-width-source:userset;mso-width-alt:6592;width:155pt'>
 <col width=72 style='mso-width-source:userset;mso-width-alt:2304;width:54pt'>
 <col width=100 span=2 style='mso-width-source:userset;mso-width-alt:3200;width:75pt'>
 <col width=46 style='mso-width-source:userset;mso-width-alt:1472;width:35pt'>
 <col width=100 style='mso-width-source:userset;mso-width-alt:3200;width:75pt'>
 <col width=72 span=7 style='mso-width-source:userset;mso-width-alt:2304;width:54pt'>
 <tr height=35 style='mso-height-source:userset;height:26.25pt'>
  <td colspan=14 height=35 class=xl6313743 width=1179 style='height:26.25pt;width:885pt'>기본협약정보</td>
 </tr>
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td rowspan=2 height=66 class=xl6413743 style='height:49.5pt;border-top:none'>No</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>회사명</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>담당자</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>신청일</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>체결완료일</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>차수</td>
  <td rowspan=2 class=xl6413743 style='border-top:none'>협약종료일</td>
  <td colspan=6 class=xl6413743 style='border-left:none'>제출서류</td>
  <td rowspan=2 class=xl6513743 width=72 style='border-top:none;width:54pt'>서비스<br />등록</td>
 </tr>
 <tr height=44 style='height:33.0pt'>
  <td height=44 class=xl6513743 width=72 style='height:33.0pt;border-top:none;border-left:none;width:54pt'>기본<br />협약서</td>
  <td class=xl6513743 width=72 style='border-top:none;border-left:none;width:54pt'>등기부<br />등본</td>
  <td class=xl6513743 width=72 style='border-top:none;border-left:none;width:54pt'>벤처기업<br />증명서</td>
  <td class=xl6513743 width=72 style='border-top:none;border-left:none;width:54pt'>직접생산<br />증명서</td>
  <td class=xl6513743 width=72 style='border-top:none;border-left:none;width:54pt'>신용<br />평가서</td>
  <td class=xl6513743 width=72 style='border-top:none;border-left:none;width:54pt'>재무<br />제표</td>
 </tr>
 <c:forEach items="${bassAgremManageListExcel}" var="excelList" varStatus="status">
 <tr height=22 style='mso-height-source:userset;height:16.5pt'>
  <td height=22 class=xl6613743 align=right style='height:16.5pt;border-top:none'><c:out value="${status.index + 1}"/> </td>
  <td class=xl6713743 style='border-top:none;border-left:none'><c:out value="${excelList.cmpnyNm}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${excelList.chargerNm}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${excelList.presentnDe}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${excelList.cnclsComptDe}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:if test="${'' ne excelList.agremOrder}"><c:out value="${excelList.agremOrder}"/>차</c:if></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${excelList.agremEndDe}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.bassAgrmntFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.rgsbukTrnscrFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.vnentrCrtfFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.directPrdctnCrtfFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.cdltDocFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6813743 style='border-top:none;border-left:none'><c:out value="${not empty excelList.fnlttFile[0] ? 'Y':'N'}"/></td>
  <td class=xl6613743 align=right style='border-top:none;border-left:none'><c:out value="${excelList.goodsCnt}"/> </td>
 </tr>
 </c:forEach>
 <![if supportMisalignedColumns]>
 <tr height=0 style='display:none'>
  <td width=51 style='width:38pt'></td>
  <td width=206 style='width:155pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=46 style='width:35pt'></td>
  <td width=100 style='width:75pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
  <td width=72 style='width:54pt'></td>
 </tr>
 <![endif]>
</table>

<table border='0' cellpadding='0' cellspacing='0' width='1179' style='border-collapse:collapse;table-layout:fixed;width:885pt'>
 <col width='51' style='mso-width-source:userset;mso-width-alt:1632;width:38pt'>
 <col width='206' style='mso-width-source:userset;mso-width-alt:6592;width:155pt'>
 <col width='72' style='mso-width-source:userset;mso-width-alt:2304;width:54pt'>
 <col width='100' span='2' style='mso-width-source:userset;mso-width-alt:3200;width:75pt'>
 <col width='46' style='mso-width-source:userset;mso-width-alt:1472;width:35pt'>
 <col width='100' style='mso-width-source:userset;mso-width-alt:3200;width:75pt'>
 <col width='72' span='7' style='mso-width-source:userset;mso-width-alt:2304;width:54pt'>
 <tr height='35' style='mso-height-source:userset;height:26.25pt'>
  <td colspan='14' height='35' class='xl7113743' width='1179' style='border-right:.5pt solid black;height:26.25pt;width:885pt'>기본협약정보</td>
 </tr>
 <tr height="22" style="height:16.5pt">
  <td rowspan="2" height="66" class="xl6627869" style="height:49.5pt;border-top:none">No</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">회사명</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">담당자</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">제출예정</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">신청일</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">체결완료일</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">발송일</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">차수</td>
  <td rowspan="2" class="xl6627869" style="border-top:none">협약종료일</td>
  <td colspan="6" class="xl6627869" style="border-left:none">제출서류</td>
  <td rowspan="2" class="xl6727869" width="72" style="border-top:none;width:54pt">서비스<br/>등록</td>
 </tr>
 <tr height="44" style="height:33.0pt">
  <td height="44" class="xl6727869" width="72" style="height:33.0pt;border-top:none; border-left:none;width:54pt">기본<br/>협약서</td>
  <td class="xl6727869" width="72" style="border-top:none;border-left:none; width:54pt">등기부<br/>등본</td>
  <td class="xl6727869" width="72" style="border-top:none;border-left:none; width:54pt">베처기업<br/>증명서</td>
  <td class="xl6727869" width="72" style="border-top:none;border-left:none; width:54pt">직접생산<br/>증명서</td>
  <td class="xl6727869" width="72" style="border-top:none;border-left:none; width:54pt">신용<br/>평가서</td>
  <td class="xl6727869" width="72" style="border-top:none;border-left:none; width:54pt">재무<br/>제표</td>
 </tr>
 <c:forEach items="${bassAgremManageListExcel}" var="excelList" varStatus="status">
 <tr height="22" style="height:16.5pt">
  <td height="22" class="xl7027869" align="right" style="height:16.5pt;border-top: none"><c:out value="${status.index + 1}"/> </td>
  <td class="xl6827869" style="border-top:none;border-left:none"> <c:out value="${excelList.cmpnyNm}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.chargerNm}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.presentnPrearngeDe}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.presentnDe}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.cnclsComptDe}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.sndngDe}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:if test="${'' ne excelList.agremOrder}"><c:out value="${excelList.agremOrder}"/>차</c:if></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${excelList.agremEndDe}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.bassAgrmntFile[0] ? 'Y':'N'}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.rgsbukTrnscrFile[0] ? 'Y':'N'}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.vnentrCrtfFile[0] ? 'Y':'N'}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.directPrdctnCrtfFile[0] ? 'Y':'N'}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.cdltDocFile[0] ? 'Y':'N'}"/></td>
  <td class="xl6927869" style="border-top:none;border-left:none"><c:out value="${not empty excelList.fnlttFile[0] ? 'Y':'N'}"/></td>
  <td class="xl7027869" align="right" style="border-top:none;border-left:none"><c:out value="${excelList.goodsCnt}"/> </td>
 </tr>
 </c:forEach>
 
 <![if supportMisalignedColumns]>
 <tr height="0" style="display:none">
  <td width="51" style="width:38pt"></td>
  <td width="206" style="width:155pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="100" style="width:75pt"></td>
  <td width="100" style="width:75pt"></td>
  <td width="100" style="width:75pt"></td>
  <td width="100" style="width:75pt"></td>
  <td width="46" style="width:35pt"></td>
  <td width="100" style="width:75pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
  <td width="72" style="width:54pt"></td>
 </tr>
 <![endif]>
</table>

</div>

<!----------------------------->
<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 끝-->
<!----------------------------->
</body>

</html>