<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="java.util.*"%>
<%@ page import="zes.core.lang.*"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ page import="zes.base.support.OpHelper"%>
<%@ page import="zes.openworks.intra.login.LoginVO"%>
<%@ page import="zes.openworks.intra.menugrp.MenuGrpVO"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>

<%!
    final String appNm = GlobalConfig.APP_NAME;
    final String appVersion = GlobalConfig.APP_VERSION;
    final String systemNm = GlobalConfig.SYSTEM_NM;
    final String clientNm = GlobalConfig.CLIENT_NM;
    final String serviceMode = GlobalConfig.SERVICE_MODE;
%>
<%
    LoginVO loginVo = OpHelper.getMgrSession(request);
    if (loginVo == null){
        loginVo = new LoginVO();
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <title>오픈마켓플레이스 통합관리자</title>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />

    <op:jsTag type="spi" items="jquery, jnotify, notice, timer, extjs, extjs-ux" />
    <op:jsTag type="openworks" />

    <script type="text/javascript" src="<c:url value="/resources/intra/explorer/intra.layout.js" />"></script>

    <script type="text/javascript">
    //<![CDATA[

        var IS_LOADING = false;
        var DEFAULT_TOP_MENU_CD = "287";
        var LOAD_TEXT = "로딩중...";

        var CTX_ROOT   = "<c:url value="/" />";
        var LOGOUT_URL = "<c:url value="/login/mgr/ND_logoutAction.do" />";
        var MENU_URL   = "<c:url value="/intra/explorer/ND_left.do" />" + "?highMenuCd=" + DEFAULT_TOP_MENU_CD;
        var NOTE_URL   = "<c:url value="/intra/note/BD_index.do" />";
        var INTEREST_LIST_URL = " ";
        var DASHBOARD_URL = "";
        
        <%
        if(loginVo.getDeptCode() != null && !("").equals(loginVo.getDeptCode().toString())) {
        	if(("1011").equals(loginVo.getDeptCode().toString())) {
				%>
        			DASHBOARD_URL = "<c:url value="/intra/changeMyInfo/BD_changeMyInfo.do" />" + "?highMenuCd=26";
				<%
				} else {
				%>
					DASHBOARD_URL = "<c:url value="/intra/explorer/BD_dashboard.do" />" + "?highMenuCd=" + DEFAULT_TOP_MENU_CD;
				<%
					}
        }%>
		
        $().ready(function() {
            $("#m" + DEFAULT_TOP_MENU_CD).addClass("on");
            //top.noteFrame.loadShowNote();
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

            var left = Ext.getCmp('leftPanel');
            left.setSrc("<c:url value="/intra/explorer/ND_left.do"/>?highMenuCd=" + id.replace("m", ""));

            // 내메뉴보기 초기화
            $("ul.s_icon > li:last > a").text("메뉴닫기");
        };

        var jsGetMyMenu = function() {
            var text = $("ul.s_icon > li:last > a").text();
            var isHidden = text.indexOf('보기') > -1;

            var $leftPanel = $("iframe[name=leftPanel]").contents();

            if(isHidden) {
                $("ul.s_icon > li:last > a").text("메뉴닫기");
                $leftPanel.find("#left_menu").hide();
                $leftPanel.find("#my_menu").fadeIn("slow");
            } else {
                $("ul.s_icon > li:last > a").text("메뉴보기");
                $leftPanel.find("#my_menu").hide();
                $leftPanel.find("#left_menu").fadeIn("slow");
            }
            return;
        };
		
        function jsGoSearch() {
            <% if("dev".equals(serviceMode)){ %>
            var url = "http://202.30.77.190:7800/manager";   //개발
            <% }else{ %>
            var url = "http://202.30.77.186:7800/manager";    //운영
            <% } %>
            window.open(url,'_blank');
        };

        function jsGoWeblog(linkNo) {   //$ceart$ 20150812 웹로그 링크 추가로 linkNo 추가
            <% if("dev".equals(serviceMode)){ %>
            alert("모니터링은 개발환경이 없습니다. 운영으로 접속합니다.");
            var url = "http://202.30.77.188:8000/wiselog";    //운영
            <% }else{ %>
            /* 20150812 웹로그 링크 추가로 수정 시작 */
            var url = "";
            if(linkNo == "1") {
                //이전소스
                //url = "http://intra.ceart.kr/intra/weblog/BD_webLogSSo.do?linkNo=1"; //운영SSO
                
                //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                url = "http://<%=GlobalConfig.DOMAIN_ADMNM %>/intra/weblog/BD_webLogSSo.do?linkNo=1"; //운영SSO
                //}}
            }
            else if(linkNo == "2") {
                //이전소스
                //url = "http://intra.ceart.kr/intra/weblog/BD_webLogSSo.do?linkNo=2"; //운영SSO
                
                //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                url = "http://<%=GlobalConfig.DOMAIN_ADMNM %>/intra/weblog/BD_webLogSSo.do?linkNo=2"; //운영SSO
                //}}
            }
            else {
                //이전소스
                //url = "http://intra.ceart.kr/intra/weblog/BD_webLogSSo.do?linkNo=1"; //운영SSO
                
                //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
                // 변경소스
                url = "http://<%=GlobalConfig.DOMAIN_ADMNM %>/intra/weblog/BD_webLogSSo.do?linkNo=1"; //운영SSO
                //}}
            }
            /* 20150812 웹로그 링크 추가로 수정 끝 */
            <% } %>
            window.open(url,'_blank');
        };

        function jsGoMail() {
            <% if("dev".equals(serviceMode)){ %>
            var url = "http://202.30.77.210:8090/tm6/login.jsp";    //개발
            <% }else{ %>
            //이전소스
            //var url = "http://intra.ceart.kr/intra/mail/BD_emsSSo.do";    //운영SSO
            
            //{{ BH, 2015.12.04, 도메인관리삭제로 인한 소스변경 
            // 변경소스
            var url = "http://<%=GlobalConfig.DOMAIN_ADMNM %>/intra/mail/BD_emsSSo.do";    //운영SSO
            //}}
            <% } %>
            //var url = "http://mail.ceart.kr:8090/tm6/login.jsp";  //운영202.30.77.180
            window.open(url,'_blank');
        };

        function jsGoReport() {
            <% if("dev".equals(serviceMode)){ %>
            var url = "http://202.30.77.190:8080/DataServer/manager/index.html";   //개발
            <% }else{ %>
            var url = "http://202.30.77.182:8080/DataServer/manager/index.html";   //운영
            <% } %>
            window.open(url,'_blank');
        };
        
        /* 2016.11.18 수정 page Enter */
        function jsGoMyInfo() {
            var url =  "/intra/changeMyInfo/BD_changeMyInfo.do";
            window.open(url,'_blank');
        };
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
                    <%-- 개발중 표시 --%>
                    <a href="<c:url value="/intra/explorer/ND_index.do" />" target="_top"><img src="<c:url value="/resources/openworks/theme/default/images/layout/bi_kor.png" />" alt="클라우드스토어 씨앗로고" /></a>
                    <div class="t_ing">
                        <ul>
                        	<%
					        	if(!("1011").equals(loginVo.getDeptCode().toString())) {
							%>
							<li><a href='javascript:void()' onclick="jsGoMyInfo()" id="myinfoSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_admin_change.png" />" alt="정보변경" /></a></li>
                        	<li><a href='javascript:void(0)' onclick="jsGoSearch()" id="searchSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_searchsys.gif" />" alt="검색엔진관리" /></a></li>
                        	<!-- 웹로그 링크 추가로 jsGoWeblog 함수 수정 시작 -->
                        	<li><a href='javascript:void(0)' onclick="jsGoWeblog(1)" id="weblogSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_weblog.gif" />" alt="웹로그모니터링" /></a>
                        	    <a href='javascript:void(0)' onclick="jsGoWeblog(2)" id="weblogSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_weblog.gif" />" alt="웹로그모니터링 테스트" /></a>
                        	</li>
                        	<!-- 웹로그 링크 추가로 jsGoWeblog 함수 수정 끝 -->
                        	<li><a href='javascript:void(0)' onclick="jsGoMail()" id="mailSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_mail.gif" />" alt="메일시스템" /></a></li>
                            <li><a href='javascript:void(0)' onclick="jsGoReport()" id="reportSys"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_reporting.gif" />" alt="레포팅툴관리" /></a></li>
                            <%}%>
                            <%--  <li><a href="/resources/download/manual/managerManual.pdf" target="_blank" class="about" id="ql-about"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_manual.gif" />" alt="매뉴얼" /></a></li> --%>
                            <li><a href="#" id="ql-logout"><img src="<c:url value="/resources/openworks/theme/default/images/btn/btn_logout.gif" />" alt="로그아웃" /></a></li>
                        </ul>
                        <p title="<%
                            List<MenuGrpVO> asnMenuGrpList = loginVo.getAsnMenuGrpList();
                            for (MenuGrpVO _menuGrp : asnMenuGrpList) {
                                out.println(_menuGrp.getMenuGroupNm());
                            }
                            %>">
                            <%= loginVo.getDeptNm() %> / [<span><%= loginVo.getMngrNm() %></span>]님 접속중
                        </p>
                    </div>
                </div>
                <!-- //로고및접속정보 -->
                <hr />
                <!-- 주메뉴 -->
                <h2 class="dpn">주메뉴</h2>
                <div id="gnb">
                    <ul class="s_icon">
                        <li class="m_close"><a href="#" onclick="jsToggleCollapse();" class="yellow">메뉴닫기</a></li>
                        <!-- <li class="i_list"><a href="#" onclick="jsGetMyList();" class="yellow">즐겨찾기</a></li>
                        <li class="m_view"><a href="#" onclick="jsGetMyMenu();" class="yellow">내메뉴보기</a></li> -->
                    </ul>
                    <ul class="menu">
                    <c:forEach items="${dataList}" var="menuVO" varStatus="status">
                    <c:choose>
                    	<c:when test="${menuVO.id == 105}">
                    	<c:if test="${auth.omp_tot_adm eq 'Y'}" >
                    	<li>
                    		<a href="#" id="m105" onclick="jsMenuClick(this.id);"><span style="color:#fff;font-size:13px;font-weight:bold">시스템관리</span></a>
			                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_08.png" />" alt="시스템관리" /> --%>
			            </li>
			            </c:if>
			            </c:when>
			            <c:otherwise>
			            <li>
							<a href="#" id="m${menuVO.id}" onclick="jsMenuClick(this.id);"><span style="color:#fff;font-size:13px;font-weight:bold">${menuVO.text}</span></a>
						</li>
			            </c:otherwise>
			            </c:choose>
                        <%-- <li><a href="#" id="m240" onclick="jsMenuClick(this.id);"><img src="<c:url value="/resources/openworks/theme/default/images/layout/gnb_m_14.png" />" alt="기본협약관리" /></a></li> --%>
                        </c:forEach>
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
            <button class="gray mar_l5" onclick="top.noteFrame.jsNoteClose();">닫기</button>
        </div>
    </div>
    <!-- //note part -->

</body>
</html>