<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>호환성 신청 및 확인 | 표준프레임워크 | 소개 | 씨앗 마켓</title>	
	<!-- 스크립트 영역 -->
	<op:jsTag type="spi" items="datepicker"/>
	<script type="text/javascript">
	//<CDATA[[
	
	
	  $().ready(function () {
	    
	    
	    $("#cmptbClCds").click(function(){
	      if($(this).is(":checked")){
	          $('input[name="q_cmptbClCds"]:checked').each(function (i) {
	              $(this).attr("checked",false);
	          });
	      } 
	    });$('input[name="q_cmptbClCds"]').click(function() {
	        if($(this).is(':checked')) {
	            $("#cmptbClCds").attr("checked",false);
	        }
	    });
	    
	    // 기간,발표일 달력 생성
	    $("span#egovPeriod a").click(function(){
	        var sType = $(this).attr('id');
	        var date = $('#q_endDate').val().replace(/\/|\-/g, "");
	        var yy = parseInt(date.substr(0, 4), 10);
	        var mm = parseInt(date.substr(4, 2), 10);
	        var dd = parseInt(date.substr(6, 2), 10);
	        var endDt = new Date(yy, mm - 1, dd);
	        var nowDt = new Date();
	        
	        switch(sType){
	            case '0' :
	                $('#q_beginDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
	                $('#q_endDate').val(nowDt.getFullYear() + '-' + prependZero(nowDt.getMonth()+1,2) + '-' + prependZero(nowDt.getDate(),2));
	                break;
	            case '7D':
	                endDt.setDate(endDt.getDate() - 7);
	                $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                break;
	            case '1M':
	                endDt.setMonth(endDt.getMonth() - 1);                    
	                $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                break;
	            case '3M':
	                endDt.setMonth(endDt.getMonth() - 3);
	                $('#q_beginDate').val(endDt.getFullYear() + '-' + prependZero(endDt.getMonth()+1,2) + '-' + prependZero(endDt.getDate(),2));
	                break;
	            default:
	                break;
	        }
	    });
	  
	    
	    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
	    $('#q_beginDate').datepicker({
	      dateFormat: 'yy-mm-dd',
	      showOn : 'button'
	    });
	    $('#q_endDate').datepicker({
	      dateFormat: 'yy-mm-dd',
	      showOn : 'button'
	    });
	    
	  });//ready end
	
	  var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
	    while(num.toString().length < len) {
	        num = "0" + num;
	    }
	    return num;
	}; //prependZero
	
	
	    
	  
	  //페이지 이동
	  var jsMovePage = function(page){
	      var p = 1;
	      if(page == 'page'){
	          p = $('input[name=page]').val();
	      }else{
	          p = page;
	      }
	      $("#dataForm input[name=q_currPage]").val(p);
	      $("#dataForm").submit();
	  };
	  
	  // get방식에서 -> post방식으로 수정 해야함.[한글 입력 파라미터 깨짐]
	  var jsSearch = function(){
	      $("#q_currPage").val(1);
	      $("#dataForm").attr("action","BD_index.do").submit();
	  };
	  
	  var jsClean = function(){
	    
	    $("#q_beginDate").val("2000-01-01");
	    $("#q_endDate").val("2100-12-31");
	    $("#q_searchVal").val("");
	  
	    $("#cmptbClCds").attr("checked",true);
	    $('input[name="q_cmptbClCds"]:checked').each(function (i) {
	        $(this).attr("checked",false);
	    });
	  };
	  
	  
	  var jsInsertForm = function(){
	      post_to_url("BD_insertForm.do",{});
	  };
	  
	  var jsView = function(vl){
	      post_to_url("BD_view.do",{"cmptbCnfirmRegstSeq":vl});
	  };
	  
	  
	  //Submit 전속 전송  (주소,파라메터,메소드)
	  function post_to_url(path, params, method) {
	      method = method || "post"; // Post:Get 전송 기본설정은 Post
	      
	      var form = document.createElement("form");
	      form.setAttribute("method", method);
	      form.setAttribute("action", path);
	  
	  
	      // 예  {"userId":"abcd","mgrId":"abcd"}
	      for(var key in params) {
	          var hiddenField = document.createElement("input");
	          hiddenField.setAttribute("type", "hidden");
	          hiddenField.setAttribute("name", key);
	          hiddenField.setAttribute("value", params[key]);
	   
	          form.appendChild(hiddenField);
	      }
	   
	      document.body.appendChild(form);
	      form.submit();
	  }
	
	//]]>
	  
	</script>
</head>
<body>	
	<form name="dataForm" id="dataForm" method="get" action="BD_index.do">

		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<div class="title-area">
				<h2>호환성 신청현황</h2>
			</div>
			<!-- //title-area -->

			<!-- section -->
			<div class="section">
				<div class="tab-search">
					<table>
						<caption>검색</caption>
						<colgroup>
						<col style="width:130px;"/>
						<col style="width:;"/>
						</colgroup>
						<tbody>
							<tr>
								<th>호환성 분석<br/>대상명</th>
								<td><input type="text" class="w650" id="q_searchVal" name="q_searchVal" value="${searchMap.q_searchVal}" title="호환성 분석 대상명 입력" /></td>
							</tr>
							<tr>
								<th>호환성 분류</th>
								<td>
									<span class="agree">
										<input type="checkbox" id="cmptbClCds" name="cmptbClCds" title="호환성 분류 전체"
										<c:if test="${fn:length(searchMap.q_cmptbClCds) == 0}">checked="checked"</c:if>/><label>전체</label>
	                                    <c:forEach items="${codeList}" var="_bean" varStatus="status">
	                                        <input type="checkbox" name="q_cmptbClCds" id="q_cmptbClCds_${_bean.prvCd}" title="호환성 분류 ${_bean.prvNm}"
	                                        <c:if test="${fn:contains(searchMap.q_cmptbClCds,_bean.prvCd)}">checked="checked"</c:if>
	                                        value="${_bean.prvCd}"/> <label>${_bean.prvNm}</label>
	                                    </c:forEach>
									</span>
								</td>
							</tr>
							<tr>
								<th>신청일</th>
								<td>
									<div class="calendar_input">
									  <input type="text" class="input" name="q_beginDate" id="q_beginDate" readonly="readonly" title="시작일 레이어 달력 열림" style="width:100px"
									  <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
									</div>
									<span class="divide"> ~ </span>
									<div class="calendar_input end">
									  <input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="종료일 레이어 달력 열림" style="width:100px"
									  <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
									</div>
									<span id="egovPeriod">
									    <a href="javascript:" id="0" class="b-btn mr05 type1"><strong><span>오늘</span></strong></a>
									    <a href="javascript:" id="7D" class="b-btn mr05 type1"><strong><span>1주일</span></strong></a>
									    <a href="javascript:" id="1M" class="b-btn mr05 type1"><strong><span>1개월</span></strong></a>
									    <a href="javascript:" id="3M" class="b-btn mr05 type1"><strong><span>3개월</span></strong></a>
                                    </span>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<!-- //section -->
			<!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="#;" class="b-btn search type2" onclick="jsSearch();"><strong><span>검 색</span></strong></a>
				<a href="#;" class="b-btn ml10 type1" onclick="jsClean(); jsSearch();"><strong><span>전체보기</span></strong></a>
			</div>
			<!-- //btn-area -->
			
			<!-- section -->
			<div class="section">
				<h3 class="stitle"></h3>

				<p class="total-count">총 <strong>${pager.totalNum}</strong>개</p>
				<!-- list -->
				<div class="type-list">
					<table>
						<caption></caption>
						<colgroup>
						<col style="width:60px;"/>
						<col style="width:*;"/>
						<col style="width:100px;"/>
						<col style="width:100px;"/>
						<col style="width:100px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>호환성 분석 대상명</th>
								<th>호환성 분류</th>
								<th>상태</th>
								<th>신청일</th>
							</tr>
						</thead>
						<tbody>
	                        <c:set var="index" value="${pager.indexNo}"/>
	                        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                        <tr>
	                            <td><span>${index-status.index}</span></td>
	                            <td class="title"><a href="#" onclick="jsView(${baseVo.cmptbCnfirmRegstSeq})">${baseVo.cmptbAnalsTrgetNm}</a></td>
	                            <td><span><c:out value="${baseVo.cmptbClNm}"/></span></td>
	                            <td><span><c:out value="${baseVo.cmptbStatus}"/></span></td>
	                            <td class="date"><span><c:out value="${baseVo.analsReqstDe}"/></span></td>
	                        </tr>
	                        </c:forEach>
	                        <op:no-data obj="${pager}" colspan="5" />
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- button -->
				<div class="btn-area mt20">
					<a href="#" class="b-btn registry type2" onclick="javascript:alert('준비중입니다.');"><strong><span>신청하기</span></strong></a>
				</div>
				<!-- //button -->

	            <!-- paging -->
	            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
	            <!-- //paging -->
			</div>
			<!-- //section -->

		</div>
		<!-- //contents -->

	
	</form>
</body>
</html>