<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!-- 검색 영역 시작 -->

    <ul class="tab">
		<li><a href="#" id="domainCd_2" onclick="jsDomainSel('2');" <c:if test="${ param.domainCd eq 2 }">class="on"</c:if>>한국어</a></li>
		<li><a href="#" id="domainCd_3" onclick="jsDomainSel('3');" <c:if test="${ param.domainCd eq 3 }">class="on"</c:if>>영어</a></li>
		<li><a href="#" id="domainCd_4" onclick="jsDomainSel('4');" <c:if test="${ param.domainCd eq 4 }">class="on"</c:if>>스페인어</a></li>
    </ul>
<!-- 검색 영역 끝 -->