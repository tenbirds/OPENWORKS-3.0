<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<html>
<head>
<title>메타정보리스트</title>
<script type="text/javascript">
//<![CDATA[
    //메타폼 등록
    var jsInsertPopView = function(el) {
        $(el).colorbox({
            title : "메타폼등록",
            href : "PD_insertFormPopView.do",
            width : "700",
            height : "500",
            iframe : true
        });
    };
    
    var jsSearch = function(){
        document.sForm.elements["q_currPage"].value = "1";
        $("#sForm").attr("action","BD_index.do").submit();
    }
    
    var jsUpdatePopView = function(el,varMasterSeqN) {
        $(el).colorbox({
            title : "메타폼등록",
            href : "PD_updateFormPopView.do?q_metaMasterSeqN="+varMasterSeqN,
            width : "700",
            height : "500",
            iframe : true
        });
    };
    
    
    var jsUseYnMod =  function(el, varMasterSeqN, modVal){
        $.ajax({
            url: "PD_updateUseYnCAction.do",
            type: "POST",
            dataType: "json",
            data: {
                metaMasterSeqN : varMasterSeqN,
                useYnC : modVal
            },
            success: function( data ) {
                jsSuccessBox(data.message);	
                
                if(modVal == "Y"){
                    $(el).parent().html("<a href=\"#\" onclick=\"JavaScript:jsUseYnMod(this, '"+varMasterSeqN+"', 'N');\">사용</a>");    
                }else{
                    $(el).parent().html("<a href=\"#\" onclick=\"JavaScript:jsUseYnMod(this, '"+varMasterSeqN+"', 'Y');\">미사용</a>");
                }                	
            }
        });
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
    
    var jsManageUserAuthPop = function(el, varMasterSeqN){
        $(el).colorbox({
            title : "사용자 권한 관리",
            href : "PD_manageUserAuthPopView.do?q_metaMasterSeqN="+varMasterSeqN,
            width : "820",
            height : "500",
            iframe : true
        });
    }
    
//]]>
</script>
</head>
<body>
<!-- 검색 -->
    <form name="sForm" id="sForm" method="get">
    <div class="searchLeft">
        <fieldset>
            <legend>검색하세요</legend>
                            사용여부 : 
            <input type="radio" name="q_useYnC" id="q_useYnC" value="Y" <c:if test="${param.q_useYnC eq 'Y'}">checked</c:if>/> 사용
            <input type="radio" name="q_useYnC" id="q_useYnC" value="N" <c:if test="${param.q_useYnC eq 'N'}">checked</c:if>/> 미사용      <br/>
                            메타정보명 : 
            <input type="text" name="q_metaMasterNmV" id="q_metaMasterNmV" value="${param.q_metaMasterNmV }" />
            <button type="button" class="gray mar_l5" id="buttSearch" onclick="JavaScript:jsSearch();">검색</button>      
        </fieldset>
    </div>
    <op:pagerParam title="메타정보리스트" />
<!-- //검색 -->
    </form>
    
    <!-- 리스트 -->
    <table class="boardList"summary="메타등록 리스트입니다.">
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
                <th>메타정보명</th>
                <th>등록일</th>
                <th>사용여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${pager.list}" var="listVO" varStatus="status">
            <tr <c:if test="${(pager.indexNo - status.index)%2 == 0}">class="bg_yellow""</c:if>>
                <td>${pager.indexNo - status.index}</td>
                <td class="tx_l">
                	<a href="#" onclick="JavaScript:jsUpdatePopView(this,'${listVO.metaMasterSeqN}')">
                		${listVO.metaMasterNmV}                		
                	</a>&nbsp;
                	<a href="#" onclick="JavaScript:jsManageUserAuthPop(this,'${listVO.metaMasterSeqN}');">[사용자권한등록]</a>
                </td>
                <td class="tx_c">${listVO.regD}</td>
                <td class="lr_none" name="tdUseYnC" id="tdUseYnC">
                	<a href="#" onclick="JavaScript:jsUseYnMod(this,'${listVO.metaMasterSeqN}','<c:if test="${listVO.useYnC eq 'Y'}">N</c:if><c:if test="${listVO.useYnC eq 'N'}">Y</c:if>');">
                	<c:if test="${listVO.useYnC eq 'Y'}">사용</c:if>                	
                	<c:if test="${listVO.useYnC eq 'N'}">미사용</c:if>
                	</a>
                </td>
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