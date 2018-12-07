<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<html>
<head>
<title>메타데이터리스트</title>
<script type="text/javascript">
//<![CDATA[
    //메타폼 등록
    var jsInsertPopView = function(el) {
        $("#sForm").attr("action","BD_insertFormView.do").submit();
    };
    
    var jsSearch = function(){
        document.sForm.elements["q_currPage"].value = "1";        
        $("#sForm").attr("action","BD_index.do").submit();
    }
    
    var jsUpdatePopView = function(el,varMasterSeqN, varDataSeqN) {
        $(el).colorbox({
            title : "메타데이터수정",
            href : "PD_updateDataPop.do?q_metaMasterSeqN="+varMasterSeqN+"&q_metaDataFormSeqN="+varDataSeqN,
            width : "780",
            height : "500",
            iframe : true
        });
    };
    
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
    
    var jsDataKind = function(){        
        if($('input:radio[name=q_dataKind]:checked').val() == "field"){
            document.getElementById("fieldDiv").style.display = "block";
            document.getElementById("metaFormDiv").style.display = "none";
            
        }else if($('input:radio[name=q_dataKind]:checked').val() == "metaForm"){
            document.getElementById("fieldDiv").style.display = "none";
            document.getElementById("metaFormDiv").style.display = "block";
        }
    }
    
    var jsMetaFormSearch = function(strMetaSeqN,strGbn){
        if(strGbn == "metaForm"){
            $("#q_metaMasterSeqN").val(strMetaSeqN);
            $("#q_fieldCdC").val("");
        }else if(strGbn == "field"){
            $("#q_metaMasterSeqN").val("");            
            $("#q_fieldCdC").val(strMetaSeqN);
        }
            
        jsSearch();
    }
    
    $(document).ready(function() {
        if($('input:radio[name=q_dataKind]:checked').val() == null){
            $('input:radio[name=q_dataKind]:input[value=field]').attr("checked", true);
        }
        
        jsDataKind();
    });
    
    
//]]>
</script>
</head>
<body>
<!-- 검색 -->
    <form name="sForm" id="sForm" method="get">
    <input type="hidden" name="q_metaMasterSeqN" 	id="q_metaMasterSeqN" 	value="${ param.q_metaMasterSeqN }" />
	<input type="hidden" name="q_metaDataFormSeqN" 	id="q_metaDataFormSeqN" value="${ param.q_metaDataFormSeqN }" />
	<input type="hidden" name="q_fieldCdC" 			id="q_fieldCdC" 		value="${ param.q_fieldCdC }" />
    <div class="search">
        <fieldset>
            <legend>검색하세요</legend>
            <input type="radio" id="q_dataKind" name="q_dataKind" value="field"  	onclick="JavaScript:jsDataKind();" <c:if test="${ param.q_dataKind eq 'field' }">checked</c:if>/> 분야별
			<input type="radio" id="q_dataKind" name="q_dataKind" value="metaForm"  onclick="JavaScript:jsDataKind();" <c:if test="${ param.q_dataKind eq 'metaForm' }">checked</c:if>/> 주제별		
			<input type="text" name="q_metaTitleV" id="q_metaTitleV" value="${param.q_metaTitleV}" maxlength='50' class="w215" />		      
	        <button type="button" class="gray mar_l5" id="buttSearch" onclick="JavaScript:jsSearch();">검색</button>      
        </fieldset>
    </div>

<div id="fieldDiv" class="c_list mar_b30">
	<ul>
	<c:forEach items="${fieldCountList}" var="fieldlistVO">		
		<li>
		<c:if test="${ fieldlistVO.fieldCdCount ne '0'}" >
			<a href="#" onclick="JavaScript:jsMetaFormSearch('${ fieldlistVO.prvCd }','field');">
			<c:if test="${ param.q_fieldCdC eq fieldlistVO.prvCd }">
			<strong>${ fieldlistVO.prvNm } ( ${ fieldlistVO.fieldCdCount } )</strong>
			</c:if>
			<c:if test="${ param.q_fieldCdC ne fieldlistVO.prvCd }">
			${ fieldlistVO.prvNm } ( ${ fieldlistVO.fieldCdCount } )
			</c:if>
			</a>
			 &nbsp;&nbsp;&nbsp;
		</c:if>
		<c:if test="${ fieldlistVO.fieldCdCount eq '0'}" >
			${ fieldlistVO.prvNm } ( ${ fieldlistVO.fieldCdCount } ) &nbsp;&nbsp;&nbsp;
		</c:if>
		</li>
	</c:forEach>
	</ul>
</div>    

<div id="metaFormDiv" class="c_list mar_b30">
	<ul>
	<c:forEach items="${masterFormCountList}" var="metaFormlistVO">
		<li>	
		<c:if test="${ metaFormlistVO.metaMasterFormCount ne '0'}" >
			<a href="#" onclick="JavaScript:jsMetaFormSearch('${ metaFormlistVO.metaMasterSeqN }','metaForm');">
			<c:if test="${ param.q_metaMasterSeqN eq metaFormlistVO.metaMasterSeqN }">
			<strong>${ metaFormlistVO.metaMasterNmV } ( ${ metaFormlistVO.metaMasterFormCount } )</strong>
			</c:if>
			<c:if test="${ param.q_metaMasterSeqN ne metaFormlistVO.metaMasterSeqN }">
			${ metaFormlistVO.metaMasterNmV } ( ${ metaFormlistVO.metaMasterFormCount } )
			</c:if>
			</a>
			&nbsp;&nbsp;&nbsp;
		</c:if>
		<c:if test="${ metaFormlistVO.metaMasterFormCount eq '0'}" >
			${ metaFormlistVO.metaMasterNmV } ( ${ metaFormlistVO.metaMasterFormCount } )
			&nbsp;&nbsp;&nbsp;
		</c:if>
		</li>
	</c:forEach>
	</ul>
</div>	

    <op:pagerParam title="메타데이터등록리스트" />
    <!-- //검색 -->
    </form>
    
    <!-- 리스트 -->
    <table class="boardList"summary="메타데이터 리스트입니다.">
        <caption class="hidden"> 목록 </caption>
        <colgroup>
            <col width="5%"/>
            <col width=""/>
            <col width="10%"/>
            <col width="10%"/>
        </colgroup>
        <thead>
            <tr>
                <th>번호</th>
                <th>메타데이터명</th>
                <th>등록일</th>
                <th>공개일자</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pager.list}" var="listVO" varStatus="status">
            <tr <c:if test="${(pager.indexNo - status.index)%2 == 0}">class="bg_yellow""</c:if>>
                <td>${pager.indexNo - status.index}</td>
                <td class="tx_l"><a href="#" onclick="JavaScript:jsUpdatePopView(this,'${ listVO.metaMasterSeqN }','${ listVO.metaDataFormSeqN }');">${ listVO.metaTitleV }</a></td>
                <td class="tx_c">${ listVO.regD}</td>
                <td class="tx_c">${ listVO.openPublicD}</td>
            </tr>
            </c:forEach>
            <op:no-data obj="${pager.list}" colspan="4" />
        </tbody>
    </table>
    <!-- //리스트 -->

    <!-- 페이징 -->
    <op:pager pager="${pager}" />
    <!-- //페이징 -->

    <!-- 버튼 -->
    <div class="tx_r mar_t10 mar_b20">
        <button type="button" class="blue" onclick="JavaScript:jsInsertPopView(this);">등록</button>
    </div>
</body>
</html>