<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류통계 요약</title>

    <op:jsTag type="spi" items="ui, fchart" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        var pieChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Pie3D.swf"/>";
        var barChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Bar2D.swf"/>";
        var columnChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Column2D.swf"/>";
        var stackChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/StackedColumn2D.swf"/>";
        var msCombiChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/MSCombiDY2D.swf"/>";

        var param = {
            q_domainCd : "${param.q_domainCd}",
            q_startDate : "${param.q_startDate}",
            q_endDate : "${param.q_endDate}",
            q_rowPerPage: "<c:out value="${param.q_rowPerPage}" default="5"/>"
        };

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            jsSelected("q_domainCd", "${param.q_domainCd}");

            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#q_startDate').datepicker();
            $('#q_endDate').datepicker();

            param["q_title"] = "처리상태현황";
            // 처리상태현황
            $("#procStatDiv").load("/intra/monitor/stat/INC_SrProcStat.do", param, function() {
            });

            param["q_title"] = "처리기간현황";
            // 처리기간현황
            $("#termStatDiv").load("/intra/monitor/stat/INC_SrTermStat.do", param, function() {
            });

            param["q_title"] = "담당자별현황";
            // 담당자별현황
            $("#tranStatDiv").load("/intra/monitor/stat/INC_SrTranStat.do", param, function() {
            });

            param["q_title"] = "기간준수현황";
            // 기간준수율
            $("#observeStatDiv").load("/intra/monitor/stat/INC_SrObserveStat.do", param, function() {
            });

        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_SrStatSummary.do">

        <div class="search">
            <fieldset>
                <legend>메시지 목록 검색</legend>

                <label class="skip" for="q_domainCd">사이트목록</label>
                <select name=q_domainCd id="q_domainCd" class="over">
                    <option value="">-- 사이트선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo">
                        <option value="${domainVo.seqNo}">${domainVo.errorAttrNm}</option>
                    </c:forEach>
                </select>

                조회기간 : 
                <label class="skip" for="q_startDate">오류발생 시작일</label>
                <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                <label class="skip" for="q_endDate">배정일끝</label>
                <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
            </fieldset>
        </div>

    </form>
    <!-- //검색 -->

    <div class="all_graph">
        <div id="tranStatDiv" class="graph_half float_l">
        </div>
        <div id="termStatDiv" class="graph_half float_r">
        </div>
    </div>

    <div class="all_graph">
        <div id="procStatDiv" class="graph_half float_l">
        </div>
        <div id="observeStatDiv" class="graph_half float_r">
        </div>
    </div>

</body>
</html>