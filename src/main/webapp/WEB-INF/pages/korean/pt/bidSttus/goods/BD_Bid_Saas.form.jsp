<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템 요구조건</h3>
<table class="tbl_st1 e4e">
	<thead>
		<tr>
			<th>단위</th>
			<th>제공용량</th>
			<th>단가</th>
			<th>제공방법</th>
		</tr>
	</thead>
	<tbody>
	    <c:set var="sassIUnitSys" value=""/>
	    <c:forEach items="${sassI}" var="sassI" varStatus="status">
	        <c:choose>
                <c:when test="${sassI.consumerYn eq 'Y'}">
                <c:set var="sassIUnitSys" value="${sassI.unitSys}"/>
					<tr>
						<td><c:if test="${sassI.unitSys ne '1006'}">${sassI.unitSysNm}</c:if><c:if test="${sassI.unitSys eq '1006'}">${sassI.etcUnitSys}</c:if></td>
						<td>${sassI.captySys}&nbsp;</td>
						<td>${sassI.amountSys}&nbsp;</td>
						<td>${sassI.splyMothSysNm}&nbsp;</td>
					</tr>
                </c:when>
                <c:when test="${sassI.consumerYn ne 'Y'}">
					<tr>
						<td>
						    <c:choose>
						        <c:when test="${sassIUnitSys eq '1006'}">
					                <input type="text" name="etcUnitSys" id="etcUnitSys" value="${sassI.etcUnitSys}"/>
					                <input type="hidden" name="unitSys" id="unitSys" value="${sassI.unitSys}"/>
						        </c:when>
						        <c:when test="${sassIUnitSys ne '1006'}">
								    <span class="sel_box">
									<select id="unitSys" name="unitSys" onchange="funUnitSysChange();">
									    <option value="">선택</option>
									    <c:forEach items="${codeList_unitSys}" var="unitSysCode" varStatus="status">
									        <option value="${unitSysCode.prvCd}" <c:if test="${sassI.unitSys == unitSysCode.prvCd}">selected=selected</c:if>>${unitSysCode.prvNm}</option>    
									    </c:forEach>
									</select>
									</span>
									<input type="text" id="etcUnitSys" name="etcUnitSys" style="display:none;" value="${sassI.etcUnitSys}"/>
						        </c:when>
						    </c:choose>
						</td>
						<td><input type="text" name="captySys" id="captySys" value="${sassI.captySys}"/></td>
						<td><input type="text" name="amountSys" id="amountSys" value="${sassI.amountSys}" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
						<td>
						    <span class="sel_box">
							<select id="splyMothSys" name="splyMothSys">
							    <option value="">선택</option>
							    <c:forEach items="${codeList_splyMothSys}" var="splyMothSysCode" varStatus="status">
							        <option value="${splyMothSysCode.prvCd}" <c:if test="${sassI.splyMothSys == splyMothSysCode.prvCd}">selected=selected</c:if>>${splyMothSysCode.prvNm}</option>    
							    </c:forEach>
							</select>
							</span>
						</td>
					</tr>
                </c:when>
            </c:choose>
	    </c:forEach>
	</tbody>
</table>

<table class="tbl_st1 mt20">
	<thead>
		<tr>
			<th>옵션명</th>
			<th>단위</th>
			<th>제공용량</th>
			<th>단가</th>
			<th>설명</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach items="${sassD}" var="sassD" varStatus="status">
	        <c:choose>
                <c:when test="${sassD.consumerYn eq 'Y'}">
					<tr>
						<td>${sassD.optionNm}</td>
						<td>${sassD.unitItem}</td>
						<td>${sassD.captyItem}</td>
						<td>${sassD.amountItem}</td>
						<td>${sassD.cmntItem}</td>
					</tr>
                </c:when>
                <c:when test="${sassD.consumerYn ne 'Y'}">
					<tr>
						<td><input type="text"   name="optionNm" value="${sassD.optionNm}"/></td>
						<td><input type="text" name="unitItem" value="${sassD.unitItem}"/></td>
						<td><input type="text" name="captyItem" value="${sassD.captyItem}"/></td>
						<td><input type="text" name="amountItem" value="${sassD.amountItem}" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
						<td><input type="text" name="cmntItem" value="${sassD.cmntItem}"/></td>
					</tr>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 알림 문구 -->
        <c:if test="${empty sassD}">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td><input type="text" name="optionNm" /></td>
			<td><input type="text" name="unitItem" /></td>
			<td><input type="text" name="captyItem" /></td>
			<td><input type="text" name="amountItem" maxlength="9" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"/></td>
			<td><input type="text" name="cmntItem" /></td>
		</tr>
        </c:if>
	</tbody>
</table>
