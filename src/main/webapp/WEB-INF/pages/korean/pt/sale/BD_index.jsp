<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title></title>
<script type="text/javascript" src="/resources/web/theme/common/js/fakeselect.js"></script>
<script type="text/javascript">

/* 20170111 현재 없어진 기능 */
/* $().ready(function() {
	<c:if test="${storeLangList[0].storeSction != 'Y'}">
	if (confirm("다국어 판매정보에서 언어상점이 개설되지 않았습니다. \n 회원정보 변경에서 다국어 판매내정보의 ${storeLangNm.langNm} 상점을 개설하시겠습니까?")) {
	    // 이전소스  
	    //location.href="/english/pt/register/BD_password.do";
	    
	    //{{ BH, 2015.11.24, 도메인관리삭제로 인한 소스변경 
		// 변경소스
		location.href="/korean/pt/register/BD_password.do";	
		//}}
	    }
	</c:if>
}); */


 var jsView = function(el,seq,type){
    var type = (type == "1001" ? "답변등록" : "답변수정");
    $(el).colorbox({
        title : type,
        href : "/korean/pt/sale/support/qna/PD_insertForm.do?goodsInqryNo=" + seq,
        width : "778",
        height: "490",
        iframe: true
    });
  };
  
  var jsRegistBack = function(el,goodsCode,goodsRegistSttus) { 
      
	if(goodsRegistSttus == 1001 || goodsRegistSttus == 1002 || goodsRegistSttus == 1004){
	    alert("승인대기/임시저장 상태에서는\n반려사유가 없습니다.");
        return false;
	}
      $(el).colorbox({
          title : "반려사유",
          href : "/korean/pt/sale/goods/PD_returnReasonPop.do?goodsCode="+goodsCode,
          width : "500",
          height : "400",
          overlayClose : false,
          escKey : false,
          iframe : true
      });
  };

  
    // 조회버튼 클릭
    function jsListSearch(page){
        $("#dataForm input[name=q_currPage]").val(page);
        document.dataForm.action = "/korean/pt/suplerCeart/BD_beforeRequestList.do";
    	document.dataForm.method = "GET";
    	document.dataForm.submit();
    }
    
    
</script>
</head>
<body>

	<!-- contents -->
	<div class="contents sale-main">

	
	<div class="supAdm dash">
		<ul>
			<!-- 최근게시물1 -->
			<li>
				<h3>
					처리해야할 견적요청서<!-- before_title : 처리해야 할 구매 문의 서비스 -->
					<i class="total">${orderGCount}</i>
					<!-- <a href="orderManage/BD_orderList.do">더보기</a> -->
					<a href="/korean/pt/suplerCeart/BD_beforeRequestList.do">더보기</a>
				</h3>
				<table class="tbl_st1 la_1" summary="처리해야할 견적요청서">
					<caption>처리해야할 견적요청서</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<!-- <th>번호</th> -->
							<th scope="col">서비스 명</th>
							<th scope="col">작성일</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<!-- <th>번호</th> -->
							<th scope="col">서비스 명</th>
							<th scope="col">작성일</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${orderG}" var="_orderG" varStatus="status">
            <tr>
            	<td>
								<a href="/korean/pt/suplerCeart/BD_beforeRequestDetailView.do?p_notifyNum=${_orderG.notifyNum}&p_notifySeq=${_orderG.notifySeq}&p_endsUserId=${_orderG.userId}"> ${fn:substring(_orderG.goodsNm,0,30)}<c:if test="${fn:length(_orderG.goodsNm) > 30}">...</c:if></a>
              </td>
              <td><c:out value='${_orderG.rplyDt}'/></td>
            </tr>
            </c:forEach>
            <op:no-data obj="${orderG}" colspan="2" />                  	
					</tbody>
				</table>
			</li>
			<!--// 최근게시물1 -->
			<!-- 최근게시물2 -->
			<li>
				<h3>
					승인 대기 서비스현황<!-- before_title : 서비스 등록 대기 현황 -->
					<i class="total">${waitGCount}</i>
					<a href="goods/BD_waitingList.do">더보기</a>
				</h3>
				<table class="tbl_st1 la_1" summary="승인 대기 서비스현황">
				<caption>승인 대기 서비스현황</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">서비스 명</th>
							<th scope="col">상태</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<!-- <th>번호</th> -->
							<th scope="col">서비스 명</th>
							<th scope="col">상태</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${waitG}" var="_waitG" varStatus="status">
		                   <tr>
		                       <td>
		                       <a href="javascript:;" title="[서비스명](팝업 창 열림)" onclick="jsRegistBack(this,'${_waitG.goodsCode}','${_waitG.goodsRegistSttus}');">
		                       <c:out value='${_waitG.goodsNm}'/>
		                       </a>
		                       </td>
		                       <td>
			                       <c:choose>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1003  || _waitG.goodsRegistSttus eq 1005 || _waitG.goodsRegistSttus eq 1010}">
					                        <span class="condi_c">반려</span><br/>
					                        <a style="width: 80px;" href="#none" title="팝업 창 열림" onclick="jsRegistBack(this,'${_waitG.goodsCode}', '${_waitG.goodsRegistSttus}');">반려사유보기</a>
				                        </c:when>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1001 || _waitG.goodsRegistSttus eq 1008}">
				                            <span class="condi_b">임시저장</span>
				                        </c:when>
				                        <c:when test="${_waitG.goodsRegistSttus eq 1002 || _waitG.goodsRegistSttus eq 1004 || _waitG.goodsRegistSttus eq 1009}">
						                    <span class="condi_d">승인대기</span>
				                        </c:when>
				                    </c:choose>
			                    </td>
		                   </tr>
		           		</c:forEach>
		                <op:no-data obj="${waitG}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// 최근게시물2 -->
		</ul>
		<ul>
			<!-- 최근게시물3 -->
			<li>
				<h3>
					입찰참여(응찰) 현황
					<a href="/korean/pt/suplerCeart/BD_bidPartcptnList.do">더보기</a>
				</h3>
				<table class="tbl_st1 la_3" summary="입찰참여(응찰) 현황">
				<caption>입찰참여(응찰) 현황</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">공고 명</th>
							<th scope="col">지명여부</th>
							<th scope="col">상태</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">공고 명</th>
							<th scope="col">지명여부</th>
							<th scope="col">상태</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${buying}" var="_buying" varStatus="status">
            <tr>
	            <td>
	            	<a href="/korean/pt/suplerCeart/BD_bidSttusDetailView.do?p_notifyNum=${_buying.notifyNum}&p_notifySeq=${_buying.notifySeq}">${fn:substring(_buying.bidNotifyNm,0,30)}<c:if test="${fn:length(_buying.bidNotifyNm) > 30}">...</c:if></a>
	            </td>
	             <td><c:out value='${_buying.cntrMothodNm}'/></td>
	             <td><c:out value='${_buying.bidPgesStatNm}'/></td>
            </tr>
           	</c:forEach>
	                <op:no-data obj="${buying}" colspan="3"/>
					</tbody>
				</table>
			</li>
			<!--// 최근게시물3 -->
			<!-- 최근게시물4 -->
			<li>
				<h3>
					씨앗공지
					<a href="/web/board/BD_board.list.do?domainCd=2&bbsCd=1019">더보기</a>
				</h3>
				<table class="tbl_st1 la_1" summary="씨앗공지">
				<caption>씨앗공지</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</tfoot>
					<tbody>						
						<c:forEach items="${noti}" var="_noti" varStatus="status">
	            <tr>
	              <td>
	              	<a href="/web/board/BD_board.view.do?domainCd=${_noti.domainCd}&bbsCd=${_noti.bbsCd}&bbscttSeq=${_noti.bbscttSeq}">${fn:substring(_noti.bbscttSj,0,30)}<c:if test="${fn:length(_noti.bbscttSj) > 30}">...</c:if></a>
	              </td>
	              <td><c:out value='${_noti.registDt}'/></td>
	            </tr>
            </c:forEach>
            <op:no-data obj="${noti}" colspan="2" />
					</tbody>							
				</table>
			</li>
			<!--// 최근게시물4 -->
		</ul>
		<ul>
			<!-- 최근게시물5 -->
			<li class="total">
				<h3>
					답변대기 Q&amp;A <!-- before_title : 답변대기 서비스 Q&A사항 -->
					<i>${inqrCount}</i>
					<a href="/korean/pt/sale/support/qna/BD_index.do">더보기</a>
				</h3>
				<table class="tbl_st1 la_4" summary="답변대기 Q&amp;A">
				<caption>답변대기 Q&amp;A</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</tfoot>
					<tbody>
					<c:forEach items="${inqr}" var="_inqr" varStatus="status">
		                <tr>
		                    <td class="title"><a href="javascript:;" onclick="jsView(this,'${_inqr.goodsInqryNo}','${_inqr.answerSttusCd}');"><c:out value='${_inqr.inqrySj}'/></a></td>
		                    <td><c:out value='${_inqr.registDt}'/></td>
		                </tr>
		           	</c:forEach>
		           	<op:no-data obj="${inqr}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// 최근게시물5 -->
			<!-- 최근게시물6 -->
			<li>
				<h3>
					답변대기 비즈매칭<!-- before_title : 비즈매칭 신규 등록 현황 -->
					<i>${bizCount}</i>
					<a href="/korean/pt/sale/bizMatching/BD_index.do?domainCd=2&bbsCd=1010">더보기</a>
				</h3>
				<table class="tbl_st1 la_4" summary="답변대기 비즈매칭">
					<caption>답변대기 비즈매칭</caption>
						<colgroup>
							<col width="*"/>
							<col width="80px"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="col">제목</th>
								<th scope="col">작성일</th>
							</tr>							
						</thead>
						<tfoot>
							<tr hidden="hidden">
								<th scope="col">제목</th>
								<th scope="col">작성일</th>
							</tr>							
						</tfoot>
						<tbody>
							<c:forEach items="${biz}" var="_biz" varStatus="status">
		          <tr>
		            <td>
		            	<a href="/web/board/BD_board.view.do?domainCd=${_biz.domainCd}&bbsCd=${_biz.bbsCd}&bbscttSeq=${_biz.bbscttSeq}">${fn:substring(_biz.bbscttSj,0,30)}<c:if test="${fn:length(_biz.bbscttSj) > 30}">...</c:if></a>
		            </td>
		          	<td><c:out value='${_biz.registDt}'/></td>
		          </tr>
		          </c:forEach>
		          <op:no-data obj="${biz}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// 최근게시물6 -->
		</ul>
		<ul>
			<!-- 최근게시물7 -->
			<li>
				<h3>
					의견공유
					<a href="/korean/pt/masub/BD_subBoardList.do">더보기</a>
				</h3>
				<table class="tbl_st1 la_4" summary="의견공유">
					<caption>의견공유</caption>
					<colgroup>
						<col width="*"/>
						<col width="80px"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</thead>
					<tfoot>
						<tr hidden="hidden">
							<th scope="col">제목</th>
							<th scope="col">작성일</th>
						</tr>							
					</tfoot>
					<tbody>
						<c:forEach items="${subBoard}" var="_subBoard" varStatus="status">
	          <tr>
	          	<td>
	          		<a href="/korean/pt/masub/BD_subBoardForm.do?masterId=${_subBoard.masterId}&masubNum=${_subBoard.masubNum}">${fn:substring(_subBoard.masubTitle,0,30)}<c:if test="${fn:length(_subBoard.masubTitle) > 30}">...</c:if></a>
	          	</td>
	            <td><c:out value='${_subBoard.masubEntrDate}'/></td>
	          </tr>
	          </c:forEach>
	          <op:no-data obj="${subBoard}" colspan="2" />
					</tbody>
				</table>
			</li>
			<!--// 최근게시물7 -->
		</ul>
	
	</div>
	</div>
	<!-- //contents -->
</body>
</html>