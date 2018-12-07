<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>서비스관리 | 판매하기 | 씨앗 마켓</title>
<op:jsTag type="spi" items="colorbox,datepicker"/>
<!-- 기능별 스크립트 정의 -->
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/apply/apply.js"></script>
	
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

	
var jsDspy = function(el) {
    var indexs = new Array();
    var goodsCodes = new Array();
    var bidSuss = new Array();
    var notifyNum = new Array();
    var notifySeq = new Array();
    var goodKndCd = new Array();
    var demandId = new Array();

    $("input[name=indexs]:checked").each(function (i) {
        indexs[i] = $(this).val();
        goodsCodes[i] = $("#goodsCodes" + this.value).val();
        bidSuss[i] = $("#bidSuss" + this.value).val();
        notifyNum[i] = $("#notifyNum" + this.value).val();
        notifySeq[i] = $("#notifySeq" + this.value).val();
        goodKndCd[i] = $("#goodKndCd" + this.value).val();
        demandId[i] = $("#demandId" + this.value).val();
        
    });
    if(goodsCodes.length == 0){
        alert("항목을 선택하세요.");
        return false;
    }else if(bidSuss != 'Y'){
        alert("계약선정 후 이용 가능합니다.");
        return false;
    }else if(bidSuss == 'Y'){
        $(el).colorbox({
            title : "계약체결 완료처리",
            href : "/korean/pt/popup/PD_applyPop.do?goodsCode="+goodsCodes+"&noifyNum="+notifyNum+"&noifySeq="+notifySeq+"&goodKndCd=" + goodKndCd+"&demandId="+demandId,
            width : "600",
            height : "460",
            overlayClose : false,
            escKey : false,
            iframe : true
        });
        }
	};

    var jsGoodsView = function(notifyNum,notifySeq,goodKndCd,demandId){
        var type ="/${_pathLang}/pt/apply/BD_applytotal.do";
            location.href = type+"?notifyNum="+notifyNum+"&noifySeq="+notifySeq+"&goodKndCd=" + goodKndCd+"&demandId="+demandId;
      };
      
      var jsMovePage = function(page) {
          var p = 5;
          if(page == 'page') {
              p = $('input[name=page]').val();
          } else {
              p = page;
          }
          $("#dataForm #q_currPage").val(p);
          $("#dataForm").submit();

      };
      var jsPageMove = function(){
          $("form[name=srcForm]").attr("method","post");
      	$("form[name=srcForm]").attr("action","/korean/pt/apply/BD_applytotal.do");
      	$("form[name=srcForm]").submit();
      };
      
      var jsSearch = function(page){
          
          var searchKey = $("#q_searchKeyType");
          var searchVal = $("#q_searchVal");
          
          if("" == $.trim($("#q_searchVal").val()) &&  "" != $.trim(searchKey.val())){
              alert(Message.msg.chkSearchVal); 
              searchVal[0].focus();
              return false;
          }
          
          if("" == $.trim(searchKey.val())){
              $("#q_searchVal").val("");
              $("#q_searchVal").val("");
          }
          dataForm.submit();
      };
</script>
</head>
<body>
		<c:set var="index" value="${pager.indexNo}"/>
				<div class="supAdm">
					<form name="dataForm" id="dataForm" method="get" action="BD_ApplyList.do">
					<div class="supAdm answAdm">
						<div class="schArea">
						    <span class="sel_box">
								<select class="list" name="q_searchKeyType" id="q_searchKeyType" title="검색" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
								<option value="services" >서비스명</option>
								<option value="organ" >문의기관</option>
								<option value="answer" selected="selected">답변자</option>					
								</select>
							</span>
							<span class="search-box">
		
								</span>
							<div>
								<input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" maxlength='50' title="검색하실 단어 입력" />
							</div>
							<a href="#" class="btns st5" onclick="jsSearch(); return false;">검색</a>
						</div>
						<div class="list_st1">
							<p class="head">
								<span> 총 ${pager.indexNo}개</span>
							    <span class="sel_box">
					          			 <select id="q_rowPerPage" name="q_rowPerPage" title="보기 갯수 선택" style="width: 100px; z-index: 5; position: absolute; left: -100000px; height: auto;" onchange="this.form.submit()" >
							               <option value="1001">반려</option>
							               <option value="1002">답변</option>
							               <option value="1003">대기</option>
							               <option selected="selected"  value="0">전체</option>
					          			 </select>
								</span>
							</p>	
							<table class="tbl_st1">
		
								<thead>
									<tr>
										<th>선택</th>
										<th>번호</th>
										<th>서비스</th>
										<th>답변자</th>
										<th>기업/기관</th>
										<th>응답 만료일</th>
										<th>답변<br />상태</th>
										<th>선정<br />상태</th>
										<th>계약<br />상태</th>
									</tr>
								</thead>
								<tbody>
								<!-- 메인 화면 DB 내용 -->									
									<c:forEach items="${pager.list}" var="_list" varStatus="status">
									<tr>
										<td>
										<input type="radio" name="indexs" value="<c:out value='${index-status.index}'/>">
			                        	
										<input type="hidden" name="goodsCodes" value="${_list.goodsCode}"id="goodsCodes${index-status.index}">
			                        	<input type="hidden" name="bidSuss" value="${_list.bidSuss}" id="bidSuss${index-status.index}"/></td>
			                   
										<td><c:out value='${index-status.index}'/></td>
									<td>
									<c:forEach items="${codeList_gbnCd}" var="code" varStatus="status">
											<c:if test="${code.prvCd eq _list.bidGbnCd}">
											<!-- 진행상태 -->
												<b class="btns st6">${code.prvNm}</b>
											</c:if>
						              </c:forEach>
						              <!-- 사업명 -->
						              <form name="srcForm" id="srcForm">
						              <input type="hidden" name="notifyNum" id="notifyNum${index-status.index}" value="${_list.notifyNum}">
						              <input type="hidden" name="notifySeq" id="notifySeq${index-status.index}" value="${_list.notifySeq}">
						              <input type="hidden" name="goodKndCd" id="goodKndCd${index-status.index}"value="${_list.goodKndCd}">
						              <input type="hidden" name="demandId" id="demandId${index-status.index}"value="${_list.demandId}">
									<a href="javascript:" onclick="jsGoodsView('${_list.notifyNum}','${_list.notifySeq}','${_list.goodKndCd}','${_list.demandId}')"><i><c:out value='${_list.cmpnyNm}'/></i>
									</a>
									<!-- <a href="javascript:jsPageMove();"><i><c:out value='${_list.cmpnyNm}'/></i></a>	 -->
									</form>
									<c:out value="${_list.applyNm}" />													
								
									</td>
										<td><c:out value='${_list.userNm}'/></td>
										<td><c:out value='${_list.applyMakr}'/></td>
										<td><c:out value='${_list.rplyDt}'/></td>
										<!-- 답변 상태 부분  -->
										<c:forEach items="${codeList_ask}" var="code" varStatus="status">
											<c:if test="${code.prvCd eq _list.askApply}">
												<td><span class="condi_d">${code.prvNm}</span></td>
											</c:if>
						                </c:forEach>						
										<!-- 답변 상태 부분  -->
										
										<!-- 선정 상태 부분  -->
										<c:choose>
											<c:when test="${_list.bidSuss eq 'Y'}">
											<input type="hidden" name="bidSuss" value="${_list.bidSuss}">
												<td><span class="condi_d">선정</span></td>
											</c:when>
											<c:otherwise>
												<td><span class="condi_d">미선정</span></td>
											</c:otherwise>
										</c:choose>	
										<!-- 선정 상태 부분 끝  -->
										<!-- 계약 상태 부분  -->
										<c:choose>
											<c:when test="${_list.cntrGbn eq 'Y'}">
												<td><span class="condi_d">체결</span></td>
											</c:when>
											<c:otherwise>
												<td><span class="condi_d"></span></td>
											</c:otherwise>
										</c:choose>	
				            			<!-- 계약 상태 부분 끝 -->
										</tr>
									</c:forEach>
									<op:no-data obj="${pager}"  colspan="9"/>
								<!-- 메인 화면 DB 내용 끝  -->
								
								</tbody>
							</table>	
							<!-- paging -->
							<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" />
							<!-- //paging -->
	        		          	<div class="btnArea rig">
					<a href="javascript:"  onclick="jsExcelList();" class="f_l btns st1 icn icnXlx">엑셀 다운로드</a>
					<a href="javascript:"  onclick="jsDspy(this);return false;" class="btns st1 icn icnSave">계약체결 완료처리</a>
					<a href="javascript:"  onclick="jsDspy(this);return false;" class="btns st1 icn icnChange">계약변경</a>
				</div>
				
				<ul class="notice_bot">
					<li class="import">※ 공급 계약완료 시 반드시 [계약체결 완료처리] 해주셔야 이용자께서 구매(실적)확인서를 발급 받을 수 있습니다.</li>
					<li>이용자가 계약체결 완료요청 시 서비스명에 <span class="btns st6">계약완료 요청</span> 아이콘이 나타나며, 거래 사실 확인 후 계약체결완료처리 하시면 됩니다.</li>
					<li>계약체결 완료 건은 [공급현황] 메뉴에서 통합관리 합니다.</li>					
				</ul>	
							</div>						
						</div>
						</form>
					</div>	

</body>
</html>
