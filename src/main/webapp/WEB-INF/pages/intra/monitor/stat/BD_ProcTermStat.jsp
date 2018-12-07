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

        var pieChartFile = "<c:url value="/resources/monitor/FusionCharts_Evaluation/Charts/Pie3D.swf"/>";

        var statusChart = new FusionCharts(
            pieChartFile,
            "sChart",
            "100%", "250",
            0, 1
        );

        var dayChart = new FusionCharts(
            pieChartFile,
            "dChart",
            "100%", "250"
        );


        var statusChartXml = "<chart decimalPrecision='0' showPercentageValues='0' showNames='1' numberSuffix='일' ";
        statusChartXml += " showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='100' pieRadius='100' animation='0' ";
        statusChartXml += " shadowXShift='4' shadowYShift='4' shadowAlpha='40' pieFillAlpha='95' baseFontSize='12'>";

        <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
            statusChartXml += "    <set value='${dataVo.stat07}' name='${dataVo.title}'/>";
        </c:forEach>

        statusChartXml += "</chart>";


        var dayChartXml = "<chart decimalPrecision='0' showPercentageValues='0' showNames='1' numberSuffix='건' ";
        dayChartXml += " showValues='1' showPercentageInLabel='0' pieYScale='45' pieBorderAlpha='100' pieRadius='100' animation='0' ";
        dayChartXml += " shadowXShift='4' shadowYShift='4' shadowAlpha='40' pieFillAlpha='95' baseFontSize='12'>";

        dayChartXml += "    <set value='${baseVo.stat01}' name='1일이내'/>";
        dayChartXml += "    <set value='${baseVo.stat02}' name='2일이내'/>";
        dayChartXml += "    <set value='${baseVo.stat03}' name='3일이내'/>";
        dayChartXml += "    <set value='${baseVo.stat04}' name='4일이내'/>";
        dayChartXml += "    <set value='${baseVo.stat05}' name='5일이내'/>";
        dayChartXml += "    <set value='${baseVo.stat06}' name='5일초과'/>";

        dayChartXml += "</chart>";

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

            statusChart.setDataXML(statusChartXml);
            statusChart.render("statusChartDiv");

            dayChart.setDataXML(dayChartXml);
            dayChart.render("dayChartDiv");
        });

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ProcTermStat.do">

        <div class="search">
            <fieldset>
                <legend>처리현황 목록 검색</legend>

                <label class="skip" for="q_domainCd">사이트목록</label>
                <select name=q_domainCd id="q_domainCd" class="over">
                    <option value="">-- 사이트선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo">
                        <option value="${domainVo.seqNo}">${domainVo.errorAttrNm}</option>
                    </c:forEach>
                </select>

                조회기간(배정일기준) : 
                <label class="skip" for="q_startDate">배정일시작</label>
                <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                <label class="skip" for="q_endDate">배정일끝</label>
                <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                담당자이름 : 
                <label class="skip" for="q_transactorNm">담당자이름</label>
                <input type="text" name="q_transactorNm" id="q_transactorNm" value="${param.q_transactorNm}" />

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
            </fieldset>
        </div>

        <!--그래프부분-->
        <div class="all_graph">
            <div class="graph_half float_l">
                <h5>
                    전체 처리기간별 현황
                    <c:if test="${not empty param.q_startDate}">
                        (${param.q_startDate} ~ ${param.q_endDate})
                    </c:if>
                </h5>
                <p class="sa_i" id="dayChartDiv"></p>
            </div>
            <div class="graph_half float_r">
                <h5>
                    담당자별 평균 장애처리 기간
                    <c:if test="${not empty param.q_startDate}">
                        (${param.q_startDate} ~ ${param.q_endDate})
                    </c:if>                </h5>
                <p class="sa_i" id="statusChartDiv"></p>
            </div>
        </div>
        <!--//그래프부분-->

        <div style="clear: both;">
            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="처리기간별 현황 목록" />
        </div>

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="처리기간별 처리현황 목록">
        <caption class="hidden">처리기간별 처리현황 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>담당자</span></th>
                <th><span>1일</span></th>
                <th><span>2일</span></th>
                <th><span>3일</span></th>
                <th><span>4일</span></th>
                <th><span>5일</span></th>
                <th><span>5일초과</span></th>
                <th><span>평균소요일</span></th>
            </tr>

            <tr style="background-color:#A6DA9A;">
                <td>총계</td>
                <td></td>
                <td>${baseVo.stat01}</td>
                <td>${baseVo.stat02}</td>
                <td>${baseVo.stat03}</td>
                <td>${baseVo.stat04}</td>
                <td>${baseVo.stat05}</td>
                <td>${baseVo.stat06}</td>
                <td class="lr_none">
                    <c:if test="${not empty baseVo.stat07}" >
                        ${baseVo.stat07} 일
                    </c:if>
                </td>
            </tr>

        </thead>

        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">

            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td>${dataVo.title} (${dataVo.value})</td>
                    <td>${dataVo.stat01}</td>
                    <td>${dataVo.stat02}</td>
                    <td>${dataVo.stat03}</td>
                    <td>${dataVo.stat04}</td>
                    <td>${dataVo.stat05}</td>
                    <td>${dataVo.stat06}</td>
                    <td class="lr_none"><c:if test="${not empty dataVo.stat07}">${dataVo.stat07} 일</c:if></td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="8" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>