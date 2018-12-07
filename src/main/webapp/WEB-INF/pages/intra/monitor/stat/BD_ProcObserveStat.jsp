<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>처리기간별 현황</title>

    <op:jsTag type="spi" items="ui, fchart" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        var msCombiChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/MSCombiDY2D.swf"/>";

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
        observeChartXml += "<dataset seriesName='평균' parentYAxis='S' color='F984A1'>";
        <c:forEach items="${dataList}" var="dataVo">
            observeChartXml += "    <set value='<c:out value="${dataVo.stat02}"/>' alpha='100' />";
        </c:forEach>
        observeChartXml += "</dataset>";

        observeChartXml += "</chart>";

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#q_startDate').datepicker();
            $('#q_endDate').datepicker();

            jsSelected("q_domainCd", "${param.q_domainCd}");
            
            // 담당자 설정 Autocomplete
            $("#q_transactorNm").autocomplete({
                minLength: ($.browser.mozilla ? 1: 2),
                delay: ($.browser.mozilla ? 800: 10),
                source: function(request, response) {
                    $.ajax({
                        url: "<c:url value="/intra/monitor/config/INC_TransactorList.do" />",
                        type: "POST",
                        dataType: "json",
                        data: {
                            q_statusCode: "STABLE",
                            q_transactorNm: request.term
                        },
                        success: function( data ) {
                            response(data);
                        }
                    });
                },
                select: function( event, ui ) {

                }
            });

            observeChart.setDataXML(observeChartXml);
            observeChart.render("observeChartDiv");
        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ProcObserveStat.do">

        <div class="search">
            <fieldset>
                <legend>처리기간 준수율 목록 검색</legend>

                <label class="skip" for="q_domainCd">사이트목록</label>
                <select name=q_domainCd id="q_domainCd" class="over">
                    <option value="">-- 사이트선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo">
                        <option value="${domainVo.seqNo}">${domainVo.errorAttrNm}</option>
                    </c:forEach>
                </select>

                조회기간(요청일기준) : 
                <label class="skip" for="q_startDate">요청일일시작</label>
                <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                <label class="skip" for="q_endDate">요청일끝</label>
                <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                담당자이름 : 
                <label class="skip" for="q_transactorNm">담당자이름</label>
                <input type="text" name="q_transactorNm" id="q_transactorNm" value="${param.q_transactorNm}" />

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
            </fieldset>
        </div>

    </form>
    <!-- //검색 -->

    <!--그래프부분-->
    <div style="width:100%;margin-bottom:10px;">
        <div class="graph_100">
            <h5>
                처리기간준수율 현황
                <c:if test="${not empty param.q_startDate}">
                    (${param.q_startDate} ~ ${param.q_endDate})
                </c:if>
            </h5>

            <p id="observeChartDiv" class="sa_i"></p>

            <div class="graph_detail_text">
                <table class="graph_kind">
                    <colgroup>
                        <col width="4%" />
                        <col width="" />
                        <col width="12%" />
                        <col width="8%" />
                    </colgroup>
                    <tbody>
                    <c:forEach items="${dataList}" var="dataVo" varStatus="status">
                        <c:set var="icon_idx" value="${status.count % 6}" />
                        <tr>
                            <td><img src="/resources/monitor/images/contents/statistics_color_0${icon_idx}.gif" alt="" /></td>
                            <td class="tx_l">${dataVo.title}</td>
                            <td class="tx_blue">전체 ${dataVo.stat01} 건</td>
                            <td class="tx_red">평균 ${dataVo.stat02} 일</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--//그래프부분-->

</body>
</html>