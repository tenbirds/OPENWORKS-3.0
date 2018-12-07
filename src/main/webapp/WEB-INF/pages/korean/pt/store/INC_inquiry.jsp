<%@page import="zes.openworks.web.store.StoreincVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:scriptlet>
pageContext.setAttribute("newLineChar", "\n");
</jsp:scriptlet>
<c:set var="userSession" value="${sessionScope['__usk'].userId}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />

<title>문의하기</title>
<script type="text/javascript" src="/new_cloud/js/jquery-1.11.3.min.js"></script>
<link rel="shortcut icon" href="/new_cloud/images/common/seart_favicon.ico">
<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />

<script type="text/javascript">
	
	
	
    var inquiryPop = function(el) {
        var url = window.parent.location;
        var  goodsTyCd= "";
        if(url.toString().indexOf("goodsTyCd=1002") > 0){
            goodsTyCd = "goodsTyCd=1002";
        }else if(url.toString().indexOf("goodsTyCd=1001") > 0){
            goodsTyCd = "goodsTyCd=1001";
        }else if(url.toString().indexOf("goodsTyCd=1003") > 0){
            goodsTyCd = "goodsTyCd=1003";
        }
        
        location.href = "../inc/PD_inquiryInsertForm.do?tab=inquiry&goodsCode=" + "${searchMap.goodsCode}"
                + "&pageUrlNm=" + "${searchMap.pageUrlNm}&"+goodsTyCd;
    };

    //페이지 이동
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#dataForm #q_currPage").val(p);
        $("#dataForm").submit();

    };

    var jsAccuseView = function(el, seq, type) {

        var para = "goodsCode=" + "${searchMap.goodsCode}" + "&goodsInqryNo=" + seq + "&pageUrlNm="
                + "${searchMap.pageUrlNm}" + "&accuseAtCd=" + type;
        location.href = "../inc/PD_accuseInsertForm.do?" + para;

    };
    
    
    var jsCommentView = function(index){
        
        // 현재 클릭 행의 class 가져오기
        var trgClass = "";
    	if($("#comment_"+index).hasClass('hide')) {    
    	    trgClass = "hide";
    	}else{
    	    trgClass = "show";	    
    	}

        // 열려있는 모든 답변 tr 닫기
        $("#commentList").find("tr[id^='comment_']").hide();
        $("#commentList").find("tr[id^='comment_']").removeClass('show').addClass('hide');
        
        // 동작 이전의 class를 참조하여 반대 class 적용(열고 닫기)
    	if(trgClass == "show") {
    	    $("#comment_"+index).removeClass('show').addClass('hide');
    	    $("#comment_"+index).slideUp(1000);
    	}else{
    	    $("#comment_"+index).removeClass('hide').addClass('show');
    	    $("#comment_"+index).slideDown(1000);
    	}

    }
    
    function fn_view_comment(bbscttSeq){
        // 현재 클릭 행의 class 가져오기
        var trgClass = "";
    	if($("#contents_"+bbscttSeq).hasClass('show')) {    
    	    trgClass = "show";
    	}else{
    	    trgClass = "hide";	    
    	}
        
        // 열려있는 모든 답변 tr 닫기
        $("#commentList").find("tr[id^='contents_']").hide();
        $("#commentList").find("tr[id^='contents_']").removeClass('hide').addClass('show');
        
        // 동작 이전의 class를 참조하여 반대 class 적용(열고 닫기)
    	if(trgClass == "show") {    
    	    $("#contents_"+bbscttSeq).removeClass('show').addClass('hide');
    		$("#contents_"+bbscttSeq).slideDown(1000);
    	}else{
    	    $("#contents_"+bbscttSeq).removeClass('hide').addClass('show');
    		$("#contents_"+bbscttSeq).slideUp(1000);	    
    	}
    }
    
    
</script>
</head>
 <body class="winPopup qna">

	<form name="dataForm" id="dataForm" method="get"
		action="INC_inquiry.do">
		<input type="hidden" id="goodsCode" name="goodsCode"
			value="${searchMap.goodsCode}" /> <input type="hidden"
			id="pageUrlNm" name="pageUrlNm" value="${searchMap.pageUrlNm}" />
		<input type="hidden" name="q_currPage" id="q_currPage"
			value="<c:out value='${searchMap.q_currPage}'/>" /> <input
			type="hidden" name="q_sortName" id="q_sortName"
			value="<c:out value='${searchMap.q_sortName}'/>" /> <input
			type="hidden" name="q_sortOrder" id="q_sortOrder"
			value="<c:out value='${searchMap.q_sortOrder}'/>" />
	</form>
	
<!-- pop-detail -->
	<table class="tbl_st6 faq" summary="Q&amp;A">
	<caption>Q&amp;A</caption>
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">공개</th>
			<th scope="col">답변상태</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일자</th>
		</tr>
	</thead>
	<tbody>	
		<c:set var="index" value="${pager.indexNo}" />
		<c:set var="ascComplet" value="<%=StoreincVO.ASC_COMPLET%>" />
		<c:set var="ascWait" value="<%=StoreincVO.ASC_WAIT%>" />
		<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			<tr class="item">										
				<td>${index-status.index}</td>
				<td class="title">
					<c:choose>
						<c:when test="${(baseVo.othbcAt eq 'Y' && userSession eq baseVo.orgInqrId) || baseVo.othbcAt eq 'N'}">
							<span onclick="javascript:jsCommentView('${index-status.index}');" class="question" style="cursor: pointer;"><c:out value="${baseVo.inqrySj}" /></span>
						</c:when>
						<c:otherwise>
							<c:out value="${baseVo.inqrySj}" />
						</c:otherwise>
					</c:choose>
<%-- 					
					<c:if test="${(baseVo.othbcAt eq 'Y' && userSession eq baseVo.orgInqrId) || baseVo.othbcAt eq 'N'}">
						<a href="javascript:" class="question"  onclick="javascript:jsCommentView('${index-status.index}');">
					</c:if>
					<c:out value="${baseVo.inqrySj}" /></a>
 --%>					
				</td>
				<td>
					<c:if test="${baseVo.othbcAt eq 'Y'}">비공개</c:if>
					<c:if test="${baseVo.othbcAt eq 'N'}">공개</c:if>
				</td>
				<td <c:if test="${baseVo.answerSttusCd eq ascComplet}"> class="finish" </c:if>>
					<c:out value="${baseVo.answerSttusNm}" />
				</td>
				<td><c:out value="${baseVo.inqrId}" /></td>
				<td><c:out value="${baseVo.registDt}" /></td>
			</tr>
			<c:if test="${baseVo.answerSttusCd eq ascWait and baseVo.othbcAt eq 'N'}">
			<tr id="comment_${index-status.index}" class="hide" style="display:none;background:#f0f0f0;">
	    	<td class="num${index-status.index}">내용 : </td>
					<td class="title" colspan="5">
						<c:out value="${fn:replace(baseVo.inqryCn, newLineChar, '<br/>')}" escapeXml="false"  />
						<c:if test="${baseVo.answerSttusCd eq ascComplet}">
						<br/>== 답변 ============================<br/>
						<c:out value="${fn:replace(baseVo.inqryAnswerCn, newLineChar, '<br/>')}" escapeXml="false" />
						</c:if>
					</td>
	    </tr>
			</c:if>
			<c:if test="${(baseVo.othbcAt eq 'Y' && userSession eq baseVo.orgInqrId) || baseVo.othbcAt eq 'N'}">
				<tr id="comment_${index-status.index}" <c:if test="${pager_sn != baseVo.goodsInqryNo}">  class="hide" style="display:none;background:#f0f0f0;" </c:if>>
					<td class="num${index-status.index}">내용 :</td>
					<td class="title" colspan="5">
						<c:out value="${fn:replace(baseVo.inqryCn, newLineChar, '<br/>')}" escapeXml="false" />
						<c:if test="${baseVo.answerSttusCd eq ascComplet}">
						<br/>== 답변 ============================<br/>
						<c:out value="${fn:replace(baseVo.inqryAnswerCn, newLineChar, '<br/>')}" escapeXml="false" />
						</c:if>
					</td>
				</tr>
				
			</c:if>
		</c:forEach>
		<op:no-data obj="${pager}" colspan="6" />
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5"></td>
			</tr>
		</tfoot>
	</table>
<!-- //list -->	
<!-- </div> -->
		
		<!-- btn-area -->
		<div class="btnArea rig">
			<a href="#" onclick="inquiryPop(this);" class="btns st1">Q&amp;A 등록</a>
		</div>
		<!-- //btn-area -->
		
		<!-- paging -->
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
		<!-- //paging -->
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>	
	
	<script>
		parent.calcHeight('inquiryFrame');
	</script>
</body>
</html>