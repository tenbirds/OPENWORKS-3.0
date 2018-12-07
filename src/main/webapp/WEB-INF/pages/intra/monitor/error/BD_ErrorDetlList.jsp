<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류 관리</title>

    <op:jsTag type="spi" items="highlight, ui" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // select 박스 선택 값 설정
            jsSelected("q_userGroup", "${param.q_userGroup}");

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
        });

        var jsErrorDetlView = function(errorNo, detlSeqNo) {
            $("#q_errorNo").val(errorNo);
            $("#q_detlSeqNo").val(detlSeqNo);
            
            jsView("BD_ErrorDetlView.do");
        };

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ErrorDetlList.do">

        <input type="hidden" name="q_errorNo" id="q_errorNo" value="${searchMap.q_errorNo}" />
        <input type="hidden" name="q_detlSeqNo" id="q_detlSeqNo" value="${searchMap.q_detlSeqNo}" />

        <div class="search">
            <fieldset>
                <legend>사용자별 오류 목록 검색</legend>


                <label class="skip" for="q_userGroup">사용자구분 선택</label>
                <select name="q_userGroup" id="q_userGroup" class="over">
                    <option value="">-- 사용자구분 선택 --</option>
                    <option value="M">관리자</option>
                    <option value="U">회원</option>
                    <option value="N">비회원</option>
                </select>
<!--
                <label class="skip" for="q_userName">이름 검색</label>
                이름 : <input type="text" name="q_userName" id="q_userName" value="${param.q_userName}" class="w120" title="이름을 입력하세요." />
-->
                오류발생일 : 
                <label class="skip" for="q_startDate">오류발생일시작</label>
                <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                <label class="skip" for="q_endDate">오류발생일끝</label> 
                <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />&nbsp;

                <input type="image" alt="날짜선택" src="/resources/monitor/images/btn/btn_date.gif" onclick="jsToggleSearchOption(this);return false;" />

                <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />

                <!-- 검색 옵션 시작 -->
                <div id="SearchOptionDiv" class="mar_t5 none">
                    <button type="button" onclick="jsSetDay(0, 1, 0);"><img alt="오늘" src="/resources/monitor/images/btn/btn_today.gif" /></button>
                    <button type="button" onclick="jsSetDay(0, 2, 0);"><img alt="1일" src="/resources/monitor/images/btn/btn_1day.gif" /></button>
                    <button type="button" onclick="jsSetDay(0, 7, 0);"><img alt="7일" src="/resources/monitor/images/btn/btn_7day.gif" /></button>
                    <button type="button" onclick="jsSetDay(0, 10, 0);"><img alt="10일" src="/resources/monitor/images/btn/btn_10day.gif" /></button>
                    <button type="button" onclick="jsSetDay(0, 15, 0);"><img alt="15일" src="/resources/monitor/images/btn/btn_15day.gif" /></button>
                    <button type="button" onclick="jsSetDay(1, 1, 0);"><img alt="1개월" src="/resources/monitor/images/btn/btn_1month.gif" /></button>
                    <button type="button" onclick="jsSetDay(3, 1, 0);"><img alt="3개월" src="/resources/monitor/images/btn/btn_3month.gif" /></button>
                    <button type="button" onclick="jsSetDay(6, 1, 0);"><img alt="6개월" src="/resources/monitor/images/btn/btn_6month.gif" /></button>
                    <button type="button" onclick="jsSetDay(-1, 1, 0);"><img alt="전체" src="/resources/monitor/images/btn/btn_all.gif" /></button>
                </div>
                <!-- 검색 옵션 끝 -->

            </fieldset>
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="${assignStus} 사용자별 오류목록" />

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="사용자별 오류관리 목록">
        <caption class="hidden">사용자별 오류관리 목록</caption>
        <colgroup>
            <col style="width:50px" />
            <col style="width:100px" />
            <col style="width:120px" />
            <col style="width:130px" />
            <col style="width:120px" />
            <col style="" />
            <col style="width:100px" />
            <col style="width:100px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>구분</span></th>
                <th><span>운영체제</span></th>
                <th><span>장치</span></th>
                <th><span>유형</span></th>
                <th><span>브라우저</span></th>
                <th><span>IP</span></th>
                <th><span>등록일</span></th>
                <th class="lr_none"><span>상세정보</span></th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.userGroup eq 'M'}">관리자</c:when>
                            <c:when test="${dataVo.userGroup eq 'U'}">회원</c:when>
                            <c:when test="${dataVo.userGroup eq 'N'}">비회원</c:when>
                        </c:choose>
                    </td>
                    <td>${dataVo.osNm}</td>
                    <td>${dataVo.diviceNm}</td>
                    <td>${dataVo.browserTypeNm}</td>
                    <td>${dataVo.browserNm}</td>
                    <td>${dataVo.userIp}</td>
                    <td>${dataVo.regDt}</td>
                    <td class="lr_none">
                        <button type="button" onclick="jsErrorDetlView('${dataVo.errorNo}', '${dataVo.detlSeqNo}');" class="vm">
                            <img src="/resources/monitor/images/btn/btn_info_view.gif" />
                        </button>
                    </td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="10" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>