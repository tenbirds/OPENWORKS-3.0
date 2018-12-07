<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var termChart = new FusionCharts(
            stackChartFile,
            "termChartId",
            "100%", "250"
        );

        var termChartXml = "<chart palette='2' showLabels='1' showvalues='0' numberSuffix='건' showSum='1' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        // categories
        termChartXml += "<categories>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <category name='<c:out value="${dataVo.title}"/>' showName='1' />";
        </c:forEach>
        termChartXml += "</categories>";

        // dataset
        termChartXml += "<dataset seriesName='1일이내' color='c2587d'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat01}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "<dataset seriesName='2일이내' color='d99220'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "<dataset seriesName='3일이내' color='801988'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat03}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "<dataset seriesName='4일이내' color='a56a50'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat04}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "<dataset seriesName='5일이내' color='21881a'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat05}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "<dataset seriesName='5일초과' color='8BBA00'>";
        <c:forEach items="${dataList}" var="dataVo">
            termChartXml += "    <set value='<c:out value="${dataVo.stat06}"/>' alpha='100' />";
        </c:forEach>
        termChartXml += "</dataset>";

        termChartXml += "</chart>";

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            termChart.setDataXML(termChartXml);
            termChart.render("termChartDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="termChartDiv" class="sa_i"></p>
