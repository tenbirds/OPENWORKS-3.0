<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script type="text/javascript">
	$().ready(function() {
	    $('#subTab1').attr("class", "on");
	    $('#subTab2').attr("class", "");
	    $('#subTab3').attr("class", "");
	    $('#subTab4').attr("class", "");
	    $("#searchPrcTypeSpan").show();
	    
	    $('.vm').click(function () {
	        jsSearch();
	     });
	});
</script>
<form name="pagingform" id="pagingform" method="post" >
	<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
	<input type="hidden" name="q_searchVal" value="${param.q_searchVal}" />
	<input type="hidden" name="q_currPage" id="q_currPage"value="${param.q_currPage}" />
	<input type="hidden" name="q_searchPrcType" value="${param.q_searchPrcType}" />
	<input type="hidden" name="q_rowPerPage" value="${param.q_rowPerPage}" />
	<input type="hidden" name="pwdYn" value="${param.pwdYn}"/>
	<input type="hidden" id="q_tabFlag" name="q_tabFlag" value="${param.q_tabFlag }" />
</form>
<op:pagerParam title="서비스권신청 목록" />

<!-- 리스트 -->
<table class="boardList" cellspacing="0" border="0" summary="리스트">
		<caption class="hidden"> 서비스권신청목록 </caption>
		<colgroup>
			<col width="6%" />
			<col width="6%" />
			<col width="" />
			<col width="12%" />
			<col width="12%" />
			<col width="17%" />
			<col width="12%" />
			<col width="12%" />
			<col width="12%" />
		</colgroup>
		<thead>
			<tr>
				<th>선택</th>
				<th>번호</th>
				<th>신청자명(ID)</th>
				<th>현재 마일리지</th>
				<th>신청 마일리지</th>
				<th>신청일자</th>
				<th>신청여부</th>
				<th>신청후 잔여 마일리지</th>
				<th>승인여부</th>
			</tr>
		</thead>
		<tbody>
	    <c:set var="index" value="${pager.indexNo}" />
		<c:forEach var="item" items="${pager.list}" varStatus="status">
			<tr <c:if test="${(index-status.index)%2==0}">class="bg_yellow"</c:if>>
				<td>
					<input type="checkbox" onclick="jsToggleCheck(this);" name="ckSelect_${item.seqNo}" id="ckSelect_${item.seqNo}" value="${item.seqNo}" class="checkbox"
						     <c:if test="${item.prcType ne '1004' or ((item.curAmount - item.reqAmount) < 0 )}"> disabled="disabled"</c:if> />
				</td>
				<td>${index-status.index}</td>
				<td>
					<a href="#" onclick="appDetailView(this, '${item.seqNo}', '${item.userId}');">${item.userNm}(${item.userId})</a>
					<input type="hidden" name="userId" id="userId${item.seqNo}" value="${item.userId}" />
					<input type="hidden" name="userNm" id="userNm${item.seqNo}" value="${item.userNm}" />
					<input type="hidden" name="reqAmount" id="reqAmount${item.seqNo}" value="${item.reqAmount}" />
				</td>
				<td class="tx_r">
					<a href="#" onclick="pwdConfirm(this
													, '회원 마일리지 정보조회'
													, 'R'
													, '/intra/mileage/read/PD_mileageView.do'
													, '900'
													, '700'
													, '${item.userId}'
													, '∬userNm=${item.userNm}'
													, '' 
													, ''
													);"><fmt:formatNumber value="${item.curAmount}" type="number" />
					</a>
				</td>
				<td class="tx_r"><fmt:formatNumber value="${item.reqAmount}" type="number" /></td>
				<td><fmt:formatDate value="${item.reqDtm}" pattern="yyyy-MM-dd" /></td>
				<td>${item.reqType}</td>
				<td class="tx_r" <c:if test="${(item.curAmount - item.reqAmount) < 0}" > style="color: red;" </c:if>>
					<c:if test="${item.voucherPrcType ne '1001'}"><fmt:formatNumber value="${item.curAmount - item.reqAmount}" type="number" /></c:if>
				</td>
				<td>
					<c:choose>
						<c:when test="${item.reqType eq '신청' and not empty item.prcTypeNm}">
							${item.prcTypeNm}
						</c:when>
						<c:when test="${item.reqType eq '신청' and empty item.prcTypeNm}">
							승인대기
						</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		<op:no-data obj="${pager.list}" colspan="9" />
		</tbody>
	</table>
	
	<p class="mar_t10">※ 각 현재 마일리지 점수를 클릭하시면 마일리지 적립 내역을 확인할 수 있습니다.</p>
	<p class="mar_t10">※ 각 신청자명을 클릭하여 승인/미승인을 선택 할 수 있습니다.</p>
	<!-- //리스트 -->
	<br/>
	<div class="tx_l"><button type="button" onclick="jsSelectApp();" class="blue">선택승인</button></div>
	
	<op:pager pager="${pager}" />	
