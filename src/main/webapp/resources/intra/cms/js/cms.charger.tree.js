var treePanel;

Ext.onReady(function(){
    
    Ext.QuickTips.init();
    
    /* Validation */
    if ( typeof(ROOT_TREE_ID) == "undefined" ) { jsWarningBox("ROOT_TREE_ID 값이 정의되지 않았습니다."); return; }
    if ( typeof(PARENT_NODE_ID_VAR) == "undefined" ) { jsWarningBox("PARENT_NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    if ( typeof(NODE_ID_VAR) == "undefined" ) { jsWarningBox("NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    if ( typeof(TREE_JSON_URL) == "undefined" ) { jsWarningBox("TREE_JSON_URL 값이 정의되지 않았습니다."); return; }
    if ( typeof(VIEW_URL) == "undefined" ) { jsWarningBox("VIEW_URL 값이 정의되지 않았습니다."); return; }
    if ( typeof(INSERT_URL) != "undefined" ) {
        if ( typeof(NODE_NM_VAR) == "undefined" ) { jsWarningBox("NODE_NM_VAR 값이 정의되지 않았습니다."); return; }
    }
    if ( typeof(ENABLE_DND) != "undefined" ) {
        if ( typeof(NODE_ORDER_VAR) == "undefined" ) { jsWarningBox("NODE_ORDER_VAR 값이 정의되지 않았습니다."); return; }
    }
    if ( typeof(ENABLE_DND) == "undefined" ) { ENABLE_DND = false; }
    if ( typeof(ROOT_TREE_TEXT) == "undefined" ) { ROOT_TREE_TEXT = "트리 목록"; }
    if ( typeof(ROOT_VISIBLE) == "undefined" ) { ROOT_VISIBLE = false; }
    if ( typeof(TREE_EL_ID) == "undefined" ) { TREE_EL_ID = "treeDiv"; }
    if ( typeof(IS_USE) == "undefined" ) { IS_USE = false; }
    if ( typeof(IS_APPEND_LEAF) == "undefined" ) { IS_APPEND_LEAF = false; }
    if ( typeof(PANEL_SIZE_HEIGHT) == "undefined" ) { PANEL_SIZE_HEIGHT = 400; }
    if ( typeof(PANEL_SIZE_WIDTH) == "undefined" ) { PANEL_SIZE_WIDTH = 200; }
    
    var treeLoader = new Ext.tree.TreeLoader({
        dataUrl: TREE_JSON_URL
    });

    treeLoader.on("beforeload", function(treeLoader, node) {
        treeLoader.baseParams[PARENT_NODE_ID_VAR] = node.id;
        if (typeof(IS_USE) != "undefined") treeLoader.baseParams.useYn = "Y";
        if (typeof(DOMAIN_VAR) != "undefined") treeLoader.baseParams[DOMAIN_VAR] = DOMAIN_NM;
    }, this);

    var rootNode = new Ext.tree.AsyncTreeNode({
        text      : ROOT_TREE_TEXT,
        id        : ROOT_TREE_ID,
        draggable : false,
        expanded  : true
    });
    
    treePanel = new Ext.tree.TreePanel({
        title      : ROOT_TREE_TEXT,
        //el         : TREE_EL_ID,
        enableDD   : ENABLE_DND,
        useArrows  : true,
        height     : PANEL_SIZE_HEIGHT,
        width      : PANEL_SIZE_WIDTH,
        autoScroll : true,
        animate    : true, 
        border     : true,
        rootVisible: ROOT_VISIBLE,
        loader     : treeLoader,
        containerScroll : false,
        tools      : [{
            id      : 'refresh',
            qtip    : '새로고침',
            handler : function(event, toolEl, panel) {
                panel.getEl().mask("로딩중...");
                panel.root.reload(function() {
                    panel.getEl().unmask();
                });
            }
        }]
    });

    treePanel.setRootNode(rootNode);
    treePanel.render(TREE_EL_ID);
    treePanel.expand(false, false);
    
    treePanel.on("click", function(node, e) {
        e.stopEvent();
        if ( typeof(window.jsMenuView) == "function" )
            eval( jsMenuView(node) );
        else
            jsWarningBox( "jsMenuView(node) 함수를 정의하세요.");
    });

    if (IS_APPEND_LEAF) {
        treePanel.on("nodedragover", function(e) {
            e.target.leaf = false;
        });
    }

});

