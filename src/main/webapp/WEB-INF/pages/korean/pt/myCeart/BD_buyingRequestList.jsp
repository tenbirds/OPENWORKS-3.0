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
            document.dataForm.action = "/korean/pt/myCeart/BD_buyingRequestList.do";
        	document.dataForm.method = "POST";
        	document.dataForm.submit();
        }

        // 계약대상 선정 버튼
        function jsContractChoice(el){
            var choiseBid = $("input[type=radio][name=notifyChk]:checked").val();
            if(choiseBid == null || choiseBid == 'undefined'){
                alert("선정할 사업을 선택하세요.");
                return false;
            }else{
                var notifyInfo = choiseBid.split('|');
                
                if($('#askApplyCd_'+notifyInfo[0]+'_'+notifyInfo[1]).val() != '1003'){
                    if($('#rplyDtYn_'+notifyInfo[0]+'_'+notifyInfo[1]).val() == 'N'){
                        alert("답변 대기중 입니다.\n(응답완료일 : " + $('#rplyDt_'+notifyInfo[0]+'_'+notifyInfo[1]).val() + ")");
                        return false;
                    }                    
                }

                if($('#bidPgesStat_'+notifyInfo[0]+'_'+notifyInfo[1]).val() == '1006'){
                    alert("이미 선정이 완료된 사업입니다.");
                    return false;                    
                }
                
                $(el).colorbox({
                    title : "계약대상 선정",
                    href : "/korean/pt/popup/PD_contractChoicePop.do?p_notifyNum="+notifyInfo[0]+"&p_notifySeq="+notifyInfo[1],
                    width : "920",
                    height : "320",
                    overlayClose : false,
                    escKey : false,
                    iframe : true
                });
            }
        }

        // 평가서 버튼
        function jsContractChoiceReport(el, notifyNum, notifySeq){
            if($('#bidPgesStat_'+notifyNum+'_'+notifySeq).val() != '1006'){
                if($('#rplyDtYn_'+notifyNum+'_'+notifySeq).val() == 'N'){
                    alert("답변 대기중 입니다.\n(응답완료일 : " + $('#rplyDt_'+notifyNum+'_'+notifySeq).val() + ")");
                    return false;
                }
            }
            $(el).colorbox({
                title : "선정평가서",
                href : "/korean/pt/popup/PD_contractChoiceReportPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq,
                width : "920",
                height : "320",
                overlayClose : false,
                escKey : false,
                iframe : true
            });                
            
        }

        // 계약체결 완료요청
        function jsFinishRequest(){
            var requestData = "";
            var chkYn = true;

			$("input[name=finishRequest]:checked").each(function() {
				var finishRequestVal = $(this).val();
				
				// notify_num|notify_seq|langStoreId|bidSussGbn|bidFinishGbn|cntrGbn
				var strAry = finishRequestVal.split("|");
				
				if(strAry[3] == 'N'){
				    alert("선정되지 않은 서비스를 선택하셨습니다.");
				    chkYn = false;
				    return false;
				}else if(strAry[4] == 'Y'){
				    alert("이미 완료요청된 서비스를 선택하셨습니다.");
				    chkYn = false;
				    return false;
				}else if(strAry[5] == 'Y'){
				    alert("이미 완료처리된 서비스를 선택하셨습니다.");
				    chkYn = false;
				    return false;
				}else{
				    requestData += finishRequestVal + "#";
				}
			});

			if(chkYn){
				if(requestData == ''){
				    alert("요청할 서비스를 선택하세요.");
				    chkYn = false;
				    return false;
				}
			}
			if(chkYn){
				if(confirm("선택하신 서비스에 대하여 계약체결 완료요청을 하시겠습니까?")) {
					$('#requestData').val(requestData);

		    	    $("#dataForm").ajaxSubmit({
		                url      : "/korean/pt/myCeart/ND_finishRequest.do",
		                type     : "POST",
		                dataType : "json",
		                success  : function(response){
		                    if(response.result) {
		                        alert("완료요청을 등록하였습니다.");
		                        location.reload();
		                    } else {
		                        alert(response.message);
		                    }
		                }
		            });
				}
			}
        }
        
        // 서비스 상세보기
        function jsRequestDetailView(notifyNum, notifySeq, langStoreId){
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            $('#langStoreId').val(langStoreId);
            document.dataForm.action = "/korean/pt/myCeart/BD_requestDetailView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        // 비교버튼 클릭 이벤트
        function jsSetCompare(notifyNum, notifySeq){
            
            jsSetCompareClear();
            
            $('.serCompare').removeClass('hidden').addClass('on');

		    $.ajax({
		        url : "/korean/pt/myCeart/BD_goodsCompareList.do",
	 	        cache: false,
		        type: "POST",
		        dataType: "JSON",
		        async: false,
		        data : {notifyNum:notifyNum, notifySeq:notifySeq},
		        success: function(data){

		            $('#q_notifyNum').val(notifyNum);
		            $('#q_notifySeq').val(notifySeq);

		            if(data.goodsList.length > 0){		                
		                for(var i = 0; i <= data.goodsList.length; i++){
		                    var goodsCode   = data.goodsList[i].goodsCode;
		                    var goodsName   = data.goodsList[i].goodsName;
		                    var langStoreNm = data.goodsList[i].langStoreNm;
		                    var goodImage =  data.goodsList[i].goodsFileUrl;

		                    var productInfro="<span id='compareItem_"+goodsCode+"'><a href='#'><img src='"+goodImage+"' alt='' /><i>"+goodsName+"</i></a>";
		                    productInfro +="<span>"+langStoreNm+"&nbsp; <button onClick='jsSetCompareDelte(\""+goodsCode+"\"); return false;'>삭제</button></span>";
		                    productInfro +="<input type='hidden' name='compGoodsCode' value='"+goodsCode+"'/>";
		                    productInfro +="</span>";
		                    $('.itemWrap').append(productInfro);
		                }
		            }
		    	}
	 		});
        }

        // 비교하기 영역 초기화
        function jsSetCompareClear(){
            $('#q_notifyNum').val('');
            $('#q_notifySeq').val('');
            $('.itemWrap').html('');
        }
        
        // 선택한 비교하기 서비스 삭제
        function jsSetCompareDelte(goodId){
            var exclGoodsCode = $('#q_exclGoodsCode').val();
            if(exclGoodsCode == ''){
                $('#q_exclGoodsCode').val(goodId);
            }else{
                $('#q_exclGoodsCode').val(exclGoodsCode+"|"+goodId);
            }

            $('#compareItem_'+goodId).html('');
            
        }
        
        // 비교하기 상세 페이지 호출
        function jsCompareDetail(el){
            
            if($('#q_notifyNum').val()=='' || $('#q_notifySeq').val()==''){
                alert("비교할 대상이 존재하지 않습니다.");
                return false;
            }

            var compGoodsCode = "";
            if($('input[name=compGoodsCode]').size() == 0){
                alert("비교할 대상이 존재하지 않습니다.");
                return false;                
            }else{
                $("input[name=compGoodsCode]").each(function(i){
                    if(compGoodsCode == ''){
                        compGoodsCode = $("input[name=compGoodsCode]").eq(i).val();
                    }else{
                        compGoodsCode = compGoodsCode + "|" + $("input[name=compGoodsCode]").eq(i).val();    
                    }
                });
            }

            var href = "/korean/pt/myCeart/PD_compareDetail.do?p_notifyNum="+$('#q_notifyNum').val()+"&p_notifySeq="+ $('#q_notifySeq').val()+"&q_compGoodsCode="+compGoodsCode;
            var type = "estiComp";
	        pop =  window.open(href, type, "width=1520,height=820,scrollbars=yes,resizable=yes,toolbar=no");
	        if(pop)    pop.focus();
        }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "/korean/pt/myCeart/INC_EXCEL.do?" + $("#dataForm").serialize();
        };
    </script>

</head>
<body>
    <form name="compareForm" id="compareForm">
        <input type="hidden" name="q_notifyNum"     id="q_notifyNum"   />   <!--  상세페이지용 -->
        <input type="hidden" name="q_notifySeq"     id="q_notifySeq"   />   <!--  상세페이지용 -->
        <input type="hidden" name="q_exclGoodsCode" id="q_exclGoodsCode"   />   <!--  상세페이지용 -->
    </form>
 		
	<div class="conWrap">
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="requestData"  id="requestData"  />                  <!--  계약체결 완료요청 대상 Data -->
            <input type="hidden" name="q_currPage"   id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
            <input type="hidden" name="p_notifyNum"   id="p_notifyNum"   />   <!--  상세페이지용 -->
            <input type="hidden" name="p_notifySeq"   id="p_notifySeq"   />   <!--  상세페이지용 -->
            <input type="hidden" name="langStoreId"   id="langStoreId" />     <!--  상세페이지용 -->

			<div class="myceart buylist reque">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="01" <c:if test="${searchDiv01 == '01'}">selected="true"</c:if> >공급사명</option>
							<option value="02" <c:if test="${searchDiv01 == '02'}">selected="true"</c:if> >서비스명</option>
						</select>
					</span>
					
					<div>
						<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>
					</div>
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>				
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);">
							    <option value="">전체</option>
							    <c:forEach items="${askApplyCdCodeList}" var="askApplyCdCode" varStatus="status">
							        <option value="${askApplyCdCode.PRVCD}" <c:if test="${searchDiv02 == askApplyCdCode.PRVCD}">selected="true"</c:if> >${askApplyCdCode.PRVNM}</option>
							    </c:forEach>
							</select>
						</span>
					</p>
					<table class="tbl_st1">
						<thead>
							<tr>
								<th>선택</th>
								<th>번호</th>
								<th>사업명/평가서</th>
								<th>서비스</th>
								<th>응답완료일</th>
								<th>답변상태</th>
								<th>계약대상</th>
							</tr>
						</thead>
						<tbody>
						<c:set var="pass_cnt" value="0"/>
						<c:set var="pass_cnt2" value="0"/>
                        <c:set var="index" value="${pager.indexNo}"/>
                        <c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td><input type="checkbox" name="finishRequest" value="${listData.notifyNum}|${listData.notifySeq}|${listData.langStoreId}|${listData.bidSussGbn}|${listData.bidFinishGbn}|${listData.cntrGbn}"/></td>
								<td>${index-status.index}</td>
							    <c:set var="spanCnt" value="0"/>
                                <c:choose>
                                    <c:when test="${pass_cnt eq 0}">                    
                                        <c:forEach items="${pager.list}" var="rowSpanContent" varStatus="status1">
                                            <c:if test="${listData.notifyNum eq rowSpanContent.notifyNum and listData.notifySeq eq rowSpanContent.notifySeq}">
                                                <c:set var="spanCnt" value="${spanCnt+1}"/>
                                            </c:if>
                                        </c:forEach>
								<td rowspan="<c:out value='${spanCnt}'/>">
									<label><input name="notifyChk" type="radio" value="${listData.notifyNum}|${listData.notifySeq}"/> ${listData.auditlogNm}</label><br />
									<i>(${listData.entrDt})</i>
									<span>
										<a href="#" onclick="javascript:jsContractChoiceReport(this, '${listData.notifyNum}','${listData.notifySeq}'); return false;"><img src="/cloud_ver2/new_cloud/images/icn_txt_eval.png" alt="평가서" /></a>										
										<a href="#" onclick="javascript:jsSetCompare('${listData.notifyNum}','${listData.notifySeq}'); return false;" class="btnPare"><img src="/cloud_ver2/new_cloud/images/icn_txt_compare.png" alt="비교" /></a>
										<input type="hidden" name="rplyDt_${listData.notifyNum}_${listData.notifySeq}"      id="rplyDt_${listData.notifyNum}_${listData.notifySeq}"      value="${listData.rplyDt}" />      <!-- 응답완료일 -->
										<input type="hidden" name="rplyDtYn_${listData.notifyNum}_${listData.notifySeq}"    id="rplyDtYn_${listData.notifyNum}_${listData.notifySeq}"    value="${listData.rplyDtYn}" />    <!-- 응답완료일 -->
										<input type="hidden" name="bidPgesStat_${listData.notifyNum}_${listData.notifySeq}" id="bidPgesStat_${listData.notifyNum}_${listData.notifySeq}" value="${listData.bidPgesStat}" /> <!-- 입찰진행상태(1006이면 선정완료) -->
										<input type="hidden" name="askApplyCd_${listData.notifyNum}_${listData.notifySeq}"  id="askApplyCd_${listData.notifyNum}_${listData.notifySeq}" value="${listData.askApplyCd}" />   <!-- 답변여부(1003이면 답변) -->
									</span>
								</td>
								        <c:set var="spanCnt" value="${spanCnt-1}"/>
                                        <c:set var="pass_cnt" value="${spanCnt}"/>
								    </c:when>
								    <c:otherwise>
								        <c:set var="pass_cnt" value="${pass_cnt-1}"/>
								    </c:otherwise>
								</c:choose>
								<td class="tit">
								<c:choose>
								    <c:when test="${listData.bidFinishGbn eq 'Y'}">
								    <img src="/cloud_ver2/new_cloud/images/icn_txt_contract_end.png" alt="계약완료 요청" />
								    </c:when>
								</c:choose>
									<i>${listData.langStoreNm}</i>
									<a href="#" onclick="javascript:jsRequestDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.langStoreId}'); return false;">${listData.goodsNm}</a>									
								</td>
								

							    <c:set var="spanCnt2" value="0"/>
                                <c:choose>
                                    <c:when test="${pass_cnt2 eq 0}">                    
                                        <c:forEach items="${pager.list}" var="rowSpanContent2" varStatus="status2">
                                            <c:if test="${listData.notifyNum eq rowSpanContent2.notifyNum and listData.notifySeq eq rowSpanContent2.notifySeq}">
                                                <c:set var="spanCnt2" value="${spanCnt2+1}"/>
                                            </c:if>
                                        </c:forEach>
								<td rowspan="<c:out value='${spanCnt2}'/>">${listData.rplyDt}</td>
								        <c:set var="spanCnt2" value="${spanCnt2-1}"/>
                                        <c:set var="pass_cnt2" value="${spanCnt2}"/>
								    </c:when>
								    <c:otherwise>
								        <c:set var="pass_cnt2" value="${pass_cnt2-1}"/>
								    </c:otherwise>
								</c:choose>

								<td>${listData.askApplyNm}</td>
								<td>${listData.bidSussGbnNm}</td>
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
		

				
				<div class="btnArea lef">
					<a href="#" onclick="javascript:jsContractChoice(this); return false;" class="btns st1 icn icnCheck">계약대상 선정</a>
					<a href="#" onclick="javascript:jsFinishRequest(); return false;" class="btns st1 icn icnSpk">계약체결 완료요청</a>
					<a href="#" onclick="jsExcelList(this);" class="btns st1 icn icnXlx">엑셀 다운로드</a>
				</div>
				
				<ul class="notice_bot">
					<li>계약대상 선정은  사업명의 라디오 버튼<input type="radio" checked="checked" /> 체크 후 [계약대상 선정] 버튼을 클릭하시면 됩니다.</li>
					<li>계약체결완료된 요청서는 [구매내역 관리] 메뉴에서도 확인 하실 수 있습니다.</li>
					<li>구매계약을 하였으나 제공자가 계약체결 완료처리를 하지 않은 경우 [계약체결 완료요청]버튼을 클릭하여 공급사에 요청 하시면 됩니다.</li>
					<li>구매(실적) 증명서 발급 요청은 계약체결 완료된 건에 한해 [구매내역 관리] 메뉴에서 한국정보화진흥원에 요청 하실 수 있습니다.</li>			
				</ul>			
			 
		    </div>
	    </form>
	</div>
		
	<!-- popup - 서비스 비교 -->
	<article class="popup serCompare">
		<h2>서비스 비교(10) <a href="#">닫기</a><i>* 최대 10개 까지 비교 가능합니다</i></h2>
		<div class="itemWrap">
		</div>
		<ul>
			<li><button onclick="javascript:jsCompareDetail(this); return false;"><i>선택서비스 비교</i></button></li>
			<li><button onclick="javascript:jsSetCompareClear(); return false;">전체 비우기</button></li>
		</ul>
	</article>
	<!--// popup - 구매요청 -->
   
</body>
</html>