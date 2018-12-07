<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>

<html>
    <head>
        <title>리소스센터 통계</title>
        <op:jsTag type="spi" items="ui,extjs4" />
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/sortUtil.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/common.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/chart.pie.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/chart.bar.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/chart.bar2.js'/>'></script>
        <script type='text/javascript' src='<c:url value='/resources/intra/resource/statistic/chart.bar3.js'/>'></script>
        <script type='text/javascript'>
        var customerInit = function() {
            initSort();
            initCalendar();
            if (document.getElementById('_chartBar') !== null) {
                initChartBar();
            }else if (document.getElementById('_chartBar2') !== null) {
                initChartBar2();
            }else if (document.getElementById('_chartBar3') !== null) {
                initChartBar3();
            }  
            else if (document.getElementById('_chartPie') !== null) {
                initChartPie();
            }         
        };
        
        var getSearchData = function(pageNo) {
            return {
                    domain : $('#domain').val(),
                    prvCode : $('#prvCode').val()  || '' ,
                    startDate : $('#startDate').val(),
                    endDate : $('#endDate').val(),
                    searchText : $('#searchText').val() || ''
//                     q_rowPerPage : $('#q_rowPerPage').val() || '10',
//                     q_currPage : pageNo || '1'
                    
            };
        };
        
        var links = [
                     {text : '리소스센터 분야',       link : 'INC_resourceField.do',         desc : '리소스센터 분야 통계에 대해 분석합니다.'},
                     {text : '리소스센터 주제',         link : 'INC_resourceTheme.do', desc : '리소스센터 주제 통계에 대해 분석합니다.'},
                     {text : '리소스센터 사용자',         link : 'INC_resourceUser.do',   desc : '리소스센터 사용자 통계에 대해 분석합니다.'}
                     ];

        </script>
        </head>
        
        <body>
            <!-- 접속수분석-->
            <div class='buser'>
                <!-- 왼쪽 tree -->
                <div class='b_list'>
                    <div class='tree_tit'>
                        리소스센터 통계
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
            
                </div>
                <input type='hidden' id='compareFlag' value='<c:out value='${searchVo.compareFlag}' default='1' />'/>
            </div>
        </body>
    </html>

