<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>일정관리(달력)</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<script type="text/javascript" src="<c:url value="/resources/intra/banner/xdate.js" />"></script>
<link rel='stylesheet' type='text/css' href='/resources/intra/schedule/fullcalendar.css' />
<script type='text/javascript' src="<c:url value="/resources/intra/schedule/fullcalendar.js" />"></script>

<!-- 기능별 스크립트 정의 -->

    <script type="text/javascript">

  //<![CDATA[
    $().ready(function () {

        $('#calendar').fullCalendar({
            height : 700,
            contentHeight: 600,
            header : {
                left : 'prevYear,prev',
                center : 'title',
                right : 'today,next,nextYear'
            },
            editable: true,
            disableDragging : true,
            disableResizing : true,

            events: function(start, end, callback) {
                
                 var startSh = start.getFullYear() + '' + set2Str(start.getMonth() + 1) + '' + set2Str(start.getDate());
                 var endSh   = end.getFullYear() + '' + set2Str(end.getMonth() + 1) + '' + set2Str(end.getDate());
                 var yearSh  = new Date(start.getFullYear(),start.getMonth(),start.getDate()+15);
               
                 $.ajax({
                    url: 'ND_calList.do',
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
                        startMonth : yearSh.getMonth()
                    },
                    success: function(json) {
                        // json에 있는 title 이라는 key값
                        var events = [];
                        for(var i=0; i < json.length; i++){
                            var jsonVal = json[i];
								
                            if(jsonVal.s_time_gb == "A")
                            {
	                            if((jsonVal.sM == 3)||(jsonVal.sM == 5)||(jsonVal.sM == 8)||(jsonVal.sM == 10)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)){
	                                }else{
	                                        events.push({
	                                            title: jsonVal.title,
	                                            start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                            end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                            color : '#DF6262',
	                                            plan_seq  : jsonVal.plan_seq                                            
	                                    });
	                                }
	                            }else if((jsonVal.sM == 1)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)||(jsonVal.sD == 30) ||(jsonVal.eD == 30)){
	
	                                }else if((jsonVal.sD == 29) ||(jsonVal.eD == 29)){
	                                    events.push({
	                                        title: jsonVal.title,
	                                        start: new Date(jsonVal.sY, 2, 0),
	                                        end  : new Date(jsonVal.eY, 2, 0),
	                                        color : '#DF6262',
	                                        plan_seq  : jsonVal.plan_seq                                     
	                                    });
	                                }else{
	                                    events.push({
	                                        title: jsonVal.title,
	                                        start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                        end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                        color : '#DF6262',
	                                        plan_seq  : jsonVal.plan_seq                                     
	                                    });
	                                }                           
	                            }else{
	                                events.push({
	                                    title: jsonVal.title,
	                                    start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                    end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                    color : '#DF6262',
	                                    plan_seq  : jsonVal.plan_seq  
	                            });
	                            }
                            }
                            else
                            {                            
	                            if((jsonVal.sM == 3)||(jsonVal.sM == 5)||(jsonVal.sM == 8)||(jsonVal.sM == 10)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)){
	                                }else{
	                                        events.push({
	                                            title: jsonVal.title,
	                                            start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                            end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                            plan_seq  : jsonVal.plan_seq                                            
	                                    });
	                                }
	                            }else if((jsonVal.sM == 1)){
	                                if((jsonVal.sD == 31) ||(jsonVal.eD == 31)||(jsonVal.sD == 30) ||(jsonVal.eD == 30)){
	
	                                }else if((jsonVal.sD == 29) ||(jsonVal.eD == 29)){
	                                    events.push({
	                                        title: jsonVal.title,
	                                        start: new Date(jsonVal.sY, 2, 0),
	                                        end  : new Date(jsonVal.eY, 2, 0),
	                                        plan_seq  : jsonVal.plan_seq                                     
	                                    });
	                                }else{
	                                    events.push({
	                                        title: jsonVal.title,
	                                        start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                        end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),
	                                        plan_seq  : jsonVal.plan_seq                                     
	                                    });
	                                }                           
	                            }else{
	                                events.push({
	                                    title: jsonVal.title,
	                                    start: new Date(jsonVal.sY, jsonVal.sM, jsonVal.sD),
	                                    end  : new Date(jsonVal.eY, jsonVal.eM, jsonVal.eD),	                                 
	                                    plan_seq  : jsonVal.plan_seq  
	                            });
	                            }
                            }
                        }
                         callback(events);
                    }
                });
            },
            eventClick: function(event) {                
                jsUpdatePop(this,event.plan_seq);
            },
            dayClick: function(date) {
                jsInsertPop2(this,date);
            }
        });
        
        
        var subTabIdx = "2";	
	      
		var s = document.getElementById("subTab" + subTabIdx);
		var a = document.getElementById("subA" + subTabIdx);
		s.style.cssText = "background-color:#db894d !important;";
		a.style.cssText = "color:#fff !important;";
        
    });
    
    var jsInsertPop = function(el){
        $(el).colorbox({
            title : "일정 등록 메뉴",
            href  : "PD_insertPop.do" ,
            width : "650",
            height: "500",
            iframe: true
           });
    };
    
    var jsInsertPop2 = function(el,date){
        var newDate = '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
        $(el).colorbox({
            title : "일정 등록 메뉴",
            href  : "PD_insertPop.do?start_dt="+newDate+"&end_dt="+newDate ,
            width : "650",
            height: "500",
            iframe: true
           });
    };

    var jsUpdatePop = function(el,vl){
        $(el).colorbox({
            title : "일정 수정 메뉴",
            href  : "PD_updatePop.do?plan_seq="+vl ,
            width : "650",
            height: "700",
            iframe: true
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
    <input type="hidden" name="startDt1" id="startDt1"/>
    <input type="hidden" name="endDt1" id="endDt1"/>
    <div>
     
       	<!-- 탭 -->
		<ul class="tab">
			<li><a href="BD_index.do"  class="on" /> 전체일정</a></li>
		    <li><a href="BD_day.do"               /> 일일일정</a></li>
		    <li><a href="BD_week.do"             /> 주간일정</a></li>			    
		</ul>
		<!-- //탭 -->			
		<!-- 작은탭 -->
		<ul class="tab_s">
			<li id="subTab1"><a href="BD_index.do"  id="subA1">리스트</a></li>
			<li id="subTab2"><a href="BD_cal.do"    id="subA2">달력형</a></li>				
		</ul>		
		<!-- //작은탭 -->
       
    </div>
    </form>
    <div id='calendar'></div>
    <br />
    <div class="tx_r"><button class="btn blue" type="button" onclick="jsInsertPop(this);">일정 등록</button></div>
    <br/>

</div>
<!-- //컨텐츠영역 -->
</body>
</html>