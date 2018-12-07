<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="ko">
<head>
<title>Product Select</title>

<op:jsTag type="openworks" items="web-core"/>

<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/common.css" />

    <link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/style.css" />

<script type="text/javascript">
//<!--
$(document).ready(function() {
    
});

var jsProductSubmit = function (){ 

   var purchsNoId = $(":radio[name='purchsNo']:checked").attr("id"); // 선택한 서비스명
   var purchsNo = $(":radio[name='purchsNo']:checked").val(); //선택한 구매번호
   
   if(purchsNo == null){
       alert(Message.msg.selProduct);
       return;
   }else{
       var num = purchsNoId.substring(8);
       var goodsCd = $("#goodsCd"+num).val(); //선택한 구매번호
       
       var temp = purchsNo+"_"+goodsCd;
       
       parent.$("#estnColumn7").val($("#goodsNm"+num).text());
       parent.$("#purchsNo").val(temp);
       parent.$("#chkPurchsNo").val(purchsNo);
       parent.$.fn.colorbox.close();
   }

};
var jsListReq = function (page){ 
$("#q_currPage").val(page);
dataForm.submit();
};

var jsSearch = function(page){
    
    var searchKey = $("#q_searchKeyType");
    var searchVal = $("#q_searchVal");
    
    if("" == $.trim($("#q_searchVal").val()) &&  "" != $.trim(searchKey.val())){
        alert(Message.msg.chkSearchVal); 
        searchVal[0].focus();
        return false;
    }
    
    if("" == $.trim(searchKey.val())){
        $("#q_searchVal").val("");
        $("#q_searchVal").val("");
    }
    dataForm.submit();
};

//-->
</script>
</head>
<body>
<!-- 컨텐츠영역 -->
    <div id="pop_wrap">
        <div class="pop_container">
            <!-- popup header -->
            <div class="header">
                <h1> Product Select </h1>
            </div>
            <!-- //header -->
            <!-- popup content -->
            <div class="section">
                <dl class="clear">
                    <dd class="float_l mar_b10 mar_l2" style="float: right;margin-bottom: 10px;">
                        <form id="dataForm" name="dataForm" action="PD_product.do" >
                            <input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='1'/>" />
                            <input type="hidden" name="q_sortName" id="q_sortName" value=""/>
                            <input type="hidden" name="q_sortOrder" id="q_sortOrder" value=""/>
                            <input type="hidden" name="bbsCd"  value="<c:out value='${param.bbsCd}'/>"/>
                            <input type="hidden" name="domainCd" id="domainCd" value="<c:out value='${param.domainCd}'/>"/>
                            <input type="hidden" name="chkPurchsNo" id="chkPurchsNo" value="<c:out value='${param.chkPurchsNo}'/>"/>
                                <select name="q_searchKeyType" id="q_searchKeyType" title="Product name search" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width:115px; margin-left:100px">
                                    <option value="GOODS_NM___1009"<c:if test="${param.q_searchKeyType eq 'GOODS_NM___1009'}"> selected="selected"</c:if>>Product name</option>
                            </select>
                            
                            <div class="search" style="float:right; height: 24px; margin-left: 10px;">  
                                <input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>"/>
                                <input type="text" value="<c:out value='${param.q_searchVal}'/>"  title="검색하실 단어 입력" name="q_searchVal" id="q_searchVal" class="input"  maxlength='50' style="height: 24px;" >
                                <input type="button" class="btn" title="검색" onclick="jsSearch(); return false;">
                            </div>
                        </form>
                    </dd>
                </dl>
            </div>
            
            Total <em class="orange"><c:out value='${pager.totalNum}'/></em>
            <c:set var="index" value="${pager.indexNo}"/>
            <table  cellspacing="0" border="0" summary="Product Select" class="tbl_pop">
                <caption class="hidden">Product Select</caption>
                <colgroup>
                    <col width="10%" />
                    <col width="30%" />
                    <col width="45%" />
                </colgroup>
                <thead>
                    <tr style="text-align: center;">
                        <th >&nbsp;</th>
                        <th  style="text-align: center;">Purchase number</th>
                        <th  style="text-align: center;">Product name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pager.list}" var="productVo" varStatus="status">
                       <input type="hidden" value="${productVo.goodsCd}" name="goodsCd" id="goodsCd${index-status.index}"/>
                       <tr>
                           <td class="lr_none" style="text-align:center;">
                               <label id="purchsNo">
                                   <input type="radio" name="purchsNo" id="purchsNo${index-status.index}" value="${productVo.purchsNo}" <c:if test="${productVo.ctgryClCd eq 1 or param.chkPurchsNo eq productVo.purchsNo}">checked="checked"</c:if>/> 
                               </label>
                           </td>
                           <td class="lr_none" style="text-align:center;"><c:out value='${productVo.purchsNo}'/></td>
                           <td class="lr_none" style="text-align:center;" id="goodsNm${index-status.index}"><c:out value='${productVo.goodsNm}'/></td>
                       </tr>
                    </c:forEach>
                    <c:if test="${empty pager.list}">
                        <tr>
                           <td colspan="3" style="text-align: center;"><strong>There is no data.</strong></td>
                        </tr> 
                    </c:if>
                </tbody>
            </table>
            
            
            
            <!-- 페이징 -->
            <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
            <!-- //페이징 -->
            <br/>
            
            <!-- 버튼 -->
            <div class="btn_area" style="margin: 0 auto; width:95px;">
                <div class="btn_navi"><a href="#" onclick="jsProductSubmit(); return false;"><span class=""disk"">Select</span></a></div>
            </div>
            <!-- //버튼 -->
        
        </div>
    </div>
    
    <!-- //컨텐츠영역 -->
    
</body>
</html>