<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title>권한추가요청 처리결과 - 반려</title>
</head>

<body>
    <!-- 컨텐츠영역 -->
    <h2>권한추가요청 신청자 정보</h2>
    <div class="mar_b30">
        <table class="boardWrite" cellspacing="0" border="0">
            <colgroup>
                <col width="15%" />
                <col width="35%" />
                <col width="15%" />
                <col width="35%" />
            </colgroup>
            <tbody>
                <tr>
                    <th>부서명</th>
                    <td>${dataVo.deptNm}</td>
                    <th>직책</th>
                    <td>${dataVo.gradeNm}</td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>${dataVo.mgrId}</td>
                    <th>성명</th>
                    <td>${dataVo.mgrNm}</td>
                </tr>
                <tr>
                    <th>요청일</th>
                    <td>${dataVo.reqModiDtm}</td>
                    <th>처리일</th>
                    <td>${dataVo.prcModiDtm}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h2>권한추가 요청 처리 결과</h2>
    <div class="mar_b30" style="width:100%;">
        <table class="tb_yellow" cellspacing="0" border="0">
            <colgroup>
                <col width="35%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;">관리자권한</th>
                </tr>
                <c:forEach items="${dataList}" var="_bean" varStatus="status">
                <tr>
                    <td class="rl">
                        <c:if test="${_bean.authTypeCd eq 'G' }">권한그룹</c:if>
                        <c:if test="${_bean.authTypeCd eq 'P' }">개별권한</c:if>
                    </td>
                    <td>${_bean.authNm}</td>
                </tr>
                </c:forEach>
                <c:forEach items="${baseVo}" var="_bean" varStatus="status">
                <tr>
                    <td class="tx_red rl">
                        <c:if test="${_bean.authTypeCd eq 'G' }">권한그룹</c:if>
                        <c:if test="${_bean.authTypeCd eq 'P' }">개별권한</c:if>
                    </td>
                    <td class="tx_red">${_bean.authNm }</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h2>추가요청 권한정보</h2>
    <div class="mar_b30" style="width:100%;">
        <table class="tb_yellow" cellspacing="0" border="0">
            <colgroup>
                <col width="35%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="2" style="text-align:center;font-weight:bold;">관리자권한</th>
                </tr>
                <c:forEach items="${viewObject}" var="_bean" varStatus="status">
                <tr>
                    <td class="rl">
                        <c:if test="${_bean.authTypeCd eq 'G' }">권한그룹</c:if>
                        <c:if test="${_bean.authTypeCd eq 'P' }">개별권한</c:if>
                    </td>
                    <td>${_bean.authNm }</td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <h2>신청사유</h2>
    <div class="mar_b30">
        <table class="boardWrite" cellspacing="0" border="0">
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th>사유</th>
                    <td>${dataVo.reqConts}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <h2 class="clear">반려사유</h2>
    <div class="mar_b30">
        <table class="boardWrite" cellspacing="0" border="0">
            <colgroup>
                <col width="15%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th>사유</th>
                    <td>${dataVo.resConts}</td>
                </tr>
            </tbody>
        </table>
    </div>

    <!-- //컨텐츠영역 -->
</body>
</html>
