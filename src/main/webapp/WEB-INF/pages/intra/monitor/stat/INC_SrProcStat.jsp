<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var procChart = new FusionCharts(
            pieChartFile,
            "procChartId",
            "100%", "250"
        );

        var procChartXml = "<chart formatNumberScale='0' numberSuffix='건' baseFontSize='12'>";

        <c:forEach items="${dataList}" var="dataVo" varStatus="status">
            procChartXml += "    <set value='${dataVo.stat01}' name='배정'/>";
            procChartXml += "    <set value='${dataVo.stat02}' name='처리중'/>";
            procChartXml += "    <set value='${dataVo.stat03}' name='완료'/>";
        </c:forEach>

        procChartXml += "</chart>";

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            procChart.setDataXML(procChartXml);
            procChart.render("procChartDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="procChartDiv" class="sa_i"></p>
