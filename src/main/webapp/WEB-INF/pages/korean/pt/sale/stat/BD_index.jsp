<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
    <title>판매통계 | 판매하기 | 씨앗 마켓</title>
	<!-- 스크립트 영역 -->
	<op:jsTag type="spi" items="datepicker"/>

<script type="text/javascript">
var ctgryCd1 = "${param.q_ctgryCd1}";
var ctgryCd2 = "${param.q_ctgryCd2}";
var ctgryCd3 = "${param.q_ctgryCd3}";

$().ready(function () {  

    //기본 카테고리(세팅)
    jsCtgryList(1,null);
    
    
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
    
    //언어 값이 있으면 확장검색 활성화
//     <c:if test="${fn:length(searchMap.q_langCodes) > 0}">
//       $(".ext_table .btn_ext a span").attr("class","on");
//       $("#exttbl").show();
//     </c:if>
    
    //노출 값이 있으면 확장검색 활성화
//     <c:if test="${fn:length(searchMap.q_goodsRegistSttus) > 0}">
//       $(".ext_table .btn_ext a span").attr("class","on");
//       $("#exttbl").show();
//     </c:if>
    
    //인증구분 체크박스 제어
    $("#crtfcCodes").click(function(){
      if($(this).is(":checked")){
          $('input[name="q_crtfcCodes"]:checked').each(function (i) {
              $(this).attr("checked",false);
          });
      } 
    });$('input[name="q_crtfcCodes"]').click(function() {
        if($(this).is(':checked')) {
            $("#crtfcCodes").attr("checked",false);
        }
    });
    
    //인증구분 값이 있으면 확장검색 활성화
//     <c:if test="${fn:length(searchMap.q_crtfcCodes) > 0}">
//       $(".ext_table .btn_ext a span").attr("class","on");
//       $("#exttbl").show();
//     </c:if>
    
    
    //기간,발표일 달력 생성
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
  
  var jsMoveSelected = function(page) {
      alert(page);
      
      $("#dataForm").submit();
  };
  
  
  // 카테고리 검색
  var jsCtgryList = function(el ,vl){
    
    var url = "ND_ctgryList.do?";
    url+= "goodsTyCd=" + $("#q_goodsTyCd").val();
    url+= "&ctgryCd=" + vl
    url+= "&ctgryDp=" + el;

    //선택값초기화
    var innerHtml = '<option value="">선택</option>';
    switch(el){
        case 1 : $("#q_ctgryCd1,#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).trigger("change");
        case 2 : $("#q_ctgryCd2,#q_ctgryCd3").html("").append(innerHtml).trigger("change");
        case 3 : $("#q_ctgryCd3").html("").append(innerHtml).trigger("change");
        default : break;
    } 
    
    if(vl == ""){return;}
    
    $.post(url , 
    function(response){
        if(response.length > 0){
            var innerHtml2 = '';
            //$("#q_ctgryCd"+el).removeAttr('disabled');
            for (var i = 0; i < response.length; i++) {
                innerHtml2 += '<option value="'+response[i].ctgryCd+'">'+response[i].ctgryNm+'</option>';
            }
            $("#q_ctgryCd"+el).append(innerHtml2);
        }
        
        switch(el){
        case 1 :
            if($("#q_ctgryCd1 option").length > 1){
                $("#q_ctgryCd1").val(ctgryCd1).attr("selected", "selected").trigger("change"); ctgryCd1 = "";                    
            }
        case 2 :
            if($("#q_ctgryCd2 option").length > 1){
                $("#q_ctgryCd2").val(ctgryCd2).attr("selected", "selected").trigger("change"); ctgryCd2 = "";
            }
        case 3 :
            if($("#q_ctgryCd3 option").length > 1){
                $("#q_ctgryCd3").val(ctgryCd3).attr("selected", "selected").trigger("change"); ctgryCd3 = "";
            }
        default : break;
        }
    });
    
  };
  
  var jsSearch = function(){
    document.dataForm.action = "BD_index.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
     $("#q_beginDate").val("2000-01-01");
     $("#q_endDate").val("2100-12-31");
     $("#q_searchVal").val("");
     
     $("input:radio[name='q_goodsRegistSttus']:radio[value='']").attr("checked",true);
     
     $("#langCodes").attr("checked",true);
     $('input[name="q_langCodes"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
     $("#crtfcCodes").attr("checked",true);
     $('input[name="q_crtfcCodes"]:checked').each(function (i) {
         $(this).attr("checked",false);
     });
     
     $("#q_goodsTyCd").val("").trigger("change");
     
  };
  
  var jsGoodsView = function(seq,urlNm){
    /* location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm; */
    /* {{ BH, 2015.12.28 소스수정 */
        location.href = "/korean/pt/store/inc/BD_storeView.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm;
    /* }} */    
  };

  var jsView = function(vl){
      $("#goodsCode").val(vl);
      document.dataForm.action = "BD_goodsView.do";
      document.dataForm.submit();
  };

  var jsExcelList = function() {
      location.href = "INC_EXCEL.do?" + $("#dataForm").serialize();
  };
</script>
</head>
<body>
    <form name="dataForm" id="dataForm" method="post" action="BD_index.do">
        <input type="hidden" name="q_currPage"  id="q_currPage"  value="<c:out value="${param.q_currPage}" />" />
        <%-- <input type="hidden" name="q_sortName"  id="q_sortName"  value="<c:out value="${param.q_sortName}" />" />
        <input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value="${param.q_sortOrder}" />" /> --%>
        <input type="hidden" name="q_init"      id="q_init"      value="<c:out value="${param.q_init}" />" />
        <input type="hidden" name="goodsCode"   id="goodsCode"   value="" />
    
		<!-- contents -->
		<div class="contents">
			<!-- title-area -->
			<div class="title-area">
				<h2>판매통계</h2>
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
								<th>카테고리</th>
								<td>
									<!-- static select -->
									<div class="select-area">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
													<op:code id="q_goodsTyCd" grpCd="1005" option="style='width:120px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
												</div>
											</div>
										</div>
										<!-- //select box -->
									</div>
									<!-- //static select -->
									
									<!-- static select -->
									<div class="select-area">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
                                                       <select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" style="width:115px;z-index:5" onchange="jsCtgryList(2,this.value)">
                                                           <option value="">선택</option>
                                                       </select>
												</div>
											</div>
										</div>
										<!-- //select box -->
									</div>
									<!-- //static select -->
									
									
									<!-- static select -->
									<div class="select-area">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
                                                       <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" style="width:115px;z-index:5" onchange="jsCtgryList(3,this.value)">
                                                           <option value="">선택</option>
                                                       </select>
												</div>
											</div>
										</div>
										<!-- //select box -->
									</div>
									<!-- //static select -->
									
									<!-- static select -->
									<div class="select-area">
										<!-- select box -->
										<div class="sech_form">
											<div class="cont_wrap">
												<div class="selected">
                                                       <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" style="width:115px;z-index:5">
                                                           <option value="">선택</option>
                                                       </select>
												</div>
											</div>
										</div>
										<!-- //select box -->
									</div>
									<!-- //static select -->

								</td>
							</tr>
							
							<tr>
								<th>서비스명</th>
								<td>
								    <input type="text" class="w650" name="q_searchVal" id="q_searchVal" value="<c:out value='${searchMap.q_searchVal}'/>" title="서비스명 입력" />
								    <input type="hidden" name="q_searchKey" id="q_searchKey" value="1001"/>
								</td>
							</tr>
							
							<tr>
								<th>기간</th>
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
				<a href="#" class="b-btn search type2" onclick="jsSearch();"><strong><span>검 색</span></strong></a>
			</div>
			<!-- //btn-area -->
			
			<!-- section -->
			<div class="section">
				<h3 class="stitle"></h3>

				<op:pagerParam page="param/webListPagerParam.jsp" />
				<!-- list -->
				<div class="type-list">
					<table>
						<caption></caption>
						<colgroup>
						<col style="width:50px;"/>
						<col style="width:100px;"/>
						<col style="width:110px;"/>
						<col style="width:*;"/>
						<col style="width:60px;"/>
						<col style="width:70px;"/>
						<col style="width:80px;"/>
						<col style="width:80px;"/>
						<col style="width:70px;"/>
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>서비스코드<br/>(언어)</th>
								<th>구분</th>
								<th>서비스명</th>
								<th>단가(\)</th>
								<th>조회수</th>
								<th>구매문의<br/>(신청)수</th>
								<th>관심서비스<br/>등록횟수</th>
								<th>평가수</th>
							</tr>
						</thead>
						<tbody>
                               <c:set var="index" value="${pager.indexNo}"/>
                               <c:forEach items="${pager.list}" var="_list" varStatus="status">
                               <tr>
                                   <td>${index - status.index}</td>
                                   <td>${_list.goodsCode}<br/>(${_list.langNm})</td>
                                   <td><c:forEach items="${_list.goodsType}" var="_goodsTy" varStatus="status">${_goodsTy.GOODSTYNM}${!status.last ? '<br/>' : ''}</c:forEach></td>
                                   <td class="title">${_list.goodsNm}</td>
                                   <td class="money"><%-- <fmt:formatNumber value="${_list.goodsPc}" groupingUsed="true" type="NUMBER" /> --%>${_list.goodsPc}</td>
                                   <td>${_list.goodsRdcnt}</td>
                                   <td>${_list.sellCnt}</td>
                                   <td>${_list.inqrCnt}</td>
                                   <td>${_list.evlScore}</td>
                               </tr>
                               </c:forEach>
                               <op:no-data obj="${pager}" colspan="9" />
						</tbody>
					</table>
				</div>
				<!-- //list -->

				<!-- button -->
				<div class="btn-area mt20">
					<a href="#" class="b-btn download type1" onclick="jsExcelList(this);"><strong><span>엑셀 다운로드</span></strong></a>
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