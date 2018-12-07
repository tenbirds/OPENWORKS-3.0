<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<h3>시스템 요구조건</h3>


        <table class="tbl_st3 mt10">
            <caption></caption>
            <colgroup>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="40%"/>
                <col width="40%"/>
            </colgroup>
            <tbody>
                <tr>
                    <th colspan="3">&nbsp;</th>
                    <th>요구사항</th>
                    <th>답변</th>
                </tr>
                
				<tr>
					<th colspan="3">제공방법</th>
					<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
		        	<c:choose>
		               <c:when test="${sass2I.consumerYn eq 'Y'}">
							<td>${sass2I.supportMethodNm}</td>
		                </c:when>
		                <c:when test="${sass2I.consumerYn eq 'N'}">
							<td><i>${sass2I.supportMethodNm}&nbsp;</i></td>
		               </c:when>
		           	</c:choose>
		           	</c:forEach>
				</tr>           
				<tr>
					<th colspan="3">사용자/관리자분리</th>
					<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
		        	<c:choose>
		               <c:when test="${sass2I.consumerYn eq 'Y'}">
							<td>${sass2I.userManagerSeparateNm}</td>
		               </c:when>
		               <c:when test="${sass2I.consumerYn eq 'N'}">
							<td><i>${sass2I.userManagerSeparateNm}&nbsp;</i></td>
		               </c:when>
		           	</c:choose>
		           	</c:forEach>
				</tr>           
				<tr>
					<th colspan="3">서비스제공방식</th>
					<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
		        	<c:choose>
		               <c:when test="${sass2I.consumerYn eq 'Y'}">
							<td>${sass2I.serviceSupplyMethodNm}</td>
		               </c:when>
		               <c:when test="${sass2I.consumerYn eq 'N'}">
							<td><i>${sass2I.serviceSupplyMethodNm}&nbsp;</i></td>
		               </c:when>
		           	</c:choose>
		           	</c:forEach>
				</tr>           
				<tr>
					<th colspan="3">암호화</th>
					<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
		        	<c:choose>
		               <c:when test="${sass2I.consumerYn eq 'Y'}">
							<td>${sass2I.encryptionNm}</td>
		               </c:when>
		               <c:when test="${sass2I.consumerYn eq 'N'}">
							<td><i>${sass2I.encryptionNm}&nbsp;</i></td>
		               </c:when>
		           	</c:choose>
		           	</c:forEach>
				</tr>           
				<tr>
					<th colspan="3">다중플랫폼지원</th>
					<c:forEach items="${sass2I}" var="sass2I" varStatus="status">
		        	<c:choose>
		               <c:when test="${sass2I.consumerYn eq 'Y'}">
							<td>${sass2I.multiPlatform}</td>
		               </c:when>
		               <c:when test="${sass2I.consumerYn eq 'N'}">
							<td><i>${sass2I.multiPlatform}&nbsp;</i></td>
		               </c:when>
		           	</c:choose>
		           	</c:forEach>
				</tr>              
                      
                <c:forEach items="${sass2Dn_h}" var="sass2Dn_h" varStatus="status_nh">
					<tr>
						<th rowspan="${(sass2Dn_h.saas2DoCnt * 3) + 3 }">필요</th>
						
                        <th colspan="2">기능명</th>
                        <c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status">
                        <c:choose>
                            <c:when test="${sass2Dn.consumerYn eq 'Y' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.functionName}</td>
                            </c:when>
                            <c:when test="${sass2Dn.consumerYn eq 'N' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.functionName}</td>
                            </c:when>
                        </c:choose>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th colspan="2">수량</th>
                        <c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status">
                        <c:choose>
                            <c:when test="${sass2Dn.consumerYn eq 'Y' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.amount}</td>
                            </c:when>
                            <c:when test="${sass2Dn.consumerYn eq 'N' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.amount}</td>
                            </c:when>
                        </c:choose>
                        </c:forEach>
                    </tr>
                    <tr>
                        <th colspan="2">단위</th>
                        <c:forEach items="${sass2Dn}" var="sass2Dn" varStatus="status">
                        <c:choose>
                            <c:when test="${sass2Dn.consumerYn eq 'Y' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.unitCodeNm}</td>
                            </c:when>
                            <c:when test="${sass2Dn.consumerYn eq 'N' and sass2Dn_h.needSeq eq sass2Dn.needSeq}">
                                <td>${sass2Dn.unitCodeNm}</td>
                            </c:when>
                        </c:choose> 
                        </c:forEach>               
                	</tr>   
                	
                	<c:forEach items="${sass2Do_h}" var="sass2Do_h" varStatus="status_oh">
                	<c:if test="${sass2Dn_h.needSeq eq sass2Do_h.needSeq}">
		                <tr> 
							<th rowspan="3">옵션</th>

			                <th>기능명</th>
			                <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">
			                <c:choose>
			                    <c:when test="${sass2Do.consumerYn eq 'Y' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.functionName}</td>
			                    </c:when>
			                    <c:when test="${sass2Do.consumerYn eq 'N' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.functionName}</td>
			                    </c:when>
		                    </c:choose>
		                    </c:forEach>    
		                </tr>
	                    <tr>
		                    <th>수량</th>
		                    <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">
		                    <c:choose>
			                    <c:when test="${sass2Do.consumerYn eq 'Y' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.amount}</td>
			                    </c:when>
			                    <c:when test="${sass2Do.consumerYn eq 'N' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.amount}</td>
			                    </c:when>
		                    </c:choose>
		                    </c:forEach>    
		                </tr>
	                    <tr>    
		                    <th>단위</th>
		                    <c:forEach items="${sass2Do}" var="sass2Do" varStatus="status2">
		                    <c:choose>
			                    <c:when test="${sass2Do.consumerYn eq 'Y' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.unitCodeNm}</td>
			                    </c:when>
			                    <c:when test="${sass2Do.consumerYn eq 'N' and sass2Do.needSeq eq sass2Dn_h.needSeq and sass2Do.optionSeq eq sass2Do_h.optionSeq}">
			                        <td>${sass2Do.unitCodeNm}</td>	                        
			                    </c:when>
		                    </c:choose>
		                    </c:forEach>    
		                </tr>	      
		            </c:if>
		                              
		            </c:forEach>
		            
	            </c:forEach>    
                
            </tbody>
        </table>

