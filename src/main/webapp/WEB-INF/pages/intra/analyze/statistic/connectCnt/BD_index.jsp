<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>접속수 분석</title>
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
        
        var getSearchData = function() {
            return {
                    domain : $('#domain').val(),
                    startDate : $('#startDate').val(),
                    endDate : $('#endDate').val(),
                    searchUnit : $('#searchUnit').val() || 'HOUR',
                    searchTime : $('#searchTime').val(),
                    searchWeekDate : $('#searchWeekDate').val(),
                    compareFlag : $('#compareFlag').val()
            };
        };
        
        var links = [
                     {text : '전체 페이지 뷰',       link : 'INC_pageView.do',        desc : '웹사이트에 대한 방문자의 페이지 뷰(page view:페이지를 본 수의 합)를 분석합니다.<br/>예를 들어 한명의 방문객이 [ 메인 페이지 &gt; FAQ 페이지 &gt; 회사 소개 페이지 ]를 보았다면 페이지 뷰는 3 이 됩니다. 즉 , 방문자들이 웹사이트에 방문하여 열어 본 페이지 수의 합을 말합니다.'},
                     {text : '전체 방문자 수',       link : 'INC_visiter.do',         desc : '웹사이트의 방문수에 대해 분석합니다. 전체방문수는 재방문이 포함된 수치로 같은날 여러번 방문하였다면(단, 세션종료후), 전체방문자수가 추가로 증가할 수 있습니다. 전체방문수에 대해 처음방문과 재방문을 나눠 함께 분석하였습니다.<br/>평균값은 원하는 기간(1개월,3개월,1주,3주)을 선택하여 해당 기간에 포함되는 전체방문수의 평균을 계산합니다.'},
                     {text : '순 방문자 수',         link : 'INC_originalVisiter.do', desc : '전체방문수중 순방문에 대해 분석합니다. 한시간기준, 하루기준, 한달기준으로 나눠 순방문을 표현합니다.<br/>전체방문수에는 동일한 방문자에 대한 중복방문을 허용합니다. 중복방문자를 제외한 순수방문자를 확인 할 수 있습니다. 선택한 기준에 따라 값이 달라지므로 수집 기준을 확인하세요'},
                     {text : '재 방문자 수',         link : 'INC_returnVisiter.do',   desc : '웹사이트의 재방문수에 대해 분석합니다. 이전에 귀사의 웹사이트 방문 경험이 한 번 이상 있으며, 다시 찾아 온 방문자를 말합니다 . 전체방문수와 재방문수를 함께 분석하여 재방문율에 대해 확인 할 수 있습니다.'},
                     {text : '같은 시간 방문자 수',  link : 'INC_timeGroup.do',       desc : '해당 기간동안 매일 특정한 시간대의 방문자수를 비교하는 값입니다. 23~24시 경이 가장 접속이 활발한 시간이라 할지라도 매 일마다 조금씩 변화가 있을 수 있습니다. 이를 알기 위하여 동일한 시간대의 방문자수 변화를 체크해야 할 필요가 있습니다.'},
                     {text : '같은 요일 방문자 수',  link : 'INC_weekDateGroup.do',   desc : '해당 기간동안 매 주 특정한 요일의 방문자수를 비교하는 값입니다. 금요일이 가장 접속이 활발한 요일이라할지라도 매 주마다 조금씩 변화가 있을 수 있습니다. 이를 알기 위하여 동일한 요일의 방문자수 변화를 체크해야 할 필요가 있습니다.'},
                     {text : '시간대별 평균 접속수', link : 'INC_time.do',            desc : '페이지뷰, 전체방문수, 순방문수, 처음방문수, 재방문수에 대한 시간대별 수치를 분석합니다.<br/>선택한 기간동안 어느 시간대에 페이지뷰가 높았는지, 방문수가 많았는지를 비교하여 분석 할 수 있습니다.'},
                     {text : '요일별 평균 접속 수',  link : 'INC_weekDate.do',        desc : '페이지 뷰, 전체 방문수, 순방문수, 처음방문수, 재방문수에 대한 요일 별 수치를 분석합니다. 선택한 기간 동안 어느 요일에 페이지 뷰가 높았는지, 방문수가 많았는지를 비교하여 분석 할 수 있습니다.'}
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
