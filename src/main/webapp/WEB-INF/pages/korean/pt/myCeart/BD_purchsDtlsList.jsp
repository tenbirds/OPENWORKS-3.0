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
    <title>구매내역 관리 - 마이씨앗</title>
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
	    var jsListSearch = function(page){
	        $("#dataForm input[name=q_currPage]").val(page);
	      document.dataForm.action = "/korean/pt/myCeart/BD_purchsDtlsList.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
	    }

        // 평가서 버튼
        var jsContractChoiceReport = function(el, notifyNum, notifySeq){
	        $(el).colorbox({
	            title : "선정평가서",
	            href : "/korean/pt/popup/PD_contractChoiceReportPop.do?p_notifyNum="+notifyNum+"&p_notifySeq="+notifySeq,
	            width : "920",
	            height : "270",
	            overlayClose : false,
	            escKey : true,
	            iframe : true
	        });
        }

        // 엑셀 다운로드
        var jsExcelList = function() {
            location.href = "/korean/pt/myCeart/purchsDtlsListExcel.do?" + $("#dataForm").serialize();
        };

        // 구매(실적)증명서 발급요청
        var jsAcmsltCrtfRequst = function() {
            var requestData = "";
            var chkYn = true;

			$("input[name=requstChk]:checked").each(function() {
				var requstChkVal = $(this).val();

				// notify_num|notify_seq|certReultCode
				var strAry = requstChkVal.split("|");
				var cntrDt = $("#cntrDt_"+strAry[0]).val();	
				if(cntrDt == null || cntrDt == ''){
				    alert("계약(구매)일이 없습니다.");
				    chkYn = false;
				    return false;
				}
				if(strAry[1] != ''){
				    alert("이미 발급요청된 구매내역을 선택하였습니다.");
				    chkYn = false;
				    return false;
				}else{
				    requestData += requstChkVal + "#";
				}
			});

			if(chkYn){
				if(requestData == ''){
				    alert("요청할 구매내역을 선택하세요.");
				    chkYn = false;
				    return false;
				}
			}

			if(chkYn){
				if(confirm("선택하신 서비스에 대하여 증명서 발급요청을 하시겠습니까?")) {
					$('#requestData').val(requestData);

		    	    $("#dataForm").ajaxSubmit({
		                url      : "/korean/pt/myCeart/ND_acmsltCrtfRequst.do",
		                type     : "POST",
		                dataType : "json",
		                success  : function(response){
		                    if(response.result) {
		                        alert("발급요청을 등록하였습니다. \n구매실적 증명서 발급은 신청일로부터 약 7일이 소요되며 발급 후 이메일, 우편으로 발송됩니다.");
		                        location.reload();
		                    } else {
		                        alert(response.message);
		                    }
		                }
		            });
				}
			}
        }
        
        // 구매(실적)증명서 발급
        var jsAcmsltCrtfReport = function() {
            var q_beginDate = "2016-11-01";
            var q_endDate   = "2017-01-30";
            var commUserId  = "rhdrhddlswmd01";
            
            var open = "http://korean.ceart.kr/report/reporting.jsp?reportSection=4001&q_beginDate="+q_beginDate+"&q_endDate="+q_endDate+"&commUserId="+commUserId;
            window.open(open, 'reporting', ' fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
        }

        // 공고 상세보기        
        var jsBidDetailView = function(notifyNum, notifySeq, langStoreId){
            $('#p_notifyNum').val(notifyNum);
            $('#p_notifySeq').val(notifySeq);
            $('#langStoreId').val(langStoreId);
            document.dataForm.action = "/korean/pt/myCeart/BD_requestDetailView2.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        // 계약결과 등록 화면 호출
        var jsMyCntrctForm = function(){
            document.dataForm.action = "/korean/pt/myCeart/BD_myCntrctForm.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }

        // 계약결과 상세보기        
        var jsCtrtcDetailView = function(cntrctSn){
            $('#p_cntrctSn').val(cntrctSn);
            document.dataForm.action = "/korean/pt/myCeart/BD_myCntrctForm.do";
            document.dataForm.method = "POST";
            document.dataForm.submit();
        }
        
        // 계약변경 팝업 호출
        function jsContractChangePopup(el,num,seq,uid){
           $(el).colorbox({
                title : "계약 정보 확인",
                href : "/korean/pt/popup/PD_cntrctCmplPop.do?p_notifyNum="+num+"&p_notifySeq="+seq+"&suplerId="+uid,
                width : "920",
                height : "560",
                overlayClose : false,
                escKey : true,
                iframe : true
            });

        }
    </script>

</head>
<body>
	<div class="conWrap">
		<form name="dataForm" id="dataForm">
			<input type="hidden" name="q_currPage"  id="q_currPage"  value="${currPage}"/> <!--  현재 페이지 -->
			<input type="hidden" name="requestData" id="requestData" />  <!--  증명서 발급요청 대상 Data -->
			<input type="hidden" name="p_notifyNum" id="p_notifyNum" />  <!--  상세페이지용 -->
			<input type="hidden" name="p_notifySeq" id="p_notifySeq" />  <!--  상세페이지용 -->
			<input type="hidden" name="langStoreId" id="langStoreId" />  <!--  상세페이지용 -->
			<input type="hidden" name="p_cntrctSn"  id="p_cntrctSn" />    <!--  상세페이지용[계약관리정보 순서] -->
			
			<div class="myceart buylist">
				<div class="schArea">
				    <span class="sel_box">
						<select name="searchDiv01" id="searchDiv01">
							<option value="1001" <c:if test="${1001 eq searchMap.searchDiv01}">selected="selected"</c:if> >제공자명</option>
							<option value="1002" <c:if test="${1002 eq searchMap.searchDiv01}">selected="selected"</c:if>>서비스명</option>
						</select><label for="searchDiv01"></label>
					</span>
					
					<div>
						<input type="text" name="searchKeyWord" id="searchKeyWord" value="${searchMap.searchKeyWord}" alt="계약결과 검색"/><label for="searchKeyWord"></label>
					</div>
					<a href="#none" onclick="javascript:jsListSearch(0);" class="btns st5" title="검 색">검 색</a>
				</div>
				<div class="list_st1">
					<p class="head">
						<span>총 ${pager.totalNum}개</span>
						
					    <span class="sel_box">
							<select name="searchDiv02" id="searchDiv02" onchange="javascript:jsListSearch(0);">
								<option value="">전체</option>
								<option value="1001" <c:if test="${1001 eq searchMap.searchDiv02}">selected="selected"</c:if>>입찰</option>
								<option value="1002" <c:if test="${1002 eq searchMap.searchDiv02}">selected="selected"</c:if>>상세정보(견적)요청</option>
								<!-- option>나라장터쇼핑몰</option -->
							</select><label for="searchDiv02"></label>
						</span>
					</p>
					
					<table class="tbl_st1" summary="계약결과 관리 목록">
					<caption>계약결과 관리 목록</caption>
						<colgroup>
							<col width="5%"/>
							<col width="5%"/>
							<col/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>							
							<col width="10%"/>							
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">선택</th>
								<th scope="row">번호</th>								
								<th scope="row">서비스명</th>
								<th scope="row">계약체결일</th>
								<th scope="row">종료일</th>
								<!-- th>구매(실적)<br />상태</th -->
								<th scope="row">계약/평가<br />정보</th>
								<th scope="row">거래<br />계약서</th>
								<th scope="row">비고</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="index" value="${pager.indexNo}"/>
              <c:forEach items="${pager.list}" var="listData" varStatus="status">
							<tr>
								<td>
										<input type="checkbox" id="requstChk${index-status.index}" name="requstChk" value="${listData.cntrctSn}|${listData.certReultCode}" alt="${listData.goodsNm}"/>
										<label for="requstChk${index-status.index}"></label>
								</td>
								<td>${index-status.index}</td>								
								<td class="tit">
								    <%-- i><a href="#" onclick="javascript:jsCtrtcDetailView('${listData.cntrctSn}'); return false;">${listData.svcNm}</a><BR/>
								    <c:choose>
		         	                    <c:when test="${listData.registMthdCode eq 1002}">
	                                    	${listData.svcNm}
	                                    </c:when>
	                                    <c:otherwise>
	                                    	${listData.suplerStoreNm}
	                                    </c:otherwise>
	                                </c:choose>
									</i --%>
                                    <c:choose>
                                        <c:when test="${listData.myCtrtcYn eq 'Y'}">
                                            <a href="#none" onclick="javascript:jsCtrtcDetailView('${listData.cntrctSn}'); return false;" title="${listData.goodsNm}">
                                            ${listData.goodsNm}
                                            <%-- 
                                            <c:choose>
			                                    <c:when test="${listData.registMthdCode eq 1002}">
			                                    	${listData.sleInsttNm}
			                                    </c:when>
			                                    <c:otherwise>
			                                    	${listData.goodsNm}
			                                    </c:otherwise>
			                                </c:choose>
			                                 --%>
                                            </a>
                                        </c:when>
                                        <c:when test="${listData.myCtrtcYn eq 'N'}">
                                            <a href="#none" onclick="javascript:jsBidDetailView('${listData.notifyNum}','${listData.notifySeq}','${listData.suplerId}'); return false;" title="${listData.goodsNm}">
                                            ${listData.goodsNm}
                                            <%-- 
                                            <c:choose>
			                                    <c:when test="${listData.registMthdCode eq 1002}">
			                                    	${listData.svcNm}
			                                    </c:when>
			                                    <c:otherwise>
			                                    	${listData.goodsNm}
			                                    </c:otherwise>
			                                </c:choose>
			                                 --%>
                                            </a>
                                        </c:when>
                                    </c:choose>
								</td>
								<c:choose>
	                                <c:when test="${listData.registMthdCode eq 1002 and listData.cntrDt eq ''}">
	                                	<td>
	                                		<input type="hidden" id="cntrDt_${listData.cntrctSn}" value="${listData.cntrDt}">	                                		
	                                	</td>
	                                	<td> </td>
	                                </c:when>
	                                <c:otherwise>
	                                	<td><input type="hidden" id="cntrDt_${listData.cntrctSn}" value="${listData.cntrDt}">
	                                		${listData.cntrDt}
	                                	</td>
										<td>${listData.cntrctEndDe}</td>
	                                </c:otherwise>
                                </c:choose>
                                <%-- td>
                                    <c:choose>
                                        <c:when test="${listData.certReultCode == null or listData.certReultCode eq ''}">미신청</c:when>
                                        <c:otherwise>${listData.certReultNm}
                                        </c:otherwise>
                                    </c:choose>
								</td --%>
								<td>
								
									<c:if test="${listData.notifyNum != null}">
									    <%-- a href="#" onclick="jsContractChangePopup(this,'${listData.notifyNum}',${listData.notifySeq},'${listData.suplerId}'); return false">
									   		<img src="/cloud_ver2/new_cloud/images/icn_txt_cntrctInfo.png" alt="계약정보" />
									    </a --%>
									    
									    <a href="#none" onclick="jsContractChangePopup(this,'${listData.notifyNum}',${listData.notifySeq},'${listData.suplerId}'); return false" class="btns_s st3" title="계약정보">계약정보</a>
								  	</c:if>
								  	
								  	<c:if test="${listData.notifyNum != null and listData.notifyNum != '' and listData.notifySeq != null and listData.notifySeq != ''}">
								        <%-- a href="#" onclick="javascript:jsContractChoiceReport(this, '${listData.notifyNum}','${listData.notifySeq}'); return false;">
								        	<img src="/cloud_ver2/new_cloud/images/icn_txt_eval.png" style="margin-top: 3px;" alt="평가서" />
								        </a --%>
								        <a href="#" onclick="javascript:jsContractChoiceReport(this, '${listData.notifyNum}','${listData.notifySeq}'); return false;" style="margin-top: 3px;"  class="btns_s st1" title="평가서">평가서</a>
								    </c:if>
								
								</td>
								<td>
								    <c:if test="${listData.ctrtcSnId != null and listData.ctrtcSnId != ''}">
								        <a href="/component/file/ND_fileDownload.do?id=${listData.ctrtcSnId}" class="downLoad" title="다운로드">다운로드</a>
								    </c:if>
								</td>
								<td>${listData.bidGbnNm}</td>
							</tr>
                            </c:forEach>
                            <!-- 데이터가 없을 때 알림 문구 -->
                            <c:if test="${empty pager.list}">
                            	<op:no-data obj="${pager}" colspan="8" />
                            </c:if>
						</tbody>
					</table>								
				</div>
		        <!-- 페이징 -->
		        <div class="paging">
		            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListSearch" />
		        </div>
		        <!-- //페이징 -->
				
				<div style="float: left">
					<a href="#none" onclick="jsExcelList(this);" class="btns st1 icn icnXlx" title="엑셀 다운로드">엑셀 다운로드</a>
				</div>
				<div style="float: right">
					<a href="#none" onclick="jsMyCntrctForm(); return false;" class="btns st1 icn icnPaper" title="계약결과 수기등록">계약결과 수기등록</a>
				</div>
				<div class="btnArea lef">
					<!-- a href="#" onclick="jsAcmsltCrtfReport(); return false;" class="btns st1 icn icnPrint">구매(실적)증명서 프린트</a -->
					<c:if test="${fn:startsWith(UserTyCd,'30')}">
						<!-- a href="#" onclick="jsAcmsltCrtfRequst(); return false;" class="btns st1 icn icnPaper">이용실적증명서 발급요청</a -->
					</c:if>
				</div>
				<ul class="notice_bot">
					<li>구매계약 완료되었으나 [구매내역 관리] 목록에 없는 경우는 [상세정보(견적)요청서관리] 메뉴에서 해당 공급사에 계약완료 처리 요청을 하시면 됩니다.</li>
					<c:if test="${fn:startsWith(UserTyCd,'30')}">
					<li>구매계약 완료된 건에 한해 이용실적증명서 증명서 발급 요청을 한국정보화진흥원에 하실 수 있습니다.</li>
					<li style="color:red;">이용실적증명서를 우편으로 받기를 원하는 기관은 이용실적증명서 신청 후 ceart@ceart.kr로 받으실 기관명, 주소, 담당자명, 연락처를 보내주시면 신청일로부터 7일 이내에 발송하여 드립니다.</li></c:if>
				</ul>
				
			</div>
			
		</form>
	</div>	
</body>
</html>