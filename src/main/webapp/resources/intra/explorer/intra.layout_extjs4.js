

Ext.Loader.setConfig({enabled: true});
Ext.Loader.setPath("Ext.ux", "/resources/openworks/spi/extjs4.1/ux");

// 텝 컨텍스트 메뉴 및 이벤트 생성
var currentItem;
var tabCloseMenu = Ext.create("Ext.ux.TabCloseMenu", {
    extraItemsTail : [ "-", {
        text : "Closable",
        checked : true,
        hideOnClick : true,
        handler : function(item) {
            currentItem.tab.setClosable(item.checked);
        }
    }, "-", {
        text : "Enabled",
        checked : true,
        hideOnClick : true,
        handler : function(item) {
            currentItem.tab.setDisabled(!item.checked);
        }
    } ],
    listeners : {
        aftermenu : function() {
            currentItem = null;
        },
        beforemenu : function(menu, item) {
            menu.child("[text=\"Closable\"]").setChecked(item.closable);
            menu.child("[text=\"Enabled\"]").setChecked(!item.tab.isDisabled());
            currentItem = item;
        }
    }
});

/**
 * 텝 UI 객체
 */
var tabs;

/**
 * 레이아웃 생성
 */
Ext.onReady(function() {

    // 텝 UI 객체
    tabs = Ext.create("Ext.tab.Panel", {
        region: "center",
        deferredRender: false,
        activeTab: 0,
        id : "mTabPanel",
        items: [{
            title: "Main",
            closable: false,
            border : 0,
            autoScroll : true,
            layout : "fit",
            xtype : "component",
            autoEl : {
                tag : "iframe",
                src : DASHBOARD_URL
            }
        }],
        plugins: tabCloseMenu
    });

    var logoutButton = Ext.get("ql-logout");
    logoutButton.on("click", function() {
        top.location.href = LOGOUT_URL;
    });

    Ext.create("Ext.Viewport", {
        layout: {
            type: "border",
            border : 0
        },
        items: [{
            region : "north",
            border : false,
            layout : "fit",
            height : 110,
            items : [{
                contentEl : "top_part"
            }]
        },{
            layout : "fit",
            region: "west",
            id : "leftPanel",
            xtype : "component",
            width: 214,
            minWidth: 100,
            minHeight: 140,
            autoScroll : true,
            border : false,
            autoEl : {
                tag : "iframe",
                src : MENU_URL
            }
        },{
            layout : "fit",
            region : "east",
            id : "rightPanel",
            xtype : "component",
            width : 230,
            minSize : 180,
            maxSize : 240,
            autoScroll : true,
            border : false,
            hidden : true,
            autoEl : {
                tag : "iframe",
                src : INTEREST_LIST_URL
            }
        },
        tabs
        ]
    });

    setTimeout(function() {
        Ext.get("loading").remove();
        Ext.get("loading-mask").fadeOut({
            remove : true
        });
    }, 250);
});

/**
 * 텝 메뉴 추가
 *
 * @param title 텝 제목
 * @param href 텝 컨텐츠
 * @param nid 텝 고유 ID
 * @param closable 닫기 여부
 */
function addTab(title, href, nid, closable) {
    var tab = Ext.getCmp("docs-" + nid);
    if(tab) {
        tabs.setActiveTab(tab);
    } else {
        tabs.add({
            id : "docs-" + nid,
            title : title,
            closable : !!closable,
            border : false,
            autoScroll : true,
            layout : "fit",
            xtype : "component",
            autoEl : {
                tag : "iframe",
                src : href
            }
        }).show();
    }
}
