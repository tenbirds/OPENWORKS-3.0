<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>수요조사설명회</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
<script type="text/javascript">

//<![CDATA[
    $().ready(function () {
        
    });//ready end
    
    
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

    var jsSearch = function(){
        document.dataForm.action = "BD_index.do";
        document.dataForm.elements["q_currPage"].value = "1";
        $("#dataForm").submit();
    };
    
    var jsSeSearch = function(se){
        $("#partcptSe").val(se);
        jsSearch();
    };

    var jsExcelList = function() {
      	location.href = "BD_indexExcel.do?" + $("#dataForm").serialize();
      	/* 
	    if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = "BD_indexExcel.do?" + $("#dataForm").serialize();
        $('#excelFr').attr('src',url);
         */
    };
    
    
//]]>
</script>
</head>
<body>
    <div id="contents">
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="BD_index.do">
            <input type="hidden" name="q_init" id="q_init" value="${param.q_init}"/>            
            <input type="hidden" name="partcptSe" id="partcptSe" value="${baseVo.partcptSe}" />
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <div style="text-align:left;">
	                    <c:set var="btnClassTp1">
						    <c:choose>
								<c:when test="${baseVo.partcptSe == 1001}">orange</c:when>
								<c:otherwise>blue</c:otherwise>
							</c:choose>
						</c:set>
						<c:set var="btnClassTp2">
						    <c:choose>
								<c:when test="${baseVo.partcptSe == 1002}">orange</c:when>
								<c:otherwise>blue</c:otherwise>
							</c:choose>
						</c:set>
                    	<c:if test="${baseVo.partcptSe == 1001}">
                    	</c:if>
                        <button type="button" class="${btnClassTp1} mar_t10 mar_l5 mar_b5" onclick="jsSeSearch('1001');">10월 10일 서울행사</button>&nbsp;
                        <button type="button" class="${btnClassTp2} mar_t10 mar_l5 mar_b5" onclick="jsSeSearch('1002');">10월 11일 대구행사</button>
                    </div>    
                </fieldset>
               
            </div>
            
            <op:pagerParam title="수요조사설명회신청 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="5%"/>
                <col width="20%"/>
                <col width="25%"/>
                <col width="10%"/>
                <col width="15%"/>
                <col width="20%"/>
                <col width="15%"/>
            </colgroup>
            <thead>
                <th>No</th>
                <th>상위기관명</th>
                <th>소속기관</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>참가신청일</th>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td>${baseVo.upperPblinsttNm}</td>
                        <td>${baseVo.pblinsttNm}</td>
                        <td>${baseVo.userNm}</td>
                        <td>${baseVo.mbtlnum}</td>
                        <td>${baseVo.email}</td>
                        <td>${baseVo.partcptReqstDt}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
    </div>
    <div class="tx_r">
    	<a href="#" onclick="jsExcelList();"><button class="blue" type="button">엑셀다운로드</button></a>
    </div>
</body>

</html>