<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<h3>시스템요구</h3>
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
		<tr>
			<td>
			    <span class="sel_box">
				<select id="unitSys" name="unitSys" onchange="funUnitSysChange();">
				    <option value="">선택</option>
				    <c:forEach items="${totUnitCodeList}" var="totUnitCode" varStatus="status">
				        <option value="${totUnitCode.PRVCD}" <c:if test="${sassI[0].unitSys == totUnitCode.PRVCD}">selected=selected</c:if>>${totUnitCode.PRVNM}</option>    
				    </c:forEach>
				</select>
				</span>
				<input type="text" id="etcUnitSys" name="etcUnitSys" style="display:none;" value="${sassI[0].etcUnitSys}"/>
			</td>
			<td><input type="text" id="captySys" name="captySys" value="${sassI[0].captySys}"/></td>
			<td><input type="text" id="amountSys" name="amountSys" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  value="${sassI[0].amountSys}"/></td> <!-- 단가(숫자만 입력) -->
			<td>
			    <span class="sel_box">
				<select id="splyMothSys" name="splyMothSys">
				    <option value="">선택</option>
				    <c:forEach items="${supplyMethodCodeList}" var="supplyMethodCode" varStatus="status">
				        <option value="${supplyMethodCode.PRVCD}" <c:if test="${sassI[0].splyMothSys == supplyMethodCode.PRVCD}">selected=selected</c:if> >${supplyMethodCode.PRVNM}</option>    
				    </c:forEach>
				</select>
				</span>
			</td>
		</tr>
		<tr>
		</tr>
	</tbody>
</table>
<table id="saasFromTab" class="tbl_st1 mt20">
	<thead>
		<tr>
			<th>옵션명</th>
			<th>단위</th>
			<th>제공용량</th>
			<th>단가</th>
			<th colspan="2">제공방법</th>
		</tr>
	</thead>
	<tbody>
	    <c:forEach items="${sassD}" var="sassD" varStatus="i">
	        <c:choose>
                <c:when test="${sassD.consumerYn eq 'Y'}">
	                <c:choose>
                        <c:when test="${i.index eq 0}">
		<tr>
			<td><input type="text" name="optionNm" value="${sassD.optionNm}"/></td>
			<td><input type="text" name="unitItem" value="${sassD.unitItem}"/></td>
			<td><input type="text" name="captyItem" value="${sassD.captyItem}"/></td>
			<td><input type="text" name="amountItem" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" value="${sassD.amountItem}"/></td>
			<td><input type="text" name="cmntItem" value="${sassD.cmntItem}"/></td>
			<td><a href="#" onclick="jsSaasAddRow(); return false;" class="btns st3">행추가</a></td>
		</tr>
                        </c:when>
                        <c:when test="${i.index > 0}">

        <tbody>
		    <tr>
			    <td><input type="text" name="optionNm" value="${sassD.optionNm}"/></td>
			    <td><input type="text" name="unitItem" value="${sassD.unitItem}"/></td>
			    <td><input type="text" name="captyItem" value="${sassD.captyItem}"/></td>
			    <td><input type="text" name="amountItem" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)"  value="${sassD.amountItem}"/></td>
			    <td><input type="text" name="cmntItem" value="${sassD.cmntItem}"/></td>
			    <td><a href="#" onclick="jsSaasDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
		    </tr>	
	    </tbody>

                        </c:when>
                    </c:choose>
                </c:when>
            </c:choose>
	    </c:forEach>
        <!-- 데이터가 없을 때 기본 한줄 표기 -->
        <c:if test="${empty sassD}">
		<tr>
			<td><input type="text" name="optionNm" /></td>
			<td><input type="text" name="unitItem" /></td>
			<td><input type="text" name="captyItem" /></td>
			<td><input type="text" name="amountItem" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></td>
			<td><input type="text" name="cmntItem" /></td>
			<td><a href="#" onclick="jsSaasAddRow(); return false;" class="btns st3">행추가</a></td>
		</tr>
        </c:if>
	</tbody>
</table>
<textarea id="sassAddRow" style="display:none">
    <tbody>
		<tr>
			<td><input type="text" name="optionNm" /></td>
			<td><input type="text" name="unitItem" /></td>
			<td><input type="text" name="captyItem" /></td>
			<td><input type="text" name="amountItem" maxlength="9" style="ime-mode:disabled" onkeydown="return jsOnlyNumber(event);" onkeyup="removeChar(event)" /></td>
			<td><input type="text" name="cmntItem" /></td>
			<td><a href="#" onclick="jsSaasDeleteRow(this); return false;" class="btns st2">행삭제</a></td>
		</tr>	
	</tbody>
</textarea>
