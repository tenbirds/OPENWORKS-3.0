<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<!-- <script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script> -->
<script type="text/javascript">

  $().ready(function () {
    
    // 체크박스 제어
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

    <%--
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
    $('#q_beginDate').datepicker({
      dateFormat: 'yy-mm-dd',
      showOn : 'button'
    });
    $('#q_endDate').datepicker({
      dateFormat: 'yy-mm-dd',
      showOn : 'button'
    });
    --%>
    
    $("#q_beginDate, #q_endDate").datepicker({
        showOn: "both", 
        buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
        buttonImageOnly: false,
        dateFormat: 'yy-mm-dd',
        buttonText: "달력"
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
    document.dataForm.action = "BD_myQnaList.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
     $("#q_beginDate").val("2000-01-01");
     $("#q_endDate").val("2100-12-31");
     $("#q_searchKey").val("1001");
     $("#q_searchVal").val("");

     $("#goodsTyCds").attr("checked",true);
     $('input[name="q_goodsTyCds"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
  };
  

  var jsGoodsView = function(seq,urlNm, sn){
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm+ "|" + sn;
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
	<div class="supAdm">	
  	<form name="dataForm" id="dataForm" method="get" action="BD_myQnaList.do">
		<input type="hidden" name="q_searchKey" id="q_searchKey" value="1003">			
		<div class="schOpt">			
			<table class="tbl_st4" summary="서비스 검색">
				<caption>서비스 검색</caption>
				<colgroup>
					<col width="10%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
				<tr>
					<th scope="col">서비스명</th>
					<td class="unit">
						<i>
					      <label><input type="checkbox" name="goodsTyCds" id="goodsTyCds" value="" title="서비스리스트"
					       <c:if test="${fn:length(searchMap.q_goodsTyCds) == 0}">checked="checked"</c:if> /> 전체</label>
						      <c:forEach items="${codeList_goodsTy}" var="_bean" varStatus="status">
						          <label><input type="checkbox" name="q_goodsTyCds" id="q_goodsTyCds_${_bean.prvCd}" title="서비스리스트"
						              <c:if test="${fn:contains(searchMap.q_goodsTyCds,_bean.prvCd)}">checked="checked"</c:if>
						          value="${_bean.prvCd}"/> ${_bean.prvNm}</label>
						    	</c:forEach>
						</i>
						<div>
							<label><input type="text" id="q_searchVal"  name="q_searchVal"  title="서비스명 입력" value="<c:out value="${searchMap.q_searchVal}" />"></label>
						</div>   
					</td>
				</tr>
				<tr>
					<th scope="col">기간</th>
					<td class="term">
				        <label><input type="text" name="q_beginDate" id="q_beginDate"  readonly="readonly" title="검색 시작일 입력" "  style="width:100px" <c:if test="${not empty searchMap.q_beginDate}"> value="<c:out value='${searchMap.q_beginDate}' />"</c:if> /></label>
				      ~
				        <label><input type="text" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" "  style="width:100px" <c:if test="${not empty searchMap.q_endDate}"> value="<c:out value='${searchMap.q_endDate}' />"</c:if> /></label>
				        <a href="javascript:" id="d_0" class="btns st3">오늘</a>
						<a href="javascript:" id="d_7D" class="btns st3">1주일</a>
						<a href="javascript:" id="d_1M" class="btns st3">1개월</a>
						<a href="javascript:" id="d_3M" class="btns st3">3개월</a>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<div class="btnArea rig mtm20">
			<a href="javascript:;" onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
			<a href="javascript:;" onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>
		</div>
		<div class="list_st1">
			<p class="head">
				 <span class="totalcount">
				    <op:pagerParam page="param/webListPagerParam.jsp" />
				 </span>
				<%-- <span class="sel_box">
					<select>
						<option>20개식</option>
						<option>40개식</option>
						<option>60개식</option>
						<option>100개식</option>					
					</select>
				</span> --%>
			</p>
			<!-- list -->
			<table class="tbl_st1" summary="제공자 문의(Q&amp;A) 목록">
				<caption>제공자 문의(Q&amp;A) 목록</caption>
				<colgroup>
					<col width="5%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="row">번호</th>
						<th scope="row">서비스명</th>
						<th scope="row">답변상태</th>
						<th scope="row">문의제목</th>
						<th scope="row">문의성격</th>
						<th scope="row">문의일</th>
						<th scope="row">답변일</th>
					</tr>
				</thead>
				<tbody>
			      <c:set var="index" value="${pager.indexNo}" />
			      <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			        <tr>
			          <td class="num">${index-status.index }</td>
			          <td class="title">
			            <a href="javascript:" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','','')"><c:out value="${baseVo.goodsNm}" /></a>
			          </td>
			          <c:if test="${baseVo.answerSttusCd eq '1001'}"> 
			            <td><span class="condi_b">미답변</span></td>
			          </c:if>
			          <c:if test="${baseVo.answerSttusCd eq '1002'}">
			            <td><span class="condi_a">답변 완료</span></td>
			          </c:if>
			          <td class="title"><a href="javascript:" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','I', '${baseVo.goodsInqryNo}')"><c:out value="${baseVo.inqrySj}" /></a></td>
			          <c:if test="${baseVo.othbcAt eq 'N'}"> 
			            <td>공개</td>
			          </c:if>
			          <c:if test="${baseVo.othbcAt eq 'Y'}">
			            <td>비공개</td>
			          </c:if>
			          <td class="date"><c:out value="${baseVo.inqryDt}" /></td>
			          <td class="date"><c:out value="${baseVo.answerDt}" /></td>
			        </tr>
			        
			      </c:forEach>
			      <op:no-data obj="${pager}" colspan="7" />
		    	</tbody>
			</table>
			<!-- //list -->
		</div>
	
		
		<!-- paging  -->
		<div class="paging">
			<span><op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" /></span>
		</div> 
		<!--// paging  -->	
					
	  </form>
  </div>
  
</body>
</html>
