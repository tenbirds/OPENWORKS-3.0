<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>즐겨찾기</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/openworks/theme/default/css/openworks_all.css"/>" />
    <op:jsTag type="spi" items="jquery" />
    <op:jsTag type="openworks" items="form" />

    <script type="text/javascript">
    //<![CDATA[
        $().ready( function() {
            $('ul > li').click(function () {
                $(this).parent().find('li').removeClass('on');
                $(this).addClass('on');
                parent.contentPanel.loadClass('즐겨찾기', $(this).attr('link'), 'x999', 'UPDATE');
            });

        });
    //]]>
    </script>

</head>

<body>
    <div id="right_menu">
	    <h3><img src="<c:url value="/resources/openworks/theme/default/images/icon/icon_interest_tit.gif" />" alt="" /> 즐겨찾기</h3>
	    <ul>
	        <c:forEach items="${dataList}" var="_bean">
	        <li link="${_bean.link}">
	            <h4>${_bean.category}</h4>
	            <p>${_bean.interestDesc}</p>
	        </li>
	        </c:forEach>
	    </ul>
    </div>
</body>
</html>