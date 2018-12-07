<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

    <script type="text/javascript">
    //<CDATA[[

        var tabs;
        $().ready(function() {

            var option = {
                    // 내용을 표시할 컨테이너는 지정 할 수도 있으며 미지정 시 임의로 생성됨.
                    tabContainer : "tabContainer",
                    // 공통 파라미터를 지정할 수 있음.
                    baseParam: {
                        q_domainCd: "${dataVo.domainCd}",
                        q_menuCode: "${dataVo.menuCode}",
                        domainCd: "${dataVo.domainCd}",
                        menuCode: "${dataVo.menuCode}"
                    }
            };

            tabs = $("#tabDiv").jsTabUi(option);
        });

        var jsReloadTab = function() {
            tabs.refresh();
        };
        
        var jsMoveTab = function(index) {
            tabs.moveTab(index);
        };

    //]]>
    </script>

    <div id="tabDiv">
        <ul>
            <li>
                <a href="<c:url value="/intra/cms/INC_MenuView.do"/>"><span>메뉴 정보</span></a></li>
                <c:if test="${dataVo.menuType eq 'content'}">
                    <li><a href="<c:url value="/intra/cms/content/INC_ContentList.do"/>"><span>컨텐츠관리</span></a></li>
                </c:if>
                <c:if test="${dataVo.statisticsUseYn eq 'T'}">
                    <li><a href="<c:url value="/intra/cms/statistics/INC_simpleMenuLog.do"/>"><span>접속 통계</span></a></li>
                </c:if>
        </ul>
    </div>
