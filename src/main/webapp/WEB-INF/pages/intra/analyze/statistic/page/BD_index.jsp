<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>페이지 분석</title>
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
                     {text : '많이 찾는 페이지',      link : 'INC_favoritePage.do',      desc : '사이트의 웹 페이지중 방문자가 가장 많이 본 순서대로 통계를 보여드립니다.<br/>고급분석설정의 페이지이름설정에 등록한 이름과 페이지URL이 함께 보여집니다.'},
                     {text : '시작 페이지',          link : 'INC_startPage.do',         desc : '웹사이트의 방문이 시작된 페이지에 대한 분석입니다.<br/>방문자가 귀사의 웹 사이트에 방문하여 분석이 시작된 페이지별 시작횟수입니다.'},
                     {text : '종료 페이지',          link : 'INC_endPage.do',           desc : '웹사이트를 빠져 나가는 페이지에 대한 분석입니다.<br/>브라우져를 닫거나, 다른 사이트로 유출되는 페이지가 어떤 페이지인지 확인할 수 있습니다.'}
                     ];

        </script>
    </head>
    
    <body>
        <!-- 접속수분석-->
        <div class='buser'>
            <!-- 왼쪽 tree -->
            <div class='b_list'>
                <div class='tree_tit'>
                    페이지 분석
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
