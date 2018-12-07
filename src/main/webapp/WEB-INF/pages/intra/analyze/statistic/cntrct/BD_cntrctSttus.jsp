<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	
    <title>계약통계(요약)</title>
    
	<op:jsTag type="openworks" items="ui, validate, form" />
	<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox, extjs4"/>
    <script type="text/javascript" src="/resources/openworks/spi/jquery/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="/cloud_ver2/new_cloud/js/Chart.bundle.js"></script>
    <script type="text/javascript" src="/cloud_ver2/new_cloud/js/utils.js"></script>
    <script type="text/javascript" src="/cloud_ver2/new_cloud/js/v3_cmm.js"></script>
    
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/jnotify/jquery.jnotify.min.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/notice/jquery.notice.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/spi/extjs/resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all.css" />
    <link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/openworks_all_print.css" media="print"/>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_cmm.css' />
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />

<script type='text/javascript'>

	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}


    $().ready(function () {
        var pCntrctYear = "${param.cntrctYear}";
        var pCntrctType = "${param.cntrctType}";
        
	    $.ajax({//계약금액 누적통계
	        type: "POST",
	        url: "/intra/analyze/statistic/cntrct/cntrctSttusList.do",
	        data: {"sessionId" : "${sessionScope.tempId}", "cntrctYear": "${param.cntrctYear}", "cntrctType": "${param.cntrctType}"},
	        dataType: "json",
	        success:function(data){
                var testJson = [];
                var newJson = [];
                var startDate = data.startDate;
                var endDate = data.endDate;
                
                //$('#chartDate1').text("계약금액 누적통계("+startDate+" ~ "+endDate+")");
				var innerHtml = "";	
				var yearOption = "";
/* 				
				console.log(data.cntrDataList);
				console.log(data.cntrTpList);
				console.log(data.cntrCorpList);
				
*/
				/* 기간별 */
				for (var j=0; j<data.cntrDataList.length; j++) {
				    var selectedVal = "";
				    var cntrDtYyyy	= data.cntrDataList[j].cntrDtYyyy;
				    
				    if (cntrDtYyyy != undefined) {
                    	if (pCntrctYear == cntrDtYyyy) {
                        	selectedVal = "selected";
                    	}

                		yearOption = "<option value=\""+cntrDtYyyy+"\""+selectedVal+"\>"+cntrDtYyyy+"년</option>";
                		$('#cntrctYear').append(yearOption);
				    }
				}
				
                for (var i=0; i<data.cntrDataList.length; i++) {
                    
                    var cntrDtYyyy	= data.cntrDataList[i].cntrDtYyyy;
                    //var cntrColor 	= data.dataList[i].cntrColor;
                    var cntrJan  	= Math.round(data.cntrDataList[i].Jan/1000000);
                    var cntrFeb  	= Math.round(data.cntrDataList[i].Feb/1000000);
                    var cntrMar  	= Math.round(data.cntrDataList[i].Mar/1000000);
                    var cntrApr  	= Math.round(data.cntrDataList[i].Apr/1000000);
                    var cntrMay  	= Math.round(data.cntrDataList[i].May/1000000);
                    var cntrJun  	= Math.round(data.cntrDataList[i].Jun/1000000);
                    var cntrJul  	= Math.round(data.cntrDataList[i].Jul/1000000);
                    var cntrAug  	= Math.round(data.cntrDataList[i].Aug/1000000);
                    var cntrSept 	= Math.round(data.cntrDataList[i].Sept/1000000);
                    var cntrOct  	= Math.round(data.cntrDataList[i].Oct/1000000);
                    var cntrNov  	= Math.round(data.cntrDataList[i].Nov/1000000);
                    var cntrDece 	= Math.round(data.cntrDataList[i].Dece/1000000);
                    var aQuarter	= Math.round(data.cntrDataList[i].aQuarter/1000000);
                    var bQuarter	= Math.round(data.cntrDataList[i].bQuarter/1000000);
                    var cQuarter	= Math.round(data.cntrDataList[i].cQuarter/1000000);
                    var dQuarter	= Math.round(data.cntrDataList[i].dQuarter/1000000);
                    var cntrClass   = ""
                    
                    if (cntrDtYyyy == undefined) {
                        cntrDtYyyy = "합계";
                        cntrClass = "bg_gray";
                    }else{
                        cntrClass = "";
                    }
                    
                    var cntrTotal   = (cntrJan + cntrFeb + cntrMar + cntrApr + cntrMay + cntrJun + cntrJul + cntrAug + cntrSept + cntrOct + cntrNov + cntrDece);

                    
                    // <td style="text-align: center;"><span style="text-align: right;display:inline-block;width: 70%;">
                    innerHtml = "<tr class='"+cntrClass+"'><th>"+cntrDtYyyy+"</th>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrJan)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrFeb)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrMar)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrApr)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrMay)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrJun)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrJul)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrAug)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrSept)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrOct)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrNov)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrDece)+"</span></td>";
                    innerHtml = innerHtml + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntrTotal)+"</span></td></tr>";
                    
                    if (cntrDtYyyy == pCntrctYear) {
	                    $('#cntrctSttusList').html(innerHtml);
                    }else{
	                    $('#cntrctSttusList').append(innerHtml);                        
                    }
                    
                    var selectedVal = "";
                    if (cntrDtYyyy !="합계") {
	                    var backgroundColor;
	                    
	                	if (cntrDtYyyy == "2016") {
	                	    backgroundColor = window.chartColors.red;
	                	}else if (cntrDtYyyy == "2017") {
	                	    backgroundColor = window.chartColors.blue;
	                	}else{
	                	    backgroundColor = window.chartColors.orange;
	                	}
	                    
	                	if (pCntrctType == "MT") {
		                	testJson = {
		                            	label : cntrDtYyyy, 
		                            	backgroundColor: backgroundColor,
		                                data: [cntrJan, cntrFeb, cntrMar, cntrApr, cntrMay, cntrJun, cntrJul, cntrAug, cntrSept, cntrOct, cntrNov, cntrDece]
		                               };
	                	}else{
		                	testJson = {
		                	        	 label : cntrDtYyyy, 
		                	        	 backgroundColor: backgroundColor, 
		                	        	 data: [aQuarter, bQuarter, cQuarter, dQuarter]
		                		       };
	                	}
	                    newJson.push(testJson);
                    }
                    
                    if (cntrDtYyyy == pCntrctYear) {
                        break;
                    }
                }
               
                
                var ctx = document.getElementById("barChart01").getContext('2d');
                if (pCntrctType == "MT") {
	                var barChart01 = new Chart(ctx, {
	                    type: 'bar',
	                    data: {
	                        	labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
	                            datasets: newJson           
	                    	},
	                    options: {
	                        tooltips: {
	                            mode: 'index',
	                            intersect: false
	                        },
	                        legend: {
	                            display: true
	                        }
	                    }
	                });
                }else{
                    var barChart01 = new Chart(ctx, {
                        type: 'bar',
                        data: { labels: ["1/4분기", "2/4분기", "3/4분기", "4/4분기"],
                                datasets: newJson
                    		  },
                    	options: {
                    	    	   tooltips: {
                    	    	              mode: 'index',
                    	    	              intersect: false
                    	    	             },
                    	    	   legend: {
                    	    	             display: true
                    	    	           }
                                 }
                    });
                }
                
				/* 서비스 구분별 */
                var testCntrJson = [];
                var newCntrJson = [];
                for (var s=0; s < data.cntrTpList.length; s++) {
                    var cntrDt  = data.cntrTpList[s].cntrDt;
                    var saasCnt = data.cntrTpList[s].saasCnt;
                    var paasCnt = data.cntrTpList[s].paasCnt;
                    var iaasCnt = data.cntrTpList[s].iaasCnt;
                    var cntSum  = data.cntrTpList[s].cntSum;
                    
                    var cntrYear = "";
                    if (cntrDt =="합계") {
                        cntrYear = cntrDt;
                    }else{
                        cntrYear = cntrDt + "년";
                    }
                    
                    innerHtml = "<tr>"
                              + "<th>"+cntrYear+"</th>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(saasCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(paasCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(iaasCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntSum)+"</span></td>"
                              + "</tr>";
                    if (cntrDt == pCntrctYear) {
                        $('#typeList').html(innerHtml);
                    }else{
                    	$('#typeList').append(innerHtml);
                    }

                    if (cntrDt !="합계") {
						var backgroundColor;
                    
	                	if (cntrDt == "2016") {
	                	    backgroundColor = window.chartColors.red;
	                	}else if (cntrDt == "2017") {
	                	    backgroundColor = window.chartColors.blue;
	                	}else{
	                	    backgroundColor = window.chartColors.orange;
	                	}

	                    testCntrJson = {
	                        	label : cntrDt, 
	                        	backgroundColor: backgroundColor,
	                            data: [saasCnt, paasCnt, iaasCnt]
	                           };
	                    newCntrJson.push(testCntrJson);
                    }
                    
                    if (cntrDt == pCntrctYear) {
                        break;
                    }
                }
 
                var ctx03 = document.getElementById("barChart03").getContext('2d');
                var barChart03 = new Chart(ctx03, {
                    type: 'bar',
                    data: { labels: ["SaaS", "PaaS", "IaaS"],
                            datasets:  newCntrJson
                		  },
                	options: {
                	    	   tooltips: {
                	    	              mode: 'index',
                	    	              intersect: false
                	    	             },
                	    	   legend: {
                	    	             display: true
                	    	           }
                             }
                });
                
                /* 서비스 기업구분별 */
                var testCorpJson = [];
                var newCorpJson = [];
                for (var k=0; k< data.cntrCorpList.length; k++) {
                    var cntrDt  	= data.cntrCorpList[k].cntrDt;
                    var priveCnt	= data.cntrCorpList[k].priveCnt;
                    var corpCnt		= data.cntrCorpList[k].corpCnt;
                    var orgCnt		= data.cntrCorpList[k].orgCnt;
                    var cntSum		= data.cntrCorpList[k].cntSum;
                    
                    var cntrYear = "";
                    if (cntrDt =="합계") {
                        cntrYear = cntrDt;
                    }else{
                        cntrYear = cntrDt + "년";
                    }

                    innerHtml = "<tr>"
                              + "<th>"+cntrYear+"</th>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(priveCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(corpCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(orgCnt)+"</span></td>"
                              + "<td><span style='text-align: right;display:inline-block;width: 70%;'>"+numberWithCommas(cntSum)+"</span></td>"
                              + "</tr>";
                    if (cntrDt == pCntrctYear) {
                        $('#corpList').html(innerHtml);
                    }else{
                    	$('#corpList').append(innerHtml);
                    }
                    
                    if (cntrDt !="합계") {
						var backgroundColor;
                    
	                	if (cntrDt == "2016") {
	                	    backgroundColor = window.chartColors.red;
	                	}else if (cntrDt == "2017") {
	                	    backgroundColor = window.chartColors.blue;
	                	}else{
	                	    backgroundColor = window.chartColors.orange;
	                	}

	                	testCorpJson = {
	                        	label : cntrDt, 
	                        	backgroundColor: backgroundColor,
	                            data: [priveCnt, corpCnt, orgCnt]
	                           };
	                	newCorpJson.push(testCorpJson);
                    }
                    
                    if (cntrDt == pCntrctYear) {
                        break;
                    }
                    
                }
                
                var ctx04 = document.getElementById("barChart04").getContext('2d');
                var barChart04 = new Chart(ctx04, {
                    type: 'bar',
                    data: { labels: ["개인", "기업", "공공기관"],
                            datasets:  newCntrJson
                		  },
                	options: {
                	    	   tooltips: {
                	    	              mode: 'index',
                	    	              intersect: false
                	    	             },
                	    	   legend: {
                	    	             display: true
                	    	           }
                             }
                });
	        }
	    });
        
    });
    
    var jsSearch = function () {
        document.dataForm.submit();
    }
</script>
</head>
<body>
    <div id="contents">
        <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_cntrctSttus.do">
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" cellspacing="0" border="0" summary="검색 조건">
                        <colgroup>
                            <col width="100" />
                            <col width="100" />
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                        <tbody>
                            <tr>
                            	<th style="text-align:  center;">조회조건</th>
                                <!-- th>계약연도</th -->
                                <td>
									<select id="cntrctYear" name="cntrctYear">
										<option value="" selected="selected">전체</option>
									</select>
                                </td>
                                <!-- th>통계유형</th -->
                                <td>
									<select id="cntrctType" name="cntrctType">
										<option value="MT" <c:if test="${param.cntrctType eq 'MT'}"> selected="selected" </c:if>>월별</option>
										<option value="QU" <c:if test="${param.cntrctType eq 'QU'}"> selected="selected" </c:if>>분기별</option>
									</select>
                                </td>
                                <td>
									&nbsp;&nbsp;<button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;				
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <!-- <button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsClean(); jsSearch();">전체보기</button> -->
                    
                </fieldset>
            </div>
            
        <!-- //검색 -->
        <h4>기간별</h4>
        <!-- <div style="width:100%">전체 N+M 건 <span>(단위 : 백만원)</span></div> -->
        
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width=""/>
            </colgroup>
            <thead>
                <tr>
                	<th>계약연도</th>
                    <th>1월</th>
                    <th>2월</th>
                    <th>3월</th>
                    <th>4월</th>
                    <th>5월</th>
                    <th>6월</th>
                    <th>7월</th>
                    <th>8월</th>
                    <th>9월</th>
                    <th>10월</th>
                    <th>11월</th>
                    <th>12월</th>
                    <th>합계</th>
                </tr>
            </thead>
            <tbody id="cntrctSttusList"></tbody>
        </table>
      
		<div class="dash_cont03_2">
        	<ul class="tabs clearfix">
        		<!-- <li rel="tab1" class="f_l active"><a href="#">계약금액</a></li> -->
               	<!-- <li rel="tab2" class="f_l"><a href="#">계약건수</a></li> -->
            </ul>
            <div class="contentArea" style="width:100%">
            	<div id="tab1" class="tab_content p_relative clearfix">
                	<div class="barCharArea f_l"  style="width:50%">
                        <canvas id="barChart01"></canvas>
                    </div>
                	<div class="barCharArea f_l"  style="width:50%">
                   		<canvas id="barChart02"></canvas>
                   	</div>
                </div>
            </div>
        </div>
			
		<br/>
		
		<h4>서비스 구분별</h4>
			
        <div style="overflow:auto;">
	        <div style=" float: left; width: 50%;overflow:auto;">

		        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
		            <caption class="hidden"> 목록 </caption>
		            <colgroup>
		                <col width="15%"/>
		                <col width=""/>
		                <col width=""/>
		                <col width=""/>
		                <col width=""/>
		            </colgroup>
		            <thead>
		                <tr>
		                	<th>연도</th>
		                    <th>SaaS</th>
		                    <th>PaaS</th>
		                    <th>IaaS</th>
		                    <th>합계</th>
		                </tr>
		            </thead>
		            <tbody id="typeList">
		            </tbody>
		        </table>

			
			</div>
			
			<div style="float: left; width: 2%;overflow:auto;">
			&nbsp;
			</div>
			
			<div style="float: left; width: 48%;overflow:auto;">


		
		        <div class="dash_cont03_2">
		        	<ul class="tabs clearfix">
		        		<!-- <li rel="tab1" class="f_l active"><a href="#">계약금액</a></li> -->
		               	<!-- <li rel="tab2" class="f_l"><a href="#">계약건수</a></li> -->
		            </ul>
		            <div>
		            	<div id="tab2">
		                	<div class="barCharArea f_l">
		                        <canvas id="barChart03"></canvas>
		                    </div>
		                </div>
		            </div>
		        </div>


			
			</div>
        </div>
        
        <br/>
	        
	        
	        
         
        
        <h4>서비스 기업구분별</h4>
        
        <div style="overflow:auto;">
	        <div style=" float: left; width: 50%;overflow:auto;">

				<table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
		            <caption class="hidden"> 목록 </caption>
		            <colgroup>
		                <col width="15%"/>
		                <col width=""/>
		                <col width=""/>
		                <col width=""/>
		                <col width=""/>
		            </colgroup>
		            <thead>
		                <tr>
		                	<th>연도</th>
		                    <th>중소기업</th>
		                    <th>중견기업</th>
		                    <th>대기업</th>
		                    <th>합계</th>
		                </tr>
		            </thead>
		            <tbody id="corpList">
		            </tbody>
		        </table>

			
			</div>
			
			<div style="float: left; width: 2%;overflow:auto;">
			&nbsp;
			</div>
			
			<div style="float: left; width: 48%;overflow:auto;">


				<div > <!-- class="dash_cont03_2" -->
		        	<ul class="tabs clearfix">
		        		<!-- <li rel="tab1" class="f_l active"><a href="#">계약금액</a></li> -->
		               	<!-- <li rel="tab2" class="f_l"><a href="#">계약건수</a></li> -->
		            </ul>
		            <div>  <!-- class="contentArea" -->
		            	<div id="tab2">
		                	<div class="barCharArea f_l">
		                        <canvas id="barChart04"></canvas>
		                    </div>
		                </div>
		            </div>
		        </div>

			
			</div>
        </div>
        
        
        
        
        
        
<!-- 버튼 
        <div class="mar_t10">  
            <div class="float_r">
                 <button class="w_blue" type="button" onclick="reportAction();">리포트 출력</button>
            </div>
        </div>
//버튼 -->
    </form>        
    </div>
</body>
</html>