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
               
   
    //등록팝업
    var jsInsertPop = function(el, vi) {
       
        var newDate = '' + vi.substr(0,4) + '-' + vi.substr(4,2) + '-' + vi.substr(6,2);
        
        $(el).colorbox({
            title : "일정등록 메뉴",
            href : "PD_insertPop.do?start_dt="+newDate+"&end_dt="+newDate ,
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

    
    //검색
    var jsSearch = function(e1) {
        
        $('#q_week').val(e1);
        
        document.dataForm.action = "BD_week.do";
        document.dataForm.submit();      
    };
   
    //]]>
</script>
</head>
<body>
	<div id="contents">
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
    	
	    	<input type="hidden" name="q_week" id="q_week"/>
	   		
   		
			<!-- 탭 -->
			<ul class="tab">
				<li><a href="BD_index.do"   		/> 전체일정</a></li>
			    <li><a href="BD_day.do"             /> 일일일정</a></li>
			    <li><a href="BD_week.do" class="on" /> 주간일정</a></li>			    
			</ul>
			<!-- //탭 -->			
			
		
		
		<p class="c_month mar_b10">
			<a href="#" onclick="jsSearch('last_week');"> <img  src="../../resources/openworks/theme/default/images/btn/btn_arrow_prev.gif" alt="이전달" class="vm" /></a>
			&nbsp;
				<c:forEach items="${searchVo}" var="searchVo" varStatus="status">
					${searchVo.q_startDt } ~ ${searchVo.q_endDt}
					<input type="hidden" name="q_startDt" id="q_startDt" value='${searchVo.q_startDt }'/>
					<input type="hidden" name="q_endDt" id="q_endDt" value='${searchVo.q_endDt }'/>
                </c:forEach>
            &nbsp;
			<a href="#" onclick="jsSearch('next_week');"><img  src="../../resources/openworks/theme/default/images/btn/btn_arrow_next.gif" alt="다음달" class="vm" /></a>
		</p>
		<!-- 주간일정 리스트 -->
		<table class="boardList" cellspacing="0" border="0" summary="주간일정">
			<caption class="hidden"> 주간일정 </caption>
			<colgroup>
				<col width="10%">
				<col width="">
				<col width="15%">
			</colgroup>
			<thead>
				<tr>
					<th>날짜</th>
					<th>일정내용</th>
					<th class="lr_none">등록</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${baseVo}" var="baseVo" varStatus="status">
					<tr>
						<c:if test="${status.index == '0'}" > <td  class="tx_red">${baseVo.sY}</td></c:if>
						<c:if test="${status.index == '6'}" > <td  class="tx_blue_n">${baseVo.sY}</td></c:if>
						<c:if test="${status.index != 0 and status.index != 6}" ><td>${baseVo.sY}</td></c:if>
						<td class="tx_l">
						<ul>
							<c:forEach items="${baseVo.dw_Plan}" var="planVo">
								<c:if test="${not empty planVo.title}" >
									<a href="#" onclick="jsUpdatePop(this,'${planVo.plan_seq}');"> <li>- ${planVo.title}</li></a>
								</c:if>
							</c:forEach>													
						</ul>
						</td>
						<td class="lr_none"><button class="s_blue" type="button" onclick="jsInsertPop(this, '${baseVo.start_dt}');">등록</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- //주관일정 리스트 -->				
		
	</div>
	<!-- //컨텐츠영역 -->
	</form>
</body>
</html>