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
                    <th colspan="3">호스팅방식</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>                
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.hostingMethodNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.hostingMethodNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">스케일링</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.scalingNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.scalingNm}&nbsp;</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">플랫폼</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.platformNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.platformNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">런타임</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.runtimesNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.runtimesNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">미들웨어</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.middlewaresNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.middlewaresNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">프레임워크</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.frameworksNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.frameworksNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">서비스</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.servicesNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.servicesNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">애드온</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.addonsNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.addonsNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">확장기능여부</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.extendFunction}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.extendFunction}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">위치</th>
                    <c:forEach items="${pass2}" var="pass2" varStatus="status">
                    <c:choose>
                        <c:when test="${pass2.consumerYn eq 'Y'}">
                            <td>${pass2.geolocationsNm}</td>
                        </c:when>
                        <c:when test="${pass2.consumerYn eq 'N'}">
                            <td>${pass2.geolocationsNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
            </tbody>
        </table>


</table>

