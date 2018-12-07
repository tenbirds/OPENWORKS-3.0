<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<script type="text/javascript" src="${contextPath}/resources/cmmnty/common/js/fakeselect.js"></script>
<script type="text/javascript">

var ctgryCd1 = "${searchMap.q_ctgryCd1}";
var ctgryCd2 = "${searchMap.q_ctgryCd2}";
var ctgryCd3 = "${searchMap.q_ctgryCd3}";

  $().ready(function () {

    //기본 카테고리(세팅)
    jsCtgryList(1,null);

  /*   $.datepicker.setDefaults({
        dateFormat:"yy-mm-dd",
        showOn : 'button',
        buttonImageOnly : true,
        buttonImage : '<c:url value="/cloud_ver2/new_cloud/images/icn_calen.png" />',
        buttonText: "날짜선택",
        yearRange: "2010:+1",
        showOptions: { direction: "up"}
    }); */
    

    $("#q_beginDate, #q_endDate").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
    
    //인증구분 체크박스 제어
    $("#crtfcCodes").click(function(){
      if($(this).is(":checked")){
          $('input[name="q_crtfcCodes"]:checked').each(function (i) {
              $(this).attr("checked",false);
          });
      } 
    });
    
    $('input[name="q_crtfcCodes"]').click(function() {
        if($(this).is(':checked')) {
            $("#crtfcCodes").attr("checked",false);
        }
    });
    
    <c:if test="${fn:length(searchMap.q_goodsRegistSttus) > 0}">
	    $(".schOpt").addClass('on');
	    $(".exSch").addClass('on');
	</c:if>
	
	<c:if test="${fn:length(searchMap.q_crtfcCodes) > 0}">
	    $(".schOpt").addClass('on');
	    $(".exSch").addClass('on');
	</c:if>
	
    //인증구분 값이 있으면 확장검색 활성화
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
      $("#searchForm #q_currPage").val(p);
      $("#searchForm").submit();
  
  };
  
  var jsMoveSelected = function(page) {
      alert(page);
      
      $("#searchForm").submit();
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
    document.searchForm.action = "BD_goodsList.do";
    document.searchForm.elements["q_currPage"].value = "1";
    document.searchForm.submit();
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
    location.href = "/${_pathLang}/pt/store/inc/BD_storeView_v2.do?goodsCode=" +seq + "&pageUrlNm=" + urlNm;
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
              ActvtyMsg = "활성"
                  }
          else
              {ActvtyMsg = "비활성"};
          if(confirm("선택한 " + goodsCodes.length + "개의 항목을 " + ActvtyMsg + " 하시겠습니까?")){
              jQuery.ajaxSettings.traditional = true;
              
              $.ajax({
                  url     : "ND_dspyUpdateAction.do",            
                  type    : "POST",
                  data : { goodsCodes : goodsCodes, goodsRegistSttus : dspyAt, goodsStatuss : goodsStatuss },
                            
                  
                  success : function(result) {
                      
                      if(result.result) {
                          /* 20150819 메세지 변경 시작 */
                          //원본alert(Message.msg.processOk);
                          if(dspyAt == 1006)
                              alert(Message.msg.changeDisplayOK);
                          else
                              alert(Message.msg.changeNotDisplayOK);
                          /* 20150819 메세지 변경 끝 */
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
      
      $("#updateYn").val("update");
//      alert($("#updateYn").val());
      document.searchForm.action = "BD_goodsForm.do"; // BD_goodsView.do

      document.searchForm.submit();
  };
  
  /* 20150818 전시 항목일 경우 수정할 수 없다는 메세지 출력 시작 */
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
          //jsView(vl);
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
  	/* 20150818 전시 항목일 경우 수정할 수 없다는 메세지 출력 끝 */
  	var jsExcelList = function() {
      	$("#q_excel").val("7");
      	location.href = "INC_goodsExcel.do?" + $("#searchForm").serialize();
      	$("#q_excel").val("");
  	};

  	
  	/* 서비스변경요청 이벤트 */
  	var jsSvcChangeRequst = function(el) {
        <c:if test="${empty sessionScope['__usk']}"> 
        if(confirm(Message.msg.userLoginCheck)) {
            top.location.href = Config.url.userLogin
                    + "?returnUrl=/korean/pt/sale/goods/BD_goodsList.do";
        }
        </c:if>
        <c:if test="${not empty sessionScope['__usk']}"> 
        var goodsCode = $(':input[name=goodsCodes]:radio:checked').val();//$(":radio[name=goodsCodes]:checked").val();

        if(goodsCode){
            var requstSe = '';
            if($("#goodsStatuss" + goodsCode).val() == '1006') {
                requstSe = '1002';
            } else {
                requstSe = '1001';
            }
            
            if($("#goodsStatuss" + goodsCode).val() == '1006') {

            $.ajax({
                url     : "BD_goodsStatAction.do",            
                type    : "POST",
                data : { goodsCode :  $(':input[name=goodsCodes]:radio:checked').val()},
                          
                success : function(result) {
                    if(result.result) {
                        //alert(Message.msg.changeNotDisplayOK);
                        alert("서비스 및 규격서를 수정할 수 있도록 변경하였습니다.");
                        self.location.reload();                   
                    } else {   
                        if (result.message != "") {
                            //alert(result.message);
                            alert("서비스 및 규격서를 수정할 수 없습니다.");                            
                        } else {
                        	alert("서비스 및 규격서를 수정할 수 없습니다.");
                        }
                    }                
                }
           });            
      
            } else {
            
             $(el).colorbox({
	            title : "서비스변경요청",
	            href : "/korean/pt/popup/PD_svcChangeRequstPop.do?requstSe=" + requstSe,
	            width : "500",
	            height : "300",
	            overlayClose : false,
	            escKey : false,
	            iframe : true
	        });
            }
        } else {
            alert("대상 서비스를 선택하세요.");
        }
        </c:if>
    };

    var jsContentDiffView = function(el, goodsCode, goodsKndCd){

       	$(el).colorbox({
           	title : "사용자 정보",
           	//href  : "/intra/orderManage/purchs/PD_tempUserView.do?goodsCode=" + goodsCode,
           	href  : "BD_webGoodsFormPopUp.do?goodsCode="+goodsCode+"&goodsKndCd="+goodsKndCd,
           	width : "1250",
           	height: "500",
         	iframe: true
     	});
     };    
    
</script>
</head>
<body>
    <!-- 검색 -->
	<div class="supAdm">
	 	   <form name="searchForm" id="searchForm" method="post" action="BD_goodsList.do">
		   <input type="hidden" name="q_excel" id="q_excel" value="" />
		   <input type="hidden" name="goodsCode" id="goodsCode" />
		   <input type="hidden" name="updateYn" id="updateYn" />		   

				<div class="schOpt">
					<table class="tbl_st4 tbl_list_input" summary="서비스목록 검색">
						<caption>서비스목록 검색</caption>
						<colgroup>
							<col width="10%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="col">카테고리</th>
							<td>
								<label><op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:115px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" /></label>
								<label><select id="q_ctgryCd1" name="q_ctgryCd1" title="카테고리1"  style="width:175px">
							 		<option value="">선택</option>
								</select></label>
							
							<%-- <select id="q_ctgryCd2" name="q_ctgryCd2" title="카테고리2" onchange="jsCtgryList(3,this.value)" style="width:115px;z-index:5">
							 <option value="">선택</option>
							</select> --%>
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
							   <label><input type="text" name="q_endDate" id="q_endDate"  <c:if test="${not empty searchMap.q_endDate}"> value="${searchMap.q_endDate}"</c:if> /></label>
								<a href="javascript:"  id="0" class="btns b-btn st3">오늘</a>
								<a href="javascript:"  id="7D" class="btns b-btn st3">1주일</a>
								<a href="javascript:"  id="1M" class="btns b-btn st3">1개월</a>
								<a href="javascript:"  id="3M" class="btns b-btn st3">3개월</a>
							
							</td>
						</tr>
						<tr>
							<th scope="col">노출</th>
							<td>
								<label><input type="radio" name="q_goodsRegistSttus" id="expsrCodes" value="" <c:if test="${fn:length(searchMap.q_goodsRegistSttus) == 0}">checked="checked"</c:if> />전체</label>&nbsp;&nbsp;&nbsp;&nbsp;
			          <c:forEach items="${codeList_expsr}" var="_bean" varStatus="status">
			          	<label><input type="radio" name="q_goodsRegistSttus" id="q_expsrCode_${_bean.prvCd}" <c:if test="${fn:contains(searchMap.q_goodsRegistSttus,_bean.prvCd)}">checked="checked"</c:if> value="<c:out value='${_bean.prvCd}'/>"/> <c:out value='${_bean.prvNm}'/></label>
			          </c:forEach>
							</td>
						</tr>
<!-- 						<tr>
							<th>진행 상태</th>
							<td>
								
							</td>
						</tr> -->
						<%-- <tr class="toggle">
							<th>서비스 명</th>
							<td>
								<label><input type="checkbox" name="crtfcCodes" id="crtfcCodes" value=""
				                <c:if test="${fn:length(searchMap.q_crtfcCodes) == 0}">checked="checked"</c:if> >전체</input></label>
				                <c:forEach items="${codeList_crtfc}" var="_bean" varStatus="status">
				                    <label><input type="checkbox" name="q_crtfcCodes" id="q_crtfcCode_${_bean.prvCd}"
				                    <c:if test="${fn:contains(searchMap.q_crtfcCodes,_bean.prvCd)}">checked="checked"</c:if>
				                    value="<c:out value='${_bean.prvCd}'/>"/> <c:out value='${_bean.prvNm}'/></label>
				                </c:forEach>
							</td>
						</tr> --%>
						</tbody>
					</table>
						
				</div>
<!-- 			<a href="#" class="exSch">확장검색</a>  -->
				<div class="btnArea rig mtm20">
				<a href="javascript:"  onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a >
				<!-- <a href="javascript:"  onclick="jsClean(); jsSearch();" class="btns st5">전체보기</a>  -->
				
				</div>
				<div class="list_st1">
					<!-- p class="head">
						<op:pagerParam page="param/webListPagerParam.jsp" />
						<span class="sel_box">
						<select id="q_rowPerPage" name="q_rowPerPage" onchange="this.form.submit()" >
	               			<option value="20" selected="<c:if test="${20 eq searchMap.q_rowPerPage}">selected</c:if>">20 개씩</option>
	               			<option value="40" selected="<c:if test="${40 eq searchMap.q_rowPerPage}">selected</c:if>">40 개씩</option>
	               			<option value="60" selected="<c:if test="${60 eq searchMap.q_rowPerPage}">selected</c:if>">60 개씩</option>
	               			<option value="100" selected="<c:if test="${100 eq searchMap.q_rowPerPage}">selected</c:if>">100 개씩</option>
         			 	</select>
         			 	</span>
					</p -->
					</form>
					<form name="dataForm" id="dataForm" method="get" action="BD_goodsList.do">
					<table class="tbl_st1" summary="서비스목록">
						<caption>서비스목록</caption>
						<colgroup>
							<col width="5%"/>
							<col width="5%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="10%"/>
							<col width="5%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="5%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">선택</th>
								<th scope="row">구분</th>
								<th scope="row">서비스코드</th>
								<th scope="row">서비스명</th>
								<th scope="row">단가</th>
								<th scope="row">서비스상태</th>
								<th scope="row">등록자</th>
								<th scope="row">등록(변경)일시</th>
								<th scope="row">상태</th>								
							</tr>
						</thead>
						<tbody>
						  <c:set var="index" value="${pager.indexNo}"/>
						  <c:forEach items="${pager.list}" var="_list" varStatus="status">
							<tr>
								<td>
									<label><input type="radio" title="${_list.goodsNm}" name="goodsCodes" value="<c:out value='${_list.goodsCode}'/>" <c:if test="${_list.goodsStat eq '1001' or _list.goodsStat eq '1002' or _list.goodsStat eq '1003' or _list.goodsStat eq '1004'}">disabled="disabled"</c:if>></label>
			          	<input type="hidden" name="goodsStatuss" value="${_list.goodsRegistSttus}" id="goodsStatuss${_list.goodsCode}"/>
			          </td>
								<!-- td><c:out value='${index-status.index}'/></td -->
			          <td>
	                <c:forEach items="${_list.goodsType}" var="_goodsType" varStatus="status">
	                   <c:out value='${_goodsType.GOODSTYNM}'/>
	                   <c:if test="${ not status.last }"><br /></c:if>
	                </c:forEach>
			          </td>
			          <td>
									<c:choose>
										<c:when test="${_list.goodsStat eq '1001' or _list.goodsStat eq '1003' or _list.goodsStat eq '1004'}">
											<a href="javascript:;" onclick="jsContentDiffView(this,'${_list.goodsCode}','${_list.goodsTyCd}');">${_list.goodsCode}</a>
									  </c:when>
			              <c:otherwise>
											<c:out value='${_list.goodsCode}'/>			                            
			              </c:otherwise>
			            </c:choose>	
			                    <%-- <br />(<c:out value='${_list.langNm}'/>) --%>
			          </td>
			          <td>
			          	<c:choose>
			            	<c:when test="${_list.goodsRegistSttus eq 1007 && _list.requstProcessAt ne 'M'}">
											<c:if test="${_list.goodsStat eq '1001' or _list.goodsStat eq '1003' or _list.goodsStat eq '1004' && _list.requstProcessAt ne 'Y'}"><br/>
												<c:out value='${_list.goodsNm}'/>
			                </c:if>
											<c:if test="${_list.goodsStat eq '1005'}"><br/>
			                	<c:out value='${_list.goodsNm}'/>
			                </c:if>
											<c:if test="${_list.goodsStat eq '1002'}"><br/>
			                	<c:out value='${_list.goodsNm}'/>
			                </c:if>
											<c:if test="${_list.goodsStat eq '0000' or _list.goodsStat eq '9999'}"><br/>
			                	<c:out value='${_list.goodsNm}'/>
			                </c:if>
			              </c:when>
			            	<c:otherwise>
			            		<a href="/korean/pt/store/software/BD_view.do?goodsCode=${_list.goodsCode}&pageUrlNm=&goodsTyCd=${_list.goodsTyCd}&ctgryPath=&ctgryCode=&_pathLang=korean&vw=sale"><c:out value='${_list.goodsNm}'/></a>
			              	<%-- <a href="/korean/pt/store/inc/BD_storeView_v2.do?goodsCode=${_list.goodsCode}"><c:out value='${_list.goodsNm}'/></a> --%>
			              	<%--  (<a onclick='jsNotAllowMsg("${_list.goodsCode}");return false;'  href="javascript:;" class="title"><font style="color:red;font-weight:bold;">수정</font></a>) --%>
			            	</c:otherwise>
			          	</c:choose><br>
                	<span>
                  	<c:forEach items="${_list.markFile}" var="fileVo" varStatus="status1">
                   	<c:forEach items="${fileVo}" var="fileVo2" varStatus="status2">
                       <img src="${fileVo2.fileUrl}" alt="<c:out value='${fileVo2.fileDesc}'/>" style="width:35px; height: 35px;" />
                   	</c:forEach>
                   	</c:forEach>			
                	</span>
              	</td>
			          <td>
			          	<fmt:formatNumber value="${_list.svcPc}" type="NUMBER" groupingUsed="true"/>
			          </td>
			          <td>
			          	<c:out value='${_list.goodsRegistSttusNm}'/>
									<!-- 
			                    	<c:if test="${_list.requstProcessAt eq 'N' or _list.requstProcessAt eq 'M' }"><br/>
			                    		(<font style="color:red; font-size: 11px !important;">
			                    	<c:out value='${_list.requstSeNm}'/>요청</font>)
			                    	</c:if>
 									-->			                    	
			          </td>
			          <td><c:out value='${_list.registId}'/></td>
			          <td><c:out value='${_list.registDt}'/></td>
								<td>
									<c:choose>
			            	<c:when test="${_list.goodsRegistSttus eq 1006 or _list.goodsRegistSttus eq 1007 && _list.requstProcessAt ne 'M'}">
											<c:if test="${_list.goodsStat eq '1001' or _list.goodsStat eq '1003' or _list.goodsStat eq '1004'}"><br/>
			                	<a onclick='jsView("${_list.goodsCode}");return false;'  href="javascript:;" class="btns st3">수정</a>
			                </c:if>
											<c:if test="${_list.goodsStat eq '1005'}"><br/>
			                	<a onclick='jsView("${_list.goodsCode}");return false;'  href="javascript:;" class="btns st3">반려</a>
			                </c:if>
											<c:if test="${_list.goodsStat eq '1002'}"><br/>
			                	<font style="color:red;font-weight:bold;">승인대기</font>
			                </c:if>
											<c:if test="${_list.goodsStat eq '0000'}"><br/></c:if>
			              </c:when>
			            	<c:otherwise>
			            	</c:otherwise>
			          	</c:choose>								
								</td>			                    
							</tr>	
						 </c:forEach>
						 <op:no-data obj="${pager}" colspan="9" />
						</tbody>
					</table>
					</form>	
	
					<div class="btnArea rig">
						<a href="#" onclick="jsExcelList(this);" class="btns st1 icn icnXlx f_l" style="margin-top: 0px;">엑셀 다운로드</a>

						<!-- <a id="linkNotDisplay" href="javascript:;" onclick="jsDspy(1007);" class="btns st3">선택항목 비전시</a>
						<a  href="javascript:;" onclick="jsDspy(1006);" class="btns st3">선택항목 전시</a> -->
						<a href="javascript:;" onclick="jsSvcChangeRequst(this);" class="btns st3">서비스변경</a>
					</div>
			</div>
				<!-- paging -->
	          	<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
	        	<!-- //paging -->
	  	
</body>
</html>
