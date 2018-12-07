<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ page import="zes.core.utils.Converter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="keywords" content="" />
    <meta name="description" content="" />
    <title>카테고리 선택</title>  
    <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
    <!-- <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" /> -->
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script>
    <!--[if lt IE 9]>
        <script type="text/javascript" src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    <op:jsTag type="openworks" items="web-core"/>
    <op:jsTag type="spi" items="form,validate,extjs" />
    <link rel="stylesheet" href="/resources/cmmnty/default/css/common.css" />
    <link rel="stylesheet" href="/resources/web/theme/default/css/popup2.css" />
    <script type="text/javascript" src="<c:url value="/resources/intra/category/category.multitree.js" />"></script>
        <script type="text/javascript">                 
        var ROOT_VISIBLE   = false;
        var ENABLE_DND     = false;
<%--        var ROOT_TREE_ID   = '<%= GlobalConfig.HIGH_MENU_CD %>'; --%>
        var ROOT_TREE_ID = "0";
        var ROOT_TREE_TEXT = "카테고리 목록";
        var ROOT_TREE_TEXT1 = "SaaS";
        var ROOT_TREE_TEXT2 = "PaaS";
        var ROOT_TREE_TEXT3 = "IaaS";
    
        var IS_APPEND_LEAF     = true;
        var PARENT_NODE_ID_VAR = "highMenuCd";
        var NODE_ID_VAR        = "menuCd";
        var NODE_NM_VAR        = "menuNm";
        var NODE_ORDER_VAR     = "orderNo";

        PID = "<%=Converter.XSS(request.getParameter("PID"))%>";
        
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
            ctgryCodeUrl += "ctgryCodes=" + getCtgryCodes[i];
        }
        if (ctgryCodeUrl != "") {
            ctgryCodeUrl = "&" + ctgryCodeUrl;
        }

        var TREE_JSON_URL1 = "INC_categoryList.do?ctgryClCd=1002&langCd=" + langCode + ctgryCodeUrl;
        var TREE_JSON_URL2 = "INC_categoryList.do?ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
        var TREE_JSON_URL3 = "INC_categoryList.do?ctgryClCd=1003&langCd=" + langCode + ctgryCodeUrl;
        
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
             
             var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
             if ( nodesCnt > 15 ) {
                 alert("최대 15개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                 return;
             } else if ( nodesCnt < 1 ) {
                 alert("최소 1개 카테고리는 선택해야합니다.");
                 return;
             } else if(nodes1.length > 5 || nodes2.length > 5 || nodes3.length > 5) {
                 alert("카테고리당 5개를 초과 선택 하실 수 없으십니다.");
                 return;
             }
             parent.$("#setCtgryCodes").val(nodes);
             parent.$.fn.colorbox.close();
             parent.jsCtgrySel();

        };
        
        var jsCancel = function() {
            parent.$.fn.colorbox.close();
        }
        
        $(document).ready(function() {
            cnt = 3;
            if (TREE_JSON_URL1 == "") {
                $("#treeTd1").remove();
            }
            if (TREE_JSON_URL2 == "") {
                $("#treeTd2").remove();
            } 
            if (TREE_JSON_URL3 == "") {
                $("#treeTd3").remove();
            }
//             if(cnt == 1){
//                 $(".oneTree").css("margin", "10px auto");
//                 $(".oneTree").css("display", "table");                
//             }
           var htmlVal = "<div style=\"color:red;\">※ 분야별 최대 5개까지 총 10개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
           $(".guide_txt").html(htmlVal);
        });
</script>
</head>
<body class="winPopup selCate">
	<h2>카테고리 선택 <a href="#close" onclick="jsCancel();">닫기</a></h2>	
	<div>
		<ul class="notice">
			<li>※ 분야별 최대 5개까지 총 10개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.</li>
		</ul>
		
		<div class="cateWrap">
		 <fieldset>
       <legend><span>카테고리 선택/등록</span></legend>
         <table class="tbl_catepop">
           <tbody>
             <tr>
               <td id="treeTd1"  align="center" class="oneTree">
                 <div id="treeDiv" style="margin: 0 auto;display: table;"></div>
               </td>
               <td id="treeTd2"  align="center" class="oneTree">
                 <div id="treeDiv2" style="margin: 0 auto;display: table;"></div>
               </td>
               <td id="treeTd3"  align="center" class="oneTree">
                 <div id="treeDiv3" style="margin: 0 auto;display: table;"></div>
               </td>
             </tr>
          </tbody>
        </table>
      </fieldset>
		</div>

		<div class="btnArea cen">
			<input type="reset" onclick="jsCancel();" value="취소" class="btns st2" />
			<input type="button" onclick="jsCategorySelect();" value="등록" class="btns st1" />
		</div>
	</div>

  <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>	
 </body>
</html>
