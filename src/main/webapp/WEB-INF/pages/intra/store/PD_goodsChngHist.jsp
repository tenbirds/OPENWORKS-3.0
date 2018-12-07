<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
                <col width="14%"/>
                <col width="14%"/>
                <col width="14%"/>
                <col width="30%"/>
                <col width="20%"/>
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>ID</th>
                    <th>부서</th>
                    <th>담당자명</th>
                    <th>내용</th>
                    <th class="lr_none">변경일자</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${fn:length(dataVo)}"/>
                <c:forEach items="${dataVo}" var="_bean" varStatus="status">
                    <tr>
                        <td>${index - status.index}</td>
                        <td>${_bean.CHANGER_ID}</td>
                        <td>${_bean.DEPTNM}</td>
                        <td>${_bean.USERNM}</td>
                        <td class="tx_l">${_bean.CHANGE_NM}</td>
                        <td class="lr_none tx_l">${_bean.CHANGE_DT}</td>
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