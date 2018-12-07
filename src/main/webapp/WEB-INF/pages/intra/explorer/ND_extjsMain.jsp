<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<%@ page import="java.util.*"%>
<%@ page import="zes.core.lang.*"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ page import="zes.base.support.OpHelper"%>
<%@ page import="zes.openworks.intra.login.LoginVO"%>
<%@ page import="zes.openworks.intra.menugrp.MenuGrpVO"%>

<%!
    final String appNm = GlobalConfig.APP_NAME;
    final String appVersion = GlobalConfig.APP_VERSION;
    final String systemNm = GlobalConfig.SYSTEM_NM;
    final String clientNm = GlobalConfig.CLIENT_NM;
%>
<%
    LoginVO loginVo = OpHelper.getMgrSession(request);
    if (loginVo == null)
        loginVo = new LoginVO();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>OpenWorks 1.0</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />

    <op:jsTag type="spi" items="jquery, jnotify, notice, timer, extjs4" />
    <op:jsTag type="openworks" />

    <script type="text/javascript" src="<c:url value="/resources/intra/explorer/intra.layout_extjs4.js" />"></script>

    <script type="text/javascript">
    //<![CDATA[

        var IS_LOADING = false;
        var DEFAULT_TOP_MENU_CD = "26";
        var LOAD_TEXT = "로딩중...";

        var CTX_ROOT = "<c:url value="/" />";
        var LOGOUT_URL = "<c:url value="/login/mgr/ND_logoutAction.do" />";
        var MENU_URL = "<c:url value="/intra/explorer/ND_left.do" />" + "?highMenuCd=" + DEFAULT_TOP_MENU_CD;
        var NOTE_URL = "<c:url value="/intra/note/BD_index.do" />";
        var INTEREST_LIST_URL = "";
        var DASHBOARD_URL = "<c:url value="/intra/explorer/ND_dashboard.do" />" + "?highMenuCd=" + DEFAULT_TOP_MENU_CD;

        $().ready(function() {
            $("#m" + DEFAULT_TOP_MENU_CD).addClass("on");
        });

        var jsMenuClick = function(id) {
            if(!id) {
                alert('준비 중 입니다.');
                return;
            }
            $("ul.menu > li > a").each(function() {
                $(this).removeClass("on");
            });
            $("#" + id).addClass("on");

            var left = Ext.getDom('leftPanel');
            left.src = "<c:url value="/intra/explorer/ND_left.do"/>?highMenuCd=" + id.replace("m", "")

            // 내메뉴보기 초기화
            $("ul.s_icon > li:last > a").text("내메뉴보기");
        };

        var jsGetMyMenu = function() {
            var text = $("ul.s_icon > li:last > a").text();
            var isHidden = text.indexOf('보기') > -1;

            var $leftPanel = $("iframe[name=leftPanel]").contents();

            if(isHidden) {
                $("ul.s_icon > li:last > a").text("내메뉴닫기");
                $leftPanel.find("#left_menu").hide();
                $leftPanel.find("#my_menu").fadeIn("slow");
            } else {
                $("ul.s_icon > li:last > a").text("내메뉴보기");
                $leftPanel.find("#my_menu").hide();
                $leftPanel.find("#left_menu").fadeIn("slow");
            }
            return;
        };

        function makeTab(title, href, nid, closable) {
            if(!closable) closable = true;

            addTab(title, href, nid, closable);
        }

        function changeStyle(id) {
            $(".3depth > li > a").removeClass("on3");
            $('#' + id).addClass("on3");
        }

        var currMenu = "";
        function changeStyleMenu(id) {
            $("div.snb > ul > li > a").removeClass("on2");
            $('#' + id).addClass("on2");
            $('#' + id).next().toggle();
        }
    //]]>
    </script>

</head>

<body>
    <div id="loading-mask" style=""></div>

    <div id="loading">
        <div class="loading-indicator">
            <a href="#"><%=systemNm%></a> (<%=appNm%> <%=appVersion%>) <br />
            <span id="loading-msg">화면을 준비중입니다. 잠시만 기다려주세요.</span>
        </div>
    </div>

    <div id="top_part">
        <div id="wrapper">
            <!-- 상단부분 -->
            <div id="header">
                <!-- 로고및접속정보 -->
                <div id="t_smenu">
                    <h1>
                        <a href="<c:url value="/" />" target="_top"><img src="<c:url value="/resources/openworks/theme/default/images/layout/logo.gif" />" alt="openworks 로고" /></a>
                    </h1>

                    <fieldset>
                        <legend>웹사이트 선택</legend>
                        <label for="website">웹사이트</label> <select id="website" title="웹사이트항목선택" class="w160" name="option">
                            <option value="kor">대표사이트</option>
                            <option value="eng">영문사이트</option>
                        </select>
                    </fieldset>

                    <div class="t_ing">
                        <p title="<%
                            List<MenuGrpVO> asnMenuGrpList = loginVo.getAsnMenuGrpList();
                            for (MenuGrpVO _menuGrp : asnMenuGrpList) {
                                out.println(_menuGrp.getMenuGrpNm()); 
                            }
                            %>">
                            <%= loginVo.getDeptNm() %> / [<span><%= loginVo.getMgrNm() %></span>]님 접속중
                        </p>
                        <ul>
                            <li><a href='javascript:void(0)' onclick="jsLoadNote()" id="ql-message"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_message.gif" />" alt="쪽지" /></a></li>
                            <li><a href="#" class="about" id="ql-about"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_about.gif" />" alt="about" /></a></li>
                            <li><a href="#" id="ql-logout"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_logout.gif" />" alt="로그아웃" /></a></li>
                        </ul>
                    </div>
                </div>
                <!-- //로고및접속정보 -->
                <hr />
                <!-- 주메뉴 -->
                <h2 class="dpn">주메뉴</h2>
                <div id="gnb">
                    <ul class="s_icon">
                        <li class="m_close"><a href="#" onclick="jsToggleCollapse();" class="yellow">메뉴닫기</a></li>
                        <li class="i_list"><a href="#" onclick="jsGetMyList();" class="yellow">관심목록</a></li>
                        <li class="m_view"><a href="#" onclick="jsGetMyMenu();" class="yellow">내메뉴보기</a></li>
                    </ul>
                    <ul class="menu">
                        <li><a href="#" id="m26" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_01.png" />" alt="마이페이지" /></a></li>
                        <li><a href="#" id="m49" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_02.png" />" alt="조직관리" /></a></li>
                        <li><a href="#" id="m28" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_03.png" />" alt="cms관리" /></a></li>
                        <li><a href="#" id="m68" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_04.png" />" alt="게시판관리" /></a></li>
                        <li><a href="#" id="m27" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_05.png" />" alt="운영관리" /></a></li>
                        <li><a href="#" id="m70" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_06.png" />" alt="회원관리" /></a></li>
                        <li><a href="#" id="m29" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_07.png" />" alt="통계관리" /></a></li>
                        <li><a href="#" id="m8" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_08.png" />" alt="시스템관리" /></a></li>
                    </ul>
                </div>
                <!-- //주메뉴 -->
            </div>
            <!-- //상단부분 -->
        </div>

    </div>
    <!-- note part -->
    <div id="noteAlertDiv">
        <strong><img src="<c:url value="/resources/openworks/theme/default/images/icon/icon_message.gif" />" alt="" />&nbsp; 새 쪽지가 도착했습니다.</strong>
        <p>
            도착한 쪽지를 보시려면 아래 <span class="tx_b">버튼을 클릭</span>하여 <span class="tx_b">내 쪽지함 메뉴</span>로 이동하세요.
        </p>

        <div id="btnDiv">
            <button class="gray" onclick="jsNote();">내 쪽지함 이동</button>
            <button class="gray mar_l5" onclick="jsNoteClose();">닫기</button>
        </div>
    </div>
    <!-- //note part -->

</body>
</html>