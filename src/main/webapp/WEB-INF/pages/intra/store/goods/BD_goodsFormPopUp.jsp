<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<title>서비스비교</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />

	<script type="text/javascript">
 		var jsClose = function() {
	        parent.$.colorbox.close();
	    }
	</script>
	<link rel='stylesheet' href='/new_cloud/css/v3_pop.css' />
	<link rel='stylesheet' href='/new_cloud/css/v3_cmm.css' />
	<link rel='stylesheet' href='/new_cloud/css/v3_css.css' />


<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
	$().ready(function(){

	    displayBytes(3000,'cfmItemContent');            
	
	});

    //글자수체크
    var displayBytes = function(nm, id){
        var obj = document.getElementById(id);
        if(obj.value.bytes() > nm){
            if(event.keyCode != '8'){
                //alert(nm+'바이트까지 입력이 가능합니다.');
                alert(nm+Message.msg.chkFormByteUntill);
            }
            obj.value = obj.value.substring(0, obj.value.length - 10);
        }
        eval('document.all.'+id+'_bytes').innerHTML = eval('dataForm.'+id).value.bytes();
    };



    var jsClose = function(){
        parent.$.fn.colorbox.close();
	};    

	var jsGoodsInsertAction = function(goodsCode, stat, exmntConfmHistSn) {
		var msg = "" ;

		var str = $("#cfmItemContent").val();
		if(stat == 'Y'){
	        msg = "승인 하시겠습니까?";			
		} else {
	        if (str == null || str.length < 1){
	            
	        	alert("관리자 검토의견을 입력해주세요.");
	            $("#cfmItemContent").focus();
	            return false;
	        }
			//alert($("#goodsCode").val());
			
	        msg = "반려 하시겠습니까?";
		}


		if (confirm(msg)){
			
            $("#dataForm").ajaxSubmit({
                url: "ND_cfmItemContent.do",
                type: "POST",
                data: { goodsCodes :  goodsCode,
                	    stat :  stat,
                	    exmntConfmHistSn : exmntConfmHistSn
                },
                success: function(response) {
                    if(response) {
                        jsSuccessBox("반려되었습니다.");
                        //jsRppReset(2);
            			parent.$.colorbox.close();
            			parent.document.location.reload();			
                        
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                }
            });

            
			
 					
		} else {
			$("#loading-container").hide();
			return;
		}
	};      

      
//]]>
</script>

	
 </head>
<body>
	<div class="supAdm view register">  
		<div id="serviceRegist01">
			<h3>1-1. 서비스 일반정보</h3>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
				<thead>
					<tr>
						<th style="text-align:center"><B>구분</B></th>
						<th style="text-align:center"><B>변경전</B></td>
						<th style="text-align:center"><B>변경후</B></td>
					</tr>
		        </thead>
		        <tbody>			
					<tr>
						<th>서비스명</th>
						<td>${goodsInfo.goodsNm}</td>
						<td>${goodsInfoTmp.goodsNm}</td>
					</tr>
					<tr>
						<th>서비스 구분</th>
						<td>${goodsInfo.goodsKndNm}</td>
						<td>${goodsInfoTmp.goodsKndNm}</td>
					</tr>        
					<tr>
						<th>카테고리</th>
						<td>
		                    <c:forEach items="${goodsCateList}" var="_goodsCtgry" varStatus="status">
								<span id="goodsCtgry_${_goodsCtgry.ctgryCode}">
		                    		<c:out value='${_goodsCtgry.ctgryName }'/><c:if test="${status.index+1 lt fn:length(goodsCateList) }">, </c:if>
		                        </span>
		                    </c:forEach>						
						</td>
						<td>
		                    <c:forEach items="${goodsCateListTmp}" var="_goodsCtgryTmp" varStatus="status">
								<span id="goodsCtgry_${_goodsCtgryTmp.ctgryCode}">
		                    		<c:out value='${_goodsCtgryTmp.ctgryName }'/><c:if test="${status.index+1 lt fn:length(goodsCateListTmp) }">, </c:if>
		                        </span>
		                    </c:forEach>						
						</td>
					</tr>
					<tr>
						<th>과금기준</th>
						<td>${goodsInfo.dueStdrMumm}</td>
						<td>${goodsInfoTmp.dueStdrMumm}</td>
					</tr>
					<tr>
						<th>서비스 가격</th>
						<td>${goodsInfo.svcPcUntCd} / <fmt:formatNumber  value='${goodsInfo.svcPc}' type="number"/> / 부가세포함 : ${goodsInfo.svcPcVat}  </td>
						<td>${goodsInfoTmp.svcPcUntCd} / <fmt:formatNumber  value='${goodsInfoTmp.svcPc}' type="number"/> / 부가세포함 : ${goodsInfoTmp.svcPcVat} </td>
					</tr>
					<tr>
						<th>최소 계약기간</th>
						<td>${goodsInfo.mummCntrctpd}</td>
						<td>${goodsInfoTmp.mummCntrctpd}</td>
					</tr>
					<tr>
						<th>서비스 대표 이미지</th>
						<td>
							<div class="thumb" >
								<span id="imgPrev1">
						        	<c:if test="${fn:length(goodsInfo.goodsImageFileUrl) gt 0}">
			                    	<img src="${goodsInfo.goodsImageFileUrl[0]}" alt="대표이미지" id="imgPrev1"/>
			                    	</c:if>							
								</span> 
							</div>
						</td>
						<td>
							<div class="thumb" >
								<span id="imgPrev1">
						        	<c:if test="${fn:length(goodsInfoTmp.goodsImageFileUrl) gt 0}">
			                    	<img src="${goodsInfoTmp.goodsImageFileUrl[0]}" alt="대표이미지" id="imgPrev1"/>
			                    	</c:if>							
								</span> 
							</div>
						</td>
					</tr>
					<tr>
						<th>사용화면 이미지 등록</th>
						<td>
				            <div class="thumb" >    
				                <c:if test="${empty dataVo.imageFile}">
				                    <c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
				                        <span id="imgPrev${status.index}">
				                            <p class="thumbimg">
				                            <%-- ${fn:length(goodsInfo.goodsImageFileUrl)-1} --%>
				                            	<c:if test="${fn:length(goodsInfo.goodsImageFileUrl) gt 0}">
				                            		<c:forEach var="j" begin="1" end="${fn:length(goodsInfo.goodsImageFileUrl)-1}" step="1" varStatus="statusImg">
				                            			<c:if test="${j eq i-1 }">
				                            				<img src="${goodsInfo.goodsImageFileUrl[j]}" id="imgPrev${i}"/>
				                            			</c:if>
				                            		</c:forEach>
				                            	</c:if>
				                            </p>

				                        </span>
				                    </c:forEach>
				                </c:if>
				            </div>						
						</td>
						<td>
							<div class="thumb" >
				                <c:if test="${empty dataVo.imageFile}">
				                    <c:forEach var="i" begin="2" end="11" step="1" varStatus="status">
				                        <span id="imgPrev${status.index}">
				                            <p class="thumbimg">
				                            <%-- ${fn:length(goodsInfo.goodsImageFileUrl)-1} --%>
				                            	<c:if test="${fn:length(goodsInfoTmp.goodsImageFileUrl) gt 0}">
				                            		<c:forEach var="j" begin="1" end="${fn:length(goodsInfoTmp.goodsImageFileUrl)-1}" step="1" varStatus="statusImg">
				                            			<c:if test="${j eq i-1 }">
				                            				<img src="${goodsInfoTmp.goodsImageFileUrl[j]}" id="imgPrev${i}"/>
				                            			</c:if>
				                            		</c:forEach>
				                            	</c:if>
				                            </p>

				                        </span>
				                    </c:forEach>
				                </c:if>
							</div>
						</td>
					</tr>
					<tr>
						<th>체험판 URL</th>
						<td>${goodsInfo.itemVodUrl}</td>
						<td>${goodsInfoTmp.itemVodUrl}</td>
					</tr>
					<tr>
						<th>서비스 안내 URL</th>
						<td>${goodsInfo.goodsDwldUrl}</td>
						<td>${goodsInfoTmp.goodsDwldUrl}</td>
					</tr>
					<tr>
						<th>모니터링 URL</th>
						<td>${goodsInfo.goodsMonitorUrl}</td>
						<td>${goodsInfoTmp.goodsMonitorUrl}</td>
					</tr>
				 </tbody>	
			</table>
		</div>

		<br />
		<div id="serviceRegist02">
			<h2>2-1. 서비스 상세정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>	
					<tr>
						<th >서비스개요</th>
						<td>${goodsInfo.goodsSumry}</td>
						<td>${goodsInfoTmp.goodsSumry}</td>
					</tr>
					<tr>
						<th >특장점</th>
						<td>${goodsInfo.itemSfe}</td>
						<td>${goodsInfoTmp.itemSfe}</td>
					</tr>
					<tr>
						<th >대상고객</th>
						<td>${goodsInfo.cstmrInfo}</td>
						<td>${goodsInfoTmp.cstmrInfo}</td>
					</tr>    
					<tr>
						<th >주요기능</th>
						<td>${goodsInfo.goodsMainFnct}</td>
						<td>${goodsInfoTmp.goodsMainFnct}</td>
					</tr>
					<tr>
						<th >주요 레퍼런스<br />(등록 서비스 기준)</th>
						<td>${goodsInfo.goodsRefer}</td>
						<td>${goodsInfoTmp.goodsRefer}</td>
					</tr>     
					<!-- 
					<tr>
						<th >서비스 정의 및 특징</th>
						<td></td>
						<td></td>
					</tr>
					 -->     
					<tr>
						<th >서비스 기대효과</th>
						<td>${goodsInfo.goodsExpcEffect}</td>
						<td>${goodsInfoTmp.goodsExpcEffect}</td>
					</tr>
				</tbody>
			</table>

			<br />
			
			<div id="2-2" <c:if test="${goodsKndCd eq '1004'}">style="display:none"</c:if>>
				<h2>2-2. 서비스 사양정보</h2>    
				<table class="boardWrite" cellspacing="0" border="0" >
			        <colgroup>
			            <col width="200" />
			            <col width="500" />
			            <col width="500" />		            
			        </colgroup>
			        <tbody>	
						<tr>
							<th >서비스 관리 기준</th>
							<td>
			                	<c:forEach var="metaSvc" items="${goodsMetaList}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvc.groupCd eq '2030'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvc.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
							</td>
							<td>
			                	<c:forEach var="metaSvcTmp" items="${goodsMetaListTmp}" varStatus="metaSvcStatus">
			                		<c:if test="${metaSvcTmp.groupCd eq '2030'}">
			                			<c:if test="${conut gt 0}">,</c:if>
			                			${metaSvcTmp.indvdlzNm}
			                			<c:set var="conut" value="${count + 1}" />
			                		</c:if>
			                	</c:forEach>
							</td>
						</tr>
						<tr>
							<th >구축방식</th>
							<td>
				            	<c:forEach items="${metaCnstcMthds}" var="_metaCnstcMthds" varStatus="status">                    
				                	 
				                	<c:set var="checked" value="false"/>
				                	<c:forEach items="${goodsMetaList}" var="_goodsMeta" varStatus="status">
					               		<c:if test="${_goodsMeta.groupCd eq '2032' and _goodsMeta.indvdlzCd eq _metaCnstcMthds.PRVCD}">
					                		<c:set var="checked" value="true"/>
					                	</c:if>
				                	</c:forEach>
				                	
				                	<input type="checkbox" name="metaCnstcMthds" id="metaCnstcMthds_${_metaCnstcMthds.PRVCD}" value="${_metaCnstcMthds.PRVCD}" style="margin-right: 10px;" <c:if test="${checked eq true}"> checked="checked" </c:if> disabled>
				                	<label for="metaCnstcMthds_${_metaCnstcMthds.PRVCD}">${_metaCnstcMthds.PRVNM}</label>    
				                </c:forEach>							
							</td>
							<td>
				            	<c:forEach items="${metaCnstcMthds}" var="_metaCnstcMthds" varStatus="status">                    
				                	 
				                	<c:set var="checked" value="false"/>
				                	<c:forEach items="${goodsMetaListTmp}" var="_goodsMeta" varStatus="status">
					               		<c:if test="${_goodsMeta.groupCd eq '2032' and _goodsMeta.indvdlzCd eq _metaCnstcMthds.PRVCD}">
					                		<c:set var="checked" value="true"/>
					                	</c:if>
				                	</c:forEach>
				                	
				                	<input type="checkbox" name="metaCnstcMthds" id="metaCnstcMthds_${_metaCnstcMthds.PRVCD}" value="${_metaCnstcMthds.PRVCD}" style="margin-right: 10px;" <c:if test="${checked eq true}"> checked="checked" </c:if> disabled>
				                	<label for="metaCnstcMthds_${_metaCnstcMthds.PRVCD}">${_metaCnstcMthds.PRVNM}</label>    
				                </c:forEach>							
							</td>
						</tr>
						<tr>
							<th >서비스 유형</th>
							<td>
								<c:forEach items="${serviceOfferMethod}" var="_serviceOfferMethod" varStatus="status">                    
					            	<input type="radio" name="serviceOfferMethod" id="serviceOfferMethod_${_serviceOfferMethod.PRVCD}" value="${_serviceOfferMethod.PRVCD}" style="margin-right: 10px;" <c:if test="${_serviceOfferMethod.PRVCD eq goodsInfo.serviceOfferMethod}"> checked="checked" </c:if> disabled>
									<label for="serviceOfferMethod_${_serviceOfferMethod.PRVCD}">${_serviceOfferMethod.PRVNM}</label>    
					            </c:forEach>   							
							</td>
							<td>
								<c:forEach items="${serviceOfferMethod}" var="_serviceOfferMethod" varStatus="status">                    
					            	<input type="radio" name="serviceOfferMethod" id="serviceOfferMethod_${_serviceOfferMethod.PRVCD}" value="${_serviceOfferMethod.PRVCD}" style="margin-right: 10px;" <c:if test="${_serviceOfferMethod.PRVCD eq goodsInfoTmp.serviceOfferMethod}"> checked="checked" </c:if>  disabled>
									<label for="serviceOfferMethod_${_serviceOfferMethod.PRVCD}">${_serviceOfferMethod.PRVNM}</label>    
					            </c:forEach>   							
							
							</td>
						</tr>	
						<tr>
							<th >아키텍쳐</th>
							<td>
				            	<label><input  type="checkbox" id="archtcSe1" name="archtcSe1" value="1" onclick="fnSetArchtcSe('1')" <c:if test="${goodsInfo.archtcSe eq '1' or goodsInfo.archtcSe eq '3'}">checked="checked"</c:if> disabled/> 32-BIT</label>
				            	<label><input type="checkbox" id="archtcSe1" name="archtcSe1" class="space_ml" value="2" onclick="fnSetArchtcSe('2')" <c:if test="${goodsInfo.archtcSe eq '2' or goodsInfo.archtcSe eq '3'}">checked="checked"</c:if>  disabled/> 64-BIT</label>
							</td>
							<td>
				            	<label><input  type="checkbox" id="archtcSe1" name="archtcSe1" value="1" onclick="fnSetArchtcSe('1')" <c:if test="${goodsInfoTmp.archtcSe eq '1' or goodsInfoTmp.archtcSe eq '3'}">checked="checked"</c:if> disabled/> 32-BIT</label>
				            	<label><input type="checkbox" id="archtcSe1" name="archtcSe1" class="space_ml" value="2" onclick="fnSetArchtcSe('2')" <c:if test="${goodsInfoTmp.archtcSe eq '2' or goodsInfoTmp.archtcSe eq '3'}">checked="checked"</c:if>  disabled/> 64-BIT</label>
							</td>
						</tr>
						<tr>
							<th >지원OS</th>
							<td>
			                	<c:forEach var="metaOSnm" items="${goodsMetaList}" varStatus="metaOSnmStatus">
			                		<c:if test="${metaOSnm.groupCd eq '1020'}">
			                			${metaOSnm.indvdlzNm}<c:if test="${metaOSnmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
			                		</c:if>
			                	</c:forEach>							
							</td>
							<td>
			                	<c:forEach var="metaOSnm" items="${goodsMetaListTmp}" varStatus="metaOSnmStatus">
			                		<c:if test="${metaOSnm.groupCd eq '1020'}">
			                			${metaOSnm.indvdlzNm}<c:if test="${metaOSnmStatus.index lt fn:length(goodsMetaListTmp) }">,</c:if>
			                		</c:if>
			                	</c:forEach>							
							</td>
						</tr>
						<tr>
							<th >지원언어</th>
							<td>
				                <c:forEach items="${goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
				                	
				                	<c:set var="checked" value="false"/>
				                	<c:forEach items="${goodsMetaList}" var="_goodsMeta" varStatus="status">
					               		<c:if test="${_goodsMeta.groupCd eq '1019' and _goodsMeta.indvdlzCd eq _goodsMetaLang.metaLangCd}">
					                		<c:set var="checked" value="true"/>
					                	</c:if>
				                	</c:forEach>                	
				                 
				                 	<input name="metaLangs" id="metaLangs${_goodsMetaLang.metaLangCd}" type="checkbox" value="${_goodsMetaLang.metaLangCd}"                    
				                    	<c:if test="${checked eq true}"> checked="checked"</c:if> disabled/> 
				                    <label for="metaLangs${_goodsMetaLang.metaLangCd}">${_goodsMetaLang.metaLangNm}</lablel> 
				                 	
				                 	<span id="metaLangs${_goodsMetaLang.metaLangCd}Nm"></span>
					                 <c:if test="${status.last}">
					                     <input name="metaLangEtc" id="metaLangEtc" type="text" title="지원언어 입력" style="width: 250px;" value="" readonly="readonly" disabled/>
					                 </c:if>
					                 
				                </c:forEach>							
							</td>
							<td>
				                <c:forEach items="${goodsMetaLang}" var="_goodsMetaLang" varStatus="status">
				                	
				                	<c:set var="checked" value="false"/>
				                	<c:forEach items="${goodsMetaListTmp}" var="_goodsMeta" varStatus="status">
					               		<c:if test="${_goodsMeta.groupCd eq '1019' and _goodsMeta.indvdlzCd eq _goodsMetaLang.metaLangCd}">
					                		<c:set var="checked" value="true"/>
					                	</c:if>
				                	</c:forEach>                	
				                 
				                 	<input name="metaLangs" id="metaLangs${_goodsMetaLang.metaLangCd}" type="checkbox" value="${_goodsMetaLang.metaLangCd}"                    
				                    	<c:if test="${checked eq true}"> checked="checked"</c:if> disabled/> 
				                    <label for="metaLangs${_goodsMetaLang.metaLangCd}">${_goodsMetaLang.metaLangNm}</lablel> 
				                 	
				                 	<span id="metaLangs${_goodsMetaLang.metaLangCd}Nm"></span>
					                 <c:if test="${status.last}">
					                     <input name="metaLangEtc" id="metaLangEtc" type="text" title="지원언어 입력" style="width: 250px;" value="" readonly="readonly" disabled/>
					                 </c:if>
					                 
				                </c:forEach>								
							</td>
						</tr>						
						<tr>
							<th >A/S방침</th>
							<td>
				               	<c:forEach var="metaASnm" items="${goodsMetaList}" varStatus="metaASnmStatus">
				               		<c:if test="${metaASnm.groupCd eq '1021'}">
				               			${metaASnm.indvdlzNm}<c:if test="${metaASnmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
				               		</c:if>
				               	</c:forEach>							
							</td>
							<td>
				               	<c:forEach var="metaASnm" items="${goodsMetaListTmp}" varStatus="metaASnmStatus">
				               		<c:if test="${metaASnm.groupCd eq '1021'}">
				               			${metaASnm.indvdlzNm}<c:if test="${metaASnmStatus.index lt fn:length(goodsMetaListTmp) }">,</c:if>
				               		</c:if>
				               	</c:forEach>							
							</td>
						</tr>
						<tr>
							<th>호환성(표준)</th>
							<td>
				               	<c:forEach var="metaStdNm" items="${goodsMetaList}" varStatus="metaStdNmStatus">
				               		<c:if test="${metaStdNm.groupCd eq '2031'}">
				               			${metaStdNm.indvdlzNm}<c:if test="${metaStdNmStatus.index lt fn:length(goodsMetaList) }">,</c:if>
				               		</c:if>
				               	</c:forEach>							
							</td>
							<td>
				               	<c:forEach var="metaStdNm" items="${goodsMetaListTmp}" varStatus="metaStdNmStatus">
				               		<c:if test="${metaStdNm.groupCd eq '2031'}">
				               			${metaStdNm.indvdlzNm}<c:if test="${metaStdNmStatus.index lt fn:length(goodsMetaListTmp) }">,</c:if>
				               		</c:if>
				               	</c:forEach>							
							</td>
						</tr>
						<tr>
							<th >제조사</th>
							<td>${goodsInfo.goodsMakr}</td>
							<td>${goodsInfoTmp.goodsMakr}</td>
						</tr>
						<tr>
							<th >출시일</span></th>
							<td>${goodsInfo.comouDe}</td>
							<td>${goodsInfoTmp.comouDe}</td>							

						</tr>
					</tbody>	
				</table>
			
				<br />
				<h2>2-3. 서비스 인증정보</h2>
				<table class="boardWrite" cellspacing="0" border="0" >
			        <colgroup>
			            <col width="600" />
			            <col width="600" />		            
			        </colgroup>
			        <tbody>
			        <tr>
			        	<th style="text-align:center;">변경전</th>
			        	<th style="text-align:center;">변경후</th>			        	
			        </tr>	
					<tr>
						<td>
							<table class="boardWrite" cellspacing="0" border="0" >
								<colgroup>
									<col width="180" />
									<col width="" />		            
								</colgroup>
								<tbody>
					        	<c:forEach items="${goodsMark}" var="_goodsMark" varStatus="statusSeq">
					            <tr>
					                <th><c:out value='${_goodsMark.MARKNM}'/></th>
		
									<c:choose>
							        <c:when test="${_goodsMark.MARKCD != '1005' and _goodsMark.MARKCD != '1003'}">  <!-- GS인증,나라장터종합쇼핑몰 등록 서비스 외 일반인증 -->	                                
					                <input type="checkbox" style="display:none;" name="goodsMarkCds" value="<c:out value='${_goodsMark.MARKCD}'/>" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>
		           					<td> ${_goodsMark.FILENM}</td>
					                </c:when>
					                <c:when test="${_goodsMark.MARKCD == '1005'}">  <!-- GS인증 -->
					                <td>${goodsInfo.gsCrtfcNo}</td>
					                </c:when>
					                <c:when test="${_goodsMark.MARKCD == '1003'}">  <!-- 나라장터종합쇼핑몰 등록 서비스(GROUP_CD = 2060) -->
					                <td>조달등록번호 : ${goodsInfo.naraCrtfcNo}</td>
					                </c:when>
									</c:choose>
								</tr>  
					        	</c:forEach>
					        	</tbody>
				        	</table>
						</td>
						<td>
							<table class="boardWrite" cellspacing="0" border="0" >
								<colgroup>
									<col width="180" />
									<col width="" />		            
								</colgroup>
								<tbody>
				        	<c:forEach items="${goodsMarkTmp}" var="_goodsMark" varStatus="statusSeq">
				            <tr>
				                <th><c:out value='${_goodsMark.MARKNM}'/></th>
				                			            
								<c:choose>
						        <c:when test="${_goodsMark.MARKCD != '1005' and _goodsMark.MARKCD != '1003'}">  <!-- GS인증,나라장터종합쇼핑몰 등록 서비스 외 일반인증 -->	                                
				                <input type="checkbox" style="display:none;" name="goodsMarkCds" value="<c:out value='${_goodsMark.MARKCD}'/>" <c:if test="${_goodsMark.MARKCD == _goodsMark.GOODSMARKCD}">checked="checked"</c:if>/>
	
								<td>${_goodsMark.FILENM}</td>
				                </c:when>
				                <c:when test="${_goodsMark.MARKCD == '1005'}">  <!-- GS인증 -->
				                <td>${goodsInfoTmp.gsCrtfcNo}</td>
				                </c:when>
				                <c:when test="${_goodsMark.MARKCD == '1003'}">  <!-- 나라장터종합쇼핑몰 등록 서비스(GROUP_CD = 2060) -->
				                <td>조달등록번호 : ${goodsInfoTmp.naraCrtfcNo}</td>
				                </c:when>
				                </c:choose>
							</tr>  
							</c:forEach>
							</tbody>
						</table>
						</td>						
					</tr>			        


					</tbody>	
				</table>
			</div>	
		</div> 
		<br />
		<div id="serviceRegist03">
			<div id="goods_type_SPL">
				<div id="goods_type_SPL" <c:if test="${goodsKndCd eq '1004'}">style="display:none"</c:if>>
				<h2>3-1. 서비스 기술정보</h2>
					<table class="boardWrite" cellspacing="0" border="0" >
				        <colgroup>
				            <col width="200" />
				            <col width="500" />
				            <col width="500" />		            
				        </colgroup>
				        <tbody>	
							<tr>
								<th>서비스 시작 절차</th>
								<td>${specInfo.svcBeginProcss}</td>
								<td>${specInfoTmp.svcBeginProcss}</td>
							</tr>
							<tr>
								<th>서비스 종료 절차</th>
								<td>${specInfo.svcEndProcss}</td>
								<td>${specInfoTmp.svcEndProcss}</td>
							</tr>
							<tr>
								<th>서비스 평가판 제공여부 및 제공기간</th>
								<td>${specInfo.svcEvlSuplyPd}</td>
								<td>${specInfoTmp.svcEvlSuplyPd}</td>
							</tr>
							<tr>
								<th>SLA 적용 여부</th>
								<td>${specInfo.slaApplcAt}</td>
								<td>${specInfoTmp.slaApplcAt}</td>
							</tr>
							<tr>
								<th>서비스 가용성</th>
								<td>${specInfo.svcUseful}</td>
								<td>${specInfoTmp.svcUseful}</td>
							</tr>
							<tr>
								<th>자동 확장 지원 여부</th>
								<td>${specInfo.atmcEstnSportAt}</td>
								<td>${specInfoTmp.atmcEstnSportAt}</td>
							</tr>
							<tr>
								<th>클러스터링 지원 여부</th>
								<td>${specInfo.clusteringSportAt}</td>
								<td>${specInfoTmp.clusteringSportAt}</td>
							</tr>
							<tr>
								<th>셀프서비스 프로비저닝 지원 여부</th>
								<td>${specInfo.sfsrvProvisioningSportAt}</td>
								<td>${specInfoTmp.sfsrvProvisioningSportAt}</td>
							</tr>
							<tr>
								<th>서비스 프로비저닝 시간</th>
								<td>${specInfo.svcProvisioningTime}</td>
								<td>${specInfoTmp.svcProvisioningTime}</td>
							</tr>
							<tr>
								<th>서비스 프로비저닝 해제 시간</th>
								<td>${specInfo.svcProvisioningRelisTime}</td>
								<td>${specInfoTmp.svcProvisioningRelisTime}</td>
							</tr>
						</tbody>
					</table>
					<br />
					<h2>3-2. 서비스 및 데이터 관리 정보</h2>
					<table class="boardWrite" cellspacing="0" border="0" >
				        <colgroup>
				            <col width="200" />
				            <col width="500" />
				            <col width="500" />		            
				        </colgroup>
				        <tbody>
							<tr>
								<th>데이터센터 국내, 외 위치 정보</th>
								<td>${specInfo.dataCnterLcInfo}</td>
								<td>${specInfoTmp.dataCnterLcInfo}</td>
							</tr>
							<tr>
								<th>데이터센터 위치 정보</th>
								<td>${specInfo.dataCnterHbrdLcInfo}</td>
								<td>${specInfoTmp.dataCnterHbrdLcInfo}</td>
							</tr>
							<tr>
								<th>재해복구계획</th>
								<td>${specInfo.dsstrrecovryPlan}</td>
								<td>${specInfoTmp.dsstrrecovryPlan}</td>
							</tr>
							<tr>
								<th>데이터 추출 절차</th>
								<td>${specInfo.dataExtrcProcss}</td>
								<td>${specInfoTmp.dataExtrcProcss}</td>
							</tr>
							<tr>
								<th>미사용 데이터 보호 정책</th>
								<td>${specInfo.unuseDataPrtcPolicy}</td>
								<td>${specInfoTmp.unuseDataPrtcPolicy}</td>
							</tr>
							<tr>
								<th>안전한 데이터 삭제 정책</th>
								<td>${specInfo.safeDataDeletePolicy}</td>
								<td>${specInfoTmp.safeDataDeletePolicy}</td>
							</tr>
							<tr>
								<th>서비스 관리 및 현황 정보 제공</th>
								<td>${specInfo.svcManageSttusInfoSuply}</td>
								<td>${specInfoTmp.svcManageSttusInfoSuply}</td>
							</tr>
							<tr>
								<th>서비스 이용 로그 제공 여부</th>
								<td>${specInfo.svcUseLogSuplyAt}</td>
								<td>${specInfoTmp.svcUseLogSuplyAt}</td>
							</tr>
							<tr>
								<th>장애관리 및 보고 정책</th>
								<td>${specInfo.troblManageReprtPolicy}</td>
								<td>${specInfoTmp.troblManageReprtPolicy}</td>
							</tr>
							<tr>
								<th>API 지원 여부 및 타입</th>
								<td>${specInfo.apiSportAt}</td>
								<td>${specInfoTmp.apiSportAt}</td>
							</tr>
						</tbody>
					</table>
					<br />
					<h2>3-3. 서비스 지원 정보</h2>    
					<table class="boardWrite" cellspacing="0" border="0" >
				        <colgroup>
				            <col width="200" />
				            <col width="500" />
				            <col width="500" />		            
				        </colgroup>
				        <tbody>
	
							<tr>
								<th>사용자 매뉴얼 제공 여부</th>
								<td>${specInfo.userMnlSuplyAt}</td>
								<td>${specInfoTmp.userMnlSuplyAt}</td>
							</tr>
							<tr>
								<th>사용자 매뉴얼 정보 유무 및 설명</th>
								<td>${specInfo.userMnlInfoAt}</td>
								<td>${specInfoTmp.userMnlInfoAt}</td>
							</tr>
							<tr>
								<th>사용자 교육 지원 여부 및 정보</th>
								<td>${specInfo.userEdcSportAt}</td>
								<td>${specInfoTmp.userEdcSportAt}</td>
							</tr>
							<tr>
								<th>방문 교육 지원 여부</th>
								<td>${specInfo.visitEdcSportAt}</td>
								<td>${specInfoTmp.visitEdcSportAt}</td>
							</tr>
							<tr>
								<th>방문 기술 지원 여부</th>
								<td>${specInfo.visitTchnlgySportAt}</td>
								<td>${specInfoTmp.visitTchnlgySportAt}</td>
							</tr>
							<tr>
								<th>방문 외 기술 지원 여부 <br /> (온라인, 이메일, 전화 등)</th>
								<td>${specInfo.visitElseTchnlgySportAt}</td>
								<td>${specInfoTmp.visitElseTchnlgySportAt}</td>
							</tr>
							<tr>
								<th>고객센터 운영 여부  및 운영 시간</th>
								<td>${specInfo.cstmrCnterOperAt}</td>
								<td>${specInfoTmp.cstmrCnterOperAt}</td>
							</tr>
						</tbody>	
					</table>
				</div>
			</div>
			<br />
       		<div id="goods_type_1002" <c:if test="${goodsKndCd ne '1002'}">style="display:none"</c:if>>			
			<h2>3-4. 소프트위여형 서비스(Saas) 관련 규격 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="100" />
		            <col width="100" />
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th rowspan="2" class="rb">서비스 제공 방식</th>
						<th>사용자용 서비스 제공 방식</th>
						<td>${specInfo.sUserSvcSuplyMthd}</td>
						<td>${specInfoTmp.sUserSvcSuplyMthd}</td>
					</tr>
					<tr>
						<th>관리용 서비스 제공 방식</th>
						<td>${specInfo.sManageSvcSuplyMthd}</td>
						<td>${specInfoTmp.sManageSvcSuplyMthd}</td>
					</tr>
					<tr>
						<th rowspan="5" class="rb">서비스 보안 관리</th>
						<th>인프라 제공 방식</th>
						<td>${specInfo.sInfrstrctrSuplyMthd}</td>
						<td>${specInfoTmp.sInfrstrctrSuplyMthd}</td>
					</tr>
					<tr>
						<th>보안 정책 </th>
						<td>${specInfo.sScrtyPolicy}</td>
						<td>${specInfoTmp.sScrtyPolicy}</td>
					</tr>
					<tr>
						<th>데이터 암호화 여부 및 방식</th>
						<td>${specInfo.sDataEncptAtMthd}</td>
						<td>${specInfoTmp.sDataEncptAtMthd}</td>
					</tr>
					<tr>
						<th>백업 및 복구 정책</th>
						<td>${specInfo.sBackupRecovryPolicy}</td>
						<td>${specInfoTmp.sBackupRecovryPolicy}</td>
					</tr>
					<tr>
						<th>사용자 인증 및 보안 보호 정책</th>
						<td>${specInfo.sUserCrtfcScrtyPrtcPolicy}</td>
						<td>${specInfoTmp.sUserCrtfcScrtyPrtcPolicy}</td>
					</tr>
					<tr>
						<th rowspan="4" class="rb">다중 플랫폼<br />(cross platform)</th>
						<th>다중 플랫폼 지원 여부</th>
						<td>${specInfo.sMultiPltfomSportAt}</td>
						<td>${specInfoTmp.sMultiPltfomSportAt}</td>
					</tr>
					<tr>
						<th>지원 운영체계 목록</th>
						<td>${specInfo.sSportOpersysmList}</td>
						<td>${specInfoTmp.sSportOpersysmList}</td>
					</tr>
					<tr>
						<th>지원 웹브라우저 목록</th>
						<td>${specInfo.sSportWbsrList}</td>
						<td>${specInfoTmp.sSportWbsrList}</td>
					</tr>
					<tr>
						<th>지원 모바일 플랫폼 목록</th>
						<td>${specInfo.sSportMobilePltfomList}</td>
						<td>${specInfoTmp.sSportMobilePltfomList}</td>
					</tr>
					<tr>
						<th rowspan="4" class="rb">호환성 정보</th>
						<th>개방형 표준 지원 여부</th>
						<td>${specInfo.sOpenStdSportAt}</td>
						<td>${specInfoTmp.sOpenStdSportAt}</td>
					</tr>
					<tr>
						<th>정부 프레임워크 지원 여부</th>
						<td>${specInfo.sGvrnFrmwrkSportAt}</td>
						<td>${specInfoTmp.sGvrnFrmwrkSportAt}</td>
					</tr>
					<tr>
						<th>오픈소스 SW 호환 여부</th>
						<td>${specInfo.sOpenSourcSwAt}</td>
						<td>${specInfoTmp.sOpenSourcSwAt}</td>
					</tr>
					<tr>
						<th>PaaS-Ta 호환 여부</th>
						<td>${specInfo.sPaastaAt}</td>
						<td>${specInfoTmp.sPaastaAt}</td>
					</tr>
					<tr>
						<th rowspan="7" class="rb">개발지원 정보</th>
						<th>소스 공개 여부</th>
						<td>${specInfo.sSourcOthbcAt}</td>
						<td>${specInfoTmp.sSourcOthbcAt}</td>
					</tr>
					<tr>
						<th>외부 API ACCESS 지원 여부</th>
						<td>${specInfo.sApiAccessSportAt}</td>
						<td>${specInfoTmp.sApiAccessSportAt}</td>
					</tr>
					<tr>
						<th>DB 마이그레이션 지원 여부</th>
						<td>${specInfo.sDbMigrationSportAt}</td>
						<td>${specInfoTmp.sDbMigrationSportAt}</td>
					</tr>
					<tr>
						<th>외부 응용프로그램 통합 지원 여부</th>
						<td>${specInfo.sExtrlApplicationSportAt}</td>
						<td>${specInfoTmp.sExtrlApplicationSportAt}</td>
					</tr>
					<tr>
						<th>Sub-tenancy 지원 여부</th>
						<td>${specInfo.sSubTenancySportAt}</td>
						<td>${specInfoTmp.sSubTenancySportAt}</td>
					</tr>
					<tr>
						<th>커스터마이징 가능 여부</th>
						<td>${specInfo.sCstmzngPosblAt}</td>
						<td>${specInfoTmp.sCstmzngPosblAt}</td>
					</tr>
					<tr>
						<th>개발지원 조건 및 기타 사항</th>
						<td>${specInfo.sDevlopSportEtc}</td>
						<td>${specInfoTmp.sDevlopSportEtc}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<br />
		<div id="goods_type_1001" <c:if test="${goodsKndCd ne '1001'}">style="display:none"</c:if>>			
			<h2>3-4. 플랫폼형 서비스(Paas) 관련 규격 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="100" />
		            <col width="100" />
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th rowspan="2" class="rb">서비스 제공 방식</th>
						<th>Secure 개발</th>
						<td>${specInfo.pSecureDevlop}</td>
						<td>${specInfoTmp.pSecureDevlop}</td>
					</tr>
					<tr>
						<th>Secure design, coding, testing 및 배포</th>
						<td>${specInfo.pSecureDctWdtb}</td>
						<td>${specInfoTmp.pSecureDctWdtb}</td>
					</tr>
					<tr>
						<th rowspan="5" class="rb">아키텍처 계획 수립</th>
						<th>지원 언어</th>
						<td>${specInfo.pSportLang}</td>
						<td>${specInfoTmp.pSportLang}</td>

					</tr>
					<tr>
						<th>지원 플랫폼</th>
						<td>${specInfo.pSportPltfom}</td>
						<td>${specInfoTmp.pSportPltfom}</td>
					</tr>	           
					<tr>
						<th>지원 Container 및 버전</th>
						<td>${specInfo.pSportContainerVer}</td>
						<td>${specInfoTmp.pSportContainerVer}</td>
					</tr>
					<tr>
						<th>지원 데이터 저장소</th>
						<td>${specInfo.pSportDataStorge}</td>
						<td>${specInfoTmp.pSportDataStorge}</td>
					</tr>
					<tr>
						<th>Sub-tenancy 지원 여부</th>
						<td>${specInfo.pSubTenancySportAt}</td>
						<td>${specInfoTmp.pSubTenancySportAt}</td>
					</tr>
					<tr>
						<th rowspan="4" class="rb">다중 플랫폼<br />(cross platform)</th>
						<th>개발자 도구 정보</th>
						<td>${specInfo.pDvlprUntInfo}</td>
						<td>${specInfoTmp.pDvlprUntInfo}</td>
					</tr>
					<tr>
						<th>SDK/API 제공 여부</th>
						<td>${specInfo.pSdkApiSuplyAt}</td>
						<td>${specInfoTmp.pSdkApiSuplyAt}</td>
					</tr>
					<tr>
						<th>테스트 및 디버깅 지원 여부</th>
						<td>${specInfo.pTestDebugingSportAt}</td>
						<td>${specInfoTmp.pTestDebugingSportAt}</td>
					</tr>
					<tr>
						<th>Add-on 서비스 및 마켓플레이스 지원 여부</th>
						<td>${specInfo.pAddonSvcMarkplaceSportAt}</td>
						<td>${specInfoTmp.pAddonSvcMarkplaceSportAt}</td>
					</tr>
					<tr>
						<th rowspan="3" class="rb">배포 및 운영환경</th>
						<th>CI(Continuous Integration) 지원</th>
						<td>${specInfo.pCisportSport}</td>
						<td>${specInfoTmp.pCisportSport}</td>

					</tr>
					<tr>
						<th>로깅/모니터링 지원</th>
						<td>${specInfo.pLogingMntrngSport}</td>
						<td>${specInfoTmp.pLogingMntrngSport}</td>
					</tr>
					<tr>
						<th>Load Balancing 지원</th>
						<td>${specInfo.pLoadBalancingSport}</td>
						<td>${specInfoTmp.pLoadBalancingSport}</td>
					</tr>
				</tbody>
			</table>  
		</div>  
		<br />
		<div id="goods_type_1003" <c:if test="${goodsKndCd ne '1003'}">style="display:none"</c:if>>
			<h2>3-4. 인프라형 서비스(Iaas) 관련 규격 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />
		            <col width="200" />
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th>공개표준지원</th>
						<th>공개표준 지원 및 문서</th>
						<td>${specInfo.iOthbcStdSportDoc}</td>
						<td>${specInfoTmp.iOthbcStdSportDoc}</td>
					</tr>
					<tr>
						<th rowspan="2" class="rb">네트워그와 연결</th>
						<th>서비스에 직접 연결하는 네트워크</th>
						<td>${specInfo.iSvcDirectCnncNtwrk}</td>
						<td>${specInfoTmp.iSvcDirectCnncNtwrk}</td>
					</tr>
					<tr>
						<th>가상 네트워크 지원</th>
						<td>${specInfo.iVirtlNtwrkSport}</td>
						<td>${specInfoTmp.iVirtlNtwrkSport}</td>
					</tr>
					<tr>
						<th rowspan="2" class="rb">접근지원</th>
						<th>동기화 지원 여부</th>
						<td>${specInfo.iSynchrnSportAt}</td>
						<td>${specInfoTmp.iSynchrnSportAt}</td>
					</tr>
					<tr>
						<th>지원 장비 목록</th>
						<td>${specInfo.iSportEqpmnList}</td>
						<td>${specInfoTmp.iSportEqpmnList}</td>

					</tr>
					<tr>
						<th rowspan="6" class="rb">제공 서비스</th>
						<th>서버/컴퓨터 서비스</th>
						<td>${specInfo.iServerComputerSvc}</td>
						<td>${specInfoTmp.iServerComputerSvc}</td>

					</tr>
					<tr>
						<th>스토리지 서비스</th>
						<td>${specInfo.iStrgeSvc}</td>
						<td>${specInfoTmp.iStrgeSvc}</td>

					</tr>
					<tr>
						<th>네트워크 서비스</th>
						<td>${specInfo.iNtwrkSvc}</td>
						<td>${specInfoTmp.iNtwrkSvc}</td>

					</tr>
					<tr>
						<th>보안 서비스</th>
						<td>${specInfo.iScrtySvc}</td>
						<td>${specInfoTmp.iScrtySvc}</td>

					</tr>
					<tr>
						<th>관리 서비스</th>
						<td>${specInfo.iManageSvc}</td>
						<td>${specInfoTmp.iManageSvc}</td>
					</tr>
					<tr>
						<th>기타 서비스</th>
						<td>${specInfo.iEtcSvc}</td>
						<td>${specInfoTmp.iEtcSvc}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<br />
		<div id="goods_type_1004" <c:if test="${goodsKndCd ne '1004'}">style="display:none"</c:if>>
			<h2>3-1. 컨설팅 서비스 (SCS) 관련 규격 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="100" />
		            <col width="100" />			            
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th colspan="2">전문가 구성</th>
						<td>${specInfo.cSpcltyRealm}</td>
						<td>${specInfoTmp.cSpcltyRealm}</td>
					</tr>
					<tr>
						<th rowspan="2" class="rb">컨설팅 주요내용</th>
						<th>도입전반</th>
						<td>${specInfo.cIndcWhole}</td>
						<td>${specInfoTmp.cIndcWhole}</td>
					</tr>
					<tr>
						<th>Setup &amp; Migration</th>
						<td>${specInfo.cSetupMgr}</td>
						<td>${specInfoTmp.cSetupMgr}</td>
					</tr>
					<tr>
						<th rowspan="5" class="rb">핵심기술 및 경험</th>
						<th>보유자격</th>
						<td>${specInfo.cHoldQualf}</td>
						<td>${specInfoTmp.cHoldQualf}</td>
					</tr>
					<tr>
						<th>보유기술</th>
						<td>${specInfo.cHoldTchnlgy}</td>
						<td>${specInfoTmp.cHoldTchnlgy}</td>
					</tr>
					<tr>
						<th>컨설팅 가능 인프라</th>
						<td>${specInfo.cInfrstrctrEtc}</td>
						<td>${specInfoTmp.cInfrstrctrEtc}</td>
					</tr>
					<tr>
						<th>컨설팅 가능 플랫폼</th>
						<td>${specInfo.cPltfomEtc}</td>
						<td>${specInfoTmp.cPltfomEtc}</td>
					</tr>
					<tr>
						<th>프로젝트 경험</th>
						<td>${specInfo.cPrjctExprnc}</td>
						<td>${specInfoTmp.cPrjctExprnc}</td>
					</tr>
					<tr>
						<th colspan="2">컨설팅 영역</th>
						<td>${specInfo.cCnslRelmEtc}</td>
						<td>${specInfoTmp.cCnslRelmEtc}</td>
					</tr>
					<tr>
						<th colspan="2">컨설팅 범위</th>
						<td>${specInfo.cCnslScope}</td>
						<td>${specInfoTmp.cCnslScope}</td>
					</tr>
					<tr>
						<th colspan="2">컨설팅 가능 상세 서비스</th>
						<td>
	            			<c:forEach var="tstCateMgmt" items="${tstCateMgmt}" varStatus="status">
	            				${tstCateMgmt.indvdlzNm}<c:if test="${status.index lt fn:length(tstCateMgmt)}">,</c:if>
	            			</c:forEach>						
						</td>
						<td>
	            			<c:forEach var="tstCateMgmtUpdate" items="${tstCateMgmtUpdate}" varStatus="status">
	            				${tstCateMgmtUpdate.indvdlzNm}<c:if test="${status.index lt fn:length(tstCateMgmtUpdate)}">,</c:if>
	            			</c:forEach>						
						</td>
					</tr>
					<tr>
						<th colspan="2">컨설팅 수행기간</th>
						<td>${specInfo.cExcPdEtc}</td>
						<td>${specInfoTmp.cExcPdEtc}</td>
					</tr>
					<tr>
						<th colspan="2">컨설팅 수행 가능 지역</th>
						<td>${specInfo.cExcArea}</td>
						<td>${specInfoTmp.cExcArea}</td>
					</tr>
					<tr>
						<th colspan="2">사전 컨설팅 가능 여부</th>
						<td>${specInfo.cBeffatCnslAt}</td>
						<td>${specInfoTmp.cBeffatCnslAt}</td>
					</tr>
				</tbody>
			</table>
		</div>

		<br />
		<div id="serviceRegist04">
			<h2>4-1. 제공자 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />			            
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th >회사 설립년도</th>
						<td>${specInfo.cmpnyFondYear} 년</td>
						<td>${specInfoTmp.cmpnyFondYear} 년</td>
					</tr>
					<tr>
						<th >회사 소개</th>
						<td>${specInfo.cmpnyIntrcn}</td>
						<td>${specInfoTmp.cmpnyIntrcn}</td>
					</tr>
					<tr>
						<th >사업 분야</th>
						<td>${specInfo.bsnsRealm }</td>
						<td>${specInfoTmp.bsnsRealm }</td>
					</tr>
					<tr>
						<th >공급 유형</th>
						<td>
			                <c:forEach items="${svcEntrprsSuplyTy}" var="_svcEntrprsSuplyTy" varStatus="status">
			                    <label>
			                    	<input disabled  type="radio" name="svcEntrprsSuplyTy" id="svcEntrprsSuplyTy_${_svcEntrprsSuplyTy.PRVCD}" value="${_svcEntrprsSuplyTy.PRVCD}" style="margin-right: 10px;" <c:if test="${_svcEntrprsSuplyTy.PRVCD eq specInfo.svcEntrprsSuplyTy}"> checked="checked" </c:if>>
			                    	${_svcEntrprsSuplyTy.PRVNM}
			                    </label>    
			                </c:forEach>							
						</td>
						<td>
			                <c:forEach items="${svcEntrprsSuplyTy}" var="_svcEntrprsSuplyTy" varStatus="status">
			                    <label>
			                    	<input disabled type="radio" name="svcEntrprsSuplyTy" id="svcEntrprsSuplyTy_${_svcEntrprsSuplyTy.PRVCD}" value="${_svcEntrprsSuplyTy.PRVCD}" style="margin-right: 10px;" <c:if test="${_svcEntrprsSuplyTy.PRVCD eq specInfoTmp.svcEntrprsSuplyTy}"> checked="checked" </c:if>>
			                    	${_svcEntrprsSuplyTy.PRVNM}
			                    </label>    
			                </c:forEach>							
						
						</td>
					</tr>
					<tr>
						<th >기업구분</th>
						<td>
			                <c:forEach items="${entrprsSe}" var="_entrprsSe" varStatus="status">
			                    <label>
			                    	<input disabled type="radio" name="entrprsSe" id="entrprsSe_${_entrprsSe.PRVCD}" value="${_entrprsSe.PRVCD}" style="margin-right: 10px;" <c:if test="${_entrprsSe.PRVCD eq specInfo.entrprsSe}"> checked="checked" </c:if>>
			                    	${_entrprsSe.PRVNM}
			                    </label>    
			                </c:forEach>	                
						</td>
						<td>
			                <c:forEach items="${entrprsSe}" var="_entrprsSe" varStatus="status">
			                    <label>
			                    	<input disabled type="radio" name="entrprsSe" id="entrprsSe_${_entrprsSe.PRVCD}" value="${_entrprsSe.PRVCD}" style="margin-right: 10px;" <c:if test="${_entrprsSe.PRVCD eq specInfoTmp.entrprsSe}"> checked="checked" </c:if>>
			                    	${_entrprsSe.PRVNM}
			                    </label>    
			                </c:forEach>								
						</td>
					</tr>
				</tbody>
			</table>    
			<br />
			<h2>4-2. 서비스 담당자 정보</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />			            
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th >담당자</th>
						<td>${specInfo.svcChargerNm}</td>
						<td>${specInfoTmp.svcChargerNm}</td>
					</tr>
					<tr>
						<th >담당자 이메일</th>
						<td>${fn:split(specInfo.svcChargerEmail,'@')[0]}<span class="space">@</span>${fn:split(specInfo.svcChargerEmail,'@')[1]}</td>
						<td>${fn:split(specInfoTmp.svcChargerEmail,'@')[0]}<span class="space">@</span>${fn:split(specInfoTmp.svcChargerEmail,'@')[1]}</td>
					</tr>
					<tr>
						<th >담당자 연락처</th>
						<td>
							<select id="svcChargerCttpc" name="svcChargerCttpc" title="국가 선택" style="width:210px;" disabled>
                         			<option value="">국가 선택</option>
                         			<c:forEach items="${nation}" var="list">
                             		<option value="<c:out value='${list.INTRLTELNL}'/>" <c:if test="${specInfo.svcChargerCttpc eq list.INTRLTELNL}">selected="selected"</c:if>}><c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)</option>
                         			</c:forEach>
                     			</select>
                     			${specInfo.svcChargerTelno}
						</td>
						<td>
							<select id="svcChargerCttpc" name="svcChargerCttpc" title="국가 선택" style="width:210px;" disabled >
                         			<option value="">국가 선택</option>
                         			<c:forEach items="${nation}" var="list">
                             		<option value="<c:out value='${list.INTRLTELNL}'/>" <c:if test="${specInfoTmp.svcChargerCttpc eq list.INTRLTELNL}">selected="selected"</c:if>}><c:out value="${list.LANGNATIONNM}" />(<c:out value="${list.INTRLTELNL}" />)</option>
                         			</c:forEach>
                     			</select>	
								${specInfoTmp.svcChargerTelno}
						</td>
					</tr>
					<tr>
						<th >담당자 휴대폰</th>
						<td>${fn:split(specInfo.svcChargerMbtlNum,'-')[0]}-${fn:split(specInfo.svcChargerMbtlNum,'-')[1]}-${fn:split(specInfo.svcChargerMbtlNum,'-')[2]}</td>
						<td>${fn:split(specInfoTmp.svcChargerMbtlNum,'-')[0]}-${fn:split(specInfoTmp.svcChargerMbtlNum,'-')[1]}-${fn:split(specInfoTmp.svcChargerMbtlNum,'-')[2]}</td>
					</tr>
				</tbody>
			</table>
			<br />
			<h2>4-3. 가격표 및 첨부파일</h2>
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="200" />			            
		            <col width="500" />
		            <col width="500" />		            
		        </colgroup>
		        <tbody>
					<tr>
						<th >가격표(업로드)</th>
						<td>${goodsInfo.priceDnFileNm}</td>
						<td>${goodsInfoTmp.priceDnFileNm}</td>
					</tr>
					<tr>
						<th>사용메뉴얼(업로드)</th>
						<td>${goodsInfo.mnlDnFileNm}</td>
						<td>${goodsInfoTmp.mnlDnFileNm}</td>
					</tr>
					<tr>
						<th>기타 첨부파일(최대 5개)</th>
						<td>${goodsInfo.itemDnFileSeq}</td>
						<td>${goodsInfoTmp.itemDnFileSeq}</td>
					</tr>
				</tbody>
			</table>	
		</div>
	</div>
	<br />
	<form name="dataForm" id="dataForm" enctype="multipart/form-data" method="post">
	<input type="hidden" name="updateYn"   id="updateYn"   value="update" />	
	<input type="hidden" name="goodsCode" id="goodsCode" value="${goodsCode}"/>
    <input type="hidden" name="langCode" id="langCode" value="00"/>
	
	<div class="supAdm view register">  
		<div id="serviceRegist01">
			<table class="boardWrite" cellspacing="0" border="0" >
		        <colgroup>
		            <col width="1200" />			            
		        </colgroup>
		        <tbody>
					<tr>
						<th>수정사유</th>
					</tr>
					<tr>
						<td>
							<textarea name="chgItemContent" id="chgItemContent" disabled>${goodsInfoTmp.chgItemContent}</textarea>						
						</td>
					</tr>
					<tr>
						<th>관리자검토의견</th>
					</tr>
					<tr>
						<td>
							<textarea name="cfmItemContent" id="cfmItemContent" onkeyup="javascript:displayBytes(3000,'cfmItemContent');">${goodsInfoTmp.cfmItemContent}</textarea>						
						</td>
					</tr>
				</tbody>
			</table>	
		</div>
	</div>
	</form>
	<br />

	<div class="btnArea rig">    	
		<!-- <a id="btnPrev" class="f_l btns st1" href="#">이전</a> -->

		<c:if test="${gubun eq 'Y'}"> 
			<a href="javascript:;" onclick="jsGoodsInsertAction('${goodsCode}','Y','${exmntConfmHistSn}');"><button class="w_blue" type="button">승인</button></a>
			<c:if test="${tmpCnt ne 0}">
				<a href="javascript:;" onclick="jsGoodsInsertAction('${goodsCode}','N','${exmntConfmHistSn}');"><button class="w_blue" type="button">반려</button></a>
			</c:if>		
		</c:if>        		
		<a href="javascript:;"><button class="w_blue" onclick="parent.$.fn.colorbox.close();" type="button">닫기</button></a>		
		
	</div>
</body>
</html>