<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<title>회원 | 씨앗 마켓</title>
	<op:jsTag type="spi" items="form, validate, multifile" />
    <script type="text/javascript">
  	//<![CDATA[
	    $(document).ready(function() {
	        
	        $("#ckMultiBoxAll").click(function() {  
	       		if($(this).is(':checked')) {        
	       			$("input[name=ckMultiBox]").prop("checked", true);   
	       		} else {        
	       			$("input[name=ckMultiBox]").prop("checked", false);    
	       		}
	       	}); 
   	 	});
	    var checkSelectedValue = function (){
		    var valueArr = new Array();
		    var list = $("input[name='ckMultiBox']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){
		            valueArr.push(list[i].value);
		        }else{
		            
		        }
		    }
		    $("#multiCheck").val(valueArr);
		    $("#multiCkSize").val(valueArr.length);
		};
		 // 다중 승인 
	   	var jsButConfirm = function(){

       	 	if(validation.dataForm() === false){
   	        	return;
   	   	 	}
       	 	checkSelectedValue();
       	 	var cmmntyId = $("#cmmntyId").val();
       	// 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
       	 	var multiCkSize = $("#multiCkSize").val();
 	       	 if ( confirm("총 "+multiCkSize+"명을 가입 승인하시겠습니까?") ) {
 	       	 var cmmntyId = $("#cmmntyId").val();
 	 	        $("#dataForm").ajaxSubmit({
	   	            url      : "INC_cmOptMemberShipInfoUpdate.do?mberState=1003",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	            if (response == "true")  {
	   	                    alert("가입 승인 되었습니다.");
	   	                 	jrMove("BD_index.do?cmmntyId="+cmmntyId);
	   	                } else { 
	   	                	alert("가입 승인 중 오류가 발생했습니다.");
	   	                   	return;
	   	                }
	   	            }
	   	        });
 	       	 }
	   };
    	 // 다중 승인 거부
	   var jsButCancle = function(){
	       	if(validation.dataForm() === false){
	           return;
		   	}
	       	checkSelectedValue();
	       	var cmmntyId = $("#cmmntyId").val();
	     // 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
			var multiCkSize = $("#multiCkSize").val();
	       	if ( confirm("총 "+multiCkSize+"명을 가입 거절 하시겠습니까?") ) {
	 	        $("#dataForm").ajaxSubmit({
	 	           url      : "INC_cmOptMemberShipInfoUpdate.do?mberState=1002",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
	   	            	if (response == "true")  {
	   	                   	("가입 거절 되었습니다.");
	   	                 	jrMove("BD_index.do?cmmntyId="+cmmntyId);
	   	                } else { 
	   	                	alert("가입 거절 중 오류가 발생했습니다.");
	   	                   	return;
	   	                }
	   	            }
	   	        });
	       	}
	   };
	   
	   var jsButWithdraw = function(){
	       if(validation.dataForm() === false){
	           return;
		   }
	       checkSelectedValue();
	       //커뮤니티회원강제탈퇴	: >>1001:운영자강제탈퇴		1002:관리자강제탈퇴
			// 커뮤니티회원상태 :>>>1001:가입중		1002:가입거절		1003:정상		1004:탈퇴
		   var cmmntyId = $("#cmmntyId").val();
	       var multiCkSize = $("#multiCkSize").val();
	       	if ( confirm("총 "+multiCkSize+"명을 강제 탈퇴 하시겠습니까?") ) {
	       		
	 	        $("#dataForm").ajaxSubmit({
	 	           url      : "INC_cmOptMemberShipInfoUpdate.do?mberState=1004",
	   	            type     : "POST",
	   	            dataType : "text",
	   	            success  : function(response) {
		   	            if (response == "true")  {
		   	                alert("강제 탈퇴 되었습니다.");
		   	             	jrMove("BD_index.do?cmmntyId="+cmmntyId);
		   	            } else { 
		   	                alert("강제 탈퇴 중 오류가 발생했습니다.");
		   	                return;
		   	           }
	   	         	}
	   	        });
	       	}
	   };
	   // 페이지 이동
	   var jrMove = function(movepage){
	        $("#dataForm").attr("action",movepage).submit();
	   };
    
       // 커뮤니티  회원정보 팝업 view 
       var jsMemberPopupView = function(el, cmmntyId, langCode, cmmntyMberId, mberStateCd) {
           $(el).colorbox({
              	title : "커뮤니티 회원 정보",         
    			href      : "PD_cmOptMemberShipView.do?cmmntyId="+cmmntyId+"&langCode="+langCode+"&cmmntyMberId="+cmmntyMberId+"&mberStateCd="+mberStateCd,
    			width : "790px",
    	        height : "700px",
    	       overlayClose : false,
              escKey : false,
              closeButton : false,
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
            $("#dataForm input[name=q_currPage]").val(p);
            $("#dataForm").submit();
        };    
        
        var validation = {     
               /** ajax submit validation **/
       		   dataForm : function() {
       		       /** 지역변수 **/
       		       if($("input[name=ckMultiBox]").is(':checked') == false){
       		           		alert("최소 한개이상은 체크하셔야 합니다.");
                          	$("input[name=ckMultiBox]").focus();
       		           return false;
       		       }	
       		   }
       	};
        
        //통합검색바
        var jsSearchAction = function() {

            $('#q_currPage').val("1");
         	$('#dataForm').submit();
        };
        
		// 회원구분 이동
        var topMberMove = function(mberStateCd){
            
            $("#q_mberStateTab").val(mberStateCd);
            $('#q_currPage').val("1");
            $('#dataForm').submit();
            
       	};

	//]]>
	 </script>
</head>
<body>
	<form name="dataForm" id="dataForm" method="post" action="BD_index.do">
		<input type="hidden" id="hidPopup" name="hidPopup" value=""/>
		<input type="hidden" name="multiCheck" id="multiCheck"  value="" />
		<input type="hidden" name="multiCkSize" id="multiCkSize"  value="" />
		<input type="hidden" name="cmmntyId" id="cmmntyId"  value="<c:out value='${openCmUserView.cmmntyId}'/>" />
		<input type="hidden" name="langCode" id="langCode"  value="<c:out value='${openCmUserView.langCode}'/>" />
		<input type="hidden" name="userId" id="userId"  value="<c:out value='${openCmUserView.userId}'/>" />
		<input type="hidden" name="q_mberStateTab" id="q_mberStateTab"  value="<c:out value='${param.q_mberStateTab}'/>" />
		<!-- container -->
		
		<div id="container">
			<jsp:include page="/korean/cm/admin/cmOptAdminMenu/INC_cmOptAdminMenuLeft.do?menuCode=cmoptmembership&amp;cmmntyId=${openCmUserView.cmmntyId}" flush="true"></jsp:include>
			<!-- //side navigation bar -->

			<!-- contents -->
			<div id="contents">
				<h2>회원</h2>
				<div class="tab_style">
					<ul>
						<li><a href="#none" id="1001" onclick="topMberMove('1001');" <c:if test="${param.q_mberStateTab== 1001 || empty param.q_mberStateTab}">class="on"</c:if>>가입회원</a></li>
                		<li><a href="#none" id="1003" onclick="topMberMove('1003');" <c:if test="${param.q_mberStateTab == 1003}">class="on"</c:if>>전체회원</a></li>                
                		<li><a href="#none" id="1004" onclick="topMberMove('1004');" <c:if test="${param.q_mberStateTab == 1004}">class="on"</c:if>>탈퇴회원</a></li>            
					</ul>
				</div>
				<div class="btn_area">
					<div class="btn_r">
					<c:if test="${param.q_mberStateTab == 1001 || empty param.q_mberStateTab }">
						<div class="btn_navi"><a href="#none" onclick="jsButConfirm();" ><span class="join">가입 승인</span></a></div>
						<div class="btn_navi_g"><a href="#none" onclick="jsButCancle();" ><span class="no_join">가입 거절</span></a></div>
					</c:if>
                    <c:if test="${param.q_mberStateTab == 1003}">	
                    	<div class="btn_navi"><a href="#none"  onclick="jsButWithdraw();"  ><span class="withdraw">강제탈퇴</span></a></div>
                    </c:if>
					</div>
				</div>
				<span class="totalcount">
					Total <em class="tx_orange"><c:out value='${pager.totalNum}'/></em>
				</span>
				<!-- 가입회원 start -->
				<c:if test="${param.q_mberStateTab== 1001 || empty param.q_mberStateTab}">
				<table class="tbl_list">
					<caption>
						<strong>회원</strong>
						<details>
							<summary>닉네임, 회원 구분, 가입신청일 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:8%">
						<col style="width:*">
						<col style="width:15%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" name="ckMultiBoxAll" id="ckMultiBoxAll" title="전체선택"/></th>
							<th scope="col">닉네임</th>
							<th scope="col">회원구분</th>
							<th scope="col">가입신청일</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMberId}'/>" title="ckMultiBox<c:out value='${status.count}'/>" /></td>
                            <td><c:if test="${param.q_mberStateTab != 1004}"> <a href="#none" id="popView" onclick="jsMemberPopupView(this, '<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>');"><c:out value='${data.ncnm}'/></a> </c:if>
                            <c:if test="${param.q_mberStateTab == 1004}"><c:out value='${data.ncnm}'/></c:if>
                            </td>
                            <td><c:out value='${data.userTyNm}'/></td>
                            <td class="date"><c:out value='${data.sbscrbReqstDt}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="4" />
					</tbody>
				</table>
				</c:if>
				<!-- 가입회원 end -->
				
				<!--전체회원 start -->
				<c:if test="${param.q_mberStateTab == 1003}">
				<table class="tbl_list">
					<caption>
						<strong>회원</strong>
						<details>
							<summary>닉네임, 회원 구분, 가입신청일 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:8%">
						<col style="width:*">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" name="ckMultiBoxAll" id="ckMultiBoxAll"  title="전체선택"></th>
							<th scope="col">닉네임</th>
							<th scope="col">방문수</th>
							<th scope="col">작성글수</th>
							<th scope="col">댓글수</th>
							<th scope="col">회원 구분</th>
							<th scope="col">최종방문일<br/>가입일</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><input type="checkbox" id="ckMultiBox_<c:out value='${status.count}'/>"  name="ckMultiBox"   value="<c:out value='${data.cmmntyId}'/>_<c:out value='${data.langCode}'/>_<c:out value='${data.cmmntyMberId}'/>"  title="ckMultiBox<c:out value='${status.count}'/>"/></td>
                            <td><a href="#none" id="popView" onclick="jsMemberPopupView(this, '<c:out value='${data.cmmntyId}'/>','<c:out value='${data.langCode}'/>', '<c:out value='${data.cmmntyMberId}'/>','<c:out value='${data.mberStateCd}'/>');"><c:out value='${data.ncnm}'/></a></td>
                            <td><c:out value='${data.cmVisitCount}'/></td><!--  방문수 -->
                            <td><c:out value='${data.cmMberBbsCount}'/></td>
                            <td><c:out value='${data.cmMberBbsCmtCount}'/>  </td>
                           	<td><c:out value='${data.userTyNm}'/></td>
                            <td class="date"><c:out value='${data.visitDt}'/><br/>(<c:out value='${data.sbscrbConfmDt}'/>)</td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="7" />
					</tbody>
					
				</table>
				</c:if>
				<!--전체회원 end -->
				
				<!-- 탈퇴회원 start -->
				<c:if test="${param.q_mberStateTab == 1004}">
				<table class="tbl_list">
					<caption>
						<strong>회원</strong>
						<details>
							<summary>닉네임, 탈퇴 구분, 회원 구분, 탈퇴일 정보를 제공합니다.</summary>
						</details>
					</caption>
					<colgroup>
						<col style="width:*">
						<col style="width:15%">
						<col style="width:15%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">닉네임</th>
							<th scope="col">탈퇴 구분</th>
							<th scope="col">회원 구분</th>
							<th scope="col">탈퇴일</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="index" value="<c:out value='${pager.indexNo}'/>"/>
                    <c:forEach items="${pager.list}" var="data" varStatus="status">
                        <tr>
                            <td><c:out value='${data.ncnm}'/></td>
                            <c:if test="${param.q_mberStateTab == 1004}"><c:out value='${data.ncnm}'/></c:if>
                            <td><c:out value='${data.enfrcSecsnNm}'/></td>
                            <td><c:out value='${data.userTyNm}'/></td>
                            <td class="date"><c:out value='${data.secsnDt}'/></td>
                        </tr>
                    </c:forEach>
                    <op:no-data obj="${pager.list}" colspan="4" />
					</tbody>
				</table>
				</c:if>
				<!-- 탈퇴회원  end -->
				<!-- paging -->
				<op:pager pager="${pager}" page="pager/cmPager.jsp" />
				<!-- //paging -->
			</div>
			<!-- //contents -->
		</div>
		<!-- //container -->
	</form>
</body>
</html>