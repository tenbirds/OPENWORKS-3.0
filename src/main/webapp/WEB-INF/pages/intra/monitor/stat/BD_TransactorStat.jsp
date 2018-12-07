<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>담당자별 현황</title>

    <op:jsTag type="spi" items="ui, fchart" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        var statusChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/StackedColumn2D.swf"/>";
        var dayChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Pie3D.swf"/>";
    
        var statusChart = new FusionCharts(
            statusChartFile,
            "sChart",
            "100%", "250",
            0, 1
        );

        var dayChart = new FusionCharts(
            dayChartFile,
            "dChart",
            "100%", "250",
            0, 1
        );

        var statusChartXml = "<chart palette='2' showLabels='1' showvalues='0' numberSuffix='건' showSum='1' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        // categories
        statusChartXml += "<categories>";

        <c:forEach items="${pager.list}" var="dataVo">
            statusChartXml += "    <category name='<c:out value="${dataVo.title}"/>' showName='1' />";
        </c:forEach>

        statusChartXml += "</categories>";

        // dataset
        statusChartXml += "<dataset seriesName='배정' color='AFD8F8'>";

        <c:forEach items="${pager.list}" var="dataVo">
            statusChartXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>

        statusChartXml += "</dataset>";


        statusChartXml += "<dataset seriesName='처리중' color='F984A1'>";

        <c:forEach items="${pager.list}" var="dataVo">
            statusChartXml += "    <set value='<c:out value="${dataVo.stat03}"/>' alpha='100' />";
        </c:forEach>

        statusChartXml += "</dataset>";

        statusChartXml += "<dataset seriesName='완료' color='8BBA00'>";

        <c:forEach items="${pager.list}" var="dataVo">
            statusChartXml += "    <set value='<c:out value="${dataVo.stat04}"/>' alpha='100' />";
        </c:forEach>

        statusChartXml += "</dataset>";
        statusChartXml += "</chart>";


        var dayChartXml = "<chart decimalPrecision='0' showPercentageValues='0' showNames='1' numberSuffix='일' ";
        dayChartXml += " showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='100' pieRadius='100' animation='0' ";
        dayChartXml += " shadowXShift='4' shadowYShift='4' shadowAlpha='40' pieFillAlpha='95' baseFontSize='12'>";

        <c:forEach items="${pager.list}" var="dataVo">
        dayChartXml += "    <set value='<c:out value="${dataVo.stat05}"/>' name='<c:out value="${dataVo.title}"/>'/>";
        </c:forEach>

        dayChartXml += "</chart>";

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#q_startDate').datepicker();
            $('#q_endDate').datepicker();

            jsSelected("q_domainCd", "${param.q_domainCd}");
            
            // 담당자 설정 Autocomplete
            $("#q_transactorNm").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/monitor/config/INC_TransactorList.do" />",
                        type: "POST",
                        dataType: "json",
                        data: {
                            q_statusCode: "STABLE",
                            q_transactorNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {

                }
            });

            statusChart.setDataXML(statusChartXml);
            statusChart.render("statusChartDiv");

            dayChart.setDataXML(dayChartXml);
            dayChart.render("dayChartDiv");

        });


        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_TransactorStat.do">

        <div class="search">
            <fieldset>
                <legend>처리현황 목록 검색</legend>

                <label class="skip" for="q_domainCd">사이트목록</label>
                <select name=q_domainCd id="q_domainCd" class="over">
                    <option value="">-- 사이트선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo">
                        <option value="${domainVo.seqNo}">${domainVo.errorAttrNm}</option>
                    </c:forEach>
                </select>

                조회기간(배정일기준) : 
                <label class="skip" for="q_startDate">배정일시작</label>
                <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                <label class="skip" for="q_endDate">배정일끝</label>
                <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                담당자이름 : 
                <label class="skip" for="q_transactorNm">담당자이름</label>
                <input type="text" name="q_transactorNm" id="q_transactorNm" value="${param.q_transactorNm}" />

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
            </fieldset>
        </div>

        <!--그래프부분-->
        <div class="all_graph">
            <div class="graph_half float_l">
                <h5>
                    담당자별 장애처리 상태현황
                    <c:if test="${not empty param.q_startDate}">
                        (${param.q_startDate} ~ ${param.q_endDate})
                    </c:if>                </h5>
                <p class="sa_i" id="statusChartDiv"></p>
            </div>
            <div class="graph_half float_r">
                <h5>
                    담당자별 장애처리 평균소요일
                    <c:if test="${not empty param.q_startDate}">
                        (${param.q_startDate} ~ ${param.q_endDate})
                    </c:if>
                </h5>
                <p class="sa_i" id="dayChartDiv"></p>
            </div>
        </div>
        <!--//그래프부분-->

        <div style="clear: both;">
            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="담당자별 현황 목록" />
        </div>

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="담당자별 처리현황 목록">
        <caption class="hidden">담당자별 처리현황 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>담당자</span></th>
                <th><span>총계</span></th>
                <th><span>배정</span></th>
                <th><span>처리중</span></th>
                <th><span>완료</span></th>
                <th><span>평균소요일</span></th>
            </tr>

            <tr style="background-color: #CFE0FC;">
                <td>총계</td>
                <td></td>
                <td>${baseVo.total}<br />(미배정:${baseVo.stat01})</td>
                <td>${baseVo.stat02}</td>
                <td>${baseVo.stat03}</td>
                <td>${baseVo.stat04}</td>
                <td class="lr_none"><c:if test="${not empty baseVo.stat05}">${baseVo.stat05} 일</c:if></td>
            </tr>

        </thead>

        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">

            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td>${dataVo.title} (${dataVo.value})</td>
                    <td>${dataVo.total}</td>
                    <td>${dataVo.stat02}</td>
                    <td>${dataVo.stat03}</td>
                    <td>${dataVo.stat04}</td>
                    <td class="lr_none"><c:if test="${not empty dataVo.stat05}">${dataVo.stat05} 일</c:if></td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="7" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>