    var treePanel;

    Ext.onReady(function() {
    
        Ext.QuickTips.init();
        /* Validation */
        if ( typeof(ROOT_TREE_ID) == "undefined" ) { alert("ROOT_TREE_ID "+Message.msg.cmMenuNoUrl); return; }
        if ( typeof(PARENT_NODE_ID_VAR) == "undefined" ) { alert("PARENT_NODE_ID_VAR "+Message.msg.cmMenuNoUrl); return; }
        if ( typeof(PARENT_NODE_NAME_VAR) == "undefined" ) { alert("PARENT_NODE_NAME_VAR "+Message.msg.cmMenuNoUrl); return; }
        if ( typeof(PARENT_NODE_TEXT_VAR) == "undefined" ) { alert("PARENT_NODE_TEXT_VAR "+Message.msg.cmMenuNoUrl); return; }
        
        if ( typeof(NODE_ID_VAR) == "undefined" ) { alert("NODE_ID_VAR "+Message.msg.cmMenuNoUrl); return; }
        if ( typeof(TREE_JSON_URL) == "undefined" ) { alert("TREE_JSON_URL "+Message.msg.cmMenuNoUrl); return; }
        if ( typeof(VIEW_URL) == "undefined" ) { alert("VIEW_URL "+Message.msg.cmMenuNoUrl); return; }
    
        if ( typeof(INSERT_URL) != "undefined" ) {
            if ( typeof(NODE_NM_VAR) == "undefined" ) { alert("NODE_NM_VAR "+Message.msg.cmMenuNoUrl); return; }
        }
        if ( typeof(ENABLE_DND) != "undefined" ) {
            if ( typeof(NODE_ORDER_VAR) == "undefined" ) { alert("NODE_ORDER_VAR "+Message.msg.cmMenuNoUrl); return; }
        }
    
        if ( typeof(ENABLE_DND) == "undefined" ) { ENABLE_DND = false; }
        if ( typeof(ROOT_TREE_TEXT) == "undefined" ) { ROOT_TREE_TEXT = Message.msg.CommunityMenu; }  
        if ( typeof(ROOT_VISIBLE) == "undefined" ) { ROOT_VISIBLE = false; }
        if ( typeof(TREE_EL_ID) == "undefined" ) { TREE_EL_ID = "treeDiv"; }
        if ( typeof(IS_USE) == "undefined" ) { IS_USE = false; }
        if ( typeof(IS_APPEND_LEAF) == "undefined" ) { IS_APPEND_LEAF = false; }
        if ( typeof(PANEL_SIZE_HEIGHT) == "undefined" ) { PANEL_SIZE_HEIGHT = 400; }
        if ( typeof(PANEL_SIZE_WIDTH) == "undefined" ) { PANEL_SIZE_WIDTH = 200; }
    
        if (typeof(IS_SELECTED_NODE) == "undefined") { IS_SELECTED_NODE = false; }
        if (IS_SELECTED_NODE) {
            if ( typeof(SELECTED_NODE_ID) == "undefined" ) { alert("SELECTED_NODE_ID "+Message.msg.cmMenuNoUrl); return; }
        }
        
        
        var treeLoader = new Ext.tree.TreeLoader({
            dataUrl: TREE_JSON_URL
        });
        treeLoader.on("beforeload", function(treeLoader, node) {
            treeLoader.baseParams[PARENT_NODE_ID_VAR] = node.id;
            if (IS_USE) treeLoader.baseParams.useYn = "Y";
            
            if (typeof(ADDED_VAR) != "undefined") treeLoader.baseParams[ADDED_VAR] = ADDED_VALUE;
        }, this);
    
        // 담당자관리에서 부서 기본 선택한 경우
        if (IS_SELECTED_NODE) {
            treeLoader.on("load", function() {
                treePanel.getSelectionModel().select(treePanel.getNodeById($("#" + SELECTED_NODE_ID).val()));
            });
        }
    
        var rootNode = new Ext.tree.AsyncTreeNode({
            text      : ROOT_TREE_TEXT,
            id        : ROOT_TREE_ID,
            draggable : false,
            expanded  : true
        });
    
        treePanel = new Ext.tree.TreePanel({
            //title      : ROOT_TREE_TEXT,
            //el         : TREE_EL_ID,
            enableDD   : ENABLE_DND,
            useArrows  : false,
            height     : PANEL_SIZE_HEIGHT,
            width      : PANEL_SIZE_WIDTH,
            autoScroll : true,
            animate    : true,
            border     : true,
            rootVisible: ROOT_VISIBLE,
            loader     : treeLoader,
            containerScroll : false
//            tools      : [{
//                id      : 'refresh',
//                qtip    : '다시읽기',
//                handler : function(event, toolEl, panel) {
//                    panel.getEl().mask("로딩중...");
//                    panel.root.reload(function() {
//                        
//                        panel.getEl().unmask();
//                        //panel.expandAll();
//                    });
//                }
//            }]
        });
        
     
        
        treePanel.setRootNode(rootNode);
        treePanel.render(TREE_EL_ID);
       // treePanel.expand(false, false);
       // treePanel.expandAll();
        //alert(treePanel.text);
//        var contextMenu = new Ext.menu.Menu({ 
//            items: [ 
//                { text: '삭제', handler: deleteHandler }, 
//                { text: '정렬', handler: sortHandler } 
//            ] 
//        }); 
        
//        treePanel.on('contextmenu', treeContextHandler); 
//        
//        treePanel.on('checkchange', function(node, checked) { 
//            node.eachChild(function(currentNode) { 
//                currentNode.ui.toggleCheck(); 
//            }); 
//        }); 
        treePanel.on("click", function(node, e) {
            e.stopEvent();
            /* tree 원본 
            if ( typeof(window.jsView) == "function" )
                eval( jsView(node) );
            else
                alert( "jsView(node) 함수를 정의하세요.");
            */
            
            /* tree 임시 수정 (리뷰 후 원복) */
            if ( typeof(window.jsView3) == "function" ){
                eval( jsView3(node) );
            }else if( typeof(window.jsView) == "function" ){
                eval( jsView(node) );
            }else{
                alert( "jsView(node) "+ Message.msg.cmParam);
            }
        });
    
        if (IS_APPEND_LEAF) {
            treePanel.on("nodedragover", function(e) {
                e.target.leaf = false;
            });
        }
    
        treePanel.on("movenode", function(tree, node, oldParent, newParent, index) {
            if ( typeof(window.jsMove) == "function" ){
                eval( jsMove(node, oldParent, newParent, index) ); 
                
                //alert( eval( jsMove(node, oldParent, newParent, index) ));
            }else{
                alert( "jsMove(node, oldParent, newParent, index)" + Message.msg.cmParam);
            }
        });
        //alert(11);
        Ext.getCmp(treePanel.id).getRootNode().reload();
        if ( typeof(window.jsBeforeMove) == "function" ) {
            treePanel.on("beforenodedrop", jsBeforeMove);
        }
        
        //우 클릭했을때 메뉴가 나타나도록 하는 핸들러
        function treeContextHandler(node) { 
            node.select(); 
            contextMenu.show(node.ui.getAnchor()); 
        } 
        
        //우 클릭시 나오는 삭제와
        function deleteHandler() { 
            treePanel.getSelectionModel().getSelectedNode().remove(); 
        } 
        //정렬처리하는 함수
        function sortHandler() { 
            treePanel.getSelectionModel().getSelectedNode().sort( 
                function (leftNode, rightNode) { 
                    return (leftNode.text.toUpperCase() < rightNode.text.toUpperCase() ? 1 : -1); 
                } 
            ); 
        } 
    });
    
    
    
    var jsView = function(node) {
       
        var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            params[ADDED_VAR] = ADDED_VALUE;
        }
        params[NODE_ID_VAR] = node.id;
        if(node.id == "0"){
         return;   
        }
        //params[PARENT_NODE_ID_VAR] = node.parentNode ? node.parentNode.id : ROOT_TREE_ID;
        //alert( params[PARENT_NODE_ID_VAR]);
        $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
            if ( node.id != ROOT_TREE_ID )
                $("#nodePath").html( jsNodePath(node) );
        });
    };
    
    
    var jsView2 = function(node, nodeParent) {
        var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            params[ADDED_VAR] = ADDED_VALUE;
        }
        params[NODE_ID_VAR] = node;
        params[PARENT_NODE_ID_VAR] = nodeParent;
    
        $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
            if ( node.id != ROOT_TREE_ID )
                $("#nodePath").html( jsNodePath(node) );
        });
    };
    var jsDefaultView = function(node) {
        
        var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            params[ADDED_VAR] = ADDED_VALUE;
        }
        params[NODE_ID_VAR] = node.id ? node.id : ROOT_TREE_ID;
        params[PARENT_NODE_ID_VAR] = node.parentNode ? node.parentNode.id : ROOT_TREE_ID;
    
        $("#treeDetailDiv").load( VIEW_URL, params, function(result) {
    
        });
    };
    
    var jsMove = function(node, oldParent, newParent, index) {
        var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            params[ADDED_VAR] = ADDED_VALUE;
        }
        
        
        params[NODE_ID_VAR] = node.id;
        params[PARENT_NODE_ID_VAR] = newParent.id;
        params[NODE_ORDER_VAR] = (index+1);
        if (typeof(TOP_NODE_VAR) != "undefined")
            params[TOP_NODE_VAR] = jsGetTopNode(node);
    
//       alert(node.id);
//       alert(newParent.id);
//       alert(oldParent.id);
//       alert(index);
//        if(oldParent != newParent){
//            alert("하위메뉴로는 이동 불가 합니다.");
//            //Ext.getCmp(treePanel.id).getRootNode().reload();
//            //treePanel.expandAll();
//            return;
//        }
        $.post( UPDATE_MOVE_URL, params, function(result) {
             if(result == "true"){
                 Ext.getCmp(treePanel.id).getRootNode().reload(); // 트리메뉴 새로고침
                 //treePanel.expandAll(); // 트리메뉴 모두 열기
             }else if(result == ""){
                 alert(Message.msg.cmMenu01);
                 Ext.getCmp(treePanel.id).getRootNode().reload();
                 treePanel.expandAll();
             }
        });
    };
    
    var jsInsertAction = function(formName) {
    
        if ( typeof(INSERT_URL) == "undefined" ) {
            alert("INSERT_URL "+Message.msg.cmMenuNoUrl);
            return;
        }
    
        var insertParams;
        if ( typeof(window.jsCreateUpdateParams) == "function" ) {
            insertParams = eval( jsCreateUpdateParams(treePanel) );
        } else {
            alert( "jsCreateUpdateParams() 함수를 정의하세요." );
            return;
        }
    
        if ( typeof(window.jsBeforeInsert) == "function" ) {
            var isValid = eval( jsBeforeInsert(formName) );
            if ( !isValid ) return;
        }
    
        var targetNode;
        if ( $("#isSame").attr("checked") )
            targetNode = treePanel.getNodeById( $("#nodeId").val() ).parentNode;
        else if ( $("#isChild").attr("checked") )
            targetNode = treePanel.getNodeById( $("#nodeId").val() );
        else
            targetNode = treePanel.getRootNode();
    
        // var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            insertParams[ADDED_VAR] = ADDED_VALUE;
        }
        insertParams[PARENT_NODE_ID_VAR] = targetNode.id;
        insertParams[NODE_NM_VAR] = $("#newNodeText").val();
        if (typeof(TOP_NODE_VAR) != "undefined")
            insertParams[TOP_NODE_VAR] = jsGetTopNode(targetNode);
    
        $.post(INSERT_URL, insertParams, function(response) {
    
            if(response.result) {
    
               // alert(response.message);
                alert(Message.msg.cmGroup03);
                var nodeId = response.value;
                var newNode = new Ext.tree.TreeNode({
                    text      : $("#newNodeText").val(),
                    id        : nodeId,
                    draggable : ENABLE_DND ? true : false
                });
    
                targetNode.appendChild( newNode );
                if ( $("#isChild").attr("checked") ) {
                    targetNode.leaf = false;
                }
              //  targetNode.expand();
                targetNode.expandAll();
                $("#newNodeText").val("");
            } else {
                alert(Message.msg.processFail);
                //alert("등록중 오류가 발생했습니다.");
            }
        }, "json");
        
    };
    
    var jsInsertAction2 = function(formName) {
        
        if($("#checkYN").val() == ""){
            alert(Message.msg.cmGroup01);
            return;
        }
        if($("#msUserMenuCd").val() == ""){
            alert(Message.msg.cmGroup02);
            return;
        }
        if ( typeof(INSERT_URL) == "undefined" ) {
            alert("INSERT_URL "+Message.msg.cmMenuNoUrl);
            return;
        }
    
        var insertParams;
        if ( typeof(window.jsCreateUpdateParams) == "function" ) {
            insertParams = eval( jsCreateUpdateParams(treePanel) );
        } else {
            alert( "jsCreateUpdateParams()"+ Message.msg.cmParam);
            return;
        }
    
        if ( typeof(window.jsBeforeInsert) == "function" ) {
            var isValid = eval( jsBeforeInsert(formName) );
            if ( !isValid ) return;
        }
        
        var targetNode;
        if ( $("#isSame").attr("checked") )
            targetNode = treePanel.getNodeById( $("#nodeId").val() ).parentNode;
        else if ( $("#isChild").attr("checked") )
            targetNode = treePanel.getNodeById( $("#nodeId").val() );
        else
            targetNode = treePanel.getRootNode();
    
        // var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            insertParams[ADDED_VAR] = ADDED_VALUE;
        }
        //insertParams[NODE_ID_VAR] = $("#cmmntyMenuCode").val();
       // insertParams[PARENT_NODE_ID_VAR] = $("#cmmntyBbsTyCd").val();
        insertParams[PARENT_NODE_NAME_VAR] = $("#cmmntyMenuNm").val();
        insertParams[PARENT_NODE_TEXT_VAR] = $("#cmmntyMenuDc").val();
        
        if (typeof(TOP_NODE_VAR) != "undefined")
            insertParams[TOP_NODE_VAR] = jsGetTopNode(targetNode);
    
        $.post(INSERT_URL, insertParams, function(response) {
    
            if(response.result) {
    
               // jsSuccessBox(response.message);
                alert(Message.msg.insertOk);
                
                $("#cmmntyMenuCode").val("");
                $("#cmmntyMenuNm").val("");
                $("#cmmntyMenuDc").val("");
                //onGroupAdd2();
                
               // alert("11");
                var nodeId = $("#cmmntyMenuCode").val();// response.value;
                //alert();
                var newNode = new Ext.tree.TreeNode({
                    text      : $("#cmmntyMenuNm").val(),
                    id        : nodeId,
                    draggable : ENABLE_DND ? true : false
                });
                    
                targetNode.appendChild( newNode );
                if ( $("#isChild").attr("checked") ) {
                    targetNode.leaf = false;
                }
               
                Ext.getCmp(treePanel.id).getRootNode().reload();
                treePanel.expandAll();
                if ( typeof(window.jsAfterInsert) == "function" ) {
                    eval( jsAfterInsert() );
                }
            } else {
               alert(Message.msg.processFail);
                //alert("등록중 오류가 발생했습니다.");
            }
        }, "json");
        
        
    };
    
    var jsUpdateAction = function(formName) {
    
        if ( typeof(UPDATE_URL) == "undefined" ) {
            alert("UPDATE_URL "+Message.msg.cmMenuNoUrl);
            return;
        }
    
        var updateParams;
        if ( typeof(window.jsCreateUpdateParams) == "function" ) {
            updateParams = eval( jsCreateUpdateParams(treePanel) );
        } else {
            alert( "jsCreateUpdateParams()"+ Message.msg.cmParam);
            return;
        }
    
        if ( typeof(window.jsBeforeUpdate) == "function" ) {
            var isValid = eval( jsBeforeUpdate(formName) );
            if ( !isValid ) return;
        }
        //alert($("#msUpMenuNm").val());
        //alert($("#msUserMenuCd").val());
        //alert($("#msUpMenuCd").val());
        var targetNode = treePanel.getNodeById( $("#cmmntyMenuCode").val() );
          // alert(targetNode);
        $.post(UPDATE_URL, updateParams, function(response) {
            try {
                if(eval(response)) {
          
                    alert(Message.msg.updateOk);
//                    if($("#cmmntyMenuCode").val() == "0"){
//                        
//                        targetNode.setText( $("#cmmntyMenuNm").val() );
//                    }else{
                        targetNode.setText( $("#cmmntyMenuNm").val() );
//                    }
                   
    
                    var showYn = $("input[name=useYn]:checked").val();
                    
                    if (showYn == '') targetNode.setCls("no-use");
                    else targetNode.setCls("");
    
                    //$("#nodePath").html( jsNodePath(targetNode) );
    
                    if ( typeof(window.jsAfterUpdate) == "function" ) {
                        eval( jsAfterUpdate() );
                    }
                }else {
                    alert(Message.msg.processFail);
                    //alert("수정중 오류가 발생했습니다.");
                }
            } catch (e) {
                jsSysErrorBox(response, e);
                return;
            }
    
        });
    };
    
    var jsDeleteAction = function() {
        
        if ( typeof(DELETE_URL) == "undefined" ) {
            alert("DELETE_URL " +Message.msg.cmMenuNoUrl );
            return;
        }
        
        if ( typeof($("#cmmntyMenuCode").val()) == "undefined" ) {
            alert(Message.msg.cmMenuSelect);
            return;
        }
        
        if ($("#cmmntyMenuCode").val() > 2000  && $("#cmmntyMenuCode").val() < 2008 ) {
            alert(Message.msg.cmMenuDelete);
            return;
        }
       
          
        var targetNode = treePanel.getNodeById( $("#cmmntyMenuCode").val() );
    
        var confirmMessage = Message.msg.deleteFileConfirm;
        
        if ( targetNode.childNodes.length > 0 || targetNode.leaf == false){
            confirmMessage = Message.msg.cmBoardDelete;
        }
        var params = {};
        if (typeof(ADDED_VAR) != "undefined") {
            if (ADDED_VALUE == "") return;
            params[ADDED_VAR] = ADDED_VALUE;
        }
        params[PARENT_NODE_ID_VAR] = targetNode.parentNode.id;
        params[NODE_ID_VAR] = targetNode.id;
    
        if ( confirm( confirmMessage ) ) {
            $.post(DELETE_URL, params, function(response) {
    
                try {
                   // alert(response.value);
                    if(eval(response)) {
                       
                        if(response.result){
                            alert(Message.msg.deleteOk);
    //                        alert("정상적으로 삭제되었습니다.");
                            targetNode.remove();
        
                            if ( typeof(window.jsAfterDelete) == "function" ) {
                                eval( jsAfterDelete() );
                            }
        
                            // 상세조회 화면 초기화
                            params[NODE_ID_VAR] = ROOT_TREE_ID;
                            $("#treeDetailDiv").load(
                                VIEW_URL, params
                            );
                        }
                    } else {
                        alert(Message.msg.processFail);
//                        alert("삭제 중 오류가 발생했습니다.");
                    }
                } catch (e) {
                    alert(response, e);
                    return;
                }
            });
        }
    };
    
    var jsNodePath = function(node) {
        var nodeText = node.text;
       
        var parentNode = node.parentNode;
       // alert(parentNode);
        if ( parentNode && parentNode.id != ROOT_TREE_ID ) {
            nodeText = jsNodePath(parentNode) + " > " + nodeText;
        }
        return nodeText;
    };
    
    var jsGetTopNode = function(node) {
        var topNode = node.id;
        var parentNode = node.parentNode;
        if (!parentNode) return "-1";
        if ( parentNode.id != ROOT_TREE_ID ) {
            topNode = jsGetTopNode(parentNode);
        }
        return topNode;
    };