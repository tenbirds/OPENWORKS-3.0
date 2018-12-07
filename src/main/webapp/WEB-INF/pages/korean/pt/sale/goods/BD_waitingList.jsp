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
<script type="text/javascript">

var ctgryCd1 = "${searchMap.q_ctgryCd1}";
var ctgryCd2 = "${searchMap.q_ctgryCd2}";

  $().ready(function () {  
  
    //기본 카테고리(세팅)
    jsCtgryList(1,null);

    $("#q_beginDate, #q_endDate").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
    
    //상태 체크박스 제어
    $("#statusCodes").click(function(){
        if($(this).is(":checked")){
            $('input[name="q_goodsRegistSttuses"]:checked').each(function (i) {
                $(this).attr("checked",false);
            });
        } 
    });
    
    $('input[name="q_goodsRegistSttuses"]').click(function() {
        if($(this).is(':checked')) {
            $("#statusCodes").attr("checked",false);
        }
    });
    
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
    
    <c:if test="${fn:length(searchMap.q_goodsRegistSttuses) > 0}">
	    $(".schOpt").addClass('on');
	    $(".exSch").addClass('on');
    </c:if>
    <c:if test="${fn:length(searchMap.q_crtfcCodes) > 0}">
	    $(".schOpt").addClass('on');
	    $(".exSch").addClass('on');
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
        case 1 : $("#q_ctgryCd1,#q_ctgryCd2").html("").append(innerHtml).trigger("change");
        case 2 : $("#q_ctgryCd2").html("").append(innerHtml).trigger("change");
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
        default : break;
        }
    });
    
  };
  
  var jsSearch = function(){
    document.dataForm.action = "BD_waitingList.do";
    document.dataForm.elements["q_currPage"].value = "1";
    document.dataForm.submit();
  };
  
  var jsClean = function(){
      
     $("#q_beginDate").val("2000-01-01");
     $("#q_endDate").val("2100-12-31");
     $("#q_searchVal").val("");
     
     
     $("#statusCodes").attr("checked",true);
     $('input[name="q_goodsRegistSttuses"]:checked').each(function (i) {
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
  };
  
  var jsRegistBack = function(el,goodsCode,goodsStatus) {          
      
      $(el).colorbox({
          title : "반려사유",
          href : "/korean/pt/sale/goods/PD_returnReasonPop.do?goodsCode="+goodsCode+"&goodsStatus="+goodsStatus,
          width : "500",
          height : "400",
          overlayClose : false,
          escKey : false,
          iframe : true
      });
      
  };
  
  var jsView = function(vl,vm){
      $("#goodsCode").val(vl);
      $("#updateYn").val(vm);      
      //document.dataForm.action = "BD_goodsView.do";
    	document.dataForm.action = "BD_goodsForm.do";
      document.dataForm.submit(); 
  };
  
  var jsWaitingView = function(vl){
      $("#goodsCode").val(vl);
      document.dataForm.action = "BD_waitingView.do";
      //document.dataForm.action = "BD_goodsForm.do";
      document.dataForm.submit();
  };

  var jsExcelList = function() {
      $("#q_excel").val("8");
      location.href = "INC_goodsExcel.do?" + $("#dataForm").serialize();
      $("#q_excel").val("");
  };
</script>
</head>
<body>


<div class="supAdm">
	<form name="dataForm" id="dataForm" method="get" action="BD_waitingList.do">
		<input type="hidden" name="q_excel" id="q_excel" value="" />
	 	<input type="hidden" name="goodsCode" id="goodsCode" />
	 	<input type="hidden" name="updateYn" id="updateYn" />	 	

 		<div class="schOpt">	
		<table class="tbl_st4 tbl_list_input" summary="서비스 승인대기 검색">
			<caption>서비스 승인대기 검색</caption>
			<colgroup>
				<col width=""/>
				<col width="*"/>
			</colgroup>
			<thead hidden="hidden">
				<tr><th scope="col">카테고리</th></tr>
				<tr><th scope="col">서비스명</th></tr>
				<tr><th scope="col">등록일</th></tr>
				<tr><th scope="col">상태</th></tr>
			</thead>
			<tfoot hidden="hidden">
				<tr><th scope="col">카테고리</th></tr>
				<tr><th scope="col">서비스명</th></tr>
				<tr><th scope="col">등록일</th></tr>
				<tr><th scope="col">상태</th></tr>
			</tfoot>
			<tr>
				<th scope="col">카테고리</th>
				<td>
					<div class="select" style="float:left;width:140px;">
						<op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:120px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" title="카테고리"/>
						<label for="q_goodsTyCd" hidden="hidden">카테고리</label>
					</div>
					<div class="select" style="float:left;width:140px;">
						<select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1" style="width:115px;z-index:5">
						 <option value="">선택</option>
						</select>
						<label for="q_ctgryCd1" hidden="hidden">카테고리1</label>
					</div>
					<%-- <div class="select" style="float:left;width:140px;">
						<select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" onchange="jsCtgryList(3,this.value)" style="width:115px;z-index:5">
						 <option value="">선택</option>
						</select>
					</div> --%>
				</td>
			</tr>
      <tr>
	    	<th scope="col">서비스명</th>
      	<td>
        	<input type="text" name="q_searchVal" id="q_searchVal" class="w650" value="<c:out value='${searchMap.q_searchVal}'/>" title="서비스명 입력"/>
        	<label for="q_searchVal" hidden="hidden">서비스명</label>
          <input type="hidden" name="q_searchKey" id="q_searchKey" value="1001"/>
        </td>            
	    </tr>
	    <tr>
				<th scope="col">등록일</th>
				<td class="term">
	      	<input type="text" name="q_beginDate" id="q_beginDate" readonly="readonly" title="검색 시작일 입력" <c:if test="${not empty searchMap.q_beginDate}"> value="${searchMap.q_beginDate}"</c:if> />
	      	<label for="q_beginDate" hidden="hidden">검색 시작일</label> 
	      	~ 
	        <input type="text" name="q_endDate" id="q_endDate" readonly="readonly" title="검색 종료일 입력" <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> />
	          <label for="q_endDate" hidden="hidden">검색 종료일</label>
	          <a href="javascript:" id="0" class="btns b-btn st3">오늘</a>
				    <a href="javascript:" id="7D" class="btns b-btn st3">1주일</a>
				    <a href="javascript:" id="1M" class="btns b-btn st3">1개월</a>
				    <a href="javascript:" id="3M" class="btns b-btn st3 ">3개월</a>
	      </td>
	    </tr>
	    <tr>
	    	<th scope="col">상태</th>
	      <td>
	       	<input type="checkbox" name="statusCodes" id="statusCodes" value="" <c:if test="${fn:length(searchMap.q_goodsRegistSttuses) == 0}">checked="checked"</c:if> />
	       	<label for="statusCodes">전체</label>&nbsp;&nbsp;&nbsp;&nbsp;
	         <c:forEach items="${codeList_sttus}" var="_bean" varStatus="status">
	         	<input type="checkbox" name="q_goodsRegistSttuses" id="q_statusCodes_${_bean.goodsRegistSttus}" <c:if test="${fn:contains(searchMap.q_goodsRegistSttuses,_bean.goodsRegistSttus)}">checked="checked"</c:if> value="<c:out value='${_bean.goodsRegistSttus}'/>" <c:if test="${_bean.goodsRegistSttus > 1003}">style="display:none"</c:if> />
	         	<c:choose>
	            <c:when test="${_bean.goodsRegistSttus eq 1001}"><label for="q_statusCodes_${_bean.goodsRegistSttus}" >임시저장</label>&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
	            <c:when test="${_bean.goodsRegistSttus eq 1002}"><label for="q_statusCodes_${_bean.goodsRegistSttus}" >대기중</label>&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
	            <c:when test="${_bean.goodsRegistSttus eq 1003}"><label for="q_statusCodes_${_bean.goodsRegistSttus}" >반려</label>&nbsp;&nbsp;&nbsp;&nbsp;</c:when>
            </c:choose>
	         </c:forEach>
	     
	       	<!-- 상태는 어쩔수 없이 하드 코오딩 -->
	       	<script type="text/javascript">
	         	$().ready(function () {
	           		//대기중
	           		$("#q_statusCodes_1002").change(function() {
	              	if($(this).is(":checked")){
	                		$("#q_statusCodes_1004").attr("checked",true);
	              	}else{
	                		$("#q_statusCodes_1004").attr("checked",false);
	              	}
	           		});
	           	
	           		//반려
	           		$("#q_statusCodes_1003").change(function() {
	             		if($(this).is(":checked")){
	               			$("#q_statusCodes_1005").attr("checked",true);
	             		}else{
	               			$("#q_statusCodes_1005").attr("checked",false);
	             		}
	           		});
	         	});
	       	</script>
	      </td>
			</tr>
<%-- 			
			<tr class="toggle" style="display:none;"> <!-- 용도폐기 -->
				<th>필터</th>
				<td>
					<input type="checkbox" name="crtfcCodes" id="crtfcCodes" value=""
	                <c:if test="${fn:length(searchMap.q_crtfcCodes) == 0}">checked="checked"</c:if> >전체&nbsp;&nbsp;&nbsp;&nbsp;</input>
	                <c:forEach items="${codeList_crtfc}" var="_bean" varStatus="status">
	                    <label><input type="checkbox" name="q_crtfcCodes" id="q_crtfcCode_${_bean.prvCd}"
	                    <c:if test="${fn:contains(searchMap.q_crtfcCodes,_bean.prvCd)}">checked="checked"</c:if>
	                    value="<c:out value='${_bean.prvCd}'/>"/> <c:out value='${_bean.prvNm}'/></label>
	                </c:forEach>
				</td>
			</tr>
 --%>
		</table>
  </div> 
        
<!--         <a href="#" class="exSch">확장검색</a> -->
		
	<div class="btnArea rig mtm20">
		<a href="javascript:"  onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
		<a href="javascript:"  onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>
	</div>
				
	    <!-- 검색 리스트 영역 -->
  <div class="list_st1">
			<!-- p class="head">
				<op:pagerParam page="param/webListPagerParam.jsp" />
				<span class="sel_box">
       			<select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" style="width: 100px; z-index: 5; position: absolute; left: -100000px; height: auto;" onchange="this.form.submit()" >
               	<option value="20" 	<c:if test="${searchMap.q_rowPerPage eq 20}">selected="selected"</c:if>>20 개씩</option>
               	<option value="40" 	<c:if test="${searchMap.q_rowPerPage eq	40}">selected="selected"</c:if>>40 개씩</option>
               	<option value="60" 	<c:if test="${searchMap.q_rowPerPage eq 60}">selected="selected"</c:if>>60 개씩</option>
               	<option value="100" <c:if test="${searchMap.q_rowPerPage eq 100}">selected="selected</c:if>>100 개씩</option>
       			</select>
       			</span>
			</p -->
        	
        	<!-- 목록 시작 -->
  	<table class="tbl_st1" summary="번호, 선택, 구분, 서비스코드, 서비스명, 언어, 인증구분, 판매방식, 전시, 등록일 정보를 제공합니다.">
	    <caption>서비스관리 목록</caption>
	    <colgroup>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="*"/>
	    	<col width="20%"/>
	    	<col width="10%"/>
	    	<col width="10%"/>
	    	<col width="20%"/>
	    </colgroup>
			<thead>
				<tr>
					<th scope="row">번호</th>
					<th scope="row">구분</th>
					<th scope="row">서비스명</th>
					<th scope="row">단가(\)</th>
					<th scope="row">상태</th>
					<th scope="row">등록자</th>
					<th scope="row">등록(변경)일시</th>
				</tr>
			</thead>
			<tfoot hidden="hidden">
				<tr><th scope="row" colspan="7">번호|구분|서비스명|단가(\)|상태|등록자|등록(변경)일시</th>
				</tr>
			</tfoot>
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
          <%-- <td><c:out value='${baseVo.goodsCode}'/><br />(<c:out value='${baseVo.langNm}'/>)</td> --%>
          <td class="title">
	          <c:choose>
	            <c:when test="${baseVo.goodsRegistSttus eq 1004  || baseVo.goodsRegistSttus eq 1005 }">
	            <a onclick='jsWaitingView("${baseVo.goodsCode}");'  href="#none" ><c:out value='${baseVo.goodsNm}'/></a>
	            </c:when>
	            <c:when test="${baseVo.goodsRegistSttus eq 1002 || baseVo.goodsRegistSttus eq 1006  || baseVo.goodsRegistSttus eq 1007 || baseVo.goodsRegistSttus eq 1008 || baseVo.goodsRegistSttus eq 1009 }">
	            <c:out value='${baseVo.goodsNm}'/>
	            </c:when>
	            <c:otherwise>
	            <c:if test="${baseVo.requstProcessAt eq 'N'}"><c:out value='${baseVo.goodsNm}'/></c:if>
	            <c:if test="${baseVo.requstProcessAt ne 'N'}"><a onclick='jsView("${baseVo.goodsCode}","${baseVo.updateYn}");'  href="#none" ><c:out value='${baseVo.goodsNm}'/></a></c:if>			                        	
	            </c:otherwise>
	          </c:choose>
              		<!-- 비전시,임시저장,검토반려,승인반려  -->
<%-- 	                        <c:choose>  --%>
<%-- 	                           <c:when test="${(baseVo.goodsRegistSttus eq 1001) or (baseVo.goodsRegistSttus eq 1003)  or (baseVo.goodsRegistSttus eq 1007)}"> --%>
<%-- 			                        <a onclick='jsView("${baseVo.goodsCode}");'  href="#none" > --%>
<%-- 			                           <c:out value='${baseVo.goodsNm}'/> --%>
<!-- 			                        </a> -->
<%-- 	                           </c:when> --%>
<%-- 	                           <c:otherwise> --%>
<%-- 		                           <c:out value='${baseVo.goodsNm}'/> --%>
<%-- 	                           </c:otherwise> --%>
<%-- 	                        </c:choose> --%>
            <span>
            <c:forEach items="${baseVo.markFile}" var="fileVo" varStatus="status1">
              <c:if test="${ status1.first }"><div class="ico"></c:if>                           
              <c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
              	<img alt="마크이미지" src="${fileVo2.fileUrl}" style="width: 35px; height: 35px;"></img>
                <c:if test="${not status2.last}">&nbsp;</c:if>
              </c:forEach>
            	<c:if test="${ status1.last }"></div></c:if>
            </c:forEach>
            </span>
          </td>
          <td class="money"><%-- <fmt:formatNumber type="NUMBER" groupingUsed="true" value="${baseVo.goodsPc}"/> --%>
          <c:choose>
						<c:when test="${fn:length(baseVo.goodsPc) > 10}">
							${fn:substring(baseVo.goodsPc, 0, 8)}...
						</c:when>
						<c:otherwise>
							${baseVo.goodsPc}
						</c:otherwise>
					</c:choose>
					</td>
          <td>
          	<c:choose>
              <c:when test="${baseVo.goodsRegistSttus eq 1003  || baseVo.goodsRegistSttus eq 1005 || baseVo.goodsRegistSttus eq 1010}">
                <span class="condi_c">반려</span><br/>
                <span class="btn_light_gray02">
                    <a href="#none" title="팝업 창 열림" onclick="jsRegistBack(this,'${baseVo.goodsCode}', '${baseVo.goodsRegistSttus}');">반려사유보기</a>
                </span>
              </c:when>
              <c:when test="${baseVo.goodsRegistSttus eq 1001 || baseVo.goodsRegistSttus eq 1008}">
               	<c:if test="${baseVo.requstProcessAt eq 'N'}"><span class="condi_b" style="color:red !important;"><c:out value='${baseVo.requstSeNm}'/>요청</span></c:if>
                	<c:if test="${baseVo.requstProcessAt ne 'N'}"><span class="condi_b">임시저장</span></c:if>
              </c:when>
              <c:when test="${baseVo.goodsRegistSttus eq 1002 || baseVo.goodsRegistSttus eq 1004 || baseVo.goodsRegistSttus eq 1009}">
               <span class="condi_d">승인대기</span>
            	</c:when>
            </c:choose>
           	</td>
           	<td><c:out value='${baseVo.registId}'/></td>
         		<td><c:out value='${baseVo.registDt}'/></td>
       		</tr>
          </c:forEach>
          <op:no-data obj="${pager}" colspan="7" />
        </tbody>
      </table>
        
	       
			<div class="btnArea rig">					
				<a href="#" onclick="jsExcelList(this);"  class="btns st1 icn icnXlx">엑셀 다운로드</a>
			</div>
					
        	<!-- //목록 끝 -->
        	<!-- paging -->
          	<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
        	<!-- //paging -->
    	</div>
	</form>
</div>
</body>
</html>
