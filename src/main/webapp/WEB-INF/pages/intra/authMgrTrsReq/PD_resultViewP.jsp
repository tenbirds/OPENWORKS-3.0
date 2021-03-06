<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
<title>권한이양 처리결과 - 승인</title>
</head>
<body>
    <!-- 컨텐츠영역 -->
        <h2>권한이양 신청자 정보</h2>
        <div class="mar_b30">
            <table class="boardWrite">
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>아이디</th>
                        <td>${dataVo.mgrId}</td>
                        <th>성명</th>
                        <td>${dataVo.mgrNm}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="float_l mar_b30" style="width:100%;">
            <div class="float_l" style="width:49%;margin-right:20px;">
                <table class="tb_yellow">
                    <tbody>
                        <tr>
                            <th style="text-align:center;font-weight:bold;">변경 전 권한</th>
                        </tr>
                        <c:forEach items="${currentlyList}" var="_bean">
	                        <tr>
	                            <td>${_bean.authNm}</td>
	                        </tr>
                        </c:forEach>
                        <c:forEach items="${authTrasferList}" var="_bean1">
	                        <tr>
	                            <td class="tx_red">${_bean1.authNm}</td>
	                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(currentlyList) == 0 && fn:length(authTrasferList) == 0}">
                        <tr>
                            <td>지정된 권한 없음.</td>
                        </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            <div class="float_l" style="width:47%;">
                <table class="tb_yellow">
                    <tbody>
                        <tr>
                            <th style="text-align:center;font-weight:bold;"><span class="tx_red">변경 후 권한</span></th>
                        </tr>
                        <c:forEach items="${currentlyList}" var="_bean">
                        <tr>
                            <td>${_bean.authNm}</td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(currentlyList) == 0}">
                            <tr>
                                <td>지정된 권한 없음.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <h2 class="clear">권한이양 대상자 정보</h2>
        <div class="mar_b30">
            <table class="boardWrite">
                <colgroup>
                    <col width="15%" />
                    <col width="35%" />
                    <col width="15%" />
                    <col width="35%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>아이디</th>
                        <td>${dataVo.targetMgrId}</td>
                        <th>성명</th>
                        <td>${dataVo.targetMgrNm}</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="float_l mar_b30" style="width:100%;">
            <div class="float_l" style="width:49%;margin-right:20px;">
                <table class="tb_yellow">
                    <tbody>
                        <tr>
                            <th style="text-align:center;font-weight:bold;">변경 전 권한</th>
                        </tr>
                        <c:forEach items="${targetMgrAuthBeforeList}" var="_bean">
                        <tr>
                            <td>${_bean.authNm}</td>
                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(targetMgrAuthBeforeList) == 0}">
                            <tr>
                                <td>지정된 권한 없음.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            <div class="float_l" style="width:47%;">
                <table class="tb_yellow">
                    <tbody>
                        <tr>
                            <th style="text-align:center;font-weight:bold;"><span class="tx_red">변경 후 권한</span></th>
                        </tr>

                        <c:forEach items="${targetMgrAuthBeforeList}" var="_bean">
	                        <tr>
	                            <td>${_bean.authNm}</td>
	                        </tr>
                        </c:forEach>
                       	<c:forEach items="${authTrasferList}" var="_bean1">
	                        <tr>
	                            <td class="tx_red">${_bean1.authNm}</td>
	                        </tr>
                        </c:forEach>
                        <c:if test="${fn:length(targetMgrAuthAfterList) == 0 && fn:length(authTrasferList) == 0}">
                            <tr>
                                <td>지정된 권한 없음.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="float_l mar_b30" style="width:100%; height: 10px"></div>
    <!-- //컨텐츠영역 -->
</body>
</html>