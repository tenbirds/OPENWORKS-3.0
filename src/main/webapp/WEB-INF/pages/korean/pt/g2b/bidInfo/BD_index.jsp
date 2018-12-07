<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<op:jsTag type="spi" items="datepicker" />
<op:jsTag type="openworks" items="ui" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
<script type="text/javascript">
  
  var dateFormat = /^(\d{4})\-(\d{2})\-(\d{2}).*$/;
  var dateOrder = "$1-$2-$3"

  $().ready(function () {

    if("${baseVo.sDate}" == ""){
      var nowDt = new Date();
      var endDt = new Date();
      endDt.setDate(endDt.getDate() - 7);
      $('#eDate').val(nowDt.toJSON().replace(dateFormat,dateOrder));
      $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
    }
    
    // 기간,발표일 달력 생성
    $("a#d_3M").click(function(){
        var sType = $(this).attr('id');
        var nowDt = new Date();
        var endDt = new Date();
          
        $('#eDate').val(nowDt.toJSON().replace(dateFormat,dateOrder));
        switch(sType){
            case 'd_7D':
                endDt.setDate(endDt.getDate() - 7);
                $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
                break;
            case 'd_15D':
              endDt.setDate(endDt.getDate() - 15);
              $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
                break;
            case 'd_3M':
                endDt.setMonth(endDt.getMonth() - 3);
                $('#sDate').val(endDt.toJSON().replace(dateFormat,dateOrder));
                  break;
            default:
                break;
        }
    });//ready end
    
    $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});
    $('#sDate').datepicker({
      dateFormat: 'yy-mm-dd',
      buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
      showOn : 'button'
    });
    $('#eDate').datepicker({
      dateFormat: 'yy-mm-dd',
      buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
      showOn : 'button'
    });
    
    $("#wait").css("display","block");
 
      
  });

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
  
  var jsLoading = function(){
    
    if(!confirm("입찰정보 검색은 상당한 시간이 소요됩니다. 검색하시겠습니까?")){
      return false;
    }
    $(".searchBtn").hide();
    $("#loading-container").show();
    
    return true;
  };
  
  var jsSearch = function(){
    
    var sDate = new $("#sDate").val().split("-");
    var eDate = $("#eDate").val().split("-");
    var sDateObj = new Date(sDate[0], Number(sDate[1])-1, sDate[2]);
    //월단위 체크를 위한 값
    var cDateObj = new Date(eDate[0], Number(eDate[1])-1, eDate[2]);
    cDateObj.setMonth(cDateObj.getMonth() - 3);
    //아래는 일단위 체크시 사용
  	//var eDateObj = new Date(eDate[0], Number(eDate[1])-1, eDate[2]);
    //var betweenDay = (eDateObj.getTime() - sDateObj.getTime())/1000/60/60/24;
    
    //월단위 체크(3개월)
    /* if(sDateObj < cDateObj){
        alert("검색기간은 최대 3개월 까지만 검색 가능합니다.");
        return false;
    } */
    /* 일단위 체크시 사용
    if(betweenDay > 7){
      alert("검색기간은 최대 1주일 까지만 검색 가능합니다.");
      return false;
    }
     */
    var path = "ND_search.do" ;
    var searchKey = $(":input:radio[name=searchKey]:checked").val();    
    var params = "params = {";
    
    if(searchKey != undefined && searchKey != '' ){
        params += "'searchKey' : '"+ searchKey +"',";
        params += "'searchVal' : '"+ $("#searchVal").val() +"',";
    }
    params += "'flag'     	:'" + $("#flag").val() + "'," ;
    params += "'dateType' 	:'" + $("#dateType").val() + "'," ;
    params += "'sDate'    	:'" + $("#sDate").val() + "'," ;
    params += "'eDate'    	:'" + $("#eDate").val() + "'," ;
    params += "'searchType':'" + $("#searchType").val() + "'," ;
    params += "'searchNmVal':'" + $("#searchNmVal").val() + "'," ;
	params += "}" ;
        
    
    post_to_url(path,eval(params),"GET");
    
  };

  var jsClean = function(){
    var params = {
        flag : $("#flag").val()
    }
    post_to_url("BD_index.do",params,"GET");
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
  }
  
</script>

<form name="dataForm" id="dataForm" method="get" action="ND_paging.do">
	<input type="hidden" id="flag" name="flag" value="${baseVo.flag}" />  
	<!-- contents -->
	<div class="contents">
		
	<!-- section -->
	<div class="section">
		<!-- tab -->
		<div class="tab_link e2">
			<a href="BD_index.do?flag=1001" <c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">class="on"</c:if>>입찰정보</a>
			<a href="BD_index.do?flag=1002" <c:if test="${baseVo.flag eq '1002'}">class="on"</c:if>>계약현황</a>
		</div>
		<!-- 20161230 화면수정 -->					
			<%-- <div class="tab-area">
			<ul>
			<li><a href="BD_index.do?flag=1001" <c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">class="on"</c:if>>용역입찰정보 검색</a></li>
			<li><a href="BD_index.do?flag=1002" <c:if test="${baseVo.flag eq '1002'}">class="on"</c:if>>계약현황 검색 </a></li>
			</ul>						
		</div> --%>
		<!-- //tab -->
	</div>
	<!-- //section -->
	
	<!-- 용역 입찰 정보 -->
   	<c:if test="${empty baseVo.flag || baseVo.flag eq '1001'}">
	<!-- section -->

	<div class="section mt30">
		<div class="tab-search">
			<table class="tbl_st4">
				<caption>검색</caption>
				<colgroup>
				<col style="width:130px;"/>
				<col style="width:;"/>
				</colgroup>
				<tbody>
					<tr>
						<th>공고명/공고번호</th>
						<td>
						<div class="cateArea">
						    <span class="sel_box">
								<select id ="searchType" name="searchType"  title="검색하실 공고명, 공고번호 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 115px; position: absolute; left: -100000px; height: auto;">
									<option value="BID_NM" <c:if test="${empty baseVo.searchType || baseVo.searchType eq 'BID_NM' }"> selected="selected" </c:if>>공고명</option>
									<option value="BID_NOTIFY_NO" <c:if test="${baseVo.searchType eq 'BID_NOTIFY_NO' }"> selected="selected" </c:if>>공고번호</option>
								</select>
							</span>
							<div class="inputWrap">
								<input type="text" id="searchNmVal" name="searchNmVal" title="공고명 입력" value="${baseVo.searchNmVal}" class="w650" />
							</div>
						</div>	
						</td>
					</tr>					
					<tr>
						<th>공고/개찰일</th>
						<td class="term">
						    <span class="sel_box">
							<select id="dateType" name="dateType" title="검색하실 일자 공고일, 개찰일 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width: 115px; position: absolute; left: -100000px; height: auto;">
								<option value="PBLANC_START_DATE" <c:if test="${empty baseVo.dateType || baseVo.dateType eq 'PBLANC_START_DATE' }"> selected="selected" </c:if>>공고일</option>
	            				<option value="BID_STRT_DATE" <c:if test="${baseVo.dateType eq 'BID_STRT_DATE' }"> selected="selected" </c:if>>개찰일</option>
							</select>
							</span>
							<input type="text" name="sDate" id="sDate" readonly="readonly" title="시작일 레이어 달력 열림" value="${baseVo.sDate}" /> ~
							<input type="text" name="eDate" id="eDate" readonly="readonly" title="종료일 레이어 달력 열림" value="${baseVo.eDate}" />
							<a href="javascript:" id="d_3M" class="btns st3">3개월</a>
						</td>
					</tr>
					<tr>
						<th>기관명</th>
						<td>
							<label><input type="radio" value="ORDER_ORGN_NM" id="searchKey01" name="searchKey" <c:if test="${empty baseVo.searchKey || baseVo.searchKey eq 'ORDER_ORGN_NM'}">checked="checked"</c:if>/>공고기관</label>
							<label><input type="radio" value="REAL_ORGN_NM"  id="searchKey02" name="searchKey" <c:if test="${baseVo.searchKey eq 'REAL_ORGN_NM'}">checked="checked"</c:if>/>수요기관</label>									
              				<input type="text" value="<c:out value='${baseVo.searchVal}' />" title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" />
							<!-- 20161230 화면수정 -->	
							<%--<input type="radio" value="ORDER_ORGN_NM" id="searchKey01" name="searchKey" <c:if test="${empty baseVo.searchKey || baseVo.searchKey eq 'ORDER_ORGN_NM'}">checked="checked"</c:if>/><label for="" class="ml5">공고기관</label>
      						<input type="radio" value="REAL_ORGN_NM" id="searchKey02" name="searchKey" <c:if test="${baseVo.searchKey eq 'REAL_ORGN_NM'}">checked="checked"</c:if>/><label for="" class="ml5">수요기관</label>
      						<input type="text" value="<c:out value='${baseVo.searchVal}' />" title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" class="w304 ml20"/> --%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- //section -->
	<!-- btn-area -->
	<div class="btn-area mt10 ar">
		<a href="javascript:" onclick="jsSearch();"class="btns st5 icn icnSearch">검색</a>
		<a href="javascript:" onclick="jsClean();" class="btns st3">초기화</a>
	</div>
	<!-- //btn-area -->
	
	<!-- section -->
	<div class="section">
<!-- 	<h3 class="stitle">입찰정보 목록</h3> -->
		<op:pagerParam page="param/webListPagerParam.jsp" /> 
		<!-- list -->
		<div class="list_st1">
			<table class="tbl_st1">
				<caption>리스트</caption>
				<colgroup>
				 <col style="width:5%"/>
				<col style="width:10%"/>
				<col style="width:7%"/>
				<col style="width:*"/>
				<col style="width:13%"/>
				<col style="width:13%"/>
				<col style="width:10%"/>
				<col style="width:10%"/> 
				</colgroup>
				<thead>
					<tr>
						<th>업무</th>
						<th>공고번호·차수</th>
						<th>분류</th>
						<th>공고명</th>
						<th>공고기관</th>
						<th>수요기관</th>
						<th>계약방법</th>
						<th>입력일시<br /><span class="caption">입찰마감일시</span></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${pager.list}" var="baseVo" varStatus="status"> 
				<tr>
					<td><c:out value="${baseVo.bidType}" /></td>
					<td><c:out value="${baseVo.bidNotifyNo}" />-<c:out value="${baseVo.bidNotifySeqNo}" /></td>
					<td><c:out value="${baseVo.bidMthd}" /></td>
				    <td class="title">
				<a href='http://www.g2b.go.kr:8081/ep/invitation/publish/bidInfoDtl.do?bidno=<c:out value="${baseVo.bidNotifyNo}"/>&bidseq=<c:out value="${baseVo.bidNotifySeqNo}" />' target="_blank"><c:out value="${baseVo.bidNm}" /></a>
				</td>
				<td><c:out value="${baseVo.orderOrgnNm}" /></td>
				<td><c:out value="${baseVo.realOrgnNm}" /></td>
				<td><c:out value="${baseVo.cntrctMth}" /></td>
				<td><c:out value="${fn:substring(baseVo.bidStrtDate,0,10)}" /><br/><span class="caption"><c:out value="${fn:substring(baseVo.bidEndDate,0,10)}" /></span>
				
				</td>
				</tr>
				</c:forEach>
		          	<op:no-data obj="${pager}" colspan="8" />
				</tbody>
			</table>
		</div>
		<!-- //list -->

		<!-- paging -->
	    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
	    <!-- //paging -->
	</div>
	<!-- //section -->
	</c:if>
	
	
	
	<!-- 계약현황 검색 -->
   			<c:if test="${baseVo.flag eq '1002'}">
   			<!-- section -->
	<div class="section mt30">
		<div class="tab-search">
			<table class="tbl_st4">
				<caption>검색</caption>
				<colgroup>
				<col style="width:130px;"/>
				<col style="width:;"/>
				</colgroup>
				<tbody>
					<tr>
						<th>계약명</th>
						<td><input type="text" id="searchNmVal" name="searchNmVal" title="계약건명 입력" value="${baseVo.searchNmVal}" class="w650"/></td>
					</tr>
					<tr>
						<th>계약일자</th>
						<td class="term">
							<input type="hidden" id="dateType" name="dateType" value="<c:if test="${empty baseVo.dateType || baseVo.dateType eq 'CNTRCT_DATE' }">CNTRCT_DATE</c:if>" />
							<input type="text" name="sDate" id="sDate" readonly="readonly" title="시작일 레이어 달력 열림" value="${baseVo.sDate}" /> ~
							<input type="text" name="eDate" id="eDate" readonly="readonly" title="종료일 레이어 달력 열림" value="${baseVo.eDate}" />
							<a href="javascript:" id="d_3M" class="btns st3">3개월</a>
						</td>
					</tr>
					<!-- 20161230 화면수정 -->									
						<%--<tr>
						<th>계약일자</th>
						<td>
							<div class="calendar_input">
								<input type="hidden" id="dateType" name="dateType" value="<c:if test="${empty baseVo.dateType || baseVo.dateType eq 'CNTRCT_DATE' }">CNTRCT_DATE</c:if>" />
							  	<input type="text" class="input" name="sDate" id="sDate" readonly="readonly" title="시작일 레이어 달력 열림" style="width:100px;" value="${baseVo.sDate}" />
							</div>
							<span class="divide"> ~ </span>
							<div class="calendar_input end">
							  	<input type="text" class="input" name="eDate" id="eDate" readonly="readonly" title="종료일 레이어 달력 열림" style="width:100px;" value="${baseVo.eDate}" />
							</div>
							<a href="javascript:" id="d_3M" class="btns st3">3개월</a>
							<p class="caption mt10">검색기간은 최대 3개월까지 가능</p>
						</td>
					</tr> --%>
					
					<tr>
						<th>기관별검색</th>
						<td>
							<label><input type="radio" value="ORDER_ORGN_NM" id="searchKey" name="searchKey" <c:if test="${empty baseVo.searchKey || baseVo.searchKey eq 'ORDER_ORGN_NM'}">checked="checked"</c:if>/>공고기관</label>
							<label><input type="radio" value="REAL_ORGN_NM" id="searchKey" name="searchKey" <c:if test="${baseVo.searchKey eq 'REAL_ORGN_NM'}">checked="checked"</c:if>/>수요기관</label>									
              				<input type="text" value="<c:out value='${baseVo.searchVal}' />" title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" />
              				<!-- 20161230 화면수정 -->	
							<%--<input type="radio" value="ORDER_ORGN_NM" id="searchKey" name="searchKey" <c:if test="${empty baseVo.searchKey || baseVo.searchKey eq 'ORDER_ORGN_NM'}">checked="checked"</c:if> class="ml20"/><label for="" class="ml5">공고기관</label>
							<input type="radio" value="REAL_ORGN_NM" id="searchKey" name="searchKey" <c:if test="${baseVo.searchKey eq 'REAL_ORGN_NM'}">checked="checked"</c:if> class="ml20"/><label for="" class="ml5">수요기관</label>
							<input type="text" value="<c:out value='${baseVo.searchVal}' />" title="카테고리내 검색 단어 입력" name="searchVal" id="searchVal" class="w304 ml20"/> --%>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<!-- //section -->
	<!-- btn-area -->
	<div class="btn-area mt10 ar">
		<a href="javascript:" onclick="jsSearch();" class="btns st5 icn icnSearch">검색</a>
		<a href="javascript:" onclick="jsClean();" class="btns st3">초기화</a>
	</div>
	<!-- //btn-area -->
	
	<!-- section -->
	<div class="section">
<!-- 		<h3 class="stitle">계약현황 목록</h3> -->
		<op:pagerParam page="param/webListPagerParam.jsp" />
		<!-- list -->
		<div class="list_st1">
			<table class="tbl_st1">
				<caption>리스트</caption>
				<colgroup>
				<col style="width:12%"/>
				<col style="width:18%"/>
				<col style="width:14%"/>
				<col style="width:12%"/>
				<col style="width:*"/>
				<col style="width:11%"/>
				<col style="width:11%"/>

				</colgroup>
				<thead>
					<tr>
						<th>계약번호</th>
						<th>계약건명</th>
						<th>계약금액</th>
						<th>계약일자</th>
						<th>계약기간</th>
						<th>계약업체</th>
						<th>수요기관</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
					<tr>
						<td><c:out value="${baseVo.cntrctNo}" /></td>
						<td class="title">
							<a href='http://www.g2b.go.kr:8067/contract/contDetail.jsp?Union_number=<c:out value="${baseVo.cntrctUnionNo}" />' target="_blank"><c:out value="${baseVo.cntrctNm}" /></a></td>
						<td><fmt:formatNumber value="${baseVo.cntrctThisTimeAmt}" groupingUsed="true"/></td>
						<fmt:parseDate value='${baseVo.cntrctDate}' var='cntrctDate' pattern="yyyyMMdd" scope="page"/>
						<td><fmt:formatDate value="${cntrctDate}" pattern="yyyy-MM-dd"/></td>
						<td><c:out value="${baseVo.cntrctPd}" /></td>
						<td><c:out value="${baseVo.mainCntrctEntrpsNm}" /></td>
						<td><c:out value="${baseVo.realOrgnNm}" /></td>
					</tr>
		          	</c:forEach>
		          	<op:no-data obj="${pager}" colspan="7" />
				</tbody>
			</table>
		</div>
		<!-- //list -->
		<!-- paging -->
	    <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
	    <!-- //paging -->
	</div>
	<!-- //section -->
   			</c:if>
   
	<div id="loading-container" class="loading-container">
        <img src="/resources/openworks/theme/default/images/loading/loading34.gif" alt="로딩중"/>
    </div>
</div>
<!-- //contents -->
</form>
