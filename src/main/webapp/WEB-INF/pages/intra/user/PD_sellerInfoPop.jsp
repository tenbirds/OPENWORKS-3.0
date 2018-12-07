<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<op:jsTag type="spi" items="form,colorbox" />
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript">

</script>
</head>
<body>
    <div id="popup" class="popup">
        <fieldset>
            <legend>회원 구분</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="회원 구분정보를 확인하실 수 있습니다.">
                <caption class="hidden">회원 구분</caption>
                <colgroup>
                    <col width="30%" />
                    <col width="70%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>구분</th>
                        <td>${baseVo.userTyCd}</td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <!-- 기본정보 -->
        <h2 class="mar_t20">기본정보</h2>
        <fieldset>
            <legend>기본정보</legend>
            <table class="boardWrite" cellspacing="0" border="0" summary="개인회원를 확인 하실 수 있습니다.">
                <caption class="hidden">기본정보</caption>
                <colgroup>
                    <col width="15%" />
                    <col width="75%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>아이디</th>
                        <td class="tx_blue_s">${baseVo.userId}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${baseVo.userNm}</td>
                    </tr>
                    <tr>
                        <th>전화번호</th>
                        <td>${baseVo.telno}</td>
                    </tr>
                    <tr>
                        <th>휴대전화</th>
                        <td>${baseVo.mbtlnum}</td>
                    </tr>
                    <tr>
                        <th>이메일주소</th>
                        <td>${baseVo.email}</td>
                    </tr>
                    <tr>
                        <th rowspan="2">주소</th>
                        <td>${baseVo.bassAdres}<br />${baseVo.detailAdres}</td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <!-- //기본정보 -->
        <!-- 회사정보 -->
        <h2 class="mar_t20" style="margin-top: 1%;">회사정보</h2>
        <fieldset>
            <legend>회사정보</legend>
            <table class="boardWrite" cellspacing="0" border="0"
                summary="회사정보를 확인 하실 수 있습니다.">
                <caption class="hidden">회사정보 등록</caption>
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>회사명</th>
                        <td>${baseVo.cmpnyNm}</td>
                    </tr>
                    <tr>
                        <th>회사 대표자이름</th>
                        <td>${baseVo.cmpnyRprsntvNm}</td>
                    </tr>
                    <tr>
                        <th>사업자 등록번호</th>
                        <td>${baseVo.bizrno}</td>
                    </tr>
                    <tr>
                        <th>회사 전화번호</th>
                        <td>${baseVo.cmpnyTelno}</td>
                    </tr>
                    <tr>
                        <th>회사 대표전화번호</th>
                        <td>${baseVo.cmpnyReprsntTelno}</td>
                    </tr>
                    <tr>
                        <th>회사 팩스</th>
                        <td>${baseVo.cmpnyFaxnum}</td>
                    </tr>
                    <tr>
                        <th>회사 이메일주소</th>
                        <td>${baseVo.cmpnyEmail}</td>
                    </tr>
                    <tr>
                        <th>회사 URL</th>
                        <td>${baseVo.cmpnyUrl}</td>
                    </tr>
                    <tr>
                        <th rowspan="2">회사 주소</th>
                        <td>${baseVo.cmpnyBassAdres}<br />${baseVo.cmpnyDetailAdres}</td>
                    </tr>
               </tbody>
            </table>
        </fieldset>
        <!-- //회사정보 -->
        <c:if test="${not empty baseVo.userList}">
	        <h2 class="mar_t20">스토어정보</h2>
	        <fieldset>
	            <legend>스토어정보</legend>
	            <table class="boardWrite" cellspacing="0" border="0" summary="스토어정보를 확인 하실 수 있습니다.">
	                <caption class="hidden">스토어정보</caption>
	                <colgroup>
	                    <col width="20%" />
	                    <col width="80%" />
	                </colgroup>
	                <tbody>
	                    <c:forEach items="${baseVo.userList}" var="store">
		                    <tr>
		                        <th>스토어 서비스언어</th>
		                        <td>${store.langNm}</td>
		                    </tr>
		                    <tr>
		                        <th>스토어명</th>
		                        <td>${store.langStoreNm}</td>
		                    </tr>
		                    <tr>
		                        <th>스토어소개</th>
		                        <td>${store.langStoreIntrcn}</td>
		                    </tr>
		                    <tr>
		                        <th>전화번호</th>
		                        <td>${store.reprsntTelno}</td>
		                    </tr>
		                    <tr>
		                        <th>이메일주소</th>
		                        <td>${store.reprsntEmail}</td>
		                    </tr>
		                </c:forEach>
	                </tbody>
	            </table>
	        </fieldset>
	    </c:if>
    </div>
    <p class="tx_c mar_t20">
        <a href="#">
            <button type="button" onclick="parent.$.fn.colorbox.close();" class="blue">확인</button>
        </a>
    </p>
    <!-- //컨텐츠영역 -->
</body>
</html>