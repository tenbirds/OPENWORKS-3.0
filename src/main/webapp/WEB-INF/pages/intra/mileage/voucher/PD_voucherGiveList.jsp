<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
<op:jsTag type="spi" items="colorbox,form,ui" />
<op:jsTag type="openworks" items="ui" />
<title>서비스권 지급 기준</title>

<script type="text/javascript">
	
	$().ready(function() {
	    
	});
	
	var jsGiveSetDetail = function(el,appStDate){ //flag : i=신규등록, u=업데이트
	    $(el).colorbox({
            title  : "서비스권 지급 기준 설정 확인",
            href   : "PD_voucherGiveSet.do?kindFlag=U&appStDate="+appStDate,
            width  : "620",
            height : "570",
            iframe : true
    	});
	};
	
	var jsGiveSetInsert = function(el){ 
	    $(el).colorbox({
            title  : "서비스권 지급 기준 설정 등록",
            href   : "PD_voucherGiveSet.do?kindFlag=I",
            width  : "620",
            height : "360",
            iframe : true
    	});
	};
	
	var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#pagingForm input[name=q_currPage]").val(p);
        $("#pagingForm").submit();
    };
</script>

</head>
 
<body>
<h2>서비스권 지급 기준</h2>

<form name="pagingForm" id="pagingForm" method="post" action="PD_voucherGiveList.do" >
	<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
	<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
	<input type="hidden" name="q_currPage" id="q_currPage"value="${param.q_currPage}" />
	<input type="hidden" name="q_searchPrcType" value="${param.q_searchPrcType}" />
	<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
</form>

<op:pagerParam title="서비스권 지급기준 목록" />

<form id="listForm" name="listForm">
	<table class="boardList" cellspacing="0" border="0" summary="리스트">
		<caption class="hidden"> 서비스권신청목록 </caption>
		<colgroup>
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
			<col width="" />
		</colgroup>
		<thead>
			<tr>
				<th>적용시작일</th>
				<th>지급기준</th>
				<th>등록자</th>
				<th class="lr_none">등록일자</th>
			</tr>
		</thead>
		<tbody id="odd-color">
			<c:set var="index" value="${pager.indexNo}"/>
			<c:forEach var="item" items="${pager.list}" varStatus="status">
			<tr>
				<td>${item.appStDate}</td>
				<td><a href="#" onclick="jsGiveSetDetail(this,'${item.appStDate}');">
					<fmt:formatNumber value="${item.giveScale}" type="number" /></a>
				</td>
				<td><c:if test="${empty item.modNm}">${item.regNm}</c:if>${item.modNm}</td>
				<td>
					<c:if test="${empty item.modNm}">
						<fmt:formatDate value="${item.regDtm}" pattern="yyyy-MM-dd" />
					</c:if>
						<fmt:formatDate value="${item.modDtm}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			</c:forEach>
			<op:no-data obj="${pager.list}" colspan="4" />
		</tbody>
	</table>	
</form>
<p class="mar_t10">※ 각 지급기준 점수를 클릭하시면 적용 시작일별 변경 내역을 확인할 수 있습니다.</p>
<op:pager pager="${pager}" />
<p class="tx_r mar_t20">
	<button type="button" onclick="jsGiveSetInsert(this);" class="blue">등록</button>
<!-- 		<button type="button" onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button> -->
</p>

</body>
</html>