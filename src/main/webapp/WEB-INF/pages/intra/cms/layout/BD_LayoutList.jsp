<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>레이아웃 관리</title>
	<op:jsTag type="spi" items="form" />
    <op:jsTag type="openworks" items="ui, form" />

    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.js" />"></script>
    <script type="text/javascript" src="<c:url value="/resources/intra/cms/js/cms.common.js" />"></script>

    <script type="text/javascript">
    
        $().ready(function(){

        });

        var jsUpdateLayoutForm = function() {
            $("#dataForm").attr("action", "BD_UpdateLayoutForm.do");
            document.dataForm.submit();
        };

        var jsInsertLayoutForm = function() {
            $("#dataForm").attr("action", "BD_InsertLayoutForm.do");
            document.dataForm.submit();
        };

    </script>
</head>

<body>

    <form name="dataForm" id="dataForm" method="get" action="BD_LayoutList.do">
        <input type="hidden" id="layoutCode" name="layoutCode" value="" />
		<input type="hidden" id="domainCd" name="domainCd" value="" />

        <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="120px" />
                <col width="150px" />
                <col width="" />
                <col width="90px" />
                <col width="100px" />
                <col width="100px" />
                <col width="80px" />
            </colgroup>
            <thead>
            <tr>
                <th>사이트명</th>
                <th>레이아웃명</th>
                <th>파일경로</th>
                <th>등록자</th>
                <th>등록일</th>
                <th>미리보기</th>
                <th class="lr_none">삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${dataList}" var="layoutVo" varStatus="status">
                <c:set var="class" value="${status.count % 2 == 1 ? 'even' : 'odd'}" />
            <tr>
                <td>
                    ${layoutVo.domainNm}
                </td>
                <td>
                    <a href="BD_UpdateLayoutForm.do?domainCd=${layoutVo.domainCd}&layoutCode=${layoutVo.layoutCode}">${layoutVo.layoutDesc}</a>
                </td>
                <td class="tx_l">
                    ${layoutVo.filePath}
                </td>
                <td>
                    ${layoutVo.regNm}
                </td>
                <td>
                    ${layoutVo.regDt}
                </td>
                <td>
                    <button type="button" class="s_blue" onclick="jsLayoutPreview('${layoutVo.domainCd}', '${layoutVo.layoutCode}');">미리보기</button>
                </td>
                <td class="lr_none">
                    <button type="button" class="s_blue" onclick="jsLayoutDelete('${layoutVo.domainCd}', '${layoutVo.layoutCode}');">삭제</button>
                </td>
            </tr>
            </c:forEach>
            
            <op:no-data obj="${dataList}" colspan="7"/>
            
            </tbody>
        </table>

        <!-- 버튼 -->
        <div class="btn_r">
            <ul>
                <li><button type="button" class="w_blue" onclick="jsInsertLayoutForm();">신규등록</button></li>
            </ul>
        </div>


    </form>
</body>
</html>