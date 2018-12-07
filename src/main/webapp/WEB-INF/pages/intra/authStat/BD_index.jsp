<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>권한통계관리</title>
    <op:jsTag type="spi" items="extjs4" />

    <script type="text/javascript">
        var chartTotal = 0;
        Ext.require(['Ext.chart.*',
                     'Ext.data.*',
                     'Ext.layout.container.Fit']);
        Ext.onReady(function () {
            var getData = function () {
                var fileds = ['name', 'data'];
                var data = [];

                $('table.boardList tbody tr').each(function (index) {
                    data[index] = {name : $(this).find('td').eq(1).text(),
                                   data : $(this).find('td').eq(2).text()};
                    chartTotal += parseInt($(this).find('td').eq(2).text());
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
                        showInLegend: true,
                        donut: false,
                        tips: {
                          trackMouse: true,
                          width: 140,
                          height: 25,
                          renderer: function(storeItem, item) {
                            this.setTitle(storeItem.get('name') + ': ' + Math.round(storeItem.get('data') / chartTotal * 100) + '%');
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
                        }
                    }]
                });


            Ext.create('widget.panel', {
                height: 350,
                title: '권한그룹별통계',
                renderTo: '_chart',
                layout: 'fit',
                items: chart
            });
        });
    </script>
</head>

<body>
        <div>
            <ul class="tab">
                <li><a href="<c:url value="BD_index.do" />" class="on">권한그룹별통계</a></li>
                <li><a href="<c:url value="BD_webPerYear.do" />">권한그룹별접속통계</a></li>
                <li><a href="<c:url value="BD_authPerDept.do" />">부서별통계</a></li>
            </ul>
        </div>
    <div class="buser">

        <!-- 관리자권한그룹 목록 -->
        <h4>권한그룹별 통계</h4>
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
                        <th class="lr_none">인원수</th>
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
                </tbody>
            </table>
        </div>
        <!-- //관리자권한그룹 목록 -->

        <!-- 그래프 -->
        <div id="_chart" class="tx_c float_l" style="width:45%;"></div>
        <!-- //그래프 -->
    </div>

</body>
</html>
