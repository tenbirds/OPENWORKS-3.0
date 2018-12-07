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
    <title>상세정보(견적)요청서 Saas</title>
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
        // 조회버튼 클릭
        function jsListSearch(page){
            $("#dataForm input[name=q_currPage]").val(page);
            document.dataForm.action = "/korean/pt/myCeart/BD_myCeartBidList.do";
    	    document.dataForm.method = "POST";
    	    document.dataForm.submit();
        }

        // 공고 상세보기
        function jsBidDetailView(notifyNum, notifySeq, bidGbnCd, grpSeq){
            // 임시저장인 경우
            if(bidGbnCd == '1003'){
                $('#notifyNum').val(notifyNum);
                $('#notifySeq').val(notifySeq);
                $('#grpSeq').val(grpSeq);
                document.saveForm.action = "/korean/pt/bid/BD_requestRegist.do";
                document.saveForm.method = "POST";
                document.saveForm.submit();
            }else{
                $('#p_notifyNum').val(notifyNum);
                $('#p_notifySeq').val(notifySeq);
                document.dataForm.action = "/korean/pt/myCeart/BD_bidDetailView.do";
                document.dataForm.method = "POST";
                document.dataForm.submit();
            }            
        }
    </script>

</head>
<body>
	<div class="conWrap">
	    <form name="saveForm" id="saveForm">
            <input type="hidden" name="notifyNum"     id="notifyNum"   />                   <!--  임시저장 확인 -->
            <input type="hidden" name="notifySeq"     id="notifySeq"   />                   <!--  임시저장 확인 -->
            <input type="hidden" name="grpSeq"        id="grpSeq"   />                      <!--  임시저장 확인 -->	    
	    </form>
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="q_currPage"    id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
            <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   />                 <!--  상세페이지용 -->
            <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   />                 <!--  상세페이지용 -->

			<div class="myceart bid">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="01" <c:if test="${searchDiv01 == '01'}">selected="true"</c:if> >공고명</option>
							<option value="02" <c:if test="${searchDiv01 == '02'}">selected="true"</c:if> >공급사명</option>
						</select><label for="searchDiv01"></label>
					</span>
					
					<div>
						<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/><label for="searchKeyWord"></label>
					</div>
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>				
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="jsListSearch(0);">
							    <option value="">전체</option>
							    <option value="1001" <c:if test="${searchDiv02 == '1001'}">selected="true"</c:if> >대기중</option>
							    <option value="1004" <c:if test="${searchDiv02 == '1004'}">selected="true"</c:if> >개찰</option>
							    <option value="1005" <c:if test="${searchDiv02 == '1005'}">selected="true"</c:if> >유찰</option>
							    <option value="1006" <c:if test="${searchDiv02 == '1006'}">selected="true"</c:if> >낙찰</option>
							    <option value="1003" <c:if test="${searchDiv02 == '1003'}">selected="true"</c:if> >마감</option>
							</select><label for="searchDiv02"></label>
						</span>
					</p>
					<table class="tbl_st1" summary="공고 관리 목록">
						<caption>공고 관리 목록</caption>
						<colgroup>
							<col width="5%"/>
							<col width="*"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="20%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">공고번호</th>
								<th scope="row">공고명</th>
								<th scope="row">공고종류</th>
								<th scope="row">계약방법</th>
								<th scope="row">진행상태</th>
								<th scope="row">공고일시<br />(마감일시)</th>							
							</tr>
						</thead>
						<tbody>
						    <c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td>${listData.notifyNum}-${listData.notifySeq}</td>
								<td class="tit">
								    <c:if test="${listData.bidGbnCd eq '1003'}">
								        <img src="/cloud_ver2/new_cloud/images/icn_txt_tempSave.png" alt="임시저장" />
								    </c:if>
									<a href="#" onclick="javascript:jsBidDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.bidGbnCd}','${listData.grpSeq}'); return false;">${listData.bidNotifyNm}</a>									
								</td>
								<td>${listData.goodKndNm}</td>
								<td>${listData.cntrMothodNm}</td>
								<td>${listData.bidPgesStatNm}</td>
								<td>
								    <c:if test="${listData.strtDt != null and listData.strtTime != null}">
									    ${listData.strtDt}&nbsp;${listData.strtTime}시
								    </c:if>
								    <c:if test="${listData.clseDt != null and listData.clseTime != null}">
									    <i>(${listData.clseDt}&nbsp;${listData.clseTime}시)</i>					
									</c:if>			
								</td>
							</tr>
						    </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                                <op:no-data obj="${pager}" colspan="6" />
                            </c:if>
						</tbody>
					</table>								
				</div>
					
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->

			</div>
		</form>
	</div>
	<!--// content -->

</body>
</html>