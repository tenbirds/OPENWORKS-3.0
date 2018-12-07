<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>방문자 분석</title>
        <op:jsTag type="spi" items="ui,extjs4" />
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/sortUtil.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/common.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.pie.js'/>'></script>
        <script type='text/javascript'>
        var customerInit = function() {
            initSort();
            initCalendar();
            if (document.getElementById('_chartBar') !== null) {
                initChartBar();
            } else if (document.getElementById('_chartPie') !== null) {
                initChartPie();
            }
        };
        
        var getSearchData = function(pageNo) {
            return {
                    domain : $('#domain').val(),
                    startDate : $('#startDate').val(),
                    endDate : $('#endDate').val(),
                    searchText : $('#searchText').val() || '',
                    q_rowPerPage : $('#q_rowPerPage').val() || '10',
                    q_currPage : pageNo || '1'
                    
            };
        };
        
        var links = [
                     {text : '방문 횟수별 분석',       link : 'INC_visitNum.do',       desc : '방문자에 대한 방문기록을 기준으로 방문횟수 분포를 분석합니다.<br/>1회방문이란 사이트에 처음 방문한 방문자이며, 재방문자에 대해 2회, 3~5회, 6~9회, 10회 이상방문으로 나눠 각 방문자와 비율을 표현합니다. 귀사의 사이트에 첫번째 방문인지, 두번째 방문 또는 3~5 회 방문하였는지 분석 할 수 있어 얼마나 많이 재방문이 이루어지는 지 분석합니다.'},
                     {text : '재 방문 기간 분석',      link : 'INC_revisitPeriod.do',  desc : '전체방문자중 재방문에 대한 방문 간격을 분석합니다.<br/>[ 오늘 재방문 / 1일만에 재방문 / 2~7일만에 재방문 / 8~15일만에 재방문 / 16~30일만에 재방문 / 1개월~3개월 만에 재방문 / 3개월 이후 만에 재방문 ]'},
                     {text : '1회 방문페이지 뷰',      link : 'INC_pageViewNum.do',    desc : '방문자가 1회 방문했을 때 둘러보는 페이지의 평균 페이지뷰입니다. 높을수록 사이트에 관심을 가지고 둘러보는 방문자라고 볼 수 있습니다.'}
                     ];
        </script>
    </head>

    <body>
        <!-- 접속수분석-->
        <div class='buser'>
            <!-- 왼쪽 tree -->
            <div class='b_list'>
                <div class='tree_tit'>
                    방문자 분석
                </div>
                <div class='panel' id='BoxList' style='height:350px;'>
                    <ul class='panList'></ul>
                </div>
                <div  class='tree_num'><p class='tx_blue mar_b10'>도움말</p>
                    <span id='descArea'></span><br/>
                    <!-- <p class='mar_t10'><a href='#'><button class='blue'>도움말 더보기</button></a></p>  -->
                </div>
            </div>
            <!-- //왼쪽 tree -->
            <div id='BoxDetail' class='b_write'>
                잠시 기다려 주세요...
            </div>
            <input type='hidden' id='compareFlag' value='<c:out value='${searchVO.compareFlag}' default='1' />'/>
        </div>
    </body>
</html>
