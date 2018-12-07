<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<title>지정권한 목록</title>
<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
    $().ready( function() {
        var listSize = '${fn:length(dataList)}';
        var widthSize = (listSize % 4) * 100 + 550;
        if(listSize > 4){
            if(!isNaN(widthSize)) parent.$.colorbox.resize({width : widthSize, height: 550});
        }
    });

    var targetAssignSelect = function(authCd, mgrId){
        self.location.href = "PD_targetAssign.do?authCode="+authCd+"&mngrId="+mgrId;
    };
</script>
</head>

<body>
    <!-- 컨텐츠영역 -->
        <form name="dataForm" id="dataForm">
            <%-- 			<input type="text" id="authCd" name="authCd" value="${mgrVO.authCd}"/> --%>
            <!-- tab -->
            <!-- <ul class="pop_tab">
                <li class="on"><a href="#">관리자권한</a>
                </li>

            </ul> -->
            <!-- //tab -->

            <div class="mar_b10 clear pop_tab_s" id="targetAssignTabDiv">
                <ul class="float_l">
                    <c:set var="auth" value="${dataVo}"></c:set>
                    <c:forEach items="${dataList}" var="_bean" varStatus="vts">
                        <li <c:if test="${_bean.authCode eq param.authCode or (empty param.authCode and vts.first)}">class="on"</c:if>>
                            <a href="#"onclick="targetAssignSelect('${_bean.authCode}','${param.mngrId}');">${_bean.authNm}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${empty dataList}">
                        <li class="on">${authInfo.authNm}</li>
                    </c:if>
                </ul>
                <div class="float_r mar_t5" style="width: 150px; text-align: right;">
                    지정권한 : <span class="tx_red tx_b">${fn:length(dataVo)}</span>건
                </div>
            </div>
            <!-- 리스트 -->
            <table class="boardList" cellspacing="0" border="0" summary="리스트">
                <caption class="hidden">지정권한목록</caption>
                <colgroup>
                    <col width="50%" />
                    <col width="50%" />
                </colgroup>
                <thead>
                    <tr>
                        <th>메뉴명</th>
                        <th class="lr_none">사용권한</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${dataVo}" var="_bean2">
                        <tr>
                            <td>${_bean2.mngrMenuNm}</td>
                            <td class="lr_none">
                                <c:if test="${_bean2.assignTyCode == 'R'}">조회권한</c:if>
                                <c:if test="${_bean2.assignTyCode == 'A'}">기본권한</c:if>
                                <c:if test="${_bean2.assignTyCode == 'G'}">총괄권한</c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty dataVo}">
                        <tr>
                            <td colspan="2">지정된 권한이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
            <!-- //리스트 -->
        </form>
    <!-- //컨텐츠영역 -->
</body>
</html>