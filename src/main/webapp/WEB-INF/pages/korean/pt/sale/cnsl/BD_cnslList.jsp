<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>IT전문가서비스 관리 | 판매하기 | 씨앗 마켓</title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

var ctgryCd1 = "${searchMap.q_ctgryCd1}";
var ctgryCd2 = "${searchMap.q_ctgryCd2}";
var ctgryCd3 = "${searchMap.q_ctgryCd3}";

  $().ready(function () {

    //기본 카테고리(세팅)
    jsCtgryList(1,null);
    $("#exttbl").hide();
    
    /* //언어 체크박스 제어
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
    <c:if test="${fn:length(searchMap.q_langCodes) > 0}">
      $(".ext_table .btn_ext a span").attr("class","on");
      $("#exttbl").show();
    </c:if>*/
    
    //노출 값이 있으면 확장검색 활성화
    <c:if test="${fn:length(searchMap.q_goodsRegistSttus) > 0}">
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
    document.dataForm.action = "BD_cnslList.do";
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
     
     $("#q_goodsTyCd").val("").trigger("change");
     
  };
  
  var jsGoodsView = function(seq,urlNm){
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm;
  };
  
  var jsDspy = function(dspyAt) {
      var url = "ND_dspyUpdateAction.do";
      var goodsCodes = new Array();
      var goodsStatuss = new Array();
      var ActvtyMsg;
      $("input[name=goodsCodes]:checked").each(function (i) {
          
//        var strObj = $(this).val().split(',');
//        goodsCodes[i] = strObj[0];
          goodsCodes[i] = $(this).val();
          goodsStatuss[i] = $("#goodsStatuss" + this.value).val();
//         alert(goodsCode);
          
//         url += "eventSeqs=" + strObj[0] + "&fileIds=" +  strObj[1] + "&" ;
      });

      if(goodsCodes.length == 0){
          jsWarningBox("대상 항목을 1개 이상 선택하세요.");
          return false;
      }else{
          if (dspyAt==1006) {
              ActvtyMsg = "전시"
                  }
          else
              {ActvtyMsg = "비전시"};
          if(confirm("선택한 " + goodsCodes.length + "개의 항목을 " + ActvtyMsg + " 하시겠습니까?")){
              jQuery.ajaxSettings.traditional = true;
              
              $.ajax({
                  url     : "ND_dspyUpdateAction.do",            
                  type    : "POST",
                  data : { goodsCodes : goodsCodes, goodsRegistSttus : dspyAt, goodsStatuss : goodsStatuss },
                            
                  
                  success : function(result) {
                      
                      if(result.result) {
                          /* 20150831 메세지 변경 시작 */
                          //원본alert(Message.msg.processOk);
                          if(dspyAt == 1006)
                              alert(Message.msg.changeDisplayOK);
                          else
                              alert(Message.msg.changeNotDisplayOK);
                          /* 20150831 메세지 변경 끝 */
                          self.location.reload();                   
                      } else {   
                          if (result.message != "") {
                              alert(result.message);
                          } else {
                              alert(Message.msg.processFail);
                          }
                      }                
                  }
             });
          }
      }
  };
  
  var jsView = function(vl){
      $("#goodsCode").val(vl);
      document.dataForm.action = "BD_cnslView.do";
      document.dataForm.submit();
  };
  
  /* 20150831 전시 항목일 경우 수정할 수 없다는 메세지 출력 시작 */
  var jsNotAllowMsg = function(vl) {
      var chFlag = confirm("서비스 정보 수정은 비전시 상태일때만 가능합니다.\n선택 항목을 비전시로 전환하시겠습니까?");
      
      if(chFlag) {
          var checkList = $("input[name=goodsCodes]");
          
          for(var c=0; c<checkList.length; c++) {
              if(checkList[c].value == vl) {
                  checkList[c].checked = true;
              }
          }
                
          jsDspy2(1007);
      }
      else {
          jsView(vl);
      }
  };
  
  var jsDspy2 = function(dspyAt) {
      var url = "ND_dspyUpdateAction.do";
      var goodsCodes = new Array();
      var goodsStatuss = new Array();
      var ActvtyMsg;
      $("input[name=goodsCodes]:checked").each(function (i) {
          goodsCodes[i] = $(this).val();
          goodsStatuss[i] = $("#goodsStatuss" + this.value).val();
      });

      if(goodsCodes.length == 0){
          jsWarningBox("대상 항목을 1개 이상 선택하세요.");
          return false;
      }else{
          if (dspyAt==1006) {
              ActvtyMsg = "활성"
                  }
          else
              {ActvtyMsg = "비활성"};
              jQuery.ajaxSettings.traditional = true;
              
              $.ajax({
                  url     : "ND_dspyUpdateAction.do",            
                  type    : "POST",
                  data : { goodsCodes : goodsCodes, goodsRegistSttus : dspyAt, goodsStatuss : goodsStatuss },
                            
                  
                  success : function(result) {
                      if(result.result) {
                          alert(Message.msg.changeNotDisplayOK);
                          self.location.reload();                   
                      } else {   
                          if (result.message != "") {
                              alert(result.message);
                          } else {
                              alert(Message.msg.processFail);
                          }
                      }                
                  }
             });
      }
  };
  /* 20150831 전시 항목일 경우 수정할 수 없다는 메세지 출력 끝 */

  var jsExcelList = function() {
      $("#q_excel").val("9");
      location.href = "INC_goodsExcel.do?" + $("#dataForm").serialize();
      $("#q_excel").val("");
  };
</script>
</head>
<body>
<!-- 검색 -->

 
 <!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get" action="BD_cnslList.do">
<input type="hidden" name="q_excel" id="q_excel" value="" />
<input type="hidden" name="goodsCode" id="goodsCode" />
    <div class="contents">
	<!-- title-area -->
	<div class="title-area">
		<h2>IT 서비스 관리</h2>
	</div>
	<!-- //title-area -->
    <section>
        <fieldset>
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
			<th>카테고리</th>
			<td>
				<!-- static select -->
				<div class="select-area">
					<!-- select box -->
					<div class="sech_form">
						<div class="cont_wrap">
						<div class="selected">
								<div class="select" style="float:left;width:140px;">
									<op:code id="q_goodsTyCd" grpCd="1005" ctgCd="CNSLTCD" defaultValues="1003" option="style='width:120px;z-index:5'" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
								</div>
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
								<div class="select" style="float:left;width:140px;">
									<select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" onchange="jsCtgryList(2,this.value)"  style="width:115px;z-index:5">
									 <option value="">선택</option>
									</select>
								</div>
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
								<div class="select" style="float:left;width:140px;">
									<select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" onchange="jsCtgryList(3,this.value)" style="width:115px;z-index:5">
									 <option value="">선택</option>
									</select>
								</div>
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
								<div class="select" style="float:left;width:140px;">
									 <select id="q_ctgryCd3" name="q_ctgryCd3" title="카테고리3" style="width:115px;z-index:5">
  										 <option value="">선택</option>
									</select>
								</div>
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
                <input type="text" name="q_searchVal" id="q_searchVal" class="w650" value="<c:out value='${searchMap.q_searchVal}'/>" title="서비스명 입력"/>
                <input type="hidden" name="q_searchKey" id="q_searchKey" value="1001"/>
            </td>            
        </tr>
        <tr>
            <th scope="row">등록일</th>
            <td>
              <div class="calendar_input">
                  <input type="text" class="input" name="q_beginDate" id="q_beginDate" readonly="readonly" title="검색 시작일 입력" style="width:100px"
                  <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
              </div>
              <span class="divide"> ~ </span>
              <div class="calendar_input end">
              <input type="text" class="input" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" style="width:100px"
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
            <table id="exttbl" class="tbl_list_input ext">
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
            <tbody>
            <%-- <tr>
                <th scope="row">언어</th>
                <td>
                  <input type="checkbox" name="langCodes" id="langCodes" value=""
                  <c:if test="${fn:length(searchMap.q_langCodes) == 0}">checked="checked"</c:if> >전체&nbsp;&nbsp;&nbsp;&nbsp;</input>
                  <c:forEach items="${codeList_lang}" var="_bean" varStatus="status">
                      <input type="checkbox" name="q_langCodes" id="q_langCode_${_bean.langCode}"
                          <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
                      value="<c:out value='${_bean.langCode}'/>"/> <c:out value='${_bean.langNm}'/>&nbsp;&nbsp;&nbsp;&nbsp;
                  </c:forEach>
                </td>
            </tr> --%>
            <tr>
                <th scope="row">노출</th>
                <td>
                  <input type="radio" name="q_goodsRegistSttus" id="expsrCodes" value=""
                  <c:if test="${fn:length(searchMap.q_goodsRegistSttus) == 0}">checked="checked"</c:if> >전체&nbsp;&nbsp;&nbsp;&nbsp;</input>
                  <c:forEach items="${codeList_expsr}" var="_bean" varStatus="status">
                    <input type="radio" name="q_goodsRegistSttus" id="q_expsrCode_${_bean.prvCd}"
                        <c:if test="${fn:contains(searchMap.q_goodsRegistSttus,_bean.prvCd)}">checked="checked"</c:if>
                    value="<c:out value='${_bean.prvCd}'/>"/> <c:out value='${_bean.prvNm}'/>&nbsp;&nbsp;&nbsp;&nbsp;
                  </c:forEach>
                </td>
            </tr>
           </tbody>
            </table>
            <!--  p class="btn_ext">
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
        </fieldset>
        <!-- //구매내역 검색 영역 -->
    </section>
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
	                <strong>서비스관리 목록</strong>
	                <details>
	                    <summary>번호, 선택, 구분, 서비스코드, 서비스명, 언어, 인증구분, 판매방식, 전시, 등록일 정보를 제공합니다.</summary>
	                </details>
	            </caption>
				<colgroup>
				<col style="width:60px;"/>
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
						<th>번호</th>
						<th>선택</th>
						<th>구분</th>
						<th>서비스코드<br/>(언어)</th>
						<th>서비스명</th>
						<th>가격(\)</th>
						<th>전시</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="_list" varStatus="status">
                <tr>
                    <td><c:out value='${index-status.index}'/></td>
                    <td><input type="checkbox" title="${_list.goodsNm}" name="goodsCodes" value="<c:out value='${_list.goodsCode}'/>">
                        <input type="hidden" name="goodsStatuss" value="${_list.goodsRegistSttus}" id="goodsStatuss${_list.goodsCode}"/></td>
                    <td>
                        <c:forEach items="${_list.goodsType}" var="_goodsType" varStatus="status">
                           <c:out value='${_goodsType.GOODSTYNM}'/>
                           <c:if test="${ not status.last }"><br /></c:if>                                                                        
                        </c:forEach>
                    </td>
                    <td><c:out value='${_list.goodsCode}'/><br />(<c:out value='${_list.langNm}'/>)</td>
                    <td class="title">
                        <!-- 20150818 전시 항목일 경우 수정할 수 없다는 메세지 출력 시작 -->
                        <!-- 원본 <a onclick='jsView("${_list.goodsCode}");'  href="#link"><c:out value='${_list.goodsNm}'/></a> -->
                         <c:choose>
                            <c:when test="${_list.goodsRegistSttus eq 1007}">
                                 <a onclick='jsView("${_list.goodsCode}");'  href="#link"><c:out value='${_list.goodsNm}'/></a>
                            </c:when>
                            <c:otherwise>
                                <a onclick='jsNotAllowMsg("${_list.goodsCode}");'  href="#link" class="title"><c:out value='${_list.goodsNm}'/></a>
                            </c:otherwise>
                         </c:choose>
                        <!-- 20150818 전시 항목일 경우 수정할 수 없다는 메세지 출력 끝 -->
                        <span>
                           <c:forEach items="${_list.markFile}" var="fileVo" varStatus="status1">                           
                           <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">                           
                               <img src="${fileVo2.fileUrl}" alt="<c:out value='${fileVo2.fileDesc}'/>"></img>
                           </c:forEach>
                           </c:forEach>
                        </span>
                    </td>
                    <td class="money"><fmt:formatNumber type="NUMBER" groupingUsed="true" value="${_list.goodsPc}"/></td>
                    <td><c:out value='${_list.goodsRegistSttusNm}'/></td>
                    <td class="date"><span><c:out value='${_list.registDt}'/></span></td>
                </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="8" />
            </tbody>
        </table>
        </div>
        <div class="btn-area mt10">
			<a id="linkNotDisplay" href="javascript:;" onclick="jsDspy(1007);" class="b-btn no-display mr05 type3"><strong><span>선택항목 비전시</span></strong></a>
			<a href="javascript:;" onclick="jsDspy(1006);" class="b-btn display mr05 type3"><strong><span>선택항목 전시</span></strong></a>
			<a href="javascript:;" onclick="jsExcelList(this);" class="b-btn download mr05 type1"><strong><span>엑셀 다운로드</span></strong></a>
		</div>
        <!-- //목록 끝 -->
        <!-- paging -->
          <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
        <!-- //paging -->
    </div>
</div>
<!-- //section -->

<!-- //contents -->
 </form>
 
</body>
</html>
