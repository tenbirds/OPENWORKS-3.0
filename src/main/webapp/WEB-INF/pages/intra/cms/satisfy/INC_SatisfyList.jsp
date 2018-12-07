<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

    <script type="text/javascript">
    //<![CDATA

        $().ready(function(){

            $('#startDt').datepicker({dateFormat:"yymmdd"});
            $('#endDt').datepicker({dateFormat:"yymmdd"});

            $(".satisfyView").colorbox({
                title : "만족도평가 상세",
                width : "95%", 
                height:"95%",
                iframe : true
            });
        });

        /** 검색 */
        var jsReloadMenu = function() {

            var startDt = $("#startDt").val();
            var endDt = $("#endDt").val();

            var url = "<c:url value="/intra/cms/satisfy/INC_SatisfyList.do"/>?&startDt=" + startDt;
            url += "&endDt=" + endDt;

            var selectedIndex = tabs.currentIndex();

            tabs.changeUrl(selectedIndex, url);
            tabs.loadTab(selectedIndex);
        };

    //]]>
    </script>

    <form name="dataForm" id="dataForm" method="get" action="INC_SatisfyList.do">

    <div>
        &nbsp;검색기간 : 
        <input type="text" id="startDt" value="${param.startDt}" maxlength="8" /> ~ 
        <input type="text" id="endDt" value="${param.endDt}" maxlength="8" />

        <button type="button" class="gray mar_l5 mar_b5" onclick="jsReloadMenu();">검색</button>
    </div>

    <table class="boardList" width="100%" border="0" cellspacing="0" cellpadding="0">
        <colgroup>
            <col width=""/>
            <col width="80px" />
            <col width="80px" />
            <col />
        </colgroup>    
        <thead>
        <tr>
            <th>항목</th>
            <th>전체점수</th>
            <th class="lr_none">전체참여수</th>
        </tr>
        </thead>
        <tbody id="odd-color">
        <c:forEach items="${dataList}" var="dataVo" varStatus="status">
            <tr>
                <td class="tx_l">
                    <a class="satisfyView" href="<c:url value='/intra/cms/satisfy/PD_SatisfyView.do'/>?domainCd=${dataVo.domainCd}&menuCode=${dataVo.menuCode}&itemNo=${dataVo.itemNo}&startDt=${param.startDt}&endDt=${param.endDt}">
                    <c:choose>
                        <c:when test="${dataVo.itemNo eq '5'}">매우만족(5점)</c:when>
                        <c:when test="${dataVo.itemNo eq '4'}">만족(4점)</c:when>
                        <c:when test="${dataVo.itemNo eq '3'}">보통(3점)</c:when>
                        <c:when test="${dataVo.itemNo eq '2'}">불만족(2점)</c:when>
                        <c:otherwise>매우불만족(1점)</c:otherwise>
                    </c:choose>
                    </a>
                </td>
                <td>
                    ${dataVo.totalPoint}
                </td>
                <td class="lr_none">
                    ${dataVo.totalReplyCnt}
                </td>
            </tr>
        </c:forEach>
        <op:no-data obj="${dataList}" colspan="3"/>

        </tbody>
    </table>

    </form>

