<%@ page contentType='text/html;charset=UTF-8' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/fmt' prefix='fmt' %>
<%@ taglib uri='http://www.openworks.kr/jsp/jstl' prefix='op' %>
<html>
<head>
<title>이벤트 통계</title>
<op:jsTag type="spi" items="ui,extjs4,colorbox" />
<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/sortUtil.js'/>'></script>
<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.bar.js'/>'></script>
<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.mutilbar.js'/>'></script>
<script type='text/javascript' src='<c:url value='/resources/intra/analyze/statistic/chart.kindBar.js'/>'></script>
<script type='text/javascript'>
    // chart에서 사용할 변수
    var fileds      = ['name',  'data0', 'data1', 'data2', 'data3'];
    var data        = [];      
    var dataFileds  = ['data0', 'data1', 'data2', 'data3'];
    var xTitle      = '';
    var yTitle      = '이벤트명' ;

    var customerInit = function() {
        data = [];  
        // chart bar 값생성
        $('tbody.chartList tr').each(function (index) {
            data[index] = { name  : $(this).find('td').eq(0).text().replace(/\s/g, ''),
                            data0 : parseInt($(this).find('td').eq(1).text(), 10),
                            data1 : parseInt($(this).find('td').eq(2).text(), 10),
                            data2 : parseInt($(this).find('td').eq(3).text(), 10)
            };
        });
        initSort();
        initChartMutilBar();
    };

    var getCalDate = function(date, months, days) {
        var newDate = date;
        if (typeof(date.getDate) != 'function') {
            newDate = new Date();
        }
        newDate.setMonth(newDate.getMonth() + months);
        newDate.setDate(newDate.getDate() + days);
        return newDate;
    };

    var getDateStr = function(date) {
        var set2Str = function(vl) {
            return parseInt(vl,10) > 9 ? vl : '0' + vl;
        };
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    $().ready(function(){
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
        
        $('#q_startDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
        });
        $('#q_endDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : CTX_PATH + '/resources/openworks/theme/default/images/icon/icon_cal.gif',
            buttonImageOnly : true,
        });

        $("#d-0").click(function() {
            var today = new Date();
            $('#q_endDate').val(getDateStr(today));
            $('#q_startDate').val(getDateStr(today));
        });
        $("#d-1").click(function() {
            var today = new Date();
            $('#q_endDate').val(getDateStr(today));
            $('#q_startDate').val(getDateStr(getCalDate(today, 0, -1)));
        });
        $("#d-7").click(function() {
            var today = new Date();
            $('#q_endDate').val(getDateStr(today));
            $('#q_startDate').val(getDateStr(getCalDate(today, 0, -6))); // -6일을 계산해야 7일이 조회됨
        });
        $("#m-1").click(function() {
            var today = new Date();
            $('#q_endDate').val(getDateStr(today));
            $('#q_startDate').val(getDateStr(getCalDate(today, -1, 0)));
        });
        $("#m-3").click(function() {
            var today = new Date();
            $('#q_endDate').val(getDateStr(today));
            $('#q_startDate').val(getDateStr(getCalDate(today, -3, 0)));
        });

        customerInit();
    });

    var search = function() {
        if($("#q_startDate").val() == ''){
            jsWarningBox("검색 시작일을 입력해 주세요.");
            $("#q_startDate").focus();
        }
        if($("#q_endDate").val() == ''){
            jsWarningBox("검색 종료일을 입력해 주세요.")
            $("#q_endDate").focus();
        }
        $("#q_domainCd").val($("#domainCd").val());
        $("#searchForm").attr("action", "BD_index.do").submit();
    };

    var jsDetailPop = function (el, seq) {
        $(el).colorbox({
            title : "참여자 유형 상세",
            href : "PD_view.do?q_eventSn="+seq,
            width : "800",
            height : "550",
            iframe : true
        });
    };

    var reportAction = function(){
        
        var q_langCodes = "L"+"${searchMap.q_domainCd}";
        var q_beginDate = "${searchMap.q_startDate}";
        var q_endDate = "${searchMap.q_endDate}";
        
        var open = "/report/reporting.jsp?reportSection=1005&q_langCodes="+q_langCodes+"&q_beginDate="+q_beginDate+"&q_endDate="+q_endDate;
        window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
    };
    
</script>
</head>
<body>
    <div class="search">
        <fieldset>
            <legend>통계 검색</legend>
            <label class="skip" for="boardsearch">통계 검색항목</label>
            <table class="boardWrite" cellspacing="0" border="0" summary="이벤트 검색">
                <caption class="hidden"> 검색 정보 </caption>
                <colgroup>
                    <col width="15%" />
                    <col width="90%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>사이트 구분</th>
                        <td>
                            <select id="domainCd">
                                <c:forEach items="${domainList}" var="domain" varStatus="status">
                                    <c:if test="${domain.domainCd != 1}">
                                        <option value="${domain.domainCd}" ${domain.domainCd eq searchMap.q_domainCd ? 'selected="selected"' : ''}>${domain.domainNm}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th><label class='tx_b' for='q_startDate'>진행기간 구분</label></th>
                        <td class='search'>
                            <fieldset>
                                <form class="float_l" name="searchForm" id="searchForm">
                                    <input type='text' id='q_startDate' name='q_startDate' class='w120' value='<c:out value='${searchMap.q_startDate}'/>' title='시작일' readonly="readonly"/>~ 
                                    <input type='text' id='q_endDate' name='q_endDate' class='w120' value='<c:out value='${searchMap.q_endDate}'/>' title='날짜선택' readonly="readonly"/>
                                    <input type='hidden' id='q_domainCd' name='q_domainCd' value='' />
                                </form>
                                <button id="d-0" class='s_blue mar_l5 mar_b5 float_l'>당일</button>
                                <button id="d-1" class='s_blue mar_l5 mar_b5 float_l'>전일</button>
                                <button id="d-7" class='s_blue mar_l5 mar_b5 float_l'>7일</button>
                                <button id="m-1" class='s_blue mar_l5 mar_b5 float_l'>1개월</button>
                                <button id="m-3" class='s_blue mar_l5 mar_b5 float_l'>3개월</button>
                                <button class='gray float_r' onclick='search();'>검색</button>
                            </fieldset>
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset> 
    </div>
    <!-- 통계그래프영역 -->
    <div class='mar_t20'>
        <h5>
            <img src='<c:url value='/resources/openworks/theme/default/images/icon/icon_arrow.gif'/>' alt='' class='vm' />
            <span class='tx_red'><c:out value='${searchMap.q_startDate}'/> ~ <c:out value='${searchMap.q_endDate}'/></span>까지 분석된 접속통계입니다.
        </h5>
        <div id='_chartBar' class='mar_t20 mar_b30'></div>
    </div>
    <!-- 리스트 -->
    <div id="_chartMutildBar"></div>
    <table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
        <caption class='hidden'> 목록 </caption>
        <colgroup>
            <col width='50%'/>
            <col width='25%'/>
            <col width='25%'/>
        </colgroup>
        <thead id='listHead'>
            <tr>
                <th>이벤트명</th>
                <th>조회수</th>
                <th class="lr_none">참여자수</th>
            </tr>
        </thead>
        <tbody id='listBody' class='chartList'>
            <c:forEach items='${dataList}' var='data' varStatus='idx'>
                <tr <c:if test='${(idx.count mod 2) eq 0}'> class='bg_yellow'</c:if>>
                    <td><c:out value='${data.EVENT_TITLE}'/></td>
                    <td><c:out value='${data.RD_CNT}'/>명</td>
                    <c:if test="${data.CMT_CNT > 0}">
                        <td class="lr_none"><a href="#" onclick="jsDetailPop(this, '${data.EVENT_SN}');"><c:out value='${data.CMT_CNT}'/>명</a></td>
                    </c:if>
                    <c:if test="${data.CMT_CNT == 0}">
                        <td class="lr_none"><c:out value='${data.CMT_CNT}'/>명</td>
                    </c:if>
                </tr>
            </c:forEach>
            <c:if test="${empty dataList}">
                <tr>
                    <td colspan="3" class="lr_none">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
    <!-- 버튼 -->
    <div class="mar_t10">
        <div class="float_r">
            <button class="w_blue" type="button" onclick="reportAction();">리포트 출력</button>
        </div>
    </div>
    <!-- //버튼 -->

    <!-- //리스트 -->
</body>
</html>