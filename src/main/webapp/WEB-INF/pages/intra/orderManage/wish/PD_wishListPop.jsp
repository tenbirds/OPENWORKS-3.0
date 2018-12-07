<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
<op:jsTag type="spi" items="ui, highlight, form,colorbox" />
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript">
	
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
	
	var jsExcelList = function() {
      	//location.href = "ND_wishListExcel.do?" + $("#dataForm").serialize();
	    if ($('#excelFr').length == 0) {
            $('body').append('<iframe id="excelFr" style="display: none;"/>');
        }

        var url = "PD_wishListExcel.do?" + $("#dataForm").serialize();
        $('#excelFr').attr('src',url);
    };
</script>
</head>
<body>
    <div id="contents">
         <!-- 검색 -->
        <form name="dataForm" id="dataForm" method="get" action="PD_wishListPop.do">
            <input type="hidden" name="q_seq" id="q_seq" value="" />
            <input type="hidden" name="userId" id="userId"	 value="${p_userId}"/>	
            <input type="hidden" name="grpSeq" id="grpSeq"	 value="${p_grpSeq}"/>	            
            
            <op:pagerParam title="구매희망 목록" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
        
         <!-- 리스트 -->
        <table class="boardList" cellspacing="0" border="0" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
                <col width="10%"/>
                <col width="15%"/>
                <col width="*"/>
                <col width="20%"/>
            </colgroup>
            <thead>
            	<tr>
	                <th>번호</th>
	                <th>선택</th>
	                <th>서비스명</th>
	                <th>판매자</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:set var="index" value="${pager.indexNo}"/>
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
                        <td>${index-status.index}</td>
                        <td><c:if test="${baseVo.selChk == 'Y'}">선택</c:if><c:if test="${baseVo.selChk == 'N'}">미선택</c:if>
                        </td>
                        <td>
                          <div class="tx_l">
                              ${baseVo.goodsNm}
                          </div>
                        </td>
                        <td class="tx_l">${baseVo.langStoreNm}</td>
                    </tr>  
                </c:forEach>
                <op:no-data obj="${pager}" colspan="10" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
         <div class="tx_r">
            <a href="#" onclick="jsExcelList();"><button class="blue" type="button">엑셀다운로드</button></a>
         </div>
        
    </div>
</body>
</html>