<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>서비스 상세조회/수정</title>
    <op:jsTag type="openworks" items="form, validate, ckeditor" />
    <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
    <script type="text/javascript" src="<c:url value="/resources/intra/store/goods.js" />"></script>
	 <script type="text/javascript">
	    // 파일 변경 버튼 클릭
	    function file_browse(){
	        document.dataForm.imageFile1.click();
	        //document.Form.text1.value=document.Form.file.value;
	    }
    </script>
</head>
<body>
	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
    <!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
    <op:pagerParam view="view" />

    <input type="hidden" name="goodsCode" id="goodsCode" value="${dataVo.goodsCode}" />
    <input name="userId" id="userId" class="w_92p" type="hidden" value="${dataVo.userId}"></input>
    <input type="hidden" name="goodsStatus" value="${dataVo.goodsRegistSttus}" id="goodsStatus"/>
    <input type="hidden" name="goodsRegistSttus" value="${dataVo.goodsRegistSttus}" id="goodsStatus"/>

    <table class="w_100p mar_b5">
			<tr>
				<td class="tx_r">
        	<input type="button" value="변경신청이력" class="blue w120" onclick="jsRegHistoryPop(this, '${dataVo.goodsCode}');return false;"></input>
          <input type="button" value="규격서이력 " class="blue w120" onclick="jsSpecHistoryPop(this, '${dataVo.goodsCode}');return false;"></input>
           <%--  <input type="button" value="이력관리" class="blue w80" onclick="jsHistoryPop(this, '${dataVo.goodsCode}');return false;"></input> --%>
        </td>
    	</tr>
    </table>

    <table class="boardWrite">
    	<colgroup>
      	<col width="150" />
        <col width="" />
      </colgroup>
      <tbody>
      <!-- 서비스 언어 -->
      	<tr>
        	<th><span class="tx_red_s">*</span>서비스 언어</th>
          	<td>
            	<input name="langCode" id="langCode" type="hidden" value="${dataVo.langCode}"/>${dataVo.langNm}
            </td>
        </tr>
      <!-- //서비스 언어 -->
            
			<!-- 전시여부 -->
			<tr>
				<th><span class="tx_red_s">*</span>전시여부</th>
					<td>
						<c:if test="${dataVo.goodsRegistSttus < 1008}">
						<op:code id="1212" grpCd="1008" ctgCd="DSPYN" type="radio" defaultValues="${empty dataVo.goodsRegistSttus ? '1006' : dataVo.goodsRegistSttus}" option="disabled"/>
						</c:if>
						<c:if test="${dataVo.goodsRegistSttus >= 1008}">
					비전시 변경 중이서 수정이 불가능합니다.
				</c:if>
				</td>
			</tr>
			<!-- //전시여부 -->

			<!-- 서비스구분선택 [2015.01.18 추가] -->
			<tr>
			    <th><span class="tx_red_s">*</span>서비스구분선택</th>  
                <td>
			        <op:code id="goodsKndCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${empty dataVo.goodsKndCd ? '1002' : dataVo.goodsKndCd}" type="radio" onclick="jsCtgryList(this.value)" />
			    </td>			
			</tr>
			<!-- //서비스구분선택 [2015.01.18 추가] -->	

			<!-- 서비스명 -->
			<tr>
				<th><span class="tx_red_s">*</span>서비스명</th>
				<td><input name="goodsNm" id="goodsNm" class="w_92p" type="text" value="${dataVo.goodsNm}" style="ime-mode:active"></input></td>
			</tr>
            <!-- 서비스명 -->

			<!-- 카테고리 -->
			<tr>
				<th><span class="tx_red_s">*</span>카테고리</th>
				<td>
				    <div>
					    <input type="button" id="ctgryBtn" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this);" />
                        <c:set var="setCtgryCodes" value=""/>
                        <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
                            <c:choose>
                                <c:when test="${status.first}">
                                    <c:set var="setCtgryCodes" value="${_goodsCtgry.CTGRYCODE}"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="setCtgryCodes" value="${setCtgryCodes}, ${_goodsCtgry.CTGRYCODE}"/>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <input type="hidden" id="setCtgryCodes" name="setCtgryCodes" value="${setCtgryCodes}"/>
					</div>
					
					<table id="ctgryTitle">
					    <tr>
					        <td colspan="3">
					            <div class="mar_t10 tx_b" id="test">연결된 카테고리</div>
					        </td>
					    </tr>
					</table>
					<table id="goodsCtgry">
             <c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry" varStatus="status">
             <tr id="goodsCtgry_${_goodsCtgry.CTGRYCODE}">
                 <td>[${_goodsCtgry.CTGRYCLNM }]</td>
                 <td>${_goodsCtgry.CTGRYPATH}</td>
                 <td>
                     <input type="button" id="goodsCtgry_${_goodsCtgry.CTGRYCODE}" value="X" onclick="jsCategoryDelete(this);"/>
                     <input type="hidden" name="ctgryCds" class="getCtgryCodes" value="${_goodsCtgry.CTGRYCODE}"/>
                 </td>
             </tr>
             </c:forEach>
					</table>
				</td>
			</tr>
			<!-- //카테고리 -->
            
			<!-- 대표 이미지 등록 -->
			<tr>
				<th><span class="tx_red_s">*</span>대표 이미지 등록<br/>사이즈 (300X250)</th>
				<td>
				    <input type="hidden" name="goodsImageFileSeq" value="<c:out value='${dataVo.goodsImageFileSeq}'/>"  />
					
					<!-- 대표이미지가 없을 경우 등록란 표기 -->
			        <span id="imageFile1Div" style="vertical-align: sub;overflow:hidden;" >
			            <input type="file" name="imageFile1" id="imageFile1" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile1', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',1,'Img', -1, 5);"/>
			            <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile1');"/>
			        </span>
			        
			        <!-- 대표이미지가 있을 경우 다운로드 링크와 변경 버튼 표기 -->
			        &nbsp;&nbsp;
		            <c:set var="fileVo" value="${dataVo.imageFile[0]}" />
		            <c:set var="image" value="" />
                    <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} 
                        <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span>
                    </a>
                    <!--
                        <input class="mar_l5" type="button" value="변경" onclick="javascript:file_browse();"/> 
                    -->
                    <input type="hidden" name="fileDesc" id="imageFile1Desc" value="" />
					<br/>
					<img src="${fileVo.fileUrl}" height="80px;">
				</td>
			</tr>
			<!-- //대표 이미지 등록 -->

			<!-- 사용자화면 이미지 -->
			<tr>
				<th>사용자화면 이미지 등록<br/>사이즈 (800X500)</th>
				<td>
		            <input type="hidden" name="goodsImageFileSeq" value="<c:out value='${dataVo.goodsImageFileSeq}'/>"  />
		            <!-- 이미지 파일 갯수 -->
		            <c:set var="imgFileCnt" value="${fn:length(dataVo.imageFile)+1}" />
                    <!-- 이미지 파일이 1개 이하이면 타이틀 이미지만 등록된 상태 -->
                    <c:if test="${fn:length(dataVo.imageFile) <= 1}">
                        <c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
                        <span id="imageFile${i}Div" style="vertical-align: sub;">
                            <input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',${i},'Img', -1, 5);"/>
                        </span>
                        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
                        <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
                        <c:if test="${not status.last}"><br/></c:if>
                        </c:forEach>
                    </c:if>
                    <!-- 이미지 파일이 1개 초과면 사용자 이미지가 등록된 상태 -->
                    <c:if test="${fn:length(dataVo.imageFile) > 1}">
                        <!-- 등록된 사용자 이미지 출력 -->
                        <c:forEach items="${dataVo.imageFile}" var="fileVo" begin="1" end="${imgFileCnt}" varStatus="status">
                        <div class="mar_b5">
                            <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                            <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
                            <c:if test="${not status.last}"><br/></c:if>
                        </div>
                        <input type="hidden" name="image" value="${fileVo.fileUrl}" />
                        </c:forEach>

                        <!-- 추가할 입력 란 -->
                        <c:forEach var="i" begin="${imgFileCnt}" end="11" step="1" varStatus="status">
                        <span id="imageFile${i}Div" style="vertical-align: sub;">
                            <input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',${i},'Img', -1, 5);"/>
                        </span>
                        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
                        <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
                        <c:if test="${not status.last}"><br/></c:if>
                        </c:forEach>
                         <div class="mar_b5">
                        <c:forEach items="${dataVo.imageFile}" var="fileVo" begin="1" end="${imgFileCnt}" varStatus="status">
                          <img src="${fileVo.fileUrl}" height="80px;">
                        </c:forEach></div>
                        </c:if>

				</td>
			</tr>
			<!-- //사용자화면 이미지 -->

			<!-- 체험판 -->
			<tr>
				<th>체험판</th>
				<td>
				    <div class="fr">
					    <p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
					    <input type="text" name="itemVodUrl" id="itemVodUrl" value="${dataVo.itemVodUrl}" class="w_92p"/>
				    </div>
				</td>
			</tr>
			<!-- //체험판 -->
			
			<!-- 서비스상세 -->
			<tr>
				<th>서비스상세</th>
				<td>
					<div class="fr ml20">
						<p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
						<input type="text" name="goodsDwldUrl" id="goodsDwldUrl" value="<c:out value='${dataVo.goodsDwldUrl}'/>" class="w_92p" />
					</div>
				</td>
			</tr>
			<!-- //서비스상세 -->
			
			<!-- 소개영상 -->
<%-- 	2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함		
			<tr>
			    <th>소개영상</th>
				<td>
					<div class="fr ml20">
						<p class="caption">※ 유투브에 등록된 동영상만 지원 가능합니다.</p>
						<strong><span>https://www.youtube.com/embed/</span></strong>
						<input name="demoExprnUrl" id="demoExprnUrl" type="text" value="<c:out value='${dataVo.demoExprnUrl}'/>" style="width:330px" />
					</div>
				</td>
			</tr> --%>
			<!-- //소개영상 -->
			
			<!-- 모니터링 URL -->
			<tr>
			    <th>모니터링 URL</th>
				<td>
					<div class="fr ml20">
						<p class="caption">※ 모니터링URL  서비스 상태를  확인할 수 있는 모니터링 URL을 입력해주세요.</p>
						<input name="goodsMonitorUrl" id="goodsMonitorUrl" type="text" value="<c:out value='${dataVo.goodsMonitorUrl}'/>" class="w_92p" />
					</div>
				</td>
			</tr>
			<!-- //모니터링 URL -->
			
            <!-- 인증구분 -->
			<tr>
				<th>인증구분</th>
				<td>
					<table style="width:100%">
					<c:forEach items="${dataVo.goodsMark}" var="_goodsMark" varStatus="statusSeq">
					<c:set var="goodsMarkCnt" value="${fn:length(dataVo.markCrtfcFile[ statusSeq.index ])}" />
					<input type="hidden" name="crtfcSeFileSeqs" value="${_goodsMark.CRTFCSEFILESEQ}" />
					<tr>
					    <td width="200px">
					        <input type="hidden" name="markCds" value="${_goodsMark.MARKCD}"></input>
					        <input type="checkbox" name="goodsMarkCds" value="${_goodsMark.MARKCD}" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>${_goodsMark.MARKNM}
					    </td>
					    
					    <!-- 나라장터 종합쇼핑몰 일경우 -->
					    <c:if test="${_goodsMark.MARKCD == '1005'}">
					    <td>
                            <input type="text" id="cntrctNo" name="cntrctNo" style="width:630px" value="<c:out value='${dataVo.cntrctNo}'/>"/>
                            <p class="mt10 caption">* 계약번호는 “-(하이픈)”을 제거하고 입력해주세요.</p>
                        </td>
					    </c:if>
					    
					    <!-- 그 이외[CC/KACI/KISA] -->
                        <c:if test="${_goodsMark.MARKCD != '1005'}">
					    <td>

					        <!-- 등록된 인증 마크가 있을 경우 다운로드 링크와 삭제버튼 표기 -->
					        <c:if test="${goodsMarkCnt > 0}">
					        <c:forEach items="${dataVo.markCrtfcFile[ statusSeq.index ]}" var="fileVo" varStatus="status">
						    <div class="mar_b5">
							    <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
							    <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
							    <c:if test="${not status.last}"><br/></c:if>
						    </div>
					        </c:forEach>
					        </c:if>
					        
					        <!-- 등록된 인증 마크가 없을 경우 등록란 표기 -->
					        <c:if test="${goodsMarkCnt == 0}">
					            <span id="markCrtfcFile${statusSeq.index}Div"  style="vertical-align: sub;">
					                <input type="file" name="markCrtfcFile${statusSeq.index}" id="markCrtfcFile${statusSeq.index}" class="markCrtfcFile${statusSeq.index} w_92p" onchange="jsFileChk('markCrtfcFile${statusSeq.index}', 5120, '1', -1, 1);"></input>
					            </span>
					            <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}');"/>
					            <input type="hidden" name="fileDesc" id="markCrtfcFile${statusSeq.index}Desc" value=""></input>
					        </c:if>
					        
					        
					        
					        			        
					    </td>
                        </c:if>
					</tr>
					</c:forEach>
					</table>
				</td>
			</tr>
            <!-- //인증구분 -->

        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr><td colspan="2"><h4>기본정보</h4></td></tr>
            <!-- 제조사 -->
            <tr>
                <th><span class="tx_red_s">*</span>제조사</th>
                <td><input name="goodsMakr" id="goodsMakr" class="w_92p" type="text" value="${dataVo.goodsMakr}"></input></td>
            </tr>
            <!-- //제조사 -->
            
            <!-- 출시일 -->
            <tr>
                <th><span class="tx_red_s">*</span>출시일</th>
                <td><input name="comouDe" id="comouDe" class="w_92p" type="text" value="${dataVo.comouDe}" maxlength="8"></input>
                <br/>(입력예시 : 20140501)
                </td>
            </tr>
            <!-- //출시일 -->
			
			<!-- 무료/체험 구분 -->
            <tr>
                <th><span>무료/체험 구분</span></th>
                <td>
                  <!--   <input id="metaExprnBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2027, '', '');"></input> -->
                    <span id="metaExprnNm">
                        <c:forEach items="${dataVo.goodsMetaExprn}" var="_goodsMetaExprn" varStatus="status">
                            ${_goodsMetaExprn.INDVDLZ_CD_NM}${!status.last?',':''}
                        </c:forEach>
                    </span>
                    
                </td>
            </tr>
            <input name="metaExprns" id="metaExprns" type="hidden" value="<c:forEach items="${dataVo.goodsMetaExprn}" var="_goodsMetaExprn" varStatus="status">${_goodsMetaExprn.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
			<!-- //무료/체험 구분 -->
			
			<!-- 기업구분 -->
			<tr>
				<th><span class="tx_red_s">*</span>기업구분</th>
				<td><label><input type="radio" id="smlpzChk" name="smlpzChk" value="Y"  <c:if test="${dataVo.smlpzChk  == 'Y'}" >checked="checked" </c:if>  /> 중소기업</label>
						<label><input type="radio" id="smlpzChk" name="smlpzChk" value="M"  <c:if test="${dataVo.smlpzChk  == 'M'}" >checked="checked" </c:if> /> 중견기업</label>
						<label><input type="radio" id="smlpzChk" name="smlpzChk" value="B"  <c:if test="${dataVo.smlpzChk  == 'B'}" >checked="checked" </c:if> /> 대기업</label></span></td>
			</tr>
			<!-- //기업구분 -->
						
			<!-- 단가 -->			
			<tr>
			    <th><span class="tx_red_s">*</span>단가(\)</th>
				<td>
				    <input name="goodsPc" id="goodsPc" class="w_92p" type="text" value="${dataVo.goodsPc}" maxlength="50"></input>
		            <br/><span class="caption">* 서비스가격 수준을 효과적으로 알릴 수 있는 기준가격을 입력해 주세요. (예, 10명까지 39,000원/월)</span>
		            <br/><span class="caption">* 자세한 서비스 요금은 가격표 항목에 첨부파일 형식으로 등록할 수 있습니다.</span>
				</td>
			</tr>						
			<!-- //단가 -->	
			
			<!-- 계약단위 -->
            <tr>
                <th><span class="tx_red_s">*</span>계약단위</th>
                <td>
                    <input id="metaCntrctUnitBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2028, '', '');"></input>
                    
                    

                    <span id="metaCntrctUnitNm">
                        <c:forEach items="${dataVo.goodsMetaCntrctUnit}" var="_goodsMetaCntrctUnit" varStatus="status">
                            ${_goodsMetaCntrctUnit.INDVDLZ_CD_NM}${!status.last?',':''}
                        </c:forEach>
                    </span>
                    <input name="metaCntrctUnits" id="metaCntrctUnits" type="hidden" value="<c:forEach items="${dataVo.goodsMetaCntrctUnit}" var="_goodsMetaCntrctUnit" varStatus="status">${_goodsMetaCntrctUnit.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaCntrctUnit.INDVDLZ_CD == 1005}"><c:set var="metaCntrctUnitetc" value="${_goodsMetaCntrctUnit.META_ETC_CN}"/></c:if></c:forEach>"/>
                    <input name="metaCntrctUnitetc" id="metaCntrctUnitetc" type="hidden" value="${metaCntrctUnitetc}"/>
                </td>
            </tr>
			<!-- //계약단위 -->
			
			<!-- 서비스 유형 -->
			<tr>
				<th><span class="tx_red_s">*</span>서비스 유형</th>
				<td>
					<ul>
						<li>
							<op:code id="serviceOfferMethod" grpCd="2034" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="${dataVo.serviceOfferMethod}" type="radio" defaultLabel="구분"  />
						</li>
					</ul>
				</td>
			</tr>
			<!-- //서비스 유형 -->

            <!-- 서비스 관리 -->
            <tr>
                <th><span class="tx_red_s">*</span>서비스 관리</th>
                <td>
                    <input id="metaSvcBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2030, '', '');"></input>
                    <span id="metaSvcNm"><c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status">${_goodsMetaSvc.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaSvcs" id="metaSvcs" type="hidden" value="<c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status">${_goodsMetaSvc.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
                </td>
            </tr>            
            <!-- //서비스 관리 -->

            <!-- 구축방식 -->
            <tr>
                <th><span class="tx_red_s">*</span>구축방식</th>
                <td>
                    <input id="metaCnstcMthdBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2032, '', '');"></input>
					<span id="metaCnstcMthdNm"><c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaCnstcMthds" id="metaCnstcMthds" type="hidden" value="<c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">${_goodsMetaCnstcMthd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
                </td>
            </tr>
            <!-- //구축방식 -->
            
            <!-- 호환성(표준) -->
            <tr>
                <th><span>호환성(표준)</span></th>
                <td>
                    <input id="metaStdBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2031, '', '');"></input>
					<span id="metaStdNm"><c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status">${_goodsMetaStd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaStds" id="metaStds" type="hidden" value="<c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status">${_goodsMetaStd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
                </td>
            </tr>
            <!-- //호환성(표준) -->

			<!-- 지원언어 -->
            <tr>
                <th><span class="tx_red_s">*</span>지원언어</th>
                <td>
                <span class="agree">
					<c:set var="metaLangEtcOpen" value="readOnly" scope="page"/>
					<c:forEach items="${dataVo.goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
                    	<input name="metaLangs" id="metaLangs${_goodsMetaLang.LANGCD}" type="checkbox"  value="${_goodsMetaLang.LANGCD}" <c:if test="${_goodsMetaLang.LANGCD == _goodsMetaLang.METALANGCD}"> checked="checked"</c:if>/>
                    	<span id="metaLangs${_goodsMetaLang.LANGCD}Nm"  class="caption mr10">${_goodsMetaLang.LANGNM}</span>
                    	<c:if test="${_goodsMetaLang.METALANGCD == 1006}">
                        	<c:set var="metaLangEtcOpen" value="" scope="page"/>
                        </c:if>
                        <c:if test="${status.last}">
                        	<input name="metaLangEtc" id="metaLangEtc" type="text" style="width: 250px;"  value="<c:out value='${_goodsMetaLang.METAETCCN}'/>" <c:out value='${metaLangEtcOpen}'/>/>
                        </c:if>
                    </c:forEach>
                    <input name="metaLangsNm" id="metaLangsNm" type="hidden" value=""/>
				</span>
                </td>
            </tr>
            <!-- //지원언어 -->

            <!-- 원산지 -->
			<tr>
			    <th><span class="tx_red_s">*</span>원산지</th>
				<td>
					<input type="text" class="w650" id="orgplce" name="orgplce" style="ime-mode:active" value="${dataVo.orgplce}"/>
				</td>
			</tr>
            <!-- //원산지 -->
            
            <!-- A/S방침 -->
            <tr>
                <th><span class="tx_red_s">*</span>A/S방침</th>
                <td><input id="metaASsBtn" type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1021, '1000', '1999');"></input>
                    <span id="metaASnm" class="mar_l10"><c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaASs" id="metaASs" type="hidden"
                     value="<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS" varStatus="status">${_goodsMetaAS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaAS.INDVDLZ_CD == 1005}"><c:set var="metaASetc" value="${_goodsMetaAS.META_ETC_CN}"/></c:if></c:forEach>"/>
                    <input name="metaASetc" id="metaASetc" type="hidden" value="${metaASetc}"/>
                    <input name="metaASnms" id="metaASnms" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //A/S방침 -->
            
            <!-- 지원OS -->
            <tr>
                <th><span class="tx_red_s">*</span>지원OS</th>
                <td><input id="metaOSsBtn" type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1020, '', '');"></input>
                    <span id="metaOSnm" class="mar_l10"><c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">${_goodsMetaOS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
                    <input name="metaOSs" id="metaOSs" type="hidden"
                     value="<c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">${_goodsMetaOS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaOS.INDVDLZ_CD == 9001}"><c:set var="metaOSetc" value="${_goodsMetaOS.META_ETC_CN}"/></c:if></c:forEach>"/>
                    <input name="metaOSetc" id="metaOSetc" type="hidden" value="${metaOSetc}"/>
                    <input name="metaOSnms" id="metaOSnms" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //지원OS -->
            
            <!-- 아키텍쳐 -->
            <tr>
                <th><span class="tx_red_s">*</span>아키텍쳐</th>
                <td>
                    <c:choose>
                    <c:when test="${dataVo.archtcSe == 1}">
                    <input name="archtcSeArry" id="archtcSeArry1" type="checkbox" value="1" checked="checked"/>32bit&nbsp;
                    <input name="archtcSeArry" id="archtcSeArry2" type="checkbox" value="2"/>64bit
                    </c:when>
                    <c:when test="${dataVo.archtcSe == 2}">
                    <input name="archtcSeArry" id="archtcSeArry1" type="checkbox" value="1"/>32bit&nbsp;
                    <input name="archtcSeArry" id="archtcSeArry2" type="checkbox" value="2" checked="checked"/>64bit
                    </c:when>
                    <c:when test="${dataVo.archtcSe == 3}">
                    <input name="archtcSeArry" id="archtcSeArry1" type="checkbox" value="1" checked="checked"/>32bit&nbsp;
                    <input name="archtcSeArry" id="archtcSeArry2" type="checkbox" value="2" checked="checked"/>64bit
                    </c:when>
                    <c:otherwise>
                    <input name="archtcSeArry" id="archtcSeArry1" type="checkbox" value="1"/>32bit&nbsp;
                    <input name="archtcSeArry" id="archtcSeArry2" type="checkbox" value="2"/>64bit
                    </c:otherwise>
                    </c:choose>
                    <input name="archtcSe" id="archtcSe" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //아키텍쳐 -->

        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="" />
            <col width="150" />
            <col width="100" />
            <col width="150" />
            <col width="100" />
        </colgroup>
        <tbody>
            <tr><td colspan="6"><h4>판매자 정보</h4></td></tr>
            <tr>
                <th><span class="tx_red_s">*</span>회사명</th>
                <td id="sellerInfo1">${dataVo.goodsStore[0].LANGSTORENM}</td>
                <th>판매자 구분</th>
                <td id="sellerInfo2">${dataVo.nationGrp}</td>
                <th>판매자 유형</th>
                <td id="sellerInfo3">${dataVo.userTyGrp}</td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자</th>
                <td colspan="5"><input name="goodsChargerNm" id="goodsChargerNm" class="w_92p" type="text" value="${dataVo.goodsChargerNm}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자 이메일</th>
                <td colspan="5"><input name="goodsChargerEmail" id="goodsChargerEmail" class="w_92p" type="text" value="${dataVo.goodsChargerEmail}"></input></td>
            </tr>
            <tr>
                <th><span class="tx_red_s">*</span>담당자 전화번호</th>
                <td colspan="5"><input name="goodsChargerCttpc" id="goodsChargerCttpc" class="w_92p" type="text" value="${dataVo.goodsChargerCttpc}"></input></td>
            </tr>
            <tr>
                <th>담당자 휴대전화번호</th>
                <td colspan="5"><input name="goodsChargerMbtlnum" id="goodsChargerMbtlnum" class="w_92p" type="text" value="${dataVo.goodsChargerMbtlnum}"></input></td>
            </tr>
<%-- 2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함            
			<tr>
                <th>홈페이지URL</th>
                <td colspan="5"><input name="goodsHmpgUrl" id="goodsHmpgUrl" class="w_92p" type="text" value="${dataVo.goodsHmpgUrl}"></input></td>
            </tr> --%>
        </tbody>
    </table>

    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="200" />
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr><td colspan="4"><h4>상세 정보</h4></td></tr>
            <tr>
                <th><span class="tx_red_s">*</span>서비스개요</th>
                <td colspan="3"><textarea name="goodsSumry" id="goodsSumry" rows="5" class="w_92p" >${dataVo.goodsSumry}</textarea></td>
            </tr>
            <tr>
                <th>태그</th>
                <td colspan="3">
                    <div>(태그선택 또는 직접 입력으로 총 10개의 태그를 입력할 수 있습니다.)</div>
                    <table class="w_100p">
                        <colgroup>
                            <col width="100" />
                            <col width="" />
                        </colgroup>
                    <tbody>
                        <tr>
                            <td>
                                <input id="metaTAGsBtn" type="button" value="태그선택" class="blue w80"  onclick="jsMetaPop(this, 1023, '', '');"></input>
                            </td>
                            <td>
			                    <input name="metaTAGs" id="metaTAGs" type="hidden" value="<c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">${_goodsMetaTAG.INDVDLZ_CD}${!status.last?',':''}</c:forEach>"/>
			                    <ul id="metaTAGhtml">
			                     <c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">
			                     <li><a id="metaTAG${_goodsMetaTAG.INDVDLZ_CD}" onclick="jsMetaTagDelete(this);" href="javascript:;">${_goodsMetaTAG.INDVDLZ_CD_NM} X</a></li>
			                     </c:forEach>
			                    </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>

                            </td>
                            <td>
                                <input type="text" name="goodsTags" id="goodsTags" class="w_92p" value="<c:forEach items="${dataVo.goodsTag}" var="_goodsTag" varStatus="status">${_goodsTag.GOODSTAGNM}${!status.last?', ':''}</c:forEach>" title="태그" />
                                <p class="tx_blue_s">- 쉼표로 구분하여 태그를 입력해 주세요.</p>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                </td>
            </tr>
            
			<!-- 특장점 -->
			<tr>
				<th colspan="4"><span class="tx_red_s">*</span>특장점</th>
			</tr>
			<tr>
				<td colspan="4">
					<div id="contentsErrorDiv1"></div>
                        <textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value="${dataVo.itemSfe}" escapeXml="false"/></textarea>
					    <script type="text/javascript">
					    //<![CDATA[
					        CKEDITOR.replace('itemSfe', {
					            height               : 200,
					            htmlEncodeOutput     : false,
					            enterMode            : "2",
					            skin                 : "moono",
					            toolbar              : [[ 'BulletedList' ]],
					            filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                                on					 : {instanceReady:function(){
                                    var liStr = /<li>(.*?)<(\/?)li>/gi;
                                    if($("#itemSfe").val().trim().match(liStr) == null){
                                    	this.execCommand( 'bulletedlist' ); 
                                    }
                                    $("#goodsNm").focus();
                                }}
					        });
					    //]]>
					    </script>
					<valid:msg name="itemSfe" />
				</td>
			</tr>
			<!-- //특장점 -->

			<!-- 대상고객 -->
			<tr>
				<th colspan="4"><span class="tx_red_s">*</span>대상고객</th>
			</tr>
			<tr>
				<td colspan="4">
					<div id="contentsErrorDiv2"></div>
						<textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value="${dataVo.goodsRefer}" escapeXml="false"/></textarea>
                        <script type="text/javascript">
                        //<![CDATA[
                            CKEDITOR.replace('goodsRefer', {
                                height               : 200,
                                htmlEncodeOutput     : false,
                                enterMode            : "2",
                                skin                 : "moono",
                                toolbar              : [[ 'BulletedList' ]],
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                                on					 : {instanceReady:function(){
                                    var liStr = /<li>(.*?)<(\/?)li>/gi;
                                    if($("#goodsRefer").val().trim().match(liStr) == null){
                                    	this.execCommand( 'bulletedlist' ); 
                                    }
                                    $("#goodsNm").focus();
                                }}
                            });
                        //]]>
                        </script>
					<valid:msg name="goodsRefer" />
				</td>
			</tr>
			<!-- //대상고객 -->
			
			<!-- 주요기능 -->
			<tr>
				<th colspan="4"><span class="tx_red_s">*</span>주요기능</th>
			</tr>
			<tr>
				<td colspan="4">
					<div id="contentsErrorDiv3"></div>
					    <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value="${dataVo.goodsMainFnct}" escapeXml="false"/></textarea>
                        <script type="text/javascript">
                        //<![CDATA[
                            CKEDITOR.replace('goodsMainFnct', {
                                height               : 200,
                                htmlEncodeOutput     : false,
                                enterMode            : "2",
                                skin                 : "moono",
                                toolbar              : [[ 'BulletedList' ]],
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                                on					 : {instanceReady:function(){
                                    var liStr = /<li>(.*?)<(\/?)li>/gi;
                                    if($("#goodsMainFnct").val().trim().match(liStr) == null){
                                    	this.execCommand( 'bulletedlist' ); 
                                    }
                                    $("#goodsNm").focus();
                                }}
                            });
                        //]]>
                        </script>
					<valid:msg name="goodsMainFnct" />
				</td>
			</tr>
			<!-- //주요기능 -->

			<!-- 가격표 -->
			<tr>
				<th colspan="4"><span class="tx_red_s">*</span>가격표</th>
			</tr>
			<tr>
			    <td colspan="2"></td>
					<td>파일 업로드</td>
                <td>
                    <input type="hidden" name="priceDnFileSeq" value="${dataVo.priceDnFileSeq}"/>
                    
                    <c:if test="${empty dataVo.priceFile[0]}">
				        <input type="file" name="priceFile1" id="priceFile1" class="mnlFile w_92p" onchange="jsFileChk('priceFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="priceFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('priceFile1');"/>
                    </c:if>
						
					<c:if test="${not empty dataVo.priceFile[0]}">
					    <c:set var="priceFileVO" value="${dataVo.priceFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <a href="javascript:;" onclick="jsFileDelete(this, ${priceFileVO.fileSeq}, '${priceFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                            <a href="/component/file/ND_fileDownload.do?id=${priceFileVO.fileId }" title="${priceFileVO.localNm}">${priceFileVO.localNm} <span class="tx_gray">(download ${priceFileVO.downCnt}, ${priceFileVO.fileSize}, ${priceFileVO.fileType})</span></a>
                        </div>
                        
                        <input type="hidden" name="priceFile1" id="priceFile1" value="${priceFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="priceFile1Desc" value="${priceFileVO.localNm}"/>
			        </c:if>
				</td>
			</tr>
			<!-- //가격표 -->
			
			<!-- 서비스규격서 -->
			<tr>
				<th colspan="4"><span class="tx_red_s">*</span>서비스규격서</th>
			</tr>
			<tr>
			    <td colspan="2"></td>
				<td>파일 업로드</td>
                <td>
                    <input type="hidden" name="goodsMnlFileSeq" value="${dataVo.goodsMnlFileSeq}"/>
                    
                    <c:if test="${empty dataVo.mnlFile[0]}">
				        <input type="file" name="mnlFile1" id="mnlFile1" class="mnlFile w_92p" onchange="jsFileChk('mnlFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="mnlFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('mnlFile1');"/>
                    </c:if>
						
					<c:if test="${not empty dataVo.mnlFile[0]}">
					    <c:set var="mnlFileVO" value="${dataVo.mnlFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <a href="javascript:;" onclick="jsFileDelete(this, ${mnlFileVO.fileSeq}, '${mnlFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                            <a href="/component/file/ND_fileDownload.do?id=${mnlFileVO.fileId }" title="${mnlFileVO.localNm}">${mnlFileVO.localNm} <span class="tx_gray">(download ${mnlFileVO.downCnt}, ${mnlFileVO.fileSize}, ${mnlFileVO.fileType})</span></a>
                        </div>
                        <input type="hidden" name="mnlFile1" id="mnlFile1" value="${mnlFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="mnlFile1Desc" value="${mnlFileVO.localNm}"/>
			        </c:if>
				</td>
			</tr>
			<!-- //서비스규격서 -->

			<!-- 사용메뉴얼 -->
			<tr>
				<th colspan="4">사용메뉴얼</th>
			</tr>
			<tr>
			    <td colspan="2"></td>
				<td>파일 업로드</td>
                <td>
                    <input type="hidden" name="mnlDnFileSeq" value="${dataVo.mnlDnFileSeq}"/>
                    
                    <c:if test="${empty dataVo.dnlFile[0]}">
				        <input type="file" name="dnlFile1" id="dnlFile1" class="mnlFile w_92p" onchange="jsFileChk('dnlFile1', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="dnlFile1Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('dnlFile1');"/>
                    </c:if>
						
					<c:if test="${not empty dataVo.dnlFile[0]}">
					    <c:set var="dnlFileVO" value="${dataVo.dnlFile[0]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <a href="javascript:;" onclick="jsFileDelete(this, ${dnlFileVO.fileSeq}, '${dnlFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                            <a href="/component/file/ND_fileDownload.do?id=${dnlFileVO.fileId }" title="${dnlFileVO.localNm}">${dnlFileVO.localNm} <span class="tx_gray">(download ${dnlFileVO.downCnt}, ${dnlFileVO.fileSize}, ${dnlFileVO.fileType})</span></a>
                        </div>
                        <input type="hidden" name="dnlFile1" id="dnlFile1" value="${dnlFileVO.fileUrl}"/>
                        <input type="hidden" name="fileDesc" id="dnlFile1Desc" value="${dnlFileVO.localNm}"/>
			        </c:if>
				</td>
			</tr>
			<!-- //사용메뉴얼 -->

			<!-- 기타첨부파일 -->
			<tr>
				<th colspan="4">기타첨부파일</th>
			</tr>
			<!-- 기타 첨부파일은 5개 까지 -->
			<c:forEach var="i" begin="1" end="5" step="1" varStatus="rtstatus">
                
                <input type="hidden" name="etcFileSeq" value="${dataVo.etcFileSeq}"/>
			    <!-- 기타 첨부파일이 없을 경우 등록용 필드 노출 -->
			    <c:if test="${empty dataVo.etcFile[i-1]}">
			    <tr>
			        <td colspan="2"></td>
				    <td>파일 업로드</td>
                    <td>
                        <input type="file" name="etcFile${i}" id="etcFile${i}" class="mnlFile w_92p" onchange="jsFileChk('etcFile${i}', 'etcfileInput${i}', 10240, '1', -1, 5);"></input>
				        <input type="hidden" name="fileDesc" id="etcFile${i}Desc" value=""/>
				        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('etcFile${i}');"/>
				    </td>
			    </tr>
			    </c:if>
			    
			    <!-- 기타 첨부파일이 있을 경우 다운로드/삭제 링크 노출 -->
			    <c:if test="${not empty dataVo.etcFile[i-1]}">
			    <tr>
			        <td colspan="2"></td>
				    <td>파일 업로드</td>
                    <td>
					    <c:set var="etcFileVO" value="${dataVo.etcFile[i-1]}" />
					    <c:set var="image" value="" />
                        <div class="mar_b5">
                            <a href="javascript:;" onclick="jsFileDelete(this, ${etcFileVO.fileSeq}, '${etcFileVO.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
                            <a href="/component/file/ND_fileDownload.do?id=${etcFileVO.fileId }" title="${etcFileVO.localNm}">${etcFileVO.localNm} <span class="tx_gray">(download ${etcFileVO.downCnt}, ${etcFileVO.fileSize}, ${etcFileVO.fileType})</span></a>
                        </div>
                        <input type="hidden" name="etcFile${i}" id="etcFile${i}" value="${etcFileVO.fileUrl}" />
                        <input type="hidden" name="fileDesc" id="etcFile${i}Desc" value="${etcFileVO.localNm}"/>
				    </td>
			    </tr>
			    </c:if>
			</c:forEach>
			<!-- //기타첨부파일 -->

			<tr>
				<td colspan="4">
					<input type="hidden" id="mnlFilesFileDesc" name="mnlFilesFileDesc" value="" />
				</td>
			</tr>
        </tbody>
    </table>
    
    
    
    
    <table class="boardWrite mar_t20">
        <colgroup>
            <col width="150" />
            <col width="" />
            <col width="150" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
           <%--  <th>서비스검토관리자</th>
            <td><c:if test="${not empty dataVo.exmntMgr.MNGR_ID}">${dataVo.exmntMgr.MNGR_NM}(${dataVo.exmntMgr.MNGR_ID})</c:if></td> --%>
            <th>서비스승인관리자</th>
            <td><c:if test="${not empty dataVo.confmMgr.MNGR_ID}">${dataVo.confmMgr.MNGR_NM}(${dataVo.confmMgr.MNGR_ID})</c:if></td>
            </tr>
        </tbody>
    </table>

    <!-- 버튼 -->
   
    <div class="mar_t20 mar_b50">
        <div class="float_l">
            <input type="button" value="목록" class="blue" onclick="jsList('BD_index.do');" />
            <input type="button" value="삭제" class="blue" onclick='jsDeleteConfirm(this);' />
        </div>
        <c:if test="${dataVo.goodsRegistSttus < 1008}">
        <div class="float_r">
           <!-- <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_goodsPreview.do');" /> -->
           <!-- <input type="button" value="검토반려" class="blue" onclick="jsRegistBack(this, 1003);" /> -->
            <input type="button" value="수정완료" class="blue" onclick="jsGoodsUpdateAction('','ND_goodsIndexUpdate.do');" />
        </div>
        </c:if>
    </div>
    <!-- //버튼 -->
    <c:if test="${not empty specVo}" >
    <table class="boardWrite">
        <colgroup>
            <col width="50" />
            <col width="250" />
            <col width="250" />
            <col width="*" />
        </colgroup>
        <tbody>
        <tr><td colspan="4"><h4>서비스규격서정보</h4></td></tr>   	 	
		<tr>
				<td>1</td>
				<th><span class="tx_red_s">*</span>서비스개요</th>
				<th></th>
				<td>${specVo.goodsSpec1}</td>
			</tr>
			<tr>
				<td>2</td>
				<td>가격</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>2.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>VAT 포함여부</th>
				<td>${specVo.goodsSpec2} </td>
			</tr>
			<tr>
				<td>2.2</td>
				<th class="requ">최소계약기간</th>
				<td>${specVo.goodsSpec3} </td>
			</tr>
			<tr>
				<td>2.3</td>
				<th><span class="tx_red_s">*</span>평가판 사용여부</th>
				<td>${specVo.goodsSpec4} </td>
			</tr>
			<tr>
				<td>3</td>
				<td>첨부문서</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>3.1</td>
				<td rowspan="4"></dh>
				<th><span class="tx_red_s">*</span>가격 테이블</th>
				<td>${specVo.goodsSpec5} </td>
			</tr>
			<tr>
				<td>3.2</td>
				<th><span class="tx_red_s">*</span>기술평가표</th>
				<td>${specVo.goodsSpec6} </td>
			</tr>
			<tr>
				<td>3.3</td>
				<th><span class="tx_red_s">*</span>서비스 항목 정의</th>
				<td>${specVo.goodsSpec7} </td>
			</tr>
			<tr>
				<td>3.4</td>
				<th><span class="tx_red_s">*</span>기간 및 조건</th>
				<td>${specVo.goodsSpec8} </td>
			</tr>
			<tr>
				<td>4</td>
				<td>연락처</td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>4.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>담당자</th>
				<td>${specVo.goodsSpec9}</td>
			</tr>
			<tr>
				<td>4.2</td>
				<th><span class="tx_red_s">*</span>전화번호</th>
				<td>${specVo.goodsSpec10}</td>
			</tr>
			<tr>
				<td>4.3</td>
				<th><span class="tx_red_s">*</span>e-mail</th>
				<td>${specVo.goodsSpec11}</td>
			</tr>
			<tr>
				<td>5</td>
				<th><span class="tx_red_s">*</span>서비스 특징</th>
				<th></th>
				<td>${specVo.goodsSpec12} </td>
			</tr>
			<tr>
				<td>6</td>
				<th><span class="tx_red_s">*</span>도입 기대효과</th>
				<th></th>
				<td>${specVo.goodsSpec13} </td>
			</tr>					
			<tr>
				<td>7</td>
				<td>기술지원</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>7.1</td>
				<td rowspan="5"></td>
				<th><span class="tx_red_s">*</span>지원 서비스 종류</th>
				<td>${specVo.goodsSpec14} </td>
			</tr>					
			<tr>
				<td>7.2</td>
				<th><span class="tx_red_s">*</span>제3의 제공자에 접근 지원</th>
				<td>${specVo.goodsSpec15} </td>
			</tr>					
			<tr>
				<td>7.3</td>
				<th><span class="tx_red_s">*</span>기술지원 시간(시간/주간/옵션)</th>
				<td>${specVo.goodsSpec16} </td>
			</tr>					
			<tr>
				<td>7.4</td>
				<th><span class="tx_red_s">*</span>지원대기 시간</th>
				<td>${specVo.goodsSpec17} </td>
			</tr>					
			<tr>
				<td>7.5</td>
				<th><span class="tx_red_s">*</span>서비스의 단계적 확장</th>
				<td>${specVo.goodsSpec18} </td>
			</tr>					
			<tr>
				<td>8</td>
				<th><span class="tx_red_s">*</span>공개표준지원</th>
				<th><span class="tx_red_s">*</span>공개표준 지원 및 문서</th>
				<td>${specVo.goodsSpec19} </td>
			</tr>					
			<tr>
				<td>9</td>
				<td>서비스 개시/종료절차</td>
				<td></td>
				<td> </td>
			</tr>					
			<tr>
				<td>9.1</td>
				<th><span class="tx_red_s">*</span>서비스 개시 </th>
				<th><span class="tx_red_s">*</span>절차 포함</th>
				<td>${specVo.goodsSpec20}</td>
			</tr>					
			<tr>
				<td>9.2</td>
				<th><span class="tx_red_s">*</span>서비스 종료</th>
				<th><span class="tx_red_s">*</span>절차 포함</th>
				<td>${specVo.goodsSpec21}</td>
			</tr>					
			<tr>
				<td>10</td>
				<th>분석</th>
				<th><span class="tx_red_s">*</span>실시간 관리 정보 제공 </th>
				<td>${specVo.goodsSpec22}</td>
			</tr>					
			<tr>
				<td>11</td>
				<td>클라우드 특성</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>11.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>탄력적 클라우드 지원</th>
				<td>${specVo.goodsSpec23}</td>
			</tr>					
			<tr>
				<td>11.2</td>
				<th><span class="tx_red_s">*</span>정의된 자원 보장</th>
				<td>${specVo.goodsSpec24}</td>
			</tr>					
			<tr>
				<td>11.3</td>
				<th><span class="tx_red_s">*</span>영구 저장소 지원</th>
				<td>${specVo.goodsSpec25}</td>
			</tr>					
			<tr>
				<td>12</td>
				<td>프로비저닝</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>12.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>셀프서비스 프로비저닝 지원</th>
				<td>${specVo.goodsSpec26}</td>
			</tr>					
			<tr>
				<td>12.2</td>
				<th><span class="tx_red_s">*</span>서비스 프로비저닝 시간</th>
				<td>${specVo.goodsSpec27}</td>
			</tr>					
			<tr>
				<td>12.3</td>
				<th><span class="tx_red_s">*</span>서비스 프로비저닝 해제 시간</th>
				<td>${specVo.goodsSpec28}</td>
			</tr>					
			<tr>
				<td>13</td>
				<th>오픈소스</th>
				<th><span class="tx_red_s">*</span>오픈소스 S/W 사용 및 지원</th>
				<td>${specVo.goodsSpec29}</td>
			</tr>					
			<tr>
				<td>14</td>
				<th>Code libraries</th>
				<th><span class="tx_red_s">*</span>Code libraries 작성 언어</th>
				<td>${specVo.goodsSpec30}</td>
			</tr>					
			<tr>
				<td>15</td>
				<td>API access</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>15.1</td>
				<td rowspan="2"></td>
				<th>API 접근가능 여부 및 지원</th>
				<td>${specVo.goodsSpec31}</td>
			</tr>					
			<tr>
				<td>15.2</td>
				<th><span class="tx_red_s">*</span>API type</th>					
				<td>${specVo.goodsSpec32}</td>
			</tr>					
			<tr>
				<td>16</td>
				<th>네트워크와 연결</th>
				<th><span class="tx_red_s">*</span>서비스에 직접 연결하는 네트워크</th>
				<td>${specVo.goodsSpec33}</td>
			</tr>					
			<tr>
				<td>17</td>
				<td>접근지원</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>17.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>지원 웹브라우저 목록</th>
				<td>${specVo.goodsSpec34}</td>
			</tr>					
			<tr>
				<td>17.2</td>
				<th><span class="tx_red_s">*</span>오프라인작업및동기화지원여부</th>
				<td>${specVo.goodsSpec35}</td>
			</tr>					
			<tr>
				<td>17.3</td>
				<th><span class="tx_red_s">*</span>지원 장비 목록</th>
				<td>${specVo.goodsSpec36}</td>
			</tr>					
			<tr>
				<td>18</td>
				<td>데이터 저장소</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>18.1</td>
				<td rowspan="4"></td>
				<th><span class="tx_red_s">*</span>데이터 저장소 정보 및 인증정보</th>
				<td>${specVo.goodsSpec37}</td>
			</tr>					
			<tr>
				<td>18.2</td>
				<th><span class="tx_red_s">*</span>사용자가 저장소 위치 지정 가능여부</th>
				<td>${specVo.goodsSpec38}</td>
			</tr>					
			<tr>
				<td>18.3</td>
				<th><span class="tx_red_s">*</span>백업, 재해복구, 복구계획</th>
				<td>${specVo.goodsSpec39}</td>
			</tr>					
			<tr>
				<td>18.4</td>
				<th><span class="tx_red_s">*</span>데이터추출 및 삭제계획</th>
				<td>${specVo.goodsSpec40}</td>
			</tr>					
			<tr>
				<td>19</td>
				<td>데이터 전송 보호</td>
				<th><span class="tx_red_s">*</span>사용자 장비와 서비스간 데이터 보호 방식</th>
				<td>${specVo.goodsSpec41}</td>
			</tr>					
			<tr>
				<td>20</td>
				<td>자산보호 및 복구</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>20.1</td>
				<td rowspan="6"></td>
				<th><span class="tx_red_s">*</span>데이터센터 위치</th>
				<td>${specVo.goodsSpec42}</td>
			</tr>					
			<tr>
				<td>20.2</td>
				<th><span class="tx_red_s">*</span>데이터 관리 위치</th>
				<td>${specVo.goodsSpec43}</td>
			</tr>					
			<tr>
				<td>20.3</td>
				<th><span class="tx_red_s">*</span>데이터센터 보호</th>
				<td>${specVo.goodsSpec44}</td>
			</tr>					
			<tr>
				<td>20.4</td>
				<th><span class="tx_red_s">*</span>미사용 데이터 보호</th>
				<td>${specVo.goodsSpec45}</td>
			</tr>					
			<tr>
				<td>20.5</td>
				<th><span class="tx_red_s">*</span>안전한 데이터 삭제</th>
				<td>${specVo.goodsSpec46}</td>
			</tr>					
			<tr>
				<td>20.6</td>
				<th><span class="tx_red_s">*</span>서비스 가용성</th>
				<td>${specVo.goodsSpec47}</td>
			</tr>					
			<tr>
				<td>21</td>
				<td>분리정책</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>21.1</td>
				<td rowspan="4"></td>
				<th><span class="tx_red_s">*</span>클라우드 배포 모델</th>
				<td>${specVo.goodsSpec48}</td>
			</tr>					
			<tr>
				<td>21.2</td>
				<th><span class="tx_red_s">*</span>소비자 유형</th>
				<td>${specVo.goodsSpec49}</td>
			</tr>					
			<tr>
				<td>21.3</td>
				<th><span class="tx_red_s">*</span>서비스 분리</th>
				<td>${specVo.goodsSpec50}</td>
			</tr>					
			<tr>
				<td>21.4</td>
				<th><span class="tx_red_s">*</span>서비스 관리 분리</th>
				<td>${specVo.goodsSpec51}</td>
			</tr>					
			<tr>
				<td>22</td>
				<th>구성 및 변경관리</th>
				<th><span class="tx_red_s">*</span>변경영향 평가</th>
				<td>${specVo.goodsSpec52}</td>
			</tr>					
			<tr>
				<td>23</td>
				<td>사건 관리</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>23.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>사건 관리 절차</th>
				<td>${specVo.goodsSpec53}</td>
			</tr>					
			<tr>
				<td>23.2</td>
				<th><span class="tx_red_s">*</span>보안사건 고객 보고</th>
				<td>${specVo.goodsSpec54}</td>
			</tr>					
			<tr>
				<td>23.3</td>
				<th><span class="tx_red_s">*</span>보안사건 정의 공표</th>
				<td>${specVo.goodsSpec55}</td>
			</tr>					
			<tr>
				<td>24</td>
				<td>취약점 관리</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>24.1</td>
				<td rowspan="5"></td>
				<th><span class="tx_red_s">*</span>취약점 평가</th>
				<td>${specVo.goodsSpec56}</td>
			</tr>					
			<tr>
				<td>24.2</td>
				<th><span class="tx_red_s">*</span>취약점 모니터링</th>
				<td>${specVo.goodsSpec57}</td>
			</tr>					
			<tr>
				<td>24.3</td>
				<th><span class="tx_red_s">*</span>취약점 완화 우선순위</th>
				<td>${specVo.goodsSpec58}</td>
			</tr>					
			<tr>
				<td>24.4</td>
				<th><span class="tx_red_s">*</span>취약점 추적</th>
				<td>${specVo.goodsSpec59}</td>
			</tr>
			<tr>
				<td>24.5</td>
				<th><span class="tx_red_s">*</span>취약점 완화 시간척도</th>
				<td>${specVo.goodsSpec60}</td>
			</tr>							
			<tr>
				<td>25</td>
				<th>이벤트 모니터링</th>
				<th><span class="tx_red_s">*</span>이벤트 모니터링</th>
				<td>${specVo.goodsSpec61}</td>
			</tr>					
			<tr>
				<td>26</td>
				<td>Secure 개발</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>26.1</td>
				<td rowspan="3"></td>
				<th><span class="tx_red_s">*</span>Secure 개발</th>
				<td>${specVo.goodsSpec62}</td>
			</tr>					
			<tr>
				<td>26.2</td>
				<th>Secure design, coding, testing 및 배포</th>
				<td>${specVo.goodsSpec63}</td>
			</tr>					
			<tr>
				<td>26.3</td>
				<th><span class="tx_red_s">*</span>소프트웨어 구성 관리</th>
				<td>${specVo.goodsSpec64}</td>
			</tr>					
			<tr>
				<td>27</td>
				<td>공급망 보안</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>27.1</td>
				<td rowspan="4"></td>
				<th><span class="tx_red_s">*</span>타 공급업체와의 데이터 공유</th>
				<td>${specVo.goodsSpec65}</td>
			</tr>					
			<tr>
				<td>27.2</td>
				<th><span class="tx_red_s">*</span>타 공급업체 보안 요구사항</th>
				<td>${specVo.goodsSpec66}</td>
			</tr>					
			<tr>
				<td>27.3</td>
				<th><span class="tx_red_s">*</span>타 공급업체의 위험 평가</th>
				<td>${specVo.goodsSpec67}</td>
			</tr>					
			<tr>
				<td>27.4</td>
				<th><span class="tx_red_s">*</span>타 공급업체 이행여부 모니터링</th>
				<td>${specVo.goodsSpec68}</td>
			</tr>					
			<tr>
				<td>28</td>
				<td>고객 인증</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>28.1</td>
				<td rowspan="2"></td>
				<th><span class="tx_red_s">*</span>사용자 인증 및 엑세스 관리</th>
				<td>${specVo.goodsSpec69}</td>
			</tr>					
			<tr>
				<td>28.2</td>
				<th>지원 채널을 통한 사용자 접근 관리</th>
				<td>${specVo.goodsSpec70}</td>
			</tr>					
			<tr>
				<td>29</td>
				<td>관리 인터페이스 분리 및 접근 제어</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>29.1</td>
				<td rowspan="2"></td>
				<th><span class="tx_red_s">*</span>관리 인터페이스 사용자 접근 제어</th>
				<td>${specVo.goodsSpec71}</td>
			</tr>					
			<tr>
				<td>29.2</td>
				<th><span class="tx_red_s">*</span>관리자 권한</th>
				<td>${specVo.goodsSpec72}</td>
			</tr>					
			<tr>
				<td>30</td>
				<th>ID 및 인증</th>
				<th><span class="tx_red_s">*</span>ID 및 인증제어</th>
				<td>${specVo.goodsSpec73}</td>
			</tr>					
			<tr>
				<td>31</td>
				<th>보안서비스 관리</th>
				<th><span class="tx_red_s">*</span>서비스 관리 모델</th>
				<td>${specVo.goodsSpec74}</td>
			</tr>					
			<tr>
				<td>32</td>
				<th>사용자에게 감사정보 제공</th>
				<th>감사정보 제공</th>
				<td>${specVo.goodsSpec75}</td>
			</tr>					
			<tr>
				<td>33</td>
				<td>사용자의 이용 안정성</td>
				<td></td>
				<td></td>
			</tr>					
			<tr>
				<td>33.1</td>
				<td rowspan="2"></td>
				<th><span class="tx_red_s">*</span>디바이스 접근 방법</th>
				<td>${specVo.goodsSpec76}</td>
			</tr>					
			<tr>
				<td>33.2</td>
				<th><span class="tx_red_s">*</span>사용자 교육</th>
				<td>${specVo.goodsSpec77}</td>
			</tr>		
   		</tbody>
   	</table>
   	</c:if>
    </form>
</body>
</html>