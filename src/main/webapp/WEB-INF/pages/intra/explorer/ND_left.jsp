<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Language" content="ko" />

    <title>오픈마켓플레이스 통합관리자</title>

    <op:jsTag type="spi" items="jquery" />
    <op:jsTag type="openworks" />

    <script type="text/javascript">CTX_PATH = "<%=request.getContextPath()%>";</script>
    <script type="text/javascript">
    //<![CDATA[

/*
        function makeTab(title, href, nid, closable) {
            parent.addTab(title, href, nid, closable);
        }
*/
        function makeTab(title, href, nid, flag) {
            parent.contentPanel.loadClass(title, href, nid, flag);
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
    <!-- 왼쪽메뉴 -->
    <div id="left_menu">

        <h2>
            <c:if test="${param.highMenuCd == '287'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">종합현황 관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_01.png" />" alt="종합현황 관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '26'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">마이페이지</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_01.png" />" alt="마이페이지"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '168'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">서비스관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_11.png" />" alt="서비스관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '169'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">주문관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_12.png" />" alt="주문관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '68'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">게시판관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_04.png" />" alt="게시판관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '170'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">커뮤니티관리</label>
            	<%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_13.png" />" alt="커뮤니티관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '27'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">운영관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_05.png" />" alt="운영관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '70'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">회원관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_06.png" />" alt="회원관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '29'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">통계관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_07.png" />" alt="통계관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '267'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">수요조사관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_15.png" />" alt="수요조사관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '105'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">시스템관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_08.png" />" alt="시스템관리"/> --%>
            </c:if>
            <c:if test="${param.highMenuCd == '272'}">
            	<label style="color:#fff;font-size:18px;font-weight:bold">VOC관리</label>
                <%-- <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_16.png" />" alt="VOC관리"/> --%>
            </c:if>
        </h2>

        <div class="snb">
            <ul>

            <c:forEach items="${dataList}" var="menuVO" varStatus="status">

                <li>
                    <c:choose>

                        <c:when test="${fn:length(menuVO.children) > 0}">

                            <a href="#" id="M_${menuVO.id}" onclick="changeStyleMenu('M_${menuVO.id}')">${menuVO.text}</a>

                            <ul class="3depth">
                                <c:forEach items="${menuVO.children}" var="subVO">
                                    <c:set var="href" value="${subVO.href}" />
                                    <c:if test="${not empty href}">
                                        <c:choose>
                                            <c:when test="${fn:indexOf(href, '?') == -1}">
                                                <c:set var="href" value="${href}?menuCd=${subVO.id}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="href" value="${href}&menuCd=${subVO.id}" />
                                            </c:otherwise>
                                        </c:choose>
                                    </c:if>
                                    <li><a href="#" id="A_${subVO.id}" onclick="changeStyle('A_${subVO.id}');makeTab('${subVO.text}','${href}','${subVO.id}','ADD')">${subVO.text}</a></li>
                                </c:forEach>
                            </ul>

                        </c:when>

                        <c:otherwise>

                            <c:set var="href" value="${menuVO.href}" />
                            <c:if test="${not empty href}">
                                <c:choose>
                                    <c:when test="${fn:indexOf(href, '?') == -1}">
                                        <c:set var="href" value="${href}?menuCd=${menuVO.id}" />
                                    </c:when>
                                    <c:otherwise>
                                        <c:set var="href" value="${href}&menuCd=${menuVO.id}" />
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <a href="#" id="M_${menuVO.id}" onclick="changeStyleMenu('M_${menuVO.id}');makeTab('${menuVO.text}','${href}','${menuVO.id}','ADD')">${menuVO.text}</a>

                        </c:otherwise>

                    </c:choose>
                </li>
	
            </c:forEach>				
            </ul>
            <p><img src="<c:url value="/resources/openworks/theme/default/images/layout/left_m_bgB.gif"/>" alt="" /></p>
        </div>
        

    </div>
    <!-- //왼쪽메뉴 -->

    <div id="my_menu" style="display: none;">
        <h2>
            <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_title_09.png"/>" alt="마이페이지" />
        </h2>
        <div class="snb">
            <div class="menu">
                <a href="#" id="M_MyMenu" onclick="changeStyleMenu('M_MyMenu')">내 메뉴</a>
            </div>
            <ul class="menucontents">
                <c:forEach items="${sessionScope.__msk.myMenuList}" var="myMenu">
                    <c:set var="href" value="${myMenu.href}" />
                    <c:choose>
                        <c:when test="${fn:indexOf(href, '?') == -1}">
                            <c:set var="href" value="${href}?menuCd=${myMenu.id}" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="href" value="${href}&menuCd=${myMenu.id}" />
                        </c:otherwise>
                    </c:choose>
                    <li><a href="#" id="M_${myMenu.id}" onclick="changeStyleMenu('M_${myMenu.id}');makeTab('${myMenu.text}','${href}','${myMenu.id}','ADD')">${myMenu.text}</a></li>
                </c:forEach>
            </ul>
        </div>
        <p>
            <img src="<c:url value="/resources/openworks/theme/default/images/layout/left_m_bgB.gif"/>" alt="" />
        </p>
    </div>


</body>
</html>