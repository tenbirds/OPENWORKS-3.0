<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    focusCleanup: true,
    rules: {
    <c:forEach items="${validate.results}" var="validateResult" varStatus="validateResultStatus">
        ${validateResult.fieldName} : {
        <c:forEach items="${validateResult.typeMsgs}" var="typeMsg" varStatus="typeMsgStatus">
            ${typeMsg.validType} :  <c:choose>
                                        <c:when test="${empty typeMsg.validData}">true</c:when>
                                        <c:otherwise>[<c:forEach items="${typeMsg.validData}" var="validData" varStatus="dataStatus">${validData}<c:if test="${not dataStatus.last}">,</c:if></c:forEach>]</c:otherwise>
                                    </c:choose><c:if test="${not typeMsgStatus.last}">,</c:if>
        </c:forEach>
        }<c:if test="${not validateResultStatus.last}">,</c:if>
    </c:forEach>
    },
    messages:{
    <c:forEach items="${validate.results}" var="validateResult" varStatus="validateResultStatus">
        ${validateResult.fieldName} : {
            <c:forEach items="${validateResult.typeMsgs}" var="typeMsg" varStatus="typeMsgStatus">
                ${typeMsg.validType} : "${typeMsg.validMsg}"<c:if test="${not typeMsgStatus.last}">,</c:if>
            </c:forEach>
        }<c:if test="${not validateResultStatus.last}">,</c:if>
    </c:forEach>
   }
