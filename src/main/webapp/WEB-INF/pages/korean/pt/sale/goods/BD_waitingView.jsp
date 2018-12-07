<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>서비스수정페이지</title>
<op:jsTag type="openworks" items="form, validate, ckeditor" />
<op:jsTag type="spi" items=" form, validate, colorbox" />
<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
<script type="text/javascript">
	$(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop() - 150 + ($(window).height()/2)) + "px"}, "slow");});});
</script>
<script type="text/javascript">
$().ready(function() {
    
    $("input[name=goodsKndCd]").attr("disabled", true);
    $("input[name=serviceOfferMethod]").attr("disabled", true);
  
});

var jsLoading = function(){
	$("#loading-container").show();
	return true;
};


var jsGoodsSpecAction = function() {
    location.href="/korean/pt/sale/goods/BD_goodsSpecView.do?goodsCode=${dataVo.goodsCode}";
};
</script>
</head>
<body>

<div class="supAdm view register">
	<h3>서비스 상세정보 </h3>
	
	<ul>
		<li>본 서비스는 <i>IE8 버전을 지원하지 않습니다.</i> 파일등록 등 정상적인 사용을 위하여 IE10 버전 이상을 사용하십시오.</li>		
	</ul>
	
	
	<c:forEach var="i" begin="1" end="1" step="1" varStatus="status">						
		<c:if test="${not empty dataVo.gcFile[i-1]}">
		<table class="tbl_st4">
			<tr>
				<th  class="requ">변경 사유서 첨부</th>
				<td>
					 <a href="/component/file/ND_fileDownload.do?id=${dataVo.gcFile[i-1].fileId }"
						title="${dataVo.gcFile[i-1].localNm}" class="aDeisable">${dataVo.gcFile[i-1].localNm}
						<span class="tx_gray">(${dataVo.gcFile[i-1].fileSize},
							${dataVo.gcFile[i-1].fileType})</span>
					</a>
				</td>
			</tr>
		</table>
		</c:if>
	</c:forEach>
	
	<dl>
		<dt>서비스 구분선택 [<em>필수</em>]</dt>
		<dd>
			<op:code id="goodsKndCd" grpCd="1005" ctgCd="GDCTCD" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="${dataVo.goodsKndCd}" type="radio" defaultLabel="구분" />			
		</dd>
	</dl>
	<dl>
		<dt>
			서비스명 입력 [<em>필수</em>]
		</dt>
		<dd><c:out value='${dataVo.goodsNm}'/></dd>
	</dl>
	<dl>
		<dt>연결된 카테고리</dt>
		<dd class="relaCate" id="goods">
			<c:forEach items="${dataVo.goodsCtgry}" var="_goodsCtgry"  varStatus="status">
			<span id="goodsCtgry_${_goodsCtgry.CTGRYCODE}"> <c:out
					value='${_goodsCtgry.CTGRYCLNM }' /> <c:out
					value='${_goodsCtgry.CTGRYPATH}' />,
			</span>
			</c:forEach>
		</dd>
	</dl>
	<dl>
		<dt>
			서비스 대표 이미지 [<em>필수</em>] <i>※ 이미지는 10MB미만, 318px x 278px의 JPG,
				GIF파일만 등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
		</dt>
		<dd class="thumb">
			<span id="imgPrev1"> 
				<p class="thumbimg">
					<img src="${dataVo.imageFile[0].fileUrl}" alt="${fileVo.localNm}" id="img1">
				</p>
			</span> 
		</dd>
	</dl>				
    <dl>
		<dt>
			사용화면 이미지 등록 <i>※ 이미지는 10MB미만, 318px x 278px의 JPG, GIF파일만
				등록가능합니다. 사이즈가 다를 경우 승인되지 않습니다.</i>
		</dt>
		<dd class="thumb">
			<c:set var="image" value="" />
			<c:forEach items="${dataVo.imageFile}" var="fileVo"
				varStatus="status">
				<c:if test="${not status.first}">
					<c:set var="i" value="${status.index+1}" />
					<span id="imgPrev${i}"> 
						<p class="thumbimg">
							<img src="${fileVo.fileUrl}" alt="${fileVo.localNm} 이미지" id="img${i}">
						</p>
					   <c:set var="count" value="${count+1}" />
					</span>
					<c:set var="image">
					<c:if test="${!status.first}">${image},</c:if>${fileVo.fileUrl}</c:set>
				</c:if>
			</c:forEach>
			<c:forEach var="i" begin="${count+2}" end="11" step="1" varStatus="status">
				<span id="imgPrev${status.index}">
					<p class="thumbimg"></p>
				</span>
			</c:forEach>		
		</dd>
	</dl>	
	<dl>
		<dt>
			체험판 <b>※ 이용자가 다운로드 또는 온라인 체험을 받을 수 있는 서비스인 경우 관련 URL 주소를 입력해
				주세요.</b>
		</dt>
		<dd>${dataVo.itemVodUrl}</dd>
	</dl>
	<dl>
			<dt>
				서비스 안내 <b>※ 이용자가 다운로드 또는 온라인에서 확인 할 수 있는 서비스 안내 URL 주소를 입력해
					주세요.</b>
			</dt>
			<dd><c:out value='${dataVo.goodsDwldUrl}'/></dd>
	</dl>
	<dl>
		<dt>
			모니터링 URL <b>※ 모티터링URL 시비스 상태를 확인할 수 있는 모니터링 URL을 입력해 주세요.</b>
		</dt>
		<dd>${dataVo.goodsMonitorUrl}</dd>
	</dl>
	<h3>인증정보</h3>
	<p>
		※ 인증서가 있는 경우 증빙자료 첨부(단, 표준프레임워크호환 서비스 등록은 "표준프레임워크 호환레벨 확인서" 첨부시에만
		가능)<br /> ※ 조달청 나라장터 등록서비스의 경우 종합쇼핑몰 제품상세정보 캡처화면 첨부
	</p>

	<table class="tbl_st4 certi">
		<c:forEach items="${dataVo.goodsMark}" var="_goodsMark"
			varStatus="statusSeq">
			<tr>
				<th><c:out value='${_goodsMark.MARKNM}' /></th>
				<c:choose>
					<c:when test="${_goodsMark.MARKCD != '1005'}">
						<td><label> <input type="hidden" name="markCds"
								id="markCds" value="<c:out value='${_goodsMark.MARKCD}'/>" />
								<input type="checkbox" name="goodsMarkCds"  disabled="disabled" 
								value="<c:out value='${_goodsMark.MARKCD}'/>"
								<c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if> />
						</label></td>
						<th>증빙 자료 업로드</th>
						<td>
							<c:forEach items="${dataVo.markCrtfcFile[ statusSeq.index]}"
								var="fileVo" varStatus="status">
								<!-- class="uploaded"  -->
								<p id="mar_b5${statusSeq.index}">
									<span> <a
										href="/component/file/ND_fileDownload.do?id=${fileVo.fileId}"
										title="${fileVo.localNm}" class="aDeisable">${fileVo.localNm}
											<span class="tx_gray">(${fileVo.fileSize},
												${fileVo.fileType})</span>
									</a>
									</span>
								</p>
							</c:forEach>
					</c:when>
					<c:when test="${_goodsMark.MARKCD == '1005'}">
						<td colspan="3"><c:out value='${dataVo.cntrctNo}'/></td>
					</c:when>
				</c:choose>
			</tr>
		</c:forEach>
	</table>
	<h3>기본정보 입력</h3>
		<table class="tbl_st4 basicInput">
			<tr>
				<th class="requ">제조사</th>
				<td>${dataVo.goodsMakr}</td>
			</tr>
			<tr>
				<th class="requ">출시일</span></th>
				<td>${dataVo.comouDe}</td>
			</tr>
			<%-- <tr>
				<th>무료/체험 구분</th>
				<td><span id="metaCnstcMthdNm"><c:forEach items="${dataVo.goodsMetaExprn}" var="_goodsMetaExprn" varStatus="status">
					${_goodsMetaExprn.INDVDLZ_CD_NM}${!status.last?',':''}
					</c:forEach></span>
				</td>
			</tr> --%>
			<tr>
				<th>기업구분</th>
				<td><span class="agree">
					<c:if test="${dataVo.smlpzChk =='Y'}" >중소기업</c:if>
						<c:if test="${dataVo.smlpzChk =='M'}" >중견기업</c:if>
						<c:if test="${dataVo.smlpzChk =='B'}" >대기업</c:if>
				</span></td>
			</tr>
			<tr>
				<th class="requ">단가(￦)</th>
				<td><c:out value='${dataVo.goodsPc}'/></td>
			</tr>
			<tr>
				<th class="requ">계약단위</th>
				<td><span id="metaCnstcMthdNm"><c:forEach items="${dataVo.goodsMetaCntrctUnit}" var="_goodsMetaCntrctUnit"
					varStatus="status">${_goodsMetaCntrctUnit.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
				</td>
			</tr>
			<tr>
				<th class="requ">서비스 유형</th>
				<td><op:code id="serviceOfferMethod" grpCd="2034" option="style='width:30px;text-align:left;z-index:5;'" defaultValues="${dataVo.serviceOfferMethod}" type="radio" defaultLabel="구분"  /></td>
			</tr>
			<tr>
				<th>서비스 관리</th>
				<td><c:forEach
							items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc"
							varStatus="status">${_goodsMetaSvc.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
					<input name="metaSvcs" id="metaSvcs" type="hidden"
					value="<c:forEach items="${dataVo.goodsMetaSvc}" var="_goodsMetaSvc" varStatus="status">${_goodsMetaSvc.INDVDLZ_CD}${!status.last?',':''}</c:forEach>" />
				</td>
			</tr>
			<tr>
				<th>구축방식</th>
				<td><c:forEach items="${dataVo.goodsMetaCnstcMthd}" var="_goodsMetaCnstcMthd" varStatus="status">
					${_goodsMetaCnstcMthd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
					
				</td>
			</tr>
			<tr>
				<th>호환성(표준)</th>
				<td> <span id="metaStdNm"><c:forEach
							items="${dataVo.goodsMetaStd}" var="_goodsMetaStd"
							varStatus="status">${_goodsMetaStd.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach></span>
					<input name="metaStds" id="metaStds" type="hidden"
					value="<c:forEach items="${dataVo.goodsMetaStd}" var="_goodsMetaStd" varStatus="status">${_goodsMetaStd.INDVDLZ_CD}${!status.last?',':''}</c:forEach>" />
				</td>
			</tr>
			<tr>
				<th class="requ">지원언어</th>
				<td><span class="agree"> <c:set var="metaLangEtcOpen"
							value="readOnly" scope="page" /> <c:forEach
							items="${dataVo.goodsMetaLang}" var="_goodsMetaLang"
							varStatus="status">
							<input name="metaLangs" id="metaLangs${_goodsMetaLang.LANGCD}" disabled=true
								type="checkbox" value="${_goodsMetaLang.LANGCD}"
								<c:if test="${_goodsMetaLang.LANGCD == _goodsMetaLang.METALANGCD}"> checked="checked"</c:if> />
							<span id="metaLangs${_goodsMetaLang.LANGCD}Nm"
								class="caption mr10">${_goodsMetaLang.LANGNM}</span>
							<c:if test="${_goodsMetaLang.METALANGCD == 1006}">
								<c:set var="metaLangEtcOpen" value="" scope="page" />
							</c:if>
							<c:if test="${status.last}">
								<input name="metaLangEtc" id="metaLangEtc" type="text"
									style="width: 250px;"
									value="<c:out value='${_goodsMetaLang.METAETCCN}'/>"
									<c:out value='${metaLangEtcOpen}'/> />
							</c:if>
						</c:forEach> 
				</span></td>
			</tr>
			<tr>
				<th class="requ">원산지</th>
				<td>${dataVo.orgplce}</td>
			</tr>
			<tr>
				<th class="requ">A/S방침</th>
				<td><span id="metaASnm">
						<c:forEach items="${dataVo.goodsMetaAS}" var="_goodsMetaAS"
							varStatus="status">${_goodsMetaAS.INDVDLZ_CD_NM}${!status.last?',':''}</c:forEach>
				</span></td>
			</tr>
			<tr>
				<th class="requ">지원OS</th>
				<td><c:forEach
							items="${dataVo.goodsMetaOS}" var="_goodsMetaOS"
							varStatus="status"><span>${_goodsMetaOS.INDVDLZ_CD_NM}${!status.last?',':''}</span></c:forEach></span>
					<input name="metaOSs" id="metaOSs" type="hidden"
					value="<c:forEach items="${dataVo.goodsMetaOS}" var="_goodsMetaOS" varStatus="status">${_goodsMetaOS.INDVDLZ_CD}${!status.last?',':''}<c:if test="${_goodsMetaOS.INDVDLZ_CD == 9001}"><c:set var="metaOSetc" value="${_goodsMetaOS.META_ETC_CN}"/></c:if></c:forEach>" />
					<input name="metaOSetc" id="metaOSetc" type="hidden"
					value="${metaOSetc}" /> <input name="metaOSnms" id="metaOSnms"
					type="hidden" value="" /></td>
			</tr>
			<tr>
				<th class="requ">아키텍쳐</th>
				<td><span class="agree"><input  type="checkbox" id="archtcSe1" name="archtcSe1" value="1" ${dataVo.archtcSe eq 3 or dataVo.archtcSe eq 1? 'checked':''} disabled="disabled"/>32-BIT
					<input type="checkbox" id="archtcSe2" name="archtcSe1" value="2" ${dataVo.archtcSe eq 3 or dataVo.archtcSe eq 2? 'checked':'' } disabled="disabled"/>64-BIT</span></td>
			</tr>
		</table>
		<h3>판매자 정보 입력</h3>
			<table class="tbl_st4">
				<tr>
					<th class="requ">회사명</th>
					<td><c:out value='${dataVo.goodsStore[0].LANGSTORENM }'/></td>
				</tr>
				<tr>
					<th class="requ">담당자</th>
					<td><c:out value='${dataVo.goodsChargerNm}'/></td>
				</tr>
				<tr>
					<th class="requ">담당자 이메일</th>
					<td class="emailSt1"><input type="text" readonly
						id="goodsChargerEmail1" name="goodsChargerEmail1"
						value="${fn:split(dataVo.goodsChargerEmail,'@')[0]}" class="w194" /><span
						class="space">@</span><input type="text" name="goodsChargerEmail2"
						id="goodsChargerEmail2" readonly
						value="${fn:split(dataVo.goodsChargerEmail,'@')[1]}" class="w194" /></td>
				</tr>
				<tr>
					<th class="requ">담당자 연락처</th>
					<td class="tel"><c:set var="cttpcs"
							value="${fn:split(dataVo.goodsChargerCttpc,'-')}" /> <!-- static select -->
						 <select id="goodsChargerCttpc0" disabled=true
							name="goodsChargerCttpc0" title="국가 선택" style="width: 210px;">
								<option value="">국가 선택</option>
								<c:forEach items="${nation}" var="list">
									<option value="<c:out value='${list.INTRLTELNL}'/>"
										<c:if test="${fn:length(cttpcs) <= 3}">
			                	<c:out value="${fn:replace(dataVo.langCode,'00','82') == list.INTRLTELNL ? 'selected' : ''}"/> 
			                  </c:if>
										<c:if test="${fn:length(cttpcs) > 3}">
			                	<c:out value="${fn:split(dataVo.goodsChargerCttpc,'-')[0] == list.INTRLTELNL ? 'selected' : ''}"/>
			                  </c:if>>
										<c:out value="${list.LANGNATIONNM}" />
										(
										<c:out value="${list.INTRLTELNL}" />
										)
									</option>
								</c:forEach>
						</select>
						<c:if test="${fn:length(cttpcs) <= 3}">
							<c:set var="idx" value="0" />
						</c:if> <!-- 국가코드가 존재하면 --> <c:if test="${fn:length(cttpcs) > 3}">
							<c:set var="idx" value="1" />
						</c:if> <input type="text" readonly name="goodsChargerCttpc1"
						id="goodsChargerCttpc1" title="연락처 입력"
						value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx]}"
						maxlength="4" class="w124" /> - <input type="text"
						name="goodsChargerCttpc2" readonly id="goodsChargerCttpc2" title="연락처 입력"
						value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx+1]}"
						class="w124" maxlength="4" /> - <input type="text"
						name="goodsChargerCttpc3" id="goodsChargerCttpc3" title="연락처 입력"
						maxlength="4" readonly
						value="${fn:split(dataVo.goodsChargerCttpc,'-')[idx+2]}"
						class="w124" maxlength="4" /></td>
				</tr>
				<tr>
					<th class="requ">담당자 휴대폰</th>
					<td class="tel">
					     <input type="text" readonly name="goodsChargerMbtlnum1" id="goodsChargerMbtlnum1" title="휴대전화번호 입력" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[0]}" maxlength="3" /> - 
						<input type="text" readonly name="goodsChargerMbtlnum2" id="goodsChargerMbtlnum2" title="휴대전화번호 입력" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[1]}"  maxlength="4" /> - 
						<input type="text" readonly  name="goodsChargerMbtlnum3" id="goodsChargerMbtlnum3" title="휴대전화번호 입력" maxlength="4" value="${fn:split(dataVo.goodsChargerMbtlnum,'-')[2]}"/>
				   </td>
				</tr>
			</table>
		
		<h3>상세 정보 입력</h3>
			<table class="tbl_st4 detailInput">
				<tr>
					<th class="requ">서비스개요</th>
					<td><textarea name="goodsSumry" id="goodsSumry" onkeyup="javascript:displayBytes(3000,'goodsSumry');" class="h167" readonly="readonly"><c:out value='${dataVo.goodsSumry }'/></textarea></td>
				</tr>
				<tr>
					<th>태그</th>
					<td class="tags">
						<c:forEach items="${dataVo.goodsMetaTAG}" var="_goodsMetaTAG" varStatus="status">
							${_goodsMetaTAG.INDVDLZ_CD_NM} 
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th class="requ">특장점</th>
					<td><textarea name="itemSfe" id="itemSfe" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.itemSfe}' escapeXml="false"/></textarea>
                        <script type="text/javascript">
                        //<![CDATA[
                            CKEDITOR.replace('itemSfe', {
                                height               : 200,
                                htmlEncodeOutput     : false,
                                enterMode            : "2",
                                skin                 : "moono",
                                toolbar              : [[ 'BulletedList' ]],
                                filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                                readOnly			 : true
                            });
                        //]]>
                        </script></td>
				</tr>
				<tr>
					<th class="requ">대상고객</th>
					<td>
					<textarea name="goodsRefer" id="goodsRefer" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.goodsRefer}' escapeXml="false"/></textarea>
                      <script type="text/javascript">
                      //<![CDATA[
                          CKEDITOR.replace('goodsRefer', {
                              height               : 200,
                              htmlEncodeOutput     : false,
                              enterMode            : "2",
                              skin                 : "moono",
                              toolbar              : [[ 'BulletedList' ]],
                              filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
                              readOnly			 : true
                          });
                      //]]>
                      </script>
                   </td>
               </tr>
               <tr>
					<th class="requ">주요기능</th>
					<td><textarea name="goodsMainFnct" id="goodsMainFnct" rows="15" style="width: 743px" title="내용을 입력해주세요"><c:out value='${dataVo.goodsMainFnct}' escapeXml="false"/></textarea>
	                       <script type="text/javascript">
	                       //<![CDATA[
	                           CKEDITOR.replace('goodsMainFnct', {
	                               height               : 200,
	                               htmlEncodeOutput     : false,
	                               enterMode            : "2",
	                               skin                 : "moono",
	                               toolbar              : [[ 'BulletedList' ]],
	                               filebrowserUploadUrl : "/component/file/ND_fileUpload.do",
	                               readOnly			 : true
	                           });
	                       //]]>
	                       </script>
	                 </td>
	            </tr>
			    <tr>
					<th class="requ">가격표(업로드)</th>     
					<td> <c:forEach var="i" begin="1" end="1" step="1" varStatus="status">							
							<c:if test="${not empty dataVo.priceFile[i-1]}">
								<a href="/component/file/ND_fileDownload.do?id=${dataVo.priceFile[i-1].fileId }"
									title="${dataVo.priceFile[i-1].localNm}" class="aDeisable">${dataVo.priceFile[i-1].localNm}
									<span class="tx_gray">(${dataVo.priceFile[i-1].fileSize}, ${dataVo.priceFile[i-1].fileType})</span>
								</a>
						 	</c:if>
					 </c:forEach></td>
				</tr>
				<tr>
					<th>사용메뉴얼(업로드)</th>
					<td> <c:forEach var="i" begin="1"  end="1" step="1" varStatus="status">
							<c:if test="${not empty dataVo.dnlFile[i-1]}">
							 <a href="/component/file/ND_fileDownload.do?id=${dataVo.dnlFile[i-1].fileId }"
								title="${dataVo.dnlFile[i-1].localNm}" class="aDeisable">${dataVo.dnlFile[i-1].localNm}
							  <span class="tx_gray">(${dataVo.dnlFile[i-1].fileSize}, ${dataVo.dnlFile[i-1].fileType})</span>
							</a>
							</c:if>
						</c:forEach></td>
				</tr>
				<tr>
					<th>기타 첨부파일(최대 5개)</th>
					<td><c:forEach var="i" begin="1" end="5" step="1" varStatus="rtstatus">
						<li class="mt10"><input type="hidden" name="etcFileSeq"	value="${dataVo.etcFileSeq}" />
						<c:if test="${not empty dataVo.etcFile[i-1]}">
							<a href="/component/file/ND_fileDownload.do?id=${dataVo.etcFile[i-1].fileId }"
								title="${dataVo.etcFile[i-1].localNm}" class="aDeisable">${dataVo.etcFile[i-1].localNm}
								<span class="tx_gray">(${dataVo.etcFile[i-1].fileSize}, ${dataVo.etcFile[i-1].fileType})</span>
							</a> 
							</c:if></li>
						</c:forEach></td>
				</tr>
		</table>
	
		<div class="btnArea rig">
			<a href="javascript:" id="tempSave" onclick="if (jsLoading()==true){jsGoodsSpecAction();};" class="btns st1 icn_r next">규격서 확인</a>
		</div>
		
		
		<c:if test="${not empty histVo}" >
			<h3>변경이력</h3>
			<table class="tbl_st1">
				<thead>
					<tr>
						<th>번호</th>
						<th>요청날짜</th>
						<th>승인날짜</th>	
						<th>가격변경</th>
						<th>변경사유서</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${histVo}" var="_histVo" varStatus="status">
					<tr>
							<td>${fn:length(histVo) -status.index}</td>
							<td>${_histVo.REQU_DT}</td>
							<td>${_histVo.EXMNT_CONFM_DT}</td>	
							<%-- <td>${_histVo.EXMNT_CONFM_CD}</td> --%>
							<td>
							<c:if test="${not empty _histVo.GOODS_CHNG_PC}" >
							전:${_histVo.GOODS_BEFORE_PC}, 후:${_histVo.GOODS_CHNG_PC}</c:if>
							<c:if test="${empty _histVo.GOODS_CHNG_PC}" >변경사항 없음.</c:if>
							</td>
							<td>
							<c:if test="${_histVo.GOODS_CHNG_FILE > 0}" >
							<a href="/component/file/ND_fileDownload.do?id=${_histVo.GOODS_CHNG_FILE_ID[0].fileId}" class="downLoad">변경사유서</a>
							</c:if>
							</td>
						</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<div id="loading-container" class="loading-container">
			<div class="loading"></div>
			<div id="loading-text">loading</div>
		</div>
		
	</div>
	<!-- //contents -->

</body>
</html>