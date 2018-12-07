<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.net.URLEncoder" %>
<c:set var="excelNm">
	<c:choose>
		<c:when test="${baseVo.partcptSe == 1001}">서울</c:when>
		<c:otherwise>대구</c:otherwise>
	</c:choose>
</c:set>
<c:set var="excelTitle">
	<c:choose>
		<c:when test="${baseVo.partcptSe == 1001}">10월 10일 서울행사</c:when>
		<c:otherwise>10월 11일 대구행사</c:otherwise>
	</c:choose>
</c:set>
<%
//******************************MS excel******************************
    // MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
    response.setHeader("Content-Disposition","attachment;filename=\"" + URLEncoder.encode("수요조사참가신청내역_" + (String)pageContext.getAttribute("excelNm") + ".xls", "UTF-8") + "\";");
    response.setHeader("Content-Description", "JSP Generated Data");
    
    //이걸 풀어주면 열기/저장 선택창이 뜨는 게 아니라 그냥 바로 저장된다.
	response.setContentType("application/vnd.ms-excel");
%>
<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv='Content-Type' content="application/vnd.ms-excel; charset=utf-8"/>
<meta name='ProgId' content='Excel.Sheet'/>
<meta name='Generator' content="Microsoft Excel 14"/>
<!-- <link rel="File-List" href="수요조사참가신청내역1.files/filelist.xml"/> -->
<style id="수요조사참가신청내역_21679_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.xl6311265
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
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6411265
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6511265
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6611265
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	background:#D9D9D9;
	mso-pattern:#464646 none;
	white-space:nowrap;}
.xl6711265
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
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	background:#D9D9D9;
	mso-pattern:#464646 none;
	white-space:nowrap;}
.xl6811265
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
	text-align:right;
	vertical-align:middle;
	border-top:none;
	border-right:.5pt solid windowtext;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6911265
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7011265
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:none;
	border-bottom:.5pt solid windowtext;
	border-left:none;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl7111265
	{padding-top:1px;
	padding-right:1px;
	padding-left:1px;
	mso-ignore:padding;
	color:#464646;
	font-size:16.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;
	mso-number-format:"\@";
	text-align:center;
	vertical-align:middle;
	border-top:.5pt solid windowtext;
	border-right:.5pt solid black;
	border-bottom:.5pt solid windowtext;
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

<div id="수요조사참가신청내역_21679" align="center" x:publishsource="Excel">
<table border="0" cellpadding="0" cellspacing="0" width="705" style='border-collapse:collapse;table-layout:fixed;width:529pt'>
 <col class="xl6311265" width="50" style='mso-width-source:userset;mso-width-alt:1600;width:38pt'/>
 <col class="xl6311265" width="153" style='mso-width-source:userset;mso-width-alt:4896;width:115pt'/>
 <col class="xl6311265" width="153" style='mso-width-source:userset;mso-width-alt:4896;width:115pt'/>
 <col class="xl6311265" width="83" style='mso-width-source:userset;mso-width-alt:2656;width:62pt'/>
 <col class="xl6311265" width="115" style='mso-width-source:userset;mso-width-alt:3680;width:86pt'/>
 <col class="xl6311265" width="153" style='mso-width-source:userset;mso-width-alt:4896;width:115pt'/>
 <col class="xl6311265" width="151" style='mso-width-source:userset;mso-width-alt:4832;width:113pt'/>
 <tr height="44" style='mso-height-source:userset;height:33.0pt'>
  <td colspan="7" height="44" class="xl6911265" width="705" style='border-right:.5pt solid black;height:33.0pt;width:529pt'>${excelTitle}</td>
 </tr>
 <tr height="22" style='mso-height-source:userset;height:16.5pt'>
  <td height="22" class="xl6611265" style='height:16.5pt'>No</td>
  <td class="xl6711265">상위기관명</td>
  <td class="xl6711265">소속기관명</td>
  <td class="xl6711265">이름</td>
  <td class="xl6711265">전화번호</td>
  <td class="xl6711265">이메일</td>
  <td class="xl6711265">참가신청일</td>
 </tr>
 <c:forEach items="${dmandExaminDcListExcel}" var="excelList" varStatus="status">
 <tr height="22" style='mso-height-source:userset;height:16.5pt'>
  <td height="22" class="xl6811265" style='height:16.5pt'><c:out value="${status.index + 1}"/></td>
  <td class="xl6511265"><c:out value="${excelList.upperPblinsttNm}"/></td>
  <td class="xl6511265"><c:out value="${excelList.pblinsttNm}"/></td>
  <td class="xl6411265"><c:out value="${excelList.userNm}"/></td>
  <td class="xl6511265"><c:out value="${excelList.mbtlnum}"/></td>
  <td class="xl6511265"><c:out value="${excelList.email}"/></td>
  <td class="xl6411265"><c:out value="${excelList.partcptReqstDt}"/></td>
 </tr>
 </c:forEach>
 
 <![if supportMisalignedColumns]>
 <tr height="0" style='display:none'>
  <td width="50" style='width:38pt'></td>
  <td width="153" style='width:115pt'></td>
  <td width="153" style='width:115pt'></td>
  <td width="83" style='width:62pt'></td>
  <td width="115" style='width:86pt'></td>
  <td width="153" style='width:115pt'></td>
  <td width="151" style='width:113pt'></td>
 </tr>
 <![endif]>
</table>
 
</div>


<!----------------------------->
<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 끝-->
<!----------------------------->
</body>

</html>