<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오류 관리</title>

    <op:jsTag type="spi" items="colorbox, ui, tooltip"/>
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
            // 툴팁 설정
            $(".attrNm").tooltip({ });
        });
        
        //]]>
    </script>
</head>
<body>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="post" action="BD_ErrorDetlList.do">

        <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
        <op:pagerParam view="view" ignores="q_detlSeqNo" />

    </form>

    <h4 class="tx_13">사용자정보</h4>
    <!-- 처리정보 내용보기 -->
    <table class="boardWrite" cellspacing="0" border="0" summary="사용자정보">
        <caption class="hidden">사용자정보</caption>
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <tbody>
            <tr>
                <th>오류번호</th>
                <td>${dataVo.errorNo}</td>
                <th>등록일</th>
                <td>${dataVo.regDt}</td>
            </tr>
            <tr>
                <th>사용자구분</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.userGroup eq 'M'}">관리자</c:when>
                        <c:when test="${dataVo.userGroup eq 'U'}">회원</c:when>
                        <c:when test="${dataVo.userGroup eq 'N'}">비회원</c:when>
                    </c:choose>
                </td>
                <th>사용자IP</th>
                <td>${dataVo.userIp}</td>
            </tr>
<!--
            <tr>
                <th>사용자이름</th>
                <td>
                    ${dataVo.userName}
                    <c:choose>
                        <c:when test="${dataVo.errorInformYn eq 'Y'}">통보요청</c:when>
                        <c:otherwise></c:otherwise>
                    </c:choose>
                </td>
                <th>사용자아이디</th>
                <td>${dataVo.userId}</td>
            </tr>
            <tr>
                <th>사용자이메일</th>
                <td>${dataVo.email}</td>
                <th>사용자전화번호</th>
                <td>${dataVo.mobNo}</td>
            </tr>
            <tr>
                <th>기타의견(사용자입력)</th>
                <td colspan="3"><op:nrToBr content="${dataVo.etc}" /></td>
            </tr>
-->
        </tbody>
    </table>
    <!-- //처리정보 내용보기 -->

    <h4 class="mar_t30">환경정보</h4>
    <!-- 기본정보 내용보기 -->
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
                <th>프로토콜</th>
                <td>${dataVo.errorProtocol}</td>
                <th>요청방식</th>
                <td>${dataVo.errorReqMethod}</td>
            </tr>

            <tr>
                <th>운영체제</th>
                <td>
                    <span id="attrOs" class="attrNm">${dataVo.osNm}</span>
                    <div id="attrOsTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.osDesc}">
                                <op:nrToBr content="${dataVo.osDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>장치종류</th>
                <td>
                    <span id="attrDivice" class="attrNm">${dataVo.diviceNm}</span>
                    <div id="attrDiviceTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.diviceDesc}">
                                <op:nrToBr content="${dataVo.diviceDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>

            <tr>
                <th>프로그램유형</th>
                <td>
                    <span id="attrBrowserType" class="attrNm">${dataVo.browserTypeNm}</span>
                    <div id="attrBrowserTypeTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.browserTypeDesc}">
                                <op:nrToBr content="${dataVo.browserTypeDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
                <th>브라우저정보</th>
                <td>
                    <span id="attrBrowser" class="attrNm">${dataVo.browserNm}</span>
                    <div id="attrBrowserTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty dataVo.browserDesc}">
                                <op:nrToBr content="${dataVo.browserDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>

            <tr>
                <th>인입주소</th>
                <td colspan="3">
                    ${dataVo.errorReferer}
                </td>
            </tr>

            <tr>
                <th>요청주소</th>
                <td colspan="3">
                    <c:set var="protocol" value="http" />
                    <c:set var="port" value="" />

                    <c:if test="${dataVo.secureProtocolYn eq 'Y'}">
                        <c:set var="protocol" value="https" />
                    </c:if>
                   <c:if test="${baseVo.serverPort ne '80'}">
                       <c:set var="port" value=":${baseVo.serverPort}" />
                   </c:if>
                    ${protocol}://${baseVo.domainNm}${port}${baseVo.errorUriNm}

                    <div id="attrUriTip" class="attrNmTip" style="display:none;">
                        <c:choose>
                            <c:when test="${not empty baseVo.errorUriDesc}">
                                <op:nrToBr content="${baseVo.errorUriDesc}" />
                            </c:when>
                            <c:otherwise>
                                등록된 내용이 없습니다.
                            </c:otherwise>
                        </c:choose>
                    </div>
                </td>
            </tr>

            <tr>
                <th>파라미터</th>
                <td colspan="3">
                    <c:if test="${not empty dataVo.errorParameter}">
                        <textarea readonly="readonly" style="width:99%;height:50px;">${dataVo.errorParameter}</textarea>
                    </c:if>
               	</td>
            </tr>

            <tr>
                <th>컨텐츠유형</th>
                <td>${dataVo.errorContType}</td>
                <th>응답유형</th>
                <td>${dataVo.errorAcceptType}</td>
            </tr>

            <tr>
                <th>쿼리스트링</th>
                <td colspan="3">${dataVo.errorQueryStr}</td>
            </tr>

            <tr>
                <th>세션정보</th>
                <td colspan="3"><textarea readonly="readonly" style="width:99%;height:200px;">${dataVo.errorSession}</textarea></td>
            </tr>

            <tr>
                <th>쿠키정보</th>
                <td colspan="3">${dataVo.errorCookie}</td>
            </tr>

        </tbody>
    </table>
    <!-- //기본정보 내용보기 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t20">
        <input type="image" alt="목록" src="/resources/monitor/images/btn/btn_list.gif" onclick="jsList();return false;" />
    </div>
    <!-- //버튼 -->

</body>
</html>