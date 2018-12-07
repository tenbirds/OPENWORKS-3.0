<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>서비스 승인대기</title>
  	<op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
    <script type="text/javascript" src="<c:url value="/resources/intra/store/goods.js" />"></script>
		<link rel="stylesheet" type="text/css" href="/resources/intra/store/layout.css" />
<!-- 		<link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_cmm.css" /> -->
		<link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_css.css" />
		<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub.css" />
		<link rel="stylesheet" type="text/css" href="/new_cloud/css/sub_ver2.css" />
		
		<link rel="stylesheet" type="text/css" href="/resources/openworks/spi/jquery/colobox/themes/theme5/colorbox.css" />
		<script src='/resources/intra/store/slider.js'></script> 
    <script type="text/javascript">
    //<CDATA[[
    //서비스규격서보기 
	    var jsSpec= function(el) {
	        $(el).colorbox({
	            title : "서비스규격서",
	            href : "/korean/pt/popup/PD_goodsSpecPop.do?goodsCode=${dataVo.goodsCode}",
	            width : "910",
	            height : "900",
	            iframe : true
	        });
	    };
	    
	    var jsGoodsUpdateConfn = function(sttus, action) {
	        if(confirm("승인완료 처리하겠습니까?")) {
	         if (sttus != '') {
	             $("#goodsRegistSttus").val(sttus);
	         }
	         $("#dataForm").attr("action", action);
	         $("#dataForm").submit();
	        }
	    };
    //]]>
    </script>
	</head>
<body>
    
	<!-- content -->
	<!-- <div class="conWrap swView" id="wrap_ver2">
		<div class="conWrap swView"> -->
	<form name="dataForm" id="dataForm" method="post">
	<op:pagerParam view="view" />
    <input type="hidden" name="goodsCode" 			id="goodsCode"			value="${dataVo.goodsCode}" />
    <input type="hidden" name="userId" 				id="userId"				value="${dataVo.userId}"></input>
    <input type="hidden" name="goodsStatus" 		id="goodsStatus"		value="${dataVo.goodsRegistSttus}"/>
    <input type="hidden" name="goodsRegistSttus"	id="goodsRegistSttus"	value="${dataVo.goodsRegistSttus}" />
  
	<!-- content -->
	
<div id="contents_area">
     <div class="mar_t20 mar_b50">
        <div class="float_l">
            <input type="button" value="승인반려" class="blue" onclick="jsRegistBack(this, 1005);" />
            <input type="button" value="승인완료" class="blue" onclick="jsGoodsUpdateConfn('1007','ND_goodsConfnUpdate.do');" />
            <!-- <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm();' /> -->
            <!-- <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_goodsPreview.do');" /> -->
        </div>
        <div class="float_r">
            <input type="button" value="목록" class="blue" onclick="jsList('BD_goodsConfnList.do');" />
        </div>
    </div>
	<div class="conWrap new_swView" id="wrap_ver2"  style="border-top:1px solid #bcbdbd; border-bottom:1px solid #bcbdbd; ">
	
		<div class="pro_title">
	  	<div class="f_l">
	    	<div class="pro_txt">
					<p>
						<c:if test="${not empty dataVo.itemImgUrl}"><img src="${ dataVo.itemImgUrl}" alt="${dataVo.goodsNm}" id="pathImage1" ><!-- 나라장터연계이미지  --></c:if> 
						<c:if test="${ empty dataVo.itemImgUrl}"><img src="${dataVo.imageFile[0].fileUrl}" alt="${dataVo.goodsNm}" id="pathImage1" ></c:if>
					</p>
					<p>${dataVo.goodsNm}<span>계약건수<strong>${suplycnt}건</strong></span></p>  
					<p>서비스분류 : <c:if test="${dataVo.langCtgryNm eq 'PaaS'}">플랫폼</c:if> <c:if test="${dataVo.langCtgryNm ne 'PaaS'}">${dataVo.langCtgryNm}</c:if></p>
					<p><!-- 인증정보 -->
						<c:forEach items="${dataVo.goodsMark}" var="_goodsMark" varStatus="status">
							${_goodsMark.MARKNM}
						</c:forEach>
					</p> 
				</div>
				<c:if test="${dataVo.svcPc ne null and dataVo.svcPc ne ''and dataVo.svcPc ne '0'}">
					<p class="pro_price"><fmt:formatNumber value="${dataVo.svcPc}" type="number" /> ${dataVo.svcPcUntCdNm} / ${dataVo.dueStdrMummNm}</p>
				</c:if>
				<div style="margin-bottom:10px">
					<c:if test="${not empty dataVo.goodsDwldUrl}"><a href="${dataVo.goodsDwldUrl}" target="_blank"  class="btns st1" style="color:#ffffff;">서비스 안내</a></c:if>
					<c:if test="${not empty dataVo.priceFile}">
						<c:forEach items="${dataVo.priceFile}" var="_priceFilee" varStatus="status">
						<%-- <a  href="javascript:;" onclick="jsFileDown('${_priceFilee.fileId}');"  class="btns st1" style="color:#ffffff;">서비스가격표</a> --%>
					  <c:set var="priceFileVO" value="${dataVo.priceFile[0]}" />
						<span><a href="/component/file/ND_fileDownload.do?id=${priceFileVO.fileId }" title="${priceFileVO.localNm}" class="btns st1" style="color:#ffffff;">서비스가격표</a></span>
						</c:forEach>
					</c:if>
					
					<c:if test="${not empty dataVo.itemVodUrl}">
						<a  href="${dataVo.itemVodUrl}" target="_blank"  class="btns st1" style="color:#ffffff;">서비스 체험하기</a>
					</c:if>
					
					<%-- <c:if test="${dataVo.goodsKndCd ne 1004}"> --%>
						<c:if test="${dataVo.specMaxNum > 0}">
							<a  href="javascript:;" onclick="jsSpec(this);" class="btns st1" style="color:#ffffff;">서비스규격서</a>
						</c:if>
						<c:if test="${dataVo.goodsMnlFileSeq < 1}">
							<c:if test="${not empty dataVo.mnlFile}">
							   <c:forEach items="${dataVo.mnlFile}" var="_mnlFile" varStatus="status">
									<a  href="javascript:;" onclick="jsFileDown('${_mnlFile.fileId}');" title="${_mnlFile.localNm}"  class="btns st1">서비스규격서</a>
							   </c:forEach>
							</c:if> 
						</c:if>
					<%-- </c:if> --%>
				</div>
	    </div>
	    <div class="f_r">
	    	<table class="normal_table" summary="제공자 정보">
	    		<caption>제공자 정보</caption>
        	<colgroup>
          	<col width="10%">
            <col width="*">
          </colgroup>
          <thead>
          	<tr>
          		<th scope="col" colspan="2" style="text-align:left">
          			<h3 style="margin-bottom:0"><i>제공자 정보</i></h3>
          		</th>
	          </tr>
	        </thead>
	        <tbody>
						<tr>
							<td scope="col">제공자명</td>
							<td>
								<c:if test="${ empty dataVo.goodsStore[0].LANGSTORENM}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsStore[0].LANGSTORENM}">${dataVo.goodsStore[0].LANGSTORENM}</c:if>									
							</td>
						</tr>
						<tr>
							<td scope="col">기업구분</td>
						  <td>
						  	<c:if test="${ empty dataVo.smlpzChk}">해당없음</c:if> 
								<c:if test="${not empty dataVo.smlpzChk}">${dataVo.smlpzChk}</c:if>
					  	</td>
						</tr>
						<tr>
							<td scope="col">담당자</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerNm}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerNm}">${dataVo.goodsChargerNm}</c:if>
							</td>
						</tr>
						<tr>
							<td scope="col">연락처</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerCttpc}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerCttpc}">
									<c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) == 4}">
										${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}-${dataVo.goodsChargerCttpc.split('-')[3]}
			            </c:if>
			            <c:if test="${fn:length(dataVo.goodsChargerCttpc.split('-')) < 4}">
			            	${dataVo.goodsChargerCttpc.split('-')[0]}-${dataVo.goodsChargerCttpc.split('-')[1]}-${dataVo.goodsChargerCttpc.split('-')[2]}
			            </c:if>
								</c:if>		
							</td>
						</tr>
						<tr>
							<td scope="col">이메일</td>
							<td>
								<c:if test="${ empty dataVo.goodsChargerEmail}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsChargerEmail}">
									<a href="mailto:${dataVo.goodsChargerEmail}">${dataVo.goodsChargerEmail}</a> 
								</c:if>								
							</td>
						</tr>
					</tbody>
					<tfoot hidden="hidden"><tr><td colspan="2"></td></tr></tfoot>
	      </table>    
			</div>
		</div>

		<div class="btnArea rig">
		</div>
		<section>
			<c:if test="${not empty ppsList}">
			<h3 style="margin-bottom:0"><i>나라장터 종합쇼핑몰 구매</i></h3>
			<div>
				<table class="tbl_st6 faq">
					<caption></caption>
					<colgroup>
						<col width="6%">
						<col width="*">
						<%-- <col width="6%"> --%>
						<col width="20%">
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>규격명</th>
							<!-- <th>구매 수량</th> -->
							<th>금액</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${ppsList}" var="_ppsList" varStatus="status">
					<input type="hidden" name="unitPric" value="${_ppsList.unitPric}">
							<input  name="basktGoodsQy" type="hidden" placeholder="1">
						<tr>
							<td><input type="checkbox" name="thngCheckBoxArr"  id="thngCheckBoxArr"  value="${_ppsList.cntrNum}${_ppsList.lineNum}"></td>
							<td> ${_ppsList.itemName}</td>
							<td><fmt:formatNumber value="${_ppsList.unitPric}" type="NUMBER" groupingUsed="true" /> 원</td>
						</tr>
					</c:forEach>
				</table>
				<p class="btn_cen"><a href="#" class="btns st1" onClick="basktReg();">나라장터에서 구매</a></p>
			</div>
			</c:if>	
			<h3 style="margin-bottom:0; background: url('')"><i>서비스 개요</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsChargerNm}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsChargerNm}">
					<op:nrToBr content="${dataVo.goodsSumry}" /> 
				</c:if>					
				
			</div>
			<h3 style="margin-bottom:0; background: url('')"><i>특장점</i></h3>
			<div>
           		<c:if test="${ empty dataVo.itemSfe}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.itemSfe}">
					<c:out value="${dataVo.itemSfe}" escapeXml="false" />
				</c:if>
			</div>
			<h3 style="margin-bottom:0; background: url('')"><i>대상고객</i></h3>
			<div>
           		<c:if test="${ empty dataVo.cstmrInfo}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.cstmrInfo}">
					<c:out value="${dataVo.cstmrInfo}" escapeXml="false" />
				</c:if>
			</div>
			<h3 style="margin-bottom:0; background: url('')"><i>주요레퍼런스</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsRefer}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsRefer}">
					<c:out value="${dataVo.goodsRefer}" escapeXml="false" />
				</c:if>				  
			</div>
			<h3 style="margin-bottom:0; background: url('')"><i>주요기능</i></h3>
			<div>
           		<c:if test="${ empty dataVo.goodsMainFnct}">
           	 		해당없음
           		</c:if> 
				<c:if test="${not empty dataVo.goodsMainFnct}">
					<c:out value="${dataVo.goodsMainFnct}" escapeXml="false" />
				</c:if>				
			</div>

<c:if test="${goodsTyCd ne '1004'}">
			<h3 style="margin-bottom:0; background: url('')"><i>서비스 사양</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" style="width: 100%" summary="서비스 사양">
					<caption>서비스 사양</caption>
					<colgroup>
						<col width="160px">
						<col width="*">
					</colgroup>
					<thead hidden="true">
						<tr>
							<th scope="col">사양</th>
							<th scope="col">내용</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td scope="col">서비스 관리기준</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaSvc}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaSvc}">
									<c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaSvc.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">인증정보</td>
							<td>
								<c:if test="${ empty dataVo.goodsMark}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMark}">
									<c:forEach items="${dataVo.goodsMark}" var="_goodsMark" varStatus="status">
									${fileVo.fileUrl}
										<c:forEach items="${dataVo.markCrtfcFile[status.index]}" var="fileVo" varStatus="status1">
											<img src="${fileVo.fileUrl}" title="${_goodsMark.MARKNM}" width="33" height="33" alt="${_goodsMark.MARKNM}"/> ${_goodsMark.MARKNM}
											<c:if test="${!status.first}">, </c:if>
										</c:forEach>
										<c:if test="${empty dataVo.markCrtfcFile[status.index]}">
											${_goodsMark.MARKNM}<c:if test="${!status.first}">, </c:if>
										</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">구축방식</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaCnstcMthd}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaCnstcMthd}">
									<c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
								<input name="metaCnstcMthds" id="metaCnstcMthds" type="hidden" value="<c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">${_goodsMetaCnstcMthd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
							</td>
						</tr>
						<tr>
							<td scope="col">서비스유형</td>
							<td>
								<c:if test="${ empty dataVo.serviceOfferMethodNm}">해당없음</c:if> 
								<c:if test="${not empty dataVo.serviceOfferMethodNm}">
									${dataVo.serviceOfferMethodNm}
								</c:if>								
							</td>
						</tr>
						<tr>
							<td scope="col">아키텍처</td>
							<td>
								<c:if test="${ empty dataVo.archtcSe}">해당없음</c:if> 						
								<c:if test="${not empty dataVo.archtcSe}">
									<c:choose>
										<c:when test="${dataVo.archtcSe == 1}">
											32-bit
										</c:when>
										<c:when test="${dataVo.archtcSe == 2}">
											64-bit
										</c:when>
										<c:when test="${dataVo.archtcSe == 3}">
											32-bit, 64-bit
										</c:when>
									</c:choose>
								</c:if>
							</td>
						</tr>
						<tr>
							<td scope="col">지원OS</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaOS}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaOS}">
									<c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">
										<c:if test="${!status.first}">, </c:if>${_goodsMetaOS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaOS.INDVDLZ_CD eq 9001 }">(${_goodsMetaOS.META_ETC_CN})</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>  
						<tr>
							<td scope="col">지원언어</td>
							<td>
                    <c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
                    	<c:if test="${_goodsMetaLang.LANGCD == _goodsMetaLang.METALANGCD}">
                    	 <c:if test="${!status.first}">, </c:if> ${_goodsMetaLang.LANGNM} </c:if>
                        ${_goodsMetaLang.INDVDLZ_CD_NM}
                    </c:forEach>
							
							
<%-- 								<c:if test="${ empty dataVo.goodsMetaLang}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaLang}">
									<c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status"><c:if test="${!status.first}">, </c:if>
										${_goodsMetaLang.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	 --%>
							</td>
						</tr> 
						<tr>
							<td scope="col">A/S</td>
							<td>
								<c:if test="${ empty dataVo.goodsMetaAS}">해당없음</c:if> 
								<c:if test="${not empty dataVo.goodsMetaAS}">
									<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">
										<c:if test="${!status.first}">, </c:if>${_goodsMetaAS.INDVDLZ_CD_NM}<c:if test="${_goodsMetaAS.INDVDLZ_CD eq 1005 }">(${_goodsMetaAS.META_ETC_CN})</c:if>
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">호환성</td>
							<td>
				          		<c:if test="${ empty dataVo.goodsMetaStd}">
				          	 		해당없음
				          		</c:if> 
								<c:if test="${not empty dataVo.goodsMetaStd}">
									<c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status"><c:if test="${!status.first}">, </c:if>${_goodsMetaStd.INDVDLZ_CD_NM}
									</c:forEach>
								</c:if>	
							</td>
						</tr>
						<tr>
							<td scope="col">제조사</td>
							<td>
				          		<c:if test="${ empty dataVo.goodsMakr}">
				          	 		해당없음
				          		</c:if> 
								<c:if test="${not empty dataVo.goodsMakr}">
									${dataVo.goodsMakr}
								</c:if>								
							</td>
						</tr>
						<tr>
							<td scope="col">출시일</td>
							<td>
								<c:if test="${ empty dataVo.comouDe}">해당없음</c:if> 
								<c:if test="${not empty dataVo.comouDe}">${dataVo.comouDe}</c:if>								
							</td>
						</tr>
					</tbody>
					<tfoot hidden="true">
						<tr>
							<td colspan="2"></td>
						</tr>
					</tfoot>
				</table>
			</div>
</c:if>
			<c:if test="${ not empty dataVo.dnlFile or not empty dataVo.etcFile}">
			<h3 style="margin-bottom:0; background: url('')"><i>매뉴얼 및 첨부파일</i></h3>
			<div>
				<table border="0" cellspacing="0" cellpadding="0" class="normal_table" width="100%" summary="매뉴얼 및 첨부파일">
					<caption>매뉴얼 및 첨부파일</caption>
					<colgroup>
						<col width="160px">
						<col width="*">
					</colgroup>
					<thead hidden="hidden"><tr><th scope="col" colspan="2"></th></tr></thead>
					<c:if test="${not empty dataVo.dnlFile}">
					<tr>
						<td scope="col">사용자 메뉴얼</td>
						<td><c:forEach items="${dataVo.dnlFile}" var="_dnlFile" varStatus="status">
							${_dnlFile.localNm}<a href="javascript:;"  onclick="jsFileDown('${_dnlFile.fileId}');" title="${_dnlFile.localNm}"  class="btn_ml"><img src="/cloud_ver2/new_cloud/images/icn_txt_downLoad.png" alt="다운로드"></a>
							</c:forEach>
						</td>
					</tr>
					</c:if>
					<c:if test="${not empty dataVo.etcFile}">
					<tr>
						<td class="font_normal font14 borB0">기타 첨부파일</td>
						<td class="borR0 borB0">
				 	   <c:forEach items="${dataVo.etcFile}" var="_etcFile" varStatus="status">
						${_etcFile.localNm}<a href="javascript:;"  onclick="jsFileDown('${_etcFile.fileId}');" title="${_etcFile.localNm}"  class="btn_ml"><img src="/cloud_ver2/new_cloud/images/icn_txt_downLoad.png" alt="다운로드"></a>
						</c:forEach> 
						</td>
					</tr>
					</c:if> 
				</table>
			</div>
			</c:if> 
			<c:if test="${goodsTyCd ne '1004'}">
			<h3 style="margin-bottom:0; background: url('')"><i>관련 이미지</i></h3>
			<div class="ps_r firstImg_img_area">
				<div id="firstImg">
					<c:if test="${ not empty dataVo.imageFile[1].fileUrl }">
					<img src="${dataVo.imageFile[1].fileUrl}" alt="관련이미지" />
					</c:if>
				</div>
				<div class="screen_img_area">
					<ul>
						<c:if test="${ not empty dataVo.imageFile[1].fileUrl }">
							<input type="hidden" id="scrImg" value="${dataVo.imageFile[1].fileUrl}" />
							<input type="hidden" id="seqImg" value="${dataVo.goodsImageFileSeq}" />
				      <c:forEach var="j" begin="1" end="2" step="1" varStatus="imgUlStatus">
				      	<c:if test="${(j-1)*5 < (fn:length(dataVo.imageFile)-1)}">
									<c:forEach var="i" begin="${1 + ((j-1)*5)}" end="${5 + ((j-1)*5)}" step="1" varStatus="imgLiStatus">
										<c:if test="${!empty dataVo.imageFile[i]}">
				            	<li class="small_screen_img">
				            		<span id="imgFiles" style="cursor: pointer;" onclick="fnLoadImg('${dataVo.imageFile[i].fileUrl}')">
				            			<img src="${dataVo.imageFile[i].fileUrl}" alt="${dataVo.goodsNm}"  />
				            		</span><img src="${dataVo.imageFile[i].fileUrl}" alt="${dataVo.goodsNm}"  />
				            	</li>
				            </c:if>
				          </c:forEach>
				        </c:if>
				      </c:forEach>
						</c:if> 
						<c:if test="${empty dataVo.imageFile[1].fileUrl }">
							<input type="hidden" id="scrImg" value="" />
						</c:if>
					</ul>
				</div>
			</div>
			</c:if>
		</section>
		
	</div>
     <div class="mar_t20 mar_b50">
        <div class="float_l">
            <input type="button" value="승인반려" class="blue" onclick="jsRegistBack(this, 1005);" />
            <input type="button" value="승인완료" class="blue" onclick="jsGoodsUpdateConfn('1007','ND_goodsConfnUpdate.do');" />
            <!-- <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm();' /> -->
            <!-- <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_goodsPreview.do');" /> -->
        </div>
        <div class="float_r">
            <input type="button" value="목록" class="blue" onclick="javascript:location.href='BD_goodsConfnList.do';" />
        </div>
    </div>
</div>
		</form>
	
</body>
</html>