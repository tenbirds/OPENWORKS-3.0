<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="ko">
 <head>
    <meta charset="UTF-8" />
    <title>POPUP - 선정평가서</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    <script type="text/javascript">
        // 닫기
        var jsClose = function(){
            parent.$.fn.colorbox.close();
        };
    </script>
 </head>

 <body class="winPopup">
    <h2>선정평가서 <a href="#" onclick="jsClose();">닫기</a></h2>
	<div>
		<table class="tbl_st4 e2">
			<tr>
				<th>사업명</th>
				<td>${baseList.auditlogNm}</td>
			</tr>					
			<tr>
				<th>서비스</th>
				<td>${baseList.goodsNm}</td>
			</tr>					
			<tr>
				<th>선정날짜</th>
				<td>${baseList.bidSussDt}</td>
			</tr>					
			<tr>
				<th>평가서첨부</th>
				<td>
				    <c:if test="${baseList.localOrginlNm != null}">
				        <a href="/component/file/ND_fileDownload.do?id=${baseList.fileId}" title="${baseList.localOrginlNm}" class="aDeisable">${baseList.localOrginlNm} <span class="tx_gray">(${baseList.fileSize}, ${baseList.fileTy})</span></a>
				    </c:if>
				</td>
			</tr>					
		</table>		
	</div>

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>  
  
 </body>
</html>