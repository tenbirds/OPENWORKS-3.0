<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var serverError = new FusionCharts(
            stackChartFile,
            "serverErrorId",
            "100%", "250"
        );

        var serverErrorXml = "<chart palette='2' showLabels='1' showvalues='1' numberSuffix='건' showSum='0' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        // categories
        serverErrorXml += "<categories>";
        <c:forEach items="${dataList}" var="dataVo">
            serverErrorXml += "    <category name='<c:out value="${dataVo.title}"/> <c:out value="${dataVo.label}"/> : <c:out value="${dataVo.label1}"/>' showName='1' />";
        </c:forEach>
        serverErrorXml += "</categories>";

        // dataset
        serverErrorXml += "<dataset seriesName='금일이전' color='AFD8F8'>";
        <c:forEach items="${dataList}" var="dataVo">
            serverErrorXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>
        serverErrorXml += "</dataset>";

        serverErrorXml += "<dataset seriesName='금일발생' color='F984A1'>";
        <c:forEach items="${dataList}" var="dataVo">
            serverErrorXml += "    <set value='<c:out value="${dataVo.stat01}"/>' alpha='100' />";
        </c:forEach>
        serverErrorXml += "</dataset>";

        serverErrorXml += "</chart>";

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            serverError.setDataXML(serverErrorXml);
            serverError.render("serverErrorDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
    </h5>

    <p id="serverErrorDiv" class="sa_i"></p>
