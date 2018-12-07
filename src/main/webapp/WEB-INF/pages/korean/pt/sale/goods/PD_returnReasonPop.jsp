<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
 <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
</head>
 <body class="winPopup proSel">
 	<h2>관리자가 등록한 반려사유</h2>
    <!-- 컨텐츠영역 -->
    <div style="border: 1px solid; width: 95%;height: 280px;margin: 10px;font-size: larger;text-align: left;padding: 5px;"><c:out value='${dataVO.returnResn}'/>
    </div>
       
 	 <div class="btnArea">
        <a href="" onclick="parent.jQuery.colorbox.close();" class="btns st1">확인</a>
     </div>
</body>
</html>