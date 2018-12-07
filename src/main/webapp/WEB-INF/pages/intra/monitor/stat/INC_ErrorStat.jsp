<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

    <script type="text/javascript">
        //<CDATA[[

        var chart${param.q_errorAttrNo} = new FusionCharts(
                columnChartFile,
                "chart${param.q_errorAttrNo}${param.q_errorAttrNo}",
                "100%", "250"
        );

        var statusChartXml${param.q_errorAttrNo} = "<chart palette='2' showLabels='1' showvalues='1' numberSuffix='건' showSum='0' decimals='0' useRoundEdges='1' legendBorderAlpha='0' baseFontSize='12'>";

        <c:forEach items="${dataList}" var="dataVo" varStatus="status">
            statusChartXml${param.q_errorAttrNo} += "    <set value='${dataVo.value}' name='${dataVo.label}'/>";
        </c:forEach>

        statusChartXml${param.q_errorAttrNo} += "</chart>";

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            chart${param.q_errorAttrNo}.setDataXML(statusChartXml${param.q_errorAttrNo});
            chart${param.q_errorAttrNo}.render("chart${param.q_errorAttrNo}Div");
        });

        //]]>
    </script>

    <h5>
        ${param.q_title}
        <c:if test="${not empty param.q_startDate}">
            (${param.q_startDate} ~ ${param.q_endDate})
        </c:if>
    </h5>

    <p id="chart${param.q_errorAttrNo}Div" class="sa_i"></p>

    <div class="graph_detail_text">
        <table class="graph_kind">
            <colgroup>
                <col width="4%" />
                <col width="" />
                <col width="12%" />
                <col width="10%" />
            </colgroup>
            <tbody>
            <c:forEach items="${dataList}" var="dataVo" varStatus="status">
                <c:set var="icon_idx" value="${status.count % 6}" />
                <tr>
                    <td><img src="/resources/monitor/images/contents/statistics_color_0${icon_idx}.gif" alt="" /></td>
                    <td class="tx_l">${dataVo.title}</td>
                    <td class="tx_blue"> </td>
                    <td class="tx_red tx_r">${dataVo.value} 회</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
