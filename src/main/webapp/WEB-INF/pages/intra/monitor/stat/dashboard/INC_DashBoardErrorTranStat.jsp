<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var errorStatChart = new FusionCharts(
            pieChartFile,
            "errorStatChartId",
            "100%", "200"
        );

        var errorStatChartXml = "<chart formatNumberScale='0' numberSuffix='건' baseFontSize='12'>";

        <c:forEach items="${dataList}" var="dataVo" varStatus="status">
            errorStatChartXml += "    <set value='${dataVo.stat02}' name='배정'/>";
            errorStatChartXml += "    <set value='${dataVo.stat03}' name='처리중'/>";
            errorStatChartXml += "    <set value='${dataVo.stat04}' name='완료'/>";
        </c:forEach>

        errorStatChartXml += "</chart>";

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            errorStatChart.setDataXML(errorStatChartXml);
            errorStatChart.render("errorStatChartDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="errorStatChartDiv" class="sa_i"></p>
