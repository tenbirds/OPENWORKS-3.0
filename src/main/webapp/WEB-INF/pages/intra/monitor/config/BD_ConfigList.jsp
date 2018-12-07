<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>환경설정 관리</title>

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
         * 환경설정 상세/수정
         */
        var jsConfigForm = function(domainCd) {
            $("#q_domainCd").val(domainCd);

            jsView("BD_ConfigForm.do");
        };

        //]]>
    </script>
</head>
<body>

    <!-- 리스트 -->
    <table class="boardList" cellspacing="0" border="0" summary="환경설정관리 목록">
        <caption class="hidden">환경설정관리 목록</caption>
        <colgroup>
            <col style="width:60px" />
            <col style="width:150px" />
            <col />
            <col style="width:120px" />
            <col style="width:150px" />
            <col style="width:100px" />
            <col style="width:100px" />
        </colgroup>
        <thead>
            <tr>
                <th><span>번호</span></th>
                <th><span>사이트</span></th>
                <th><span>운영자</span></th>
                <th><span>알림형태</span></th>
                <th><span>알림방법</span></th>
                <th><span>등록자</span></th>
                <th class="lr_none"><span>등록일</span></th>
            </tr>
        </thead>
        <!-- id="odd-color" : 목록 테이블 ROW 별 컬러 적용 -->
        <tbody id="odd-color">
            <c:set var="index" value="${pager.indexNo}" />

            <c:forEach items="${dataList}" var="dataVo" varStatus="status">
                <tr>
                    <td>${dataCnt-status.index}</td>
                    <td><a href="BD_ConfigForm.do?q_domainCd=${dataVo.domainCd}">${dataVo.domainNm}</a></td>
                    <td class="tx_r">
                        <a href="BD_ConfigForm.do?q_domainCd=${dataVo.domainCd}">
                            <c:forEach items="${dataVo.adminList}" var="adminVo">
                                ${adminVo.adminDeptNm} / ${adminVo.adminNm}<br />
                            </c:forEach>
                        </a>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.errorInformType eq '1010'}">알리지않음</c:when>
                            <c:when test="${dataVo.errorInformType eq '1020'}">최초한번</c:when>
                            <c:when test="${dataVo.errorInformType eq '1030'}">항상알림</c:when>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${dataVo.errorInformMethod eq 'SMS'}">문자메시지</c:when>
                            <c:when test="${dataVo.errorInformMethod eq 'EMAIL'}">이메일</c:when>
                            <c:when test="${dataVo.errorInformMethod eq 'SMS_EMAIL'}">문자메시지 + 이메일</c:when>
                        </c:choose>
                    </td>
                    <td>${dataVo.modNm}</td>
                    <td class="lr_none">${dataVo.modDt}</td>
                </tr>
            </c:forEach>

            <op:no-data obj="${dataList}" colspan="7" />

        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <button type="button" onclick="jsConfigForm();"><img src="/resources/monitor/images/btn/btn_new_regist.gif" alt="신규등록"/></button>
    </div>
    <!-- //버튼 -->

</body>
</html>