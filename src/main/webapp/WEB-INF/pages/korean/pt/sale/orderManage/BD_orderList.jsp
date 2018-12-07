<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="orderManageVO" class="zes.openworks.web.sale.orderManage.OrderManageVO" />

<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<op:jsTag type="spi" items="validate,form,colorbox,datepicker"/>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
    
<script type="text/javascript">

var ctgryCd1 = "${searchMap.q_ctgryCd1}";
var ctgryCd2 = "${searchMap.q_ctgryCd2}";
var ctgryCd3 = "${searchMap.q_ctgryCd3}";


    $().ready(function () {
        
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
        });$('input[name="q_langCodes"]').click(function() {
            if($(this).is(':checked')) {
                $("#langCodes").attr("checked",false);
            }
        });
        
        //언어 값이 있으면 언어검색 활성화
        <c:if test="${fn:length(searchMap.q_langCodes) > 0}">
          $(".ext_table .btn_ext a span").attr("class","on");
          $("#exttbl").show();
        </c:if>
        
        
        // 기간,발표일 달력 생성
        $("table.tbl_list_input a.b-btn").click(function(){
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
        
    });//ready end

    
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
        document.dataForm.action = "BD_orderList.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };

   var jsClean = function(){
        
       $("#q_beginDate").val("2000-01-01");
       $("#q_endDate").val("2100-12-31");
       $("#q_searchVal").val("");
       
       $("#q_goodsTyCd").val("").trigger("change");

       $("#langCodes").attr("checked",true);
       $('input[name="q_langCodes"]:checked').each(function (i) {
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
    
    
    var jsOrderView = function(el,num){
      $(el).colorbox({
          title : "신청내용",
          href : "/${_pathLang}/pt/popup/PD_reqstCnView.do?purchsNo=" + num,
          width : "500",
          height: "600",
          iframe: true
      });
    };
    
    var jsSourceDwon = function(filePath,fileNm){
      location.href = "/component/file/ND_directDownload.do?fn=" + fileNm + "&fp=" + filePath;
    };    

    var jsExcelList = function() {
        $("#q_excel").val("12");
        location.href = "BD_orderList.do?" + $("#dataForm").serialize();
        $("#q_excel").val("");
    };
</script>
</head>
<body>
<div class="contents">
	<!-- title-area -->
	<div class="title-area">
		<h2>구매문의 내역</h2>
	</div>
	<!-- //title-area -->
		<form name="dataForm" id="dataForm" method="get" action="BD_orderList.do">
 		 <input type="hidden" id="q_excel" name="q_excel" value="" />
			
		
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
											<op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:120px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="구분" onchange="jsCtgryList(1,null)" />
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
	              <a href="javascript:" id="d_0" class="b-btn mr05 type1"><strong><span>오늘</span></strong></a>
				  <a href="javascript:" id="d_7D" class="b-btn mr05 type1"><strong><span>1주일</span></strong></a>
				  <a href="javascript:" id="d_1M" class="b-btn mr05 type1"><strong><span>1개월</span></strong></a>
				  <a href="javascript:" id="d_3M" class="b-btn mr05 type1"><strong><span>3개월</span></strong></a>
	            </td>
	        </tr>
	        </tbody>
	        </table>
<!-- 
	          <div class="ext_table">           
	            <table id="exttbl" class="tbl_list_input ext">
	            <caption>
	                <strong>검색조건 확장</strong>
	                <details>
	                    <summary>확장 검색 조건을 입력하는 서식입니다.</summary>
	                </details>
	            </caption>
	            <colgroup>
	                <col style="width:17%">
	                <col>
	            </colgroup>
	            <tbody>
		          <tr>
			          <th scope="row">언어</th>
			          <td>
			              <input type="checkbox" name="langCodes" id="langCodes" value="" title="언어 리스트"
			            <c:if test="${fn:length(searchMap.q_langCodes) == 0}">checked="checked"</c:if> />전체&nbsp;&nbsp;&nbsp;&nbsp;
			            <c:forEach items="${codeList}" var="_bean" varStatus="status">
			                <input type="checkbox" name="q_langCodes" id="q_langCode_${_bean.langCode}"  title="언어 리스트"
			                    <c:if test="${fn:contains(searchMap.q_langCodes,_bean.langCode)}">checked="checked"</c:if>
			                value="<c:out value='${_bean.langCode}'/>"/> <c:out value='${_bean.langNm}'/>&nbsp;&nbsp;&nbsp;&nbsp;
			            </c:forEach>
			          </td>
			      </tr>
	            </tbody>
	            </table>
	             <p class="btn_ext">
	                <a href="#ToggleEvent" class="arrow bottom"><span class="off">확장검색</span></a>
	            </p>
	        </div>
-->
	        </div>
	        <!-- btn-area -->
			<div class="btn-area mt10 ar">
				<a href="javascript:" onclick="jsSearch();" class="b-btn search type2"><strong><span>검 색</span></strong></a><a href="javascript:" onclick="jsClean(); jsSearch();" class="b-btn ml10 type1"><strong><span>전체보기</span></strong></a>
			</div>
			<!-- //btn-area -->
	        </div>
	        </fieldset>
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
		          <strong>서비스주문 검색 결과 목록</strong>
		          <details>
		              <summary>번호, 구분, 구매번호, 주문일시, 서비스명, 언어, 이용자, 상태, 처리 정보를 제공합니다.</summary>
		          </details>
			      </caption>
			      <colgroup>
			          <col style="width:45px">
			          <col style="width:90px">
			          <col style="width:75px">
			          <col style="width:90px">
			          <col>
			          <col style="width:75px">
			          <col style="width:70px">
			          <col style="width:95px">
			          <col style="width:65px">
			      </colgroup>
			      <thead>
			          <tr>
				          <th scope="col">번호</th>
				          <th scope="col">구분</th>
				          <th scope="col">구매번호<br />(언어)</th>
				          <th scope="col">주문일시</th>
				          <th scope="col">서비스명</th>
				          <th scope="col">단가(\)</th>
				          <th scope="col">이용자</th>
				          <th scope="col">판매방식</th>
				          <th scope="col">처리</th>                             
				      </tr>
			      </thead>
			      <tbody>
			          <c:set var="index" value="${pager.indexNo}" />
			          <c:set var="omTyCdDw" value="<%=orderManageVO.OM_TY_CD_DW %>" />
			          <c:set var="omTyCdVw" value="<%=orderManageVO.OM_TY_CD_VE %>" />
			          <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
			              <tr>
			                  <td class="num"><c:out value='${index-status.index}'/></td>
			                  <td>${baseVo.ctgryClNm}</td>
			                  <td><c:out value='${baseVo.purchsNo}'/><br />(<c:out value='${baseVo.langNm}'/>)</td>
			                  <td><span><c:out value='${baseVo.orderDt}'/></span></td>
			                  <td class="title"><a href="javascript:" onclick="jsGoodsView(${baseVo.goodsCd},'')" ><c:out value='${baseVo.goodsNm}'/></a>                    
			                  </td>
			                  <td>${baseVo.goodsPc}</td>
			                  <td>
			                      <span><a href="#javascript:" onclick="jsRegistView(this,'${baseVo.ordrrId}')"><c:out value='${baseVo.ordrrNm}'/></a></span>
			                      <span>(<c:out value='${baseVo.ordrrId}'/>)</span>
			                  </td>
			                  <td>
			                      <%-- <c:if test="${baseVo.sleMthdCd eq omTyCdDw}"> --%>
			                      <c:if test="${baseVo.ordrOx eq 'O'}">
			                        <span class="btn_light_gray02">
			                            <a href="javascript:" onclick="jsOrderView(this,'${baseVo.purchsNo}')" title="신청내용보기"  >신청내용보기</a>
			                        </span>
			                      </c:if>
			                      <%-- <c:if test="${baseVo.sleMthdCd eq omTyCdVw}"> --%>
			                      <c:if test="${baseVo.ordrOx eq 'X'}">
			                        <%-- <c:if test="${not empty baseVo.goodsDwldUrl}"> --%>
			                          <a href="#none" onclick="jsSourceDwon('${baseVo.goodsDwldUrl}','${baseVo.goodsDwldNm}');"><button class="blue" type="button">다운로드</button></a>
			                        <%-- </c:if> --%>
			                      </c:if>
			                  </td>
			                  <td>
			                      <c:if test="${baseVo.orderCnfirmAt eq 'Y'}">
			                          <span class="condi_a">확인</span>
			                      </c:if>
			                      <c:if test="${baseVo.orderCnfirmAt eq 'N'}">
			                          <span class="condi_b">미확인</span>
			                      </c:if>
			                  </td>
			              </tr>
			          </c:forEach>
			          <op:no-data obj="${pager}" colspan="9" />
			      </tbody>
			  </table>
			  </div>
			  <!-- //목록 끝 -->
			  <div class="btn-area mt10">
			      <a href="javascript:;" onclick="jsExcelList(this);" class="b-btn download mr05 type1"><strong><span>엑셀 다운로드</span></strong></a>
			  </div>
			      <!-- paging -->
			    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
			    <!-- //paging -->
			  </div>
			  
			  <!-- //검색 리스트 영역 --> 
			</form>
		</div>
</body>
</html>