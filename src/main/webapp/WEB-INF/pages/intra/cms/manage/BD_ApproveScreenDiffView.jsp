<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>화면비교</title>

    <op:jsTag type="spi" items="form, validate, ui" />
    <op:jsTag type="openworks" items="form" />

    <script type="text/javascript">
    //<![CDATA[
        var width = $(window).width() - 20;
        var height= $(window).height()- 50;
        var childArr = new Array();

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

        /** 
         * 비교 대상 버전 창의 화면 위치를 동일하게 위치 시키기 위한 이벤트 통합관리.
         * 이벤트를 공유하려는 하위 iframe 객체 윈도우에서 현재 부모창에 스스로 등록한다.
         * 부모는 자식 iframe 객체 윈도우가 몇개인지 스스로 찾지 않는다.
         */
        var jsAddChildEvent = function($child) {
            childArr[childArr.length] = $child;

            $child.scroll(function() {
                for(var i = (childArr.length - 1) ; i >= 0 ; i--) {
                    if($(this) != childArr[i]) {
                        childArr[i].scrollTop($(this).scrollTop());
                        childArr[i].scrollLeft($(this).scrollLeft());
                    }
                }
            });
        };

        /** 하위 iframe 객체의 갯수에 따라서 화면을 분할한다. */
        var jsWindowDivision = function() {
            width = $(window).width() - 20;
            height= $(window).height()- 50;
        };

        /** 
         * 수평 비교
         * 비교 윈도우를 수평으로 배치한다.
         */
        var jsHorizontalDiff = function() {
            $("#leftContentWindow").css("width","49%").css("height","600px");
            $("#rightContentWindow").css("width","49%").css("height","600px");
            $("#leftContentWindow").css("float","left");
        };

        /** 
         * 수직 비교
         * 비교 윈도우를 수직으로 배치한다.
         */
        var jsVerticalDiff = function() {
            $("#leftContentWindow").css("width","100%").css("height","300px");
            $("#rightContentWindow").css("width","100%").css("height","300px");
            $("#leftContentWindow").css("clear","both");
        };
    //]]>
    </script>
</head>

<body>
    <div id="tabDiv">
        <ul class="tab">
            <li><a onclick="jsMoveUrl('<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do"/>');return false;" href="<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}"><span>소스비교</span></a></li>
            <li><a class="on" onclick="jsMoveUrl('<c:url value="/intra/cms/manage/BD_ApproveScreenDiffView.do"/>');return false;" href="<c:url value="/intra/cms/manage/BD_ApproveScreenDiffView.do"/>?q_domainCd=${param.q_domainCd}&q_menuCode=${param.q_menuCode}&q_leftContentSeqNo=${param.q_leftContentSeqNo}"><span>화면비교</span></a></li>
        </ul>
    </div>

    <!-- 버튼 -->
    <div class="btn_r">
        <ul>
            <li><button type="button" class="s_blue" onclick="jsVerticalDiff();" >수직비교</button></li>
            <li><button type="button" class="s_blue" onclick="jsHorizontalDiff();" >수평비교</button></li>
        </ul>
    </div>
    <!-- //버튼 -->

    <iframe id="leftContentWindow" name="leftContentWindow" style="border:1px solid #333333; width:100%;height:300px;" 
        src="<c:url value="/intra/cms/layout/PD_LayoutPreView.do" />?q_domainCd=${dataVo.leftContent.domainCd}&q_layoutCode=${dataVo.leftContent.layoutCode}&q_menuCode=${dataVo.leftContent.menuCode}&q_contentSeqNo=${dataVo.leftContent.contentSeqNo}"></iframe>

    <iframe id="rightContentWindow" name="rightContentWindow" style="border:1px solid #333333; width:100%;height:300px;"
        src="<c:url value="/intra/cms/layout/PD_LayoutPreView.do" />?q_domainCd=${dataVo.rightContent.domainCd}&q_layoutCode=${dataVo.rightContent.layoutCode}&q_menuCode=${dataVo.rightContent.menuCode}&q_contentSeqNo=${dataVo.rightContent.contentSeqNo}"></iframe>

    <form name="dataForm" id="dataForm" action="<c:url value="/intra/cms/manage/BD_ApproveSourceDiffView.do"/>" method="post">

        <%-- 페이징 관련 파라미터 생성. view 설정 모든 검색 파라미터가 hidden으로 생성됨 --%>
        <op:pagerParam view="view" />

        <input type="hidden" name="domainCd" id="domainCd" value="${dataVo.leftContent.domainCd}" />
        <input type="hidden" name="menuCode" id="menuCode" value="${dataVo.leftContent.menuCode}" />
        <input type="hidden" name="contentSeqNo" id="contentSeqNo" value="${dataVo.leftContent.contentSeqNo}" />
        <input type="hidden" name="leftContentSeqNo" id="leftContentSeqNo" value="${dataVo.leftContent.contentSeqNo}" />

        <input type="hidden" name="approvalSt" id="approvalSt" value="" />

        <br class="blank"/>

        <h4>승인/반려 사유</h4>
        <table class="boardWrite" summary="승인/반려 사유" >
            <caption class="title">승인/반려 사유</caption>
            <colgroup>
                <col width="20%"/>
                <col width="80%"/>
            </colgroup>
            <tbody>
            <tr>
                <th>발행 사유</th>
                <td>${dataVo.leftContent.publishReason}</td>
            </tr>
            <tr>
                <th>승인/반려 사유</th>
                <td>
                    <c:choose>
                        <c:when test="${dataVo.leftContent.approvalSt eq '1020'}">
                            <textarea id="approvalReason" name="approvalReason" rows="4" style="width: 100%;">${dataVo.leftContent.approvalReason}</textarea>
                            <span class="tx_blue_s">(최대 한글 <strong>400</strong>자)</span>
                        </c:when>
                        <c:otherwise>
                            ${dataVo.leftContent.approvalReason}
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <c:if test="${dataVo.leftContent.approvalSt eq '1020'}">
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