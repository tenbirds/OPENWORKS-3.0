<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.utils.Converter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>클라우드스토어 씨앗</title>
    
    <!--공통css--><!-- 
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" /> -->
    <link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_pop.css" />
    
    <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>    
    <script type="text/javascript">
     	
    	// 팝업창 닫기
    	var jsClose = function()
     	{
        	parent.$.fn.colorbox.close();
     	};
  		
     	// 서비스 상세화면으로 이동....
     	var fnViewService = function(el,goodsCode,goodsKndCd)
	     {
	         parent.location.href="/korean/pt/store/software/BD_view.do?goodsCode="+goodsCode+"&pageUrlNm=null&goodsTyCd="+goodsKndCd+"&ctgryPath=&_pathLang=korean" ;
	     };
	</script>	
</head>

 <body class="winPopup">
 
	<h2>계약대상 선정 <a href="#"  onclick="jsClose();">닫기</a></h2>
		
	<div>
		<div style="margin-bottom: 20px;font-size: 12;">
			<b style="font-size:  15px;">총 전시 서비스 ${totalService}개</b>
		</div>
		
		<table class="tbl_st3"> 

	        </tr>
	            <th>서비스명</td>
	        </tr>
	        <c:forEach items="${serviceList}" var="listVo" varStatus="status">  
	        </tr>
	            <td>
	                <a href="#"  onClick="fnViewService(this,'${listVo.goodsCode}','${listVo.goodsKndCd}'); return false;">${listVo.goodsNm}</a>
	            </td>
	        </tr>                                                 
	        </c:forEach>            
        
    	</table>    
       
   </div>
            
</body>
</html>

