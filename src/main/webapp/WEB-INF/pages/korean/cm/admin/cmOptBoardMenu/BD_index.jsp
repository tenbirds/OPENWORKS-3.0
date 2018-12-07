<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@page import="zes.openworks.common.GlobalConfig"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>메뉴 관리 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate, cmextjs" />
	
	<script type="text/javascript" src="/resources/openworks/spi/openworks/openworks.tree2.js"></script>
<%-- 	<script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script> --%>
	<script type="text/javascript">
	
	
	    var ROOT_VISIBLE   = true;
	    var ENABLE_DND     = true;
	   // var ROOT_TREE_ID   =  "0";        
		var ROOT_TREE_ID   =       '<%= GlobalConfig.HIGH_MENU_CD %>';
	    //var ROOT_TREE_TEXT = "";
	
	    var IS_APPEND_LEAF     = true;
	    var PARENT_NODE_ID_VAR = "cmmntyUpMenuCode";
	    var NODE_ID_VAR        = "cmmntyMenuCode";
	    var NODE_NM_VAR        = "cmmntyMenuNm";
	    var NODE_ORDER_VAR     = "sortOrdr";
	    
	    var PARENT_NODE_NAME_VAR     = "cmmntyMenuNm";
	    var PARENT_NODE_TEXT_VAR     = "cmmntyMenuDc";
	
	    var TREE_JSON_URL = "INC_cmOptBoardMenuTreeList.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	    var VIEW_URL      	= "INC_cmOptBoardMenuTreeView.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	    var INSERT_URL    	= "ND_cmOptBoardMenuInsert.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	    var UPDATE_URL    	= "ND_cmOptBoardMenuUpdate.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	    var UPDATE_MOVE_URL    	= "ND_cmOptBoardMenuMoveUpdate.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	    var DELETE_URL    	= "ND_cmOptBoardMenuDelete.do?cmmntyId=<c:out value='${cmmntyId}'/>";
	
	    var  PANEL_SIZE_HEIGHT  = "1000"
	  	var  PANEL_SIZE_WIDTH ="208";
	  	var  RESIZABLE =false;
		var TREE_TITLE = "";
	
		
	    
	    var jsBeforeInsert = function(formName) {
	        return $(formName).valid();
	    };
	    var jsBeforeUpdate = function(formName) {
	        return $(formName).valid();
	    };
	
	    
	    var jsCreateUpdateParams = function() {
// 	        var checkShowYN;
// 	        if($('input[name="showYn"]').is(":checked")){
// 	            checkShowYN = "Y";
// 	        }else{
// 	            checkShowYN = "N";
// 	        }
	        return {
	            cmmntyMenuCode : $("#cmmntyMenuCode").val(),
	            cmmntyMenuNm : $("#cmmntyMenuNm").val(),
	            cmmntyBbsTyCd : $("#cmmntyBbsTyCd").val(),
	            //menuUrl: $("#menuUrl").val(),
	            cmmntyMenuDc : $("#cmmntyMenuDc").val()
// 	            showYn  :  checkShowYN
	        };
	    };
	    
	    var jsAfterInsert = function() {
	    };
	
	    var jsAfterUpdate = function() {
	    };
	    var jsAfterDelete = function() {
	    };
	    
		var onMenuAdd = function(){	   
		   $("#treeDetailDiv").load("INC_cmOptBoardMenuTreeForm.do?cmmntyId=<c:out value='${cmmntyId}'/>");
		};
		
		var onTreeReload = function(){
		    
		    Ext.getCmp(treePanel.id).getRootNode().reload();
		  
		}
	// 	var funAddRow = function(){    
	// 	    $("#treeAdd").append($("#addRow").val());
	// 	}
	// 	var funDeleteRow = function(obj){
	//     	$(obj).parent().parent().parent().remove();
	//     }; 
	     </script>      
</head>
<body>
		<!-- container -->
		<div id="container">
		<form name="dataForm" id="dataForm" method="post">
			<!-- side navigation bar -->
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=msoptboardmenu&amp;cmmntyId=${cmUserView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->
		</form>
			<!-- contents -->
			<div id="contents">
				<h2>메뉴관리</h2>
				<div class="board">
					<div class="menu">
						<div class="function">
							<a href="#none" onclick="onMenuAdd();"><img src="/resources/cmmnty/default/images/btn/btn_add.png" alt="추가"></a>
							<a href="#none" onclick="jsDeleteAction();"><img src="/resources/cmmnty/default/images/btn/btn_del.png" alt="삭제"></a>
							<a href="#none" onclick="onTreeReload();"><img src="/resources/cmmnty/default/images/btn/btn_refresh.png" alt="새로고침"></a>
						</div>
							<ul id ="treeDiv"></ul>
					</div>
					<div id="treeDetailDiv" class="write">
					</div>
				</div>
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
</body>
</html>
