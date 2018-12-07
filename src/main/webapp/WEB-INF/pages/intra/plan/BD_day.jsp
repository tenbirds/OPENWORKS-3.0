<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>일정관리(리스트)</title>
<op:jsTag type="spi" items="validate,ui,form,highlight" />
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript"
	src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<!-- 기능별 스크립트 정의 -->

<script type="text/javascript">
    //<![CDATA[
    $().ready(function() {
        
        
    });
    

    //등록팝업
    var jsInsertPop = function(el, vi, zi) {
        
        var d = new Date();
        var newDate = '' + d.getFullYear() + '-' + set2Str(d.getMonth() + 1) + '-' + set2Str(d.getDate());
        
        $(el).colorbox({
            title : "일정등록 메뉴",
            href : "PD_insertPop.do?start_dt="+newDate+"&end_dt="+newDate+"&s_time_gb="+vi+"&e_time_gb="+vi+"&start_time="+zi ,
            width : "650",
            height : "700",
            iframe : true
        });
    };
    
        
    //수정팝업
    var jsUpdatePop = function(el, vl) {        
        $(el).colorbox({
            title : "일정수정 메뉴",
            href : "PD_updatePop.do?Plan_seq=" + vl,
            width : "650",
            height : "700",
            iframe : true
        });

    };

    
    var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };
    

    //]]>
</script>
</head>
<body>
	<div id="contents">
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">

			<!-- 탭 -->
			<ul class="tab">
				<li><a href="BD_index.do"   		/> 전체일정</a></li>
			    <li><a href="BD_day.do"  class="on" /> 일일일정</a></li>
			    <li><a href="BD_week.do"           /> 주간일정</a></li>			    
			</ul>
			<!-- //탭 -->			
			
		</form>

		<!-- 일일일정 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="일일일정">
			<caption class="hidden"> 일일일정 </caption>
			<colgroup>
				<col width="10%">
				<col width="">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>시간</th>
					<th>일정내용</th>
					<th class="lr_none">등록</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${baseVo}" var="baseVo" varStatus="status">
					<tr>
						<td><img 
								<c:if test="${baseVo.s_time_gb == 'A' }">src="../../resources/openworks/theme/default/images/icon/blue.gif"   alt="오전"</c:if>
								<c:if test="${baseVo.s_time_gb == 'P' }">src="../../resources/openworks/theme/default/images/icon/orange.gif" alt="오후"</c:if>
							/>
							${baseVo.start_time}
						</td>					
						<td class="tx_l">
						<ul>
							<c:forEach items="${baseVo.dw_Plan}" var="planVo">
								<c:if test="${not empty planVo.title}" >
									<a href="#" onclick="jsUpdatePop(this,'${planVo.plan_seq }');"> <li>- ${planVo.title}</li></a>
								</c:if>
							</c:forEach>													
						</ul>
						</td>
						<td class="lr_none"><button class="s_blue" type="button" onclick="jsInsertPop(this, '${baseVo.s_time_gb}', '${baseVo.start_time}');">등록</button></td>
					</tr>
				</c:forEach>				
			</tbody>
		</table>
		<!-- //일일일정 리스트 -->
				
		
	</div>
	<!-- //컨텐츠영역 -->
</body>
</html>