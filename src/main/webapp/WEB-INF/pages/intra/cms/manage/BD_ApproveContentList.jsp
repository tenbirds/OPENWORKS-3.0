<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>컨텐츠 발행 승인 관리</title>

    <op:jsTag type="spi" items="highlight" />
    <op:jsTag type="openworks" items="ui, form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>

    <script type="text/javascript">
    //<CDATA[[
        $().ready(function() {
        });
    //]]>
    </script>
</head>

<body>

    <ul class="tab">
        <li><a onclick="jsPublishTabList('BD_ApproveContentList.do', 1020);return false;" href="BD_ApproveContentList.do?q_domainCd=${param.q_searchDomainCd}&q_searchKey=${param.q_searchKey}&q_searchVal=${param.q_searchVal}&q_approvalSt=1020" <c:if test="${empty param.q_approvalSt or param.q_approvalSt eq '1020'}" >class="on"</c:if>><span>발행요청</span></a></li>
        <li><a onclick="jsPublishTabList('BD_ApproveContentList.do', 1040);return false;" href="BD_ApproveContentList.do?q_domainCd=${param.q_searchDomainCd}&q_searchKey=${param.q_searchKey}&q_searchVal=${param.q_searchVal}&q_approvalSt=1040" <c:if test="${param.q_approvalSt eq '1040'}" >class="on"</c:if>><span>발행완료</span></a></li>
        <li><a onclick="jsPublishTabList('BD_ApproveContentList.do', 1030);return false;" href="BD_ApproveContentList.do?q_domainCd=${param.q_searchDomainCd}&q_searchKey=${param.q_searchKey}&q_searchVal=${param.q_searchVal}&q_approvalSt=1030" <c:if test="${param.q_approvalSt eq '1030'}" >class="on"</c:if>><span>발행반려</span></a></li>
        <li><a onclick="jsPublishTabList('BD_ApproveContentList.do', 1000);return false;" href="BD_ApproveContentList.do?q_domainCd=${param.q_searchDomainCd}&q_searchKey=${param.q_searchKey}&q_searchVal=${param.q_searchVal}&q_approvalSt=1000" <c:if test="${param.q_approvalSt eq '1000'}" >class="on"</c:if>><span>전체</span></a></li>
    </ul>

    <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_ApproveContentList.do">
        <input type="hidden" id="q_approvalSt" name="q_approvalSt" value="<c:out value="${param.q_approvalSt}" default="1020" />" />

        <div class="search">
            <fieldset>
                <legend>발행요청 컨텐츠 검색</legend>

                <label class="skip" for="q_domainCd">사이트 선택</label>
                <select name="q_searchDomainCd" id="q_domainCd" class="over">
                    <option value="">-- 사이트 선택 --</option>
                    <c:forEach items="${domainList}" var="domainVo" varStatus="status">
                        <option value="${domainVo.domainCd}" 
                            <c:if test="${domainVo.domainCd eq param.q_searchDomainCd}">selected="selected"</c:if>>
                            ${domainVo.domainNm}</option>
                    </c:forEach>
                </select>

                <label class="skip" for="q_searchKey">검색유형 선택</label>
                <select name="q_searchKey" id="q_searchKey" class="over">
                    <option value="">-- 검색유형 --</option>
                    <option value="1001" <c:if test="${param.q_searchKey == '1001'}">selected="selected"</c:if>>메뉴명</option>
                    <option value="1002" <c:if test="${param.q_searchKey == '1002'}">selected="selected"</c:if>>요청자</option>
                </select>
                
                <label class="skip" for="q_searchVal">검색단어 입력</label>
                <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" class="w215" title="검색어를 입력하세요." />
                <button class="gray mar_l5 mar_b5">검색</button>

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
                <col width="50px" />
                <col width="70px" />
                <col width="120px" />
                <col width="120px" />
                <col width="100px" />
            </colgroup>
            <thead>
            <tr>
                <th>메뉴경로</th>
                <th>발행사유</th>
                <th>버전</th>
                <th>상태</th>
                <th>요청일</th>
                <th>요청자</th>
                <th class="lr_none">미리보기</th>
            </tr>
            </thead>
            <tbody id="odd-color">
            <c:forEach items="${pager.list}" var="contentManageVo" varStatus="status">
                <tr>
                    <td class="tx_l"> 
                        <a onclick="jsMoveUrl('<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do" />?q_domainCd=${contentManageVo.domainCd}&q_menuCode=${contentManageVo.menuCode}&q_leftContentSeqNo=${contentManageVo.contentSeqNo}&q_approvalSt=${param.q_approvalSt}');return false;" href="<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do" />?q_domainCd=${contentManageVo.domainCd}&q_menuCode=${contentManageVo.menuCode}&q_leftContentSeqNo=${contentManageVo.contentSeqNo}&q_approvalSt=${param.q_approvalSt}">${contentManageVo.menuPath}</a>
                    </td>
                    <td class="tx_l">${contentManageVo.publishReason}</td>
                    <td># ${contentManageVo.contentSeqNo}</td>
                    <td>
                        <c:choose>
                            <c:when test="${contentManageVo.applyYn eq 'Y'}"><span style="color:blue;">적용</span></c:when>
                            <c:when test="${contentManageVo.approvalSt eq '1010'}">작성중</c:when>
                            <c:when test="${contentManageVo.approvalSt eq '1020'}"><span style="color:red;">요청</span></c:when>
                            <c:when test="${contentManageVo.approvalSt eq '1030'}">반려</c:when>
                            <c:when test="${contentManageVo.approvalSt eq '1040'}"><span style="font-weight: bold;">발행</span></c:when>
                        </c:choose>
                    </td>
                    <td>${contentManageVo.modDt}</td>
                    <td>${contentManageVo.modNm}</td>
                    <td class="lr_none">
                        <button type="button" class="s_blue" onclick="jsLayoutPreview('${contentManageVo.domainCd}', '${contentManageVo.layoutCode}', '${contentManageVo.menuCode}', ${contentManageVo.contentSeqNo});">미리보기</button>
                    </td>
                </tr>
            </c:forEach>
    
            <op:no-data obj="${pager}" colspan="7"/>
    
            </tbody>
        </table>
    </div>
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

</body>
</html>
