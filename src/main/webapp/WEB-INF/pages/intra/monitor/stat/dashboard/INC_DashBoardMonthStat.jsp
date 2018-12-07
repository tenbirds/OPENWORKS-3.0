<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var monthError = new FusionCharts(
            columnChartFile,
            "monthErrorId",
            "100%", "250"
        );

        var monthErrorXml = "<chart palette='2' showLabels='1' showvalues='1' numberSuffix='건' showSum='0' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        <c:forEach items="${dataList}" var="dataVo">
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat01}"/>' name='1월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat02}"/>' name='2월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat03}"/>' name='3월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat04}"/>' name='4월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat05}"/>' name='5월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat06}"/>' name='6월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat07}"/>' name='7월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat08}"/>' name='8월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat09}"/>' name='9월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat10}"/>' name='11월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat11}"/>' name='11월'/>";
            monthErrorXml += "    <set value='<c:out value="${dataVo.stat12}"/>' name='12월'/>";
        </c:forEach>

        monthErrorXml += "</chart>";

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            monthError.setDataXML(monthErrorXml);
            monthError.render("monthErrorDiv");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
    </h5>
    <p id="monthErrorDiv" class="sa_i"></p>
