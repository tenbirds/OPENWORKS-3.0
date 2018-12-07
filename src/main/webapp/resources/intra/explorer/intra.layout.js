
ContentPanel = function() {
    if(DASHBOARD_URL != ''){
        ContentPanel.superclass.constructor.call(this, {
            region : 'center',
            margins : '5 5 0 0',
            resizeTabs : false,
            collapsible : false,
            split : false,
            plugins : new Ext.ux.TabCloseMenu(),
            enableTabScroll : true,
            activeTab : 0
            //대시보드생성
            ,items : {
                xtype : 'iframepanel',
                frame : true,
                id : 'docs-1',
                title : 'Main',
                defaultSrc : DASHBOARD_URL,
                iconCls : 'icon_tab_title',
                closable : false,
                border : false,
                autoScroll : true
            }
        });
    } else {
        ContentPanel.superclass.constructor.call(this, {
            region : 'center',
            margins : '5 5 0 0',
            resizeTabs : false,
            collapsible : false,
            split : false,
            plugins : new Ext.ux.TabCloseMenu(),
            enableTabScroll : true,
            activeTab : 0
        });
    }
};

Ext.extend(ContentPanel, Ext.TabPanel, {

    id : 'mTabPanel',
    initEvents : function() {
        ContentPanel.superclass.initEvents.call(this);
    },

	listeners : {
        'beforeclose' : function() {
            alert("sdfsf");
        },

        'beforetabchange' : function(tp, newTab, currentTab) {
            if(currentTab)
                currentTab.setIconClass('icon_tab_title');
        },

        'tabchange' : function(tp, tab) {
            tab.setIconClass('icon_tab_title_on');
        }
    },

	loadClass : function(title, href, nid, flag) {
        if(!href) {
            Ext.Msg.show({
                title : '경고',
                msg : 'URL 정보가 없습니다.',
                icon : Ext.Msg.ERROR,
                buttons : Ext.Msg.OK
            });
            return;
        }

        var id = 'docs-' + nid;
        var tab = this.getComponent(id);
        var tab2 = this.getComponent(id + 'A');

        //텝브라우징 제한
        if(flag == 'NEW' && !tab2) {
            tab = false;
            id = 'docs-' + nid + 'A';
        }

        if(tab) {
            this.setActiveTab(tab);

            if(flag == 'UPDATE')
                tab.getFrame().setSrc(CTX_ROOT + href);

            tab.setIconClass('icon_tab_title_on');

        } else {
            IS_LOADING = true;

            var p = this.add(new DocPanel({
                id : id,
                title : title,
                /* 
                tabTip : title, 
                loadMask : {
                    msg : LOAD_TEXT
                },
                */
                nid : nid,
                iconCls : 'icon_tab_indicator',
                defaultSrc : href.indexOf('http') > -1 ? href : CTX_ROOT + href
            }));

            this.setActiveTab(p);
            p.setIconClass('icon_tab_indicator');

            p.getFrame().on('documentloaded', function(e) {
                p.setIconClass('icon_tab_title_on');
                IS_LOADING = false;
            });
        }
    }
});

DocPanel = Ext.extend(Ext.ux.ManagedIFrame.Panel, {
    closable : true,
    border : false,
    layout : 'fit'
});


Ext.onReady(function() {

    if(CTX_ROOT) {
        if(CTX_ROOT.match('/' + "$") == '/')
            CTX_ROOT = CTX_ROOT.substring(0, CTX_ROOT.lastIndexOf('/'));
    }

    var logoutButton = Ext.get('ql-logout');
    logoutButton.on('click', function() {
        top.location.href = LOGOUT_URL;
    });

    contentPanel = new ContentPanel();

    var topMenu = new Ext.Panel({
        border : false,
        layout : 'fit',
        region : 'north',
        // cls: 'header',
        height : 110,
        items : {
            xtype : 'box',
            el : 'top_part',
            border : false
        }
    });

    var viewport = new Ext.Viewport({
        layout : 'border',
        items : [ topMenu, {
            xtype : 'iframepanel',
            id : 'rightPanel',
            layout : 'fit',
            region : 'east',
            split : true,
            width : 230,
            minSize : 180,
            maxSize : 240,
            autoScroll : true,
            margins : {
                top : 5,
                left : -5,
                right : 5,
                bottom : 5
            },
            cmargins : {
                top : 5,
                left : 0,
                right : 5,
                bottom : 0
            },
            border : true,
            defaultSrc : INTEREST_LIST_URL,
            autoScroll : true,
            hidden : true
        }, {
            xtype : 'iframepanel',
            id : 'leftPanel',
            layout : 'fit',
            region : 'west',
            split : true,
            width : 214,
            autoScroll : true,
            margins : {
                top : 5,
                left : 5,
                right : 0,
                bottom : 5
            },
            cmargins : {
                top : 5,
                left : 5,
                right : 5,
                bottom : 0
            },
            border : true,
            defaultSrc : MENU_URL,
            autoScroll : true
        }, {
            layout : 'border',
            border : false,
            region : 'center',
            margins : {
                top : 0,
                left : 0,
                right : 0,
                bottom : 5
            },
            cmargins : {
                top : 5,
                left : 5,
                right : 5,
                bottom : 0
            },
            items : [ contentPanel ]
        } ]
    });

    viewport.doLayout();

    setTimeout(function() {
        Ext.get('loading').remove();
        Ext.get('loading-mask').fadeOut({
            remove : true
        });
    }, 250);

});

function jsToggleCollapse() {
    var left = Ext.getCmp('leftPanel');
    if(left.hidden) {
        left.show();
        $('ul.s_icon > li:first').removeClass("m_open");
        $('ul.s_icon > li:first').addClass("m_close");
        $('ul.s_icon > li:first > a').text("메뉴닫기");
    } else {
        left.hide();
        $('ul.s_icon > li:first').removeClass("m_close");
        $('ul.s_icon > li:first').addClass("m_open");
        $('ul.s_icon > li:first > a').text("메뉴열기");
    }
    left.ownerCt.doLayout();
    // Ext.getCmp('leftPanel').toggleCollapse(true);
};

function jsGetMyList() {
    var right = Ext.getCmp('rightPanel');
    if(right.hidden)
        right.show();
    else
        right.hide();
    right.ownerCt.doLayout();
}

function jsLoadNote() {
    contentPanel.loadClass('내 쪽지함', CTX_ROOT + NOTE_URL, 'NOTE', 'ADD');
};

var jsNote = function() {
    jsLoadNote();
    jsNoteClose();
};

var jsNoteClose = function() {
    if(typeof (top.noteFrame.jsNoteClose) == "function") {
        top.noteFrame.jsNoteClose();
    }
};