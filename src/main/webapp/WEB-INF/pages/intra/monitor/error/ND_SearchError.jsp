<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류 관리</title>

    <op:jsTag type="openworks" items="admin-core" />

    <link rel="stylesheet" type="text/css" href="/resources/monitor/css/contents.css" />

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {

        });
        //]]>
    </script>
</head>
<body>

    <!-- 컨텐츠영역 -->
    <div id="contents_area">

        <c:if test="${empty param.q_errorNo}">
            <!-- 검색 -->
            <form name="dataForm" id="dataForm" method="get" action="ND_SearchError.do">

                <div class="search">
                    <fieldset>
                        <legend>오류 목록 검색</legend>
        
                        <label class="skip" for="q_errorNo">오류번호 검색</label>
                        오류번호 : <input type="text" name="q_errorNo" id="q_errorNo" value="${param.q_errorNo}" class="w120" title="오류번호를 입력하세요." />
        
                        <button class="gray mar_l5 mar_b5">검색</button>
                    </fieldset>
                </div>

            </form>
            <!-- //검색 -->
        </c:if>

        <c:choose>
            <c:when test="${not empty param.q_errorNo and empty dataVo}">
    
                <h4 class="tx_13">처리정보</h4>
                <!-- 처리정보 내용보기 -->
                <table class="boardWrite" cellspacing="0" border="0" summary="오류내용 기본정보">
                    <caption class="hidden">오류내용 상세정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align:center;">검색 결과가 없습니다.</td>
                        </tr>
                    </tbody>
                </table>
    
            </c:when>
            <c:when test="${empty param.q_errorNo}">
    
                <h4 class="tx_13">처리정보</h4>
                <!-- 처리정보 내용보기 -->
                <table class="boardWrite" cellspacing="0" border="0" summary="오류내용 기본정보">
                    <caption class="hidden">오류내용 상세정보</caption>
                    <tbody>
                        <tr>
                            <td style="text-align:center;">오류번호를 입력하고 검색하세요.</td>
                        </tr>
                    </tbody>
                </table>

            </c:when>
            <c:when test="${not empty dataVo}">

                <%-- 처리자 정보 --%>
                <c:set var="transactorVo" value="${dataVo.transactor}" />
    
                <h4 class="tx_13">처리정보</h4>
                <!-- 처리정보 내용보기 -->
                <table class="boardWrite" cellspacing="0" border="0" summary="오류내용 기본정보">
                    <caption class="hidden">오류내용 상세정보</caption>
                    <colgroup>
                        <col width="15%" />
                        <col width="35%" />
                        <col width="15%" />
                        <col width="35%" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>최초오류발생일</th>
                            <td>${dataVo.errorStDt}</td>
                            <th>최종오류발생일</th>
                            <td>
                                ${dataVo.errorEdDt}
                                <c:if test="${not empty dataVo.errorTermDt}">
                                    (<span style="color:red;">${dataVo.errorTermDt}</span>일간)
                                </c:if>
                            </td>
                        </tr>
                        <tr>
                            <th>처리상태</th>
                            <td>
                                <c:choose>
                                    <c:when test="${dataVo.errorProcStatus eq '1020'}">배정</c:when>
                                    <c:when test="${dataVo.errorProcStatus eq '1030'}">처리중</c:when>
                                    <c:when test="${dataVo.errorProcStatus eq '1040'}">완료</c:when>
                                    <c:otherwise>미배정</c:otherwise>
                                </c:choose>
                            </td>
                            <th>배정일시</th>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty dataVo.errorAssignDt}">
                                        <span style="font-weight: bold;">배정일</span> : ${dataVo.errorAssignDt}
                                    </c:when>
                                    <c:otherwise>
                                        배정전
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${dataVo.errorProcStatus eq '1040'}" >
                                    <br />
                                    <span style="font-weight: bold;">완료일</span> : ${dataVo.errorProcDt} (<span style="color:red;">${dataVo.errorProcTerm}</span>일 소요)
                                </c:if>
                            </td>
                        </tr>
                        <c:if test="${dataVo.errorProcStatus ne '1010'}">
                            <tr>
                                <th>담당자</th>
                                <td colspan="3">
                                    ${dataVo.transactorNm}
                                    <c:if test="${not empty dataVo.transactorNm}">
                                        ( 이메일 : ${transactorVo.email}, 전화번호 : ${transactorVo.telNo} )
                                    </c:if>
                                </td>
                            </tr>
                        </c:if>
                        <c:if test="${not empty dataVo.guideCont}">
                            <tr>
                                <th>이용안내(임시조치방안)</th>
                                <td colspan="3">
                                    <op:nrToBr content="${dataVo.guideCont}" />
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                <!-- //처리정보 내용보기 -->

            </c:when>
        </c:choose>
    </div>
</body>
</html>