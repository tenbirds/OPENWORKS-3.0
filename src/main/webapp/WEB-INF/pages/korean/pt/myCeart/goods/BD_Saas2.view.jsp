<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구사항</h3>
<table class="tbl_st1" summary="시스템 요구사항 정보" >
	<caption>시스템 요구사항</caption>
	<colgroup>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
		<col width="20%"/>
	</colgroup>
	<thead>
		<tr>
			<th>제공방법</th>
			<th>사용자/관리자분리</th>
			<th>서비스제공방식</th>
			<th>암호화</th>
			<th>다중플랫폼지원</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
  	<c:choose>
    	<c:when test="${sass2I.consumerYn eq 'Y'}">
			<tr>
				<td>${sass2I.supportMethodNm}</td>
				<td>${sass2I.userManagerSeparateNm}</td>
				<td>${sass2I.serviceSupplyMethodNm}</td>
				<td>${sass2I.encryptionNm}</td>
				<td>
					<c:if test="${sass2I.multiPlatform eq 'Y'}">
						지원
					</c:if>
					<c:if test="${sass2I.multiPlatform ne 'Y'}">
						해당없음
					</c:if>
				</td>
			</tr>
      </c:when>
      <c:when test="${sass2I.consumerYn eq 'N'}">
			<tr>
				<td><i>${sass2I.supportMethodNm}&nbsp;</i></td>
				<td><i>${sass2I.userManagerSeparateNm}&nbsp;</i></td>
				<td><i>${sass2I.serviceSupplyMethodNm}&nbsp;</i></td>
				<td><i>${sass2I.encryptionNm}&nbsp;</i></td>
				<td><i>${sass2I.multiPlatform}&nbsp;</i></td>
			</tr>
			</c:when>
    </c:choose>
  </c:forEach>
	</tbody>
</table>


<c:if test="${fn:length(sass2Dn_h) > 0}">
	
	<table class="tbl_st8 mt20">
		<thead>
			<tr>
				<th>기능명(필요)</th>
				<th>수량</th>
				<th>단위</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${sass2Dn_h}" var="sass2Dn_h" varStatus="status_nh">
		    	<c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status">
					<c:choose>
						<c:when test="${sass2Dn_h.needSeq eq sass2Dn.needSeq and sass2Dn.consumerYn eq 'Y'}">
							<tr class="sass_dn_tr_up"> 
								<td>${sass2Dn.functionName}</td>
								<td>${sass2Dn.amount}</td>
								<td>${sass2Dn.unitCodeNm}</td>
							</tr>
			        	</c:when>
			            <c:when test="${sass2Dn_h.needSeq eq sass2Dn.needSeq and sass2Dn.consumerYn eq 'N'}">
							<tr class="sass_dn_tr_down">
								<td><i>${sass2Dn.functionName}&nbsp;</i></td>
								<td><i>${sass2Dn.amount}&nbsp;</i></td>
								<td><i>${sass2Dn.unitCodeNm}&nbsp;</i></td>
							</tr>
			            </c:when>
			        </c:choose>
		        </c:forEach>	          
				
				<c:set var="countSassH2Do" value="0" />
				<c:forEach items="${sass2Do_h}" var="sass2Do_h" varStatus="status_oh">
					<c:if test="${sass2Do_h.needSeq eq sass2Dn_h.needSeq}"> <!--  필요사항아래 옵션사항이 존재하는지 확인 한다. -->
						<c:set var="countSassH2Do" value="${countSassH2Do + 1}" />
					</c:if>
				</c:forEach>
				
				<c:if test="${countSassH2Do gt 0}">
		            <tr class="sass_do_tr">
						<td colspan="3">
			               	<table class="tbl_st8 mt20" style="border: 1px solid #ddd; width:98%; margin: auto; float: right;">
			               	<thead>
				                <tr>
									<th>기능명(옵션)</th>
									<th>수량</th>
									<th>단위</th>
								</tr>
							</thead>
							<tbody>
							
								<c:forEach items="${sass2Do_h}" var="sass2Do_h" varStatus="status_oh">
								<c:if test="${sass2Dn_h.needSeq eq sass2Do_h.needSeq}">
					                <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">
							        <c:choose>
						                <c:when test="${sass2Do.needSeq eq sass2Do_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq and sass2Do.consumerYn eq 'Y'}">
											<tr class="sass_do_tr_up"> 
												<td>${sass2Do.functionName}</td>
												<td>${sass2Do.amount}</td>
												<td>${sass2Do.unitCodeNm}</td>
											</tr>
						                </c:when>
						                <c:when test="${sass2Do.needSeq eq sass2Do_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq and sass2Do.consumerYn eq 'N'}">
											<tr class="sass_do_tr_down">
												<td><i>${sass2Do.functionName}&nbsp;</i></td>
												<td><i>${sass2Do.amount}&nbsp;</i></td>
												<td><i>${sass2Do.unitCodeNm}&nbsp;</i></td>
											</tr>
						                </c:when>
						            </c:choose>
							    	</c:forEach>
							    </c:if>
							    </c:forEach>	
					    	
					    	</tbody>
					    	</table>
				    	</td>
			    	</tr>
		    	</c:if>
		            
		           
		    </c:forEach>
		</tbody>
	</table>

</c:if>
