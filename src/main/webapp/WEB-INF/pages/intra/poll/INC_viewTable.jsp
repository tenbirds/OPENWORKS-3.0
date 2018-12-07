<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

    <form name="dataForm" id="dataForm" action="<c:url value="ND_pollUpdateAction.do" />" method="post">

        <%-- 페이징 관련 파라미터 생성. --%>
        <op:pagerParam view="view" />

        <!-- 기본 조건 항목 -->
        <input type="hidden" name="seq" value='${dataVo.seq}' />

    <h4 class="tx_13">기본 정보</h4>
    <table class="boardWrite" width="100%" summary="기본 정보">
        <caption class="title">기본 정보</caption>
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>등록부서</th>
                <td>${dataVo.deptNm}</td>
                <th>등록자</th>
                <td>${dataVo.regNm}</td>
            </tr>
            <tr>
                <th>설문상태</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.startYn eq 'N'}">대기중</c:when>
                        <c:when test="${dataVo.state eq 'S'}">중지</c:when>
                        <c:when test="${dataVo.startYn eq 'Y' and dataVo.endYn eq 'N'}">진행중</c:when>
                        <c:when test="${dataVo.endYn eq 'Y'}">종료</c:when>
                    </c:choose>
                </td>
                <th>적용도메인</th>
                <td>${dataVo.domainNm}</td>
            </tr>
            <tr>
                <th>제목</th>
                <td colspan="3">${dataVo.title}</td>
            </tr>
            <tr>
                <th>목적</th>
                <td colspan="3">
                    <op:nrToBr content="${dataVo.purpose}" />
                </td>
            </tr>
            <tr>
                <th>설문조사일</th>
                <td>
                    <input type="text" name="startTime" id="startTime" value="${dataVo.startTime}" class="w80" /> 
                    ~
                    <input type="text" name="endTime" id="endTime" value="${dataVo.endTime}" class="w80" />
                </td>
                <th>설문참여제한</th>
                <td>
                    ${dataVo.limitCnt}
                    <p class="tx_blue_s">'0' 설정시 제한이 없습니다.</p>
                </td>
            </tr>
            <tr>
                <th>중복차단여부</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.dupYn eq 'Y'}">차단</c:when>
                        <c:when test="${dataVo.dupYn eq 'N'}">허용</c:when>
                    </c:choose>
                </td>
                <th>중복차단 방법</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.dupCheck eq 'U'}">회원전용</c:when>
                        <c:when test="${dataVo.dupCheck eq 'I'}">IP 확인</c:when>
                        <c:when test="${dataVo.dupCheck eq 'C'}">Cookie 확인</c:when>
                        <c:otherwise><span class="gray">중복차단 사용안함</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <th>공개여부<span class="tx_red tx_b">*</span></th>
                <td>
                    <input type="radio" class="radio" name="openYn" id="openYnY" value="Y" <c:if test="${dataVo.openYn eq 'Y'}">checked='checked'</c:if> />&nbsp;<label for="openYnY">공개</label>
                    <input type="radio" class="radio" name="openYn" id="openYnN" value="N" <c:if test="${dataVo.openYn eq 'N' or empty dataVo.openYn}">checked='checked'</c:if> />&nbsp;<label for="openYnN">미공개</label>
                    <p class="tx_blue_s">설문 작성이 완료된 후 공개로 변경.</p>
                </td>
                <th>용도선택</th>
                <td>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnN" value="N" <c:if test="${dataVo.bannerYn eq 'N'}">checked="checked"</c:if> />&nbsp;<label for="bannerYnN">설문</label>
                    <input type="radio" class="radio" name="bannerYn" id="bannerYnY" value="Y" <c:if test="${dataVo.bannerYn eq 'Y'}">checked="checked"</c:if> />&nbsp;<label for="bannerYnY">설문 + 배너</label>
                    <p class="tx_blue_s">(메인 페이지 베너 기능이 있을 시)</p>
                </td>
            </tr>
            
            <c:if test="${dataVo.endYn eq 'Y'}">
            <tr>
                <th>결과요약</th>
                <td colspan="3">
                    <textarea name="summary" id="summary" rows="5" cols="30" class="textarea w-80per" >${dataVo.summary}</textarea>
                </td>
            </tr>        
            </c:if>
            
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><input type="submit" value="수정" class="w_blue" /></li>
            <li><input type="button" value="목록" class="blue" onclick="jsPollList();" /></li>
        </ul>
    </div>
    <!-- //버튼 -->

    </form>