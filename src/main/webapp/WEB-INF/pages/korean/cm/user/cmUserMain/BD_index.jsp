<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%
	String strCmmntyId =  request.getParameter("cmmntyId") != null ? request.getParameter("cmmntyId") : "";
	
    // 이전소스
	//request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));
	
    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
	// 변경소스
	request.setAttribute("SubDomain", "korean");
	//}}
	    
	String nowURL = request.getRequestURI().toString();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>커뮤니티 홈 | 씨앗 마켓</title>	
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
		$(document).ready(function() {
	    
		});
	
		  var jrMoveList = function(cmmntyMenuUrl, cmmntyId, cmmntyMenuCode, cmmntyBbsTyCd, cmmntyMenuFolderNm ){

		      var subdomain = "<c:out value='${SubDomain}'/>";
		      var movepage = "";
		     	// 이전소스
		      	//if(subdomain == "korean"){
		     	//  movepage ="http://korean.ceart.kr/korean"+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
		     	//}else{
		     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
		     	//}
		     	
		     	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
				// 변경소스
				movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean"+cmmntyMenuUrl+"?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
				//}}
		     	location.href = movepage;
		  };
		  
		  var jrMoveView = function(cmmntyBbsSeq, cmmntyMenuUrl, cmmntyId, cmmntyMenuCode,  cmmntyBbsTyCd, cmmntyMenuFolderNm ){
		      var subdomain = "<c:out value='${SubDomain}'/>";
		      var movepage = "";
		     	// 이전소스
		      	//if(subdomain == "korean"){
		     	//  movepage ="http://korean.ceart.kr/korean/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"View.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
		     	//}else{
		     	//   movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"View.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
		     	//}
		     	
		     	//{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
				// 변경소스
				movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/korean/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"View.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
				//}}
		  		$("#dataForm #cmmntyBbsSeq").val(cmmntyBbsSeq);
		  		$("#dataForm").attr("action",movepage).submit();
		  };
    </script>
</head>
<body>
<c:set var="cmmntyId" value="<%=strCmmntyId %>"/>

		<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
		<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
		<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value=""/>
		<!-- container -->
		<div id="container">
			<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=0&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
			<!-- contents -->
			<div id="contents">
				<section class="main">
				<c:set  var="listLength"  value="${fn:length(cmUserMainMenu)}"/>  
				<c:forEach var="menuList" items="${cmUserMainMenu}" varStatus="status">
					<c:if test="${ status.count == 1 }">
					<div class="notice_area">
					</c:if>
						<div class="notice" > 
							<h2><c:out value="${menuList.cmmntyMenuNm}"/></h2>
							<c:if test="${ menuList.cmmntyBbsTyCd != 1003 }">
							<ul class="list">
								<c:forEach var="indata" items="${menuList.cmUserMainBoardCollection}" varStatus="inStatus">
								<c:if test="${ menuList.cmmntyBbsTyCd == 1001 }"> <%-- 	1001 기본형 --%>
								<c:if test="${indata.othbcSetupCd == 1004 and sessionScope['__usk'].userId != indata.registId and cmInfo.userId != sessionScope['__usk'].userId  }"><li>비밀글입니다.</li></c:if>
								<c:if test="${indata.othbcSetupCd != 1004 || (indata.othbcSetupCd == 1004 and (sessionScope['__usk'].userId == indata.registId || cmInfo.userId == sessionScope['__usk'].userId  ))}">
								<li><a href="#none" onclick="jrMoveView('<c:out value='${ indata.cmmntyBbsSeq}'/>','<c:out value='${ menuList.cmmntyMenuUrl}'/>','<c:out value='${menuList.cmmntyId}'/>','<c:out value='${menuList.cmmntyMenuCode}'/>','<c:out value='${menuList.cmmntyBbsTyCd}'/>','<c:out value='${menuList.cmmntyMenuFolderNm}'/>' );">
								<c:if test="${fn:length(indata.bbscttSj) > 30}"><c:if test="${ indata.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if><c:if test="${indata.othbcSetupCd == 1004}"><strong>[비밀글]</strong></c:if> <c:out value="${fn:substring(indata.bbscttSj,0,25)}"/>...</c:if>
								<c:if test="${fn:length(indata.bbscttSj) <= 30}"><c:if test="${ indata.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if><c:if test="${indata.othbcSetupCd == 1004}"><strong>[비밀글]</strong></c:if> <c:out value="${indata.bbscttSj}"/></c:if><em>[<c:out value='${indata.cmBbsCmtCount}'/>]</em></a><span class="date"><c:out value='${indata.rdcnt}'/></span></li>
								</c:if>
								</c:if>
								<c:if test="${ menuList.cmmntyBbsTyCd != 1001}"> <%-- 	1002 FAQ형, 1004답변형 --%>
								<li><a href="#none" onclick="jrMoveView('<c:out value='${ indata.cmmntyBbsSeq}'/>','<c:out value='${ menuList.cmmntyMenuUrl}'/>','<c:out value='${menuList.cmmntyId}'/>','<c:out value='${menuList.cmmntyMenuCode}'/>','<c:out value='${menuList.cmmntyBbsTyCd}'/>','<c:out value='${menuList.cmmntyMenuFolderNm}'/>' );">
								<c:if test="${fn:length(indata.bbscttSj) > 30}"><c:out value="${fn:substring(indata.bbscttSj,0,30)}"/>...</c:if><c:if test="${fn:length(indata.bbscttSj) <= 30}"><c:out value="${indata.bbscttSj}"/></c:if></a><span class="date"><c:out value='${indata.rdcnt}'/></span></li>
								</c:if>
								</c:forEach>
								<c:if test="${ empty menuList.cmUserMainBoardCollection }">
								<li>등록된 자료가 없습니다.</li>
								</c:if>
							</ul>
							</c:if>
							<c:if test="${ menuList.cmmntyBbsTyCd == 1003 }"><%-- 	1003 갤러리형 --%>
							<ul class="photo_list">
							<c:forEach var="indata" items="${menuList.cmUserMainBoardCollection}" varStatus="inStatus">
								<li>
									<div class="photo"><a href="#none" onclick="jrMoveView('<c:out value='${ indata.cmmntyBbsSeq}'/>','<c:out value='${ menuList.cmmntyMenuUrl}'/>','<c:out value='${menuList.cmmntyId}'/>','<c:out value='${menuList.cmmntyMenuCode}'/>','<c:out value='${menuList.cmmntyBbsTyCd}'/>','<c:out value='${menuList.cmmntyMenuFolderNm}'/>' );"><img src="<c:out value='${indata.cmUserBoardFileCollection[0].fileUrl}'/>" alt="<c:out value='${indata.cmUserBoardFileCollection[0].fileDesc}'/>"/></a></div>
									<ul>
										<li class="date"><c:out value='${indata.registDt}'/></li>
										<li class="inquiry">조회수<span class="num"><c:out value='${indata.rdcnt}'/></span></li>
										<li class="name"><c:if test="${ cmInfo.userId != indata.registId}"><c:out value='${indata.ncnm}'/></c:if><c:if test="${cmInfo.userId == indata.registId }">운영자</c:if></li>
									</ul>
								</li>
							</c:forEach>
							<c:if test="${ empty menuList.cmUserMainBoardCollection }">
								<li>등록된 자료가 없습니다.</li>
								</c:if>
							</ul>
							</c:if>
							<div class="btn_more">
							<a href="#none" title="<c:out value="${menuList.cmmntyMenuNm}"/> 더보기" onclick="jrMoveList('<c:out value='${ menuList.cmmntyMenuUrl}'/>','<c:out value='${menuList.cmmntyId}'/>','<c:out value='${menuList.cmmntyMenuCode}'/>','<c:out value='${menuList.cmmntyBbsTyCd}'/>','<c:out value='${menuList.cmmntyMenuFolderNm}'/>' );"><img src="/resources/cmmnty/default/images/btn/btn_more.gif" alt="더보기"></a></div>
						</div>	
					<c:if test="${ status.count % 2 == 0 and   status.count != 1 }">						
					</div>
					<div class="notice_area">
					</c:if>
					<c:if test="${ status.count == listLength}">
					</div>
					</c:if>
					</c:forEach>
				</section>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form>
</body>
</html>
