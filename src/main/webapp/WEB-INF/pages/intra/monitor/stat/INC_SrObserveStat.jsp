<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var observeChart = new FusionCharts(
            msCombiChartFile,
            "observeChartId",
            "100%", "250"
        );

        var observeChartXml = "<chart showValues='1' numberSuffix='건' sNumberSuffix='일' decimals='3' setAdaptiveYMin='1' setAdaptiveSYMin='1' lineThickness='5' baseFontSize='12'>";

        // categories
        observeChartXml += "<categories>";
        <c:forEach items="${dataList}" var="dataVo">
            observeChartXml += "    <category name='<c:out value="${dataVo.title}"/>' showName='1' />";
        </c:forEach>
        observeChartXml += "</categories>";

        // dataset
        observeChartXml += "<dataset seriesName='총계'>";
        <c:forEach items="${dataList}" var="dataVo">
            observeChartXml += "    <set value='<c:out value="${dataVo.stat01}"/>' alpha='100' />";
        </c:forEach>
        observeChartXml += "</dataset>";

        // dataset
        observeChartXml += "<dataset seriesName='평균' color='F984A1' parentYAxis='S'>";
        <c:forEach items="${dataList}" var="dataVo">
            observeChartXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>
        observeChartXml += "</dataset>";

        observeChartXml += "</chart>";

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            observeChart.setDataXML(observeChartXml);
            observeChart.render("observeChartDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="observeChartDiv" class="sa_i"></p>
