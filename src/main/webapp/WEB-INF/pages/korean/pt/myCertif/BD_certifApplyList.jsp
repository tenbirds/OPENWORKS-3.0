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
    	$(document).ready(function() {
			$("#q_beginDate, #q_endDate").datepicker({
			     showOn: "both", 
			     buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
			     buttonImageOnly: false,
			     buttonText: "달력"
			});
			
			
		      //기간,발표일 달력 생성
	        $("table.tbl_st4 a.btns").click(function(){
	            var sType = $(this).attr('id');
	            var date = $('#q_endDate').val().replace(/\/|\-/g, "");
	            var yy = parseInt(date.substr(0, 4), 10);
	            var mm = parseInt(date.substr(4, 2), 10);
	            var dd = parseInt(date.substr(6, 2), 10);
	            var endDt = new Date(yy, mm - 1, dd);
	            var nowDt = new Date();
	            
	            switch(sType){
	                case 'd_0' :
	                    $('#q_beginDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
	                    $('#q_endDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
	                    break;
	                case 'd_7D':
	                    endDt.setDate(endDt.getDate() - 7);
	                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                    break;
	                case 'd_1M':
	                    endDt.setMonth(endDt.getMonth() - 1);                    
	                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                    break;
	                case 'd_3M':
	                    endDt.setMonth(endDt.getMonth() - 3);
	                    $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                    break;
	                default:
	                    break;
	            }
	        });
    	});
    	
	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	        if($("#q_beginDate").val() > $("#q_endDate").val() || $("#q_beginDate").val().replace(/-/gi,"") > $("#q_endDate").val().replace(/-/gi,"")){
	            alert("기간이 맞지 않습니다.");
	            $("#q_beginDate").focus();
	            return false;
	        }
			if($("#q_beginDate").val() == "" && $("#q_endDate").val() != ""){
			    alert("검색 시작일 입력해 주세요.");
	            $("#q_beginDate").focus();
	            return false;
			}
			if($("#q_beginDate").val() != "" && $("#q_endDate").val() == ""){
			    alert("검색 종료일 입력해 주세요.");
	            $("#q_endDate").focus();
	            return false;
			}
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "BD_certifApplyList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }
	    var jsSearchAllAction = function() {
	        $("#q_issuSttus").val("");
		 	$("#q_beginDate").val(""); 
		 	$("#q_endDate").val(""); 
		 	jsListSearch();
	    }
	    //페이징 
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
	    
	    var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
	        while(num.toString().length < len) {
	            num = "0" + num;
	        }
	        return num;
	    }; //prependZero
       
    </script>

</head>
<body>
	<div class="conWrap">
		<form name="dataForm" id="dataForm">
	  	<input type="hidden" name="q_currPage"  id="q_currPage" /> <!--  현재 페이지 -->
	        
			<!-- search -->
			<div class="schOpt on">				
				<table class="tbl_st4" summary="이용실적증명서 발급 신청 검색">
				<caption>이용실적증명서 발급 신청 검색</caption>
				<colgroup>
					<col width="10%"/>
					<col width="*"/>
				</colgroup>
				<thead hidden="hidden">
					<tr>
						<th colspan="2" scope="col">이용실적증명서 발급 신청 검색</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row">진행상태</th>
	          	<td>
	            	<span class="sel_box">
	                	<select name="q_issuSttus" id="q_issuSttus" title="진행상태  선택" >
	                		<option value="" <c:if test="${param.q_mberDateSearch == ''}"> selected="selected" </c:if>>전체</option>
			                <option value="1001" <c:if test="${param.q_issuSttus == '1001'}"> selected="selected" </c:if>>신청</option>
			                <option value="1003" <c:if test="${param.q_issuSttus == '1003'}"> selected="selected" </c:if>>발급</option>
			                <option value="1002" <c:if test="${param.q_issuSttus == '1002'}"> selected="selected" </c:if>>발급반려</option>
						</select><label for="q_issuSttus"></label>
		                </span>
	            	</td>
				</tr>
				<tr>
					<th scope="row">발급신청일</th>
					<td class="term">
						<input type="text" id="q_beginDate" name="q_beginDate" title="검색 시작일 입력" style="width:100px" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> /><label for="q_beginDate"></label>
		        ~ 
		        <input type="text" id="q_endDate" name="q_endDate" title="검색 종료일 입력" style="width:100px" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> /> <label for="q_endDate"></label>
						<a href="#none" id="d_0"  class="btns st3" title="오늘">오늘</a>
						<a href="#none" id="d_7D" class="btns st3" title="1주일">1주일</a>
						<a href="#none" id="d_1M" class="btns st3" title="1개월">1개월</a>
						<a href="#none" id="d_3M" class="btns st3" title="3개월">3개월</a>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="#none" onclick="javascript:jsListSearch(1);" class="btns st5 icn icnSearch">검 색</a>
			<a href="#none" onclick="jsSearchAllAction();" 				class="btns st5">전체보기</a>
		</div>
		<!-- //search -->
		
		<div class="list_st1">
			<p class="head">
				<span>총 ${pager.totalNum}개</span>
			</p>
			<table class="tbl_st1" summary="이용실적증명서 발급 목록">
				<caption>이용실적증명서 발급 목록</caption>
				<colgroup>
					<col width="5%"/>
					<col width="*"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
					<col width="20%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="row">번호</th>
						<th scope="row">발급사유</th>
						<th scope="row">진행상태</th>
						<th scope="row">발급방식</th>
						<th scope="row">발급신청일</th>
						<th scope="row">발송일</th>
					</tr>
				</thead>
				<tbody>
				<c:set var="index" value="${pager.indexNo}"/>
				<c:forEach items="${pager.list}" var="listData" varStatus="status">
					<c:choose>
						<c:when test="${listData.issuSttusNm eq '실적증명요청'}">
            	<c:set var="color" value="red" />
            </c:when>
            <c:when test="${listData.issuSttusNm eq '발급완료'}">
            	<c:set var="color" value="blue" />
            </c:when>
            <c:otherwise>
            	<c:set var="color" value="black" />
            </c:otherwise>
          </c:choose>
                          
					<tr>
						<td>${index-status.index}</td>
						<td class="lef"><a href="BD_certifApplyDetail.do?rouSn=${listData.rouSn}">${listData.issuResn}</a></td>
						<td style="color : ${color}">${listData.issuSttusNm}</td>
						<td>${listData.issuMthNm}</td>
						<td>${listData.registDt}</td>
						<td><c:if test="${listData.issuSttus eq '1003'}">${listData.sndngDe}</c:if></td>
					</tr>
				</c:forEach>
				<!-- 데이터가 없을 때 알림 문구 -->
				<c:if test="${empty pager.list}">
					<op:no-data obj="${pager}" colspan="6" />
				</c:if>
				</tbody>
					</table>	
				</div>
					
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
		</form>
	</div>
		
</body>
</html>