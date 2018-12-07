<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<html>
<head>
<op:jsTag type="spi" items="jquery,ui" />

<script type="text/javascript">
    $().ready(function() {
    	$('button:contains("인쇄")').click(function() {
            alert('중비 중...');
            return;
        });
    });
</script>
</head>
<body>
    <p class="tx_r mar_b10 mar_t10">
       <span class="tx_red">붉은색 텍스트</span>는 <span class="tx_red">미사용 코드</span>입니다.
    </p>
    <!-- 리스트 -->
    <table class="boardList" summary="게시판 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
        	<col width="20%" />
            <col width="20%" />
            <col width="" />
        </colgroup>
        <thead>
            <tr>
            	<th>언어코드[코드번호]</th>
                <th>그룹코드[코드번호]</th>
                <th class="lr_none">개별코드[코드번호]</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${dataList}" var="_grpBean">
                <tr>
                	<td>
                        <c:if test="${_grpBean.grpUseYn == 'Y'}">${_grpBean.langNm} [${_grpBean.langCode}]</c:if>
                        <c:if test="${_grpBean.grpUseYn == 'N'}"><span style="color: red">${_grpBean.langNm} [${_grpBean.langCode}]</span></c:if>
                    </td>
                    <td>
                        <c:if test="${_grpBean.grpUseYn == 'Y'}">${_grpBean.grpNm} [${_grpBean.grpCd}]</c:if>
                        <c:if test="${_grpBean.grpUseYn == 'N'}"><span style="color: red">${_grpBean.grpNm} [${_grpBean.grpCd}]</span></c:if>
                    </td>
                    <td class="lr_none">
                        <c:forEach items="${_grpBean.prvTotalCodeList}" var="_prvBean" varStatus="_stst">
                            <c:if test="${not _stst.first}"> ,</c:if>
                            <c:if test="${_prvBean.useYn == 'Y'}">${_prvBean.prvNm} [${_prvBean.prvCd}]</c:if>
                            <c:if test="${_prvBean.useYn == 'N'}"><span style="color: red">${_prvBean.prvNm} [${_prvBean.prvCd}]</span></c:if>
                        </c:forEach>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <!-- //리스트 -->
    <p class="tx_c mar_t20">
        <!-- <a href="#"><button type="button" class="blue">인쇄</button></a> -->
        <a href="#"><button onclick="parent.$.fn.colorbox.close();" class="blue">닫기</button></a>
    </p>
</body>
</html>