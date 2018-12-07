<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var tranChart = new FusionCharts(
            stackChartFile,
            "tranChartId",
            "100%", "250"
        );

        var tranChartXml = "<chart palette='2' showLabels='1' showvalues='0' numberSuffix='건' showSum='1' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        // categories
        tranChartXml += "<categories>";
        <c:forEach items="${dataList}" var="dataVo">
            tranChartXml += "    <category name='<c:out value="${dataVo.title}"/>' showName='1' />";
        </c:forEach>
        tranChartXml += "</categories>";

        // dataset
        tranChartXml += "<dataset seriesName='배정' color='AFD8F8'>";
        <c:forEach items="${dataList}" var="dataVo">
            tranChartXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>
        tranChartXml += "</dataset>";

        tranChartXml += "<dataset seriesName='처리중' color='F984A1'>";
        <c:forEach items="${dataList}" var="dataVo">
            tranChartXml += "    <set value='<c:out value="${dataVo.stat03}"/>' alpha='100' />";
        </c:forEach>
        tranChartXml += "</dataset>";

        tranChartXml += "<dataset seriesName='완료' color='8BBA00'>";
        <c:forEach items="${dataList}" var="dataVo">
            tranChartXml += "    <set value='<c:out value="${dataVo.stat04}"/>' alpha='100' />";
        </c:forEach>
        tranChartXml += "</dataset>";

        tranChartXml += "</chart>";

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            tranChart.setDataXML(tranChartXml);
            tranChart.render("tranChartDiv");
        });


        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="tranChartDiv" class="sa_i"></p>
