<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ page import="zes.core.utils.Converter"%>

<%
    Map<String, Object> searchMap = (HashMap<String, Object>)request.getAttribute("searchMap");
    Map<String, Boolean> ignores = (HashMap<String, Boolean>)request.getAttribute("ignores");

    if(null != searchMap) {
        Iterator<String> it = searchMap.keySet().iterator();
        while(it.hasNext()) {
            String paramName = it.next();
            if(!ignores.containsKey(paramName) && paramName.startsWith(GlobalConfig.PREFIX_SEARCH_PARAM)) {
%>
        <input type="hidden" name="<%= paramName %>" id="<%= paramName %>" value="<%= Converter.XSS(searchMap.get(paramName).toString()) %>" />
<%
            }
        }
    }
%>
