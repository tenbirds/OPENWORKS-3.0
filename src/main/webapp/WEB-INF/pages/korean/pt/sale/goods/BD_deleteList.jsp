<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

var ctgryCd1 = "${searchMap.q_ctgryCd1}";
var ctgryCd2 = "${searchMap.q_ctgryCd2}";
var ctgryCd3 = "${searchMap.q_ctgryCd3}";

  $().ready(
          function () {  

              
              $("#q_beginDate, #q_endDate").datepicker({
                    showOn: "both", 
                    buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
                    buttonImageOnly: false,
                    buttonText: "달력"
              });
                
              //기본 카테고리(세팅)
              jsCtgryList(1,null);
              $("#exttbl").hide();
              //언어 체크박스 제어
              $("#langCodes").click(function(){
                  if($(this).is(":checked")){
                      $('input[name="q_langCodes"]:checked').each(function (i) {
                          $(this).attr("checked",false);
                      });
                  } 
              });
              
              

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
          	    
            	}); //ready
            	
          	<c:if test="${fn:length(searchMap.q_crtfcCodes) > 0}">
	    	    $(".schOpt").addClass('on');
	    	    $(".exSch").addClass('on');
	    	</c:if>

          }
  	);

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
    document.dataForm.action = "BD_deleteList.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
      $("#q_beginDate").val("2000-01-01");
      $("#q_endDate").val("2100-12-31");
      $("#q_searchVal").val("");
      
      $("input:radio[name='q_goodsRegistSttus']:radio[value='']").attr("checked",true);
  
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
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm;
  }
  
</script>
</head>
<body>
	<div class="supAdm">				
	
	<form name="dataForm" id="dataForm" method="get" action="BD_deleteList.do">
	 <div class="schOpt">
		<table class="tbl_st4 tbl_list_input" summary="삭제서비스 검색">
			<caption>삭제서비스 검색</caption>
			<colgroup>
				<col width="10%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
			<tr>
				<th scope="col">카테고리</th>
				<td>
				<label><op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:115px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" /></label>
				<label>
				<select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1"  style="width:175px">
				 <option value="">선택</option>
				</select></label>
				</td>
			</tr>
        <tr>
            <th scope="col">서비스명</th>
            <td>
                <label><input type="text" name="q_searchVal" id="q_searchVal" class="w650" value="<c:out value='${searchMap.q_searchVal}'/>" title="서비스명 입력"/></label>
                <input type="hidden" name="q_searchKey" id="q_searchKey" value="1001"/>
            </td>            
        </tr>
        <tr>
			<th scope="col">등록일</th>
			<td class="term">
				 <label><input type="text" name="q_beginDate" id="q_beginDate" readonly="readonly" title="검색 시작일 입력" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> /></label>
				  ~  
				 <label><input type="text" name="q_endDate" id="q_endDate" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> /></label>
				<a href="javascript:"  id="0" class="btns b-btn st3">오늘</a>
				<a href="javascript:"  id="7D" class="btns b-btn st3">1주일</a>
				<a href="javascript:"  id="1M" class="btns b-btn st3">1개월</a>
				<a href="javascript:"  id="3M" class="btns b-btn st3">3개월</a>
			</td>
		</tr>    
<!-- 		
          <tr class="toggle">
	              <th>인증구분</th>
	              <td>
	               <input type="checkbox" name="crtfcCodes" id="crtfcCodes" value=""
	               <c:if test="${fn:length(searchMap.q_crtfcCodes) == 0}">checked="checked"</c:if> >전체&nbsp;&nbsp;&nbsp;&nbsp;</input>
	               <c:forEach items="${codeList_crtfc}" var="_bean" varStatus="status">
	                   <input type="checkbox" name="q_crtfcCodes" id="q_crtfcCode_${_bean.prvCd}"
	                       <c:if test="${fn:contains(searchMap.q_crtfcCodes,_bean.prvCd)}">checked="checked"</c:if>
	                   value="<c:out value='${_bean.prvCd}'/>"/> <c:out value='${_bean.prvNm}'/>&nbsp;&nbsp;&nbsp;&nbsp;
	               </c:forEach>
	              </td>
	          </tr>
-->
      	</tbody>
        </table>
      </div>
	   <!-- a href="#" class="exSch">확장검색</a -->  
	   <div class="btnArea rig mtm20">
			<a href="javascript:"  onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
			<a href="javascript:"  onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>
	  </div>		
		
       <div class="list_st1">
  	  	<!--  p class="head">
	      <op:pagerParam page="param/webListPagerParam.jsp" />
   		  <span class="sel_box">
   		  <select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" style="width: 100px; z-index: 5; position: absolute; left: -100000px; height: auto;" onchange="this.form.submit()" >
          <option value="20" <c:if test="${20 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>20 개씩</option>
          <option value="40" <c:if test="${40 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>40 개씩</option>
          <option value="60" <c:if test="${60 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>60 개씩</option>
          <option value="100" <c:if test="${100 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>100 개씩</option>
   		  </select>
   		 </span>
		</p -->		    
       
      <table class="tbl_st1" summary="삭제서비스 목록">
	            <caption>
	                <strong>서비스관리 목록</strong>
	                <details>
	                    <summary>번호, 선택, 구분, 서비스코드, 서비스명, 언어, 인증구분, 판매방식, 전시, 등록일 정보를 제공합니다.</summary>
	                </details>
	            </caption>
				<colgroup>
				<col style="width:60px;"/>
				<col style="width:100px;"/>
				<col style="width:100px;"/>
				<col style="width:*;"/>
				<col style="width:130px;"/>
				<col style="width:100px;"/>
				<col style="width:100px;"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="row">번호</th>
						<th scope="row">구분</th>
						<th scope="row">서비스코드</th>
						<th scope="row">서비스명</th>
						<th scope="row">단가(\)</th>
						<th scope="row">삭제주체</th>
						<th scope="row">등록일</th>
					</tr>
				</thead>
				<tbody>
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
	                <tr>
	                    <td><c:out value='${index-status.index}'/></td>
	                    <td>
	                        <c:forEach items="${baseVo.goodsType}" var="_goodsType" varStatus="status">
	                           <c:out value='${_goodsType.GOODSTYNM}'/>
	                           <c:if test="${ not status.last }"><br /></c:if>                                                                        
	                        </c:forEach>
	                    </td>
                        <td><c:out value='${baseVo.goodsCode}'/><%-- <br />(<c:out value='${baseVo.langNm}'/>) --%></td>
	                    <td class="title">
                            <c:out value='${baseVo.goodsNm}'/>
                            <span>
                                <c:forEach items="${baseVo.markFile}" var="fileVo" varStatus="status1">
                                    <c:if test="${ status1.first }"><div class="ico"></c:if>                           
                                    <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
                                        <img alt="마크이미지" width="35" height="15" src="${fileVo2.fileUrl}"></img>
                                        <c:if test="${not status2.last}">&nbsp;</c:if>
                                    </c:forEach>
                                    <c:if test="${ status1.last }"></div></c:if>
                                </c:forEach>
                            </span>
                        </td>
	                    <td class="money"><%-- <fmt:formatNumber type="NUMBER" groupingUsed="true" value="${baseVo.goodsPc}"/> --%>${baseVo.goodsPc}</td>
	                    <td>
	                       <c:if test="${baseVo.mngrDeleteAt=='Y'}">관리자</c:if><c:if test="${baseVo.goodsActvtyAt=='N'}">판매자</c:if>
	                    </td>
	                    <td class="date"><span><c:out value='${baseVo.registDt}'/></span></td>
	                </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="7" />
            </tbody>
        </table>
        </div>
        <!-- //목록 끝 -->
        <!-- paging -->
          <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
        <!-- //paging -->
        </form>
        </div> 
</body>
</html>