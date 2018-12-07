<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${cmsVo.chargerShowYn eq 'Y'}">
    <c:set var="chargerInfo" value="${cmsVo.chargerInfo}" />
    <div class="duty_wrap clear">
        <p>
            [ 담당자 : ${chargerInfo.deptNm} ${chargerInfo.mgrNm} ]
            [ 전화번호 : ${chargerInfo.telNum} ]
        </p>
    </div>
</c:if>