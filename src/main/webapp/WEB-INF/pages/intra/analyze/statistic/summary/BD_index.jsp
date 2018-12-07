<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>접속통계 요약</title>
        <op:jsTag type='spi' items='ui,extjs4' />
        <script type='text/javascript'>
            var search = function() {
                var doamin = $('#domain').val();
                window.location.href = './BD_index.do?domain=' + doamin;
            };
        </script>
        <script type='text/javascript'>
            $(document).ready(function() {
                $("#chart0").html('');
                Ext.create('widget.panel', {
                    height: 400,
                    width : 700,
                    title: '전체페이지뷰',
                    renderTo: 'chart0',
                    layout: 'fit',
                    items: chart0
                });
                $("#chart1").html('');
                Ext.create('widget.panel', {
                    height: 400,
                    width : 700,
                    title: '전체방문자수',
                    renderTo: 'chart1',
                    layout: 'fit',
                    items: chart1
                });
                $("#chart2").html('');
                Ext.create('widget.panel', {
                    height: 400,
                    title: '많이찾는페이지',
                    renderTo: 'chart2',
                    layout: 'fit',
                    items: chart2
                });
                $("#chart3").html('');
                Ext.create('widget.panel', {
                    height: 400,
                    title: '웹브라우저',
                    renderTo: 'chart3',
                    layout: 'fit',
                    items: chart3
                });
            });

            Ext.require(['Ext.chart.*',
                         'Ext.data.*',
                         'Ext.layout.container.Fit']);
            var getData = function (idx) {
                var fileds = ['name', 'data'];
                var data = [new Array(),new Array(),new Array(),new Array()];


                <c:forEach items="${dataList0}" var="data0">
                    data[0].push({
                        name : '<c:out value="${data0.title}"/>',
                        data : <c:out value="${data0.value}"/>
                    });
                </c:forEach>
                <c:forEach items="${dataList1}" var="data1">
                    data[1].push({
                        name : '<c:out value="${data1.title}"/>',
                        data : <c:out value="${data1.value}"/>
                    });
                </c:forEach>
                <c:forEach items="${dataList2}" var="data2">
                    data[2].push({
                        name : '<c:out value="${data2.title}"/>',
                        data : <c:out value="${data2.value}"/>
                    });
                </c:forEach>
                <c:forEach items="${dataList3}" var="data3">
                    data[3].push({
                        name : '<c:out value="${data3.title}"/>',
                        data : <c:out value="${data3.value}"/>
                    });
                </c:forEach>


                return Ext.create('Ext.data.JsonStore', {
                    fields : fileds,
                    data   : data[idx]
                });
            };
            var chart0 = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                animate: true,
                shadow: true,
                width : 600,
                store: getData(0),
                axes: [{
                    type: 'Numeric',
                    position: 'left',
                    fields: ['data'],
                    title: '페이지뷰',
                    grid: true,
                    minimum: 0
                }, {
                    type: 'Category',
                    position: 'bottom',
                    fields: ['name'],
                    title: '접속일자'
                }],
                series: [{
                    type: 'column',
                    axis: 'left',
                    gutter: 80,
                    xField: 'name',
                    yField: ['data'],
                    tips: {
                        trackMouse: true,
                        width: 74,
                        height: 38,
                        renderer: function(storeItem, item) {
                            this.setTitle(storeItem.get('name'));
                            this.update(storeItem.get('data'));
                        }
                    },
                    style: {
                        fill: '#38B8BF'
                    }
                }]
            });

            var chart1 = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                animate: true,
                shadow: true,
                width : 600,
                store: getData(1),
                axes: [{
                    type: 'Numeric',
                    position: 'left',
                    fields: ['data'],
                    title: '방문자수',
                    grid: true,
                    minimum: 0
                }, {
                    type: 'Category',
                    position: 'bottom',
                    fields: ['name'],
                    title: '방문일자'
                }],
                series: [{
                    type: 'column',
                    axis: 'left',
                    gutter: 80,
                    xField: 'name',
                    yField: ['data'],
                    tips: {
                        trackMouse: true,
                        width: 74,
                        height: 38,
                        renderer: function(storeItem, item) {
                            this.setTitle(storeItem.get('name'));
                            this.update(storeItem.get('data'));
                        }
                    },
                    style: {
                        fill: '#38B8BF'
                    }
                }]
            });

            var chart2 = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                animate: true,
                store: getData(2),
                shadow: true,
                legend: {
                    position: 'left'
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
                    },
                    colorSet : ['rgb(205, 62, 62)',
                                'rgb(226, 145, 41)',
                                'rgb(156, 177, 17)',
                                'rgb(17, 177, 69)',
                                'rgb(38, 93, 193)',
                                'rgb(151, 38, 193)',
                                'rgb(219, 68, 143)',
                                'rgb(177, 177, 177)']
                }]
            });

            var chart3 = Ext.create('Ext.chart.Chart', {
                xtype: 'chart',
                animate: true,
                store: getData(3),
                shadow: true,
                legend: {
                    position: 'left'
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
                    },
                    colorSet : ['rgb(205, 62, 62)',
                                'rgb(226, 145, 41)',
                                'rgb(156, 177, 17)',
                                'rgb(17, 177, 69)',
                                'rgb(38, 93, 193)',
                                'rgb(151, 38, 193)',
                                'rgb(219, 68, 143)',
                                'rgb(177, 177, 177)']
                }]
            });

        </script>
    </head>



    <body>
        <div class='buser'>
	        <select id='domain' name='domain' class='over mar_r20' onchange='search();'>
            <c:forEach var="domainVo" items="${domainList}">
	            <option value='${domainVo.domainNm}' <c:if test="${param.domain eq domainVo.domainNm}">selected='selected'</c:if>>${domainVo.domainNm}</option>
            </c:forEach>
	        </select>
            <h4><span class='tx_red'>2012-04-26 ~ 2012-05-02</span>까지 분석된 주요통계입니다.</h4>
            <div id='chart0' class='graph_half float_l'>
            </div>
            <div id='chart1' class='graph_half float_r'>
            </div>
            <div id='chart2' class='graph_half float_l'>
            </div>
            <div id='chart3' class='graph_half float_r'>
            </div>
        </div>
    </body>
</html>
