<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title></title>
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
  
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
    
    <!--[if lt IE 9]>
        <script src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
	    var ctgryCd1 = "${searchMap.q_ctgryCd1}";
	    var ctgryCd2 = "${searchMap.q_ctgryCd2}";
	    var ctgryCd3 = "${searchMap.q_ctgryCd3}";

        $().ready(function () {
            //기본 카테고리(세팅)
            jsCtgryList(1,null);

        }); //ready

	    // 조회버튼 클릭
	    var jsListSearch = function(page){
	         $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_suplySttusList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

        // 카테고리 검색
        var jsCtgryList = function(el ,vl){
          
          var url = "/korean/pt/sale/goods/ND_ctgryList.do?";
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

	    // 검색 일자 선택 클릭
	    var jsSrcTerm = function(termDiv) {
	        $('#searchStartDt').val(jsGetDate(termDiv));
	        $('#searchEndDt').val(jsGetDate());
	    }
	    
	    // 검색 시작일자 셋팅
	    var jsGetDate = function(termDiv){
		    var date = new Date();

		    if(termDiv == 'today'){
		        date.setDate(date.getDate());
		    }else if(termDiv == 'week'){
	            date.setDate(date.getDate()-7);
	        }else if(termDiv == 'oneMonth'){
	            date.setMonth(date.getMonth()-1);
	        }else if(termDiv == 'threeMonth'){
	            date.setMonth(date.getMonth()-3);
	        }
		    var year  = date.getFullYear();
		    var month = date.getMonth() + 1; // 0부터 시작하므로 1더함 더함
		    var day   = date.getDate();
		    if (("" + month).length == 1) { month = "0" + month; }
		    if (("" + day).length   == 1) { day   = "0" + day;   }
		    var dateTxt = "" + year + "-" + month + "-" + day;
		    return dateTxt;
	    }
	    
	    // 검색기간 초기화
	    var jsSrcTermClear = function(){
	        $('#searchStartDt').val('');
	        $('#searchEndDt').val('');
	    }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "/korean/pt/suplerCeart/suplySttusExcel.do?" + $("#dataForm").serialize();
        };
        
        // 계약결과 등록 화면 호출
        var jsMyCntrctForm = function(){
            document.dataForm.action = "/korean/pt/suplerCeart/BD_myCntrctForm.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        // 계약결과 상세보기        
        var jsCtrtcDetailView = function(cntrctSn){
			$('#p_cntrctSn').val(cntrctSn);
            document.dataForm.action = "/korean/pt/suplerCeart/BD_myCntrctForm.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }
    </script>

</head>
<body>
	<!-- <div class="conWrap"> -->
		<div class="supAdm">
			<form name="dataForm" id="dataForm" method="post" action="BD_suplySttusList.do">
			<input type="hidden" name="q_currPage"  id="q_currPage" value="${currPage}"/>	
			<input type="hidden" name="p_notifyNum" id="p_notifyNum" />  					<!-- 상세보기(공고번호) -->
			<input type="hidden" name="p_notifySeq" id="p_notifySeq" />  					<!-- 상세보기(공고차수) -->
			<input type="hidden" name="p_cntrctSn"  id="p_cntrctSn" />    					<!--  상세페이지용[계약관리정보 순서] -->				
				<div class="schOpt on">				
					<table class="tbl_st4" summary="제공현황 검색">
						<caption>제공현황 검색</caption>
						<colgroup>
							<col width="10%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
						<tr>
							<th scope="col">카테고리</th>
							<td>
								<span class="sel_box">
									<select id="q_searchKey" name="q_searchKey"  style="width:175px">
									<option value="">선택</option>
									<option value="1001" <c:if test="${param.q_searchKey eq 1001}" >selected</c:if> >서비스명</option>
									<option value="1002" <c:if test="${param.q_searchKey eq 1002}" >selected</c:if>>계약기관(회사)명</option>
									<option value="1003" <c:if test="${param.q_searchKey eq 1003}" >selected</c:if>>이용기관(회사)</option>
									</select>
								</span><input type="text"  name="q_searchKeyWord" id="q_searchKeyWord" value="${param.q_searchKeyWord}" style="width:570px;margin-left:10px"/>
								<label for="q_searchKey" hidden="hidden"></label><label for="q_searchKeyWord" hidden="hidden"></label>
							</td>
						</tr>
						<tr>
							<th scope="col">서비스구분 명</th>
							<td>
								<op:code id="q_goodsTyCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:115px;z-index:5'" defaultValues="${param.q_goodsTyCd}" type="select" defaultLabel="전체"  />
								<label for="q_goodsTyCd"></label>
							</td>
						</tr>
						<tr>
							<th scope="col">계약체결일</th>
							<td class="term">
								<input type="text" name="searchStartDt" id="searchStartDt" value="${param.searchStartDt}" /><label for="searchStartDt"></label>
								 ~ 
								<input type="text" name="searchEndDt" id="searchEndDt" value="${param.searchEndDt}" /><label for="searchEndDt"></label>
								<a href="#" onclick="jsSrcTerm('today'); return false;" class="btns st3">오늘</a>
								<a href="#" onclick="jsSrcTerm('week'); return false;" class="btns st3">1주일</a>
								<a href="#" onclick="jsSrcTerm('oneMonth'); return false;" class="btns st3">1개월</a>
								<a href="#" onclick="jsSrcTerm('threeMonth'); return false;" class="btns st3">3개월</a>
								<a href="#" onclick="jsSrcTermClear(); return false;" class="btns st3">초기화</a>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
				<div class="btnArea rig mtm20">
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
					    <span class="sel_box">
							<select id="q_rowPerPage" name="q_rowPerPage" onchange="this.form.submit()" >
								<option value="10" <c:if test="${15 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>10 개씩</option>
								<option value="20" <c:if test="${20 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>20 개씩</option>
								<option value="40" <c:if test="${40 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>40 개씩</option>
								<option value="60" <c:if test="${60 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>60 개씩</option>
								<option value="100" <c:if test="${100 eq searchMap.q_rowPerPage}">selected="selected"</c:if>>100 개씩</option>
							</select><label for="q_rowPerPage"></label>
						</span>
					</p>
					
					<table class="tbl_st1" summary="제공현황 목록">
						<caption>제공현황 목록</caption>
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="10%"/>
							<col width="20%"/>
						</colgroup>
						 <thead>
							<tr>
								<th scope="row">번호</th>
								<th scope="row">계약번호</th>
								<th scope="row">계약체결일</th>
								<th scope="row">계약기관(회사)명</th>
								<th scope="row">구분</th>
								<th scope="row">서비스명</th>
								<th scope="row">총 계약기간</th>
								<th scope="row">총 계약금액</th>
							</tr>
						</thead>
						
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
						    <c:set var="precntrctSn" value="0" />
                            <c:forEach items="${pager.list}" var="listData" varStatus="status">
								<tr>
									<td>${index-status.index} </td> <!-- 번호 -->
									
									<c:if test="${listData.cntrctSn ne precntrctSn}">
										<c:set var="spanCnt2" value="${listData.serviceCnt}"/> 
										<c:if test="${listData.serviceCnt > 1}" >

											<td rowspan="${listData.serviceCnt}">
												<a href="#" onclick="javascript:jsCtrtcDetailView('${listData.cntrctSn}'); return false;">${listData.cntrNum}</a>&nbsp; <!-- 계약번호 -->
											</td>
											<td rowspan="${listData.serviceCnt}">
												${listData.cntrDt} <!-- 계약체결일 -->
											</td>
											<%-- <td>${listData.cntrctBeginDe} ~ <br /> ${listData.cntrctEndDe}</td> --%>
											<td rowspan="${listData.serviceCnt}">
												${listData.purchsInsttNm} <!-- 계약기관(회사)명 -->
											</td>	

											<c:forEach items="${pager.list}" var="rowSpanContent2" varStatus="status2">
												<c:if test="${listData.cntrctSn eq rowSpanContent2.cntrctSn}">
													<c:set var="spanCnt2" value="${spanCnt2+1}"/>
												</c:if>
											</c:forEach>

										</c:if>
										<c:if test="${listData.serviceCnt < 2}" > 
											<td> 
												<a href="#" onclick="javascript:jsCtrtcDetailView('${listData.cntrctSn}'); return false;">${listData.cntrNum}</a>&nbsp; <!-- 계약번호 -->
											</td>
											<td>
												${listData.cntrDt} <!-- 계약체결일 -->
											</td>
											<%-- <td>${listData.cntrctBeginDe} ~ <br /> ${listData.cntrctEndDe}</td> --%>
											<td>
												${listData.purchsInsttNm} <!-- 계약기관(회사)명 -->
											</td>	
										</c:if>										
										
										
									</c:if>




									<c:set var="precntrctSn" value="${listData.cntrctSn}" /> 
									<c:set var="spanCnt2" value="0"/>
									
									<td>${listData.goodsTyNm}</td> <!-- 구분 -->
									<td class="tit">${listData.goodsNm}</td> <!-- 서비스명 -->
									<td>
										${listData.splyFormUnit} <!-- 총 계약기간 -->
										<c:if test ="${listData.splyForm eq 1 || listData.splyForm eq 2}">개월</c:if>
										<c:if test ="${listData.splyForm eq 3}">일</c:if>
									</td>
									<td>
										<fmt:formatNumber value="${listData.cntrctamount}" groupingUsed="true"/>원 <!-- 총 계약금액 -->
									</td>
								</tr>
                            </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                                <op:no-data obj="${pager}" colspan="9" />
                            </c:if>
						</tbody>
					</table>
				</div>
				
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
				<!-- 버튼영역 -->
				<div class="btnArea lef">
					<a href="#" onclick="jsExcelList(this);" class="btns st1 icn icnXlx">엑셀 다운로드</a>
					<a href="#" onclick="jsMyCntrctForm(); return false;" class="btns st1 icn icnPaper">계약결과 수기등록</a>
				</div>	
				<!-- //버튼영역 -->
			</form>
		</div>
		
	<!-- </div> -->


  <!-- datepicker -->
  <script>
	$(document).ready(function() {
	    $("#searchStartDt, #searchEndDt").datepicker({
	          showOn: "both", 
	          buttonImage: "/cloud_ver2/new_cloud/images/icn_calen.png", 
	          buttonImageOnly: false,
	          buttonText: "달력"
	    });
	});
  </script>
  <!--// datepicker -->


  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
</body>
</html>