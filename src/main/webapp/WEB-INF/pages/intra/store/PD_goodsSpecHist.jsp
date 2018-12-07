<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"			prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" 			prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"	prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"				prefix="fmt"%>

<html>
<head>
    <title>이력관리</title>
    <op:jsTag type="spi" items="form, highlight" />
    <script type="text/javascript">
    </script>
</head>
<body>
    <div class="w_100p">
        <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="8%"/>
                <col width="*"/>
                <col width="15%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="8%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>개요</th>
                    <th>VAT</br>포함여부</th>
                    <th>등록일자</th>
                    <th>등록ID</th>
                    <th>첨부</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${fn:length(dataVo)}"/>
                <c:forEach items="${dataVo}" var="_bean" varStatus="status">
                    <tr>
                        <td>${index - status.index}</td>
                        <td class="tx_l"><c:out value="${fn:substring(_bean.goodsSpec1,0,60)}"/><c:if test="${fn:length(_bean.goodsSpec1) >= 60}">...</c:if> </td>
                        <td><%-- <fmt:formatNumber value="${_bean.goodsSpec2}" pattern="#,##0.00"  /> --%>
                        	<fmt:formatNumber value="${_bean.goodsSpec2}" pattern="#,##0.00" />
                        </td>
                        <td>${_bean.goodsEntrDate}</td>
                        <td>${_bean.userId}</td>
                        <td><a href="/component/file/ND_fileDownload.do?id=${_bean.specExcelFile[0].fileId}" class="downLoad">다운</a></td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${dataVo}" colspan="6" msg="변경된 이력내역이 존재하지 않습니다."/>
            </tbody>
        </table>
        <!-- //리스트 -->
        <div align="center" class="mar_t10">
            <input type="button" class="w80 mar_r10" onclick="parent.$.fn.colorbox.close();" value="확인"></input>
            
        </div>
    </div>
</body>
</html>