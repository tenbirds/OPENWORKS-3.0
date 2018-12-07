<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>소스비교</title>

    <script type="text/javascript">
    //<CDATA[[

        var jsContentDiffView = function() {
            var leftContentSeqNo = $("#q_leftContentSeqNo").val();
            var rightContentSeqNo = $("#q_rightContentSeqNo").val();

            if(leftContentSeqNo == rightContentSeqNo) {
                jsWarningBox("동일 버전에서는 차이점을 볼 수 없습니다.");
                return;
            }

            $("#dataForm").submit();
        };

    </script>
</head>

<body>

    <div id="tabDiv">
        <ul class="tab">
            <li><a class="on" href="<c:url value="/intra/cms/content/PD_SourceDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}&q_rightContentSeqNo=${baseVo.rightContent.contentSeqNo}"><span>소스비교</span></a></li>
            <li><a href="<c:url value="/intra/cms/content/PD_ScreenDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}&q_rightContentSeqNo=${baseVo.rightContent.contentSeqNo}"><span>화면비교</span></a></li>
        </ul>
    </div>

    <form name="dataForm" id="dataForm" action="<c:url value="/intra/cms/content/PD_SourceDiffView.do"/>" method="post">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" ignores="q_leftContentSeqNo,q_rightContentSeqNo"/>

        <div id="helpDiv" class="show">
            <div class="point_blue">
            <b>${param.filePath}</b> 파일의 버전 
        
            <select id="q_leftContentSeqNo" name="q_leftContentSeqNo" onchange="jsContentDiffView();">
                <c:forEach items="${baseVo.contentSeqNos}" var="leftContentSeqNo" varStatus="status">
                    <option value="${leftContentSeqNo}" 
                        <c:if test="${leftContentSeqNo eq baseVo.leftContent.contentSeqNo}">selected="selected"</c:if>>#${leftContentSeqNo} &nbsp;</option>
                </c:forEach>
            </select>과 버전 

            <select id="q_rightContentSeqNo" name="q_rightContentSeqNo" onchange="jsContentDiffView();">
                <c:forEach items="${baseVo.contentSeqNos}" var="rightContentSeqNo">
                    <option value="${rightContentSeqNo}" 
                        <c:if test="${rightContentSeqNo eq baseVo.rightContent.contentSeqNo}">selected="selected"</c:if>>#${rightContentSeqNo} &nbsp;</option>
                </c:forEach>
            </select>의 차이점 비교
            </div>
        </div>

        <br class="blank" />

        <c:if test="${not empty dataVo}">

            <table id="diffTwoTbl" class="boardList">
                <colgroup>
                    <col width="8%" />
                    <col width="46%" />
                    <col width="46%" />
                </colgroup>
                <thead>
                <tr>
                    <th>결과</th>
                    <th>버전 #${baseVo.leftContent.contentSeqNo}</th>
                    <th><c:choose><c:when test="${baseVo.rightContent.applyYn eq 'Y'}">현재적용버전</c:when><c:otherwise>버전 #${baseVo.rightContent.contentSeqNo}</c:otherwise></c:choose></th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty dataVo}">
                        <tr>
                            <td colspan="3">
                                <span class="point_red">차이점이 없습니다.</span>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${dataVo}" var="diffVo">
                            <c:set var="backgroundcolor" value="#FFFFFF" />
                            <c:choose>
                                <c:when test="${diffVo.tag eq 'add'}"><c:set var="backgroundcolor" value="#DFEAF3" /></c:when>
                                <c:when test="${diffVo.tag eq 'modify'}"><c:set var="backgroundcolor" value="#DFEAF3" /></c:when>
                                <c:when test="${diffVo.tag eq 'delete'}"><c:set var="backgroundcolor" value="#FCFADD" /></c:when>
                            </c:choose>

                            <tr style="background-color:${backgroundcolor};">
                                <td style="height: 12px;">${diffVo.tagName}</td>
                                <td class="tx_l" style="word-wrap:break-word;height: 12px;">${diffVo.oldLine}</td>
                                <td class="tx_l" style="word-wrap:break-word;height: 12px;">${diffVo.newLine}</td>
                            </tr>
                        </c:forEach>

                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>

        </c:if>

    </form>

    <c:if test="${empty dataVo}">
        <div id="warnDiv"><span class="point_red">차이점이 없습니다.</span></div>
    </c:if>

    <h4>승인/반려 사유</h4>
    <table class="boardWrite" summary="승인/반려 사유">
        <caption class="title">승인/반려 사유</caption>
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tbody>
            <tr>
                <th>발행 사유</th>
                <td>${baseVo.leftContent.publishReason}</td>
            </tr>
            <tr>
                <th>승인/반려 사유</th>
                <td>${baseVo.leftContent.approvalReason}</td>
            </tr>
        </tbody>
    </table>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="w_blue" onclick="self.close();" >닫기</button></li>
        </ul>
    </div>
    <!-- //버튼 -->

</body>
</html>