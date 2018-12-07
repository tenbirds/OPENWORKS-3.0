<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	// 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	//변경소스
	request.setAttribute("SubDomain", "korean");
	//}}

	
%>

	<style type="text/css">
	#containerLogoMenu {position:relative; width:999px; height:170px; margin:0 auto; overflow:hidden}
	#containerLogoMenu img {position:absolute; top:0; left:0} 
	#containerLogoMenu .resultMenu > * {position:absolute;}
	 #containerLogoMenu .resultMenu .inertxtMenu {line-height:normal; }
	</style>
	<script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script>
  	<script type="text/javascript">
	  $(document).ready(function() {
	      cmOpenInfoMenu = {
	              	logoTitleMenu : "<c:out value="${cmUserMenuView.logoTitle}" default="Open Market Place" />",
				    logoTitleWidthLcMenu  : <c:out value="${cmUserMenuView.logoTitleWidthLc}" default="0" />,	        
				    logoTitleVrticlLcMenu  : <c:out value="${cmUserMenuView.logoTitleVrticlLc}" default="0" />,	        
				    logoTitleFontMenu  : "<c:out value="${cmUserMenuView.logoTitleFont}" />",	        
				    logoTitleFontSizeMenu : "<c:out value="${cmUserMenuView.logoTitleFontSize}" default="34" />",	        
				    logoTitleColorMenu : "<c:out value="${cmUserMenuView.logoTitleColor}" />"	        
				};
	      
	   // text 로고의 초기 위치 설정
	    	var leftMenu = cmOpenInfoMenu.logoTitleWidthLcMenu;
	    	var topMenu  = cmOpenInfoMenu.logoTitleVrticlLcMenu;
	    	
	    	$("#textLogoMenu").css({ "top": parseInt(topMenu, 10), "left": parseInt(leftMenu, 10) });
	    	
		    var html = '<P id="preLogoMenu" style="font-family:\'' + cmOpenInfoMenu.logoTitleFontMenu + '\'; font-size:' + cmOpenInfoMenu.logoTitleFontSizeMenu + 'px; font-style:italic; color:#' + cmOpenInfoMenu.logoTitleColorMenu + '">' + cmOpenInfoMenu.logoTitleMenu + '</p>';
		    $( "#textLogoMenu" ).html(html);
	  });
	  
	  var jrMoveMenu = function(movepage){
	  		//$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
	  		$("#dataForm").attr("action",movepage).submit();
	  };
	 var jsCmUserMove = function(movepage){
	     var subdomain = "<c:out value='${SubDomain}'/>";
	      var cmmntyId="<c:out value='${cmmntyId}'/>";
	      var movepage = "";
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserMain/BD_index.do?cmmntyId="+cmmntyId;
	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
	  		$("#dataForm").attr("action",movepage).submit();
	  };
	  
	  var jrMoveMenu2 = function(){

	      var subdomain = "<c:out value='${SubDomain}'/>";
	      var cmmntyId="<c:out value='${cmmntyId}'/>";
	      var movepage = "";
			movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/admin/cmOptInfo/BD_cancleIndex.do?cmmntyId="+cmmntyId;
	     	
	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
	  		$("#dataForm").attr("action",movepage).submit();
	  };
  </script>
		<div class="visual">
			<c:if test="${cmUserMenuView.logoDirectRegistAt eq 'Y'}">
					<img id="imgTitle" src="<c:out value="${cmUserMenuView.logoFileUrl}"/>" alt="대표이미지">
			</c:if>
			<c:if test="${cmUserMenuView.logoDirectRegistAt eq 'N'}">
				<div id="containerLogoMenu">
					<div class="resultMenu" >
						<img id="mainLogoMenu" src="/upload/cmmntylogo/img_banner_visual.jpg" alt="대표이미지" style="width:999px; height:170px;" />
						<div id="textLogoMenu" class="inertxtMenu" ></div>
					</div>
				</div>
			</c:if>
		</div>
		<!-- side navigation bar -->
		<div class="snb">
			<div class="community_Login">
				<p class="ico">운영자</p>
				<div class="admin">
					<div class="txt">커뮤니티 관리</div>
					<div class="btn_light_gray">
						<a href="#none" onclick="jsCmUserMove();">커뮤니티 모드</a>
					</div>
				</div>
			</div>
			<c:set  var="listLength"  value="${fn:length(cmOptAdminMenuList)}"/> 
			<c:forEach var="dataList" items="${cmOptAdminMenuList}" varStatus="status">
			<c:if test='${ status.count == 1 }' >
			<ul>
				<li><a href="#none" onclick="jrMoveMenu('<c:out value='${ dataList.userMenuUrl}'/>?cmmntyId=<c:out value='${cmmntyId}'/>');"<c:if test='${ menuCode  eq dataList.menuCode}'> class="on"</c:if>><c:out value='${ dataList.userMenuNm}'/></a></li>
			</c:if>
			<c:if test='${ status.count != 1 && status.count != listLength }' >
				<li><a href="#none" onclick="jrMoveMenu('<c:out value='${ dataList.userMenuUrl}'/>?cmmntyId=<c:out value='${cmmntyId}'/>');"<c:if test='${ menuCode  eq dataList.menuCode}'> class="on"</c:if>><c:out value='${ dataList.userMenuNm}'/></a></li>
			</c:if>
			<c:if test='${ status.count == listLength }' >
			</ul>
			<c:if test ="${cmUserMenuView.cmmntySttusCd != '1005' }">
			<div class="closing"><a href="#none" onclick="jrMoveMenu('<c:out value='${ dataList.userMenuUrl}'/>?cmmntyId=<c:out value='${cmmntyId}'/>');"<c:if test='${ menuCode  eq dataList.menuCode}'> class="on"</c:if>><c:out value='${ dataList.userMenuNm}'/></a></div>
			</c:if>
			<c:if test ="${cmUserMenuView.cmmntySttusCd == '1005' }">
			<div class="closing"><a href="#none" onclick="jrMoveMenu2();"<c:if test='${ menuCode  eq dataList.menuCode}'> class="on"</c:if>><c:out value='${ dataList.userMenuNm}'/></a></div>
			</c:if>
			</c:if>
			</c:forEach>
		</div>
		<!-- //side navigation bar -->