<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:forEach items="${mileageGrpItemInfo}" var="dataList" varStatus="status">
	<c:set var="accuType">
		<c:if test="${dataList.accuType eq 'A'}">적립</c:if>
		<c:if test="${dataList.accuType eq 'S'}">차감</c:if>
	</c:set>
	<li class="mar_t5 resultItem">
		구분: <strong>${dataList.mileageItemNm}</strong>,
		타입: <strong>${accuType}</strong>,
		Point: <strong <c:if test="${accuType eq '적립'}">id="iPoint"</c:if>>${dataList.mileagePoint}</strong>점 <br /> 

		적용URI: <input type="text" id="url_${status.count}" name="url" class="w215" value="${dataList.url}" />

		파라미터1: <input type="text" id="param1_${status.count}" name="param1" class="w120" value="${dataList.param1}" maxlength="20" />
		파라미터2: <input type="text" id="param2_${status.count}" name="param2" class="w120" value="${dataList.param2}" maxlength="20" /> <br />

		<span class="tx_blue_s">* 파라미터는 반드시 '<strong>키=값</strong>'으로 입력해주세요. (예: bbsCd=1001)</span>
		<input type="hidden" id="mileageItemCds_${status.count}" name="mileageItemCds" value="${dataList.mileageItemCd}" />
		<c:if test="${!status.last}"><div id="horLine"></div></c:if>
	</li>
</c:forEach>