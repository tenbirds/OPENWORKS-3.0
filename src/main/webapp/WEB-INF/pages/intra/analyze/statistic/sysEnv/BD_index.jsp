<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>시스템 환경 분석</title>
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
                     {text : '웹 브라우저',      link : 'INC_browser.do',          desc : '방문자들이 사용하는 웹 브라우저 종류 및 버전을 알 수 있습니다.<br/>브라우저별 분석을 통해 방문객의 인터넷 환경을 이해할 수 있으며, 방문객의 인터넷 환경에 맞도록 웹 사이트를 최적화 할 수 있습니다. 웹 사이트를 사용자 환경에 최적화하여 디자인 할 수 있습니다.'},
                     {text : '운영체제',         link : 'INC_os.do',               desc : '방문자들이 사용하는 운영체제에 대한 분포를 알 수 있습니다.<br/>이 정보는 어떤 프로그램이나 기타의 것을 다운로드 서비스할 때 유용한 정보로써 사용자의 OS 종류와 다운로드 파일의 호환성, 또는 특정 OS 를 위한 프로그램이나 웹 페이지를 개발할 때 유용하게 쓰일 수 있습니다.'},
                     {text : '모니터 해상도',    link : 'INC_resolution.do',       desc : '방문자가 컴퓨터에서 설정하여 사용하는 모니터의 해상도를 알 수 있습니다.<br/>주 해상도를 기초로 웹 페이지의 디자인을 최적화 할 수 있습니다.<br/>만 약 800*600 모드에 맞추어 사이트 제작이 되었으나, 웹로그분석 결과 1024*768 이상의 해상도 방문자가 다수인 경우, 추후 리뉴얼을 할 때는 방문객의 주요 해상도에 맞추어 넓은 화면에 많은 컨텐츠를 표현하는 것을 고려해 볼 수 있을 것입니다.'},
                     {text : '색상도',           link : 'INC_colorDepth.do',       desc : '방문자가 컴퓨터에서 설정하여 사용하는 모니터의 색상수를 알 수 있습니다.<br/>이 분석정보를 기초로 웹 페이지의 디자인을 최적화 할 수 있습니다.'}
                     ];
        </script>
    </head>

    <body>
        <!-- 접속수분석-->
        <div class='buser'>
            <!-- 왼쪽 tree -->
            <div class='b_list'>
                <div class='tree_tit'>
                    시스템 환경 분석
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
