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
	String nowURL = request.getRequestURI().toString();
	
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>작성 글 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
	$(document).ready(function() {
	    
	});
	
	//통합검색바
    var jsSearchAction = function() {
		if( $("#q_searchKeyWord").val() == ""){
		    alert(Message.msg.chkSearchVal);
		    return;
		}
        $('#q_currPage').val("1");
     	$('#dataForm').submit();
    };
    
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };    

    var jsUserBoardView = function(cmmntyId, cmmntyMenuFolderNm, cmmntyMenuCode, cmmntyBbsSeq,  registId, cmmntyBbsTyCd ){
	      	var subdomain = "<c:out value='${SubDomain}'/>";
	      	var movepage = "";
	     	if(cmmntyBbsTyCd == "1002"){
	     	    // 이전소스
	     	    //movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"List.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
	     	    
	     	    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
				// 변경소스
				movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/"+subdomain+"/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"List.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
				//}}
	     	    
	     	}else{
	     	    // 이전소스
	     	    //movepage ="http://"+subdomain+".ceart.kr/"+subdomain+"/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"View.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
	     	    
	     	    //{{ BH, 2015.11.20, 도메인관리삭제로 인한 소스변경 
				// 변경소스
				movepage ="http://<%=GlobalConfig.DOMAIN_SUBNM %>/"+subdomain+"/cm/user/cmUserBoard/"+cmmntyMenuFolderNm+"/BD_"+cmmntyMenuFolderNm+"View.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
				//}}
	     	}
	  		$("#dataForm #cmmntyBbsSeq").val(cmmntyBbsSeq);
	  		$("#dataForm").attr("action",movepage).submit();
	  };
	</script>
</head>
<body>
		<form name="dataForm" id="dataForm" method="post">
		<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
		<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
		<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value=""/>
		<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${searchMap.q_currPage}"/>" />
		<!-- container -->
		<div id="container">
			<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=2&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
			<!-- contents -->
			<div id="contents">
				<h2>작성 글</h2>
				<div class="cont_wrap">
					<div class="selected">
						<select id="q_keyWordSearch" name="q_keyWordSearch" title="검색하실 키워드 선택" style="width:150px;">
							<option value="2001" <c:if test="${param.q_keyWordSearch == '2001'}"> selected="selected" </c:if>>제목 + 내용</option>
							<option value="2002" <c:if test="${param.q_keyWordSearch == '2002'}"> selected="selected" </c:if>>태그</option>
							<option value="2003" <c:if test="${param.q_keyWordSearch == '2003'}"> selected="selected" </c:if>>댓글 내용</option>
							<option value="2005" <c:if test="${param.q_keyWordSearch == '2005'}"> selected="selected" </c:if>>댓글 작성자</option>
						</select>
					</div>
					<div class="search">
						<input type="text" class="input" id="q_searchKeyWord" name="q_searchKeyWord" title="카테고리내 검색 단어 입력" value="<c:out value="${param.q_searchKeyWord}"/>">
						<input type="submit" class="btn" id="sech" name="sech" title="검색" onclick="jsSearchAction();">
					</div>
				</div>
				<span class="totalcount">
					총 <em class="tx_orange"><c:out value="${pager.totalNum}"/></em>
				</span>
				<table class="tbl_list">
					<caption>
						<strong>작성 글 게시판</strong>
						<details>
							<summary>번호, 제목, 작성자, 작성일, 조회수 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:*">
						<col style="width:15%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
					<c:forEach items="${pager.list}" var="data" varStatus="status">
						<tr>
							<td><c:out value='${pager.indexNo - status.index}'/></td>
							<c:if test='${empty data.fileList[0].fileUrl}'>
							<td class="t_al"><a href="#none" onclick="jsUserBoardView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.cmmntyMenuFolderNm}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>', '<c:out value='${data.cmmntyBbsTyCd}'/>');" >
							<c:out value='${data.bbscttSj}'/></a> <c:if test="${data.cmmntyBbsTyCd != '1002'}"><span class="num">[<c:out value='${data.cmBbsCmtCount}'/>]</span></c:if></td>
							</c:if>
							<c:if test='${not empty data.fileList[0].fileUrl}'>
							<td class="t_al"><a href="#none" onclick="jsUserBoardView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.cmmntyMenuFolderNm}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>', '<c:out value='${data.cmmntyBbsTyCd}'/>');" >
							<c:out value='${data.bbscttSj}'/></a>
							<a href="/component/file/ND_fileDownload.do?id=<c:out value='${data.fileList[0].fileId}'/>" title="<c:out value='${data.fileList[0].fileDesc}'/>"><img src="/resources/cmmnty/default/images/common/ico/ico_image.gif" alt="<c:out value='${data.fileList[0].localNm}'/>"></a> <c:if test="${data.cmmntyBbsTyCd != '1002'}"><span class="num">[<c:out value='${data.cmBbsCmtCount}'/>]</span></c:if></td>
							</c:if>
							<td class="date"><c:out value='${data.registDt}'/></td>
							<td><c:out value='${data.rdcnt}'/></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<!-- paging -->
				<op:pager pager="${pager}" page="pager/cmPager.jsp" />
				<!-- //paging -->
			</div>
			<!-- //contents -->
			</div>
		<!-- //container -->
</body>
</html>
