<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>서비스 등록 대행</title>
	<op:jsTag type="openworks" items="form, validate, ckeditor" />
	<op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" />
	<script type="text/javascript" src="<c:url value="/resources/intra/store/goods.js" />"></script>

	<script type="text/javascript">
	    $("#exttbl").hide();
	    
        // 서비스구분선택 변경시
 	    var strCtgryCurrentVal = "1002";
        var jsCtgryList = function(vl){
 	        var ctgrysVal = $("#setCtgryCodes").val();
 	        
    	    if(ctgrysVal.trim() != "") {
	    	    if(confirm("서비스구분 변경 시 연결된 카테고리가 초기화됩니다.\n변경하시겠습니까?")){
	    	        strCtgryCurrentVal = vl;
	    	        $("#setCtgryCodes").val('');
	    	        $('table#goodsCtgry').html('');
	    	    }else{
	    	        $('input:radio[name="goodsKndCd"]:input[value='+strCtgryCurrentVal+']').attr("checked", true);
	    	    }
    	    } else {
    	        strCtgryCurrentVal = vl;
    	    }
        };
    
        // 카테고리 선택
        var jsCtgrySelPop = function(el){
            if ($("#userId").val() == "") {
                alert("판매자를 먼저 선택해 주십시오.");
                return false;
            }

            var goodsTyCd = $(':radio[name="goodsKndCd"]:checked').val().substring(2);

            $(el).colorbox({
                title        : "서비스 카테고리선택",
                href         : "/korean/pt/sale/goods/PD_categoryPop.do?PID=ST" + goodsTyCd,
                width        : "650",
                height       : "750",
                overlayClose : false,
                escKey       : true,
                iframe       : true
            });
        };
	</script>
</head>
<body>

	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">

	<!-- 페이징 관련 파라미터 생성. rowPerPage 설정 시 목록표시 갯수 선택 생성됨-->
	<op:pagerParam view="view" />

	<input type="hidden" name="goodsCode" id="goodsCode" value="" />
	<input type="hidden" name="langNm" 	  id="langNm" 	 value="${param.langNm}" />
	<input type="hidden" name="langCode"  id="langCode"  value="<c:if test="${param.langCode eq null}">00</c:if><c:if test="${param.langCode ne null}">${param.langCode}</c:if>" />
	<table class="boardWrite">
		<colgroup>
			<col width="150" />
			<col width="" />
		</colgroup>
		<tbody>
		    <!-- 판매자선택 -->
			<tr>
				<th><span class="tx_red_s">*</span>판매자 선택</th>
				<td >선택한 판매자 계정 : <input type="text" name="userId" id="userId" value="${param.userId}" readonly="readonly"></input> <input type="button" id="userIdBtn" value="판매자 선택" onclick="jsSellerList(this);"></input>
				</td>
			</tr>
			<!-- //판매자선택 -->
			
			<!-- 서비스언어 -->
			<%-- 
			<tr>
				<th><span class="tx_red_s">*</span>서비스 언어</th>
				<td>${param.langNm}
				<input name="langNm" id="langNm" type="hidden" value="${param.langNm}"/>
				<input name="langCode" id="langCode" type="hidden"  value="${param.langCode}" />
				</td>
			</tr>
			 --%>
			<!-- //서비스언어 -->
			
			<!-- 전시여부 -->
			<tr>
				<th><span class="tx_red_s">*</span>전시여부</th>
				<td>
				<op:code id="goodsRegistSttus" grpCd="1008" ctgCd="DSPYN" type="radio" defaultValues="${empty dataVo.goodsRegistSttus ? '1006' : dataVo.goodsRegistSttus}"/>
				</td>
			</tr>
			<!-- //전시여부 -->
			
			<!-- 서비스구분선택 [2015.01.18 추가] -->
			<tr>
			    <th><span class="tx_red_s">*</span>서비스구분선택</th>  
                <td>
			        <op:code id="goodsKndCd" grpCd="1005" ctgCd="GDCTCD" defaultValues="${empty dataVo.goodsKndCd ? '1002' : dataVo.goodsKndCd}" type="radio" onclick="jsCtgryList(this.value)" />
			        <input type="hidden" id="" name="" value=""/>			
			    </td>			
			</tr>
			<!-- //서비스구분선택 [2015.01.18 추가] -->					
			
			<!-- 서비스명 -->
			<tr>
				<th><span class="tx_red_s">*</span>서비스명</th>
				<td><input name="goodsNm" id="goodsNm" class="w_92p" type="text" value="" style="ime-mode:active"></input></td>
			</tr>
            <!-- 서비스명 -->

			<!-- 카테고리 -->
			<tr>
				<th><span class="tx_red_s">*</span>카테고리</th>
				<td>
				    <div>
					   <input type="button" id="ctgryBtn" value="카테고리 선택" class="blue" onclick="jsCtgrySelPop(this);" />
					   <input type="hidden" id="setCtgryCodes"></input>
					</div>
					<table id="ctgryTitle">
					    <tr>
					        <td colspan="3">
					            <div class="mar_t10 tx_b" id="test">연결된 카테고리</div>
					        </td>
					    </tr>
					</table>
					<table id="goodsCtgry">
					</table>
				</td>
			</tr>
			<!-- //카테고리 -->
			
			<!-- 대표 이미지 등록 -->
			<tr>
				<th><span class="tx_red_s">*</span>대표 이미지 등록<br/>사이즈 (300X250)</th>
				<td>
					<table>
					    <tr>
					        <td>
						        <span id="imageFile1Div" style="vertical-align: sub;">
						            <input type="file" name="imageFile1" id="imageFile1" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile1', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',1,'Img', -1, 5);"/>
						        </span>
						        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile1');"/>
						        <input type="hidden" name="fileDesc" id="imageFile1Desc" value=""></input>
					        </td>
					    </tr>
					</table>
				</td>
			</tr>
			<!-- //대표 이미지 등록 -->


			<!-- 사용자화면 이미지 -->
			<tr>
				<th>사용자화면 이미지 등록<br/>사이즈 (800X500)</th>
				<td>
					<table>
					    <tr>
					        <td><c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
						        <span id="imageFile${i}Div" style="vertical-align: sub;">
						            <input type="file" name="imageFile${i}" id="imageFile${i}" class="w470 mar_b5 imageFile" accept=".jpg,.jpeg,.gif,.png|images/*" onchange="jsPreview('imageFile${i}', 0, 0, 400, 300, 10240, 'jpg,jpeg,gif,png',${i},'Img', -1, 5);"/>
						        </span>
						        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('imageFile${i}');"/>
						        <input type="hidden" name="fileDesc" id="imageFile${i}Desc" value=""></input>
						        <c:if test="${not status.last}"><br/></c:if>
					            </c:forEach>
					        </td>
					        <td>
						        <c:forEach items="${dataVo.imageFile}" var="fileVo" varStatus="status">
						        <div class="mar_b5">
							        <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
							        <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
							        <c:if test="${not status.last}"><br/></c:if>
						        </div>
						        <input type="hidden" name="image" value="${fileVo.fileUrl}" />
						        </c:forEach>
					        </td>
					    </tr>
					</table>
				</td>
			</tr>
			<!-- //사용자화면 이미지 -->
			
			<!-- 체험판 -->
			<tr>
				<th>체험판</th>
				<td>
				    <div class="fr">
					    <p class="caption">※ 이용자가 다운로드 받는 서비스일 경우 다운로드 받을 수 있는 URL 주소를 입력해주세요.</p>
					    <input type="text" name="itemVodUrl" id="itemVodUrl" value="<c:out value='${dataVo.itemVodUrl}'/>" class="w_92p"/>
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
			<!-- 2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함 -->
			<!-- 소개영상 -->
			<!-- 
			<tr>
			    <th>소개영상</th>
				<td>
					<div class="fr ml20">
						<p class="caption">※ 유투브에 등록된 동영상만 지원 가능합니다.</p>
						<strong><span>https://www.youtube.com/embed/</span></strong>
						<input name="demoExprnUrl" id="demoExprnUrl" type="text" value="<c:out value='${dataVo.demoExprnUrl}'/>" style="width:330px" />
					</div>
				</td>
			</tr>
			 -->
			<!-- //소개영상 -->
			
			<!-- 소개영상 -->
			<tr>
			    <th>모니터링 URL</th>
				<td>
					<div class="fr ml20">
						<p class="caption">※ 모니터링URL  서비스 상태를  확인할 수 있는 모니터링 URL을 입력해주세요.</p>
						<input name="goodsMonitorUrl" id="goodsMonitorUrl" type="text" value="" class="w_92p"  />
					</div>
				</td>
			</tr>

			<!-- //소개영상 -->
			
			<!-- 인증구분 -->
			<tr>
				<th>인증구분</th>
				<td>
					<table style="width:100%">
					<c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
					<tr>
					    <td width="200px">
					        <input type="hidden" name="markCds" value="${_goodsMark.MARKCD}"></input>
					        <input type="checkbox" name="goodsMarkCds" value="${_goodsMark.MARKCD}" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>${_goodsMark.MARKNM}
					    </td>
                        <c:if test="${_goodsMark.MARKCD == '1005'}">
                        <td>
                        <input type="text" id="cntrctNo" name="cntrctNo" style="width:630px" value="<c:out value='${dataVo.cntrctNo}'/>"/>
                        <p class="mt10 caption">* 계약번호는 “-(하이픈)”을 제거하고 입력해주세요.</p>
                        </td>
                        </c:if>
                        <c:if test="${_goodsMark.MARKCD != '1005'}">
					    <td>
					        <span id="markCrtfcFile${statusSeq.index}Div"  style="vertical-align: sub;">
					            <input type="file" name="markCrtfcFile${statusSeq.index}" id="markCrtfcFile${statusSeq.index}" class="markCrtfcFile${statusSeq.index} w_92p" onchange="jsFileChk('markCrtfcFile${statusSeq.index}', 5120, '1', -1, 1);"></input>
					        </span>
					        <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('markCrtfcFile${statusSeq.index}');"/>
					        <input type="hidden" name="fileDesc" id="markCrtfcFile${statusSeq.index}Desc" value=""></input>
					    </td>
                        </c:if>

					    <td width="200px">
					        <c:forEach items="${dataVo.markCrtfcFile[ statusSeq.index ]}" var="fileVo" varStatus="status">
						    <div class="mar_b5">
							    <a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
							    <a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
							    <c:if test="${not status.last}"><br/></c:if>
						    </div>
					        </c:forEach>
					        <input type="hidden" name="crtfcSeFileSeqs" value="${_goodsMark.CRTFCSEFILESEQ}" />
					    </td>
					</tr>

					</c:forEach>
					</table>
				</td>
			</tr>
            <!-- //인증구분 -->

<!-- 
			<tr>
				<th>파일</th>
				<td>
					<table class="w_100p">
					<tr><td><op:code id="sleMthdCd" grpCd="1007" type="radio" defaultValues="${empty dataVo.sleMthdCd ? '1002' : dataVo.sleMthdCd}"/>
					</td>
					<td>다운로드URL <input type="text" name="goodsDwldUrl" id="goodsDwldUrl" class="w_92p" value="${dataVo.goodsDwldUrl}"></input></td>
					</tr>
					<tr>
					<td>
					<span id="goodsFileDiv"  style="vertical-align: sub;">
					<input type="file" name="goodsFile" id="goodsFile" class="mar_t10 mar_b10 goodsFil w_92p" onchange="jsFileChk('goodsFile', 0, '1', -1, 1);"></input>
					</span>
					<input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('goodsFile');"/>
					<input type="hidden" name="fileDesc" id="goodsFileDesc" value=""></input>
					</td>
					<td>
					<c:forEach items="${dataVo.goodsFile}" var="fileVo" varStatus="status">
						<div class="mar_b5">
							<a href="javascript:;" onclick="jsFileDelete(this, ${fileVo.fileSeq}, '${fileVo.fileId}');"><img src="<c:url value='/resources/openworks/theme/default/images/icon/icon_cancel_red.png' />" class="vm"></img></a>
							<a href="/component/file/ND_fileDownload.do?id=${fileVo.fileId }" title="${fileVo.localNm}">${fileVo.localNm} <span class="tx_gray">(download ${fileVo.downCnt}, ${fileVo.fileSize}, ${fileVo.fileType})</span></a>
							<c:if test="${not status.last}"><br/></c:if>
						</div>
					</c:forEach>
					</td>
					</tr>
					</table>
				</td>
			</tr>

			<tr>
				<th>소개영상</th>
				<td><input name="demoExprnUrl" id="demoExprnUrl" class="w_92p" type="text" value=""></input></td>
			</tr>
-->
		</tbody>
	</table>








	<table class="boardWrite mar_t20">
		<colgroup>
			<col width="150" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr><td colspan="2"><h4>기본정보</h4></td></tr>
<!-- 2015.01.18 수정 [클라우드 서비스 종류로 변경]
			<tr>
				<th><span class="tx_red_s">*</span>서비스종류</th>
				<td><op:code id="goodsKndCd" grpCd="1024" type="radio" defaultValues="1001"/></td>
			</tr>
-->
			<!-- 제조사 -->
			<tr>
				<th><span class="tx_red_s">*</span>제조사</th>
				<td><input name="goodsMakr" id="goodsMakr" class="w_92p" type="text" value=""></input></td>
			</tr>
			<!-- //제조사 -->
			
			<!-- 출시일 -->
			<tr>
				<th><span class="tx_red_s">*</span>출시일</th>
				<td><input name="comouDe" id="comouDe" class="w_92p" type="text" value="" maxlength="8"></input>
				<br/>(입력예시 : 20140501)
				</td>
			</tr>
			<!-- //출시일 -->
			
			<!-- 무료/체험 구분 -->
            <tr>
                <th><span>무료/체험 구분</span></th>
                <td>
                    <input id="metaExprnBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2027, '', '');"></input>
                    <span id="metaExprnNm"></span>
                    <input name="metaExprns" id="metaExprns" type="hidden" value=""/>
                </td>
            </tr>
			<!-- //무료/체험 구분 -->
			
			<!-- 기업구분 -->
			<tr>
				<th><span>기업구분</span></th>
				<td><span class="agree"><input type="checkbox" id="smlpzChk" name="smlpzChk" value="Y"  /><label>중소기업</label></span></td>
			</tr>
			<!-- //기업구분 -->
						
			<!-- 단가 -->			
			<tr>
			    <th><span class="tx_red_s">*</span>단가(\)</th>
				<td>
				    <input name="goodsPc" id="goodsPc" class="w_92p" type="text" value="" maxlength="50"></input>
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
                    <span id="metaCntrctUnitNm"></span>
                    <input name="metaCntrctUnits" id="metaCntrctUnits" type="hidden" value=""/>
                    <input name="metaCntrctUnitetc" id="metaCntrctUnitetc" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //계약단위 -->
            
            <!-- 서비스 유형 -->
			<tr>
				<th><span class="tx_red_s">*</span>서비스 유형</th>
				<td>
					<ul>
						<li>
							<op:code id="serviceOfferMethod" grpCd="2034" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="1001" type="radio" defaultLabel="구분"  />
						</li>
					</ul>
				</td>
			</tr>
			<!-- //서비스 유형 -->

            <!-- 서비스 관리 -->
            <tr>
                <th><span>서비스 관리</span></th>
                <td>
                    <input id="metaSvcBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2030, '', '');"></input>
                    <span id="metaSvcNm"></span>
                    <input name="metaSvcs" id="metaSvcs" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //서비스 관리 -->

            <!-- 구축방식 -->
            <tr>
                <th><span>구축방식</span></th>
                <td>
                    <input id="metaCnstcMthdBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2032, '', '');"></input>
                    <span id="metaCnstcMthdNm"></span>
                    <input name="metaCnstcMthds" id="metaCnstcMthds" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //구축방식 -->
            
            <!-- 호환성(표준) -->
            <tr>
                <th><span>호환성(표준)</span></th>
                <td>
                    <input id="metaStdBtn" type="button" value="선택" class="blue w80"  onclick="jsMetaPop(this, 2031, '', '');"></input>
                    <span id="metaStdNm"></span>
                    <input name="metaStds" id="metaStds" type="hidden" value=""/>
                </td>
            </tr>
            <!-- //호환성(표준) -->
            
            <!-- 지원언어 -->
			<tr>
				<th><span class="tx_red_s">*</span>지원언어</th>
				<td><c:forEach items="${goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
						<input name="metaLangs" id="metaLangs${_goodsMetaLang.metaLangCd}" class="w_92p" type="checkbox"
						 value="${_goodsMetaLang.metaLangCd}" style="width:20px;"
						 <c:if test="${status.first}">checked="checked"</c:if>/>
						 <span id="metaLangs${_goodsMetaLang.metaLangCd}Nm">${_goodsMetaLang.metaLangNm}</span>
						 <c:if test="${status.last}">
							<input name="metaLangEtc" id="metaLangEtc" type="text" readonly="readonly" style="width:250px"></input>
						 </c:if>
					</c:forEach>
					<input name="metaLangsNm" id="metaLangsNm" type="hidden" value=""/>
				</td>
			</tr>
            <!-- //지원언어 -->

            <!-- 원산지 -->
			<tr>
			    <th><span class="tx_red_s">*</span>원산지</th>
				<td>
					<input type="text" class="w650" id="orgplce" name="orgplce" style="ime-mode:active"/>
				</td>
			</tr>
            <!-- //원산지 -->
            
            <!-- A/S방침 -->
			<tr>
				<th><span class="tx_red_s">*</span>A/S방침</th>
				<td>
				    <input id="metaASsBtn"  type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1021, '1000', '1999');"></input>
					<span id="metaASnm" class="mar_l10"></span>
					<input name="metaASs" id="metaASs" type="hidden" value=""/>
					<input name="metaASetc" id="metaASetc" type="hidden" value=""/>
					<input name="metaASnms" id="metaASnms" type="hidden" value=""/>
				</td>
			</tr>
            <!-- //A/S방침 -->
            
            <!-- 지원OS -->
			<tr>
				<th><span class="tx_red_s">*</span>지원OS</th>
				<td>
				    <input id="metaOSsBtn" type="button" value="선택" class="blue w80" onclick="jsMetaPop(this, 1020, '', '');"></input>
					<span id="metaOSnm" class="mar_l10"></span>
					<input name="metaOSs" id="metaOSs" type="hidden" value=""/>
					<input name="metaOSetc" id="metaOSetc" type="hidden" value=""/>
					<input name="metaOSnms" id="metaOSnms" type="hidden" value=""/>
				</td>
			</tr>
			<!-- //지원OS -->
			
			<!-- 아키텍쳐 -->
			<tr>
				<th><span class="tx_red_s">*</span>아키텍쳐</th>
				<td>
					<input name="archtcSeArry" id="archtcSeArry1" type="checkbox" checked="checked" value="1"/>32bit&nbsp;
					<input name="archtcSeArry" id="archtcSeArry2" type="checkbox" value="2"/>64bit
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
				<td>${param.sellerInfo1}<input name="sellerInfo1" id="sellerInfo1" type="hidden" value="${param.sellerInfo1}"/></td>
				<th>판매자 구분</th>
				<td>${param.sellerInfo2}<input name="sellerInfo2" id="sellerInfo2" type="hidden" value="${param.sellerInfo2}"/></td>
				<th>판매자 유형</th>
				<td>${param.sellerInfo3}<input name="sellerInfo3" id="sellerInfo3" type="hidden" value="${param.sellerInfo3}"/></td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>담당자</th>
				<td colspan="5"><input name="goodsChargerNm" id="goodsChargerNm" class="w_92p" type="text" value="${param.goodsChargerNm}"></input></td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>담당자 이메일</th>
				<td colspan="5"><input name="goodsChargerEmail" id="goodsChargerEmail" class="w_92p" type="text" value="${param.goodsChargerEmail}"></input></td>
			</tr>
			<tr>
				<th><span class="tx_red_s">*</span>담당자 전화번호</th>
				<td colspan="5"><input name="goodsChargerCttpc" id="goodsChargerCttpc" class="w_92p" type="text" value="${param.goodsChargerCttpc}"></input></td>
			</tr>
			<tr>
				<th>담당자 휴대전화번호</th>
				<td colspan="5"><input name="goodsChargerMbtlnum" id="goodsChargerMbtlnum" class="w_92p" type="text" value=""></input></td>
			</tr>
<!-- 2016.12.09 수정  소계영상, 홈페이지URL 삭제요청으로 주석처리함 -->	
<!--  
			<tr>
				<th>홈페이지URL</th>
				<td colspan="5"><input name="goodsHmpgUrl" id="goodsHmpgUrl" class="w_92p" type="text" value=""></input></td>
			</tr>
-->			
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
				<td colspan="3"><textarea name="goodsSumry" id="goodsSumry" rows="5" class="w_92p"></textarea></td>
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
								<input name="metaTAGs" id="metaTAGs" type="hidden" value=""/>
								<ul id="metaTAGhtml"></ul>
							</td>
						</tr>
						<tr>
							<td>

							</td>
							<td>
								<input type="text" name="goodsTags" id="goodsTags" class="w_92p" value="" title="태그" />
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
                        <textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
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
                                    $("#userIdBtn").focus();
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
						<textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
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
                                    $("#userIdBtn").focus();
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
					    <textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요"></textarea>
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
                                    $("#userIdBtn").focus();
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
				    <input type="file" name="priceFile1" id="priceFile1" class="mnlFile w_92p" onchange="jsFileChk('priceFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="priceFile1Desc" value=""/>
				    <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('priceFile1');"/>
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
				    <input type="file" name="mnlFile1" id="mnlFile1" class="mnlFile w_92p" onchange="jsFileChk('mnlFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="mnlFile1Desc" value=""/>
				    <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('mnlFile1');"/>
				</td>

			</tr>
			<!-- //서비스소개서 -->

			<!-- 사용메뉴얼 -->
			<tr>
				<th colspan="4">사용메뉴얼</th>
			</tr>
			<tr>
			    <td colspan="2"></td>
				<td>파일 업로드</td>
                <td>
				    <input type="file" name="dnlFile1" id="dnlFile1" class="mnlFile w_92p" onchange="jsFileChk('dnlFile1', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="dnlFile1Desc" value=""/>
				    <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('dnlFile1');"/>
				</td>
			</tr>
			<!-- //사용메뉴얼 -->


			
			<!-- 기타첨부파일 -->
			<tr>
				<th colspan="4">기타 첨부파일 <span class="caption">(최대 5개)</span></th>
			</tr>
			<c:forEach var="i" begin="1" end="5" step="1" varStatus="status">
			<tr>
			    <td colspan="2"></td>
				<td>파일 업로드</td>
                <td>
                    <input type="file" name="etcFile${i}" id="etcFile${i}" class="mnlFile w_92p" onchange="jsFileChk('etcFile${i}', 'etcfileInput${i}', 10240, '1', -1, 5);"></input>
				    <input type="hidden" name="fileDesc" id="etcFile${i}Desc" value=""/>
				    <input class="mar_l5" type="button" value="X" onclick="jsInputFileReset('etcFile${i}');"/>
				</td>
			</tr>

			</c:forEach>
			<!-- //기타첨부파일 -->
			
			<tr>
				<td colspan="4">
					<input type="hidden" id="mnlFilesFileDesc" name="mnlFilesFileDesc" value="" />
				</td>
			</tr>
		</tbody>
	</table>

	<!-- 버튼 -->
	<div class="mar_t20 mar_b50">
		<div class="float_l">
			<input type="button" value="취소" class="blue" onclick="jsCancel();" />
			<!-- <input type="button" value="미리보기" class="blue" onclick="jsGoodsPreview('PD_goodsPreview.do');" /> -->
		</div>
		<div class="float_r">
			<input type="button" value="등록" class="blue" onclick="jsGoodsInsertAction();" />
		</div>
	</div>
	<!-- //버튼 -->
	</form>
</body>
</html>
