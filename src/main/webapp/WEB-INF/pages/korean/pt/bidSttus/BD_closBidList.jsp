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
    <op:jsTag type="openworks" items="form" />
    <op:jsTag type="spi" items="form,datepicker" />
    
    <script type="text/javascript" src="<%=request.getContextPath()%>/resources/web/board/board.js"></script>
        
    <script type="text/javascript">
	    
	    // 조회버튼 클릭
	    function jsListSearch(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	        document.dataForm.action = "/korean/pt/bidSttus/BD_closBidList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

	    // 검색 일자 선택 클릭
	    var jsSrcTerm = function(termDiv) {
	        $('#searchStartDt').val(jsGetDate(termDiv));
	        $('#searchEndDt').val(jsGetDate());
	    }
	    
	    // 검색 시작일자 셋팅
	    var jsGetDate = function(termDiv){
		    var date = new Date();

	        if(termDiv == 'week'){
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

	    // 공고명 선택 - 상세조회
	    var jsDetailView = function(notifyNum, notifySeq){
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            document.dataForm.action = "/korean/pt/bidSttus/BD_closBidView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
	    }
    </script>

</head>
<body>
	<div class="bidNoti">	
	    <form name="dataForm" id="dataForm">
            <input type="hidden" name="p_notifyNum" id="p_notifyNum"   />                 <!--  상세페이지용 -->
            <input type="hidden" name="p_notifySeq" id="p_notifySeq"   />                 <!--  상세페이지용 -->
	        <input type="hidden" name="q_currPage"  id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
	        <input type="hidden" name="closeYn"     id="closeYn"    value=""/>            <!--  공고 마감여부 -->
						
				<div class="schOpt on">				
					<table class="tbl_st4" summary="사전공고 검색">
					<caption>사전공고 검색</caption>
					<colgroup>
						<col width="10%" />
						<col width="*" />
					</colgroup>
					<thead hidden="hidden">
						<tr>
							<th scope="row" colspan="2">공고명/공고번호</th>
						</tr>
					</thead>
					<tfoot hidden="hidden">
						<tr>
							<th scope="row" colspan="2">공고명/공고번호</th>
						</tr>
					</tfoot>
					<tbody>
						<tr>
							<th scope="row">공고명/공고번호</th>
							<td>
								<div class="cateArea">
								    <span class="sel_box">
										<select name="searchDiv01" id="searchDiv01" title="공고명/공고번호">
											<option value="1001" <c:if test="${searchDiv01 == '1001'}">selected="true"</c:if> >공고명</option>
											<option value="1002" <c:if test="${searchDiv01 == '1002'}">selected="true"</c:if> >공고번호</option>
										</select><label for="searchDiv01"></label>
									</span>
									<div class="inputWrap">
										<input type="text" name="searchKeyWord01" id="searchKeyWord01" value="${searchKeyWord01}" title="공고명/공고번호 검색"/><label for="searchKeyWord01"></label>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">공고일/개찰일</th>
							<td class="term">
							    <span class="sel_box">
									<select name="searchDiv02" id="searchDiv02" title="공고일/개찰일">
										<option value="1001" <c:if test="${searchDiv02 == '1001'}">selected="true"</c:if> >공고일</option>
										<option value="1002" <c:if test="${searchDiv02 == '1002'}">selected="true"</c:if> >개찰일</option>
									</select><label for="searchDiv02"></label>
								</span>
								<input type="text" name="searchStartDt" id="searchStartDt" value="${searchStartDt}" title="시작일"/><label for="searchStartDt"></label>
								 ~ 
								<input type="text" name="searchEndDt" id="searchEndDt" value="${searchEndDt}" title="종료일"/><label for="searchEndDt"></label>
								<a href="#none" onclick="jsSrcTerm('week'); return false;" 				class="btns st3" title="1주일">1주일</a>
								<a href="#none" onclick="jsSrcTerm('oneMonth'); return false;" 		class="btns st3" title="1개월">1개월</a>
								<a href="#none" onclick="jsSrcTerm('threeMonth'); return false;" 	class="btns st3" title="3개월">3개월</a>
								<a href="#none" onclick="jsSrcTermClear(); return false;" 				class="btns st3" title="초기화">초기화</a>
							</td>
						</tr>
						<tr>
							<th scope="row">수요기관 명</th>
							<td>
								<input type="text" name="searchKeyWord02" id="searchKeyWord02" value="${searchKeyWord02}" title="수요기관 명"/><label for="searchKeyWord02"></label>
							</td>
						</tr>	
						</tbody>				
					</table>
				</div>
				<div class="btnArea rig mtm20">
					<a href="#none" onclick="javascript:jsListSearch(0);" class="btns st5 icn icnSearch" title="검색">검색</a>					
				</div>
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv03" id="searchDiv03" onchange="javascript:jsListSearch(0);">
								<option value="1001" <c:if test="${searchDiv03 == '1001'}">selected="true"</c:if> >신규 등록순</option>					
								<option value="1002" <c:if test="${searchDiv03 == '1002'}">selected="true"</c:if> >마감 임박순</option>
								<option value="1003" <c:if test="${searchDiv03 == '1003'}">selected="true"</c:if> >수의계약</option>
								<!-- option value="1004" <c:if test="${searchDiv03 == '1004'}">selected="true"</c:if> >변경공고</option -->
							</select><label for="searchDiv03"></label>
						</span>
					</p>

					<table class="tbl_st1" summary="사전공고 목록">
					<caption>사전공고 목록</caption>
					<colgroup>
						<col width="10%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="20%" />
						<col width="10%" />
						<col width="20%" />
					</colgroup>
					<tfoot hidden="hidden">
						<tr>
							<th scope="row" colspan="7">공고명/공고번호</th>
						</tr>
					</tfoot>
						<thead>
							<tr>								
								<th scope="row">공고번호</th>
								<th scope="row">분류</th>
								<th scope="row">공고명</th>
								<th scope="row">수요기관</th>
								<th scope="row">계약방법</th>
								<th scope="row">진행상태</th>
								<th scope="row">공고일시<br />(마감일시)</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
                            <c:forEach items="${pager.list}" var="listData" varStatus="status">
								<tr>
									<td>${listData.notifyNum}-${listData.notifySeq}</td>
									<td>${listData.bidClassNm}</td>
									<td class="tit"><a href="#" onclick="jsDetailView('${listData.notifyNum}', '${listData.notifySeq}'); return false;">${listData.bidNotifyNm}</a></td>
									<td>${listData.realDmndOrgn}</td>
									<td>${listData.cntrMothodNm}</td>
									<td>${listData.bidPgesStatNm}</td>
									<td>${listData.strtDt}&nbsp;${listData.strtTime}시
										<i>(${listData.clseDt}&nbsp;${listData.clseTime}시)</i>
									</td>
								</tr>
                            </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                                <op:no-data obj="${pager}" colspan="7" />
                            </c:if>																	
						</tbody>
					</table>								
				</div>	
				
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
		</form>
	</div>
<!--// content -->

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


</body>
</html>