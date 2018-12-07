<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>
<c:if test="${fn:length(iass2Ds_h) > 0}">
	<table class="tbl_st1" summary="시스템 요구조건">
		<caption>시스템 요구조건</caption>
		<colgroup>
			<col width="*"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
		</colgroup>
		<thead>
			<tr>
		  	<th colspan="6" scope="col">서버</th>
		  </tr>
		  <tr>
		    <th scope="row">용도</th>
		    <th scope="row">OS</th>
		    <th scope="row">CPU(Vcore)</th>
		    <th scope="row">메모리(GB)</th>
		    <th scope="row">Disk(GB)</th>
		    <th scope="row">수량(CM)</th>
		  </tr>
		</thead>
		<tfoot hidden="hidden">
			<tr>
		  	<th colspan="6" scope="col">서버</th>
		  </tr>
		</tfoot>
		<tbody>
		<c:forEach items="${iass2Ds}" var="iass2Ds" varStatus="status">
			<c:choose>
		  <c:when test="${iass2Ds.consumerYn eq 'Y'}">
	    <tr>
		    <td>${iass2Ds.serverUse}&nbsp;</td>
		    <td>${iass2Ds.serverOs}&nbsp;</td>
		    <td>${iass2Ds.serverCpu}&nbsp;</td>
		    <td>${iass2Ds.serverMemory}&nbsp;</td>
		    <td>${iass2Ds.serverDisk}&nbsp;</td>
		    <td>${iass2Ds.serverQnty}&nbsp;</td>
	    </tr>
		  </c:when>
	    <c:when test="${iass2Ds.consumerYn eq 'N'}">
	    <tr>
	        <td>
	        	<input type="text" id="serverUse" name="serverUse"    value="${iass2Ds.serverUse}"/>
	        	<label for="serverUse" hidden="hidden">${iass2Ds.serverUse}</label>
	        </td>
	        <td>
	        	<input type="text" id="serverOs" name="serverOs"     value="${iass2Ds.serverOs}"/>
	        	<label for="serverOs" hidden="hidden">${iass2Ds.serverOs}</label>
	        </td>
	        <td>
	        	<input type="text" id="serverCpu" name="serverCpu"    value="${iass2Ds.serverCpu}"/>
	        	<label for="serverCpu" hidden="hidden">${iass2Ds.serverCpu}</label>
	        </td>
	        <td class="num">
	            <div class="unit">
	                <input type="text" id="serverMemory" name="serverMemory" value="${iass2Ds.serverMemory}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	                <label for="serverMemory" hidden="hidden">${iass2Ds.serverMemory}</label>
	            </div>
	        </td>
	        <td class="num">
	            <div class="unit">
	                <input type="text" id="serverDisk" name="serverDisk" value="${iass2Ds.serverDisk}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	                <label for="serverDisk" hidden="hidden">${iass2Ds.serverDisk}</label>
	            </div>
	        </td>
	        <td class="num">
	            <div class="unit">
	                <input type="text" id="serverQnty" name="serverQnty" value="${iass2Ds.serverQnty}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	                <label for="serverQnty" hidden="hidden">${iass2Ds.serverQnty}</label>
	            </div>
	        </td>
	    </tr>
	    </c:when>
	    </c:choose>
		  </c:forEach>
		</tbody>
	</table>
</c:if>

	<table class="tbl_st4" summary="시스템 요구조건">
		<caption>시스템 요구조건</caption>
		<colgroup>
			<col width="*"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
		</colgroup>
    <thead>
      <tr><th colspan="6" scope="row">부가정보(서버)</th></tr>
      <tr>
	      <th scope="row">공인 IP 수량(개)</th>
	      <th scope="row">네트워크 트래픽(GB)</th>
	      <th scope="row">GSLB(개)</th>
	      <th scope="row">로드밸런서(GB)</th>
	      <th scope="row">스냅샷(GB)</th>
	      <th scope="row">이미지(GB)</th>        
      </tr>
    </thead>
    <tfoot hidden="hidden">
      <tr><th colspan="6" scope="row">부가정보(서버)</th></tr>
    </tfoot>
    <tbody>
     <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
     <c:choose>
     <c:when test="${iass2I.consumerYn eq 'Y'}">
     <tr>
	     <td>${iass2I.serverIp}&nbsp;</td>
	     <td>${iass2I.serverNetwork}&nbsp;</td>
	     <td>${iass2I.serverGslb}&nbsp;</td>
	     <td>${iass2I.serverLdbl}&nbsp;</td>
	     <td>${iass2I.serverSnap}&nbsp;</td>
	     <td>${iass2I.serverImg}&nbsp;</td>
     </tr>
     </c:when>
     <c:when test="${iass2I.consumerYn eq 'N'}">
     <tr>
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverIp}" name="serverIp" id="serverIp" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	             <label for="serverIp" hidden="hidden">serverIp</label>
	         </div>    
	     </td>
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverNetwork}" name="serverNetwork" id="serverNetwork" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	             <label for="serverNetwork" hidden="hidden">serverNetwork</label>
	         </div>    
	     </td>    
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverGslb}" name="serverGslb" id="serverGslb" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	             <label for="serverGslb" hidden="hidden">serverGslb</label>
	         </div>    
	     </td>
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverLdbl}" name="serverLdbl" id="serverLdbl" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	             <label for="serverLdbl" hidden="hidden">serverLdbl</label>
	         </div>
	     </td>    
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverSnap}" name="serverSnap" id="serverSnap" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	             <label for="serverSnap" hidden="hidden">serverSnap</label>
	         </div>
	     </td>
	     <td class="num">
	         <div class="unit">
	             <input type="text" class="width50p" value="${iass2I.serverImg}" name="serverImg" id="serverImg" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	             <label for="serverImg" hidden="hidden">serverImg</label>
	         </div>
	     </td>
     </tr>
     </c:when>
     </c:choose>
     </c:forEach>
  	</tbody>
	</table>

<c:if test="${fn:length(iass2Dd_h) > 0}">
	<table class="tbl_st1" summary="시스템 요구조건">
		<caption>시스템 요구조건</caption>
		<colgroup>
			<col width="*"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
			<col width="16%"/>
		</colgroup>
		<thead>
	    <tr>
	    	<th colspan="6" scope="row">DB</th>
	    </tr>
	    <tr>
	      <th scope="row">용도</th>
	      <th scope="row">OS</th>
	      <th scope="row">CPU(Vcore)</th>
	      <th scope="row">메모리(GB)</th>
	      <th scope="row">Disk(GB)</th>
	      <th scope="row">수량(CM)</th>
	    </tr>
	  </thead>
	  <tbody>
    <c:forEach items="${iass2Dd}" var="iass2Dd" varStatus="status">
    <c:choose>
    <c:when test="${iass2Dd.consumerYn eq 'Y'}">
    <tr>
        <td>${iass2Dd.dbUse}&nbsp;</td>
        <td>${iass2Dd.dbOs}&nbsp;</td>
        <td>${iass2Dd.dbCpu}&nbsp;</td>
        <td>${iass2Dd.dbMemory}&nbsp;</td>
        <td>${iass2Dd.dbDisk}&nbsp;</td>
        <td>${iass2Dd.dbQnty}&nbsp;</td>
    </tr>
    </c:when>
    <c:when test="${iass2Dd.consumerYn eq 'N'}">
    <tr>
	    <td>
	    	<input type="text" id="dbUse" name="dbUse"    value="${iass2Dd.dbUse}"/>
	    	<label for="dbUse" hidden="hidden">${iass2Dd.dbUse}</label>
	    </td>
	    <td>
	    	<input type="text" id="dbOs" name="dbOs"     value="${iass2Dd.dbOs}"/>
	    	<label for="dbOs" hidden="hidden">${iass2Dd.dbOs}</label>
	    </td>
	    <td>
	    	<input type="text" name="dbCpu"    value="${iass2Dd.dbCpu}"/>
	    	<label for="dbCpu" hidden="hidden">${iass2Dd.dbCpu}</label>
	    </td>
	    <td class="num">
	        <div class="unit">
	            <input type="text" id="dbMemory" name="dbMemory" value="${iass2Dd.dbMemory}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	            <label for="dbMemory" hidden="hidden">${iass2Dd.dbMemory}</label>
	        </div>    
	    </td>
	    <td class="num">
	        <div class="unit">
	            <input type="text" name="dbDisk" value="${iass2Dd.dbDisk}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	            <label for="dbDisk" hidden="hidden">${iass2Dd.dbDisk}</label>
	        </div>    
	    </td>
	    <td class="num">
	        <div class="unit">
	            <input type="text" name="dbQnty" value="${iass2Dd.dbQnty}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	            <label for="dbQnty" hidden="hidden">${iass2Dd.dbQnty}</label>
	        </div>
	    </td>
    </tr>
    </c:when>
    </c:choose>
    </c:forEach>
		</tbody>
	</table>
	
</c:if>	

	<table class="tbl_st4" summary="부가정보(DB)">
		<caption>부가정보(DB)</caption>
		<colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
		</colgroup>
    <thead>
        <tr><th colspan="4" scope="row">부가정보(DB)</th></tr>
        <tr>
	        <th scope="row">공인 IP 수량(개)</th>
	        <th scope="row">네트워크 트레픽(GB)</th>
	        <th scope="row">추가 디스크(GB)</th>
	        <th scope="row">백업 스토리지(GB)</th>   
        </tr>
    </thead>
    <tfoot hidden="hidden">
        <tr><th colspan="4" scope="row">부가정보(DB)</th></tr>
    </tfoot>
    <tbody>
    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
        <c:choose>
            <c:when test="${iass2I.consumerYn eq 'Y'}">
            <tr>
                <td>${iass2I.dbIp}&nbsp;</td>
                <td>${iass2I.dbNetwork}&nbsp;</td>
                <td>${iass2I.dbAddDisk}&nbsp;</td>
                <td>${iass2I.dbBackStorg}&nbsp;</td>
            </tr>
            </c:when>
            <c:when test="${iass2I.consumerYn eq 'N'}">
            <tr>
                <td class="num">
                    <div class="unit">
                        <input type="text" class="width50p" id="dbIp" name="dbIp" value="${iass2I.dbIp}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
                        <label for="dbIp" hidden="hidden">${iass2I.dbIp}</label>
                    </div>
                </td>
                <td class="num">
                    <div class="unit">
                        <input type="text" class="width50p" id="dbNetwork" name="dbNetwork" value="${iass2I.dbNetwork}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                        <label for="dbNetwork" hidden="hidden">${iass2I.dbNetwork}</label>
                    </div>
                </td>
                <td class="num">
                    <div class="unit">
                        <input type="text" class="width50p" id="dbAddDisk" name="dbAddDisk" value="${iass2I.dbAddDisk}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                        <label for="dbAddDisk" hidden="hidden">${iass2I.dbAddDisk}</label>
                    </div>
                </td>
                <td class="num">
                    <div class="unit">
                        <input type="text" class="width50p" id="dbBackStorg" name="dbBackStorg" value="${iass2I.dbBackStorg}" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                        <label for="dbBackStorg" hidden="hidden">${iass2I.dbBackStorg}</label>
                    </div>
                </td>                                   
            </tr>
            </c:when>
        </c:choose>
    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="스토리지">
		<caption>스토리지</caption>
		<colgroup>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
			<col width="25%"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th colspan="2" scope="row">스토리지</th>
	    </tr>
	    <tr>
	      <th scope="row">저장공간(GB)</th>
	      <th scope="row">전송량(GB)</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
        <tr><th colspan="4" scope="row">부가정보(DB)</th></tr>
    </tfoot>
    <tbody>
    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
    <c:choose>
	    <c:when test="${iass2I.consumerYn eq 'Y'}">
	    <tr>
	      <td>${iass2I.dbStorgSpace}&nbsp;</td>
	      <td>${iass2I.dbTransVlmn}&nbsp;</td>
	    </tr>
	    </c:when>
	    <c:when test="${iass2I.consumerYn eq 'N'}">
	    <tr>
	      <td class="num">
	        <div class="unit">
	            <input type="text" class="width50p" id="dbStorgSpace" name="dbStorgSpace" value="${iass2I.dbStorgSpace}" id="dbStorgSpace" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	            <label for="dbStorgSpace" hidden="hidden">${iass2I.dbStorgSpace}</label>
	        </div>
	      </td>
	      <td class="num">
	        <div class="unit">
	            <input type="text" class="width50p" id="dbTransVlmn" name="dbTransVlmn" value="${iass2I.dbTransVlmn}" id="dbTransVlmn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	            <label for="dbTransVlmn" hidden="hidden">${iass2I.dbTransVlmn}</label>
	        </div>
	      </td>
	    </tr>
	    </c:when>
    </c:choose>
    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="CDN">
		<caption>CDN</caption>
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th colspan="2" scope="row">CDN</th>
	    </tr>
	    <tr>              
	      <th scope="row">전송량(GB)</th>
	      <th scope="row">예상 요청 수(건)</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">CDN</th></tr>
    </tfoot>
    <tbody>
	    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
      <c:choose>
      <c:when test="${iass2I.consumerYn eq 'Y'}">
      <tr>
	      <td>${iass2I.cdnTransVlmn}&nbsp;</td>
	      <td>${iass2I.cdnRequCnt}&nbsp;</td>
      </tr>
      </c:when>
      <c:when test="${iass2I.consumerYn eq 'N'}">
      <tr>
	      <td class="num">
	          <div class="unit">
	              <input type="text" class="width50p" name="cdnTransVlmn" value="${iass2I.cdnTransVlmn}" id="cdnTransVlmn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	              <label for="cdnTransVlmn" hidden="hidden">${iass2I.cdnTransVlmn}</label>
	          </div>    
	      </td>
	      <td class="num">
	          <div class="unit">
	              <input type="text" class="width50p" name="cdnRequCnt" value="${iass2I.cdnRequCnt}" id="cdnRequCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	              <label for="cdnRequCnt" hidden="hidden">${iass2I.cdnRequCnt}</label>
	          </div>
	      </td>                                   
      </tr>
      </c:when>
      </c:choose>
	    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="웹방화벽">
		<caption>웹방화벽</caption>
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th colspan="2" scope="row">웹방화벽</th>
	    </tr>
	    <tr>              
	      <th class="sepa" scope="row">서비스유형</th>
	      <th scope="row">처리속도(Mbps)</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">웹방화벽</th></tr>
    </tfoot>

    <tbody>
    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
    <c:choose>
    <c:when test="${iass2I.consumerYn eq 'Y'}">
    <tr>
        <td>${iass2I.webGoodsKindNm}&nbsp;</td>
        <td>${iass2I.webAccess}&nbsp;</td>                                  
    </tr>
    </c:when>
    <c:when test="${iass2I.consumerYn eq 'N'}">
    <tr>
        <td>
            <!-- 2074 -->
            <span id="spanWebGoodsKind" class="sel_box">
                <select id="webGoodsKind" name="webGoodsKind">
                    <option value="">선택</option>
                    <!-- 2074 -->
                    <c:forEach items="${webGoodsKindList}" var="webGoodsKind" varStatus="status">
                        <option value="${webGoodsKind.PRVCD}">${webGoodsKind.PRVNM}</option>    
                    </c:forEach>
                </select>
                <label for="webGoodsKind" hidden="hidden">webGoodsKind</label>
            </span>
        </td>
        <td class="num">
            <div class="unit">
                <input type="text" class="width50p" name="webAccess" value="${iass2I.webAccess}" id="webAccess" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                <label for="webAccess" hidden="hidden">webAccess</label>
            </div>
        </td>
    </tr>
    </c:when>
    </c:choose>
    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="모니터링">
		<caption>모니터링</caption>
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th colspan="2" scope="row">모니터링</th>
	    </tr>
	    <tr>              
	      <th class="sepa" scope="row">VM(GB)</th>
	      <th scope="row">계정 수량(개)</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">모니터링</th></tr>
    </tfoot>
    <tbody>
	    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
      <c:choose>
       <c:when test="${iass2I.consumerYn eq 'Y'}">
       <tr>
           <td>${iass2I.mntingVm}&nbsp;</td>
           <td>${iass2I.mntingIdCnt}&nbsp;</td>
       </tr>
       </c:when>
       <c:when test="${iass2I.consumerYn eq 'N'}">
       <tr>
           <td class="num">
               <div class="unit"> 
                   <input type="text" class="width50p" name="mntingVm" value="${iass2I.mntingVm}" id="mntingVm" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                   <label for="mntingVm" hidden="hidden">mntingVm</label>
               </div>
           </td>
           <td class="num">
               <div class="unit">
                   <input type="text" class="width50p" name="mntingIdCnt" value="${iass2I.mntingIdCnt}" id="mntingIdCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
                   <label for="mntingIdCnt" hidden="hidden">mntingIdCnt</label>
               </div>
           </td>                                   
       </tr>
       </c:when>
      </c:choose>
	    </c:forEach>
    </tbody>
	</table>


	<table class="tbl_st1" summary="백업">
		<caption>백업</caption>
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
    <thead>
    	<tr>
      	<th colspan="2" scope="row">백업</th>
      </tr>
      <tr>                               
      	<th scope="row">백업서버 수량(개)</th>
        <th scope="row">저장용량(GB)</th>
      </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">백업</th></tr>
    </tfoot>
    <tbody>
	    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
      <c:choose>
	      <c:when test="${iass2I.consumerYn eq 'Y'}">
	      <tr>
	          <td>${iass2I.bakupCnt}&nbsp;</td>
	          <td>${iass2I.bakupStorg}&nbsp;</td>
	      </tr>
	      </c:when>
	      <c:when test="${iass2I.consumerYn eq 'N'}">
	      <tr>
	          <td class="num">
	              <div class="unit">
	                  <input type="text" class="width50p" name="bakupCnt" value="${iass2I.bakupCnt}" id="bakupCnt" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
	                  <label for="bakupCnt" hidden="hidden">bakupCnt</label>
	              </div>
	          </td>
	          <td class="num">
	              <div class="unit">
	                  <input type="text" class="width50p" name="bakupStorg" value="${iass2I.bakupStorg}" id="bakupStorg" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
	                  <label for="bakupStorg" hidden="hidden">bakupStorg</label>
	              </div>
	          </td>                                   
	      </tr>
	      </c:when>
      </c:choose>
	    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="부가서비스_보안관리">
		<caption>부가서비스_보안관리</caption>
		<colgroup>
			<col width="50%"/>
			<col width="50%"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th colspan="2" scope="row">부가서비스_보안관리</th>
	    </tr>
	    <tr>                                   
	      <th class="sepa" scope="row">VPN(Mbps)</th>
	      <th scope="row">SSL VPN(Users)</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">백업</th></tr>
    </tfoot>

    <tbody>
	    <c:forEach items="${iass2I}" var="iass2I" varStatus="status">
      <c:choose>
          <c:when test="${iass2I.consumerYn eq 'Y'}">
          <tr>
              <td>${iass2I.sectyVpn}&nbsp;</td>
              <td>${iass2I.sectySslvpn}&nbsp;</td>
          </tr>
          </c:when>
          <c:when test="${iass2I.consumerYn eq 'N'}">
          <tr>
              <td class="num">
                  <div class="unit">
                      <input type="text" class="width50p" name="sectyVpn" value="${iass2I.sectyVpn}" id="sectyVpn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'float');" onblur="return nr_num(this,'float');" />
                      <label for="sectyVpn" hidden="hidden">sectyVpn</label>
                  </div>    
              </td>
              <td class="num">
                  <div class="unit">
                      <input type="text" class="width50p" name="sectySslvpn" value="${iass2I.sectySslvpn}" id="sectySslvpn" maxlength="9" style="ime-mode:disabled" onkeyup="return nr_num(this,'int');" onblur="return nr_num(this,'int');" />
                      <label for="sectySslvpn" hidden="hidden">sectySslvpn</label>
                  </div>
              </td>                                   
          </tr>
          </c:when>
      </c:choose>
	    </c:forEach>
    </tbody>
	</table>

	<table class="tbl_st1" summary="부가서비스_기타">
		<caption>부가서비스_기타</caption>
		<colgroup>
			<col width="10%"/>
			<col width="*"/>
		</colgroup>
    <thead>
	    <tr>
	    	<th scope="row">부가서비스_기타</th>
	    </tr>
    </thead>
    <tfoot hidden="hidden">
    	<tr><th colspan="2" scope="row">백업</th></tr>
    </tfoot>

    <tbody>
			<c:forEach items="${iass2I}" var="iass2I" varStatus="status">
			<c:choose>
			<c:when test="${iass2I.consumerYn eq 'Y'}">
			<tr>
			    <td>${iass2I.addedEtc}&nbsp;</td>
			</tr>
			</c:when>
			<c:when test="${iass2I.consumerYn eq 'N'}">
			<tr>
			    <td>
			    	<input type="text" name="bakupCnt"  id="bakupCnt" value="${iass2I.addedEtc}"/>
			    	<label for="bakupCnt" hidden="hidden">bakupCnt</label>
			    </td>                                 
			</tr>
			</c:when>
			</c:choose>
			</c:forEach>
    </tbody>
	</table>

