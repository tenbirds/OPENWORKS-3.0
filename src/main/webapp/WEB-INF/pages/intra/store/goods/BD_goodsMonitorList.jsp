<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>서비스 현황</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

    <script type="text/javascript">
        //<CDATA[[

        /*
         * 공통 초기화 기능
         */
        $(document).ready(function() {
            // select 박스 선택 값 설정
            startBlink();
        });
        
        /* 깜박이는 이미지 */
        function doBlink() {
            var blink = $(".blank");
            for (var i=0; i < blink.length; i++)
            blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : ""
            }
		function startBlink(styId) {
		    setInterval("doBlink()",300); //숫자가 낮을수록 속도 빠름
        }
        //]]>
    </script>
</head>
<body>
    <div id="contents">
        <!-- 검색 -->
        <!-- 20150822 buffer overflow 공격 감지로 get -> post 변경 시작 -->
        <form name="dataForm" id="dataForm" method="post" action="BD_goodsMonitorList.do">
        <!-- 20150822 buffer overflow 공격 감지로 get -> post 변경 끝 -->
            <input type="hidden" name="q_excel" id="q_excel" value="" />
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}" />
            <input type="hidden" name="goodsCode" id="goodsCode" value="" />

            <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
            <op:pagerParam title="서비스 전시" />

        <!-- //검색 -->

        <!-- 리스트 -->
<!--         <form name="dataForm2" id="dataForm2" method="post"> -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="30%"/>
                <col width="*%"/>
                <col width="10%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>서비스명</th>
                    <th>모니터 URL</th>
                    <th>서비스 상태</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                    	<td>${index-status.index}</td>
                        <td>
                            <div class="tx_l">
                                ${baseVo.goodsNm}
                            </div>
                        </td>
                       <td class="tx_l">
                      		<a href="${baseVo.goodsMonitorUrl}" target="_blank">${baseVo.goodsMonitorUrl}</a>
                       </td>
                        <td class="tx_c">
                           	<c:if test="${baseVo.goodsServiceState == '200'}">
                           	<span id="sty${index-status.index}" style="color:green;font-size:22px;">●</span> 정상
                           	</c:if>
                           	<c:if test="${baseVo.goodsServiceState != '200'}">
                           	<span id="sty${index-status.index}" class="blank" style="color:red;font-size:22px;">●</span> 이상
                           	</c:if>
                        </td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="4" />
            </tbody>
        </table>

        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->

    </form>
    </div>

    <!-- //컨텐츠영역 -->
</body>
</html>