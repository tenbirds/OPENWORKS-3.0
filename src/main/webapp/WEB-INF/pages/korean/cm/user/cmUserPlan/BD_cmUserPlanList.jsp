<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%
	request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	String nowURL = request.getRequestURI().toString();
	
%>
    
 <!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<script type="text/javascript" src="<c:url value="/resources/cmmnty/common/js/jquery-1.11.1.js" />"></script>
	<op:jsTag type="spi" items="form, validate" />
	<link rel='stylesheet' type='text/css' href="/resources/cmmnty/common/js/fullcalendar/fullcalendar.css" />
<%-- 	 <script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>  --%>
	<script type='text/javascript' src="<c:url value="/resources/cmmnty/common/js/fullcalendar/fullcalendar.js" />"></script>
	

	<script type="text/javascript">
	$(document).ready(function() {
	    //alert(start.getFullYear());
	                    // 현재 년,월,일 

                var date = new Date();

                var d = date.getDate();

                var m = date.getMonth();

                var y = date.getFullYear();

	    $('#calendarDiv').fullCalendar({
            height : 700,
            contentHeight: 600,
            header : {
	           // left: 'prev,next today',  // 왼쪽 버튼 순서	
	            //center: 'title',  // 가운데 타이틀
	            //right: 'month,agendaWeek,agendaDay' // 오른쪽 버튼 순서 
                left : 'prevYear,prev',
                center : 'title',
                right : 'today,next,nextYear'
			},
			titleFormat: {
		            month: 'yyyy년 MMMM',
		            week: "yyyy년 MMMM d[ yyyy]{'일 ~'[ MMM] dd일 }",
		            day: 'yyyy년 MMM d dddd'
			},	
			columnFormat: {month: 'ddd',week: 'M/d ddd ', day: 'M월d일 dddd '},
			timeFormat: { // for event elements
			    '':  'HH:mm', // 월간 
		    	agenda: 'HH:mm{ - HH:mm}' // 주간,일간 
		  	},
			allDayText: '시간', // 주간,월간
			axisFormat: 'tt hh', // 주간,월간
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesShort: ['일','월','화','수','목','금','토'],
	       	buttonText: {
// 	            prev: '&nbsp;&#9668;&nbsp;',
// 	            next: '&nbsp;&#9658;&nbsp;',
// 	            prevYear: '&nbsp;&lt;&lt;&nbsp;',
// 	            nextYear: '&nbsp;&gt;&gt;&nbsp;',
	            today: '오늘',
	            month: '월간',
	            week: '주간',
	            day: '일간'
	         },
            editable: true,
            disableDragging : true,
            disableResizing : true,
            events: function(start, end, callback) {
               
                 var startSh = start.getFullYear() + '' + set2Str(start.getMonth() + 1) + '' + set2Str(start.getDate());
                 var endSh   = end.getFullYear() + '' + set2Str(end.getMonth() + 1) + '' + set2Str(end.getDate());
                 var yearSh  = new Date(start.getFullYear(),start.getMonth(),start.getDate()+15);
               	//alert(startSh);
                 $.ajax({
                    url: 'ND_cmUserPlanCalList.do',
                    dataType:    "json",
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data: {
                        // our hypothetical feed requires UNIX timestamps
                        //달력에 표시되는 시작년월일
                        start: startSh,
                        //달력에 표시되는 끝나는 년월일
                        end: endSh,
                        //보고자 하는 현재 년도
                        startYear : yearSh.getFullYear(),
                        //보고자 하는 현재달
                        startMonth : yearSh.getMonth(),
                        cmmntyId:"<c:out value='${cmUserMenuView.cmmntyId}'/>", 
                        langCode:"<c:out value='${cmUserMenuView.langCode}'/>", 
        	            cmmntyMenuCode:"<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>"
                    },
                    success: function(json) {
                        // json에 있는 title 이라는 key값
                        var events = [];
                        for(var i=0; i < json.length; i++){
                            var jsonVal = json[i];
								
                            if(i%2 == 0 )
                            {
	                            if((jsonVal.sM == 3)||(jsonVal.sM == 5)||(jsonVal.sM == 8)||(jsonVal.sM == 10)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)){
	                                }else{
	                                        events.push({
	                                            title: jsonVal.schdulSj,
	                                            start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                            end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                            color : '#DF6262',
	                                            schdulSeq  : jsonVal.schdulSeq                                            
	                                    });
	                                }
	                            }else if((jsonVal.sM == 1)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)||(jsonVal.sD == 30) ||(jsonVal.eD == 30)){
	
	                                }else if((jsonVal.sD == 29) ||(jsonVal.eD == 29)){
	                                    events.push({
	                                        title: jsonVal.schdulSj,
	                                        start: new Date(jsonVal.sY, 2, 0),
	                                        end  : new Date(jsonVal.eY, 2, 0),
	                                        color : '#DF6262',
	                                        schdulSeq  : jsonVal.schdulSeq                                     
	                                    });
	                                }else{
	                                    events.push({
	                                        title: jsonVal.schdulSj,
	                                        start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                        end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                        color : '#DF6262',
	                                        schdulSeq  : jsonVal.schdulSeq                                     
	                                    });
	                                }                           
	                            }else{
	                                events.push({
	                                    title: jsonVal.schdulSj,
	                                    start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                    end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                    color : '#DF6262',
	                                    schdulSeq  : jsonVal.schdulSeq  
	                            });
	                            }
                            }
                            else if(i%2 != 0 )
                            {                            
	                            if((jsonVal.sM == 3)||(jsonVal.sM == 5)||(jsonVal.sM == 8)||(jsonVal.sM == 10)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)){
	                                }else{
	                                        events.push({
	                                            title: jsonVal.schdulSj,
	                                            start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                            end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                            schdulSeq  : jsonVal.schdulSeq                                            
	                                    });
	                                }
	                            }else if((jsonVal.sM == 1)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)||(jsonVal.sD == 30) ||(jsonVal.eD == 30)){
	
	                                }else if((jsonVal.sD == 29) ||(jsonVal.eD == 29)){
	                                    events.push({
	                                        title: jsonVal.schdulSj,
	                                        start: new Date(jsonVal.sY, 2, 0),
	                                        end  : new Date(jsonVal.eY, 2, 0),
	                                        schdulSeq  : jsonVal.schdulSeq                                     
	                                    });
	                                }else{
	                                    events.push({
	                                        title: jsonVal.schdulSj,
	                                        start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                        end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                        schdulSeq  : jsonVal.schdulSeq                                     
	                                    });
	                                }                           
	                            }else{
	                                events.push({
	                                    title: jsonVal.schdulSj,
	                                    start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                    end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),	                                 
	                                    schdulSeq  : jsonVal.schdulSeq  
	                            });
	                            }
                            }
                        }
                         callback(events);
                    }
                });
            },
            eventClick: function(event) {            
                jsUserPlanView(this,event.schdulSeq);
            },
            dayClick: function(date) {
                <c:choose>
                <c:when test="${cmMberInfo.mberStateCd == '1003' && not empty  sessionScope['__usk'].userId}">
                jsUserPlanDateInsert(this,date);
                </c:when>
                <c:when test="${cmInfo.userId == sessionScope['__usk'].userId && not empty  sessionScope['__usk'].userId }">
                jsUserPlanDateInsert(this,date);
                </c:when>
                <c:otherwise>
                	jrLogin();
                </c:otherwise>
                </c:choose>
            }
        });
	});
	//등록페이지로 이동
    var jsUserPlanInsert = function(){
        jrMove("BD_cmUserPlanForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>");
    };
    // 지정일로 설정 등록페이지로 이동
    var jsUserPlanDateInsert = function(el,date){
        var newDate = '' + date.getFullYear() + set2Str(date.getMonth() + 1) + set2Str(date.getDate());
		jrMove("BD_cmUserPlanForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&beginDate="+newDate+"&endDate="+newDate);
    };
	// 일정 상세 페이지 
    var jsUserPlanView = function(el,vl){ 
        jrMove("BD_cmUserPlanView.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&schdulSeq="+vl );
    };
    //기본 날짜 설정
  	var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
   	};
   	
	// 페이지 이동
   	var jrMove = function(movepage){
        $("#dataForm").attr("action",movepage).submit();
  	}; 
  	var jrLogin = function(){
  	    //alert("1");
  	  jsLoginCheck(this,'<c:out value="${sessionScope['__usk'].userId}"/>' ,'', '');
  	};
	</script>
</head>
<body>
	<form name="dataForm" id="dataForm" method="post" action="BD_cmUserPlanList.do">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
		<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
		<div id="container">
		<!-- side navigation bar -->
			<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
		<!-- //side navigation bar -->
			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<div class="cont_wrap">
					<div class="btn_org"><c:if test="${cmMberInfo.mberStateCd == '1003' && not empty  sessionScope['__usk'].userId}"><a href="#none" onclick="jsUserPlanInsert();">작성하기</a></c:if>
					<c:if test="${cmInfo.userId == sessionScope['__usk'].userId && not empty  sessionScope['__usk'].userId }"><a href="#none" onclick="jsUserPlanInsert();">작성하기</a></c:if></div>
					
				</div>
				<table class="tbl_calendar">
									<caption>
						<strong>달력</strong>
						<details>
							<summary>달력으로 해당 년 월의 일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일에 대한 날짜 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:14.3%">
						<col style="width:14.3%">
						<col style="width:14.3%">
						<col style="width:14.3%">
						<col style="width:14.3%">
						<col style="width:14.3%">
						<col style="*">
					</colgroup>
				 <div id="calendarDiv"></div>
				 </table>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
		</form>
</body>
</html>
 