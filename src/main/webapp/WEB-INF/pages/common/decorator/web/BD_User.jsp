<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="zes.openworks.intra.cms.*" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title><decorator:title default="" /></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="ko" />

	<op:jsTag type="spi" items="jquery,notice,colorbox" />
	<op:jsTag type="openworks" />

	<script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>

	<decorator:head />
	<script>
	$().ready(function (){
		
	});
	</script>
</head>

<body>

	<!-- 컨텐츠영역 -->
	<div id="contents_area">
		<!-- 타이틀 및 상단아이콘 -->
		<h3><decorator:title default="" /></h3>

		<decorator:body />

	</div>
	<!-- //컨텐츠영역 -->

</body>
</html>