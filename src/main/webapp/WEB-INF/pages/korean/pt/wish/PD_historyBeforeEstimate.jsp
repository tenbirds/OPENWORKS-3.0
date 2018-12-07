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
    
    <title>POPUP - 견적관리(이전 사전견적서 리스트보기)</title>
      
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
      
    <script type="text/javascript">
        var jsClose = function( notifyNum
				                 ,notifySeq
				                 ,userId
				                 ,goodsCd
				                 ,langStoreUserId
			 	               ) 
        {
            parent.$.colorbox.close();
            
            // 부모창에 있는 함수를 부른다.
            // 견적서 보기를 실행한다. 
            parent.jsbfRequestEstimateAgain( notifyNum
						                    ,notifySeq
						                    ,userId
						                    ,goodsCd
						                    ,langStoreUserId
						                   );
        }
    </script>
       
</head>

<body class="winPopup">
    
    <h2>견적관리 <a  href="#close" onclick="jsClose('','','','','');">닫기</a></h2>
    
    <div>        
        
        <table class="tbl_st4">
            <caption></caption>
            <colgroup>
                <col width="40%">
                <col width="60%">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th style="text-align: center;">수신일자</th>
                    <th style="text-align: center;">견적가</th>
                </tr>
                <c:forEach items="${pager}" var="myWishList" varStatus="status">
                    <tr>
                    
                        <td style="text-align: center;">
                             
                             <a href="#" onClick="jsClose('${myWishList.notifyNum}',${myWishList.notifySeq},'${myWishList.userId}','${myWishList.goodsCd}','${myWishList.langStoreUserId}');">
                             	${myWishList.entrDt}
                             </a>
                             
                        </td>
                        <td style="text-align: right;">
                             <a href="#" onClick="jsClose('${myWishList.notifyNum}',${myWishList.notifySeq},'${myWishList.userId}','${myWishList.goodsCd}','${myWishList.langStoreUserId}');">
                             	
                             	<c:if test="${fn:length(myWishList.splyAmt) gt 0}">
                            		<fmt:formatNumber value="${myWishList.splyAmt}" pattern="#,###" />원&nbsp;&nbsp;
                            	</c:if>
                            	
                             </a>
                        </td>                    
    
                    </tr>                    
                </c:forEach>
            </tbody>
        </table>
        
    </div>
    
    
    
    
  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>    
 </body>
</html>
