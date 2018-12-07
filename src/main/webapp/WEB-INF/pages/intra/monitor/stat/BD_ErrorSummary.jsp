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

        var columnChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Column2D.swf"/>";

        var param = {
            q_domainCd : "${param.q_domainCd}",
            q_startDate : "${param.q_startDate}",
            q_endDate : "${param.q_endDate}",
            q_rowPerPage: "<c:out value="${param.q_rowPerPage}" default="5"/>"
        };

        /* 공통 초기화 기능 */
        $(document).ready(function() {
            jsSelected("q_domainCd", "${param.q_domainCd}");
            jsSelected("q_rowPerPage", "${param.q_rowPerPage}");

            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#q_startDate').datepicker();
            $('#q_endDate').datepicker();

            param["q_errorAttrNo"] = "1";
            param["q_errorAttr"] = "DOMAIN_CD";
            param["q_target"] = "B";
            param["q_title"] = "사이트별";
            // 사이트별
            $("#serverStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "9";
            param["q_errorAttr"] = "ERROR_RES_CD";
            param["q_target"] = "B";
            param["q_title"] = "응답상태 코드별";
            // 응답상태 코드별
            $("#statusStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "8";
            param["q_errorAttr"] = "ERROR_FILE_CD";
            param["q_target"] = "B";
            param["q_title"] = "오류발생 파일별";
            // 오류발생 파일별
            $("#errorFileStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "6";
            param["q_errorAttr"] = "ERROR_CLASS_CD";
            param["q_target"] = "B";
            param["q_title"] = "오류클레스유형별";
            // 오류클레스유형별
            $("#exceptionStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "3";
            param["q_errorAttr"] = "OS_CD";
            param["q_target"] = "C";
            param["q_title"] = "운영체제별";
            // 운영체제별
            $("#osStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "4";
            param["q_errorAttr"] = "DIVICE_CD";
            param["q_target"] = "C";
            param["q_title"] = "장치종류별";
            // 장치종류별
            $("#devicsStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "2";
            param["q_errorAttr"] = "BROWSER_CD";
            param["q_target"] = "C";
            param["q_title"] = "브라우저별";
            // 브라우저별
            $("#broswerStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "5";
            param["q_errorAttr"] = "BROWSER_TYPE_CD";
            param["q_target"] = "C";
            param["q_title"] = "프로그램 유형별";
            // 브라우저 유형별
            $("#broswerTypeStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

            param["q_errorAttrNo"] = "10";
            param["q_errorAttr"] = "ERROR_URI_CD";
            param["q_target"] = "B";
            param["q_title"] = "요청 주소별";
            // 요청 주소별(URI)
            $("#errorUriStatDiv").load("/intra/monitor/stat/INC_ErrorStat.do", param, function() {
            });

        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ErrorSummary.do">

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
        <div id="serverStatDiv" class="graph_half float_l">
        </div>
        <div id="statusStatDiv" class="graph_half float_r">
        </div>
    </div>

    <div class="all_graph">
        <div id="errorFileStatDiv" class="graph_half float_l">
        </div>
        <div id="exceptionStatDiv" class="graph_half float_r">
        </div>
    </div>

    <div class="all_graph">
        <div id="broswerStatDiv" class="graph_half float_l">
        </div>
        <div id="broswerTypeStatDiv" class="graph_half float_r">
        </div>
    </div>

    <div style="width:100%;margin-bottom:10px;">
        <div id="errorUriStatDiv" class="graph_100">
        </div>
    </div>

</body>
</html>