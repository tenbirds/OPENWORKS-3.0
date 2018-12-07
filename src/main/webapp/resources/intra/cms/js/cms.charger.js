
/** 상세보기 */
var jsMenuView = function(node) {

    if(!node.attributes.href) {
        $("#treeDetailDiv").html("<h4 class='tx_13'>메뉴 관리</h4><p>메뉴명를 선택하세요.</p>");
        return;
    }

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

    $("#dataForm").ajaxSubmit({
        url      : UPDATE_URL,
        type     : "POST",
        dataType : "json",
        success  : function(response) {

            try {
                if(eval(response)) {
                    jsSuccessBox(Message.msg.insertOk);
                    if ( typeof(window.jsAfterUpdate) == "function" ) {
                        eval( jsAfterUpdate() );
                    }
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
