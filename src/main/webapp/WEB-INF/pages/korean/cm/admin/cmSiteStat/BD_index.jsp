<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 통계 | CEART MARKET</title>
	<op:jsTag type="spi" items="form, validate" />
     <script type="text/javascript" src="/resources/openworks/spi/extjs4.1/ext.js"></script>
	<script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>
	<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/sortUtil.js'/>'></script>
	<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/common.js'/>'></script>
	<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.bar.js'/>'></script>
	<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.mutilbar.js'/>'></script>
	<script type="text/javascript" src="/resources/openworks/spi/extjs4.1/locale/ext-lang-ko.js"></script>
	<script type="text/javascript" src="/resources/openworks/spi/extjs4.1/ext-all.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/extjs4.1/resources/css/ext-all.css" />
	<script type="text/javascript">

		$(document).ready(function(){
		    
		  
		});
		
		// chart에서 사용할 변수
	   	var fileds		= ['name',  'data0', 'data1', 'data2', 'data3'];
	   	var data		= [];
	   	var dataFileds	= ['data0', 'data1', 'data2', 'data3'];
	   	var xTitle		= '건수';
	   	var yTitle		= '기간' ;
	   	
		var customerInit = function(dataId) {
		    var tableId = "table.visitorChartList tbody tr";
		    if(dataId != undefined && dataId != "") {
		        tableId = "table." + dataId + " tbody tr";
		    }
			data = [];  
			// chart bar 값생성
			$(tableId).each(function (index) {
				data[index] = { name  : $(this).find('td').eq(0).text().replace(/\s/g, ''),
								data0 : parseInt($(this).find('td').eq(1).text(), 10)
				};
			});

			// initSort();
			// initCalendar();
// 			$.datepicker.setDefaults({dateFormat: 'yymmdd'});
// 			$('#startDate').datepicker({
// 				showOn : 'button',
// 				defaultDate : null,
// 				 buttonImage : '<c:url value="/resources/web/theme/default/images/btn/btn_calendar.gif" />',
// 				buttonImageOnly : true,
// 				onSelect : function(dateText, inst) {
// 					setSearchUnit('', dateText);
// 				}
// 			});

		  $.datepicker.setDefaults({
		      	   showButtonPanel:true,
		           dateFormat:"yymmdd",
		           showOn : 'button',
		           buttonImageOnly : true,
		           buttonImage : '/resources/web/theme/default/images/btn/btn_calendar.gif',
		           buttonText: "날짜선택",
		           yearRange: "2010:+1",
		           showOptions: { direction: "up"},
		   		   onSelect : function(dateText, inst) {
						setSearchUnit('', dateText);
					}
		       });
		    $('#startDate').datepicker();
			initChartMutilBar();
		};
		
		var setChartDisplay = function(dataId) {
		    if(dataId == "visitor") {
		        $("#visitHref").attr("class", "on");
		        $("#boardHref").removeAttr("class");
		        $("#pageHref").removeAttr("class");
		        customerInit("visitorChartList");
		    }else if (dataId=="pageView"){
		        $("#visitHref").removeAttr("class");
		        $("#boardHref").removeAttr("class");
		        $("#pageHref").attr("class", "on");
		        customerInit("pageViewChartList");
		    } else {
		        $("#visitHref").removeAttr("class");
		        $("#boardHref").attr("class", "on");
		        $("#pageHref").removeAttr("class");
		        customerInit("boardCntChartList");
		    }
		};
		
		var getSearchData = function(pageNo) {
			return {
				searchUnit : $("#searchUnit").val(),
				startDate : $("#startDate").val(),
				endDate : $("#endDate").val()
			};
		};
		
		var links = [{text : '커뮤니티 통계', link : 'INC_cmSiteStatView.do?cmmntyId=${param.cmmntyId}', desc : '커뮤니티 통계 현황을 보여줍니다.'}];

		var jsSearch = function() {
			// 날짜 유효성 체크
			var startDate = $('#startDate').val();

			if(startDate == null || startDate == "") {
				alert("통계 기준일을 입력하세요.");
				$('#startDate').focus();
				return false;
			}

			// 검색
			search();
		};
		
		// 기간 구분
		var setSearchUnit = function(selectedUnit, selectedDay) {
			var unit = $("#searchUnit").val();
			if(selectedUnit != "") {
				unit = selectedUnit;
			}
			var basisDay = $("#startDate").val();
			if(selectedDay != "") {
				basisDay = selectedDay;
			}
			if(unit == "DATE") {
				$("#date").attr("class", "daily");
				$("#week").removeAttr("class");
				$("#month").removeAttr("class");
				$("#startDate").val(basisDay);
				$("#endDate").val(basisDay);
			} else if(unit == "WEEK") {
				$("#date").removeAttr("class");
				$("#week").attr("class", "daily");
				$("#month").removeAttr("class");
				setWeekDay(basisDay);
			} else if(unit == "MONTH") {
			    $("#date").removeAttr("class");
				$("#week").removeAttr("class");
				$("#month").attr("class", "daily");
				$("#startDate").val(basisDay.substring(0, 6) + "01");
				$("#endDate").val(basisDay.substring(0, 6) + getLastDay(basisDay));
			}
			$("#searchUnit").val(unit);
		};

		// 주간날짜 설정
		function week_calandar(week, day) {
			day.setDate(day.getDate() - day.getDay());
			day.setDate(day.getDate() + week * 7);
			for(var i=0; i<7; i++) {
				if(i == 0) {
					$("#startDate").val(getDateStr(day));
				} else if(i == 6) {
					$("#endDate").val(getDateStr(day));
				}
				day.setDate(day.getDate() + 1);
			}
			day.setDate(day.getDate() - 7);
		}

		// 주간날짜 기준값
		function setWeekDay(strDate) {
			var yy = strDate.substr(0, 4),
			mm = strDate.substr(4, 2) - 1,
			dd = strDate.substr(6, 2);

			week_calandar(0, new Date(yy, mm, dd));
		}

		// 주어진 날짜(yyyyMMdd, yyyyMM)가 속한 달의 마지막 날짜를 반환
		var getLastDay = function(strDate) {
			var yyyyMMdd = String(strDate);
			var days = "31";
			var year = yyyyMMdd.substring(0, 4);
			var month = yyyyMMdd.substring(4, 6);

			if(Number(month) == 2) {
				if(is_leap_year(year + month + "01")) {
					days = "29";
				} else {
					days = "28";
				}
			} else if(Number(month) == 4 || Number(month) == 6 || Number(month) == 9 || Number(month) == 11) {
				days = "30";
			}

			return days;
		};

		// 날짜 타입을 문자열로
		var getDateStr = function(date) {
			var set2Str = function(vl) {
				return parseInt(vl, 10) > 9 ? vl : '0' + vl;
			};
			return '' + date.getFullYear() + set2Str(date.getMonth() + 1) + set2Str(date.getDate());
		};
	</script>
</head>
<body>
	
	<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" name="cmmntyId" id="cmmntyId"  value="<c:out value='${cmUserView.cmmntyId}'/>" />
		<input type="hidden" name="langCode" id="langCode"  value="<c:out value='${cmUserView.langCode}'/>" />
		<input type="hidden" name="userId" id="userId"  value="<c:out value='${cmUserView.userId}'/>" />
		
		<!-- container -->
		
		<div id="container">
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=cmsitestats&amp;cmmntyId=${cmUserView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
				<div id='BoxDetail' >
				</div>
		</div>
		<!-- //container -->
	</form>
		<input type='hidden' id='compareFlag' value='<c:out value='${searchVO.compareFlag}' default='1' />' />
</body>
</html>