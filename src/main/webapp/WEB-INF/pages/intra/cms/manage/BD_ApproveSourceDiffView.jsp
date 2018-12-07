<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>컨텐츠비교</title>

    <op:jsTag type="spi" items="form" />
    <op:jsTag type="openworks" items="form" />

    <script type="text/javascript">
        //<CDATA[[
    
        $().ready(function() {
        });
    
        var jsContentDiffView = function() {
            var leftContentSeqNo = $("#leftContentSeqNo > option:selected").val();
            var rightContentSeqNo = $("#rightContentSeqNo > option:selected").val();
    
            if(leftContentSeqNo == rightContentSeqNo) {
                jsWarningBox("동일 버전에서는 차이점을 볼 수 없습니다.");
                return;
            }
    
            $("#dataForm").submit();
        };
    
        var jsPreview = function(revision) {
    
        };
    
        /** 목록 이동 */
        var jsList = function() {

            $("#dataForm").attr("action", "BD_ApproveContentList.do");

            $("#dataForm").submit();
        };
    
        /** 컨텐츠 발행 요청 승인 */
        var jsDeployComplete = function() {
            $("#approvalSt").val("1040");

            $("#dataForm").ajaxSubmit({
                url : "<c:url value="/intra/cms/manage/ND_ApproveAction.do"/>",
                type : "POST",
                dataType : "json",
                success : function(response) {
                    if (response.result) {
                        jsSuccessBox(response.message);
                    } else { 
                        jsErrorBox(response.message);
                    }
                    jsList();
                }
            });
        };
    
        /** 컨텐츠 발행 요청 반려 */
        var jsDeployReject = function() {
            $("#approvalSt").val("1030");
    
            if($.trim($("#approvalReason").val()) == "") {
                jsErrorBox("반려시에는 반려사유를 간략이 입력해 주세요.");
                return false;
            }

            $("#dataForm").ajaxSubmit({
                url : "<c:url value="/intra/cms/manage/ND_ApproveAction.do"/>",
                type : "POST",
                dataType : "json",
                success : function(response) {
                    if (response.result) {
                        jsSuccessBox(response.message);
                    } else { 
                        jsErrorBox(response.message);
                    }
                    jsList();
                }
            });
        };
        //]]>
    </script>
</head>

<body>

    <div id="tabDiv">
        <ul class="tab">
            <li><a class="on" onclick="jsMoveUrl('<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do"/>');return false;" href="<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}"><span>소스비교</span></a></li>
            <li><a onclick="jsMoveUrl('<c:url value="/intra/cms/manage/BD_ApproveScreenDiffView.do"/>');return false;" href="<c:url value="/intra/cms/manage/BD_ApproveScreenDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}"><span>화면비교</span></a></li>
        </ul>
    </div>

    <h4>승인요청 버전(# ${baseVo.leftContent.contentSeqNo})과 현재 적용버전 (# ${baseVo.rightContent.contentSeqNo})과의 차이점 비교</h4>

    <c:if test="${not empty dataVo}">

        <table class="boardList">
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



    <form name="dataForm" id="dataForm" action="<c:url value="BD_ApproveContentList.do"/>" method="post">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" />

        <input type="hidden" name="domainCd" id="domainCd" value="${baseVo.leftContent.domainCd}" />
        <input type="hidden" name="menuCode" id="menuCode" value="${baseVo.leftContent.menuCode}" />
        <input type="hidden" name="contentSeqNo" id="contentSeqNo" value="${baseVo.leftContent.contentSeqNo}" />

        <input type="hidden" name="approvalSt" id="approvalSt" value="" />

        <input type="hidden" name="leftContentSeqNo" id="leftContentSeqNo" value="${baseVo.leftContent.contentSeqNo}" />

        <br class="blank" />

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
                    <td>
                        <c:choose>
                            <c:when test="${baseVo.leftContent.approvalSt eq '1020'}">
                                <textarea id="approvalReason" name="approvalReason" rows="4" style="width: 100%;">${baseVo.leftContent.approvalReason}</textarea>
                                <span class="tx_blue_s">(최대 한글 <strong>400</strong>자)</span>
                            </c:when>
                            <c:otherwise>
                                ${baseVo.leftContent.approvalReason}
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <c:if test="${baseVo.leftContent.approvalSt eq '1020'}">
                    <li><button type="button" class="w_blue" onclick="jsDeployComplete();">발행승인</button></li>
                    <li><button type="button" class="w_blue" onclick="jsDeployReject();">발행반려</button></li>
                </c:if>
                <li><button type="button" class="blue" onclick="jsList();">목록</button></li>
            </ul>
        </div>
        <!-- //버튼 -->

    </form>

</body>
</html>