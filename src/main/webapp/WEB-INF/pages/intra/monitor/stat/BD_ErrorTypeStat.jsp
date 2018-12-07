<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>메시지 관리</title>

    <op:jsTag type="spi" items="ui" />
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

        });

        /**
         * 메시지 상세/수정
         */
        var jsMessageForm = function(messageSeqNo) {
            $("#q_messageSeqNo").val(messageSeqNo);

            jsView("BD_MessageForm.do");
        };

        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_MessageList.do">

        <input type="hidden" name="q_messageSeqNo" id="q_messageSeqNo" value="" />

        <div class="search">
            <fieldset>
                <legend>메시지 목록 검색</legend>

                <label class="skip" for="q_title">제목 검색</label>
                제목 : <input type="text" name="q_title" id="q_title" value="${param.q_title}" class="w120" title="제목을 입력하세요." />

                <button class="gray mar_l5 mar_b5">검색</button>
            </fieldset>
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <op:pagerParam title="메시지 목록" />

    </form>
    <!-- //검색 -->

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="메시지관리 목록">
        <caption class="hidden">메시지관리 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="" />
            <col style="width:120px" />
            <col style="width:120px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>제목</span></th>
                <th><span>등록자</span></th>
                <th><span>등록일</span></th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${pager.list}" var="dataVo" varStatus="status">
                <tr>
                    <td>${index-status.index}</td>
                    <td class="tx_l"><a href="#" onclick="jsMessageForm('${dataVo.messageSeqNo}');">${dataVo.title}</a></td>
                    <td>${dataVo.regNm}</td>
                    <td>${dataVo.regDt}</td>
                </tr>
            </c:forEach>

            <op:no-data obj="${pager}" colspan="4" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->


    <!-- 버튼 -->
    <div>
        <div class="float_r">
            <button type="button" class="w_blue" onclick="jsMessageForm();">신규등록</button>
        </div>
    </div>
    <!-- //버튼 -->

</body>
</html>