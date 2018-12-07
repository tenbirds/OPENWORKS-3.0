<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>장애 관리</title>

    <op:jsTag type="spi" items="highlight, ui, tooltip" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <style type="text/css">
        .boardList th:last-child, .boardList td:last-child {
            border-right: 0px;
        }
    </style>

    <!-- 기능별 스크립트 정의 -->
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/monitor/js/openworks.monitor.js"></script>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // select 박스 선택 값 설정
            jsSelected("q_errorTypeCd", "${param.q_errorTypeCd}");
            jsSelected("q_errorResCd", "${param.q_errorResCd}");

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


            // 툴팁 설정
            $(".attrNm").tooltip({ });
        });

        var jsErrorView = function(errorNo) {

            jsView("BD_ErrorView.do?q_errorNo="+errorNo);
        };

        //]]>
    </script>
</head>
<body>

    <ul class="tab">
        <li><a href="#" onclick="jsErrorTabList('BD_ErrorList.do', 1010);return false;" <c:if test="${empty param.q_errorProcStatus or param.q_errorProcStatus eq '1010'}" >class="on"</c:if>>미배정 (${baseVo.stat01})</a></li>
        <li><a href="#" onclick="jsErrorTabList('BD_ErrorList.do', 1020);return false;" <c:if test="${param.q_errorProcStatus eq '1020'}" >class="on"</c:if>>배정 (${baseVo.stat02})</a></li>
        <li><a href="#" onclick="jsErrorTabList('BD_ErrorList.do', 1030);return false;" <c:if test="${param.q_errorProcStatus eq '1030'}" >class="on"</c:if>>처리중 (${baseVo.stat03})</a></li>
        <li><a href="#" onclick="jsErrorTabList('BD_ErrorList.do', 1040);return false;" <c:if test="${param.q_errorProcStatus eq '1040'}" >class="on"</c:if>>완료 (${baseVo.stat04})</a></li>
        <li><a href="#" onclick="jsErrorTabList('BD_ErrorList.do', 1000);return false;" <c:if test="${param.q_errorProcStatus eq '1000'}" >class="on"</c:if>>전체 (${baseVo.stat05})</a></li>
    </ul>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ErrorList.do">

        <input type="hidden" name="q_errorProcStatus" id="q_errorProcStatus" value="${searchMap.q_errorProcStatus}" />

        <div class="search">
            <div class="w790">
                <fieldset>
                    <legend>오류 목록 검색</legend>

                    <label class="skip" for="q_errorResCd">상태코드선택</label>
                    <select name="q_errorResCd" id="q_errorResCd" class="over">
                        <option value="">-- 상태코드 --</option>
                        <c:forEach items="${errorResList}" var="errorRes">
                            <option value="${errorRes.seqNo}">코드 ${errorRes.errorAttrNm}</option>
                        </c:forEach>
                    </select>

                    <label class="skip" for="q_errorUri">오류주소 검색</label>
                    오류주소: <input type="text" name="q_errorUri" id="q_errorUri" value="${param.q_errorUri}" class="w120" title="오류주소를 입력하세요." />&nbsp;&nbsp;

                    <label class="skip" for="q_errorNum">오류번호 검색</label>
                    오류번호: <input type="text" name="q_errorNum" id="q_errorNum" value="${param.q_errorNum}" class="w120" title="오류번호를 입력하세요." />&nbsp;&nbsp;

                    <label class="skip" for="q_userName">사용자명 검색</label>
                    사용자명: <input type="text" name="q_userName" id="q_userName" value="${param.q_userName}" class="w120" title="사용자명을 입력하세요." />

                    <br />

                    <div class="mar_t5 tx_c">
                        오류발생일 : 
                        <label class="skip" for="q_startDate">오류발생시작일시작</label>
                        <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~
                        <label class="skip" for="q_endDate">오류발생시작일끝</label> 
                        <input type="text" id="q_endDate" name="q_endDate" class="w80" value="${param.q_endDate}" maxlength='8' />

                        <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />

                    </div>

                <!-- 검색 옵션 시작 -->
                <div id="SearchOptionDiv" class="mar_t5">
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
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <c:choose>
            <c:when test="${empty param.q_errorProcStatus or param.q_errorProcStatus eq '1010'}"><c:set var="assignStatus" value="미배정"/></c:when>
            <c:when test="${param.q_errorProcStatus eq '1020'}"><c:set var="assignStatus" value="배정"/></c:when>
            <c:when test="${param.q_errorProcStatus eq '1030'}"><c:set var="assignStatus" value="처리중"/></c:when>
            <c:when test="${param.q_errorProcStatus eq '1040'}"><c:set var="assignStatus" value="완료"/></c:when>
            <c:when test="${param.q_errorProcStatus eq '1000'}"><c:set var="assignStatus" value="전체"/></c:when>
        </c:choose>
        <op:pagerParam title="${assignStatus} 목록" />

    </form>
    <!-- //검색 -->

    <c:choose>
        <c:when test="${empty param.q_errorProcStatus or param.q_errorProcStatus eq '1010'}"><c:set var="cols" value="5"/></c:when>
        <c:when test="${param.q_errorProcStatus eq '1020'}"><c:set var="cols" value="7"/></c:when>
        <c:when test="${param.q_errorProcStatus eq '1030'}"><c:set var="cols" value="8"/></c:when>
        <c:when test="${param.q_errorProcStatus eq '1040'}"><c:set var="cols" value="9"/></c:when>
        <c:otherwise><c:set var="cols" value="10"/></c:otherwise>
    </c:choose>

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="오류관리 목록">
        <caption class="hidden">오류관리 목록</caption>
        <colgroup>
            <col style="width:50px" />
            <col style="" />
            <col style="width:180px" />
            <col style="width:60px" />
            <col style="width:70px" />
            <col style="width:140px" />

            <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1010'}">
                <col style="width:100px" />
                <col style="width:75px" />
            </c:if>

            <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1020' and param.q_errorProcStatus ne '1010'}">
                <col style="width:100px" />
            </c:if>

            <c:if test="${param.q_errorProcStatus eq '1040' or param.q_errorProcStatus eq '1000'}">
                <col style="width:130px" />
            </c:if>

            <c:if test="${param.q_errorProcStatus eq '1000'}">
                <col style="width:70px" />
            </c:if>
        </colgroup>
        <thead>
            <tr>
                <th rowspan="2"><span>번호</span></th>
                <th><span>오류번호</span></th>
                <th><span>사이트명</span></th>
                <th><span>상태<br />코드</span></th>
                <th><span>오류<br />횟수</span></th>
                <th><span>최초발생일<br />최종발생일</span></th>

                <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1010'}">
                    <th><span>배정일</span></th>
                    <th><span>처리자</span></th>
                </c:if>

                <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1020' and param.q_errorProcStatus ne '1010'}">
                    <th>
                        시작예정일<br />완료예정일
                    </th>
                </c:if>

                <c:if test="${param.q_errorProcStatus eq '1040' or param.q_errorProcStatus eq '1000'}">
                    <th><span>완료일</span></th>
                </c:if>


                <c:if test="${param.q_errorProcStatus eq '1000'}">
                    <th class="lr_none"><span>상태</span></th>
                </c:if>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody>
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">

                <c:choose>
                    <c:when test="${(status.index % 2) == 1}">
                        <c:set var="rowCss" value="class=\"bg_yellow\"" />
                    </c:when>
                    <c:otherwise>
                        <c:set var="rowCss" value="" />
                    </c:otherwise>
                </c:choose>

                <tr ${rowCss}>
                    <td rowspan="2">${index-status.index}</td>
                    <td>${dataVo.errorNo}</td>
                    <td>
                        <span id="attrDomain${status.index}" class="attrNm">${dataVo.domainNm}</span>
                        <div id="attrDomain${status.index}Tip" class="attrNmTip" style="display:none;">
                            <c:choose>
                                <c:when test="${not empty dataVo.domainDesc}">
                                    <op:nrToBr content="${dataVo.domainDesc}" />
                                </c:when>
                                <c:otherwise>
                                    등록된 내용이 없습니다.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <td>
                        <span id="attrRes${status.index}" class="attrNm">${dataVo.errorResNm}</span>
                        <div id="attrRes${status.index}Tip" class="attrNmTip" style="display:none;">
                            <c:choose>
                                <c:when test="${not empty dataVo.errorResDesc}">
                                    <op:nrToBr content="${dataVo.errorResDesc}" />
                                </c:when>
                                <c:otherwise>
                                    등록된 내용이 없습니다.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                    <td><a href="#" onclick="jsErrorDetlList('${dataVo.errorNo}');return false;" ><span style="color:blue;font-weight: bold;">${dataVo.errorCnt}</span> 회</a></td>

                    <td class="tx_l">
                        ${dataVo.errorStDt} ~
                        <br />
                        ${dataVo.errorEdDt}
                        <c:if test="${not empty dataVo.errorTermDt}">
                            (<span style="color:red;font-weight: bold;">${dataVo.errorTermDt}</span>일간)
                        </c:if>
                    </td>

                    <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1010'}">
                        <td>${dataVo.errorAssignDt}</td>
                        <td>${dataVo.transactorNm}</td>
                    </c:if>

                    <c:if test="${not empty param.q_errorProcStatus and param.q_errorProcStatus ne '1020' and param.q_errorProcStatus ne '1010'}">
                        <td>
                            ${dataVo.workStDt}<br />${dataVo.workEdDt}
                        </td>
                    </c:if>

                    <c:if test="${param.q_errorProcStatus eq '1040' or param.q_errorProcStatus eq '1000'}">
                        <td>
                            ${dataVo.errorProcDt}
                            <c:if test="${not empty dataVo.errorProcDt}">
                                (<span style="color:red;font-weight: bold;">${dataVo.errorProcTerm}</span>일)
                            </c:if>
                        </td>
                    </c:if>

                    <c:if test="${param.q_errorProcStatus eq '1000'}">
                        <td>
                            <c:choose>
                                <c:when test="${dataVo.errorProcStatus eq '1010'}">미배정</c:when>
                                <c:when test="${dataVo.errorProcStatus eq '1020'}">배정</c:when>
                                <c:when test="${dataVo.errorProcStatus eq '1030'}">처리중</c:when>
                                <c:when test="${dataVo.errorProcStatus eq '1040'}">완료</c:when>
                            </c:choose>
                        </td>
                    </c:if>
                </tr>
                <tr ${rowCss}>
                    <td colspan="${cols}" class="tx_l lr_none">
                        <a href="#" id="attrUri${status.index}" class="attrNm" onclick="jsErrorView('${dataVo.errorNo}');return false;">${dataVo.errorUriNm}</a>
                        <div id="attrUri${status.index}Tip" class="attrNmTip" style="display:none;">
                            <c:choose>
                                <c:when test="${not empty dataVo.errorUriDesc}">
                                    <op:nrToBr content="${dataVo.errorUriDesc}" />
                                </c:when>
                                <c:otherwise>
                                    등록된 내용이 없습니다.
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="${cols + 1}" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>