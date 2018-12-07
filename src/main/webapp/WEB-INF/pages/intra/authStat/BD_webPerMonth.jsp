<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>권한통계관리</title>
    <op:jsTag type="spi" items="ui,extjs4" />

    <script type="text/javascript">
        Ext.require(['Ext.chart.*',
                     'Ext.data.*',
                     'Ext.layout.container.Fit']);
        var fileds = ['month'];
        Ext.onReady(function () {
            var tmpData = [];

            var getData = function () {
                var data   = [];

                var index = 0;
                // <c:forEach items="${chart}" var="_chart" varStatus="stat">
                tmpData[index++] = {name : '${_chart.AUTHNM}',
                                    month1  : parseInt('${_chart.MONTH1}',10),
                                    month2  : parseInt('${_chart.MONTH2}',10),
                                    month3  : parseInt('${_chart.MONTH3}',10),
                                    month4  : parseInt('${_chart.MONTH4}',10),
                                    month5  : parseInt('${_chart.MONTH5}',10),
                                    month6  : parseInt('${_chart.MONTH6}',10),
                                    month7  : parseInt('${_chart.MONTH7}',10),
                                    month8  : parseInt('${_chart.MONTH8}',10),
                                    month9  : parseInt('${_chart.MONTH9}',10),
                                    month10 : parseInt('${_chart.MONTH10}',10),
                                    month11 : parseInt('${_chart.MONTH11}',10),
                                    month12 : parseInt('${_chart.MONTH12}',10),
                                    };
                // </c:forEach>

                for (var i = 1; i < 13; i++) {
                    var vv = {};
                    vv['month'] = i + '월';
                    for (var k = 0; k < index; k++) {
                        if (i == 1) {
                            fileds.push(tmpData[k]['name']);
                        }
                        vv[tmpData[k]['name']] = tmpData[k]['month' + i];
                    }
                    data[i-1] = vv;
                }

                return Ext.create('Ext.data.JsonStore', {
                    fields : fileds,
                    data   : data
                });
            };

            var chart = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                animate: true,
                shadow: true,
                store: getData(),
                legend: {
                    position: 'right'
                },
                axes: [{
                    type: 'Numeric',
                    position: 'left',
                    fields: fileds.slice(1),
                    title: '접속수',
                    grid: true,
                    minimum: 0
                }, {
                    type: 'Category',
                    position: 'bottom',
                    fields: ['month'],
                    title: '월'
                }],
                series: [{
                    type: 'column',
                    axis: 'left',
                    gutter: 80,
                    xField: 'month',
                    yField: fileds.slice(1),
                    tips: {
                        trackMouse: true,
                        width: 60,
                        height: 28,
                        renderer: function(storeItem, item) {
                            this.setTitle(String(item.value[0] + "(" + item.value[1] + ")"));
                        }
                    }
                }]
            });

            if (tmpData.length == 0) {
                return;
            }


            Ext.create('widget.panel', {
                height: 350,
                title: '권한그룹별통계',
                renderTo: '_chart',
                layout: 'fit',
                items: chart
            });
        });

        $().ready(function() {
            var YEAR_GAP = 5;
            var THIS_YEAR = new Date().getFullYear();
            var htmlStr = '';
            for (var i = 0; i < YEAR_GAP; i++) {
                htmlStr += '<option>'+(THIS_YEAR - i)+'</option>';
            }
            $(htmlStr).appendTo('#q_year');
            $('#q_year').val('${param.q_year}');


            if ('${param.q_year}' == '') {
                $('h4 > span.tx_red').text(THIS_YEAR + '년');
            }

            if ($('#q_stDate').val() == '' && $('#q_enDate').val() == '') {
                var firstDate = new Date();
                firstDate.setDate(1);

                var lastDate = new Date();
                lastDate.setMonth(lastDate.getMonth() + 1);
                lastDate.setDate(0);

                $('#q_stDate').val(getDateStr(firstDate));
                $('#q_enDate').val(getDateStr(lastDate));
            }

            $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

            $('#q_stDate').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true,
            });
            $('#q_enDate').datepicker({
                showOn : 'button',
                defaultDate : null,
                buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
                buttonImageOnly : true,
            });
        });

        var getDateStr = function(date) {
            return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
        };

        var set2Str = function(vl) {
            return parseInt(vl,10) > 9 ? vl : '0' + vl;
        };

        var jsSelectTypeChange = function(vl) {
            if (vl == 'day') {
                $('#q_year').hide();
                $('#q_date').show();
            } else {
                $('#q_year').show();
                $('#q_date').hide();
            }
        };

        var jsSearchStat = function() {
            var vl = $('select[name=q_selSearchType]').val();
            var $sForm = $('#sForm');
            if (vl == 'year') {
                sForm.action = 'BD_webPerYear.do';
            } else if (vl == 'month') {
                sForm.action = 'BD_webPerMonth.do';
            } else if (vl == 'day') {
                sForm.action = 'BD_webPerDay.do';
            }
            $sForm.submit();
        };
    </script>
</head>

<body>
    <div>
        <ul class="tab">
            <li><a href="<c:url value="BD_index.do" />">권한그룹별통계</a></li>
            <li><a href="<c:url value="BD_webPerYear.do" />" class="on">권한그룹별접속통계</a></li>
            <li><a href="<c:url value="BD_authPerDept.do" />">부서별통계</a></li>
        </ul>
    </div>

    <div class="buser">
        <!-- 관리자권한그룹 목록 -->
        <form id="sForm" method="post">
        <div class="search" style="text-align: left; padding-left: 10px;">
            <select name="q_selSearchType" onchange="jsSelectTypeChange(this.value);">
                <option value="year">연도별</option>
                <option value="month" selected="selected">월별</option>
                <option value="day">요일별</option>
            </select>
            <select id="q_year" name="q_year"></select>
            <span id="q_date" style="display: none;">
                <input type="text" id="q_stDate" name="q_stDate" class="w120" value="${param.q_stDate}" />
                <input type="text" id="q_enDate" name="q_enDate" class="w120" value="${param.q_enDate}" />
            </span>
            <span class="vt"><button type="button" class="s_blue mar_l5" onclick="jsSearchStat();">검색</button></span>
        </div>
        </form>

        <h4>권한그룹별 월별 접속통계</h4>
        <div class="float_l mar_r30" style="width:50%;">
            <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
                <caption class="hidden"> 목록 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="" />
                    <col width="30%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>권한그룹명</th>
                        <th class="lr_none">접속수</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${stat}" var="_item" varStatus="stat">
                    <tr>
                        <td>${stat.count}</td>
                        <td>${_item.AUTHNM}</td>
                        <td class="lr_none">${_item.PERSONTCNT}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${stat}" colspan="3" msg="해당년도에 접속정보가 없습니다." />
                </tbody>
            </table>
        </div>
        <!-- //관리자권한그룹 목록 -->

        <!-- 그래프 -->
        <div id="_chart" class="tx_c float_l" style="width:45%;"></div>
        <!-- //그래프 -->

        <!-- 조회기간 -->
        <div class="float_l w_100p mar_t30">
        <h4>조회기간 : <span class="tx_red">${param.q_year}년</span></h4>
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="4%" />
                <col width=""   />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
                <col width="6%" />
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>권한그룹명</th>
                    <th>총접속 수</th>
                    <th>비율(%)</th>
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
                    <th class="lr_none">12월</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${stat}" var="_item" varStatus="stat">
                <tr>
                    <td>${stat.count}</td>
                    <td>${_item.AUTHNM}</td>
                    <td>${_item.PERSONTCNT}</td>
                    <td>${_item.PERSONTCNTPERCENT}%</td>
                    <td>${_item.MONTH1}</td>
                    <td>${_item.MONTH2}</td>
                    <td>${_item.MONTH3}</td>
                    <td>${_item.MONTH4}</td>
                    <td>${_item.MONTH5}</td>
                    <td>${_item.MONTH6}</td>
                    <td>${_item.MONTH7}</td>
                    <td>${_item.MONTH8}</td>
                    <td>${_item.MONTH9}</td>
                    <td>${_item.MONTH10}</td>
                    <td>${_item.MONTH11}</td>
                    <td class="lr_none">${_item.MONTH12}</td>
                </tr>
                </c:forEach>
                <op:no-data obj="${stat}" colspan="16" />
            </tbody>
        </table>
        </div>
        <!-- //조회기간 -->
    </div>

</body>
</html>
