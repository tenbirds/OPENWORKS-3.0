<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>내 메뉴 관리</title>
    <op:jsTag type="spi" items="form,validate,extjs" />
    <op:jsTag type="openworks" items="core" />

    <script type="text/javascript" src="<c:url value="/resources/intra/mymenu/base.mymenu.js" />"></script>
    <script type="text/javascript">

        var ENABLE_DND         = true;
        var ROOT_TREE_ID       = '<%=zes.openworks.common.GlobalConfig.HIGH_MENU_CD%>';
        var ROOT_TREE_TEXT     = "메뉴 목록";

        var IS_APPEND_LEAF     = true;
        var PARENT_NODE_ID_VAR = "highMenuCd";
        var NODE_ID_VAR        = "menuCd";

        var TREE_JSON_URL      = "INC_myMenuListAll.do";
    </script>
    <script>
        var updateMyMenus = function () {
            var menuCds ='';
            var myMenuPanel = Ext.getCmp("myMenuPanel");
            var rowCount = myMenuPanel.store.getCount();
            for (var i=0 ; i < rowCount ; i++) {
                var record = myMenuPanel.store.getAt(i);
                menuCds += ',' + record.data['menuCd'];
            }

            $.ajax({
                url		: "INC_updateAction.do",
                type    : "POST",
                data    : {menuCds : menuCds.substr(1)},
                async    : false,
                success  : function (response) {
                    try {
                        if(eval(response)) {
                            jsSuccessBox(Message.msg.updateOk);
                        } else {
                            jsErrorBox(Message.msg.processFail);
                        }
                    } catch (e) {
                        jsSysErrorBox(response, e);
                        return;
                    }
                  }
              });
        };
    </script>
    <style type="text/css">
        em { color: #000; }
    </style>
</head>

<body>

<div id="myMenuDiv" style="width:100%;"></div>
<div class="tx_r mar_t5 mar_b5">
    <a href="#" onclick="updateMyMenus();"><button type="button" class="blue">저장</button></a>
</div>

</body>
</html>
