<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html lang="ko">
<head>
<title>서비스 선택</title>

<op:jsTag type="openworks" items="web-core"/>

<link rel="shortcut icon" href="/resources/web/theme/default/images/common/ico/seart_favicon.ico">
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/popup2.css" />
<link rel="stylesheet" type="text/css" href="/resources/web/theme/default/css/common.css" />

<script type="text/javascript">
//<!--
$(document).ready(function() {
    
});

var jsProductSubmit = function (){ 

   var purchsNo = $(":radio[name='purchsNo']:checked").val();
   var goodsNm = $("#goodsNm1").text();

   if(purchsNo == null){
       alert("서비스를 선택해주세요");
       return;
   }else{
       alert(goodsNm )
	   parent.$("#estnColumn7").val(goodsNm);
	   parent.$.fn.colorbox.close();
   }

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
                <h1> 서비스선택 </h1>
            </div>
            <!-- //header -->
            <!-- popup content -->
            <div class="section">
                <dl class="clear">
                    <dd class="float_l mar_b10 mar_l2">
	                    <form >
		                    <input type="hidden" name="q_currPage" id="q_currPage" value="<c:out value='1'/>" />
							<input type="hidden" name="q_sortName" id="q_sortName" value="<c:out value=''/>"/>
							<input type="hidden" name="q_sortOrder" id="q_sortOrder" value="<c:out value=''/>"/>
		                    
					            <select name="q_searchKeyType" id="q_searchKeyType" title="서비스명 검색" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width:115px; margin-left:100px">
						            <option value="GOODS_NM___1002"<c:if test="${param.q_searchKeyType eq 'GOODS_NM___1002'}"> selected="selected"</c:if>>서비스명</option>
						        </select>
						        
					            <input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>"/>
					            <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>"  maxlength='50' style="vertical-align: top; margin-top:20px;" title="검색하실 단어 입력">
					            
		                        <span id="idspan2" style="vertical-align: super;"></span>
					            <input type="image" alt="검색"  src="/resources/web/theme/default/images/btn/btn_g_search.gif"  style="margin-top:20px;">
	                    </form>
                    </dd>
                </dl>
            </div>
            
            
            
            <table id="ziptable" cellspacing="0" border="0" summary="서비스선택" class="popup_list">
                <caption class="hidden">서비스선택</caption>
                <colgroup>
                    <col width="10%" />
                    <col width="45%" />
                    <col width="45%" />
                </colgroup>
                <thead>
                <c:forEach items="${pager.list}" var="productVo" varStatus="status">
                
                
                </c:forEach>
                    <tr>
                        <th>&nbsp;</th>
                        <th>구매번호</th>
                        <th class="lr_none">서비스명</th>
                    </tr>
                </thead>
                <tbody>
	                <c:forEach items="${pager.list}" var="productVo" varStatus="status">
	                   <tr>
	                       <td class="lr_none" style="text-align:center;"><label id="purchsNo"><input type="radio" name="purchsNo" id="purchsNo" value="${productVo.purchsNo}" <c:if test="${productVo.purchsNo eq PurchsNo}">checked="checked"  </c:if>/> </label></td>
	                       <td class="lr_none" style="text-align:center;">${productVo.purchsNo}</td>
	                       <td class="lr_none" style="text-align:center;" id="goodsNm${productVo.purchsNo}">${productVo.goodsNm}</td>
	                   </tr>
	                </c:forEach>
	                <c:if test="${empty pager.list}">
		                <tr>
		                   <td colspan="3" style="text-align: center;"><strong>데이터가 없습니다.</strong></td>
		                </tr> 
	                </c:if>
                </tbody>
            </table>
            
	        <!-- 페이징 -->
	        <op:pager pager="${pager}" page="pager/webPager.jsp" script="jsListReq" />
	        <!-- //페이징 -->
	        <br/>
	        
	        <!-- 버튼 -->
	        <div class="btn_area" style="margin: 0 auto; width: 170px;">
	                <div class="btn_navi"><a href="#" onclick="jsProductSubmit(); return false;"><span class="list">선택</span></a></div>
	                <div class="btn_navi_g"><a href="#" onclick="parent.jQuery.colorbox.close(); "><span class="disk">취소</span></a></div>
	        </div>
	        <!-- //버튼 -->
        
        </div>
    </div>
    
    
    
    
    
    <!-- //컨텐츠영역 -->
    
    
</body>
</html>