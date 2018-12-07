<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html lang="ko">
 <head>
	<meta charset="UTF-8" />
	<title>POPUP - 기관명 검색</title>
	<link rel='stylesheet' href='/cloud_ver2/new_cloud/css/v3_pop.css' />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="description" content="공공기관의 민간클라우드서비스를 위한 클라우드전문 마켓플레이스 클라우드스토어 씨앗" />
	<script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
	<script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
	<script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>	
	<link rel="stylesheet" type="text/css" href="/resources/openworks/theme/default/css/loading.css" />
	<script type="text/javascript">
	    $(function(){$(window).on('scroll',function(){$(".loading-container").stop().animate({ "top": ($(window).scrollTop()  + ($(window).height()/2)) + "px"}, "slow");});});
	</script>
		
	<script type="text/javascript">
	$().ready(function(){

		$("#allCheck1").click(function(){
		    if ($("#allCheck1").is(":checked")){
		        $(".buseoCodes").attr("checked", true);
        	}else{
        	    $(".buseoCodes").attr("checked", false);
        	} 
		});
		
		$("#allCheck2").click(function(){
		    if ($("#allCheck2").is(":checked")){
		        $(".realBuseoCodes").attr("checked", true);
        	}else{
        	    $(".realBuseoCodes").attr("checked", false);
        	} 
		});
		
		/* "realBuseoCodes" */
	});
	
	
	    var jsClose = function() {
	        parent.$.colorbox.close();
	    }
	    
	    var jsSearch = function(page){
	        if($("#q_searchVal").val() == ''){
	            alert("검색값을 입력해주세요");
		      	$("#q_searchVal").focus();
	            return false;
	        }
			
            $("#q_currPage").val(page);
            $("#loading-container").show();
	        document.dataForm.method = "POST";
	        document.dataForm.action = "PD_organSearchList.do";
	        document.dataForm.submit();
	    }

  		var jsRealOrganInsert = function(){
	        
	    	var chkCnt=0;
			$("input[name=buseoCodes]:checked").each(function() {
				var requstChkVal = $(this).val();
				chkCnt ++;
			});

			if(chkCnt == 0 ){ alert("한개 이상의 기관을 선택하세요."); return;}
			
			 $("#loading-container").show();
			dataString = $("#dataForm").serialize();
			$.ajax({
				type: "POST",
				url: "BD_RealOrganInsert.do",
				data : dataString,
				dataType: "json",
				async:       false,
				success: function(response){
				   if(!response.result){
					     alert("등록하는데 이상이 발견하였습니다. 다시 시도해주시기 바랍니다.");
					}else{
					     document.location.reload();
					     /*	parent.$("#dataForm input[name=bbsCd]").val("${param.bbsCd}");
						parent.$("#dataForm input[name=bbscttSeq]").val("${param.bbscttSeq}");
						parent.jsRequest("dataForm", "BD_board.view.do", "get");
						parent.$.fn.colorbox.close(); */
					}
				}
			});
		}
  		
		var jsRealOrganDelete = function(){
	        
	    	var chkCnt=0;
			$("input[name=realBuseoCodes]:checked").each(function() {
				var requstChkVal = $(this).val();
				chkCnt ++;
			});

			if(chkCnt == 0 ){ alert("한개 이상의 기관을 선택하세요."); return;}
			
			$("#loading-container").show();
			var confirmMsg = "선택하신 실제이용기관을 삭제 하시겠습니까?";
			if(confirm(confirmMsg)) {
				dataString = $("#dataForm").serialize();
				$.ajax({
					type: "POST",
					url: "BD_RealOrganDelete.do",
					data : dataString,
					dataType: "json",
					async:       false,
					success: function(response){
					   if(!response.result){
							alert("삭제하는데 이상이 발견하였습니다. 다시 시도해주시기 바랍니다.");
						}else{
						    document.location.reload();
						   /*  	parent.$("#dataForm input[name=bbsCd]").val("${param.bbsCd}");
							parent.$("#dataForm input[name=bbscttSeq]").val("${param.bbscttSeq}");
							parent.jsRequest("dataForm", "BD_board.view.do", "get");
							parent.$.fn.colorbox.close(); */
						}
					}
				});
			}
		}
	</script>
 </head>

 <body class="winPopup">

 <h2>실제 이용기관 검색<a  href="#close" onclick="jsClose();">닫기</a></h2>
<form name="dataForm" id="dataForm" onsubmit="return jsSearch(1);">
	<input type="hidden" name="cntrctSn" value="${cntrctSn}" >
	<input type="hidden" name="q_currPage"   id="q_currPage" value="${pager.currPage}"/> <!--  현재 페이지 -->
	<input type="hidden" name="q_searchKey"  id="q_searchKey" value="orgn_nm"/> 
 	<div class="popuparea">
		<div class="schArea">
		    <span>기관명</span>
			<div>
				<input type="text"  type="text" id="q_searchVal" name="q_searchVal" value="${param.q_searchVal}" />
			</div>
			<a href="#" class="btns st5"  onclick="jsSearch(1);">검 색</a>
		</div>	
		<p class="title_area"><strong>검색결과</strong></p>
		<div>
			<table class="tbl_st3 type_c scrolltbody">
				<thead>
					<tr>
						<th><input id="allCheck1" name="allCheck1" type="checkbox"></th>
						<th>기관명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${baseList}" var="data" >
					<tr onclick="jsMemberSelect('${data.orgnCode}','${data.buseoCode}','${data.orgnNm}','${data.orgnNmSt}');">
						<td><input type="checkbox" name="buseoCodes" class="buseoCodes" value="${data.buseoCode}" <c:if test="${data.orgnCode eq data.buseoCode}"> disabled </c:if>> </td>
						<td class="lef"><c:out value='${data.orgnNm}'/></td>
					</tr>
					</c:forEach>
					<c:if test="${empty baseList}">
	                    <op:no-data obj="${baseList}" colspan="2" />
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="btnArea">
			<a href="#" onClick="jsRealOrganInsert();" class="btns st1">추가하기</a>
		</div>		
	</div>
	<div class="popuparea poparea_last">
		<p class="title_area"><strong>실제 이용기관 목록</strong></p>
		<div>
			<table class="tbl_st3 type_c scrolltbody">
				<thead>
					<tr>
						<th><input id="allCheck2" name="allCheck2" type="checkbox"></th>
						<th>기관명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${dataList}" var="data"  varStatus="status">
					<c:if test="${status.first}"><c:set var="buseoNmTitle" value="${data.buseoNm}" /></c:if>
					<tr>
						<td><input type="checkbox" name="realBuseoCodes" class="realBuseoCodes"  value="${data.buseoCode}"></td> 
						<td>${data.buseoNm}</td>
					</tr> 
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="btnArea">
			<a href="#" onClick="jsRealOrganDelete();" class="btns st1">삭제</a>
			<a  href="#close" onclick="jsClose();" class="btns st1">확인</a>
		</div>	
		
	</div>
	</form>
	
<div id="loading-container" class="loading-container">
        <div class="loading"></div>
        <div id="loading-text">loading</div>
</div>
	
 </body>
 <script src="/resources/web/theme/common/js/jquery-1.11.1.min.js"></script>
  <script src='/cloud_ver2/new_cloud/js/jquery.mCustomScrollbar.min.js'></script>  
  <script src='/cloud_ver2/new_cloud/js/v3_cmm.js'></script>
<script>		
<c:if test="${not empty dataList}">
var tridx = '${fn:length(dataList)}';  
parent.$("#oganArea").html("${buseoNmTitle} 외"+ (tridx-1) +" 건");
</c:if> 
<c:if test="${empty dataList}">  
parent.$("#oganArea").html("");
</c:if>
$("#loading-container").hide();
</script> 
</html>