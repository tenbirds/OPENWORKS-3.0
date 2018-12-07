<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.intra.cms.*" %>
<%@ page import="zes.openworks.intra.cms.support.CmsDecoratorMapper" %>
<%@ page import="zes.core.utils.Converter"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%

HttpSession hs = request.getSession();
String menudecorator = String.valueOf(hs.getAttribute(CmsConstant.DECORATOR_MENU));
String decoratorPath;

String noAuth = CmsDecoratorMapper.NO_AUTH_PAGE;
if(menudecorator.equals(noAuth)) {
    decoratorPath = menudecorator + ".jsp";
} else {
    String domainCd = request.getParameter("q_domainCd");
    if(null == domainCd) {
        CmsVO cmsVo = (CmsVO)request.getAttribute("cmsVo");
        domainCd = cmsVo.getDomainCd().toString();
    }

    decoratorPath = domainCd + "/" + menudecorator + ".jsp";
}

%>

<c:if test="${not empty menudecorator}">
    <jsp:include page="<%= Converter.XSS(decoratorPath) %>" flush="true"></jsp:include>
</c:if>
