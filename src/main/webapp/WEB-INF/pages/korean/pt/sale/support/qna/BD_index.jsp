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
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />

<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">


  $().ready(function () {
    
     $("#exttbl").hide();
    //상태 체크
    $('input:radio[name="q_answerSttusCd"]').filter('[value="${searchMap.q_answerSttusCd}"]').attr('checked', true);
    
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

    
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
    $('#q_beginDate').datepicker({
      dateFormat: 'yy-mm-dd',
      buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
      showOn : 'button'
    });
    $('#q_endDate').datepicker({
      dateFormat: 'yy-mm-dd',
      buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
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
     $('input:radio[name="q_answerSttusCd"]').filter('[value=""]').attr('checked', true);
     
     $('input[name="q_langCodes"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
     $("#goodsTyCds").attr("checked",true);
     $('input[name="q_goodsTyCds"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
  };
    
  var jsGoodsView = function(seq,urlNm){
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm;
  };
  
  var jsView = function(el,seq,type){
    
    var type = (type == "1001" ? "답변등록" : "답변수정");
    $(el).colorbox({
        title : type,
        href : "PD_insertForm.do?goodsInqryNo=" + seq,
        width : "778",
        height: "490",
        iframe: true
    });
  };
  
  var jsRegistView = function(el,id){
    $(el).colorbox({
        title : "회원정보",
        href : "/${_pathLang}/pt/popup/PD_userView.do?userId=" + id,
        width : "510",
        height: "300",
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

	<form name="dataForm" id="dataForm" method="get" action="BD_index.do">

	  <!-- 구매내역 검색 영역 -->
	<div class="supAdm">				
		<div class="schOpt">				
			<table class="tbl_st4" summary="Q&amp;A 관리">		
			<caption>Q&amp;A 검색</caption>
			<colgroup>
			<col style="width:130px;"/>
			<col style="width:;"/>
			</colgroup>
			
			<tbody>
			  <tr>
			    <th scope="row">검색어</th>
			    <td>
					<!-- select box -->
					<div class="sel_box">
						<select id="q_searchKey" name="q_searchKey" title="카테고리 선택">
						  <option value="1001" <c:if test="${empty searchMap.q_searchKey || searchMap.q_searchKey eq '1001' }">selected="selected"</c:if> >문의제목</option>
				          <option value="1002" <c:if test="${searchMap.q_searchKey eq '1002' }">selected="selected"</c:if> >문의자</option>
				          <option value="1003" <c:if test="${searchMap.q_searchKey eq '1003' }">selected="selected"</c:if> >서비스명</option>
						</select><label for="q_searchKey"></label>
					</div>
					<label><input type="text" id="q_searchVal" name="q_searchVal" title="검색어 입력" value="${searchMap.q_searchVal}" style="width:310px;margin-right:10px;margin-left:10px;"></label>
					<!-- //select box -->
				</td>
			  </tr>
			  <tr>
			    <th scope="row">문의일자</th>
				<td class="term">
					<label><input type="text" class="input" name="q_beginDate" id="q_beginDate" readonly="readonly" title="검색 시작일 입력" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> /></label>
					 ~
					<label><input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> /></label>
					<a href="javascript:" id="d_0" class="btns st3">오늘</a>	
					<a href="javascript:" id="d_7D" class="btns st3">1주일</a>			      
					<a href="javascript:" id="d_1M" class="btns st3">1개월</a>			      
					<a href="javascript:" id="d_3M" class="btns st3">3개월</a>			      		      
			    </td>
			  </tr>
			  <tr>
			    <th scope="row">상태</th>
			    <td>
			      <span class="agree">
			      <label><input type="radio" name="q_answerSttusCd" id="total"    value="" checked="checked" title="상태 전체" />전체</label>
			      <label><input type="radio" name="q_answerSttusCd" id="standby"  value="1001" title="상태 대기"  />대기</label>
			      <label><input type="radio" name="q_answerSttusCd" id="complete" value="1002" title="상태 완료" />완료</label>
			     	</span>
			  </tr>
		  	</table>
		  
			<div class="schOpt">		    
		    <table  class="tbl_st4" summary="Q&A 관리 현황">
		    	<caption>Q&amp;A 관리 현황</caption>
		    	<colgroup>
		    		<col width="10%"/>
		    		<col width="*"/>
		    	</colgroup>
		    	<tbody>
		    	<tr class="toggle">
		      <th scope="row">인증구분</th>
		      <td>
		        <label><input type="checkbox" name="goodsTyCds" id="goodsTyCds" value="" title="구분 리스트" <c:if test="${fn:length(searchMap.q_goodsTyCds) == 0}">checked="checked"</c:if> />전체</label>&nbsp;&nbsp;&nbsp;&nbsp;
		        <c:forEach items="${codeList_goodsTy}" var="_bean" varStatus="status">
		            <label><input type="checkbox" name="q_goodsTyCds" id="q_goodsTyCds_${_bean.prvCd}" title="언어 리스트" <c:if test="${fn:contains(searchMap.q_goodsTyCds,_bean.prvCd)}">checked="checked"</c:if> value="${_bean.prvCd}"/> ${_bean.prvNm}</label>&nbsp;&nbsp;&nbsp;&nbsp;
		        </c:forEach>        
		    </tr>
		    </tbody>
		    </table>
		  </div>
            <!--  a href="#" class="exSch">확장검색</a --> 

			<div class="btnArea rig mtm20">
				<a href="javascript:" onclick="jsSearch();"  class="btns st5 icn icnSearch">검색</a >
				<a href="javascript:" onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>
			</div>			
			<!-- //btn-area -->  
		  </div>
		  </div>
		  <!-- //구매내역 검색 영역 -->
		 
		  
		  <!-- 검색 리스트 영역 -->
			  <div class="section">
		    	<h3 class="stitle"></h3>
		        <div class="mt-15 fr">
    				<div class="sel_box">
          			 	<select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" onchange="this.form.submit()" >
		               		<option value="20" <c:if test="${20 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>20 개씩</option>
		               		<option value="40" <c:if test="${40 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>40 개씩</option>
		               		<option value="60" <c:if test="${60 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>60 개씩</option>
		               		<option value="100" <c:if test="${100 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>100 개씩</option>
          			 	</select><label for="q_rowPerPage"></label>
			   		</div>
		       </div>
        <op:pagerParam page="param/webListPagerParam.jsp" />
		  
		  <!-- 목록 시작 -->
		  <div class="type-list">
		  <table>
		    <caption>
		      <strong>서비스Q&amp;A 검색 결과 목록</strong>
		      <details>
		        <summary>번호, 서비스명, 문의제목, 문의자, 상태, 문의일자, 답변일자 정보를 제공합니다.</summary>
		      </details>
		    </caption>
		    <colgroup>
				<col style="width:45px">
				<col style="width:242px">
				<col style="width:45px">
				<col style="width:315px">
				<col style="width:90px">
				<col style="width:200px">
		    </colgroup>
		    <thead>
		<tr>
 		        <th scope="col">번호</th>
		        <th scope="col">문의제목</th> 
		        <th scope="col">답변상태</th>  
		        <th scope="col">서비스명</th> 
		        <th scope="col">문의자</th>  
		        <th scope="col">문의일자<br /> 답변일자</th>  
		      </tr>    
			  <!-- 20170101 구분, 언어 필드삭제 -->
			  <!--<tr>
 		        <th scope="col">번호</th>
		        <th scope="col">구분</th>
		        <th scope="col">서비스명</th>  
		        <th scope="col">언어</th> 
		        <th scope="col">문의제목</th> 
		        <th scope="col">문의자</th>  
		        <th scope="col">상태</th> 
		        <th scope="col">문의일자<br /> 답변일자</th>  
		      </tr> -->
		    </thead>
		    <tbody>
		      <c:set var="index" value="${pager.indexNo}" />
		      <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		        <tr>
		          <td>${index-status.index }</td>
		          <%-- <td>${baseVo.langNm}</td> --%>
		          <td><a href="javascript:" onclick="jsView(this,'${baseVo.goodsInqryNo}','${baseVo.answerSttusCd}')">${baseVo.inqrySj}</a></td>
		          <c:if test="${baseVo.answerSttusCd eq '1001'}"> 
		          <td><span class="condi_d">대기</span></td>
		          </c:if>
		          <c:if test="${baseVo.answerSttusCd eq '1002'}">
		          <td><span class="condi_a">완료</span></td>
		          </c:if>		          
		          <%-- <td>${baseVo.ctgryClNm}</td> --%>		          
		          <!-- <td class="title"> -->
		          <td>
		            <a href="javascript:" onclick="jsGoodsView('${baseVo.goodsCode}','')">${baseVo.goodsNm}
		              <c:if test="${baseVo.othbcAt eq 'Y'}">
		                <img src="/resources/web/theme/default/images/common/ico/ico_close.gif" alt="비공개" class="va">
		              </c:if> 
		            </a>
		          </td>
		          <td>
		            <span><a href="javascript:" onclick="jsRegistView(this,'${baseVo.inqrId}')" >${baseVo.inqrNm}</a></span>
		            <span>(${baseVo.inqrId})</span>
		          </td>
		          <c:if test="${baseVo.answerSttusCd eq '1001'}"> 
		            <td class="date"><span>${baseVo.inqryDt}</span></td>
		          </c:if>
		          <c:if test="${baseVo.answerSttusCd eq '1002'}">
		          <td class="date">
		            <div>${baseVo.inqryDt}</div>
		            <div>${baseVo.answerDt}</div>
		          </td>
		        </c:if>
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

