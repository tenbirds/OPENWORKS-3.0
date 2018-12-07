<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>사용자 메뉴관리</title>

    <op:jsTag type="spi" items="validate, form, multifile, selectbox, ui, extjs" />
    <op:jsTag type="openworks" items="ui, form, ckeditor" />

    <script type="text/javascript" src="<%= request.getContextPath() %>/component/javascript/MD_massageConfig.do"></script>

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.tree.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.js" />"></script>

    <script type="text/javascript">
        var titleText = "메뉴를 선택하세요.";
        <c:choose>
            <c:when test="${not empty param.domainCd}">
                titleText = "${dataVo.domainDesc}";
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>

        var TREE_EL_ID = "treeDiv";
        var ENABLE_DND = true;
        var ROOT_TREE_ID = 'web';
        var ROOT_TREE_TEXT = titleText;
        var ROOT_TREE_DEPTH = 0;
        var ROOT_VISIBLE = false;

        var IS_APPEND_LEAF = true;
        var PARENT_NODE_ID_VAR = "parentMenuCode";
        var NODE_DEPTH_VAR = "menuDepth";
        var NODE_ID_VAR = "menuCode";
        var NODE_NM_VAR = "menuNm";
        var NODE_ORDER_VAR = "sortOrder";
        var TOP_NODE_VAR = "topMenuCode";
        var DOMAIN_VAR = "domainCd";
        var DOMAIN_NM = "";

        var TREE_JSON_URL = "INC_MenuList.do";
        var VIEW_URL = "INC_TabView.do";
        var INSERT_URL = "ND_InsertAction.do";
        var UPDATE_URL = "ND_UpdateAction.do";
        var DELETE_URL = "ND_DeleteAction.do";
        var MOVE_URL = "ND_MoveAction.do";

        $(document).ready(function(){

            $("#domainBtn").colorbox({
                title : "사이트 목록",
                href  : "<c:url value="/component/domain/PD_DomainList.do" />",
                width : "630", height:"380", 
                iframe: true
            });

            <c:choose>
                <c:when test="${not empty param.domainCd}">
                    jsDomainRefresh("${param.domainCd}");
                </c:when>
                <c:otherwise>
                    <c:if test="${baseVo eq '1'}" >
                        $("#domainList").trigger("change", "${domainCd}");
                    </c:if>
                </c:otherwise>
            </c:choose>

            $("#treeDetailDiv").show();
        });

        var jsDomainRefresh = function(domainCd) {

            DOMAIN_NM = domainCd;

            if(treePanel) {
                treePanel.getEl().mask("로딩중...");
                treePanel.root.reload(function() {
                    treePanel.getEl().unmask();
                    treePanel.root.setText($("#domainList :selected").text());
                });
            }

            $('#treeDetailDiv').html("<h4 class='tx_13'>메뉴 관리</h4><p>메뉴명를 선택하세요.</p>");

            if (!domainCd) {
                $("#treeDetailDiv").show();
                $("#addMenu").hide();
            }
        };

        var jsCreateMenu = function() {
            $.post("ND_CreateMenu.do", {
                domainCd : $.trim($("#domainList :selected").val()),
                domainNm : $.trim($("#domainList :selected").text())
                },
                function(response) {
                    if (response.result) {
                        jsSuccessBox(response.message);
                        $("#treeDetailDiv").show();
                        $("#addMenu").hide();
                        $("#domainList").trigger("change", $("#domainList :selected").val());
                    } else { 
                        jsErrorBox(response.message);
                    }
                }
            );
        };

    </script>

</head>

<body>

    <div class="buser">
        <!-- 사이트 목록 -->
        <div class="b_list">

            <form name="domainForm" method="get">
            <c:choose>
                <c:when test="${not empty param.domainCd}">
                    <input type="hidden" id="domainCd" name="domainCd" value="${param.domainCd}" />
                </c:when>
                <c:otherwise>
                    <select name="domainList" id="domainList" style="width:100%;" onchange="jsDomainRefresh(this.value);" class="select">
                        <option value="">-- 사이트 선택 --</option>
                        <c:forEach items="${dataList}" var="domainVo" varStatus="status">
                            <option value="${domainVo.domainCd}" 
                                <c:if test="${status.index eq 0 and baseVo eq '1'}">selected="selected"</c:if>>
                                ${domainVo.domainNm}</option>
                        </c:forEach>
                    </select>
                </c:otherwise>
            </c:choose>
            </form>

            <div id="treeDiv" class="mar_t5"></div>

        </div>
        <!-- //사이트 목록 -->

        <div id="treeDetailDiv" style="display:none;" class="b_write">
            <h4 class="tx_13">메뉴 관리</h4><p>메뉴명를 선택하세요.</p>
        </div>

        <div id="addMenu" style="display:none;" class="b_write">
            <h4 class="tx_13">최상위 메뉴 생성</h4>

            <table class="boardWrite" summary="메뉴 추가" >
                <caption class="title">메뉴 추가</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="85%" />
                </colgroup>
                <tbody>
                <tr>
                    <th>사이트명</th>
                    <td>
                        <span id="siteName"></span>
                    </td>
                </tr>
                </tbody>
            </table>

            <!-- 버튼 -->
            <div class="btn_r">
                <ul>
                    <li><input type="button" value="메뉴생성" class="w_blue" onclick="jsCreateMenu();" /></li>
                </ul>
            </div>
            <!-- //버튼 -->

        </div>

    </div>

</body>
</html>
