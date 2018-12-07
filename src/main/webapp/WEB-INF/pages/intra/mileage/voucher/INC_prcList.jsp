<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<op:jsTag type="spi" items="form,colorbox,highlight,ui" />
<op:jsTag type="openworks" items="ui" />

<script type="text/javascript">
$().ready(function() {
    $('#subTab1').attr("class", "");
    $('#subTab2').attr("class", "");
    $('#subTab3').attr("class", "on");
    $('#subTab4').attr("class", "");
    
    $("#searchPrcTypeSpan").hide();
    $('#pagingform input[name=q_tabFlag]').val('${param.q_tabFlag}');
    
    $('.vm').click(function () {
        jsSearch();
     });
});
</script>

<op:pagerParam title="서비스권 지급상태 목록" />

<!-- 리스트 -->
	<table class="boardList" cellspacing="0" border="0" summary="리스트">
		<caption class="hidden"> 서비스권신청목록 </caption>
		<colgroup>
			<col width="5%" />
			<col width="12%" />
			<col width="9%" />
			<col width="9%" />
			<col width="10%" />
			<col width="8%" />
			<col width="8%" />
			<col width="12%" />
			<col width="10%" />
			<col width="" />
		</colgroup>
		<thead>
			<tr>
				<th>번호</th>
				<th>신청자명(ID)</th>
				<th>현재 마일리지</th>
				<th>신청 마일리지</th>
				<th>신청일자</th>
				<th>신청여부</th>
				<th>승인여부</th>
				<th>처리자(ID)</th>
				<th>처리일자</th>
				<th class="lr_none">서비스권 지급 처리상태</th>
			</tr>
		</thead>
		<tbody>
	    <c:set var="index" value="${pager.indexNo}" />
		<c:forEach var="item" items="${pager.list}" varStatus="status">
			<tr <c:if test="${(index-status.index)%2==0}">class="bg_yellow"</c:if>>
				<td>${index-status.index}</td>
				<td>
					<a href="#" onclick="sndStatusView(this, '${item.seqNo}', '${item.userId}');">${item.userNm}<br/>(${item.userId})</a>
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
				<td><a href="#" onclick="sndStatusView(this,'${item.seqNo}','${item.userId}');">${item.prcTypeNm}</a></td>
				<td>${item.voucherPrcNm }</td>
				<td>${item.voucherPrcDt }</td>
				<td class="lr_none">${item.voucherPrcTypeNm}</td>
			</tr>
		</c:forEach>
		<op:no-data obj="${pager.list}" colspan="10" />
		</tbody>
	</table>
	
	<p class="mar_t10">※ 각 현재 마일리지 점수를 클릭하시면 마일리지 적립 내역을 확인할 수 있습니다.</p>
	<p class="mar_t10">※ 각 신청자명을 클릭하시면 신청내역을 확인 할 수 있습니다.</p>
	<p class="mar_t10">※ 각 승인여부를 클릭하시면 발송 처리 내역을 확인 할 수 있습니다.</p>
	<!-- //리스트 -->
	<op:pager pager="${pager}" />