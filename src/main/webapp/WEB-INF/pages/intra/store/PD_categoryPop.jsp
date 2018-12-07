<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.utils.Converter"%>
<html>
<head>
    <title>카테고리 선택</title>
    <op:jsTag type="spi" items="form,validate,extjs" />
    <script type="text/javascript" src="<c:url value="/resources/intra/category/category.multitree.js" />"></script>
    
    <script type="text/javascript">	                
	    var ROOT_VISIBLE   = false;
	    var ENABLE_DND     = false;
<%-- 	    var ROOT_TREE_ID   = '<%= GlobalConfig.HIGH_MENU_CD %>'; --%>
        var ROOT_TREE_ID = "0";
 	    var ROOT_TREE_TEXT = "카테고리 목록";
 	    var ROOT_TREE_TEXT1 = "표준프레임워크호환 서비스";
 	    var ROOT_TREE_TEXT2 = "솔루션/서비스";
 	    var ROOT_TREE_TEXT3 = "IT전문가서비스";
	
	    var IS_APPEND_LEAF     = true;
	    var PARENT_NODE_ID_VAR = "highMenuCd";
	    var NODE_ID_VAR        = "menuCd";
	    var NODE_NM_VAR        = "menuNm";
	    var NODE_ORDER_VAR     = "orderNo";
	    

	    PID = "<%=Converter.XSS(request.getParameter("PID"))%>";
	    
	    switch (PID) {
	        case 'ST01' :
	            var langCode = parent.$("#langCode").val();
	            var getCtgryCodes = Array();        
	            parent.$("input.getCtgryCodes").each(function(i){
	                 getCtgryCodes[i] = $(this).val();
	            });
	            
	            var ctgryCodeUrl = "";
	            for (var i = 0; i < getCtgryCodes.length; i++) {
	                if (i > 0) {
	                    ctgryCodeUrl += "&";
	                }
	                ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i]     
	            }
	            if (ctgryCodeUrl != "") {
	                ctgryCodeUrl = "&" + ctgryCodeUrl;
	            }

// 	            var TREE_JSON_URL1 = "INC_categoryList.do?ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL1 = "";
	            var TREE_JSON_URL2 = "INC_categoryList.do?ctgryClCd=1002&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL3 = "";
	            break;
	            
            case 'ST02' :
                var langCode = parent.$("#langCode").val();
                var getCtgryCodes = Array();        
                parent.$("input.getCtgryCodes").each(function(i){
                     getCtgryCodes[i] = $(this).val();
                });
                
                var ctgryCodeUrl = "";
                for (var i = 0; i < getCtgryCodes.length; i++) {
                    if (i > 0) {
                        ctgryCodeUrl += "&";
                    }
                    ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i]     
                }
                
                if (ctgryCodeUrl != "") {
                    ctgryCodeUrl = "&" + ctgryCodeUrl;
                }

                var TREE_JSON_URL1 = "";                
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "INC_categoryList.do?ctgryClCd=1003&langCd=" + langCode + ctgryCodeUrl;
                break;
                
            case 'ST03' :
                var langCode = parent.$("#langList :selected").val();
                var getCtgryCodes = Array();        
                parent.$("input.getCtgryCodes").each(function(i){
                     getCtgryCodes[i] = $(this).val();
                });
                
                var ctgryCodeUrl = "";
                if (getCtgryCodes != "") {
	                for (var i = 0; i < getCtgryCodes.length; i++) {
	                    if (i > 0) {
	                        ctgryCodeUrl += "&";
	                    }
	                    ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i]     
	                }
	                if (ctgryCodeUrl != "") {
	                    ctgryCodeUrl = "&" + ctgryCodeUrl;
	                }
                }
                
                var TREE_JSON_URL1 = "INC_categoryList.do?chkBox=1&ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "";                
                break;
                
            case 'ST04' :
                var langCode = parent.$("#langList :selected").val();
                var getCtgryCodes = Array();        
                parent.$("input.getCtgryCodes2").each(function(i){
                     getCtgryCodes[i] = $(this).val();
                });
                
                var ctgryCodeUrl = "";
                if (getCtgryCodes != "") {
	                for (var i = 0; i < getCtgryCodes.length; i++) {
	                    if (i > 0) {
	                        ctgryCodeUrl += "&";
	                    }
	                    ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i]     
	                }
	                if (ctgryCodeUrl != "") {
	                    ctgryCodeUrl = "&" + ctgryCodeUrl;
	                }
                }
                var TREE_JSON_URL1 = "INC_categoryList.do?chkBox=1&ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "";
                break;
                
            case 'UM01' :
                var langCode = parent.$("#langCode").val();
                var getCtgryCodes = Array();        
                parent.$("input.getCtgryCodes").each(function(i){
                     getCtgryCodes[i] = $(this).val();
                });
                
                var ctgryCodeUrl = "";
                for (var i = 0; i < getCtgryCodes.length; i++) {
                    if (i > 0) {
                        ctgryCodeUrl += "&";
                    }
                    ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i]     
                }
                if (ctgryCodeUrl != "") {
                    ctgryCodeUrl = "&" + ctgryCodeUrl;
                }

                var TREE_JSON_URL1 = "";
                var TREE_JSON_URL2 = "INC_categoryList.do?ctgryClCd=1002&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL3 = "INC_categoryList.do?ctgryClCd=1003&langCd=" + langCode + ctgryCodeUrl;
                break;
	    }
        
        var jsCategorySelect = function() {
            
             var nodes = "";
             var nodes1 = new Array();
             var nodes2 = new Array();
             var nodes3 = new Array();
             var cc1 = "";
             var cc2 = "";
             if(treePanel1) {
                 var nodes1 = treePanel1.getChecked("id");
             }
             
             if(treePanel2) {
                 var nodes2 = treePanel2.getChecked("id");                 
             }
             
             if(treePanel3) {
                 var nodes3 = treePanel3.getChecked("id");                 
             }
             
             if ((nodes1.length > 0) && (nodes2.length > 0)) {
                 var cc1 = ","
             }
             if (((nodes1.length + nodes2.length) > 0) && (nodes3.length > 0)){
                 var cc2 = ","
             }
             nodes = nodes1 + cc1 + nodes2 + cc2 + nodes3;             
             
             switch (PID) {
	             case 'ST01' :
	                 var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
	                 if ( nodesCnt > 5 ) {
	                     alert("최대 5개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
	                     return;
	                 }
	                 if ( nodesCnt < 1 ) {
	                     alert("최소 1개 카테고리는 선택해야합니다.");
	                     return;
	                 }
	                 
	                 /** 2015.12.05 : KS CHOI 
	                 	카테고리 변경 및 해당카테고리에서 무조건 1개를 선택할 이유가 없어 삭제 
	                 {[
	                 var langCode = parent.$("#langCode").val();
	                 switch (langCode) {
		                 case '00' :
		                     var techNode = treePanel2.getNodeById("6202_45");
		                     break;
		                 case '01' :
		                     var techNode = treePanel2.getNodeById("6202_308");
		                     break;
		                 case '06' :
		                     var techNode = treePanel2.getNodeById("6202_399");
		                     break;
		                 default:
		                     break;
	                 }
	                 
	                 var techCtgry = 0;
	                 for(var i=0; i < nodes2.length; i++) {
	                     if (techNode.findChild("id", nodes2[i] , true) != null) {
	                         techCtgry = 1;
	                         break;
	                     }
	                 }
	                 
                     if ( techCtgry == 0) {
                         alert("기술 카테고리에서 반드시 1개의 카테고리를 선택하셔야 합니다.");
                         return;
                     }
	                 ]}*/
                     parent.$("#setCtgryCodes").val(nodes);                
	                 parent.$.fn.colorbox.close();
	                 parent.jsCtgrySel();
	                 break;
                 case 'ST02' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
                     if ( nodesCnt > 5 ) {
                         alert("최대 5개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     }
                     if ( nodesCnt < 1 ) {
                         alert("최소 1개 카테고리는 선택해야합니다.");
                         return;
                     }
                     parent.$("#setCtgryCodes").val(nodes);                
                     parent.$.fn.colorbox.close();
                     parent.jsCtgrySel();
                     break;
                 case 'ST03' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
                     if ( nodesCnt > 1 ) {
                         alert("최대 1개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     }
                     if ( nodesCnt < 1 ) {
                         alert("최소 1개 카테고리는 선택해야합니다.");
                         return;
                     }
                     parent.$("#setCtgryCodes").val(nodes);
                     parent.$.fn.colorbox.close();
                     parent.jsCtgrySel();
                     break;
                 case 'ST04' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
                     if ( nodesCnt > 1 ) {
                         alert("최대 1개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     }
                     if ( nodesCnt < 1 ) {
                         alert("최소 1개 카테고리는 선택해야합니다.");
                         return;
                     }
                     parent.$("#setCtgryCodes2").val(nodes);                
                     parent.$.fn.colorbox.close();
                     parent.jsCtgrySel2();
                     break;
                 case 'UM01' : <%-- 회원관리에서 사용 --%>
                     var nodesCnt = (nodes2.length + nodes3.length);
                     if ( nodesCnt > 10 ) {
                         alert("최대 10개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     } else if ( nodesCnt < 1 ) {
                         alert("최소 1개 카테고리는 선택해야합니다.");
                         return;
                     } else if(nodes2.length > 5 || nodes3.length > 5) {
                         alert("카테고리당 5개를 초과 선택할 수 없습니다.");
                         return;
                     }
                     parent.$("#setCtgryCodes").val(nodes);
                     parent.$.fn.colorbox.close();
                     parent.jsCtgrySel();
                     break;
             }

        };
        
        var jsCancel = function() {
            parent.$.fn.colorbox.close();
        }
        
        $(document).ready(function() {
            if (TREE_JSON_URL1 == "") {
                $("#treeTd1").remove();
            }
            if (TREE_JSON_URL2 == "") {
                $("#treeTd2").remove();
            } 
            if (TREE_JSON_URL3 == "") {
                $("#treeTd3").remove();
            }
            
            switch (PID) {
                case 'ST01' :
                    /** 2015.12.05 : KS CHOI 
                 	카테고리 변경 및 해당카테고리에서 무조건 1개를 선택할 이유가 없어 삭제 
                 	{[
                    var htmlVal = "<div style=\"color:red;\">※ 기술 카테고리에서는 반드시 1개 이상의 카테고리를 선택해 주세요.<br/>";
                    ]}**/
                    var htmlVal = "<div style=\"color:red;\">";
                    htmlVal += "※ 카테고리는 최대 5개까지 등록 가능합니다.<br/>";
                    /** 2015.12.05 : KS CHOI 
                 	카테고리 변경으로 인해 표준프레임워크 카테고리 삭제되었음 
                 	{[
                    htmlVal += "※ 표준프레임워크호환 서비스는 표준프레임워크 상호호환성 확인을 받은 서비스에 한해서만 등록이 가능합니다.</div>";
                    ]}**/
                    htmlVal += "</div>";
                    $("#guide").html(htmlVal);
                    break;
                case 'ST02' :
                    var htmlVal = "<div style=\"color:red;\">※ 최대 5개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
                    $("#guide").html(htmlVal);
                    break;
                case 'ST03' :
                    
                    break;
                case 'UM01' :
                    var htmlVal = "<div style=\"color:red;\">※ 카테고리당 최대 5개까지 총 15개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
                    $("#guide").html(htmlVal);
                    break;
            }   
        });
</script>
</head>
<body>
    <div class="w_100p">
        <div id="guide" class="mar_b5"></div>        
        <table class="w_100p">
            <tr>    
            
                <td id="treeTd1"  align="center">
                   <div id="treeDiv" class="mar_t5" style="margin: 0 auto;display: table;"></div>
                </td>            
            
                <td id="treeTd2" align="center">
                    <div id="treeDiv2" class="mar_t5" style="margin: 0 auto;display: table;"></div>
                </td>
             
                <td id="treeTd3" align="center">
                    <div id="treeDiv3" class="mar_t5" style="margin: 0 auto;display: table;"></div>
                </td>
            
            </tr>            
        </table>
        <div align="center" class="mar_t10">
            <input type="button" class="w80 mar_r10" onclick="jsCancel();" value="취소"></input>
	        <input type="button" class="w80" onclick="jsCategorySelect();" value="등록"></input>	        
	        
        </div>
    </div>
</body>
</html>