<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, zes.openworks.intra.zipcode.*" %>
<c:forEach items="${dataList}" var="dataList" varStatus="status">
	<option value="${dataList.sigunguCd}" <c:if test="${dataList.sigunguCd eq param.q_sigunguCd}">selected="selected"</c:if>>${dataList.sigunguNm}</option>
</c:forEach>
<!-- <script type="text/javascript"> -->
// alert("${param.q_sigunguCd}");
<!-- </script> -->