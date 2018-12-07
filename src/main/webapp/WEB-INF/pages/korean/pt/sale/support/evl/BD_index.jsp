<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">
	
  $().ready(function () {
      $("#exttbl").hide();
    //언어 체크박스 제어
    $("#langCodes").click(function(){
        if($(this).is(":checked")){
            $('input[name="q_langCodes"]:checked').each(function (i) {
                $(this).attr("checked",false);
            });
        } 
    });$('input[name="q_langCodes"]').click(function() {
        if($(this).is(':checked')) {
            $("#langCodes").attr("checked",false);
        }
    });
    
    $("#goodsTyCds").click(function(){
      if($(this).is(":checked")){
          $('input[name="q_goodsTyCds"]:checked').each(function (i) {
              $(this).attr("checked",false);
          });
      } 
    });$('input[name="q_goodsTyCds"]').click(function() {
        if($(this).is(':checked')) {
            $("#goodsTyCds").attr("checked",false);
        }
    });
    
    //언어 값이 있으면 언어검색 활성화
    <c:if test="${fn:length(searchMap.q_langCodes) > 0}">
      $(".ext_table .btn_ext a span").attr("class","on");
      $("#exttbl").show();
    </c:if>
    
    //구분 값이 있으면 언어검색 활성화
    <c:if test="${fn:length(searchMap.q_goodsTyCds) > 0}">
      $(".ext_table .btn_ext a span").attr("class","on");
      $("#exttbl").show();
    </c:if>
    
   
    //기간,발표일 달력 생성
    $("table.tbl_list_input a.b-btn").click(function(){
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
    
    
    
  }); //ready

  var prependZero = function(num, len) { // 지정한 수만큼 0 채우기 
      while(num.toString().length < len) {
          num = "0" + num;
      }
      return num;
  }; //prependZero
  
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
  
  var jsSearch = function(){
    document.dataForm.action = "BD_index.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
     $("#q_beginDate").val("2000-01-01");
     $("#q_endDate").val("2100-12-31");
     $("#q_searchKey").val("1001");
     $("#q_searchVal").val("");
     $("#langCodes").attr("checked",true);
     
     $('input[name="q_langCodes"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
     $("#goodsTyCds").attr("checked",true);
     $('input[name="q_goodsTyCds"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
  };
  
  
  
  var jsGoodsView = function(seq,urlNm){
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm;
  };
    
  var jsRegistView = function(el,id){
    $(el).colorbox({
        title : "회원정보",
        href : "/${_pathLang}/pt/popup/PD_userView.do?userId=" + id,
        width : "500",
        height: "450",
        iframe: true
    });
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
  };

</script>
</head>
<body>
<div class="contents">
	<!-- title-area -->
	<div class="title-area">
		<h2>리뷰 관리</h2>
	</div>
	<!-- //title-area -->
		<form name="dataForm" id="dataForm" method="get" action="BD_index.do">
		  <!-- 구매내역 검색 영역 -->
		  
        <legend><span>검색조건 입력</span></legend>
		<!-- section -->
		<div class="section">
		<div class="tab-search">
		<table class="tbl_list_input">
			<caption>검색</caption>
			<colgroup>
			<col style="width:130px;"/>
			<col style="width:;"/>
			</colgroup>
			<tbody>
			  <tr>
			    <th scope="row">검색어</th>
			    <td>
				<div class="select-area">
					<!-- select box -->
					<div class="sech_form">
						<div class="cont_wrap">
							<div class="selected">
								<div class="select" style="float:left;width:140px;">
									<select id="q_searchKey" name="q_searchKey" title="카테고리 선택" style="width:120px;z-index:5">
							          <option value="1001" <c:if test="${empty searchMap.q_searchKey || searchMap.q_searchKey eq '1001' }">selected="selected"</c:if> >서비스명</option>
							          <option value="1003" <c:if test="${searchMap.q_searchKey eq '1003' }">selected="selected"</c:if> >평가글</option>
							        </select>
							    	</div> </div>
									<input type="text" id="q_searchVal" name="q_searchVal" title="검색어 입력" value="${searchMap.q_searchVal}" style="width:310px;margin-right:10px;margin-left:10px;">
								</div>
							</div>		
						</div>
					</div>
					<!-- //select box -->
				</td>
			  </tr>
			  <tr>
			    <th scope="row">문의일자</th>
			    <td>
			      <div class="calendar_input">
			        <input type="text" class="input" name="q_beginDate" id="q_beginDate"  readonly="readonly" title="검색 시작일 입력" style="width:100px;" 
			            <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
			      </div>
			      <span class="divide"> ~ </span>
			      <div class="calendar_input end">
			        <input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" style="width:100px;"
			          <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
			      </div>
				      <a href="javascript:" id="0" class="b-btn mr05 type1"><strong><span>오늘</span></strong></a>
					  <a href="javascript:" id="7D" class="b-btn mr05 type1"><strong><span>1주일</span></strong></a>
					  <a href="javascript:" id="1M" class="b-btn mr05 type1"><strong><span>1개월</span></strong></a>
					  <a href="javascript:" id="3M" class="b-btn mr05 type1"><strong><span>3개월</span></strong></a>
			    </td>
			  </tr>
		  </table>
		  
		  <div class="ext_table">
		    
		    <table id="exttbl" >
		    <caption>
		      <strong>검색조건 확장</strong>
		      <details>
		        <summary>확장 검색 조건을 입력하는 서식입니다.</summary>
		      </details>
		    </caption>
		    <colgroup>
		      <col style="width:16%">
		      <col>
		    </colgroup>
<!-- 
		    <tr>
		      <th scope="row">언어</th>
		      <td>
		        <input type="checkbox" name="langCodes" id="langCodes" value="" title="언어 리스트"
		        <c:if test="${fn:length(searchMap.q_langCodes) == 0}">checked="checked"</c:if> />전체&nbsp;&nbsp;&nbsp;&nbsp;
		        <c:forEach items="${codeList_lang}" var="_bean" varStatus="status">
		            <input type="checkbox" name="q_langCodes" id="q_langCode_${_bean.langCode}" title="언어 리스트"
		                <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
		            value="${_bean.langCode}"/> ${_bean.langNm}&nbsp;&nbsp;&nbsp;&nbsp;
		        </c:forEach>
		      </td>
		    </tr>
-->
		    <tr>
		      <th scope="row">인증구분</th>
		      <td>
		        <input type="checkbox" name="goodsTyCds" id="goodsTyCds" value="" title="구분 리스트"
		        <c:if test="${fn:length(searchMap.q_goodsTyCds) == 0}">checked="checked"</c:if> />전체&nbsp;&nbsp;&nbsp;&nbsp;
		        <c:forEach items="${codeList_goodsTy}" var="_bean" varStatus="status">
		            <input type="checkbox" name="q_goodsTyCds" id="q_goodsTyCds_${_bean.prvCd}" title="언어 리스트"
		                <c:if test="${fn:contains(searchMap.q_goodsTyCds,_bean.prvCd)}">checked="checked"</c:if>
		            value="${_bean.prvCd}"/> ${_bean.prvNm}&nbsp;&nbsp;&nbsp;&nbsp;
		        </c:forEach>        
		    </tr>
		    </table>
		    <!-- p class="btn_ext">
                <a href="#ToggleEvent" class="arrow bottom"><span class="off">확장검색</span></a>
            </p -->
		  </div>
		  	<!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="javascript:" onclick="jsSearch();" class="b-btn search type2"><strong><span>검 색</span></strong></a><a href="javascript:" onclick="jsClean(); jsSearch();" class="b-btn ml10 type1"><strong><span>전체보기</span></strong></a>
			</div>
			<!-- //btn-area -->  
		  </div>
		  </div>
		  <!-- //구매내역 검색 영역 -->
		 
		  
		  <!-- 검색 리스트 영역 -->
			  <div class="section">
		    	<h3 class="stitle"></h3>
		        <div class="mt-15 fr">
			        <div class="select-area">
					<!-- select box -->
					<div class="sech_form">
						<div class="cont_wrap">
							<div class="selected">
		     				 <div class="select list" style="width:100px;">
			          			 <select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" style="width: 100px; z-index: 5; position: absolute; left: -100000px; height: auto;" onchange="this.form.submit()" >
					               <option value="20" <c:if test="${20 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>20 개씩</option>
					               <option value="40" <c:if test="${40 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>40 개씩</option>
					               <option value="60" <c:if test="${60 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>60 개씩</option>
					               <option value="100" <c:if test="${100 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>100 개씩</option>
			          			 </select>
						      </div>
						    </div>
					      </div>
				       </div>
			       </div>
		       </div>
        <op:pagerParam page="param/webListPagerParam.jsp" />
		  
		  <!-- 목록 시작 -->
		  <div class="type-list">
		  <table>
		    <caption>
		      <strong>서비스Q&amp;A 검색 결과 목록</strong>
		      <details>
		        <summary>번호, 구분, 서비스명, 문의제목, 문의자, 상태, 문의일자, 답변일자 정보를 제공합니다.</summary>
		      </details>
		    </caption>
		    <colgroup>
		      <col style="width:45px">
		      <%-- <col style="width:70px">
		      <col>
		      <col style="width:70px">
		      <col style="width:85px"> --%>
		      <col style="width:*">
		      <col style="width:90px">
		      <col style="width:80px">
		    </colgroup>
		    <thead>
		      <tr>
		        <th scope="col">번호</th>
		        <!-- <th scope="col">구분</th>
		        <th scope="col">서비스명</th>
		        <th scope="col">언어</th>
		        <th scope="col">평점</th> -->
		        <th scope="col">평가글</th>
		        <th scope="col">작성자</th>
		        <th scope="col">작성일</th>
		      </tr>
    		</thead>
		    <tbody>
		      <c:set var="index" value="${pager.indexNo}" />
		      <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		        <tr>
		          <td>${index-status.index }</td>
		          <%-- <td>${baseVo.ctgryClNm}</td>
		          <td class="title">
		            <a href="javascript:" onclick="jsGoodsView('${baseVo.goodsCode}','')">${baseVo.goodsNm}</a>
		          </td>
		          <td>${baseVo.langNm}</td>
		          <td>
		            <span><img src="/resources/web/theme/default/images/common/ico/ico_star_${baseVo.evlScore}.gif" alt="평가점수"></span>
		            <span>${baseVo.evlScore}.0</span>
		          </td> --%>
		          <td class="title">
		            <a href="javascript:" onclick="jsGoodsView('${baseVo.goodsCode}','C')" target="_blank" >${baseVo.evlSntnc}</a>
		          
		            </td>
		          <td>
		            <span><a href="javascript:" onclick="jsRegistView(this,'${baseVo.registId}')" >${baseVo.registNm}</a></span>
		            <span>(${baseVo.registId})</span>
		          </td>
		          <td><span>${baseVo.registDt}</span></td>
		        </tr>
		      </c:forEach>
		      <op:no-data obj="${pager}" colspan="8" />
		    </tbody>
		  </table>
		  </div>
		  <!-- //목록 끝 -->
		  
		  <!-- paging -->
		  <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
		  <!-- //paging -->
		  <!-- //검색 리스트 영역 -->
		  </div>
		</form>
</div>
</body>
</html>
