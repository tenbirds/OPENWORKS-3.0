
/** 상세보기 */
var jsMenuView = function(node) {
    var params = {};
    if (typeof(DOMAIN_VAR) != "undefined") {
        if (DOMAIN_NM == "") return;
        params[DOMAIN_VAR] = DOMAIN_NM;
    }

    params[NODE_ID_VAR] = node.id;
    params[PARENT_NODE_ID_VAR] = node.parentNode ? node.parentNode.id : ROOT_TREE_ID;

    $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
        if ( node.id != ROOT_TREE_ID )
            $("#nodePath").html( jsNodePath(node) );
    });
};

/** 트리메뉴에서 메뉴 이동 */
var jsMenuMove = function(node, oldParent, newParent, index) {
    var params = {};
    if (typeof(DOMAIN_VAR) != "undefined") {
        if (DOMAIN_NM == "") return;
        params[DOMAIN_VAR] = DOMAIN_NM;
    }
    params[NODE_ID_VAR] = node.id;
    params[NODE_NM_VAR] = node.text;
    params[PARENT_NODE_ID_VAR] = newParent.id;
    params[NODE_DEPTH_VAR] = newParent.attributes.depth + 1;
    params[NODE_ORDER_VAR] = (index+1);
    if (typeof(TOP_NODE_VAR) != "undefined")
        params[TOP_NODE_VAR] = jsGetTopNode(node);

    $.post(MOVE_URL, params, function(result) {
    }, "json");
};

/** 등록전 체크 로직 */ 
var jsBeforeInsert = function() {
    if ( $("#newMenuCode").val() == "" ) {
        jsWarningBox("메뉴코드를 입력하세요.");
        $("#newMenuCode").focus();
        return false;
    }
    if ( $("#newMenuNm").val() == "" ) {
        jsWarningBox("메뉴 명을 입력하세요.");
        $("#newMenuNm").focus();
        return false;
    }
    return true;
};

/** 신규메뉴 등록 */
var jsMenuInsert = function() {
    
    // 전후 공백 제거
    $("#newMenuCode").val($.trim($("#newMenuCode").val()));
    $("#newMenuNm").val($.trim($("#newMenuNm").val()));

    if ( typeof(INSERT_URL) == "undefined" ) { 
        jsWarningBox("INSERT_URL 값이 정의되지 않았습니다."); 
        return; 
    }

    if ( typeof(window.jsBeforeInsert) == "function" ) {
        var isValid = eval( jsBeforeInsert() );
        if ( !isValid ) return;
    }

    var params = {};
    if (typeof(DOMAIN_VAR) != "undefined") {
        if (DOMAIN_NM == "") return;
        params[DOMAIN_VAR] = DOMAIN_NM;
    }

    var targetNode;
    if ( $("#isSame").attr("checked") ) {
        targetNode = treePanel.getNodeById( $("#menuCode").val() ).parentNode;
    } else if ( $("#isChild").attr("checked") ) {
        targetNode = treePanel.getNodeById( $("#menuCode").val() );
    } else {
        jsWarningBox("추가 옵션을 선택해야 합니다."); 
        return; 
    }

    params[PARENT_NODE_ID_VAR] = targetNode.id;
    params[NODE_ID_VAR] = $("#newMenuCode").val();
    params[NODE_NM_VAR] = $("#newMenuNm").val();
    params[NODE_ORDER_VAR] = "0";
    if (typeof(TOP_NODE_VAR) != "undefined")
        params[TOP_NODE_VAR] = jsGetTopNode(targetNode);

    $.post(INSERT_URL, params, function(response) {

        if (response.result) {
            jsSuccessBox(response.message);
//            document.location.reload();
        } else { 
            jsErrorBox(response.message);
        }

        var newNode = new Ext.tree.TreeNode({
            text      : $("#newMenuNm").val(),
            id        : $("#newMenuCode").val(),
            draggable : ENABLE_DND ? true : false
        });

        targetNode.appendChild( newNode );
        if ( $("#isChild").attr("checked") ) {
            targetNode.leaf = false;
        }
        targetNode.expand();

        $("#newMenuCode").val("");
        $("#newMenuNm").val("");
        $("#isSame").removeAttr("checked");
        $("#isChild").removeAttr("checked");

    }, "json");
};

/** 수정전 로직 */
var jsBeforeUpdate = function() {
    if ( $("#menuNm").val() == "" ) {
        jsWarningBox("메뉴 명을 입력하세요.");
        $("#menuNm").focus();
        return false;
    }

    return true;
};

/** 수정후 로직 */
var jsAfterUpdate = function() {
    jsMenuView( treePanel.getNodeById($("#menuCode").val()) );
};

/** 수정 */
var jsMenuUpdate = function() {

    if ( typeof(UPDATE_URL) == "undefined" ) { 
        jsWarningBox("UPDATE_URL 값이 정의되지 않았습니다."); 
        return; 
    }

    if ( typeof(window.jsBeforeUpdate) == "function" ) {
        var isValid = eval( jsBeforeUpdate() );
        if ( !isValid ) return;
    }

    $("#userMenuUrl, #adminMenuUrl").removeAttr("disabled");

    var authType = $("input[name='authType']:checked").val();
    if(authType == "MGR") {
        if($("#authMgrId option").size() < 1) {
            jsWarningBox("권한 유형이 담당자인경우 담당자를 등록해야 합니다.");
            return;
        }
        $("#authMgrId option").each(
            function() {
                $(this).attr("selected", "selected");
            }
        );
        $("#authDeptCd").val("");
        $("#authDeptNm").val("");
    } else if(authType == "INC_DEPT" || authType == "EQ_DEPT") {
        if(!$("#authDeptCd").val()) {
            jsWarningBox("권한 유형이 부서인경우 부서를 등록해야 합니다.");
            return;
        } else {
            $("#authMgrId option").each(
                function() {
                    $(this).removeAttr("selected");
                }
            );
        }
    } else {
        $("#authDeptCd").val("");
        $("#authDeptNm").val("");
        $("#authMgrId option").each(
            function() {
                $(this).removeAttr("selected");
            }
        );
    }

    $("#dataForm").ajaxSubmit({
        url      : UPDATE_URL,
        type     : "POST",
        dataType : "text",
        success  : function(response) {
            if (response) {
                jsSuccessBox(Message.msg.updateOk);
                if ( typeof(window.jsAfterUpdate) == "function" ) {
                    eval( jsAfterUpdate() );
                }
            } else { 
                jsErrorBox(Message.msg.processFail);
            }
        }

    });
};

/** 메뉴 삭제 */
var jsMenuDelete = function() {

    if ( typeof(DELETE_URL) == "undefined" ) { 
        jsWarningBox("DELETE_URL 값이 정의되지 않았습니다."); 
        return; 
    }

    if ( $("#menuCode").val() == "" ) {
        jsWarningBox("먼저 삭제할 정보를 선택하세요."); 
        return;
    }

    var targetNode = treePanel.getNodeById( $("#menuCode").val() );
    var parentNode = targetNode.parentNode;
    
    var confirmMessage = "정말 삭제 하시겠습니까?";

    if ( targetNode.childNodes.length > 0 || targetNode.leaf == false)
        confirmMessage = "하위 정보가 존재합니다.\n삭제 시 하위 정보가 모두 삭제됩니다.\n\n정말 삭제 하시겠습니까?";

    var params = {};
    if (typeof(DOMAIN_VAR) != "undefined") {
        if (DOMAIN_NM == "") return;
        params[DOMAIN_VAR] = DOMAIN_NM;
    }
    params[PARENT_NODE_ID_VAR] = targetNode.parentNode.id;
    params[NODE_ID_VAR] = targetNode.id;

    if ( confirm( confirmMessage ) ) {
        $.post(DELETE_URL, params, function(response) {
            if (response.result) {
                jsSuccessBox(response.message);

                targetNode.remove();

                treePanel.getEl().mask("로딩중...");
                treePanel.root.reload(function() {
                    treePanel.getEl().unmask();
                });    
                if(parentNode.childNodes.length <= 0) {
                    parentNode.leaf = true;
                }

                // 상세조회 화면 초기화
                $('#treeDetailDiv').html("<h4 class='tx_13'>메뉴 관리</h4><p>메뉴명를 선택하세요.</p>");
            } else { 
                jsErrorBox(response.message);
            }
        }, "json");
    }
};

/** 경로명 생성 */
var jsNodePath = function(node) {
    var nodeText = node.text;
    var parentNode = node.parentNode;
    if ( parentNode.id != ROOT_TREE_ID ) {
        nodeText = jsNodePath(parentNode) + " > " + nodeText;
    }
    $("#menuRoute").val(nodeText);
    return nodeText;
};

/** 최상위코드 */
var jsGetTopNode = function(node) {
    var topNode = node.id;
    var parentNode = node.parentNode;
    if (!parentNode) return "-1";
    if ( parentNode.id != ROOT_TREE_ID ) {
        topNode = jsGetTopNode(parentNode);
    }
    return topNode;
};

