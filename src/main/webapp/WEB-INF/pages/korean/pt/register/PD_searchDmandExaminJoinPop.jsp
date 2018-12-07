<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE HTML>
<html>
<head>
<title>수요예보조사</title>
<meta charset="utf-8" />

<c:set var="rootPath" value="${pageContext.request.scheme }://${pageContext.request.serverName }:${pageContext.request.serverPort }" />
<c:set var="path" value="${pageContext.request.contextPath}" />
<c:set var="basePath" value="${rootPath }${path }" />

<c:set var="cssPath" value="${basePath}/resources/openworks/spi/juiGrid/dist" />
<c:set var="scriptPath" value="${basePath}/resources/openworks/spi/juiGrid/js" />
<c:set var="libPath" value="${basePath }/resources/openworks/spi/juiGrid/lib" />
<c:set var="imagePath" value="${basePath }/resources/openworks/spi/juiGrid/img" />

<link rel="stylesheet" href="${cssPath }/grid.css" />
<link rel="stylesheet" href="${cssPath }/grid-jennifer.css" />
<link rel="stylesheet" href="${cssPath }/layout.css" />

<script src="${libPath }/jquery-1.8.0.min.js"></script>
<script src="${libPath }/core.js"></script>
<script src="${cssPath }/grid.js"></script>
<op:jsTag type="spi" items="colorbox" />
<script>
    var data = [];

    jui.ready([ "grid.xtable" ], function(xtableUI) {
        var body_width = $("body").width();
        var rowLength = 0; 
        /* var list1 = new Array(); */
       
        <c:forEach items="${list}" var="item1">
        rowLength = rowLength + 1;
        data.push({
            "Delete" : "<img src='${imagePath}/delete.png' width='15' height='15'/>",
            "No" : rowLength,
            "No1" : "${item1.pblinsttType}",
            "No2" : "${item1.dmandSurveyHighorgname}",
            "No3" : "${item1.dmandSurveyOrgname}",
            "No4" : "${item1.dmandSurveySysname}",
            "No5" : "obj",
            "No6" : "기존",
            "No7" : "${item1.dmandSurveyManager}",
            "No8" : "",
            "No9" : "",
            "No10" : "${item1.dmandSurveyBuildy}",
            "No11" : "${item1.dmandSurveyUpy}",
            "No12" : "${item1.dmandSurveyBuildcost}",
            "No13" : "${item1.dmandSurveyMaint}",
            "No14" : "${item1.dmandSurveyExpenses}",
            "No15" : "",
            "No16" : "",
            "No17" : "",
            "No18" : "",
            "No19" : "",
            "No20" : "",
            "No21" : "",
            "No22" : "",
            "No23" : "",
            "No24" : "",
            "No25" : "",
            "No26" : "",
            "No27" : "",
            "No28" : ""
        });

        </c:forEach>
        /*  for ( var i = 0; i < list1.length; i++) {
             alert(list1[i]);
         } */

        xtable = xtableUI("#xtable", {
            fields : [ "Delete", "No", "No1", "No2", "No3", "No4", "No5", "No6", "No7", "No8", "No9", "No10", "No11",
                    "No12", "No13", "No14", "No15", "No16", "No17", "No18", "No19", "No20", "No21", "No22", "No23",
                    "No24", "No25", "No26", "No27", "No28" ],
            width : 800,
            scrollWidth : 1600,
            scrollHeight : 400,
            rowHeight : 31,
            buffer : "vscroll",
            resize : true,
            event : {
                colmenu : function(column, e) {
                    this.toggleColumnMenu(e.pageX - 25);
                },
                colresize : function() {
                    console.log("resize");
                }
            }
        });
        xtable.update(data);

        addRow = function() {
            var result = [];
            var rowLength = data.length + 1;
            data.push({
                Delete : "<img src='${imagePath}/delete.png' width='15' height='15'/>",
                No : rowLength,
                No1 : "<input type='text' value='' style='width: 90%;''/>",
                No2 : "<input type='text' value='' style='width: 90%;''/>",
                No3 : "<input type='text' value='' style='width: 90%;''/>",
                No4 : "<input type='text' value='' style='width: 90%;''/>",
                No5 : "<input type='text' value='' style='width: 90%;''/>",
                No6 : "<input type='text' value='' style='width: 90%;''/>",
                No7 : "<input type='text' value='' style='width: 90%;''/>",
                No8 : "<input type='text' value='' style='width: 90%;''/>",
                No9 : "<input type='text' value='' style='width: 90%;''/>",
                No10 : "<input type='text' value='' style='width: 90%;''/>",
                No11 : "<input type='text' value='' style='width: 90%;''/>",
                No12 : "<input type='text' value='' style='width: 90%;''/>",
                No13 : "<input type='text' value='' style='width: 90%;''/>",
                No14 : "<input type='text' value='' style='width: 90%;''/>",
                No15 : "<input type='text' value='' style='width: 90%;''/>",
                No16 : "<input type='text' value='' style='width: 90%;''/>",
                No17 : "<input type='text' value='' style='width: 90%;''/>",
                No18 : "<input type='text' value='' style='width: 90%;''/>",
                No19 : "<input type='text' value='' style='width: 90%;''/>",
                No20 : "<input type='text' value='' style='width: 90%;''/>",
                No21 : "<input type='text' value='' style='width: 90%;''/>",
                No22 : "<input type='text' value='' style='width: 90%;''/>",
                No23 : "<input type='text' value='' style='width: 90%;''/>",
                No24 : "<input type='text' value='' style='width: 90%;''/>",
                No25 : "<input type='text' value='' style='width: 90%;''/>",
                No26 : "<input type='text' value='' style='width: 90%;''/>",
                No27 : "<input type='text' value='' style='width: 90%;''/>",
                No28 : "<input type='text' value='' style='width: 90%;''/>"
            })
            xtable.update(data);
        }
    });
    
	fn_surveyDownChk = function(el){
	    $('.cboxElement').removeClass('cboxElement');
	    $(el).colorbox({
            title : "조사표 다운로드",
            href : "PD_searchDmandExaminSurveyPop.do",
            width : 700,
            height : 300,
            overlayClose : false,
            escKey : false,
            iframe : true,
            fixed : true
        });
	 /*    var popUrl = "BD_searchDmandExaminSurveyPop.do";
	    var popOption = "top=300, left=400, width=700, height=300, resizable=no, scrollbars=no, status=no, location=no";
	    window.open(popUrl,"",popOption); */
	}
</script>
</head>
<body class="jui" style="background-color: #fff;">
	<div id="header">
		<table style="width: 100%">
			<tbody>
				<tr style="height: 50px; background-color: #4567a3;">
					<td
						style="font-size: 24px; font-weight: 600; color: #fff; padding-left: 15px;">2018년
						클라우드 수요예보조사</td>
				</tr>
			</tbody>
		</table>
	</div>
<%-- 	<input type="hidden" id="listValue" value="${list }" /> --%>
	<div id="xtable" class="xtable scroll">
		<table class="table classic">
			<thead>
				<tr>
					<th width="100px">행삭제</th>
					<th width="100px">순번</th>
					<th width="100px">①기관유형</th>
					<th width="100px">②상위기관명</th>
					<th width="100px">③기관명</th>
					<th width="100px">④시스템명</th>
					<th width="100px">⑤시스템목적</th>
					<th width="100px">⑥시스템구분</th>
					<th width="100px">⑦담당자</th>
					<th width="100px">⑧이메일</th>
					<th width="100px">⑨연락처</th>
					<th width="100px">⑩구축년도(YYYY)</th>
					<th width="100px">⑪최근 업그레이드년도(YYYY)</th>
					<th width="100px">⑫구축비(단위:천원)</th>
					<th width="100px">⑬당해년도유지보수비(단위:천원)</th>
					<th width="100px">⑭당해년도운영비(단위:천원)</th>
					<th width="100px">⑮클라우드 기이용여부</th>
					<th width="100px">⑮-1)클라우드구분</th>
					<th width="100px">⑮-2)클라우드 도입년도(YYYY)</th>
					<th width="100px">보안성</th>
					<th width="100px">경제성</th>
					<th width="100px">업무혁신 및 만족도</th>
					<th width="100px">장점 및 단점(서술형)</th>
					<th width="100px">⑯클라우드전환 또는 도입예정</th>
					<th width="100px">클라우드 구분</th>
					<th width="100px">서비스구분</th>
					<th width="100px">⑯-2)클라우드 예산(단위:천원)</th>
					<th width="100px">⑰-1)비밀여부</th>
					<th width="100px">⑰-2)경제성</th>
					<th width="100px">⑱기타사유 및 의견(서술형)</th>
				</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
	<input type="button" value="행추가 +" onClick="javascript:addRow();" />
	<div class="btndown_Wrap">
		<table border="0" cellspacing="0" cellpadding="0" width="100%"
			class="input_box">
			<colgroup>
				<col width="20%">
				<col width="*">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<tr>
				<td>수요예보조사표 업로드</td>
				<td><input name="" type="text"
					placeholder="한국정보화진흥원_0920_수요조사 결과.xls"></td>
				<td><a class="txt_white">찾아보기</a></td>
				<td><a>적용</a></td>
			</tr>
		</table>
		<table border="0" cellspacing="0" cellpadding="0" width="100%"
			class="mt15 btn_area">
			<colgroup>
				<col width="33%">
				<col width="33%">
				<col width="33%">
			</colgroup>
			<tr>
				<td><a href="javascript:void(0);" onclick="fn_surveyDownChk(this);"><span><img src="${imagePath }/icon_download.png" width="20" height="16" ></span>조사표 다운로드</a></td>
				<td><a>저장</a></td>
				<td><a>제출</a></td>
			</tr>
		</table>
	</div>
	<script data-jui="#xtable" data-tpl="row" type="text/template">
   <tr>
   <td><!= Delete !></td>
   <td><!= No !></td>
   <td><!= No1 !></td>
   <td><!= No2 !></td>
   <td><!= No3 !></td>
   <td><!= No4 !></td>
   <td><!= No5 !></td>
   <td><!= No6 !></td>
   <td><!= No7 !></td>
   <td><!= No8 !></td>
   <td><!= No9 !></td>
   <td><!= No10 !></td>
   <td><!= No11 !></td>
   <td><!= No12 !></td>
   <td><!= No13 !></td>
   <td><!= No14 !></td>
   <td><!= No15 !></td>
   <td><!= No16 !></td>
   <td><!= No17 !></td>
   <td><!= No18 !></td>
   <td><!= No19 !></td>
   <td><!= No20 !></td>
   <td><!= No21 !></td>
   <td><!= No22 !></td>
   <td><!= No23 !></td>
   <td><!= No24 !></td>
   <td><!= No25 !></td>
   <td><!= No26 !></td>
   <td><!= No27 !></td>
   <td><!= No28 !></td>
   </tr>
</script>
	<script data-jui="#xtable" data-tpl="loading" type="text/template">
    <div class="loading"></div>
</script>

<script data-jui="#xtable" data-tpl="none" type="text/template">
    <tr>
        <td colspan="30" class="none" align="center">데이터가 없습니다.</td>
    </tr>
</script>
</body>
</html>