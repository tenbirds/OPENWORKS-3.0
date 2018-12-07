<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<html>
<head>
<title>메타데이터등록</title>
<script type="text/javascript">
//<![CDATA[
    var jsMeatdataList = function(){
        $("#sForm").attr("action","BD_index.do").submit();
    }
    
    var jsSearch = function(){
        document.sForm.elements["q_currPage"].value = "1";
        $("#sForm").attr("action","BD_insertFormView.do").submit();
    }
    
    var jsMovePage = function(page) {
        var p = 1;
        if (page == 'page') {
            p = $('input[name=page]').val();
        } else {
            p = page;
        }
        $("#sForm input[name=q_currPage]").val(p);
        $("#sForm").submit();
    };
    
    var jsInsertDataPopView = function(el,varFormSeq) {
        $(el).colorbox({
            title : "데이터등록",
            href : "PD_insertDataPop.do?q_metaMasterSeqN="+varFormSeq,
            width : "780",
            height : "540",
            iframe : true
        });
    };
    
    var jsSelectFormViewPop = function(el,varView) {
        $(el).colorbox({
            title : "메타정보보기",
            href : "PD_selectFormViewPop.do?q_metaMasterSeqN="+varView,
            width : "780",
            height : "500",
            iframe : true
        });
    };
//]]>
</script>
</head>
<body>
<!-- 검색 -->
<form name="sForm" id="sForm" method="get">
<c:if test="${param.q_dataKind eq 'metaForm' }">
<input type="hidden" name="q_metaMasterSeqN" 	id="q_metaMasterSeqN" 	value="${ param.q_metaMasterSeqN }" />
</c:if>
<input type="hidden" name="q_fieldCdC" 			id="q_fieldCdC" 		value="${ param.q_fieldCdC }" />
<input type="hidden" name="q_metaTitleV" 		id="q_metaTitleV" 		value="${param.q_metaTitleV}" />
<input type="hidden" name="q_dataKind" 			id="q_dataKind"			value="${param.q_dataKind}"/>    
    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <input type="hidden" name="q_useYnC" id="q_useYnC" value="Y"/>
                            메타정보명 : 
            <input type="text" name="q_metaMasterNmV" id="q_metaMasterNmV" value="${param.q_metaMasterNmV }" />
            <button type="button" class="gray mar_l5" id="buttSearch" onclick="JavaScript:jsSearch();">검색</button>      
        </fieldset>
    </div>
<!-- //검색 -->
		<op:pagerParam title="데이터리스트" />
    </form>
    <!-- 리스트 -->
    <table class="boardList"summary="데이터 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="5%"/>
            <col width=""/>
            <col width="10%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>메타정보명</th>
                <th>등록일</th>                
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pager.list}" var="listVO" varStatus="status">
            <tr <c:if test="${(pager.indexNo - status.index)%2 == 0}">class="bg_yellow""</c:if>>
                <td>${pager.indexNo - status.index}</td>
                <td class="tx_l">
                	${listVO.metaMasterNmV}&nbsp;
                	<a href="#" onclick="JavaScript:jsSelectFormViewPop(this,'${listVO.metaMasterSeqN}')">[폼보기]</a>&nbsp;
                	<a href="#" onclick="JavaScript:jsInsertDataPopView(this,'${listVO.metaMasterSeqN}')">[등록하기]</a>
                	</td>
                <td class="tx_c">${listVO.regD}</td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="3" />
        </tbody>
    </table>
    <!-- //리스트 -->
    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->
    <!-- 버튼 -->
    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue" onclick="JavaScript:jsMeatdataList();">목록</button>
    </div>
</body>
</html>