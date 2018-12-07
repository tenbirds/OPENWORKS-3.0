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
    
    //체크박스 제어
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
    $("span#evlPeriod  span a").click(function(){
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
    document.dataForm.action = "BD_myEvlList.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
     $("#q_beginDate").val("2000-01-01");
     $("#q_endDate").val("2100-12-31");
     $("#q_searchVal").val("");
     
          
     $("#goodsTyCds").attr("checked",true);
     $('input[name="q_goodsTyCds"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
  };
  
  
  
  var jsGoodsView = function(seq,urlNm){
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" + seq + "&pageUrlNm=" + urlNm;
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

<form name="dataForm" id="dataForm" method="get" action="BD_myEvlList.do">
<input type="hidden" name="q_searchKey" id="q_searchKey" title="컨설팅" value="1003">


  <section>  
  
  <!-- 구매내역 검색 영역 -->
  <fieldset>
  <legend><span>검색조건 입력</span></legend>
  <table class="tbl_list_input">
  <caption>
    <strong>서비스평 검색</strong>
    <details>
      <summary>검색 조건을 입력하는 서식입니다.</summary>
    </details>
  </caption>
  <colgroup>
    <col style="width:17%">
    <col>
  </colgroup>
  <tr>
    <th scope="row">서비스</th>
    <td>
      <input type="text" id="q_searchVal"  name="q_searchVal"  title="서비스명 입력" value="${searchMap.q_searchVal}"  style="width:310px;margin-right:10px;">
      
      <input type="checkbox" name="goodsTyCds" id="goodsTyCds" value="" title="서비스 리스트"
      <c:if test="${fn:length(searchMap.q_goodsTyCds) == 0}">checked="checked"</c:if> />전체&nbsp; 
      <c:forEach items="${codeList_goodsTy}" var="_bean" varStatus="status">
          <input type="checkbox" name="q_goodsTyCds" id="q_goodsTyCds_${_bean.prvCd}" title="서비스 리스트"
              <c:if test="${fn:contains(searchMap.q_goodsTyCds,_bean.prvCd)}">checked="checked"</c:if>
          value="${_bean.prvCd}"/> ${_bean.prvNm}&nbsp;
      </c:forEach>
    </td>
  </tr>
  <tr>
    <th scope="row">기간(문의일)</th>
      <td>
      <div class="calendar_input">
        <input type="text" class="input" name="q_beginDate" id="q_beginDate"  readonly="readonly" title="검색 시작일 입력" style="width:118px;" 
          <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
      </div>
      <span class="divide"> ~ </span>
      <div class="calendar_input end">
        <input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" style="width:118px;"
          <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
      </div>
      <span id="evlPeriod">
        <span class="btn_light_gray02"><a href="javascript:" id="d_0">오늘</a></span>
        <span class="btn_light_gray02"><a href="javascript:" id="d_7D">1주일</a></span>
        <span class="btn_light_gray02"><a href="javascript:" id="d_1M">1개월</a></span>
        <span class="btn_light_gray02"><a href="javascript:" id="d_3M">3개월</a></span>
      </span>
    </td>
  </tr>
  </table>
  
  <div class="search_input_btn">
    <div class="btn_navi">
        <a href="javascript:" onclick="jsSearch();"><span class="find">검색</span></a>
    </div>
    <div class="btn_navi_g">
        <a href="javascript:" onclick="jsClean(); jsSearch();"><span class="total">전체보기</span></a>
    </div>
  </div>  
  </fieldset>
  <!-- //구매내역 검색 영역 -->
  </section>
  
  <!-- 검색 리스트 영역 -->
  <section>
  <span class="totalcount">
    <op:pagerParam page="param/webListPagerParam.jsp" />
  </span>
  
  <!-- 목록 시작 -->
  <table class="tbl_list type_A">
    <caption>
      <strong>서비스평 검색 결과</strong>
      <details>
        <summary>번호, 서비스명, 내평가, 작성일 정보를 제공합니다.</summary>
      </details>
    </caption>
    <colgroup>
      <col style="width:45px">
      <col style="width:130px">
      <col style="width:85px">
      <col>
      <col style="width:110px">
    </colgroup>
    <thead>
      <tr>
        <th scope="col">번호</th>
        <th scope="col">서비스명</th>
        <th scope="col" colspan="2">내 평가</th>
        <th scope="col">작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:set var="index" value="${pager.indexNo}" />
      <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
        <tr>
          <td class="num">${index-status.index }</td>
          <td class="p_name">
            <a href="javascript:" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','')" ><c:out value="${baseVo.goodsNm}" /></a>
          </td>
          <td>
            <span><img src="/resources/web/theme/default/images/common/ico/ico_star_${baseVo.evlScore}.gif" alt="평가점수"></span>
            <span>${baseVo.evlScore}.0</span>
          </td>
          <td class="al">
            <a href="javascript:" onclick="jsGoodsView('<c:out value="${baseVo.goodsCode}" />','C')" ><c:out value="${baseVo.evlSntnc}" /></a>
            </td>
          <td class="date"><span><c:out value="${baseVo.registDt}" /></span></td>
        </tr>
      </c:forEach>
      <op:no-data obj="${pager}" colspan="5" />
  </table>
  <!-- //목록 끝 -->
  <!-- paging -->
    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
  <!-- //paging -->
  </section>
  <!-- //검색 리스트 영역 -->
  
</form>
</body>
</html>
