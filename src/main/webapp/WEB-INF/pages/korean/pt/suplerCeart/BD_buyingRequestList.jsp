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
    <title>상세정보(견적)요청서</title>
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
            document.dataForm.action = "/korean/pt/suplerCeart/BD_buyingRequestList.do";
    	    document.dataForm.method = "POST";
    	    document.dataForm.submit();
        }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "/korean/pt/suplerCeart/INC_EXCEL.do?" + $("#dataForm").serialize();
        };

        // 서비스 상세보기
        function jsRequestDetailView(notifyNum, notifySeq, endsUserId)
        {
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            $('#p_endsUserId').val(endsUserId);
            
            document.dataForm.action = "/korean/pt/suplerCeart/BD_requestDetailView.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        // 계약체결 완료처리 팝업 호출
        function jsContractCompletePopup(el){
            var choiseBid = $("input[type=radio][name=notifyChk]:checked").val();

            if(choiseBid == null || choiseBid == 'undefined'){
                alert("선정할 사업을 선택하세요.");
                return false;
            }else{
                var notifyInfo = choiseBid.split('|');
                var notifyNum  = notifyInfo[0];
                var notifySeq  = notifyInfo[1];
                var bidSussGbn = notifyInfo[2];
                var cntrGbn    = notifyInfo[3];
                
                if(bidSussGbn == 'N'){
                    alert("선정되지 않은 견적입니다.");
                    return false;
                }
                if(cntrGbn == 'Y'){
                    alert("이미 완료된 견적입니다.");
                    return false;
                }
            }

            $(el).colorbox({
                title : "계약체결 완료처리",
                href : "/korean/pt/popup/PD_cntrctCmplPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq+"&suplerId=null",
                width : "920",
                height : "560",
                overlayClose : false,
                escKey : false,
                iframe : true
            });

        }

        // 계약변경 팝업 호출
        function jsContractChangePopup(el){
            var choiseBid = $("input[type=radio][name=notifyChk]:checked").val();

            if(choiseBid == null || choiseBid == 'undefined'){
                alert("계약변경할 사업을 선택하세요.");
                return false;
            }else{
                var notifyInfo = choiseBid.split('|');
                var notifyNum  = notifyInfo[0];
                var notifySeq  = notifyInfo[1];
                var bidSussGbn = notifyInfo[2];
                var cntrGbn    = notifyInfo[3];
                
                if(bidSussGbn == 'N'){
                    alert("선정되지 않은 견적입니다.");
                    return false;
                }
                if(cntrGbn != 'Y'){
                    alert("계약이 완료되지 않은 견적입니다.");
                    return false;
                }
            }

            $(el).colorbox({
                title : "계약변경",
                href : "/korean/pt/popup/PD_cntrctCmplPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq+"&suplerId=null",
                width : "920",
                height : "560",
                overlayClose : false,
                escKey : false,
                iframe : true
            });

        }
    </script>

</head>
<body>
    <div class="conWrap">
        <form name="dataForm" id="dataForm">
            <input type="hidden" name="q_currPage"   id="q_currPage" value="${currPage}"/> <!--  현재 페이지 -->
            <input type="hidden" name="p_notifyNum"   id="p_notifyNum" />  <!-- (상세보기용) 공고번호 -->
            <input type="hidden" name="p_notifySeq"   id="p_notifySeq" />  <!-- (상세보기용) 공고차수 -->
            <input type="hidden" name="p_endsUserId"  id="p_endsUserId" /> <!-- (상세보기용) 이용자ID -->
		
			<div class="supAdm answAdm">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01" >
							<option value="1001" <c:if test="${searchDiv01 == '1001'}">selected="true"</c:if> >서비스명</option>
							<option value="1002" <c:if test="${searchDiv01 == '1002'}">selected="true"</c:if> >문의기관</option>							
						</select>
					</span>
					
					<div>
						<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchKeyWord}"/>
					</div>
					<a href="#" onclick="javascript:jsListSearch(0);" class="btns st5">검 색</a>
				</div>				
				
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum} 개</span>
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);" >
								<option value="">전체</option>
							    <c:forEach items="${codeList_askApplyCd}" var="askApplyCd" varStatus="status">
							        <option value="${askApplyCd.prvCd}" <c:if test="${searchDiv02 == askApplyCd.prvCd}">selected="true"</c:if> >${askApplyCd.prvNm}</option>
							    </c:forEach>
							</select>
						</span>
					</p>
					
					<table class="tbl_st1">
						<thead>
							<tr>
								<th>선택</th>
								<th>번호</th>
								<th>구분</th>
								<th>서비스</th>
								<!-- th>답변자</th -->
								<th>기업/기관</th>
								<th>응답 만료일</th>
								<th>답변<br />상태</th>
								<th>선정<br />상태</th>
								<th>계약<br />상태</th>
							</tr>
						</thead>
						<tbody>
						    <c:set var="index" value="${pager.indexNo}"/>
                            <c:forEach items="${pager.list}" var="listData" varStatus="status">
							    <tr>
								    <td>
								        <c:if test="${listData.bidSussGbn eq 'Y'}">
								            <input type="radio" name="notifyChk" value="${listData.notifyNum}|${listData.notifySeq}|${listData.bidSussGbn}|${listData.cntrGbn}"/>
								        </c:if>
								    </td>
								    <td>${index-status.index}</td>
								    <td>${listData.goodsKndCd}</td>
								    <td>
								        <c:if test="${listData.bidFinishGbn eq 'Y'}">
								            <img src="/cloud_ver2/new_cloud/images/icn_txt_contract_end.png" alt="계약완료 요청" />
								        </c:if>
									    <i>${listData.auditlogNm}</i>
									    <a href="#" onclick="javascript:jsRequestDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.endsUserId}'); return false;">
									    	${listData.goodsNm}
									    </a>									
								    </td>
								    <!-- td>황길동</td -->
								    <td>${listData.realDmndOrgn}</td>
								    <td>${listData.rplyDt}</td>
								    <td>${listData.askApplyNm}</td>
								    <td>
								        <c:if test="${listData.bidSussGbn eq 'Y'}">선정</c:if>
								        <c:if test="${listData.bidSussGbn ne 'Y'}">미선정</c:if>
								    </td>
								    <td>
								        <c:if test="${listData.cntrGbn eq 'Y'}">체결</c:if>
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
				
				<div class="btnArea rig">
					<a href="#" onclick="jsExcelList(this);" class="f_l btns st1 icn icnXlx">엑셀 다운로드</a>
					<a href="#" onclick="jsContractCompletePopup(this); return false;" class="btns st1 icn icnSave">계약체결 완료처리</a>
					<a href="#" onclick="jsContractChangePopup(this); return false;" class="btns st1 icn icnChange">계약변경</a>
				</div>`
				
				<ul class="notice_bot">
					<li class="import">※ 공급 계약완료 시 반드시 [계약체결 완료처리] 해주셔야 이용자께서 구매(실적)확인서를 발급 받을 수 있습니다.</li>
					<li>이용자가 계약체결 완료요청 시 서비스명에 <span class="btns st6">계약완료 요청</span> 아이콘이 나타나며, 거래 사실 확인 후 계약체결완료처리 하시면 됩니다.</li>
					<li>계약체결 완료 건은 [공급현황] 메뉴에서 통합관리 합니다.</li>					
				</ul>
			</div>
	    </form>
	</div>
	<!--// content -->
</body>
</html>