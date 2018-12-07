<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<script type="text/javascript">
    $(window).load(function () {
          $(".gubun").each(function () {
              var rows = $(".gubun:contains('" + $(this).text() + "')");
              if (rows.length > 1) {
                  rows.eq(0).attr("rowspan", rows.length);
                  rows.not(":eq(0)").remove(); 
              } 
          });
      });

</script>
</head>
<body>
    <table class='boardList' cellspacing='0' border='0' summary='리스트입니다.'>
        <caption class='hidden'> 목록 </caption>
        <colgroup>
            <col width='30%'/>
            <col width='35%'/>
            <col width='35%'/>
        </colgroup>
        <thead id='listHead'>
            <tr>
                <th colspan="2">회원유형</th>
                <th class="lr_none">참여자수</th>
            </tr>
        </thead>
        <tbody id='listBody' class='chartList'>
            <c:if test="${fn:length(dataVo) > 0}">
                <c:forEach items='${dataVo}' var='data' varStatus='idx'>
                    <tr >
                        <td class="gubun"><c:out value='${data.NATION}'/></td>
                        <td><c:out value='${data.USER_TY_CD}'/>명</td>
                        <td class="lr_none"><c:out value='${data.CNT}'/>명</td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(dataVo) == 0}">
                <tr>
                    <td colspan="3" class="lr_none">데이터가 존재하지 않습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>
</body>
</html>