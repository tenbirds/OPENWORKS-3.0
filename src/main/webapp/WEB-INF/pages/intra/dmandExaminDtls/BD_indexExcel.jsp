<%@ page language="java" contentType="application/vnd.ms-excel; charset=utf-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.net.URLEncoder" %>
<%
//******************************MS excel******************************
    // MS excel로 다운로드/실행, filename에 저장될 파일명을 적어준다.
    response.setHeader("Content-Disposition","attachment;filename=\"" + URLEncoder.encode("수요정보조사등록내역.xls", "UTF-8") + "\";");
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
<style id="통합 문서1_10027_Styles">
<!--table
	{mso-displayed-decimal-separator:"\.";
	mso-displayed-thousand-separator:"\,";}
.font510027
	{color:windowtext;
	font-size:8.0pt;
	font-weight:400;
	font-style:normal;
	text-decoration:none;
	font-family:"맑은 고딕", monospace;
	mso-font-charset:129;}
.xl1510027
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
.xl6310027
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
	background:#B8CCE4;
	mso-pattern:#464646 none;
	white-space:nowrap;}
.xl6410027
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
	mso-number-format:"0\;\[Red\]0";
	text-align:right;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6510027
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
	text-align:left;
	vertical-align:middle;
	border:.5pt solid windowtext;
	mso-background-source:auto;
	mso-pattern:auto;
	white-space:nowrap;}
.xl6610027
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

<div id="통합 문서1_10027" align='center' x:publishsource="Excel">

<table border='0' cellpadding='0' cellspacing='0' width='774' style='border-collapse: collapse;table-layout:fixed;width:581pt'>
 <col width='45' style='mso-width-source:userset;mso-width-alt:1440;width:34pt'>
 <col width='171' style='mso-width-source:userset;mso-width-alt:5472;width:128pt'>
 <col width='192' style='mso-width-source:userset;mso-width-alt:6144;width:144pt'>
 <col width='201' style='mso-width-source:userset;mso-width-alt:6432;width:151pt'>
 <col width='201' style='mso-width-source:userset;mso-width-alt:6432;width:151pt'>
 <col width='165' style='mso-width-source:userset;mso-width-alt:5280;width:124pt'>
 <tr height='22' style='height:16.5pt'>
  <td height='22' class='xl6310027' width='45' style='height:16.5pt;width:34pt'>No</td>
  <td class='xl6310027' width='171' style='border-left:none;width:128pt'>상위기관명</td>
  <td class='xl6310027' width='192' style='border-left:none;width:144pt'>소속기관</td>
  <td class='xl6310027' width='201' style='border-left:none;width:151pt'>이름(ID)</td>
  <td class='xl6310027' width='201' style='border-left:none;width:151pt'>전화번호</td>
  <td class='xl6310027' width='165' style='border-left:none;width:124pt'>등록일자</td>
 </tr>
 <c:forEach items="${dmandExaminDtlsListExcel}" var="excelList" varStatus="status">
 <tr height='22' style='height:16.5pt'>
  <td height='22' class='xl6410027' style='height:16.5pt;border-top:none'><c:out value="${status.index + 1}"/></td>
  <td class='xl6510027' style='border-top:none;border-left:none'><c:out value="${excelList.upperPblinsttNm}"/></td>
  <td class='xl6510027' style='border-top:none;border-left:none'><c:out value="${excelList.pblinsttNm}"/></td>
  <td class='xl6510027' style='border-top:none;border-left:none'><c:out value="${excelList.userNm}"/>(<c:out value="${excelList.userId}"/>)</td>
  <td class='xl6510027' style='border-top:none;border-left:none'><c:out value="${excelList.mbtlnum}"/></td>
  <td class='xl6610027' style='border-top:none;border-left:none'><c:out value="${excelList.dmandExaminDt}"/></td>
 </tr>
 </c:forEach>
 <![if supportMisalignedColumns]>
 <tr height='0' style='display:none'>
  <td width='45' style='width:34pt'></td>
  <td width='171' style='width:128pt'></td>
  <td width='192' style='width:144pt'></td>
  <td width='201' style='width:151pt'></td>
  <td width='201' style='width:151pt'></td>
  <td width='165' style='width:124pt'></td>
 </tr>
 <![endif]>
</table>

</div>


<!----------------------------->
<!--Excel의 웹 페이지 마법사로 게시해서 나온 결과의 끝-->
<!----------------------------->
</body>

</html>