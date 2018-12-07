Ext.onReady(function(){

    Ext.QuickTips.init();

    /*---------------------------------------
     * 할당 가능 메뉴 트리 패널
     */

    /* Validation */
    if ( typeof(ROOT_TREE_ID) == "undefined" ) { jsWarningBox("ROOT_TREE_ID 값이 정의되지 않았습니다."); return; }
    if ( typeof(PARENT_NODE_ID_VAR) == "undefined" ) { jsWarningBox("PARENT_NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    if ( typeof(NODE_ID_VAR) == "undefined" ) { jsWarningBox("NODE_ID_VAR 값이 정의되지 않았습니다."); return; }
    if ( typeof(TREE_JSON_URL) == "undefined" ) { jsWarningBox("TREE_JSON_URL 값이 정의되지 않았습니다."); return; }

    var treeLoader = new Ext.tree.TreeLoader({
        dataUrl: TREE_JSON_URL
    });
    treeLoader.on("beforeload", function(treeLoader, node) {
        treeLoader.baseParams[PARENT_NODE_ID_VAR] = node.id;
        if (typeof(IS_USE) != "undefined") treeLoader.baseParams.useYn = "Y";
        if (typeof(ADDED_VAR) != "undefined") treeLoader.baseParams[ADDED_VAR] = ADDED_VALUE;
    }, this);

    var rootNode = new Ext.tree.AsyncTreeNode({
        text      : ROOT_TREE_TEXT,
        id        : ROOT_TREE_ID,
        draggable : false,
        expanded  : true
    });

    var treePanel = new Ext.tree.TreePanel({
        title      : '전체 메뉴 목록',
        iconCls    : 'icon_tab_menu',
        ddGroup    : 'myMenuDDGroup',
        bodyStyle  : 'padding:8px 8px 0 0',
        enableDrag : true,
        useArrows  : true,
        height     : 430,
        autoScroll : true,
        animate    : true,
        rootVisible: false,
        tools      : [{
            id      : 'down',
            qtip    : '메뉴 펼치기',
            handler : function(event, toolEl, panel) {
                panel.expandAll();
            }
        },{
            id      : 'up',
            qtip    : '메뉴 닫기',
            handler : function(event, toolEl, panel) {
                panel.collapseAll();
            }
        }, {
            id      : 'refresh',
            qtip    : '메뉴 새로고침',
            handler : function(event, toolEl, panel) {
                panel.getEl().mask("로딩중...");
                panel.root.reload(function() {
                    panel.getEl().unmask();
                });
            }
        }],
        loader     : treeLoader
    });

    treePanel.on("click", function(node, e) {
        e.stopEvent();
    });

    treePanel.setRootNode(rootNode);
    //treePanel.render();
    treePanel.expand(false, false);

    /*---------------------------------------
     * 내 메뉴 패널
     */

    var myMenuRecord = Ext.data.Record.create([{
        menuCd : 'text',
        menuNm : 'text'
    }]);

    var store = new Ext.data.JsonStore({
        url   : 'INC_myAssignMenuList.do',
        root  : '',
        fields : ['menuCd', 'menuNm'],
        record : myMenuRecord
    });
    store.load();

    var myMenuPanel = new Ext.ListView({
    	id         : "myMenuPanel",
        store      : store,
        multiSelect: true,
        emptyText  : '내 메뉴로 등록된 정보가 없습니다.',
        loadMask   : true,
        /* autoHeight : true, */
        columnSort : false,
        reserveScrollOffset: true,
        columns    : [
            { header : '메뉴명', dataIndex: 'menuNm' },
            { header : '메뉴코드', dataIndex: 'menuCd' }
        ]
    });
    myMenuPanel.on("dblclick", function(panel, index, node, e) {
        var record = panel.store.getAt(index);
        panel.store.remove(record);
    }, this);

    var accordionPanel = new Ext.Panel({
        renderTo : 'myMenuDiv',
        layout   : 'column',
        margins  : '0 0 0 0',
        border   : false,
        items: [{
            columnWidth:.30,
            baseCls:'x-plain',
            bodyStyle:'padding:0 0 0 0',
            items:[treePanel]
        }, {
            columnWidth:.70,
            baseCls:'x-plain',
            bodyStyle:'padding:0 0 0 10px',
            items:[{
                title   : '내 메뉴 목록',
                iconCls : 'icon_my_menu',
                height  : 430,
                layout  : 'fit',
                items   : [myMenuPanel],
                tools      : [{
                    id      : 'refresh',
                    qtip    : '내 메뉴 새로고침',
                    handler : function(event, toolEl, panel) {
                        //myMenuPanel.getEl().mask("로딩중...");
                        myMenuPanel.store.reload();
                        //myMenuPanel.getEl().unmask();
                    }
                }]
            }]
        }]
    });

    var _IS_FOLDER_ITEM = function (dataNode) {
		if(dataNode == false) {
			return false;
		}
		return true;
	};
    var myMenuPanelTargetEl = myMenuPanel.getEl();
    var myMenuPanelDropTarget = new Ext.dd.DropTarget(myMenuPanelTargetEl, {
        ddGroup    : 'myMenuDDGroup',
        notifyOver :function(ddSource, e, data) {

            var node = ddSource.dragData.node;
            if (_IS_FOLDER_ITEM(node.leaf) == true) {
	            var rowCount = myMenuPanel.store.getCount();
	            for (var i=0 ; i < rowCount ; i++) {
	                var record = myMenuPanel.store.getAt(i);
	                if (record.data['menuCd'] == node.id){
	                    return this.dropNotAllowed;
	                }
	            }
	            return this.dropAllowed;
            }
        },
        notifyDrop : function(ddSource, e, data){
            var node = ddSource.dragData.node;
            if (_IS_FOLDER_ITEM(node.leaf) == true) {
	            var rowCount = myMenuPanel.store.getCount();
	            for (var i=0 ; i < rowCount ; i++) {
	                var record = myMenuPanel.store.getAt(i);
	                if (record.data['menuCd'] == node.id){
	                    return false;
	                }
	            }

	            var newRecord = new myMenuRecord({
	                menuNm : node.text,
	                menuCd : node.id
	            });

	            myMenuPanel.store.add(newRecord);

	            return true;
            }
        }
    });
});
