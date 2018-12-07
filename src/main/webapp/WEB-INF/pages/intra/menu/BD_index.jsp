<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="zes.openworks.common.GlobalConfig"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>메뉴 관리</title>

    <op:jsTag type="spi" items="form,validate,extjs" />
    <op:jsTag type="openworks" items="tree" />

    <script type="text/javascript">

        var ROOT_VISIBLE   = true;
        var ENABLE_DND     = true;
        var ROOT_TREE_ID   = '<%= GlobalConfig.HIGH_MENU_CD %>';
        var ROOT_TREE_TEXT = "메뉴 목록";

        var IS_APPEND_LEAF     = true;
        var PARENT_NODE_ID_VAR = "highMenuCd";
        var NODE_ID_VAR        = "menuCd";
        var NODE_NM_VAR        = "menuNm";
        var NODE_ORDER_VAR     = "orderNo";

        var TREE_JSON_URL = "INC_menuList.do";
        var VIEW_URL      = "INC_menuView.do";
        var INSERT_URL    = "ND_insertAction.do";
        var UPDATE_URL    = "ND_updateAction.do";
        var DELETE_URL    = "ND_deleteAction.do";

        var jsBeforeInsert = function(formName) {
            return $(formName).valid();
        };
        var jsBeforeUpdate = function(formName) {
            return $(formName).valid();
        };

        var jsCreateUpdateParams = function() {
            return {
                menuCd : $("#nodeId").val(),
                menuNm : $("#nodeText").val(),
                menuUrl: $("#menuUrl").val(),
                controllerNm : $("#controllerNm").val(),
                useYn  : $("input[name=useYn]:checked").val()
            };
        };

        var jsAfterUpdate = function() {
        };
        var jsAfterDelete = function() {
        };
    </script>
</head>

<body>

    <div class="buser">
        <div id="treeDiv" class="b_list"></div>

        <div id="treeDetailDiv" class="b_write">
            <h4 class="tx_13">메뉴 정보</h4>
            <p>메뉴명을 선택하세요.</p>
        </div>

    </div>

</body>
</html>
