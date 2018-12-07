<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

	<title>이용실적증명서 신청승인</title>
	
	<op:jsTag type="openworks" items="ui, validate, form" />
	<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>
	
	<script type="text/javascript">
	$().ready(function () {
	    $("input[name=chk-all]").click(function() {
	        var isChecked = this.checked;
	        $("input[name=indexs]").each(function() {
	            this.checked = isChecked;
	        });
	    });
	            
	});//ready end
	/*  페이지 이동 (페이징 처리) */
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
	/*  검색 */
	var jsSearch = function(){
	    var q_searchVal = $('#q_searchVal').val();
	    var q_beginDate = $('#q_beginDate').val();
	    var q_endDate = $('#q_endDate').val();
	/*
		if(q_searchVal == null || q_searchVal == ''){
	       alert("검색조건 : 회원ID 혹은 회원명 입력해주세요.");
	       	return false;
	   } 
	*/
	   //document.dataForm.action = "BD_index.do";
	   document.dataForm.elements["q_currPage"].value = "1";
	   $("#dataForm").submit();
	};
	
	var jsAcmsltCrtfManager = function(el,rousn) {
		$(el).colorbox({
			title : "엑셀 출력 항목 선택",
			href : "BD_form.do?rouSn=" +rousn,
			width : "950",
			height : "400",
			iframe : true
		});
	};
	
	// 선택항목 증명서 출력 1003
	var jsAcmsltCrtfReport = function(el,certResultCode) 
	{		
		var items = []; 
	    var checkCnt = 0;
	    
	    $('input:checkbox[name=indexs]:checked').each(function () 
	    { 
	    	items.push($(this).val());
	    });
	    
	    checkCnt = items.length;
	    if (checkCnt == 0 ) 
	    {
	        alert('1개 이상 선택 하셔야 합니다.');
	        return false;
	    }
	    else
	    {
			$(el).colorbox({
				title  : "이용실적증명서 신청내역",
				href   : "BD_serviceReportList.do?item="+items+"&certResultCode="+certResultCode,
				width  : "950",
				height : "500",
	            overlayClose : true,
	            escKey : true,
	            iframe : true
			});
	    }
	    //$('input:checkbox[name=indexs]:checked').attr("checked", false);
	};
	
	
	
    // '보기' 클릭!! (신청내역보기)    
    var jsView = function(vl,rousn)
    {
        $("#goodsCode").val(vl);
        document.dataForm.action = "BD_serviceReportList.do?item="+rousn+"&certResultCode=1003",
        document.dataForm.submit();
    };
    
	</script>
</head>
<body>
	<div id="contents">
    	<!-- 검색 -->
    	<form name="dataForm" id="dataForm" method="post" action="BD_suppList.do">
        	<input name="userId" id="userId" value="${param.q_searchVal}" type="hidden"/>
        	<input name="cntrctSnArray" id="cntrctSnArray" type="hidden"/>
            <div class="search">
                <fieldset>
                    <legend>조건을 선택하여 검색하세요.</legend>
                    <table class="boardWrite" summary="검색 조건">
	                    <colgroup>
	                        <col width="10%" />
	                        <col width="18%" />
	                        <col width="5%" />
	                        <col width="20%" />
	                    </colgroup>
                    	<tbody>
                   			<tr>
                        		<th>검색조건</th>
                            	<td colspan="3">
                            	<!-- 검색조건 회원ID/사업명 -->
	                            	<select id="q_searchKey" name="q_searchKey" title="상세검색을 선택하세요"> 
	                                	<option value="1002" <c:if test="${param.q_searchKey eq 1002}">selected="selected"</c:if>>신청자명</option>
	                                  	<option value="1001" <c:if test="${param.q_searchKey eq 1001}">selected="selected"</c:if>>신청자ID</option>
	                                  	<option value="1000" <c:if test="${param.q_searchKey eq 1000}">selected="selected"</c:if>>기관명</option>
	                              	</select>
                                	<input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value="${param.q_searchVal}" />" class="w215" title="검색어를 입력하세요." />
                            	</td>	                                
                        	</tr>
                    	</tbody>
                    </table>
                    <div>
                    	<button type="button" class="blue mar_t10 mar_l5 mar_b5" onclick="jsSearch();">검색</button>&nbsp;&nbsp;
                    </div>
            	</fieldset>
            </div>
            <op:pagerParam title="이용실적증명서 요청리스트" />
        </form>
        <!-- //검색 -->
        <%-- 페이징 관련 파라미터 생성. 목록표시 갯수 선택 생성됨--%>
        
         <!-- 리스트 -->
        <table class="boardList" summary="리스트입니다.">
            <caption class="hidden"> 목록 </caption>
            <colgroup>
<!-- 	            <col width="4%"/>     -->
	            <col width="4%"/>
	            <col width="*"/>
                <col width="7%"/>
                <col width="10%"/>
                <col width="20%"/>
                <col width="10%"/>
                <col width="5%"/>
            </colgroup>
            <thead>
            	<tr>
            		<!--  th><input type="checkbox" value="Y" name="chk-all" id="chk-all" /></th  -->
            		<th>No.</th>
            		<th>신청기관</th>
	                <th>신청자명</th>
	                <th>신청일</th>
	                <th>발급사유</th>
	                <th>신청내역</th>
	                <th>지연일</th>
                </tr>
            </thead>
            <tbody id="odd-color">
                <c:forEach items="${pager.list}" var="baseVo" varStatus="status">
                    <tr>
<!--                     	<td><input type="checkbox" id="indexs" name="indexs" value="${baseVo.rouSn}"/></td>	 -->			
                    	<td>${fn:length(pager.list)-status.index}</td>
                    	<td class="tx_l">${baseVo.organNm}</td>
                    	<td>${baseVo.userNm}</td>
                    	<td>${baseVo.registDt}</td>
                    	<td class="tx_l">${baseVo.issuResn}</td>
                    	<td><a href="#" onclick="jsView(this,${baseVo.rouSn});">보기</a></td>
                    	<td>${baseVo.dateDiffe}</td>
                    </tr>
                </c:forEach>
                <op:no-data obj="${pager}" colspan="8" />
            </tbody>
        </table>
        
        <!-- 페이징 -->
        <op:pager pager="${pager}" />
        
        <div class="tx_l">
        	
<!--        	<button class="blue" type="button" name="submits" id="submits" onclick="jsAcmsltCrtfReport(this,1003);">선택항목 증명서 출력</button>  -->
			
			<!--button class="blue" type="button" name="submits" id="submits" onclick="jsAcmsltCrtfReport(this,1003);">이용실적증명발급 반려</button -->
        </div>
    </div>
</body>

</html>