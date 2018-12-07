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
                    <th colspan="3">컨설팅 영역</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">                    
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.cnslRelmNm}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.cnslRelmNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">컨설팅 범위</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.cnslScopeNm}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.cnslScopeNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">컨설팅 수행가능지역</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.excAreaNm}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.excAreaNm}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">도입전반(성능/사용랑)</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.indcWhole}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.indcWhole}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">Setup &amp; Migration</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.setupMgr}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.setupMgr}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">운영</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.oper}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.oper}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">품질보증/테스트</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.qlityTest}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.qlityTest}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">보안</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.scrty}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.scrty}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
                <tr>
                    <th colspan="3">교육</th>
                    <c:forEach items="${scs2}" var="scs2" varStatus="status">
                    <c:choose>                
                        <c:when test="${scs2.consumerYn eq 'Y'}">
                            <td>${scs2.education}</td>
                        </c:when>
                        <c:when test="${scs2.consumerYn eq 'N'}">
                            <td>${scs2.education}</td>
                        </c:when>
                    </c:choose>
                    </c:forEach>
                </tr>
            </tbody>
        </table>


</table>

