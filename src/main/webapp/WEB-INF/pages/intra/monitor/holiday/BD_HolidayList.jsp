<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>휴일 관리</title>

    <op:jsTag type="spi" items="ui" />
    <op:jsTag type="openworks" items="ui, form" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <script type="text/javascript" >
    //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // select 박스 선택 값 설정
            jsSelected("q_useYn", "${param.q_useYn}");
            jsSelected("q_searchKey", "${param.q_searchKey}");

            //검색 날짜 입력
            $.datepicker.setDefaults({
                dateFormat:"yy-mm-dd",
                showOn : 'button',
                buttonImageOnly : true,
                buttonImage : "<c:url value="/resources/monitor/images/contents/icon_cal.gif" />",
                buttonText: "날짜선택"
            });
            $('#q_startDate').datepicker();
            $('#q_endDt').datepicker();
        });

        /**
         * 휴일 상세/수정
         */
        var jsHolidayForm = function(holidayYmd) {

            jsView("BD_HolidayForm.do?q_holidayYmd="+holidayYmd);
        };

        /**
         * 휴일 Excel 등록 폼
         */
        var jsHolidayExcelForm = function(holidayYmd) {

            jsView("BD_HolidayExcelForm.do?q_holidayYmd=");
        };

    //]]>
    </script>

</head>

<body>


    <form name="dataForm" id="dataForm" method="get" action="BD_HolidayList.do">

        <!-- 검색 영역 시작 -->
        <div class="search">

            <input type="text" id="q_startDate" name="q_startDate" class="w80" value="${param.q_startDate}" maxlength='8' /> ~ 
            <input type="text" id="q_endDt" name="q_endDt" class="w80" value="${param.q_endDt}" maxlength='8' />&nbsp;

            <select name="q_useYn" id="q_useYn" class="over">
                <option value="">-- 사용여부 --</option>
                <option value="Y">사용</option>
                <option value="N">사용않함</option>
            </select>

            <select name="q_searchKey" id="q_searchKey" class="over">
                <option value="">-- 검색조건 --</option>
                <option value="1001">휴일명</option>
                <option value="1002">휴일설명</option>
            </select>

            <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" maxlength="50" class="w180" />

            <input type="image" alt="검색" src="/resources/monitor/images/btn/btn_search.gif" />
        </div>
        <!-- 검색 영역 끝 -->

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="휴일 목록" />

    </form>

        <!-- 리스트 -->
        <table class="boardList" width="100%" border="0" cellspacing="0" summary="휴일 목록">
            <caption>휴일 목록</caption>
            <colgroup>
                <col width="50px" />
                <col width="" />
                <col width="170px" />
                <col width="90px" />
                <col width="90px" />
                <col width="90px" />
            </colgroup>
            <!-- 테이블 목록 헤드 -->
            <thead>
                <tr>
                    <th><span>순번</span></th>
                    <th><span>휴일명</span></th>
                    <th><span>휴일날짜</span></th>
                    <th><span>등록자</span></th>
                    <th><span>등록일자</span></th>
                    <th class="lr_none"><span>사용여부</span></th>
                </tr>
            </thead>

            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}" />

                <c:forEach items="${pager.list}" var="holidayVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td class="tl">
                            <a href="#" onclick="jsHolidayForm('${holidayVo.holidayYmd}'); return false;">
                                 ${holidayVo.holidayNm}
                            </a>
                        </td>
                        <td>
                            <a href="#" onclick="jsHolidayForm('${holidayVo.holidayYmd}'); return false;">
                                ${holidayVo.viewHolidayYmd}
                            </a>
                        </td>
                        <td>${holidayVo.regNm}</td>
                        <td>${holidayVo.regDt}</td>
                        <td class="lr_none">${holidayVo.useYn}</td>
                    </tr>
                </c:forEach>

                <op:no-data obj="${pager}" colspan="6" />

            </tbody>
        </table>
        <!-- //리스트 -->

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

        <!-- 버튼 -->
        <div class="tx_r mar_t20">
            <button type="button" onclick="jsHolidayForm();"><img src="/resources/monitor/images/btn/btn_gic_regist.gif" alt="직접등록"/></button>
            <button type="button" onclick="jsHolidayExcelForm();"><img src="/resources/monitor/images/btn/btn_excel_regist.gif" alt="엑셀등록"/></button>
        </div>
        <!-- //버튼 -->

</body>
</html>
