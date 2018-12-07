<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl"  prefix="op"%>
<html>
<head>
    <title></title>
<script type="text/javascript">
    $().ready(function () {

    }); //ready()

    var jsBack = function(){      
        history.go(-1);event.preventDefault();        
    };


    var jsMovePage = function(page){
        var p = 1;
        if(page == 'page'){
            p = $('input[name=page]').val();
        }else{
            p = page;
        }
        $("#dataForm input[name=q_currPage]").val(p);
        $("#dataForm").submit();
    };
    

    var eventListExcel = function() {
        parent.location.href = "INC_answerListExcel.do?eventSn=" + $("#eventSn").val();
    };
    
</script>
    
</head>

<body>

      <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="PD_answerList.do">
            <input type="hidden" name="eventSn" id="eventSn" value="${baseVo.eventSn}" />            
            <input type="hidden" name="eventTitle" id="eventTitle" value="${baseVo.eventTitle}" />
            <input type="hidden" name="beginDate" id="beginDate" value="${baseVo.beginDate}" />
            <input type="hidden" name="endDate" id="endDate" value="${baseVo.endDate}" />
            
            <div class="search">
                <fieldset>
                    <legend>댓글 제목과 기간을 확인해세요.</legend>
                    <label class="skip" for="boardsearch">댓글 제목 항목</label>
                    
                    
                    <span style="font-weight: bold;">제목 </span><span style="font-weight: bold;">: &nbsp;&nbsp;</span>${baseVo.eventTitle}
                    <span>(${fn:substring(baseVo.beginDate,0,4)}-${fn:substring(baseVo.beginDate,4,6)}-${fn:substring(baseVo.beginDate,6,8)}
                                    ~ ${fn:substring(baseVo.endDate,0,4)}-${fn:substring(baseVo.endDate,4,6)}-${fn:substring(baseVo.endDate,6,8)})</span>
                </fieldset>
            </div>
            <div class="tx_l mar_b10">
                <a href="#"><button class="w_blue" onclick="eventListExcel();">엑셀출력</button></a>
            </div>
            <op:pagerParam title="댓글 목록" />
        </form>
        <!-- 컨텐츠영역 -->
        <form id="dataForm" name="dataForm">

            <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="10%"/>
                <col width="20%"/>
                <col width="15%"/>
                <col width=""/>
            </colgroup>
              <thead>
                <tr>
                    <th>번호</th>
                    <th>작성일</th>
                    <th>작성자(ID)</th>
                    <th class="lr_none">내용</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                 <tr>
                    <td>${index-status.index}</td>
                    <td>${baseVo.writngDt}</td>
                    <td>${baseVo.wrterNm}<br/>(${baseVo.wrterId})</td>
                    <td>${baseVo.eventCmtCn}</td>
                 </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="4" />
            </tbody>
            </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        <!-- //페이징 -->
                
        </form>
</body>
</html>