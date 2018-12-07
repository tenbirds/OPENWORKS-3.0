var treePanel1;
var treePanel2;
var treePanel3;
var treePanel4;

Ext.onReady(function(){

    Ext.QuickTips.init();

    /* Validation */
    if ( typeof(ROOT_TREE_ID) == "undefined" ) { alert("ROOT_TREE_ID 값이 정의되지 않았습니다."); return; }
    if ( typeof(PARENT_NODE_ID_VAR) == "undefined" ) { alert("PARENT_NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    if ( typeof(NODE_ID_VAR) == "undefined" ) { alert("NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    //if ( typeof(TREE_JSON_URL) == "undefined" ) { alert("TREE_JSON_URL 값이 정의되지 않았습니다."); return; }
    //if ( typeof(VIEW_URL) == "undefined" ) { alert("VIEW_URL 값이 정의되지 않았습니다."); return; }

    if ( typeof(INSERT_URL) != "undefined" ) {
        if ( typeof(NODE_NM_VAR) == "undefined" ) { alert("NODE_NM_VAR 값이 정의되지 않았습니다."); return; }
    }
    if ( typeof(ENABLE_DND) != "undefined" ) {
        if ( typeof(NODE_ORDER_VAR) == "undefined" ) { alert("NODE_ORDER_VAR 값이 정의되지 않았습니다."); return; }
    }

    if ( typeof(ENABLE_DND) == "undefined" ) { ENABLE_DND = false; }
    if ( typeof(ROOT_TREE_TEXT) == "undefined" ) { ROOT_TREE_TEXT = "트리 목록"; }
    if ( typeof(ROOT_VISIBLE) == "undefined" ) { ROOT_VISIBLE = false; }
    if ( typeof(TREE_EL_ID) == "undefined" ) { TREE_EL_ID = "treeDiv"; }
    if ( typeof(IS_USE) == "undefined" ) { IS_USE = false; }
    if ( typeof(IS_APPEND_LEAF) == "undefined" ) { IS_APPEND_LEAF = false; }
    if ( typeof(PANEL_SIZE_HEIGHT) == "undefined" ) { PANEL_SIZE_HEIGHT = 400; }
    if ( typeof(PANEL_SIZE_WIDTH) == "undefined" ) { PANEL_SIZE_WIDTH = 250; }

    if (typeof(IS_SELECTED_NODE) == "undefined") { IS_SELECTED_NODE = false; }
    if (IS_SELECTED_NODE) {
        if ( typeof(SELECTED_NODE_ID) == "undefined" ) { alert("SELECTED_NODE_ID 값이 정의되지 않았습니다."); return; }
    }

        
    if (TREE_JSON_URL1 != "") {
        var treeLoader1 = new Ext.tree.TreeLoader({
            dataUrl: TREE_JSON_URL1
        });
        
        treeLoader1.on("beforeload", function(treeLoader1, node) {
            treeLoader1.baseParams[PARENT_NODE_ID_VAR] = node.id;
            if (IS_USE) treeLoader1.baseParams.useYn = "Y";
            if (typeof(ADDED_VAR) != "undefined") treeLoader1.baseParams[ADDED_VAR] = ADDED_VALUE;
        }, this);    
        
        
        var rootNode1 = new Ext.tree.AsyncTreeNode({
            text      : ROOT_TREE_TEXT1,
            id        : ROOT_TREE_ID,
            draggable : false,
            expanded  : true
        });
    
        treePanel1 = new Ext.tree.TreePanel({
            title      : ROOT_TREE_TEXT1,
            //el         : TREE_EL_ID,
            enableDD   : ENABLE_DND,
            useArrows  : true,
            height     : PANEL_SIZE_HEIGHT,
            width      : PANEL_SIZE_WIDTH,
            autoScroll : true,
            animate    : false,
            border     : true,
            rootVisible: ROOT_VISIBLE,
            loader     : treeLoader1,
            containerScroll : false,  
            pathSeparator : " > ",
            tools      : [{
                id      : 'refresh',
                qtip    : '다시읽기',
                handler : function(event, toolEl, panel) {
                    panel.getEl().mask("로딩중...");
                    panel.root.reload(function() {
                        panel.getEl().unmask();
                        panel.expandAll();
                    });
                }
            }]
        });
    
        treePanel1.setRootNode(rootNode1);    
        treePanel1.render(TREE_EL_ID);
        treePanel1.expand(false, false);
        treePanel1.expandAll();

        treePanel1.on("click", function(node, e) {
        //treePanel1.getNodeById("6202_44")
        //var techNode = treePanel1.getNodeById("6202_1");
        //alert(techNode.childNodes);
        //alert(techNode.findChild("id", node.id, true));
                       
        //alert(node.checked);
        e.stopEvent();
        });
    }
    
    if (TREE_JSON_URL2 != "") {
        var treeLoader2 = new Ext.tree.TreeLoader({
            dataUrl: TREE_JSON_URL2
        });
        
        treeLoader2.on("beforeload", function(treeLoader2, node) {
            treeLoader2.baseParams[PARENT_NODE_ID_VAR] = node.id;
            if (IS_USE) treeLoader2.baseParams.useYn = "Y";
            if (typeof(ADDED_VAR) != "undefined") treeLoader2.baseParams[ADDED_VAR] = ADDED_VALUE;
        }, this);
        
        var rootNode2 = new Ext.tree.AsyncTreeNode({
            text      : ROOT_TREE_TEXT2,
            id        : ROOT_TREE_ID,
            draggable : false,
            expanded  : true
        });
        
        treePanel2 = new Ext.tree.TreePanel({
            title      : ROOT_TREE_TEXT2,
            //el         : TREE_EL_ID,
            enableDD   : ENABLE_DND,
            useArrows  : true,
            height     : PANEL_SIZE_HEIGHT,
            width      : PANEL_SIZE_WIDTH,
            autoScroll : true,
            animate    : false,
            border     : true,
            rootVisible: ROOT_VISIBLE,
            loader     : treeLoader2,
            containerScroll : false,
            tools      : [{
                id      : 'refresh',
                qtip    : '다시읽기',
                handler : function(event, toolEl, panel) {
                    panel.getEl().mask("로딩중...");
                    panel.root.reload(function() {
                        panel.getEl().unmask();
                        panel.expandAll();
                    });
                }
            }]
        });
    
        treePanel2.setRootNode(rootNode2);    
        treePanel2.render("treeDiv2");
        treePanel2.expand(false, false);
        treePanel2.expandAll();
    
        treePanel2.on("click", function(node, e) {
            e.stopEvent();
        });
    }
    
    if (TREE_JSON_URL3 != "") {
        var treeLoader3 = new Ext.tree.TreeLoader({
            dataUrl: TREE_JSON_URL3
        });
        
        treeLoader3.on("beforeload", function(treeLoader3, node) {
            treeLoader3.baseParams[PARENT_NODE_ID_VAR] = node.id;
            if (IS_USE) treeLoader3.baseParams.useYn = "Y";
            if (typeof(ADDED_VAR) != "undefined") treeLoader3.baseParams[ADDED_VAR] = ADDED_VALUE;
        }, this);
        
        var rootNode3 = new Ext.tree.AsyncTreeNode({
            text      : ROOT_TREE_TEXT3,
            id        : ROOT_TREE_ID,
            draggable : false,
            expanded  : true
        });
        
        treePanel3 = new Ext.tree.TreePanel({
            title      : ROOT_TREE_TEXT3,
            //el         : TREE_EL_ID,
            enableDD   : ENABLE_DND,
            useArrows  : true,
            height     : PANEL_SIZE_HEIGHT,
            width      : PANEL_SIZE_WIDTH,
            autoScroll : true,
            animate    : false,
            border     : true,
            rootVisible: ROOT_VISIBLE,
            loader     : treeLoader3,
            containerScroll : false,
            tools      : [{
                id      : 'refresh',
                qtip    : '다시읽기',
                handler : function(event, toolEl, panel) {
                    panel.getEl().mask("로딩중...");
                    panel.root.reload(function() {
                        panel.getEl().unmask();
                        panel.expandAll();
                    });
                }
            }]
        });
    
        treePanel3.setRootNode(rootNode3);
        treePanel3.render("treeDiv3");
        treePanel3.expand(false, false);
        treePanel3.expandAll();
        
        treePanel3.on("click", function(node, e) {
            e.stopEvent();
        });
    }
        
    if (TREE_JSON_URL4 != "") {
        var treeLoader4 = new Ext.tree.TreeLoader({
            dataUrl: TREE_JSON_URL4
        });
        
        treeLoader4.on("beforeload", function(treeLoader4, node) {
            treeLoader4.baseParams[PARENT_NODE_ID_VAR] = node.id;
            if (IS_USE) treeLoader4.baseParams.useYn = "Y";
            if (typeof(ADDED_VAR) != "undefined") treeLoader4.baseParams[ADDED_VAR] = ADDED_VALUE;
        }, this);
        
        var rootNode4 = new Ext.tree.AsyncTreeNode({
            text      : ROOT_TREE_TEXT4,
            id        : ROOT_TREE_ID,
            draggable : false,
            expanded  : true
        });
        
        treePanel4 = new Ext.tree.TreePanel({
            title      : ROOT_TREE_TEXT4,
            //el         : TREE_EL_ID,
            enableDD   : ENABLE_DND,
            useArrows  : true,
            height     : PANEL_SIZE_HEIGHT,
            width      : PANEL_SIZE_WIDTH,
            autoScroll : true,
            animate    : false,
            border     : true,
            rootVisible: ROOT_VISIBLE,
            loader     : treeLoader4,
            containerScroll : false,
            tools      : [{
                id      : 'refresh',
                qtip    : '다시읽기',
                handler : function(event, toolEl, panel) {
                    panel.getEl().mask("로딩중...");
                    panel.root.reload(function() {
                        panel.getEl().unmask();
                        panel.expandAll();
                    });
                }
            }]
        });
    
        treePanel4.setRootNode(rootNode4);
        treePanel4.render("treeDiv4");
        treePanel4.expand(false, false);
        treePanel4.expandAll();
        
        
        treePanel4.on("click", function(node, e) {
            e.stopEvent();
        });
    }
    


});
