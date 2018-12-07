<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>콘텐츠 분석</title>
        <op:jsTag type="spi" items="ui,extjs4" />
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/sortUtil.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/common.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.bar.js'/>'></script>
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
                     {text : '사이트 체류시간',      link : 'INC_residenseSite.do',        desc : '방문자가 사이트에 방문 후 이탈할 때 까지 보낸 시간을 의미합니다.<br/>[ 1분↓ / 3분↓ / 5분↓ / 7분↓ / 10분↓ / 15분↓ / 20분↓ / 30분↓ / 1시간↓ / 1시간↑ ]으로 분류하여 각 체류시간대별 방문자수 분포와 일자별 총 체류시간에 대해 분석합니다.<br/>방문당 체류시간도 함께 표현하여, 1회 방문을 통해 평균적으로 얼마나 사이트에 머문 후 이탈하는지 확인할 수 있습니다.'},
                     {text : '페이지별 체류시간',    link : 'INC_residensePage.do',        desc : '방문자가 사이트에 방문 후 각 페이지에서 보낸 시간을 의미합니다.<br/>[ 5초↓ / 15초↓ / 30초↓ / 1분↓ / 5분↓ / 5분↑ ]으로 분류하여 각 체류시간대별 방문자수 분포와 페이지별 총 체류시간에 대해 분석합니다.<br/>방문당 체류시간도 함께 표현하여, 1회 방문을 통해 평균적으로 페이지에 머문 후 이동 또는 이탈하는지 확인할 수 있습니다.'}
                     ];
        </script>
    </head>

    <body>
        <!-- 접속수분석-->
        <div class='buser'>
            <!-- 왼쪽 tree -->
            <div class='b_list'>
                <div class='tree_tit'>
                    콘텐츠 분석
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
