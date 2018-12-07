<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>지정권한메뉴</title>
    <op:jsTag type="spi" items="validate" />
    <script type="text/javascript">
       $().ready(function(authCd) {

//    		alert(authCd);


      });
    </script>
</head>

<body>
            <!-- 컨텐츠영역 -->
                <div class="tx_r mar_b10">지정권한 : <span class="tx_red tx_b">${fn:length(dataVo)}</span>건</div>
                <!-- 리스트 -->
                <table class="boardList" cellspacing="0" border="0" summary="리스트">
                    <caption class="hidden">지정권한목록 </caption>
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
                    </tbody>
                </table>
                <!-- //리스트 -->

                <p class="tx_r mar_t20"><a href="#"><button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button></a></p>
            <!-- //컨텐츠영역 -->
</body>
</html>