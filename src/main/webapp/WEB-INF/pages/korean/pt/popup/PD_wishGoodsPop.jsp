<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.core.utils.Converter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>클라우드스토어 씨앗</title>
    
    <!--공통css--><!-- 
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" type="text/css" href="/resources/cmmnty/default/css/common.css" /> -->
    <link rel="stylesheet" type="text/css" href="/cloud_ver2/new_cloud/css/v3_pop.css" />
     <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript">
     var jsClose = function(){
        parent.$.fn.colorbox.close();
     };
     
     var jsGoPage1 = function(obj)
     {
         $('#tab2').removeClass('on');
         $(obj).addClass('on');
         
         $('#divPage1').show();
         $('#divPage2').hide();
     };
     
     var jsGoPage2 = function(obj)
     {
         $('#tab1').removeClass('on');
         $(obj).addClass('on');
         
         $('#divPage1').hide();
         $('#divPage2').show();
     };
     
     $(document).ready(function () 
     {    	 
    	 <c:if test="${estimateCnt == 0}">    	 
    	 	$('#tab2').hide();
    	 </c:if>
     });

     
	</script>
</head>

 <body class="winPopup">
	<h2>계약대상 선정 <a href="#"  onclick="jsClose();">닫기</a></h2>
	<div>
		<aside>
			<a id="tab1" href="#" class="on" onclick="jsGoPage1(this);">서비스사양</a>						
			<a id="tab2" href="#" class=""   onclick="jsGoPage2(this);" goodsTyCd="${goodsTyCd}">견적요청서</a> <!-- /cloud_ver3/html_web/popup_serviceCompare_SaaS.html -->
		</aside>
	
		<div id="divPage1">
		<table class="tbl_st3" summary="서비스사양">
			<caption>서비스사양</caption>
	    <colgroup>
				<col width="10%">
       	<c:forEach varStatus="status" begin="0" end="${bgGoodsCnt}">
       		<col width="${90/bgGoodsCnt}%">
       	</c:forEach>
	    </colgroup>
	    <thead>
	       <tr>
	         <th scope="row">서비스명</th>
	         <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
	         	<th scope="row">${_bgGoodsList.GOODS_NM}</th>
	         </c:forEach>
	       </tr>
      </thead>
      <tbody>
			<tr>
				<td colspan="${bgGoodsCnt+1}" style="text-align:left;" class="bg_st2"> 기업정보 비교항목</td>
      </tr>
      <tr class="group1">
      	<th scope="col">제공자</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
        	<td>${_bgGoodsList.LANG_STORE_NM }</td>
        </c:forEach>
      </tr> 
      <tr class="group1">
      	<th scope="col">기업구분</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
          	<td>${_bgGoodsList.SMLPZ_CHK }</td>
          </c:forEach>
      </tr> 
      <tr class="group1">
      	<th scope="col">제조사</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
          	<td>${_bgGoodsList.GOODS_MAKR }</td>
          </c:forEach>
      </tr> 
      <tr class="group1">
      	<th scope="col">제조국</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
          	<td>${_bgGoodsList.ORG_PLCE }</td>
          </c:forEach>
      </tr>
      <tr class="group1">
      	<th scope="col">출시일</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
          	<td>${_bgGoodsList.COMOU_DE }</td>
          </c:forEach>   
      </tr>
			<tr>
				<td colspan="${bgGoodsCnt+1}" style="text-align:left;" class="bg_st2"> 서비스단가 비교항목</td>               
      </tr>
      <tr class="group2">
      	<th scope="col">계약단위</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
           <td>
           	<c:forEach items="${_bgGoodsList.GOODS_META_CNTRCT_UNIT}" var="_goodsMetaCntrctUnit" varStatus="statusIdx">
           		${_goodsMetaCntrctUnit}
           	</c:forEach>
           </td>
          </c:forEach>                        
      </tr>
      <tr class="group2">
      	<th scope="col">단가</th>
      	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
          	<td>${_bgGoodsList.GOODS_PC }</td>
          </c:forEach>  
      </tr>
			<tr>
				<td colspan="${bgGoodsCnt+1}" style="text-align:left;" class="bg_st2"> 시스템사양 비교항목</td>
      </tr>
        <tr class="group3">
        	<th scope="col">서비스분류</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_CTGRY}" var="_goodsCtgry" varStatus="statusIdx">
             		${_goodsCtgry}
             	</c:forEach>
             </td>
            </c:forEach>
        </tr>
        <tr class="group3">
        	<th scope="col">서비스관리기준</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_META_SVC}" var="_goodsMetaSvc" varStatus="statusIdx">
             		${_goodsMetaSvc}
             	</c:forEach>
            	</td>
            </c:forEach> 
        </tr>
        <tr class="group3">
        	<th scope="col">호환성</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_META_STD}" var="_goodsMetaStd" varStatus="statusIdx">
             		${_goodsMetaStd}
             	</c:forEach>
             </td>
            </c:forEach>                     
        </tr>
        <tr class="group3">
        	<th scope="col">지원언어</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.LANG_NM}" var="_langNm" varStatus="statusIdx">
             		${_langNm}
             	</c:forEach>
             </td>
            </c:forEach> 
        </tr>
        <tr class="group3">
        	<th scope="col">구축방식</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_META_CNSTC_MTHD}" var="_goodsMetaCnstcMthd" varStatus="statusIdx">
             		${_goodsMetaCnstcMthd}
             	</c:forEach>
             </td>
            </c:forEach>
        </tr>
        <tr class="group3">
        	<th scope="col">서비스유형</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
            	<td>${_bgGoodsList.SERVICE_OFFER_METHOD_NM }</td>
            </c:forEach> 
        </tr>
        <tr class="group3">
        	<th scope="col">아키텍처</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
            	<td>${_bgGoodsList.ARCHTC_SE }</td>
            </c:forEach>
        </tr>
        <tr class="group3">
        	<th scope="col">A/S</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_META_AS}" var="_goodsMetaAs" varStatus="statusIdx">
             		${_goodsMetaAs}
             	</c:forEach>
             </td>
            </c:forEach>
        </tr>
        <tr class="group3">
        	<th scope="col">지원OS</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_META_OS}" var="_goodsMetaOs" varStatus="statusIdx">
             		${_goodsMetaOs}
             	</c:forEach>
             </td>
            </c:forEach>
        </tr>
        <tr class="group3">
        	<th scope="col">인증정보</th>
        	<c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
             <td>
             	<c:forEach items="${_bgGoodsList.GOODS_MARK_LIST}" var="_goodsMarkList" varStatus="statusIdx">
             		${_goodsMarkList}
             	</c:forEach>
             </td>
            </c:forEach>  
        </tr>
			</tbody>
		</table>		
		</div>
		
		<div id="divPage2" style="display:none;">
		<c:choose>
			<c:when test="${goodsTyCd eq 1001}"> <!-- Paas -->
				<table class="tbl_st3" summary="PaaS">
					<caption>PaaS</caption>
			    <colgroup>
						<col width="10%">
           	<c:forEach varStatus="status" begin="0" end="${estimateCnt}">
           		<col width="${80/(estimateCnt * 2)}%">
           		<col width="${80/(estimateCnt * 2)}%">
           	</c:forEach>
			    </colgroup>
			    <tbody>
	           <tr>
	             <th scope="col">서비스명</th>
	             <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
	             	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
	             		<th colspan="2">${_bgGoodsList.GOODS_NM}</th>
	             	</c:if>
	             </c:forEach>
	           </tr>
	           <tr>
	             <th scope="col" colspan="2" class="bg_st2">항목</th>
	             <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
	             	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
	              	<th scope="col" class="bg_st2">요구사항</th>
	              	<th scope="col" class="bg_st2">답변</th>
	              </c:if>
	             </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">호스팅방식</th>
	           		<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.HOSTINGMETHOD_NM}</td>
	              </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">스케일링</th>
	           		<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.SCALING_NM}</td>
	              </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">플랫폼</th>
	           		<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.PLATFORM_NM}</td>
	              </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">런타임</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.RUNTIMES_NM}</td>
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">미들웨어</th>
	           		<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.MIDDLEWARES_NM}</td>
	              </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">프레임워크</th>
	           		<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.FRAMEWORKS_NM}</td>
	              </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">서비스</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.SERVICES_NM}</td>
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th>애드온</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.ADDONS_NM}</td>
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">확장기능여부</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.EXTENDFUNCTION}</td>
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">위치</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	               	<td>${_estimateList.GEOLOCATIONS_NM}</td>
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">희망구매가(원)</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	           	  	<c:if test="${status.index % 2 == 0}">		                		
	               		<td colspan="2" class="comm">
	               		
	               		<c:choose>
	                              <c:when test="${_estimateList.HOPE_PUCH_AMT != null}">
	                                  <fmt:formatNumber value="${_estimateList.HOPE_PUCH_AMT}" pattern="#,###" /> 원
	                              </c:when>
	                              <c:when test="${_estimateList.HOPE_PUCH_AMT == null}">
	                                  0 원
	                              </c:when>
	                          </c:choose>
	                          
	                          </td>
	               	</c:if>	
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">답변완료일</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	           	  	<c:if test="${status.index % 2 == 0}">
	               		<td colspan="2" class="comm">${_estimateList.RPLY_DT}</td>
	               	</c:if>	
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">관련문서</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	           	  	<c:if test="${status.index % 2 == 0}">
	               		<td colspan="2" class="comm">${_estimateList.DELY_FILE}</td>
	               	</c:if>	
	               </c:forEach>
	           </tr>
	           <tr>
	           	<th scope="col">추가문의</th>
	           	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
	           	  	<c:if test="${status.index % 2 == 0}">
	               		<td colspan="2" class="comm">${_estimateList.ADD_CONT}</td>
	               	</c:if>
	               </c:forEach>
	           </tr>
		       </tbody>
				</table>
			
			</c:when>
			
			<c:when test="${goodsTyCd eq 1002}"> <!-- Saas -->
			
				<table class="tbl_st3" summary="SaaS">
					<caption>SaaS</caption>
					<colgroup>
						<col width="10%">
						<col width="10%">
           	<c:forEach varStatus="status" begin="0" end="${estimateCnt}">
           		<col width="${80/(estimateCnt * 2)}%">
           		<col width="${80/(estimateCnt * 2)}%">
           	</c:forEach>
			    </colgroup>
			    <tbody>
		            <tr>
		                 <th scope="col" colspan="2">서비스명</th>
		                 <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
		                 	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
		                 		<th colspan="2">${_bgGoodsList.GOODS_NM}</th>
		                 	</c:if>
		                 </c:forEach>
		            </tr>
		            <tr>
		                 <th scope="col" colspan="2" class="bg_st2">항목</th>
		                 <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
		                 	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
			                 	<th class="bg_st2">요구사항</th>
			                 	<th class="bg_st2">답변</th>
			                 </c:if>
		                 </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" colspan="2">제공방법</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.SUPPORT_METHOD_NM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" colspan="2">사용자/관리자 분리</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.USER_MANAGER_SEPARATE_NM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" colspan="2">서비스제공방식</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.SERVICE_SUPPLY_METHOD_NM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" colspan="2">암호화</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.ENCRYPTION_NM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" colspan="2">다중플랫폼지원</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.MULTIPLATFORM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" rowspan="3">필요<br/>사항</th>
		            	<th scope="col">기능명</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.NEED_FUNCTIONNAME}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col">수량</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.NEED_AMOUNT}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col">단위</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.NEED_UNITCODE_NM}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" rowspan="3">옵션<br/>사항</th>
		            	<th scope="col">기능명</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.OPTION_FUNCTIONNAME}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col">수량</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.OPTION_AMOUNT}</td>
		                </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col">단위</th>
		            	<c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
		                	<td>${_estimateList.OPTION_UNITCODE_NM}</td>
		                </c:forEach>
		            </tr>
		      </tbody>
				</table>
			
			</c:when>
			
			<c:when test="${goodsTyCd eq 1003}"> <!-- Iaas -->			
			
				<table class="tbl_st3" summary="IaaS">
					<caption>IaaS</caption>
			    <colgroup>
						<col width="10%" />
						<col width="10%" />
           	<c:forEach varStatus="status" begin="0" end="${estimateCnt}">
           		<col width="${80/(estimateCnt * 2)}%" />
           		<col width="${80/(estimateCnt * 2)}%" />
           	</c:forEach>
			    </colgroup>
			    <tbody>
		            <tr>
		                 <th scope="col" colspan="2">서비스명</th>
		                 <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
		                 	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
		                 		<th colspan="2">${_bgGoodsList.GOODS_NM}</th>
		                 	</c:if>
		                 </c:forEach>
		            </tr>
		            <tr>
		                 <th scope="col" colspan="2" class="bg_st2">항목</th>
		                 <c:forEach items="${bgGoodsList}" var="_bgGoodsList" varStatus="status">
		                 	<c:if test="${_bgGoodsList.NOTIFY_NUM ne null}">
			                 	<th class="bg_st2">요구사항</th>
			                 	<th class="bg_st2">답변</th>
			                 </c:if>
		                 </c:forEach>
		            </tr>
		            <tr>
		            	<th scope="col" rowspan="12">서버<br/>사항</th>
                        <th scope="col">용도</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_USE}</td>
                        </c:forEach>
                    </tr>
		            <tr>
                        <th scope="col">OS</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_OS}</td>
                        </c:forEach>
                    </tr>
		            <tr>
                        <th scope="col">CPU</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_CPU}</td>
                        </c:forEach>
                    </tr>
		            <tr>
                        <th scope="col">메모리</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_MEMORY}</td>
                        </c:forEach>
                    </tr>
		            <tr>
                        <th scope="col">디스크</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_DISK}</td>
                        </c:forEach>
                    </tr>
		            <tr>
                        <th scope="col">수량</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_QNTY}</td>
                        </c:forEach>
                    </tr>
		            					
                    <tr>
                        <th scope="col">공인IP수량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_IP}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">네트워크 트래픽</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_NETWORK}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">GSLB</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_GSLB}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">로드밸런서</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_LDBL}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">스냅샷</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_SNAP}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">이미지</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SERVER_IMG}</td>
                        </c:forEach>
                    </tr>
                    

                    <tr>
                        <th scope="col" rowspan="10">DB<br/>사항</th>
                        <th>용도</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_USE}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">OS</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_OS}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">CPU</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_CPU}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">메모리</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_MEMORY}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">디스크</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_DISK}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">수량</th>                        
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_QNTY}</td>
                        </c:forEach>
                    </tr>
                                        
                    <tr>                        
                        <th scope="col">공인IP수량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_IP}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">네트워크 트래픽</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_NETWORK}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">추가 디스크</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_ADDDISK}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col">벡업 스토리지</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_BACKSTORG}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">스토리지 저장공간</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_STORG_SPACE}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">스토리지 전송량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.DB_TRANS_VLMN}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">CDN 전송량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.CDN_TRANS_VLMN}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">CDN 예상 요청 수</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.CDN_REQU_CNT}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">웹방화벽 상품유형</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.WEB_GOODS_KIND_NM}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">웹방화벽 처리속도</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.WEB_ACCESS}</td>
                        </c:forEach>
                    </tr>

                    <tr>
                        <th scope="col" colspan="2">모니터링 VM</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.MNTING_VM}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">모니터링 계정 수량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.MNTING_ID_CNT}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">백업 서버수량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.BAKUP_CNT}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">백업 저장용량</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.BAKUP_STORG}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">부가서비스 VPN</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SECTY_VPN}</td>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th scope="col" colspan="2">부가서비스 SSL VPN</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.SECTY_SSLVPN}</td>
                        </c:forEach>
                    </tr>
                    
                    <tr>
                        <th scope="col" colspan="2">기타</th>
                        <c:forEach items="${estimateList}" var="_estimateList" varStatus="status">
                            <td>${_estimateList.ADDED_ETC}</td>
                        </c:forEach>                        
                    </tr>
					</tbody>
				</table>
			
			
			</c:when>
		</c:choose>
				
				
		</div>
		
	</div>
</body>
</html>

