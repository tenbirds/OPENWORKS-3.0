<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>

<html>
<head>
    <title>변경 이력 보기</title>
    <op:jsTag type="spi" items="form, validate,colorbox,highlight,ui" />
    <op:jsTag type="openworks" items="ui"/>
    <script type="text/javascript">
    <!--
    $().ready(function () {
        $.datepicker.setDefaults({dateFormat: 'yy-mm-dd'});

        $('#q_startDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });
        $('#q_endDt').datepicker({
            showOn : 'button',
            defaultDate : null,
            buttonImage : '<c:url value="/resources/openworks/theme/default/images/icon/icon_cal.gif" />',
            buttonImageOnly : true
        });

    });

    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action= "PD_historyPop.do";
        document.dataForm.submit();
    };
    var jsSearch = function(){
        if($("#q_startDt").val().length == 10){
            $("#q_startDt").val($("#q_startDt").val().replace(/-/gi,""));
        };
        if($("#q_endDt").val().length == 10){
            $("#q_endDt").val($("#q_endDt").val().replace(/-/gi,""));
        };

        document.dataForm.action = "PD_historyPop.do";
        document.dataForm.elements["q_currPage"].value = "1";
        document.dataForm.submit();
    };



    //-->
    </script>
</head>
<body>
<div id="popup1">
<form name="dataForm" id="dataForm" method="post" action="PD_historyPop.do">
<input type="hidden" name="mileageCdLog" id="mileageCdLog" value="${param.mileageCdLog }"/>
<!-- 검색 -->
    <div class="search">
        <fieldset>
            <label>변경 일자 :</label>
            <input class="w120" type="text" value="${param.q_startDt }" name="q_startDt" id="q_startDt" title="날짜선택" /> ~ <input class="w120" type="text" value="${param.q_endDt }" name="q_endDt" id="q_endDt" title="날짜선택"/>
            <button class="s_blue mar_l5 mar_b5" type="button" onclick="jsSearch();">검색</button>
        </fieldset>
    </div>
    <op:pagerParam title="마일리지 변경 로그 목록" />
    <!-- //검색 -->
</form>

    <table class="boardList" cellspacing="0" border="0" summary="게시판 리스트입니다.">
    <caption class="hidden"> 목록 </caption>
    <colgroup>
        <col width="5%"/>
        <col width="15%"/>
        <col width=""/>
        <col width="12%"/>
        <col width="15%"/>
    </colgroup>
    <thead>
        <tr>
            <th>번호</th>
            <th>구 분</th>
            <th>변경 내용</th>
            <th>수정자</th>
            <th class="lr_none">변경일자</th>
        </tr>
    </thead>
    <tbody id="odd-color">
        <c:set var="index" value="${pager.indexNo}"/>
        <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
            <tr>
                <td>
                ${index-status.index}
                </td>

                <td>
                <c:if test="${not empty baseVo.mileageGrpCdLog }">마일리지 그룹코드<br /></c:if>
                    <c:if test="${not empty baseVo.mileageNmLog }">마일리지 명<br /></c:if>
                    <c:if test="${not empty baseVo.dailyMaxAccuCntLog }">1일 적립 횟수<br /></c:if>
                    <c:if test="${not empty baseVo.dailyMaxAccuAmountLog }">1일 적립 한도<br /></c:if>
                    <c:if test="${not empty baseVo.expDtLog }">유효 기간<br /></c:if>
                    <c:if test="${not empty baseVo.useYnLog }">사용 여부<br /></c:if>
                </td>

                <td>
                    <c:if test="${not empty baseVo.mileageGrpCdLog }">${baseVo.mileageGrpCdLog }<br /></c:if>
                    <c:if test="${not empty baseVo.mileageNmLog }">${baseVo.mileageNmLog }<br /></c:if>
                    <c:if test="${not empty baseVo.dailyMaxAccuCntLog }">${baseVo.dailyMaxAccuCntLog }<br /></c:if>
                    <c:if test="${not empty baseVo.dailyMaxAccuAmountLog }">${baseVo.dailyMaxAccuAmountLog }<br /></c:if>
                    <c:if test="${not empty baseVo.expDtLog }">${baseVo.expDtLog }<br /></c:if>
                    <c:if test="${not empty baseVo.useYnLog }">${baseVo.useYnLog }<br /></c:if>
                </td>

                <td>
                ${baseVo.regIdLog }
                </td>
                <td class="lr_none">
               ${baseVo.logDtmLog }
                </td>
            </tr>
       </c:forEach>
    </tbody>
</table>
<op:no-data obj="${pager.list}" colspan="5" />
    <!-- //리스트 -->
<op:pager pager="${pager}" />
</div>

<div class="tx_c mar_t10">
<button class="blue" type="button" onclick="parent.$.fn.colorbox.close();">닫기</button>
</div>
</body>
</html>