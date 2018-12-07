<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<html>
<head>
<title>메타데이터관리리스트</title>
<op:jsTag type="spi" items="validate,ui,form"/>
<op:jsTag type="openworks" items="ui"/>
<script type="text/javascript">
//<![CDATA[
    var jsSearch = function(){        
        document.dataForm.elements["q_currPage"].value = "1";        
        $("#dataForm").attr("action","BD_managePropertyList.do").submit();
    }
    
    var jsUpdatePopView = function(el,varMasterSeqN, varDataSeqN) {        
        $(el).colorbox({
            title : "데이터수정",
            href : "PD_updateDataPop.do?q_metaMasterSeqN="+varMasterSeqN+"&q_metaDataFormSeqN="+varDataSeqN,
            width : "780",
            height : "500",
            iframe : true
        });
    };
    
    var jsDeleteData = function(){
        var u_metaDataFormSeqN = jsCheckedArray();
        
        $("#dataForm").ajaxSubmit({
            url      : "PD_updateUseYnCAction.do",
            type     : "POST",
            data : { u_metaDataFormSeqN : u_metaDataFormSeqN.join(',')},
            success  : function(response) {
                if (response.result) {
                    jsSuccessBox(response.message);
                    jsSearch();
                } else { 
                    jsErrorBox(response.message);
                }
            }
        });
    }
    
    var jsCheckedArray = function() {
        var selectedDelYn = [];

        $("input[name=delYn]:checked").each(function(i) {
            selectedDelYn[i] = $(this).val();
        });
        return selectedDelYn;
    };
    
    var jsInsertDataPopView = function(el,varFormSeq) {
        $(el).colorbox({
            title : "데이터등록",
            href : "PD_insertDataPop.do?q_metaMasterSeqN="+$("select[name=q_metaMasterSeqN]").val(),
            width : "780",
            height : "540",
            iframe : true
        });
    };
    
    var jsSelectFormViewPop = function(el) {    
        $(el).colorbox({
            title : "메타정보보기",
            href : "PD_selectFormViewPop.do?q_metaMasterSeqN="+$("select[name=q_metaMasterSeqN]").val(),
            width : "650",
            height : "500",
            iframe : true
        });
    };
    
    var jsMovePage = function(page) {
        var p = 1;
        if(page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        document.dataForm.elements["q_currPage"].value = p;
        document.dataForm.action = "BD_managePropertyList.do";
        document.dataForm.submit();
    };
//]]>
</script>
</head>
<body>
<!-- 검색 -->
    <form name="dataForm" id="dataForm" method="get">
    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <select name="q_useYnC" id="q_useYnC">
            <option value="">사용여부</option>
            <option value="Y" <c:if test="${ param.q_useYnC eq 'Y' }">selected</c:if>>사용</option>
            <option value="N" <c:if test="${ param.q_useYnC eq 'N' }">selected</c:if>>미사용</option>
            </select>&nbsp;
            <select name="q_metaMasterSeqN" id="q_metaMasterSeqN">
            <option value="">선택하세요.</option>
            <c:forEach items="${selMetaFormList}" var="selMetaFormList" >
            <option value="${selMetaFormList.metaMasterSeqN}" <c:if test="${ param.q_metaMasterSeqN eq selMetaFormList.metaMasterSeqN }">selected</c:if>>${selMetaFormList.metaMasterNmV}</option>
            </c:forEach>
            </select>      
            <button type="button" class="gray mar_l5" id="buttSearch" onclick="JavaScript:jsSearch();">검색</button>      
            <button type="button" class="gray mar_l5" id="buttFormView" onclick="JavaScript:jsSelectFormViewPop(this);">폼보기</button>      
            <button type="button" class="gray mar_l5" id="buttRegView" onclick="JavaScript:jsInsertDataPopView(this);">등록하기</button>      
        </fieldset>
    </div>
    <op:pagerParam title="메타데이터 관리 리스트" />
    <!-- //검색 -->
    
    
    <!-- 리스트 -->
    <table class="boardList"summary="메타데이터 관리 리스트입니다." width="100%">
        <caption class="hidden"> 목록 </caption>
        <colgroup>        	
        	<c:forEach items="${tbHeader}" var="listHeadVO" varStatus="headerStatus">	
        		<c:if test="${ headerStatus.index eq 0 }">
        		<col width="80"/>
        		<col width="80"/>
        		</c:if>
        		<col width=""/>
        		<c:if test="${ tbHeaderSize-1 eq headerStatus.index }">
            	<col width="80"/>
            	</c:if>
            </c:forEach>            
        </colgroup>
        <thead>
            <tr>            	
	            <c:forEach items="${tbHeader}" var="listTitleVO" varStatus="titStatus">	 
	            	<c:if test="${ titStatus.index eq 0 }">
	        		<th>삭제 <input type="checkbox" name="allCheck" id="allCheck" onclick="JavaScript:jsAllCheck('delYn',this);" /></th>
	        		<th>번호</th>
	        		</c:if>           
	                <th>${ listTitleVO.metaPropNameV }( ${ listTitleVO.metaPropCdV } )</th>
	                <c:if test="${ tbHeaderSize-1 eq titStatus.index }">
	        		<th>수정</th>
	        		</c:if>	                
	            </c:forEach>	            
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pager.list}" var="listVO" varStatus="pagerStatus">
            <tr <c:if test="${(pager.indexNo - pagerStatus.index)%2 == 0}">class="bg_yellow""</c:if>>
            	<c:set var="checkNum" value="0" scope="page" />
            	<c:forEach items="${ tdList }" var="tdListVO" varStatus="tdStatus">
            		<c:if test="${ listVO.metaDataFormSeqN eq tdListVO.metaDataFormSeqN }">
	            		<c:if test="${ checkNum % tbHeaderSize  eq 0 }">
	            			<td><input type="checkbox" name="delYn" id="u_metaDataFormSeqN" value="${ tdListVO.metaDataFormSeqN }" onclick="JavaScript:jsToggleCheck(this);"/></td>
	                		<td>${ pager.indexNo - pagerStatus.index }</td>	                		
	                	</c:if>	                	
	                	<td>${ tdListVO.propertyValueV }</td>
	                	<c:if test="${ tbHeaderSize-1 eq checkNum % tbHeaderSize }">	                			
	                		<td><button type="button" class="blue" onclick="JavaScript:jsUpdatePopView(this,'${ tdListVO.metaMasterSeqN }','${ tdListVO.metaDataFormSeqN }');">수정</button></td>
	                	</c:if>
                	</c:if>
                 	<c:set var="checkNum" value="${ checkNum+1 }" />
                </c:forEach> 
            </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="${ tbHeaderSize+3 }" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
	</form>
    <!-- 버튼 -->
    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue" onclick="JavaScript:jsDeleteData();">선택삭제</button>
    </div>
</body>
</html>