<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<h3>시스템 요구조건</h3>
<table class="tbl_st4 mt10">

    <tr>
        <th>호스팅방식</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>                
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd>${pass2.hostingMethodNm}</dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.hostingMethodNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>스케일링</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.scalingNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.scalingNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>플랫폼</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.platformNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.platformNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>런타임</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.runtimesNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.runtimesNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>미들웨어</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.middlewaresNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.middlewaresNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>프레임워크</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.frameworksNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.frameworksNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>서비스</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.servicesNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.servicesNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>애드온</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.addonsNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.addonsNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>확장기능여부</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.extendFunction}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.extendFunction}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
    <tr>
        <th>위치</th>
        <td>
            <dl>
                <c:forEach items="${pass2}" var="pass2" varStatus="status">
                <c:choose>
                    <c:when test="${pass2.consumerYn eq 'Y'}">
                        <dd><i>${pass2.geolocationsNm}</i></dd>
                    </c:when>
                    <c:when test="${pass2.consumerYn eq 'N'}">
                        <dd><i>${pass2.geolocationsNm}&nbsp;</i></dd>
                    </c:when>
                </c:choose>
                </c:forEach>
            </dl>
        </td>
    </tr>
    
</table>

