<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.base.support.*,zes.openworks.monitor.error.*" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />
    <title>상태코드 ${errorVo.errorResNm} 오류가 발생되었습니다.</title>

    <op:jsTag type="spi" items="jquery" />
    <op:jsTag type="openworks" />

    <script type="text/javascript">
    //<CDATA[[

    //]]>
    </script>

</head>
 
<body>

    <!-- 컨텐츠영역 -->
    <div id="contents_area">

    <%-- 처리자 정보 --%>
    <c:set var="transactorVo" value="${errorVo.transactor}" />

    <h4 class="tx_13">오류 현황</h4>
    <table class="boardWrite" cellspacing="0" border="0" summary="오류발생에 대한 안내">
        <caption class="hidden">오류발생에 대한 안내</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>
            <tr>
                <th>접수번호</th>
                <td>${errorVo.errorNo}</td>
            </tr>
            <tr>
                <th>진행상태조회</th>
                <td>
                    <%
                        boolean isSecure = request.isSecure();
                        int port = request.getServerPort();
                        StringBuilder host = new StringBuilder();
                        if(isSecure) {
                            host.append("https://");
                        } else {
                            host.append("http://");
                        }
                        host.append(request.getServerName());
                        if(port != 80 && port != 443) {
                            host.append(":").append(request.getServerPort());
                        }
                    %>
                    <a href="<%= host.toString() %>/collector/error/ND_SearchError.do?q_errorNo=${errorVo.errorNo}" target="_blank">
                        <%= host.toString() %>/collector/error/ND_SearchError.do?q_errorNo=${errorVo.errorNo}
                    </a>
                    <p>조회페이지로 이동후 즐겨찾기(북마크)에 등록해 두시면, 추후 쉽게 확인하실 수 있습니다.</p>
                </td>
            </tr>

            <tr>
                <th>처리상태</th>
                <td>
                    <c:choose>
                        <c:when test="${errorVo.errorProcStatus eq '1020'}">배정</c:when>
                        <c:when test="${errorVo.errorProcStatus eq '1030'}">처리중</c:when>
                        <c:when test="${errorVo.errorProcStatus eq '1040'}">완료</c:when>
                        <c:otherwise>미배정</c:otherwise>
                    </c:choose>
                </td>
            </tr>

            <c:if test="${errorVo.errorProcStatus ne '1010'}" >
                <tr>
                    <th>배정일시</th>
                    <td>
                        <c:choose>
                            <c:when test="${not empty errorVo.errorAssignDt}">
                                <span style="font-weight: bold;">배정일</span> : ${errorVo.errorAssignDt}
                            </c:when>
                            <c:otherwise>
                                배정전
                            </c:otherwise>
                        </c:choose>
                        <c:if test="${errorVo.errorProcStatus eq '1040'}" >
                            <br />
                            <span style="font-weight: bold;">완료일</span> : ${errorVo.errorProcDt} (<span style="color:red;">${errorVo.errorProcTermDt}</span>일 소요)
                        </c:if>
                    </td>
                </tr>
            </c:if>

            <c:if test="${not empty transactorVo}">
                <tr>
                    <th>담당자</th>
                    <td>
                        ${transactorVo.transactorNm}
                        ( 이메일 : ${transactorVo.email}, 전화번호 : ${transactorVo.telNo1}-${transactorVo.telNo2}-${transactorVo.telNo3} )
                    </td>
                </tr>
            </c:if>

            <c:if test="${not empty errorVo.guideCont}">
                <tr>
                    <th><label for="mobNo">이용안내</label></th>
                    <td>
                        <op:nrToBr content="${errorVo.guideCont}" />
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div style="margin:10px 60px 0 0;text-align:right;">
        <button type="button" class="blue" onclick="history.go(-2);" style="border:0px;" ><img src="/emguide/images/btn_return.gif" alt="돌아가기"/></button>
    </div>

    </div>
</body>
</html>


