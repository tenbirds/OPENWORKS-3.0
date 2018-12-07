<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page import="zes.core.utils.Converter"%>
<html lang="ko">
 	<head>  
	  	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	  	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	  	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	  	
	  	<title>협약기업정보 - 씨앗소개</title>
	  	
	  	<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
		<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
		<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
		<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/common.css" />
		
      	<script type="text/javascript">
		
			// 페이지이동과 검색
	      	var jsMovePage = function(page) 
			{
		        $("#dataForm input[name=q_currPage]").val(page);
		        document.dataForm.action = "BD_index.do";
		        document.dataForm.method = "post";
		        document.dataForm.submit();
		    };
		    
		 	// 서비스리스트
		    var fnViewServiceList = function(el,userId)
			{
	               $(el).colorbox({
	                   title        : "서비스 리스트",
	                   href         : "/korean/pt/introduction/BD_popup.do?q_userId="+userId,
	                   width        : "500",
	                   height       : "350",
	                   closeButton	: true,
	                   overlayClose : false,
	                   escKey       : true,
	                   iframe       : true
	               });
		    };
		    
		    // 기업명변경
		    var fnChangeCompanyName = function(obj) 
			{
		        var companyName = $(obj).val();
		        
		        if (companyName == "") 
		            jsMovePage(1);
		    }; 
		    
    	</script>
 	</head>

 	<body>
 			
	<div class="intro contract">

    	<h4>클라우드스토어 씨앗에 등록된 협약기업의 정보입니다.</h4>		
		
		<form name="dataForm" id="dataForm" method="post" action="BD_index.do">
	        <input type="hidden" name="q_currPage"      id="q_currPage"   value="${q_currPage}" />
	        <input type="hidden" name="q_rowPerPage"    id="q_rowPerPage" value="60" />
	        <input type="hidden" name="q_sortName"      id="q_sortName"   value="${q_sortName}" />
	        <input type="hidden" name="q_sortOrder"     id="q_sortOrder"  value="${q_sortOrder}" />
    	
		<table class="tbl_st4" summary="클라우드스토어 씨앗에 등록된 협약기업의 정보입니다.">
	  	<caption>협약기업의 정보</caption>
	    <colgroup>
	    	<col width="20%"/>
	    	<col width="*"/>
	    </colgroup>
	    <thead>
	    	<tr>
	    		<th colspan="3" scope="col">기업명 검색</th>
	    	</tr>
	    </thead>
	    <tbody>
			<tr>
				<th scope="col" class="txt_blue15" >기업명 검색</th>
				<td>
					<input type="text" id="q_companyName" name="q_companyName"  autofocus="auto" tabindex="1"  value="${q_companyName}"  onkeyup="fnChangeCompanyName(this)"/><label for="q_companyName"></label>
				</td>
				<td><a href="javascript:jsMovePage(1);" class="btns st1">검색</a></td>
				</tr>
				</tbody>
			</table>
			
			<div style="margin-bottom: 10px;">
				<span style="vertical-align:middle;font-size: 16px;font-weight: ">총 ${totalCompany}개 기업 (전시 서비스 ${totalService}개)</span>
				<span style="bold;color: #478edc;">※ 2차협약기준</span>
			</div>
			
			<%-- 
			<c:forEach items="${pager.list}" var="listVo" varStatus="status">
			${listVo.cmpnyNm}<br />
			</c:forEach> --%>
			
			<table class="tbl_st4" summary="협약기업 목록">
			<caption>협약기업 목록</caption>
			<colgroup>
				<col width="*"/>
			</colgroup>
			<thead hidden="hidden">
				<tr><th colspan="4">협약기업 목록</th></tr>
			</thead>
			<tbody>
				<c:forEach items="${pager.list}" var="listVo" varStatus="status">
	      <c:choose>
	       	<c:when test="${status.last and status.index % 4 lt 3}">
	       		<td>
	       			<a href="#"  onClick="fnViewServiceList(this,'${listVo.userId}'); return false;">${listVo.cmpnyNm}</a>
	       		</td>
	       		<c:forEach var="i" begin="0" end="${status.index % 4}" step="1">
	       			<td>&nbsp;</td>
	       		</c:forEach>
	       		</tr>
	       	</c:when>
	       	<c:when test="${status.index % 4 eq 0}">
	           	<tr>
	           	<td>
	       			<a href="#"  onClick="fnViewServiceList(this,'${listVo.userId}'); return false;">${listVo.cmpnyNm}</a>
	       		</td>
	       	</c:when>                  
          <c:when test="${status.index % 4 gt 0 and status.index % 4 lt 3 }">
        		<td>
            	<a href="#"  onClick="fnViewServiceList(this,'${listVo.userId}'); return false;">${listVo.cmpnyNm}</a>
            </td>        				
    			</c:when>
          <c:when test="${status.index % 4 eq 3}">
          	<td>
            	<a href="#"  onClick="fnViewServiceList(this,'${listVo.userId}'); return false;">${listVo.cmpnyNm}</a>
            </td>
          </tr>
          </c:when>                                  
        </c:choose>        					
 			</c:forEach>
 			</tbody>
 			</table>
	        
	        <!-- paging -->
			<op:pager pager="${pager}" page="pager/webPager.jsp"/>
			<!-- //paging -->
				
	   	</form>
        
         								
         	
	</div>
<script> 	
<% String str = Converter.XSS(request.getParameter("link"));
 if ( str != null && str.equals("doc") )  {  %>
 $().ready(function(){
  	$(document).scrollTop($('#doc').offset().top);
  });
<% } %>
</script> 
	</body>
</html>