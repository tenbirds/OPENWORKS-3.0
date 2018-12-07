<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

<html>
<head>
    <title>마일리지 관리</title>
    <op:jsTag type="spi" items="form,validate,highlight,extjs4" />
    <op:jsTag type="openworks" items="ui" />

    <script type="text/javascript">

    $().ready( function() {
        $("#chart0").html('');
        Ext.create('widget.panel', {
            height: 400,
            width : 1000,
            title: '년도별 마일리지 통계',
            renderTo: 'chart0',
            layout: 'fit',
            items: chart0
        });


    });

    Ext.require(['Ext.chart.*',
                 'Ext.data.*',
                 'Ext.layout.container.Fit']);


    var getData = function (idx) {
        var fileds = ['application','cancel','year'];
        var data = [new Array()];


        <c:forEach items="${dataList0}" var="data0">
            data[0].push({
                application : <c:out value="${data0.value4}"/>,
                cancel : <c:out value="${data0.value3}"/>,
                year : <c:out value="${data0.year}"/>
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
        width : 1000,
        store: getData(0),
        axes: [{
            type: 'Numeric',
            position: 'left',
            fields: ['application'],
            title: '마일리지',
            grid: true,
            minimum: 0
        }, {
            type: 'Category',
            position: 'bottom',
            fields: ['year'],
            title: '년도'
        }],
        series: [{
            type: 'column',
            gutter: 80,
            yField: ['application','cancel'],
            tips: {
                trackMouse: true,
                width: 100,
                height: 50,
                renderer: function(value) {
                    this.setTitle(value);
                }
            }
        }]
    });



    var jsSearchAction = function(){
        $("#dataForm").submit();
    };


    </script>
</head>

<body>
<div>
    <ul class="tab">
        <li><a href="<c:url value="../mng/BD_index.do" />">마일리지 항목 설정</a></li>
        <li><a href="<c:url value="../read/BD_index.do" />">회원 마일리지 조회</a></li>
        <li><a href="<c:url value="../status/BD_index.do" />" class="on">마일리지 통계</a></li>
        <li><a href="<c:url value="../voucher/BD_index.do" />">서비스권 신청</a></li>
    </ul>
</div>
<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
<div id="contents">
    <div>
    <ul class="tab_s">
        <li class="on"><a href="<c:url value="../status/BD_index.do" />">년도별 마일리지 통계</a></li>
        <li><a href="<c:url value="../status/BD_month.do" />">월별 마일리지 통계</a></li>
        <li><a href="<c:url value="../status/BD_voucher.do" />">서비스권 신청 통계</a></li>
    </ul>
    </div>
    <div class="search">
        <fieldset>
            <legend>검색할 년도를 선택하세요</legend>
            <!-- 마일리지 타입 선택 -->

            <!-- 검색어 작성-->
            년도 선택 : <input class="w215" type="text" name="endDate" id="endDate" value="${param.endDate}" maxlength="4"/>

            <!-- 검색버튼 -->
            <button class="gray mar_l5 mar_b5" type="button" onclick="jsSearchAction();">검색</button>

        </fieldset>
    </div>
    <div class="clear mar_tb20 tx_c">
                    <div id='chart0'></div>
                </div>
    </div>
</form>
    <div class="po_rel">
            <h4> 년도별 통계자료</h4>
            <span class="h4_r"><button class="s_blue">엑셀출력</button></span>
        </div>
        <table class="boardList" cellspacing="0" border="0">
            <caption class="hidden"> 년도별 통계자료 </caption>
            <colgroup>
                <col width="15%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
            </colgroup>
            <thead>
                <tr>
                    <th rowspan="2">구분</th>
                    <th colspan="2">적립(1)</th>
                    <th colspan="2">차감(2)</th>
                    <th colspan="2" class="lr_none">합계</th>
                </tr>
                <tr>
                    <th>건수</th>
                    <th>점수</th>
                    <th>건수</th>
                    <th>점수</th>
                    <th>건수(1+2)</th>
                    <th class="lr_none">점수(1-2)</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${dataList0}" var="dataVo">
                <tr>
                    <th>${dataVo.year }</th>
                    <td>${dataVo.value2 }</td>
                    <td>${dataVo.value4 }</td>
                    <td class="tx_red">${dataVo.value }</td>
                    <td class="tx_red">${dataVo.value3 }</td>
                    <td>${dataVo.value2 + dataVo.value }</td>
                    <td class="lr_none">${dataVo.value4 - dataVo.value3 }</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
<!-- //컨텐츠영역 -->
</body>
</html>