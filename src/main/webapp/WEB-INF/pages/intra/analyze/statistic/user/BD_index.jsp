<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>회원 통계</title>
    <op:jsTag type="spi" items="ui,extjs4" />
    <script type='text/javascript'>

        var getDateStr = function(date) {
            var set2Str = function(vl) {
                return parseInt(vl,10) > 9 ? vl : '0' + vl;
            };
            return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
        };
    
        var getCalDate = function(date, months, days) {
            var newDate = date;
            if (typeof(date.getDate) != 'function') {
                newDate = new Date();
            }
            newDate.setMonth(newDate.getMonth() + months);
            newDate.setDate(newDate.getDate() + days);
            return newDate;
        };
    
        $().ready(function(){
            $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
            
            $('#q_startDate').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
                buttonImageOnly : true,
            });
            $('#q_endDate').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
                buttonImageOnly : true,
            });

            /* initChartPie2(); */
            initChartPie();

            $("#d-0").click(function() {
                var today = new Date();
                $('#q_endDate').val(getDateStr(today));
                $('#q_startDate').val(getDateStr(today));
            });
            $("#d-1").click(function() {
                var today = new Date();
                $('#q_endDate').val(getDateStr(today));
                $('#q_startDate').val(getDateStr(getCalDate(today, 0, -1)));
            });
            $("#d-7").click(function() {
                var today = new Date();
                $('#q_endDate').val(getDateStr(today));
                $('#q_startDate').val(getDateStr(getCalDate(today, 0, -6))); // -6일을 계산해야 7일이 조회됨
            });
            $("#m-1").click(function() {
                var today = new Date();
                $('#q_endDate').val(getDateStr(today));
                $('#q_startDate').val(getDateStr(getCalDate(today, -1, 0)));
            });
            $("#m-3").click(function() {
                var today = new Date();
                $('#q_endDate').val(getDateStr(today));
                $('#q_startDate').val(getDateStr(getCalDate(today, -3, 0)));
            });
        });

        Ext.require(['Ext.chart.*',
                     'Ext.data.*',
                     'Ext.layout.container.Fit']);

        var initChartPie = function() {
            var chartTotal = 0;
            var getData = function () {
                var fileds = ['name', 'data'];
                var data = [];
            
                $('._chartData').each(function (index) {
                    var text = $("._chartTitle")[index].innerText;
                    var value = $(this).text();
                    data[index] = {name : text,
                                   data : value};
                    chartTotal += parseInt(value);
                });
                
                return Ext.create('Ext.data.JsonStore', {
                    fields : fileds,
                    data   : data
                });
            };

            var chart = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                id: 'chartCmp',
                animate: true,
                store: getData(),
                shadow: true,
                legend: {
                    position: 'right'
                },
                insetPadding: 15,
                theme: 'Base:gradients',
                series: [{
                    type: 'pie',
                    field: 'data',
                    //showInLegend: true,
                    donut: false,
                    tips: {
                      trackMouse: true,
                      width: 160,
                      height: 25,
                      renderer: function(storeItem, item) {
                        this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / chartTotal * 100) + '%' + ' (' + storeItem.get('data') + '명)');
                      }
                    },
                    highlight: {
                      segment: {
                        margin: 10
                      }
                    },
                    label: {
                        field: 'name',
                        display: 'rotate',
                        contrast: true,
                        font: '12px Arial'
                    },
                    colorSet : ['rgb(205, 62, 62)',
                                'rgb(226, 145, 41)', 
                                'rgb(156, 177, 17)', 
                                'rgb(17, 177, 69)', 
                                'rgb(38, 93, 193)', 
                                'rgb(151, 38, 193)']
                }]
            });

            $("#_chartPie").html('');
            Ext.create('widget.panel', {
                height: 300,
                title: '',
                renderTo: '_chartPie',
                layout: 'fit',
                items: chart
            });
        };

        var initChartPie2 = function() {
            var chartTotal = 0;
            var getData = function () {
                var fileds = ['name', 'data'];
                var data = [];
            
                $('._chartData2').each(function (index) {
                    var text = $("._chartTitle2")[index].innerText;
                    var value = $(this).text();
                    data[index] = {name : text,
                                   data : value};
                    chartTotal += parseInt(value);
                });
                
                return Ext.create('Ext.data.JsonStore', {
                    fields : fileds,
                    data   : data
                });
            };

            var chart2 = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                id: 'chartCmp',
                animate: true,
                store: getData(),
                shadow: true,
                legend: {
                    position: 'right'
                },
                insetPadding: 15,
                theme: 'Base:gradients',
                series: [{
                    type: 'pie',
                    field: 'data',
                    //showInLegend: true,
                    donut: false,
                    tips: {
                      trackMouse: true,
                      width: 160,
                      height: 25,
                      renderer: function(storeItem, item) {
                          this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / chartTotal * 100) + '%' + ' (' + storeItem.get('data') + '명)');
                      }
                    },
                    highlight: {
                      segment: {
                        margin: 10
                      }
                    },
                    label: {
                        field: 'name',
                        display: 'rotate',
                        contrast: true,
                        font: '12px Arial'
                    },
                    colorSet : ['rgb(38, 93, 193)', 
                                'rgb(151, 38, 193)', 
                                'rgb(219, 68, 143)', 
                                'rgb(177, 177, 177)']
                }]
            });

            $("#_chartPie2").html('');
            Ext.create('widget.panel', {
                height: 200,
                title: '',
                renderTo: '_chartPie2',
                layout: 'fit',
                items: chart2
            });
        };

        var search = function() {
            if($("#q_startDate").val() == ''){
                jsWarningBox("검색 시작일을 입력해 주세요.");
                $("#q_startDate").focus();
            }
            if($("#q_endDate").val() == ''){
                jsWarningBox("검색 종료일을 입력해 주세요.")
                $("#q_endDate").focus();
            }
            $("#searchForm").attr("action", "BD_index.do").submit();
        };

        var jsExcelView = function () {
            $("#searchForm").attr("action", "INC_EXCEL.do").submit();
            
        };
        
        var reportAction = function(){
            var endDate = $("#q_endDate").val();
            var yyyymmdd = $("#q_endDate").val().replace(/-/gi, "");
            
            var open = "/report/reporting.jsp?reportSection=2002&q_endDate="+endDate+"&yyyymmdd="+yyyymmdd;
            window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
        };
    </script>
</head>
<body>
    <input type='hidden' id='q_compareFlag' value='<c:out value='${searchMap.q_compareFlag}' default='1' />'/>
    <div class='mar_t20'>
        <div class='search'>
            <fieldset style="margin-left: 20%;">
                <form class="float_l" name="searchForm" id="searchForm">
                    <label class='tx_b'>기간설정 : </label>
                    <input type='text' id='q_startDate' name='q_startDate' class='w120' value='<c:out value='${searchMap.q_startDate}'/>' title='시작일' readonly="readonly"/>~ 
                    <input type='text' id='q_endDate' name='q_endDate' class='w120' value='<c:out value='${searchMap.q_endDate}'/>' title='날짜선택' readonly="readonly"/>
                </form>
                <button class='gray float_l' onclick='search();'>검색</button>
                <button id="d-0" class='s_blue mar_l5 mar_b5 float_l'>당일</button>
                <button id="d-1" class='s_blue mar_l5 mar_b5 float_l'>전일</button>
                <button id="d-7" class='s_blue mar_l5 mar_b5 float_l'>7일</button>
                <button id="m-1" class='s_blue mar_l5 mar_b5 float_l'>1개월</button>
                <button id="m-3" class='s_blue mar_l5 mar_b5 float_l'>3개월</button>
                <button class='s_blue mar_l20 mar_b5 float_l' onclick="jsExcelView()">엑셀저장</button>
            </fieldset>
        </div>
        <h5 style="padding: 21px 0;">
            <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' />
            <span class='tx_red'><c:out value='${searchMap.q_startDate}'/> ~ <c:out value='${searchMap.q_endDate}'/></span>까지 분석된 접속통계입니다.
        </h5>
    </div>
    <!-- 국내 -->
    <div style="float: left; width: 100%;">
        <div id="_chartPie"></div>
        <div class="graph_detail_text" style="float:left; border:3px solid #e1e1e1; padding:10px; width: 100%;">
            <ul id='_chartData'>
                <c:set var="color" value="1" />
                <c:set var="korColspan" value="1"/>
                <c:forEach items="${dataList}" var="topData">
                    <c:if test="${topData.NATION eq '국내' and not empty topData.USERTYNM}">
                        <li>
                            <div class="float_l">
                                <img src="<c:url value="/resources/openworks/theme/default/images/contents/statistics_color_${color}.gif"/>" alt="" class="vm" />
                                <strong class="_chartTitle">&nbsp;<c:out value="${topData.USERTYNM}"/></strong>
                                <%-- <strong>${topData.NATION}</strong><strong class="_chartTitle">&nbsp;<c:out value="${topData.USERTYNM}"/></strong> --%>
                            </div>
                            <div class="float_r w160">
                                <span class="tx_blue float_l">[<span ${topData.CNT == 0 ? '' : 'class="_chartData"'}><c:out value="${topData.CNT}"/></span>]</span>
                                <span class="tx_red float_r">${topData.PARTRATE}%</span>
                            </div>
                        </li>
                        <c:set var="color" value="${color+1}" />
                        <c:set var="korColspan" value="${korColspan + 1}"/>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div>
    <!-- 해외 -->
    <%-- <div style="float: right; width: 50%;">
        <div id="_chartPie2"></div>
        <div class="graph_detail_text" style="float:left; border:3px solid #e1e1e1; padding:10px; width: 100%;">
            <ul id='_chartData2'>
                <c:set var="othColspan" value="1"/>
                <c:forEach items="${dataList}" var="topData" varStatus="topList">
                    <c:if test="${topData.NATION eq '해외' and not empty topData.USERTYNM}">
                        <li>
                            <div class="float_l">
                                <img src="<c:url value="/resources/openworks/theme/default/images/contents/statistics_color_${color}.gif"/>" alt="" class="vm" />
                                <strong>${topData.NATION}</strong><strong class="_chartTitle2">&nbsp;<c:out value="${topData.USERTYNM}"/></strong>
                            </div>
                            <div class="float_r w160">
                                <span class="tx_blue float_l">[<span ${topData.CNT == 0 ? '' : 'class="_chartData2"'}><c:out value="${topData.CNT}"/></span>]</span>
                                <span class="tx_red float_r">${topData.PARTRATE}%</span>
                            </div>
                        </li>
                        <c:set var="color" value="${color+1}" />
                        <c:set var="othColspan" value="${othColspan + 1}"/>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
    </div> --%>
    <c:forEach items="${dataList}" var="topData" varStatus="topList">
        <c:if test="${topList.count == korColspan and korColspan != 1}">
            <c:set var="korUser" value="${topData.CNT}"/>
        </c:if>
        <c:if test="${topList.count == korColspan+othColspan and othColspan != 1}">
            <c:set var="othUser" value="${topData.CNT}" />
        </c:if>
        <c:if test="${topList.last}">
            <c:set var="totalUser" value="${topData.CNT}" />
        </c:if>
    </c:forEach>
    <div class="clear mar_b20" style="position: absolute;top: 124px;font-size: 16px;">
        <strong>전체회원수 : <span class="tx_red">${totalUser}</span>명
        <%-- <strong>전체회원수 : <span class="tx_red">${totalUser}</span>명&nbsp;&nbsp;&nbsp;&nbsp;국내전체회원수 : <span class="tx_red">${korUser}</span>명&nbsp;&nbsp;&nbsp;&nbsp;해외전체회원수 : <span class="tx_red">${othUser}</span>명</strong> --%>
    </div>
    <table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
        <caption class='hidden'> 목록 </caption>
        <colgroup>
            <%-- <col width='10%'/> --%>
            <col width='33%'/>
            <col width='33%'/>
            <col width='33%'/>
        </colgroup>
        <thead id='listHead'>
            <tr>
                <!-- <th colspan="2"><span id='sort' id='1'>회원유형</span></th> -->
                <th><span id='sort' id='1'>회원유형</span></th>
                <th><span id='sort' id='2'>회원수</span></th>
                <th class='lr_none'><span id='sort' id='3'>전체회원대비 비율</span></th>
            </tr>
        </thead>
        <tbody id='listBody'>
            <c:set var="idx" value="1" />
            <c:forEach items='${dataList}' var='data'>
                <c:if test="${not empty data.NATION and not empty data.USERTYNM}">
                    <tr <c:if test='${(idx mod 2) eq 0 }'> class='bg_yellow'</c:if>>
                        <%-- <c:if test="${idx == 1}">
                           <td rowspan="${korColspan-1}" title="<c:out value='${data.NATION}'/>"><c:out value='${data.NATION}'/></td>
                        </c:if> --%>
                        <c:if test="${idx == korColspan}">
                           <td rowspan="${othColspan}" title="<c:out value='${data.NATION}'/>"><c:out value='${data.NATION}'/></td>
                        </c:if>
                        <td class='tx_l' title='<c:out value='${data.USERTYNM}'/>'><c:out value='${data.USERTYNM}'/></td>
                        <td class='tx_r' title='<c:out value='${data.CNT}'/>'><c:out value='${data.CNT}'/></td>
                        <td class='tx_r' title='<c:out value='${data.RATE}'/> %'><c:out value='${data.RATE}'/> %</td>
                    </tr>
                    <c:set var="idx" value="${idx+1}" />
                </c:if>
                <c:if test="${empty data.NATION}">
                   <c:set var="totalCnt" value="${data.CNT}" /><!-- 회원수 합계 -->
                   <c:set var="totalRate" value="${data.RATE}" /><!-- 비율 합계 -->
                </c:if>
            </c:forEach>
            <op:no-data obj="${dataList}" colspan="5" />
        </tbody>
        <tfoot>
            <tr class='bg_gray'>
                <!-- <td title='합계' colspan="2">합계</td> -->
                <td title='합계'>합계</td>
                <td class='tx_r' title='<c:out value='${totalCnt}'/>'><c:out value='${totalCnt}'/></td>
                <td class='tx_r lr_none' title='${totalRate}%'>${totalRate}%</td>
            </tr>
        </tfoot>
    </table>
    <!-- 리포트 버튼  -->
	<div class="float_r" style="padding-top: 5px;;">
	     <button class="w_blue" type="button" onclick="reportAction();">일일보고 출력</button>
	</div>
	<br /><br/>
	<!--  //리포트 버튼 -->
</body>
</html>