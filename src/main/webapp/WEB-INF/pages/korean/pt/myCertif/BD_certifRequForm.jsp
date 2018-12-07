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
    <op:jsTag type="spi" items="form,validate,datepicker" />
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
		$(document).ready(function() {
		 	/* $("#dPicker_1, #dPicker_2").datepicker({
		          showOn: "both", 
		          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
		          buttonImageOnly: false,
		          buttonText: "달력"
		    });
		 	 */

	        $("#dataForm").validate({
	            rules: {
	                issuResn         : { required : true, maxlength : 100}
	            }
	           ,invalidHandler: function(event, validator){
	            }
	        }); 
		 });
	    // 조회버튼 클릭
	    var jsListSearch = function(){
	        document.searchForm.action = "BD_certifRequList.do";
		    document.searchForm.method = "POST";
		    document.searchForm.submit();
	    }

        // 계약결과 등록 화면 호출
        var jsMyCertifRequForm = function(){
            
            if(checkFormValue()){
                if(confirm("신청 하시겠습니까?")){
                    
                	if($("#radio_email:checked").val() == "E" ){
                	    $("#zip").val('');
                	    $("#req_address").val('');
                	    $("#req_address_d").val('');
                	}
                	
                	if($("#radio_mail:checked").val() == "Z" ){
                	    $("#email").val('');
                	}
	            document.dataForm.action = "BD_certifRequInsert.do";
	            document.dataForm.method = "POST";
	            document.dataForm.submit();
                }
            }
        }
		
        
        var checkFormValue = function(){
            //서비스명
            if($("#issuResn").val() == null || $("#issuResn").val() == ""){
                alert("발급사유를 입력해주세요.");
                $("#issuResn").focus();
                return false;
            }
            
            if($("#radio_email:checked").val() == "E" ){
                if($("#req_email").val() == null || $("#req_email").val() == ""){
	                alert("이메일을 입력해주세요.");
	                $("#email").focus();
	                return false;
                }
                
                var emailExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
                if(!emailExp.test($('#req_email').val())){
                     alert('이메일 형식으로 입력해주세요.');
                     $('#req_email').focus();
                     return;
                }
            }
           if($("#radio_mail:checked").val() == "Z" ){
                if($("#zip").val() == null || $("#zip").val() == ""){
	                alert("우편번호를 입력해주세요.");
	                $("#zip").focus();
	                return false;
                }
                
                if($("#req_address").val() == null || $("#req_address").val() == ""){
	                alert("주소를 입력해주세요.");
	                $("#req_address").focus();
	                return false;
                }
                
                if($("#req_address_d").val() == null || $("#req_address_d").val() == ""){
	                alert("상세주소을 입력해주세요.");
	                $("#req_address_d").focus();
	                return false;
                }
            }
            return true;
        }
        
        
        var jsZipcodePop = function (el, zcId, adr1, adr2) {    <%-- 주소찾기 팝업 호출 --%>
		 	$("#zipCodeId").val(zcId);
		    $("#baseAddrId").val(adr1);
		    $("#detailAddrId").val(adr2); 
		    var pop = window.open("/korean/pt/register/PD_jusoSearch.do","pop","top="+ (screen.height/2 - 230) +",left=" + (screen.width/2 - 285) + ",width=570,height=460, scrollbars=no");
		};
 
    </script>

</head>
<body>

	<div class="certifRequList2">
		<form name="searchForm" id="dataForm"  method="post"></form>
		<form name="dataForm" id="dataForm"  method="post">		
		<input type="hidden" id="zipCodeId" ><input type="hidden" id="baseAddrId" ><input type="hidden" id="detailAddrId" >
		 <div>
			<table class="tbl_st4">
				<tr>
					<th>발급사유</th>
					<td><input type="text" id="issuResn" name="issuResn" maxlength="200"></td>
				</tr>
				<tr>
					<th>이용실적증명서 발급방법</th>
					<td>
						<div class="request_how_select">
							<ul>
								<li class="radio_email">
									<p><input type="radio" id="radio_email" name="issuMth" checked="checked" value="E"><label for="radio_email">이메일 수신</label></p>
									<div>
										<input type="text" id="req_email" name="email" value="${sessionScope['__usk'].email}" title="이메일">
									</div>
								</li>
								<li class="radio_mail">
									<p><input type="radio" id="radio_mail" name="issuMth" value="Z"><label for="radio_mail">우편 발송</label></p>
									<div class="display_no">
										<input type="text" class="mailnum" id="zip" name="zip" readonly title="우편번호">
										<a href=""  onclick="jsZipcodePop(this,'zip','req_address','req_address_d');return false;" class="btns st3">우편번호 검색</a>
										<input type="text" class="req_address" id="req_address" name="bassAdres" readonly title="주소">
										<input type="text" class="req_address_d" id="req_address_d" name="detailAdres" title="상세줏소">
									</div>
								</li>
							</ul>
						</div>
					</td>
				</tr>
<!-- 				<tr>
					<th>발급요청기간</th>
					<td class="term">
						<input type="text" id="dPicker_1" name="issuRequstBeginDe"/> ~ <input type="text" id="dPicker_2" name="issuRequstEndDe" />
					</td>
				</tr> -->
			</table>
		</div>
		<div class="btnarea">
			<a href="javascript:;" onclick="jsMyCertifRequForm(); return false;" class="btns st1"> 신청 </a> 
		</div>
		
		<div>
			<p>총 <span>${pager.totalNum}</span>건 (금액 : <span id='totalamout'>000,000,000</span>원)</p>
		</div>
		<div class="list_st1">
			<table class="tbl_st1">
				<thead>
					<tr>
						<th>NO</th>
						<th>서비스명</th>
						<th>구분</th>
						<th>계약개시</th>
						<th>계약종료</th>
						<th>총 계약기간</th>
						<th>총 계약금액 (VAT포함)</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody>
				  	<c:set var="index" value="${pager.indexNo}"/>
	                <c:forEach items="${pager.list}" var="listData" varStatus="status">
	                 <input type="hidden" name="cntrctSvcSns" value="${listData.cntrctSvcSn}">
					<tr>
						<td>${index-status.index}</td>
						<td>${listData.goodsNm}</td>
						<td>${listData.goodsTyNm}</td>
						<td>${listData.cntrctBeginDe}</td>
						<td>${listData.cntrctEndDe}</td>
						<td>${listData.splyFromPeriod}</td>
						<td>
						<c:if test="${listData.sportAt eq 'Y' and listData.rlCntrctInsttAt eq 'Y'}" >0</c:if>
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
		</form>
		<div>
			<a href="javascript:;" onclick="javascript:jsListSearch();"  class="btns st1">목록</a>
		</div>
	</div>
</body>
</html>