<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.core.spi.commons.configuration.Config"%>

<html>
<head>
<op:jsTag type="spi" items="jquery,ui" />

<script type="text/javascript">
    $().ready(function() {
        if ($('#q_sType').val() != 'PM') {
            $('fieldset').eq(0).hide();
        }

/*
        if ($('#q_sType').val() != 'ALL' && $('#q_stDate').val() == '') {
            $('#q_stDate').val(getDateStr(new Date()));
        }
        if ($('#q_sType').val() != 'ALL' && $('#q_enDate').val() == '') {
            $('#q_enDate').val(getDateStr(new Date()));
        }
*/

        $("p.tx_c  a  button.gray").click(function() {
            var sType = $(this).attr('id');
            var stDate = null;
            switch(sType) {
            case '0' :
                stDate = new Date();
                break;
            case '1D':
                stDate = getCalDate(new Date(),0,-1);
                break;
            case '7D':
                stDate = getCalDate(new Date(),0,-7);
                break;
            case '10D':
                stDate = getCalDate(new Date(),0,-10);
                break;
            case '15D':
                stDate = getCalDate(new Date(),0,-15);
                break;
            case '1M':
                stDate = getCalDate(new Date(),-1,0);
                break;
            case '3M':
                stDate = getCalDate(new Date(),-3,0);
                break;
            case '6M':
                stDate = getCalDate(new Date(),-6,0);
                break;
            default:
                stDate = new Date();
                break;
            }
            $('#q_stDate').val(getDateStr(stDate));
            if ($('#q_enDate').val() == '') {
                $('#q_enDate').val(getDateStr(new Date()));
            }

            if (sType == 'ALL') {
                $('#q_stDate').val('');
                $('#q_enDate').val('');
            }

            $('#q_sType').val(sType);

            if (sType == 'PM') {
                $('fieldset').eq(0).show();
            } else {
                $('#sForm').submit();
            }
        });


        $('button:contains("검색")').click(function() {
            if ($('#q_stDate').val() > $('#q_enDate').val()) {
                alert('시작일이 종료일보다 늦습니다.');
                return;
            }
            $('#sForm').submit();
        });

        $('button:contains("엑셀")').click(function() {
            if ($('#excelFr').length == 0) {
                $('body').append('<iframe id="excelFr" style="display: none;"/>');
            }

            var url = 'INC_changeLogExcel.do?mngrId=' + $('#mngrId').val() + '&q_stDate=' + $('#q_stDate').val() + '&q_enDate=' + $('#q_enDate').val();
            $('#excelFr').attr('src',url);
        });

        $('button:contains("인쇄")').click(function() {
            alert('중비 중...');
            return;
        });

        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_stDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true,
        });
        $('#q_enDate').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true,
        });
    });

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
        return '' + date.getFullYear() + '-' + set2Str(date.getMonth() + 1) + '-' + set2Str(date.getDate());
    };

    var set2Str = function(vl) {
        return parseInt(vl,10) > 9 ? vl : '0' + vl;
    };


    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $('#sForm input[name=q_currPage]').val(p);
        $('#sForm').submit();
    };
</script>
</head>

<body>
    <!-- 검색-->
    <form id="sForm" method="post" action="PD_changeLog.do">
        <input type="hidden" name="mngrId"      id="mngrId"   value="${param.mngrId}"/>
        <input type="hidden" name="q_sType"    id="q_sType" value="${param.q_sType}"/>

        <div class="search" style="margin:20px 0;">
            <p class="tx_c mar_b10">
                <a href="#"><button type="button" id="0"   class="gray">당일</button></a>
                <a href="#"><button type="button" id="1D"  class="gray">전일</button></a>
                <a href="#"><button type="button" id="7D"  class="gray">7일</button></a>
                <a href="#"><button type="button" id="10D" class="gray">10일</button></a>
                <a href="#"><button type="button" id="15D" class="gray">15일</button></a>
                <a href="#"><button type="button" id="1M"  class="gray">1개월</button></a>
                <a href="#"><button type="button" id="3M"  class="gray">3개월</button></a>
                <a href="#"><button type="button" id="6M"  class="gray">6개월</button></a>
                <a href="#"><button type="button" id="ALL" class="gray">전체</button></a>
                <a href="#"><button type="button" id="PM" class="gray">선택</button></a>
            </p>
            <fieldset>
                <legend>로그인 일자</legend>
                <label for="con"><span class="tx_b">로그인 일자</span></label>
                <input type="text" name="q_stDate" id="q_stDate" class="w120" title="날짜선택" value="${param.q_stDate}"/> ~
                <input type="text" name="q_enDate" id="q_enDate" class="w120" title="날짜선택" value="${param.q_enDate}"/>
                <span class="vt"><button type="button" class="s_blue mar_l5">검색</button></span>
            </fieldset>
        </div>
        <!-- /검색 -->

        <op:pagerParam title="변경이력" />

    </form>

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
        <caption class="hidden">목록</caption>
        <colgroup>
            <col width="7%"  />
            <col width="15%" />
            <col width=""    />
            <col width="15%" />
            <col width="20%" />
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>로그구분</th>
                <th>변경내용</th>
                <th>등록자</th>
                <th class="lr_none">변경일자</th>
            </tr>
        </thead>
        <tbody>
            <c:set var="index" value="${pager.indexNo}" />
            <c:forEach items="${pager.list}" var="changeLog" varStatus="status">
                <tr>
                        <td>${index-status.index}</td>
                        <c:choose>
                            <c:when test="${not empty changeLog.changeType}">
                                <td>${changeLog.changeType}</td>
                                <td><c:out value="${changeLog.changeResutl}" default="${changeLog.logTy == 'I' ? '최초등록' : ''}" /></td>
                            </c:when>
                            <c:otherwise>
                                <td>단순저장</td>
                                <td>변경없음</td>
                            </c:otherwise>
                        </c:choose>
                        <td>${changeLog.updtId}</td>
                        <td class="lr_none">${changeLog.logDt}</td>
                </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="5" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <div class="float_r">
        <a href="#"><button type="button" class="orange">엑셀</button></a>
    </div>

</body>
</html>