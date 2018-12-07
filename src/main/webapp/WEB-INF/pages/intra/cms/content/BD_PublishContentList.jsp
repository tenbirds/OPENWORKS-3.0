<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>컨텐츠 발행 요청 관리</title>

    <op:jsTag type="spi" items="highlight" />
    <op:jsTag type="openworks" items="ui, form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>

    <script type="text/javascript">
    
        $().ready(function() {
        });

    </script>
</head>

<body>

    <ul class="tab">
        <li><a onclick="jsPublishTabList('BD_PublishContentList.do',1020);return false;" href="BD_PublishContentList.do?q_domainCd=${param.q_domainCd}&q_menuPath=${param.q_menuPath}&q_approvalSt=1020" <c:if test="${empty param.q_approvalSt or param.q_approvalSt eq '1020'}" >class="on"</c:if>><span>발행요청</span></a></li>
        <li><a onclick="jsPublishTabList('BD_PublishContentList.do',1040);return false;" href="BD_PublishContentList.do?q_domainCd=${param.q_domainCd}&q_menuPath=${param.q_menuPath}&q_approvalSt=1040" <c:if test="${param.q_approvalSt eq '1040'}" >class="on"</c:if>><span>발행완료</span></a></li>
        <li><a onclick="jsPublishTabList('BD_PublishContentList.do',1030);return false;" href="BD_PublishContentList.do?q_domainCd=${param.q_domainCd}&q_menuPath=${param.q_menuPath}&q_approvalSt=1030" <c:if test="${param.q_approvalSt eq '1030'}" >class="on"</c:if>><span>발행반려</span></a></li>
        <li><a onclick="jsPublishTabList('BD_PublishContentList.do',1000);return false;" href="BD_PublishContentList.do?q_domainCd=${param.q_domainCd}&q_menuPath=${param.q_menuPath}&q_approvalSt=1000" <c:if test="${param.q_approvalSt eq '1000'}" >class="on"</c:if>><span>전체</span></a></li>
    </ul>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_PublishContentList.do">
        <input type="hidden" id="q_approvalSt" name="q_approvalSt" value="<c:out value="${param.q_approvalSt}" default="1020" />" />

        <div class="search">
            <fieldset>
                <legend>발행요청 컨텐츠 검색</legend>

                <label class="skip" for="q_domainCd">사이트 선택</label>
                <select name="q_domainCd" id="q_domainCd" class="over">
                    <option value="">-- 사이트 선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo" varStatus="status">
                        <option value="${domainVo.domainCd}" 
                            <c:if test="${domainVo.domainCd eq param.q_domainCd}">selected="selected"</c:if>>
                            ${domainVo.domainNm}</option>
                    </c:forEach>
                </select>

                <label class="skip" for="q_menuPath">메뉴명 입력</label>
                메뉴명 : <input type="text" name="q_menuPath" id="q_menuPath" value="${param.q_menuPath}" class="w215" title="메뉴명을 입력하세요." />
                <button class="gray mar_l5">검색</button>

            </fieldset>
        </div>

        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        <c:choose>
            <c:when test="${empty param.q_approvalSt or param.q_approvalSt eq '1020'}"><c:set var="approvalStNm" value="발행요청"/></c:when>
            <c:when test="${param.q_approvalSt eq '1040'}"><c:set var="approvalStNm" value="발행완료"/></c:when>
            <c:when test="${param.q_approvalSt eq '1030'}"><c:set var="approvalStNm" value="발행반려"/></c:when>
            <c:when test="${param.q_approvalSt eq '1000'}"><c:set var="approvalStNm" value="전체"/></c:when>
        </c:choose>
        <op:pagerParam title="${approvalStNm} 컨텐츠 목록" />

    </form>
    <!-- //검색 -->

    <div id="tabDiv">

        <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="300px" />
                <col width="" />
                <col width="70px" />
                <col width="70px" />
                <col width="120px" />
            </colgroup>
            <thead>
            <tr>
                <th>메뉴경로</th>
                <th>발행사유</th>
                <th>버전</th>
                <th>상태</th>
                <th class="lr_none">요청일</th>
            </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach items="${pager.list}" var="contentVO" varStatus="status">
                <tr>
                    <td class="tx_l"> 
                        <a href="<c:url value="/intra/cms/content/PD_SourceDiffView.do" />?q_domainCd=${contentVO.domainCd}&q_menuCode=${contentVO.menuCode}&q_leftContentSeqNo=${contentVO.contentSeqNo}" target="_blank">${contentVO.menuPath}</a>
                    </td>
                    <td class="tx_l">${contentVO.publishReason}</td>
                    <td># ${contentVO.contentSeqNo}</td>
                    <td>
                        <c:choose>
                            <c:when test="${contentVO.applyYn eq 'Y'}"><span style="color:blue;">적용</span></c:when>
                            <c:when test="${contentVO.approvalSt eq '1010'}">작성중</c:when>
                            <c:when test="${contentVO.approvalSt eq '1020'}"><span style="color:red;">요청</span></c:when>
                            <c:when test="${contentVO.approvalSt eq '1030'}">반려</c:when>
                            <c:when test="${contentVO.approvalSt eq '1040'}"><span style="font-weight: bold;">발행</span></c:when>
                        </c:choose>
                    </td>
                    <td class="lr_none">${contentVO.modDt}</td>
                </tr>
            </c:forEach>
    
            <op:no-data obj="${pager}" colspan="5"/>
    
            </tbody>
        </table>
    </div>
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>
