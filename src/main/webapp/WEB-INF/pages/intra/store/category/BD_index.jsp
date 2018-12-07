<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>카테고리 관리</title>
<%--     <op:jsTag type="openworks" items="form, validate, ckeditor" /> --%>
<%--     <op:jsTag type="spi" items="jquery, form, validate, ui, colorbox" /> --%>
    <op:jsTag type="spi" items="form,validate,extjs,colorbox" />
    
    <script type="text/javascript" src="<c:url value="/resources/intra/category/category.tree.js" />"></script>
    
    <script type="text/javascript">	                
	    var ROOT_VISIBLE   = true;
	    var ENABLE_DND     = true;
<%-- 	    var ROOT_TREE_ID   = '<%= GlobalConfig.HIGH_MENU_CD %>'; --%>
        var ROOT_TREE_ID = "0";
 	    var ROOT_TREE_TEXT = "카테고리 목록";
	
	    var IS_APPEND_LEAF     = true;
	    var PARENT_NODE_ID_VAR = "highMenuCd";
	    var NODE_ID_VAR        = "menuCd";
	    var NODE_NM_VAR        = "menuNm";
	    var NODE_ORDER_VAR     = "orderNo";
	    
        var ADDED_VAR = "langCd";
        var ADDED_VALUE = "";
	    
	
	    var TREE_JSON_URL = "INC_categoryList.do?ctgryClCd=<%= request.getParameter("ctgryClCd") %>";
	    var VIEW_URL      = "INC_categoryView.do?ctgryClCd=<%= request.getParameter("ctgryClCd") %>";
	    var INSERT_URL    = "ND_insertAction.do?ctgryClCd=<%= request.getParameter("ctgryClCd") %>";
	    var UPDATE_URL    = "ND_updateAction.do";
	    var DELETE_URL    = "ND_deleteAction.do";
	
	    var jsBeforeInsert = function(formName) {
	        return $(formName).valid();
	    };
	    var jsBeforeUpdate = function(formName) {
	        return $(formName).valid();
	    };
	
	    var jsCreateUpdateParams = function() {
	        return {
	            menuCd : $("#nodeId").val(),
	            menuNm : $("#nodeText").val(),
	            menuUrl: $("#menuUrl").val(),
	            controllerNm : $("#controllerNm").val(),
	            useYn  : $("input[name=useYn]:checked").val()
	        };
	    };
	
	    var jsAfterUpdate = function() {
	    };
	    var jsAfterDelete = function() {
	    };

	    
        $(document).ready(function(){

//             $("#domainBtn").colorbox({
//                 title : "언어 목록",
//                 href  : "<c:url value="/component/domain/PD_DomainList.do" />",
//                 width : "630", height:"380", 
//                 iframe: true
//             });
				/* 
               <c:if test="${empty param.langCd}">
                
                $("#langList").trigger("change", "${langCd}");
                //jsLangRefresh("00");
               </c:if>
                */
			jsLangRefresh('00');
               //$("#langList").trigger("change", "${langCd}");           
//               $("#treeDetailDiv").show();
        });

        var jsLangRefresh = function(langCd) {    

            ADDED_VALUE = langCd;            
                                    
            if(treePanel) {
                treePanel.getEl().mask("로딩중...");
                treePanel.root.reload(function() {
                    treePanel.getEl().unmask();
//                    treePanel.root.setText($("#langList :selected").text());
                });
            }

//            $('#treeDetailDiv').html("<h4 class='tx_13'>카테고리 관리</h4><p>카테고리명을 선택하세요.</p>");
        };

                       
	</script>
</head>
<body>
    <div class="buser">
       
        <!-- 언어 목록 -->
        <div class="b_list">

            <form name="langForm" method="get">
            <c:choose>
                <c:when test="${not empty param.langCd}">
                    <input type="hidden" id="langCd" name="langCd" value="${param.langCd}" />
                </c:when>
                <c:otherwise>
                	<input type="hidden" id="langList" name="langList" value="00" />
                	<%-- 
                    <select name="langList" id="langList" style="width:100%;" onchange="jsLangRefresh(this.value);" class="select">
                        <c:forEach items="${langVo}" var="langVo" varStatus="status">
                            <option value="${langVo.langCd}"
                                    <c:if test="${status.index eq 0}">selected="selected"</c:if>>
                                ${dataVo} ${langVo.langNm}</option>
                        </c:forEach>
                    </select>
                     --%>
                </c:otherwise>
            </c:choose>
            </form>
            <span style="font-weight: bold;">${baseVo}</span>
            <div id="treeDiv" class="mar_t5"></div>
            
        </div>
        <!-- //언어 목록 -->
            
<!--         <div id="treeDiv" class="b_list"></div> -->

        <div id="treeDetailDiv" class="b_write">
            <h4 class="tx_13">카테고리 관리</h4>
            <p>카테고리명을 선택하세요.</p>
        </div>
    </div>
</body>
</html>