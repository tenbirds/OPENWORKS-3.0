<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8" />
  <title>정보수정 - 판매 권한 신청</title>
  <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_css.css' />
    
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	
	<op:jsTag type="openworks" items="ui, validate, form" />
	<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<!-- //KICA SecuKit NX -->
	<script type="text/javascript">
	  var jsLsitAction = function() {
	            $("#dataForm").attr("action", "BD_suppliIndex.do");
	            $("#dataForm").submit();
	   }	
	</script>  
 </head>

 <body>
<!-- <section class="lay_lnb"> -->
<!-- <div class="conWrap"> -->
<div class="join_info inputOffer">
<form name="dataForm" id="dataForm"  method="post">
	<!-- content -->
	
		
			
			
				<c:if test="${not empty bassAgrem and bassAgrem.agremStat eq '1003'}" >
				<h4>한국정보화진흥원 알림사항</h4>
				<table class="tbl_st4">
					<tr>
						<th>상태</th>
						<td>
							승인보류
							<i class="importInfo_1">※ 승인보류 시 관련내용을 보완하여 보완신청 해 주세요</i>
						</td>
					</tr>
					<tr>
						<th>알림사항</th>
						<td class="importInfo_2"><c:if test="${ null eq baseVo.mangComt}">관리자 의견이 없습니다.</c:if><c:if test="${ null ne baseVo.mangComt}">${baseVo.mangComt}</c:if></td>
					</tr>
				</table>
				</c:if>
				
				<p><i>*</i> 으로 표시된 항목은 필수 입력 사항입니다.</p>
		
				<h4>필수정보</h4>
				
				<table class="tbl_st4">
					<tr>
						<th>담당자 명</th>
						<td>${svcStror.storeChargerNm}</td>
					</tr>
				</table>
				
				<h4>기업정보</h4>
				<table class="tbl_st4">
					<tr>
						<th>기업 명</th>
						<td>${svcStror.langStoreNm}</td>
						<th class="requ">소재지</th>
						<td>
						<select id="cmpnyLoca" name="cmpnyLoca" style="width:100px;" disabled>
								<c:forEach items="${cmpnyLocaList}" var="cmLocal">
			            		<option value="${cmLocal.PRVCD}" <c:if test="${cmLocal.PRVCD == bassAgrem.cmpnyLoca}">selected="selected"</c:if>>${cmLocal.PRVNM}</option>
								</c:forEach>
						</select>
				</td>
					</tr>
					<tr>
						<th>회사로고</th>
						<td colspan="3" class="thumb">							
							<span id="imgPrev1">
								<p class="thumbimg">
									<c:if test="${not empty svcStror.fileList[0]}">
										<img src="${svcStror.fileList[0].fileUrl}" alt="${svcStror.fileList[0].localNm}" id="img1">
									</c:if>
								</p>
							</span>
							<div class="uploadFileWrap">
									<c:if test="${not empty svcStror.fileList[0]}">
										<div>
											<span>
												<a href="/component/file/ND_fileDownload.do?id=${svcStror.fileList[0].fileId }"
													title="${svcStror.fileList[0].localNm}" class="aDeisable">${svcStror.fileList[0].localNm}
													(${svcStror.fileList[0].fileSize}, ${svcStror.fileList[0].fileType})
												</a> 
											</span>
										</div>
									</c:if>   	          
								<p class="desc">jpg, png (권장 160x120픽셀 ) 파일</p>
							</div>
						</td>
					</tr>
					<tr>
						<th class="requ">대표전화</th>
						<td colspan="3" class="tel">${svcStror.reprsntTelno1} - ${svcStror.reprsntTelno2} - ${svcStror.reprsntTelno3}</td>
					</tr>
					<tr>
						<th>사업자 등록번호</th>
						<td colspan="3">
							${bassAgrem.bizrno}
						</td>
					</tr>
					<tr>
		           <%--  <th>관리자 의견</th>
			            <td colspan="5">
			            <textarea name="mangComt" id="mangComt" style="border:5px;resize:none;width:100%; height:100px;" readonly="readonly" ><c:if test="${ null eq baseVo.mangComt}">관리자 의견이 없습니다.</c:if><c:if test="${ null ne baseVo.mangComt}">${baseVo.mangComt}</c:if></textarea>           
			            </td>
		            </tr> --%>
				</table>
				
				<h4>구비서류 첨부<i>※ PDF파일로 업로드 하셔야 합니다.</i></h4>
				<table class="tbl_st4">
					<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
						<c:if test="${not empty bassAgrem.lastAgrmntFile[i-1]}">
							<tr>
								<th class="requ">확정협약서</th>
								<td>
								<div>
									<span>
										<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.lastAgrmntFile[i-1].fileId }"
											title="${bassAgrem.lastAgrmntFile[i-1].localNm}" class="aDeisable">${bassAgrem.lastAgrmntFile[i-1].localNm}
											(${bassAgrem.lastAgrmntFile[i-1].fileSize}, ${bassAgrem.lastAgrmntFile[i-1].fileType})
										</a>
									</span>
								</div>
								</td>
							</tr>
						</c:if>		
					</c:forEach>			
					<tr>
						<th class="requ">제출협약서</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.bassAgrmntFile[i-1]}">
									<div>
										<span >
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.bassAgrmntFile[i-1].fileId }"
												title="${bassAgrem.bassAgrmntFile[i-1].localNm}" class="aDeisable">${bassAgrem.bassAgrmntFile[i-1].localNm}
												(${bassAgrem.bassAgrmntFile[i-1].fileSize}, ${bassAgrem.bassAgrmntFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th class="requ">등기부등본</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.rgsbukTrnscrFile[i-1]}">
									<div>
										<span>
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.rgsbukTrnscrFile[i-1].fileId }"
												title="${bassAgrem.rgsbukTrnscrFile[i-1].localNm}" class="aDeisable">${bassAgrem.rgsbukTrnscrFile[i-1].localNm}
												(${bassAgrem.rgsbukTrnscrFile[i-1].fileSize}, ${bassAgrem.rgsbukTrnscrFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>			            
						</td>
					</tr>
					<tr>
						<th class="requ">신용평가서</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.cdltDocFile[i-1]}">
									<div>
										<span>
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.cdltDocFile[i-1].fileId }"
												title="${bassAgrem.cdltDocFile[i-1].localNm}" class="aDeisable">${bassAgrem.cdltDocFile[i-1].localNm}
												(${bassAgrem.cdltDocFile[i-1].fileSize}, ${bassAgrem.cdltDocFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>		            
						</td>
					</tr>
			 	<tr>
						<th class="requ">재무제표</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.fnlttFile[i-1]}">
									<div>
										<span>
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.fnlttFile[i-1].fileId }"
												title="${bassAgrem.fnlttFile[i-1].localNm}" class="aDeisable">${bassAgrem.fnlttFile[i-1].localNm}
												(${bassAgrem.fnlttFile[i-1].fileSize}, ${bassAgrem.fnlttFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>		            
						</td>
					</tr>
					<tr>
						<th>벤처기업인증서</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.vnentrCrtfFile[i-1]}">
									<div>
										<span>
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.vnentrCrtfFile[i-1].fileId }"
												title="${bassAgrem.vnentrCrtfFile[i-1].localNm}" class="aDeisable">${bassAgrem.vnentrCrtfFile[i-1].localNm}
												(${bassAgrem.vnentrCrtfFile[i-1].fileSize}, ${bassAgrem.vnentrCrtfFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>		            
						</td>
					</tr>
					<tr>
						<th>직접생산증명서</th>
						<td> 
							<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">
								<c:if test="${not empty bassAgrem.directPrdctnCrtfFile[i-1]}">
									<div>
										<span>
											<a href="/component/file/ND_fileDownload.do?id=${bassAgrem.directPrdctnCrtfFile[i-1].fileId }"
												title="${bassAgrem.directPrdctnCrtfFile[i-1].localNm}" class="aDeisable">${bassAgrem.directPrdctnCrtfFile[i-1].localNm}
												(${bassAgrem.directPrdctnCrtfFile[i-1].fileSize}, ${bassAgrem.directPrdctnCrtfFile[i-1].fileType})
											</a>
										</span>
									</div>
								</c:if>
							</c:forEach>		            
						</td>
					</tr> 
				</table>
				
				<div class="btnArea rig">
					<c:if test="${screenType eq 'forSale'}">
					<a href="javascript:jsLsitAction();" class="btns st1 icn icnList">목록보기</a>
					</c:if>
				</div>
			
		
	
	<!--// content -->
	</form>
	</div>
	<!-- </div> -->
	<!-- </section> -->
 </body>
</html>