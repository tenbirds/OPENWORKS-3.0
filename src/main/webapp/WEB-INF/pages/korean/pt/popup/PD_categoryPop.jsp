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
      
	<%--     <op:jsTag type="openworks" items="web-core"/> --%>
	<script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/resources/web/theme/common/js/jquery-migrate-1.1.1.min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_globalConfig.do"></script>

    <script type="text/javascript" src="${contextPath}/resources/openworks/spi/jquery/colobox/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="${contextPath}/component/javascript/MD_massageConfig.do"></script>
    
    <op:jsTag type="spi" items="form,validate,extjs" />
    
    <link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
	
	<!--     <script type="text/javascript" src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script> -->
	<!--     <script type="text/javascript" src="/resources/web/theme/default/js/common.js"></script> -->
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/resources/web/theme/default/js/html5shiv.js"></script> 
    <![endif]-->
    
    <script type="text/javascript" src="<c:url value="/resources/intra/category/category.multitree.js"/>"></script>
    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
    <link rel="stylesheet" href="/resources/cmmnty/default/css/common.css" />
    <!-- <link rel="stylesheet" href="/resources/web/theme/default/css/popup2.css" /> -->
    <link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
    
    <script type="text/javascript">
    
        var ROOT_VISIBLE   = false;
        var ENABLE_DND     = false;
		<%-- var ROOT_TREE_ID   = '<%= GlobalConfig.HIGH_MENU_CD %>'; --%>
        var ROOT_TREE_ID = "0";
        var ROOT_TREE_TEXT = "카테고리 목록";
        var ROOT_TREE_TEXT1 = "IaaS";
        var ROOT_TREE_TEXT2 = "SaaS";
        var ROOT_TREE_TEXT3 = "PasS";
        var ROOT_TREE_TEXT4 = "SCS";
    
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
                //var PANEL_SIZE_WIDTH = 400;
                var TREE_JSON_URL1 = "";                
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "INC_categoryList.do?ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL4 = "";
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
                var TREE_JSON_URL2 = "INC_categoryList.do?ctgryClCd=1002&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL3 = "";
                var TREE_JSON_URL4 = "";
                break;     
            case 'ST03' :
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
               // var PANEL_SIZE_WIDTH = 400;
                var TREE_JSON_URL1 = "INC_categoryList.do?ctgryClCd=1003&langCd=" + langCode + ctgryCodeUrl;                
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "";
                var TREE_JSON_URL4 = "";
                break;
                
            case 'ST04' :
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
               // var PANEL_SIZE_WIDTH = 400;
                var TREE_JSON_URL1 = "";
                var TREE_JSON_URL2 = "";
                var TREE_JSON_URL3 = "";
                var TREE_JSON_URL4 = "INC_categoryList.do?ctgryClCd=1004&langCd=" + langCode + ctgryCodeUrl;
                
                break;
            case 'BM01' :
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

                var TREE_JSON_URL1 = "INC_categoryList.do?ctgryClCd=1003&langCd=" + langCode + ctgryCodeUrl;         
                var TREE_JSON_URL2 = "INC_categoryList.do?ctgryClCd=1002&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL3 = "INC_categoryList.do?ctgryClCd=1001&langCd=" + langCode + ctgryCodeUrl;
                var TREE_JSON_URL4 = "";
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
                var TREE_JSON_URL4 = "";
                break;
            case 'BM02' :
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
                var TREE_JSON_URL4 = "";
                break;
        }
        
        var jsCategorySelect = function() {
            
             var nodes = "";
             var nodes1 = new Array();
             var nodes2 = new Array();
             var nodes3 = new Array();
             var nodes4 = new Array();
             
             var cc1 = "";
             var cc2 = "";
             var cc3 = "";
             
             if(treePanel1) {
                 var nodes1 = treePanel1.getChecked("id");
             }
             
             if(treePanel2) {
                 var nodes2 = treePanel2.getChecked("id");                 
             }
             
             if(treePanel3) {
                 var nodes3 = treePanel3.getChecked("id");                 
             }
             
             if(treePanel4) {
                 var nodes4 = treePanel4.getChecked("id");                 
             }
             
             if ((nodes1.length > 0) && (nodes2.length > 0)) {
                 cc1 = ","
             }
             if (((nodes1.length + nodes2.length) > 0) && (nodes3.length > 0)){
                 cc2 = ","
             }
             if (((nodes1.length + nodes2.length + nodes3.length) > 0) && (nodes4.length > 0)){
                 cc3 = ","
             }
             nodes = nodes1 + cc1 + nodes2 + cc2 + nodes3 + cc3 + nodes4;             
             
             
             switch (PID) {
                 case 'ST01' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length + nodes4.length);
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
                             var techNode = treePanel2.getNodeById("6202_44");
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
                         alert("기술 카테고리에서 반드시 1개 이상의 카테고리를 선택하셔야 합니다.");
                         return;
                     }
                     ]}*/
                     parent.$("#setCtgryCodes").val(nodes);                
                     parent.$.fn.colorbox.close();
                     parent.jsCtgrySel();
                     break;
                 case 'ST02' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length + nodes4.length);
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
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length + nodes4.length);
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
                     
                 case 'ST04' :
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length + nodes4.length);
                     
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
                 case 'BM01' : // 비즈매칭 게시판 사용
                     var nodesCnt = (nodes1.length + nodes2.length + nodes3.length);
                     if ( nodes1.length > 1) {
                         alert("분류별 최대 1개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     } 
                     if ( nodes2.length > 1) {
                         alert("분류별 최대 1개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
                     }
                     if ( nodes3.length > 1) {
                         alert("분류별 최대 1개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
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
                     
                 case 'UM01' : <%-- 회원관리에서 사용 --%>
	                 var nodesCnt = (nodes2.length + nodes3.length);
	                 if ( nodesCnt > 15 ) {
	                     alert("최대 10개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
	                     return;
	                 } else if ( nodesCnt < 1 ) {
	                     alert("최소 1개 카테고리는 선택해야합니다.");
	                     return;
	                 } else if(nodes2.length > 5 || nodes3.length > 5) {
	                     alert("카테고리당 5개를 초과 선택 하실 수 없으십니다.");
	                     return;
	                 }
	                 parent.$("#setCtgryCodes").val(nodes);
	                 parent.$.fn.colorbox.close();
	                 parent.jsCtgrySel();
	                 break;
                 case 'BM02' : // 판매하기 비즈매칭사용
	                 var nodesCnt = ( nodes2.length + nodes3.length);
                 
	                 if(nodes1.length > 5 || nodes2.length > 5 || nodes3.length > 5 ){
	                     alert("각 분류별로 최대 5개 카테고리를 등록할 수 있습니다.\n선택된 카테고리를 확인해 주세요.");
                         return;
	                 } else if ( nodesCnt < 1 ) {
	                     alert("최소 1개 카테고리는 선택해야합니다.");
	                     return;
	                 } 
	                 
	                 if(!confirm("카테고리를 등록하시겠습니까?")) return false;
	                 
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
            if (TREE_JSON_URL4 == "") {
                $("#treeTd4").remove();
            }
//             if(cnt == 1){
//                 $(".oneTree").css("margin", "10px auto");
//                 $(".oneTree").css("display", "table");                
//             }
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
                    $(".guide_txt").html(htmlVal);
                    break;
                case 'ST02' :
                    var htmlVal = "<div style=\"color:red;\">※ 최대 5개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
                    $(".guide_txt").html(htmlVal);
                    break;                  
                case 'ST04' :
                    var htmlVal = "<div style=\"color:red;\">※ 최대 5개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
                    $(".guide_txt").html(htmlVal);
                    break;                  
                case 'BM01' :
                    var htmlVal = "<div style=\"color:red;\">※ 비즈매칭 연결된 카테고리는 회원님이 궁굼하신 사항이나 요청사항에 빠르게 판매자들이 답변을 할 수 있도록 하기위한 설정입니다.<br/>";
                    htmlVal += "※ SaaS, PaaS, IaaS 각 카테고리별 최대 1개씩 총 3개까지 등록 가능합니다. <br/>";
                    htmlVal += "※ 반드시 1개 이상의 카테고리를 선택해주세요.</div>";
                    $(".guide_txt").html(htmlVal);
                    break;                  
                case 'UM01' :
                    var htmlVal = "<div style=\"color:red;\">※ 카테고리당 최대 5개까지 총 15개까지 등록 가능합니다. 등록할 카테고리를 선택해 주세요.<br/></div>";
                    $(".guide_txt").html(htmlVal);
                    break;
                case 'BM02' :
                    var htmlVal = "<div style=\"color:red;\">※ 비즈매칭 알림 설정은 이용자가 비즈매칭 서비스(IT전문가서비스, 솔루션/서비스 요청 서비스)를 문의할 때 선택하신 항목과 매칭이 되면 판매자에게 신규등록 내역을 알려주는 서비스 입니다.<br/> 각 분류 별로 최대 5개까지 설정할 수 있습니다.</div>";
                    $(".guide_txt").html(htmlVal);
                    break;
            }
            
        });
	</script>
</head>
<body class="winPopup qna">
	
	<h2>카테고리 선택 <a href="#"  onclick="jsCancel();">닫기</a></h2>

	<!-- popup content -->
   	<div class="section">
		<p class="guide_txt">최대 5개까지 등록 가능합니다. 등록할 태그를 선택해주세요.</p><br/>
		
       	<fieldset>
       
       	<legend><span>카테고리 선택/등록</span></legend>
       
       	<table class="tbl_catepop">
       	<tbody>
		<tr>
			<td id="treeTd2"  align="center" class="oneTree">
      			<div id="treeDiv2" style="margin: 0 auto;display: table;"></div>					   
           	</td>
           	<td id="treeTd3"  align="center" class="oneTree">
               	<div id="treeDiv3" style="margin: 0 auto;display: table;"></div>
           	</td>    
           	<td id="treeTd1"  align="center" class="oneTree">
              	<div id="treeDiv" style="margin: 0 auto;display: table;"></div>	                   
           	</td>
           	<td id="treeTd4"  align="center" class="oneTree">
               	<div id="treeDiv4" style="margin: 0 auto;display: table;"></div>
           	</td>                                    
        </tr>
       	</tbody>       
       	</table>
       
       	</fieldset>
       
       	<div class="sub_cate">
       	</div>

       	<div class="btn_area">
			<div class="btn_pop_c">                     
            	<div class="btn_navi">
                	<a href="#reg" onclick="jsCategorySelect();"><span class="gt" style="color:white;">등록</span></a>                            
               	</div>
               	<div class="btn_navi_g">
                	<a href="#cancel" onclick="jsCancel();"><span class="cancel">취소</span></a>
               	</div>
            </div>
       	</div>
   </div>
      
</body>
</html>
