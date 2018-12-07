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
    <title>제공자씨앗 - 입찰참여 현황 - 입찰 상세</title>
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
        //  목록보기 버튼
        var returnList = function(){
            document.dataForm.action = "/korean/pt/suplerCeart/BD_bidPartcptnList.do";    
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
        }
        
        //  나의 응찰 버튼
        var jsBidEntend = function(extendTermYn, entendDiv){
            if(entendDiv == 'A'){
                // 응찰 마감일 뿐 아니라 입찰건이 마감되었는지 까지 체크
                if(extendTermYn != 'Y'){
                    alert("입찰이 마감되었습니다.");
                    return false;
                }                
            }

            $('#p_entendDiv').val(entendDiv);
	        document.dataForm.action = "/korean/pt/suplerCeart/BD_bidExtendView.do";
		    document.dataForm.method = "POST";
		    document.dataForm.submit();
        }
    </script>

</head>
<body>
	<div class="conWrap">
	    <form name="dataForm" id="dataForm">
	        <input type="hidden" name="searchDiv01"     id="searchDiv01"     value="${searchDiv01}"/>         <!--  목록 페이지 조회조건1 -->	        
	        <input type="hidden" name="searchDiv02"     id="searchDiv02"     value="${searchDiv02}"/>         <!--  목록 페이지 조회조건2 -->
            <input type="hidden" name="searchKeyWord"   id="searchKeyWord"   value="${searchKeyWord}"/>       <!--  목록 페이지 검색어1 -->	        
	        <input type="hidden" name="q_currPage"      id="q_currPage"      value="${currPage}"/>            <!--  현재 페이지 -->
	        <input type="hidden" name="p_notifyNum"     id="p_notifyNum"     value="${baseList.notifyNum}"/>  <!--  공고번호 -->
	        <input type="hidden" name="p_notifySeq"     id="p_notifySeq"     value="${baseList.notifySeq}"/>  <!--  공고차수 -->
	        <input type="hidden" name="p_entendDiv"     id="p_entendDiv" />                                   <!--  응찰구분 -->
	    </form>

		<div class="bidNoti">
			<ul class="notice">
				<li>공고의 등록 및 집행은 발주기관 및 수요기관에서 직접 수행합니다.</li>
				<li>한국정보화진흥원에서는 타 기관에서 직접 집행하는 입찰건의 세부내용은 알 수 없으므로 해당 발주기관에 직접 문의하시면 정확한 답변을 받으실 수 있습니다.</li>
			</ul>
			
			<h3>공고일반</h3>
			
			<table class="tbl_st4 e4">
				<tr>
					<th>입찰공고명</th>
					<td colspan="3" class="bidName">${baseList.bidNotifyNm}
					    <!-- img src="/cloud_ver2/new_cloud/images/icn_txt_renoti.png" alt="재공고" / -->
					</td>
				</tr>
				<!--tr>
					<th>재공고사유</th>
					<td colspan="3">공고변경/취소/연장이 된 경우 입력된 사유 내용이 나옵니다…</td>
				</tr>
				<tr>
					<th>재공고일</th>
					<td colspan="3"></td>
				</tr-->
				<tr>
					<th>공고번호</th>
					<td colspan="3">${baseList.notifyNum}-${baseList.notifySeq}</td>
				</tr>
				<tr>
					<th>공고종류</th>
					<td>${baseList.bidKndNm}</td>
					<th>공고분류</th>
					<td>${baseList.bidClassNm}</td>
				</tr>
				<tr>
					<th>계약방법</th>
					<td colspan="3">${baseList.cntrMothodNm}</td>
				</tr>
				<c:if test="${baseList.cntrMothod eq '1003'}">
				<tr>
					<th>수의계약 사유공문</th>
					<td colspan="3">
					    <c:if test="${baseList.optlCntrFileId != null}">
					        <a href="/component/file/ND_fileDownload.do?id=${baseList.optlCntrFileId}" title="${baseList.optlCntrFileOrgNm}" class="aDeisable">${baseList.optlCntrFileOrgNm} <span class="tx_gray">(${baseList.optlCntrFileSize}, ${baseList.optlCntrFileTy})</span></a>
					    </c:if>
					</td>
				</tr>
				</c:if>
				<tr>
					<th>발주(공고) 기관</th>
					<td>${baseList.endsUserNm}</td>
					<th>실수요 기관</th>
					<td>${baseList.realDmndOrgn}</td>
				</tr>
				<tr>
					<th>담당자 명</th>
					<td>${baseList.realDmndOrgn}</td>
					<th>연락처</th>
					<td>${baseList.endsMbtlnum}</td>
				</tr>
				<tr>
					<th>연계기관<br />공고URL</th>
					<td colspan="3">${baseList.linkOrgnUrl}</td>
				</tr>
			</table>

			<c:choose>
			    <c:when test="${baseList.bidKndCd eq '1001'}">
			        <h3>입찰집행</h3>
		            <table class="tbl_st4">
			            <tr>
				            <th>입찰서 접수 일시</th>
				            <td>${baseList.strtDt}&nbsp;&nbsp;${baseList.strtTime}시</td>
				            <th>입찰서접수 마감 일시</th>
				            <td><em>${baseList.clseDt}&nbsp;&nbsp;${baseList.clseTime}시</em></td>
			            </tr>
			            <tr>
				            <th>개찰일시</th>
				            <td colspan="3">${baseList.openDt}&nbsp;&nbsp;${baseList.openTime}시</td>
			            </tr>
		            </table>
			    </c:when>
			    <c:when test="${baseList.bidKndCd eq '1002'}">
			        <h3>공고기간</h3>
			        <table class="tbl_st4">
				        <tr>
					        <th>시작일시</th>
					        <td>${baseList.strtDt}&nbsp;&nbsp;${baseList.strtTime}시</td>
					        <th>마감일시</th>
					        <td><em>${baseList.clseDt}&nbsp;&nbsp;${baseList.clseTime}시</em></td>
				        </tr>
			        </table>
			    </c:when>
			</c:choose>
            <c:if test="${(baseList.cntrMothod eq '1002' or baseList.cntrMothod eq '1004')}"> 
			    <h3>응찰제한</h3>
			    <table class="tbl_st4">
				    <tr>
					    <th>지역제한</th>
					    <td>${baseList.areaLimit1Nm}
					    <c:if test="${(baseList.areaLimit2Nm != null)}">
					    ,&nbsp;${baseList.areaLimit2Nm} 
					    </c:if>
					    <c:if test="${(baseList.areaLimit3Nm != null)}">
					    ,&nbsp;${baseList.areaLimit3Nm} 
					    </c:if>
					    </td>
				    </tr>
				    <tr>
					    <th>자격제한</th>
					    <td>
					    <c:set var="limitTxt" value=""/>
					    <c:if test="${baseList.catyLimitEntr eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}중소기업확인서,"/>
					    </c:if>
					    <c:if test="${baseList.catyLimitVntr eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}벤처기업확인서,"/>
					    </c:if>
					    <c:if test="${baseList.catyLimitSoc eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}사회적기업확인서,"/>
					    </c:if>
					    <c:if test="${baseList.catyLimitWomn eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}여성기업확인서,"/>
					    </c:if>
					    <c:if test="${baseList.catyLimitDiad eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}중증장애인생산시설,"/>
					    </c:if>
					    <c:if test="${baseList.catyLimitEtc eq 'Y'}">
					        <c:set var="limitTxt" value="${limitTxt}${baseList.catyLimitEtcComt},"/>
					    </c:if>
					    ${limitTxt}
					    </td>
				    </tr>
			    </table>
            </c:if>

	        <!-- 지명경쟁일 경우 노출  -->
	        <c:if test="${(baseList.cntrMothod eq '1004')}"> 
	            <h3>응찰지명</h3>
	            <table class="tbl_st4">
		            <tr>
			            <th>업체지명 (2곳이상)</th>
		                <td>
		                <c:forEach items="${pager}" var="myWishList" varStatus="status">
		                ${myWishList.langStoreNm},&nbsp;
	                    </c:forEach>
	                    </td>
		            </tr>
	            </table>
	        </c:if>

			<h3>시스템 요구조건</h3>
			<table class="tbl_st4">
				<tr>
					<th>제품군</th>
					<td>${baseList.goodKndNm}</td>
				</tr>
			</table>
			
            <!-- tbl_write -->
            <c:choose>
                <c:when test="${baseList.goodKndCd eq 1001}">
                    <%@include file="../bidSttus/goods/BD_Bid_Paas.view.jsp" %>
                </c:when>
                <c:when test="${baseList.goodKndCd eq 1002}">
                    <%@include file="../bidSttus/goods/BD_Bid_Saas.view.jsp" %>
                </c:when>
                <c:when test="${baseList.goodKndCd eq 1003}">
                    <%@include file="../bidSttus/goods/BD_Bid_Iaas.view.jsp" %>
                </c:when>
            </c:choose>
            <!-- //tbl_write -->
			
			<h3>납품 요구조건</h3>
			<table class="tbl_st4">
				<tr>
					<th>희망 구매가</th>
					<td><fmt:formatNumber value="${baseList.hopePuchAmt}" groupingUsed="true"/> 원 /
                     	    <c:choose>
                               <c:when test="${baseList.vatGbn eq 'Y'}">VAT 포함</c:when>
                               <c:when test="${baseList.vatGbn eq 'N'}">VAT 미포함</c:when>
                           </c:choose>
					</td>
				</tr>
				<tr>
					<th>납품 기한</th>
					<td>
					    <c:choose>
					        <c:when test="${baseList.talkGbn eq 'Y'}">합의후 결정</c:when>
					        <c:when test="${baseList.talkGbn eq 'N'}">${baseList.delyDt} (${baseList.delyTime} 시)</c:when>
					    </c:choose>
					</td>
				</tr>
				<tr>
					<th>납품 장소</th>
					<td>${baseList.delyPlac}</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td>
					    <c:if test="${baseList.delyFileId != null}">
					    <a href="/component/file/ND_fileDownload.do?id=${baseList.delyFileId}" title="${baseList.delyFileOrgNm}" class="aDeisable">${baseList.delyFileOrgNm} <span class="tx_gray">(${baseList.delyFileSize}, ${baseList.delyFileTy})</span></a>
					    </c:if>
					</td>
				</tr>
				<tr>
					<th>공고설명</th>
					<td>${baseList.notifyCont}</td>
				</tr>
			</table>


                <c:if test="${baseList.bidPgesStat eq '1002' or baseList.bidPgesStat eq '1004' or baseList.bidPgesStat eq '1005' or baseList.bidPgesStat eq '1006' or baseList.bidPgesStat eq '1009'}">
					<h3>
					    <c:choose>
					        <c:when test="${baseList.bidPgesStat eq '1002'}">응찰현황
					        </c:when>
					        <c:when test="${baseList.bidPgesStat eq '1004'}">개찰현황
					        </c:when>
					        <c:when test="${baseList.bidPgesStat eq '1006'}">낙찰현황
					        </c:when>
					        <c:when test="${baseList.bidPgesStat eq '1005'}">유찰현황
					        </c:when>
					    </c:choose>
					</h3>
					<div class="bidSta">				
					    <c:choose>
					        <c:when test="${baseList.bidPgesStat eq '1002'}">
						        <!-- 응찰이 있는 경우 -->
						        <table class="tbl_st1">
							        <thead>
								        <tr>
									        <th>No</th>
									        <th>사업자번호</th>
									        <th>업체명</th>
									        <th>응찰금액(원)</th>
									        <th>응찰일시</th>
								        </tr>
							        </thead>
							        <tbody>
							            <c:set var="requestCnt" value="0"/>
	                                    <c:forEach items="${pager}" var="bidTenderList" varStatus="status">
	                                        <c:choose>
	                                            <c:when test="${bidTenderList.askApplyCd eq '1003'}">
	                                            <c:set var="requestCnt" value="${requestCnt+1}"/>
								        <tr>
								            <td>${status.count}</td>
								            <c:choose>
								                <c:when test="${bidTenderList.userId eq sessionScope['__usk'].userId or baseList.endsUserId eq sessionScope['__usk'].userId}">
											        <td>${bidTenderList.bizrno}</td>
											        <td>${bidTenderList.langStoreNm}</td>
											        <td><fmt:formatNumber value="${bidTenderList.splyAmt}" groupingUsed="true"/></td>
											        <td>${bidTenderList.bidEntrDt}</td>
								                </c:when>
								                <c:otherwise>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>비공개</td>
								                </c:otherwise>
								            </c:choose>
								        </tr>
	                                            </c:when>
	                                        </c:choose>
	                                    </c:forEach>
	                                    <c:if test="${requestCnt eq '0'}">
	                                    <tr>
	                                        <td colspan="5">응찰중인 업체가 없습니다.</td>
	                                    </tr>
	                                    </c:if>
							        </tbody>
						        </table>
						        <!--// 응찰이 있는 경우 -->
					        </c:when>

					        <c:when test="${baseList.bidPgesStat eq '1004' or baseList.bidPgesStat eq '1006'}">
								<!-- 개찰완료 -->
								<ul>
									<li>실제개찰일시: ${baseList.realOpenDt}&nbsp;${baseList.realOpenTm}시</li>
									<li>집행관: ${baseList.baffNm}</li>					
								</ul>
								<table class="tbl_st1">
									<thead>
										<tr>
											<th>No</th>
											<th>사업자번호</th>
											<th>업체명</th>
											<th>응찰금액(원)</th>
											<th>응찰일</th>
											<th>순위</th>
											<th>결과</th>
										</tr>
									</thead>
									<tbody>
									    <c:forEach items="${pager}" var="bidTenderList" varStatus="status">
										<tr>
											<td>${status.count}</td>
								            <c:choose>
								                <c:when test="${bidTenderList.userId eq sessionScope['__usk'].userId or baseList.endsUserId eq sessionScope['__usk'].userId}">

														<td>${bidTenderList.bizrno}</td>
														<td>${bidTenderList.langStoreNm}</td>
														<td><fmt:formatNumber value="${bidTenderList.splyAmt}" groupingUsed="true"/></td>
														<td>${bidTenderList.bidEntrDt}</td>
														<td><c:if test="${bidTenderList.bidRank eq 0}"></c:if><c:if test="${bidTenderList.bidRank ne 0}">${bidTenderList.bidRank}</c:if></td>
														<td>
														<c:choose>
														    <c:when test="${bidTenderList.bidSussGbn eq 'Y'}">낙찰</c:when>
														    <c:otherwise>-</c:otherwise>
														</c:choose>
														</td>
													
								                </c:when>
								                <c:otherwise>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>비공개</td>
											        <td>
														<c:choose>
														    <c:when test="${bidTenderList.bidSussGbn eq 'Y'}">낙찰</c:when>
														    <c:otherwise>-</c:otherwise>
														</c:choose>
											        </td>
								                </c:otherwise>
								            </c:choose>
                                        </tr>
									    </c:forEach>
									</tbody>					
								</table>
								<!--// 개찰완료 -->
					        </c:when>

	                        <c:when test="${baseList.bidPgesStat eq '1005' or baseList.bidPgesStat eq '1009'}">
	                            <!-- 유찰,공고연기,공고취소 -->
								<ul>
									<li>실제개찰일시: ${baseList.realOpenDt}&nbsp;${baseList.realOpenTm}시</li>
									<li>집행관: ${baseList.baffNm}</li>				
								</ul>
								<table class="tbl_st4">
									<tr>
										<th>개찰결과</th>
										<td>유찰 되었습니다.	</td>
									</tr>					
									<tr>
										<th>유찰사유</th>
										<td>${baseList.bidChngCause}</td>
									</tr>					
								</table>
								<!--// 유찰,낙찰취소,공고연기,공고취소 -->
	                        </c:when>

					    </c:choose>
					</div>
					<br />
                </c:if>
                
                
                <c:if test="${baseList.bidPgesStat eq '1007'}">
                	<h3>취소내역</h3>
					<table class="tbl_st4">
					    <tr>
						    <th>취소일자</th>
						    <td>${baseList.cnclDt}</td>
					    </tr>
					    <tr>
						    <th>취소사유</th>
						    <td>${baseList.bidChngCause}</td>
					    </tr>
					</table>
                </c:if>


			<div class="btnArea rig">
                <c:if test="${baseList.endsUserId ne sessionScope['__usk'].userId}">
				    <c:choose>
	                    <c:when test="${baseList.bidKndCd eq '1001'}">
				            <c:choose>
	                            <c:when test="${baseList.bidPgesStat eq '1001' or baseList.bidPgesStat eq '1002'}">
	                                <a href="#" onclick="jsBidEntend('${baseList.extendTermYn}','A'); return false;" class="btns st1 icn icnWrite">응찰</a>
	                            </c:when>
	                            <c:otherwise>
	                                <a href="#" onclick="jsBidEntend('${baseList.extendTermYn}','B'); return false;" class="btns st1 icn icnPs">나의응찰</a>
	                            </c:otherwise>
	                        </c:choose>
	                    </c:when>
	                </c:choose>
                </c:if>
				<a href="#" onclick="javascript:returnList(); return false;" class="btns st1 icn icnList">목록보기</a>
			</div>	
		</div>
	</div>
</body>
</html>