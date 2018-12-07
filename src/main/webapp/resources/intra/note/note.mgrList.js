
// 변수 선언부
var _DEPT_USER_TREE_VARS = {
    /* var def */
    TITLE : "사용자 선택",
    TREE_EL_ID : "_DEPT_USER_TREE",
    PARENT_NODE_ID_VAR : "highDeptCd",
    EL_ID : "mgrNms",
    TREE_JSON_URL : "INC_deptUserTreeList.do",
    VIEW_URL : "INC_deptView.do",
    ROOT_TREE_TEXT : "전체",
    IS_USE : false,
    MULTI_SELECTE : false,
    ROOT_TREE_ID : "0"
};

if (typeof (_DEPT_USER_TREE_TITLE) != "undefined")
    _DEPT_USER_TREE_VARS.TITLE = _DEPT_USER_TREE_TITLE;
if (typeof (_DEPT_USER_DRAG_TARGET_EL_ID) != "undefined")
    _DEPT_USER_TREE_VARS.EL_ID = _DEPT_USER_DRAG_TARGET_EL_ID;
if (typeof (_DEPT_USER_ITEM_MULTI_SELECT) != "undefined")
    _DEPT_USER_TREE_VARS.MULTI_SELECTE = _DEPT_USER_ITEM_MULTI_SELECT;

Ext.onReady(function() {
    var _DEPT_USER_ROOT_NODE = new Ext.tree.AsyncTreeNode({
        text : _DEPT_USER_TREE_VARS.ROOT_TREE_TEXT,
        id : _DEPT_USER_TREE_VARS.ROOT_TREE_ID,
        expanded : true
    // 시작시에 펼침
    });
    var _DEPT_USER_TREE_LOADER = new Ext.tree.TreeLoader({
        dataUrl : _DEPT_USER_TREE_VARS.TREE_JSON_URL
    });

    _DEPT_USER_TREE_LOADER
            .on(
                    "beforeload",
                    function(treeLoader, node) {
                        treeLoader.baseParams[_DEPT_USER_TREE_VARS.PARENT_NODE_ID_VAR] = node.id;
                        if (typeof (_DEPT_USER_TREE_VARS.IS_USE) != "undefined")
                            treeLoader.baseParams.useYn = "Y";
                    }, this);

    var _DEPT_USER_SEL_MODEL = null;
    if (_DEPT_USER_TREE_VARS.MULTI_SELECTE == true) {
        _DEPT_USER_SEL_MODEL = new Ext.tree.MultiSelectionModel();
    } else {
        _DEPT_USER_SEL_MODEL = new Ext.tree.DefaultSelectionModel();
    }

    var _DEPT_USER_TREE_PANLE = new Ext.tree.TreePanel({
        id : "_DEPT_USER_TREE_PANLE",
        useArrows : true,
        autoScroll : true,
        animate : true,
        title : _DEPT_USER_TREE_VARS.TITLE,
        el : _DEPT_USER_TREE_VARS.TREE_EL_ID,
        border : true,
        width : 250,
        height : 300,
        enableDrag : true,
        ddGroup : 't2div',
        selModel : _DEPT_USER_SEL_MODEL,
        loader : _DEPT_USER_TREE_LOADER
    });

    _DEPT_USER_TREE_PANLE.setRootNode(_DEPT_USER_ROOT_NODE);
    _DEPT_USER_TREE_PANLE.render();
    _DEPT_USER_TREE_PANLE.expand(false, false);

    var _DEPT_USER_DRAG_TARGET_EL = Ext.get(_DEPT_USER_TREE_VARS.EL_ID);
    var _IS_FOLDER_ITEM = function(dataNode) {
        if (dataNode == false) {
            return false;
        }
        return true;
    };
    var _DEPT_USER_DRAG_TARGET = new Ext.dd.DropTarget(_DEPT_USER_DRAG_TARGET_EL, {
        ddGroup : 't2div',
        notifyOver : function(ddSource, e, data) {
            return _IS_FOLDER_ITEM(data.node.leaf);
        },
        notifyDrop : function(ddSource, e, data) {
            if (_IS_FOLDER_ITEM(data.node.leaf) == true) {
                var code = data.node.id;
                var dept = data.node.parentNode.text;
                var text = data.node.text;
                _DEPT_USER_ADD_OPTION(code, dept + "/" + text);
                return true;
            }
        }
    });
});

var _DEPT_USER_ADD_OPTION = function(code, text) {
    $("#mgrNms").addOption(code, text);
    $("#mgrNm").val("");
};

var _DEPT_USER_ADDED_NODE = function() {
    if (_DEPT_USER_TREE_VARS.MULTI_SELECTE == true) {
        var treePanel = Ext.getCmp("_DEPT_USER_TREE_PANLE");
        var treeSelModel = treePanel.selModel;
        var treeSelNode = treeSelModel.selNodes;
        var _tmpBoolean = false;
        if (treeSelNode.length == 0) {
            jsWarningBox("추가하실 구성원을 선택하세요.");
            return;
        }
        for ( var i = 0; i < treeSelNode.length; i++) {
            if (treeSelNode[i].leaf == false && _tmpBoolean == false) {
                _tmpBoolean = true;
            } else {
                var code = treeSelNode[i].id;
                var dept = treeSelNode[i].parentNode.text;
                var text = treeSelNode[i].text;
                _DEPT_USER_ADD_OPTION(code, dept + "/" + text);
            }
        }
        if (_tmpBoolean == true) {
            jsMessage("선택하신 부서는 제외되었습니다.");
        }
    } else {

    }
};
