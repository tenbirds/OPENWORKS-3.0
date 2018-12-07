<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>	
<%@ page import="zes.openworks.intra.cms.support.CmsUtil" %>
<%
	request.setAttribute("SubDomain", CmsUtil.getHostName(request.getServerName()));

	String nowURL = request.getRequestURI().toString();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title><c:out value="${cmUserMenuView.cmmntyMenuNm}"/> | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate" />
	<script type="text/javascript">
	$(document).ready(function() {
	    
	});
	
 	// 페이지 이동
   	var jrMove = function(movepage){
        $("#dataForm").attr("action",movepage).submit();
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
    
    
	//통합검색바
    var jsSearchAction = function() {
		if( $("#q_searchKeyWord").val() == ""){
		    alert(Message.msg.chkSearchVal);
		    return;
		}
		
        $('#q_currPage').val("1");
     	$("#dataForm").attr("action","BD_cmBasicBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>").submit();
    };
    
    var jsUserBoardWrite = function(){
        jrMove("BD_cmBasicBoardForm.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
    };
    
    var jsBoardNoticeWrite = function(menucode){
        if(menucode == ""){
            menucode ="2001";
        }
        jrMove("BD_cmBasicBoardForm.do?cmmntyMenuCode="+menucode+"&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>");
    };

    var jsUserBoardView = function(cmmntyId, langCode, cmmntyMenuCode, cmmntyBbsSeq, registId){

	     	movepage ="BD_cmBasicBoardView.do?cmmntyId="+cmmntyId+"&cmmntyMenuCode="+cmmntyMenuCode;
	     	$('#cmmntyBbsSeq').val(cmmntyBbsSeq);
	  		$("#dataForm").attr("enctype","application/x-korean-form-urlencoded");
	  		$("#dataForm").attr("action",movepage).submit();
    };
	</script>
</head>
<body>
<form name="dataForm" id="dataForm" method="post" action="BD_cmBasicBoardList.do?cmmntyMenuCode=<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>&cmmntyId=<c:out value='${cmUserMenuView.cmmntyId}'/>">
	<input type="hidden" id="cmmntyId" name="cmmntyId" value="<c:out value="${cmUserMenuView.cmmntyId}"/>"/>
	<input type="hidden" id="cmmntyBbsTyCd" name="cmmntyBbsTyCd" value="<c:out value="${cmUserMenuView.cmmntyBbsTyCd}"/>"/>
	<input type="hidden" id="cmmntyBbsSeq" name="cmmntyBbsSeq" value=""/>
	
	<input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value="${searchMap.q_currPage}"/>" />
	
		<!-- container -->
		<div id="container">
			<!-- side navigation bar -->
				<jsp:include page="/korean/cm/user/cmUserMenu/INC_cmUserMenuLeft.do?cmmntyMenuCode=${cmUserMenuView.cmmntyMenuCode}&amp;cmmntyId=${cmUserMenuView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></h2>
				<div class="cont_wrap">
					<div class="selected">
						<select id="q_keyWordSearch" name="q_keyWordSearch" title="검색하실 키워드 선택" style="width:150px;">
							<option value="2001" <c:if test="${param.q_keyWordSearch == '2001'}"> selected="selected" </c:if>>제목 + 내용</option>
							<option value="2002" <c:if test="${param.q_keyWordSearch == '2002'}"> selected="selected" </c:if>>태그</option>
							<option value="2003" <c:if test="${param.q_keyWordSearch == '2003'}"> selected="selected" </c:if>>댓글 내용</option>
							<option value="2004" <c:if test="${param.q_keyWordSearch == '2004'}"> selected="selected" </c:if>>작성자</option>
							<option value="2005" <c:if test="${param.q_keyWordSearch == '2005'}"> selected="selected" </c:if>>댓글 작성자</option>
						</select>
					</div>
					<div class="search">
						<input type="text" class="input" id="q_searchKeyWord" name="q_searchKeyWord" title="카테고리내 검색 단어 입력" value="<c:out value="${param.q_searchKeyWord}"/>" />
						<input type="button" class="btn" id="sech" name="sech" title="검색" onclick="jsSearchAction();" />
					</div>
					<div class="btn_org" >
						<c:if test="${cmMberInfo.mberStateCd == '1003' && cmUserMenuView.cmmntyMenuCode != '2001' && not empty  sessionScope['__usk'].userId  }">
							<a href="#none" onclick="jsUserBoardWrite();">작성하기</a>
						</c:if>
						<c:if test="${cmInfo.userId == sessionScope['__usk'].userId && not empty  sessionScope['__usk'].userId }">
							<a href="#none" onclick="jsBoardNoticeWrite('<c:out value='${cmUserMenuView.cmmntyMenuCode}'/>');">작성하기</a>
						</c:if>
					</div>
				</div>
				<span class="totalcount">
					총 <em class="tx_orange"><c:out value="${pager.totalNum}"/></em>
				</span>
				<table class="tbl_list">
					<caption>
						<strong><c:out value="${cmUserMenuView.cmmntyMenuNm}"/></strong>
						<details>
							<summary>번호, 제목, 작성자, 작성일, 조회수 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:10%">
						<col style="width:*">
						<col style="width:12%">
						<col style="width:15%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col">작성일</th>
							<th scope="col">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
					<c:forEach items="${pager.list}" var="data" varStatus="status">
						<tr>
							<td><c:out value='${pager.indexNo - status.index}'/></td>
							<c:if test="${data.othbcSetupCd == 1004 and sessionScope['__usk'].userId != data.registId and cmInfo.userId != sessionScope['__usk'].userId  }"><td class="t_al">비밀글입니다.</td></c:if>
							<c:if test="${data.othbcSetupCd != 1004 || (data.othbcSetupCd == 1004 and (sessionScope['__usk'].userId == data.registId || cmInfo.userId == sessionScope['__usk'].userId  ))}">
								<c:if test='${empty data.fileList[0].fileUrl}'>
								<td class="t_al"><a href="#none" onclick="jsUserBoardView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>');" >
								<c:if test="${data.othbcSetupCd == 1004}"><strong>[비밀글]</strong></c:if>
								<c:if test="${ data.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if> <c:out value='${data.bbscttSj}'/></a> <span class="num">[<c:out value='${data.cmBbsCmtCount}'/>]</span></td>
								</c:if>
								<c:if test='${not empty data.fileList[0].fileUrl}'>
								<td class="t_al"><a href="#none" onclick="jsUserBoardView('<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMenuCode}'/>','<c:out value='${data.cmmntyBbsSeq}'/>','<c:out value='${data.registId}'/>');" >
								<c:if test="${data.othbcSetupCd == 1004}">[비밀글]</c:if>
								<c:if test="${ data.noticeBbscttAt  == 'Y'}"><strong>[ 공지 ]</strong></c:if> <c:out value='${data.bbscttSj}'/></a>
								<a href="/component/file/ND_fileDownload.do?id=<c:out value='${data.fileList[0].fileId}'/>" title="<c:out value='${data.fileList[0].fileDesc}'/>"><img src="/resources/cmmnty/default/images/common/ico/ico_image.gif" alt="<c:out value='${data.fileList[0].localNm}'/>"></a> <span class="num">[<c:out value='${data.cmBbsCmtCount}'/>]</span></td>
								</c:if>
							</c:if>
							
							<td><c:if test="${ cmInfo.userId != data.registId}"><c:out value='${data.wrterNcnm}'/></c:if><c:if test="${cmInfo.userId == data.registId }">운영자</c:if></td>
							<td class="date"><c:out value='${data.registDt}'/></td>
							<td><c:out value='${data.rdcnt}'/></td>
						</tr>
					</c:forEach>
					<op:no-data obj="${pager}" colspan="5" msg="<strong>작성된 게시물이 없습니다.</strong>" />
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