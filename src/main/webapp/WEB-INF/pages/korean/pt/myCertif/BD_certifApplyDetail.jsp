<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>구매내역 관리 - 마이씨앗</title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "BD_certifApplyList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

       
    </script>

</head>
<body>
	
	<form name="dataForm" id="dataForm"  method="post">
	</form>
		<div class="certifRequList4">
			<div>
					<table class="tbl_st4">
						<tr>
							<th>발급사유</th>
							<td>${dataVo.issuResn}</td>
						</tr>
						<tr>
							<th>발급상태</th>
							<td>${dataVo.issuSttusNm}
							<c:if test="${dataVo.issuSttus eq '1003'}">(발급번호 : ${dataVo.rouIssuNo})</c:if>
							</td>
						</tr>
						<tr>
							<th>발급방법</th>
							<td>${dataVo.issuMthNm}
							<c:if test="${dataVo.issuMth eq 'E'}">${dataVo.email}</c:if>
							<c:if test="${dataVo.issuMth eq 'Z'}">(${dataVo.zip}) ${dataVo.bassAdres} ${dataVo.detailAdres}</c:if>
							</td>
						</tr>
					</table>
			</div>
			<div class="txtarea">
				<p>총 <span>${pager.totalNum}</span>건 (금액 : <span id='totalamout'>000,000,000</span>원)</p>
			</div>
			<div class="list_st1">
				
				<table class="tbl_st1">
					<thead>
						<tr>
							<th>번호</th>
							<th>사업명</th>
							<th>이용기간</th>
							<th>제공자</th>
							<th>서비스명</th>
							<th>구분</th>
							<th>총 계약기간</th>
							<th>총 계약금액 (VAT포함)</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="${pager.indexNo}"/>
					<c:set var="cntrctAmount" value="0" /> 
					<c:forEach items="${pager.list}" var="listData" varStatus="status">
						<tr>
							<td>${index-status.index}</td>
							<td>${listData.svcNm}</td>
							<td>${listData.cntrctBeginDe} ~ ${listData.cntrctEndDe}</td>
							<td>${listData.cmpnyNm}</td>
							<td>${listData.goodsNm}</td>
							<td>${listData.goodsTyNm}</td>
							<td>${listData.splyFromPeriod}</td>
							<td style="text-align:right;padding-right:40px;"><c:if test="${listData.sportAt eq 'Y' and listData.rlCntrctInsttAt eq 'Y'}" >0</c:if>
								<c:if test="${listData.sportAt eq 'N' or listData.rlCntrctInsttAt eq 'N'}" >
									<fmt:formatNumber value="${listData.cntrctAmount}" groupingUsed="true"/>
									<c:set var="cntrctAmount" value="${cntrctAmount+listData.cntrctAmount}" />
								</c:if> 원
							</td>
							<td><c:if test="${listData.sportAt eq 'Y'}" >지원사업</c:if></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<script>$('#totalamout').html('<fmt:formatNumber value="${cntrctAmount}" groupingUsed="true"/>');</script>
			</div>

			<div>
				<a href="javascript:;" onclick="javascript:jsListSearch();" class="btns st1">목록</a>
			</div>
		</div>		
</body>
</html>