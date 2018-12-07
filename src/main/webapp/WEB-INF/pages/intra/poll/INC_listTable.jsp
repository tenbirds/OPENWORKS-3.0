<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!-- 목록 테이블 -->
<table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="40px" id="td-SEQ" />
        <col id="td-TITLE" />
        <col width="100px" id="td-DATE" />
        <col width="130px" id="td-DOMAIN" />
        <col width="60px" id="td-STATE" />
        <col width="60px" id="td-OPEN_YN" />
        <col width="60px" id="td-RESPONSE_CNT" />
        <col width="70px" id="td-DEPT_NM" />
        <col width="60px" id="td-REG_NM" />
        <col width="90px" id="td-REG_TIME" />
    </colgroup>

    <thead>
        <tr>
            <th id="th-SEQ"><span>순번</span></th>
            <th id="th-TITLE"><span>제 목</span></th>
            <th id="th-DATE"><span>설문기간</span></th>
            <th id="th-DOMAIN"><span>도메인</span></th>
            <th id="th-STATE"><span>상태</span></th>
            <th id="th-OPEN_YN"><span>공개</span></th>
            <th id="th-RESPONSE_CNT"><span>응답수</span></th>
            <th id="th-DEPT_NM"><span>등록 부서</span></th>
            <th id="th-REG_NM"><span>등록자</span></th>
            <th id="th-REG_TIME" class="lr_none"><span>등록일시</span></th>
        </tr>
    </thead>
    <tbody id="odd-color">
        <!-- 게시물 목록 -->
        <c:set var="index" value="${pager.indexNo}" />
        <c:forEach items="${pager.list}" var="pollVo" varStatus="status">
            <tr>
                <td>${index - status.index}</td>
                <td style="text-align:left; padding-left: 15px;">
                	<a href="#hh" rel="#titleSummary${status.count}" class="contentTip" onclick="jsPollView('${pollVo.seq}'); return false;">${pollVo.title}</a>
                </td>
                <td>${pollVo.startTime}<br /> ~ ${pollVo.endTime}</td>
                <td>${pollVo.domainNm}</td>
                <td>
                    <c:choose>
                        <c:when test="${pollVo.startYn eq 'N'}">대기중</c:when>
                        <c:when test="${pollVo.state eq 'S'}">중지</c:when>
                        <c:when test="${pollVo.startYn eq 'Y' and pollVo.endYn eq 'N'}">진행중</c:when>
                        <c:when test="${pollVo.endYn eq 'Y'}">종료</c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${pollVo.openYn eq 'Y'}">공개</c:when>
                        <c:otherwise>비공개</c:otherwise>
                    </c:choose>
                </td>
                <td>${pollVo.responseCnt}</td>
                <td>${pollVo.deptNm}</td>
                <td>${pollVo.regNm}</td>
                <td class="lr_none">${pollVo.regTime}</td>
            </tr>
        </c:forEach>
        <op:no-data obj="${pager}" colspan="10" />

    </tbody>
</table>
