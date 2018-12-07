<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">

    $(document).ready(function() {
        $("#dataForm").submit(function() {
            jsMovePage($("#q_currPage").val(), $("#q_rowPerPage").val());
            return false;
        });
    });

    /** 소스 비교 */
    var jsContentDiffView = function() {
        var leftContentSeqNo = $("input:radio[name=leftContentSeqNo]:checked").val();
        var rightContentSeqNo = $("input:radio[name=rightContentSeqNo]:checked").val();

        if(!leftContentSeqNo || !rightContentSeqNo) {
            jsWarningBox("차이점을 보기 위한 버전을 2개 선택하세요.");
            return;
        }
        if(leftContentSeqNo == rightContentSeqNo) {
            jsWarningBox("동일 버전에서는 차이점을 볼 수 없습니다.");
            return;
        }

        var url = "<c:url value="/intra/cms/content/PD_SourceDiffView.do"/>?q_domainCd=${dataVo.domainCd}&q_menuCode=${dataVo.menuCode}&q_leftContentSeqNo=" + leftContentSeqNo + "&q_rightContentSeqNo=" + rightContentSeqNo;
        window.open(url, null, "toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=1000,height=600");
        return false;
    };

    /** 페이징 */
    var jsMovePage = function(cpage, rpage) {
        if(!rpage) {
            rpage = $("#q_rowPerPage").val();
        }
        
        var url = "<c:url value="/intra/cms/content/INC_ContentList.do"/>?q_currPage="+cpage+"&q_rowPerPage="+rpage;

        var selectedIndex = tabs.currentIndex();

        tabs.changeUrl(selectedIndex, url);
        tabs.loadTab(selectedIndex);
    };

</script>

<form id="dataForm" name="dataForm" method="post" action="/intra/cms/content/INC_ContentList.do">

    <input type="hidden" id="domainNm" name="domainNm" value="${dataVo.domainNm}" />
    <input type="hidden" id="portNo" name="portNo" value="${dataVo.portNo}" />

    <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
    <op:pagerParam />

    <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup>
            <col width="50px" />
            <col width="50px" />
            <col width="80px" />
            <col width="" />
            <col width="" />
            <col width="70px" />
            <col width="70px" />
            <col width="100px" />
        </colgroup>
        <thead>
        <tr>
            <th>비교1</th>
            <th>비교2</th>
            <th>편집</th>
            <th>발행사유</th>
            <th>승인내용</th>
            <th>상태</th>
            <th>등록자</th>
            <th class="lr_none">등록일</th>
        </tr>
        </thead>
        <tbody id="odd-color">

        <c:forEach items="${pager.list}" var="contentVO" varStatus="status">
            <c:set var="class" value="${status.count % 2 == 1 ? 'even' : 'odd'}" />
                   
        <tr>
            <td style="text-align:center">
                <input type="radio" name="leftContentSeqNo" id="left_${contentVO.contentSeqNo}" class="radio" 
                    value="${contentVO.contentSeqNo}" />
            </td>
            <td>
                <input type="radio" name="rightContentSeqNo" id="right_${contentVO.contentSeqNo}" class="radio" 
                    value="${contentVO.contentSeqNo}"
                    <c:if test="${status.first}"> checked="checked"</c:if> 
                 />
            </td>
            <td>
                <button type="button" class="s_blue" onclick="jsAdminPreview('<c:url value="/intra/cms/content/BD_ContentForm.do"/>?q_domainCd=${contentVO.domainCd}&q_menuCode=${contentVO.menuCode}&q_contentSeqNo=${contentVO.contentSeqNo}');">#${contentVO.contentSeqNo}</button>
            </td>
            <td class="tl"><c:out value="${contentVO.publishReason}" /></td>
            <td>
                <c:choose>
                    <c:when test="${contentVO.approvalSt eq '1010' or contentVO.approvalSt eq '1020'}"></c:when>
                    <c:when test="${not empty contentVO.approvalReason}"><c:out value="${contentVO.approvalReason}" /></c:when>
                    <c:when test="${dataVo.approvalYn eq 'N'}">자동승인</c:when>
                </c:choose>
            </td>
            <td>
                <c:choose>
                    <c:when test="${contentVO.applyYn eq 'Y'}">
                        <button type="button" class="s_blue" onclick="jsUserPreview('<c:url value="${dataVo.userMenuUrl}"/>');">적용</button>
                    </c:when>
                    <c:when test="${contentVO.approvalSt eq '1010'}">작성</c:when>
                    <c:when test="${contentVO.approvalSt eq '1020'}">요청</c:when>
                    <c:when test="${contentVO.approvalSt eq '1030'}"><span style="color:red;">반려</span></c:when>
                    <c:when test="${contentVO.approvalSt eq '1040'}"><span style="color:blue;">승인</span></c:when>
                </c:choose>
            </td>
            <td>${contentVO.regNm}</td>
            <td class="lr_none">${contentVO.regDt}</td>
        </tr>
        </c:forEach>
        
        <op:no-data obj="${pager}" colspan="8"/>
        
        </tbody>
    </table>

</form>

<!-- 페이징 -->
<op:pager pager="${pager}" />
<!-- //페이징 -->

<c:if test="${fn:length(pager.list) > 1}">
    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="w_blue" onclick="jsContentDiffView();" >비교</button></li>
        </ul>
    </div>
    <!-- //버튼 -->
</c:if>

