<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    
    <title>POPUP - 검색이력조회</title>
      
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
      
    <script type="text/javascript">
        var jsClose = function() 
        {
            parent.$.colorbox.close();            
        }
    </script>
       
</head>

 <body class="winPopup">
	<h2>검색이력조회  <a  href="#close" onclick="jsClose();">닫기</a></h2>
	<div>
		<p class="title_area"><strong>${myWishVO.goodsNm}</strong>${myWishVO.langStoreNm}</p>
		<ul class="list_search_history">
           	<li>
           		<p>1. 검색어</p>
           		<input name="" type="text" placeholder="" />
           	</li>
           	<li>
           		<p>2. 필터검색</p>
           		<input name="" type="text" placeholder="" value="${filtercon}"/>
           	</li>
           	<li>
           		<p>3. 비교대상</p>
           		<table class="tbl_st3 type_c">
                   <colgroup>
                   	  <col width="30%" />
                      <col />
                   </colgroup>
                   <!-- 
                   <tr>
                        <th>비교대상</th>
                        <th>비교항목</th>
                   </tr>
                   <tr>
                        <th>구름IDE</th>
                        <td>기업정보, 서비스단가, 시스템사양</td>
                   </tr>
                   <tr>
                        <th>파스-타</th>
                        <td>서비스단가, 시스템사양</td>
                   </tr> -->
                </table>
           	</li>
    	</ul>   		
	</div>
	
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>	
 </body>
 
</html>
