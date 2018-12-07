<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>방문경로 분석</title>
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
                     {text : '검색엔진',      link : 'INC_searchEngine.do',    desc : '검색엔진을 통해 방문한 경우에 대한 분석리포트입니다.<br/>검색 키워드별 방문수에 대해 4개의 검색엔진 자료를 선택적으로 비교 분석합니다.'},
                     {text : '검색어',        link : 'INC_searchWord.do',      desc : '검색엔진에서 어떤 검색어를 통해 많이 방문하였는지 각 검색어별 전체방문수를 분석합니다.<br/>각 검색어별 방문수에 대해 보여지며 펼침기능을 통해 각 검색엔진별 방문수를 확인 할 수 있습니다.'},
                     {text : '유입도메인',    link : 'INC_inflowDomain.do',    desc : '유입 도메인 분석은 사이트 방문경로에 대한 분석리포트입니다.<br/>유입경로가 없이 직접방문(Bookmark)하였는지, 어떤 사이트에서 얼마의 방문객을 보내주었는지 알 수 있습니다.<br/>.com 또는 .co.kr 등 최상위 도메인 주소만을 보여드립니다 .'},
                     {text : 'URL분석',       link : 'INC_inflowUrl.do',       desc : '유입도메인상세 분석은 사이트 방문경로에 대한 분석리포트입니다.<br/>사이트에 방문할 수 있도록 연결해준 링크가 클릭된 페이지 URL을 보여줍니다.<br/>각각의 URL에 대한 유입수를 보여주므로 어떤 사이트의 어떤 페이지를 통해 방문이 이루어졌는지 확인할 수 있습니다.'}
                     ];
        </script>
    </head>

    <body>
        <!-- 접속수분석-->
        <div class='buser'>
            <!-- 왼쪽 tree -->
            <div class='b_list'>
                <div class='tree_tit'>
                    접속수 분석
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
