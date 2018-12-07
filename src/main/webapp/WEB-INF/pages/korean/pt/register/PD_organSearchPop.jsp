<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
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
	<script type="text/javascript">
	    var jsClose = function(flag) {
	    	if (flag == "A") {
	    		self.close();
	    	}else{
	        parent.$.colorbox.close();
	    	}
	    }
	    
	    var jsSearch = function(page){
	        if($("#q_searchVal").val() == ''){
	            alert("검색값을 입력해주세요");
		      	$("#q_searchVal").focus();
	            return false;
	        }
			
            $("#q_currPage").val(page);
	        document.dataForm.method = "POST";
	        document.dataForm.action = "PD_organSearchList.do";
	        document.dataForm.submit();
	    }
	 	
	    var jsMemberSelect = function(orgnCode, buseoCode, orgnNm, orgnNmSt){
	    	var flag = $("#flag").val();
	    	
		    if (confirm("기관 및 부서를 선택하시겠습니까?")) {
		      if(flag == "A") {
		    	  $(opener.document).find("#orgnCode").val(orgnCode);
		    	  $(opener.document).find("#buseoCode").val(buseoCode);
		    	  $(opener.document).find("#orgn_nm").val(orgnNm);
		    	  $(opener.document).find("#orgn_nm_st").val(orgnNmSt);
		    	  //$(opener.document).find('input:checkbox[id="dmandExaminChargerAt"]').attr("checked", true);
		      }else if(flag == "F") {//이용희망목록에서 검색
		    	  parent.$("#realDmndOrgn").val(orgnNm);
		    	  parent.$("#realDmndOrgnCd").val(orgnCode);
		    	  parent.$("#realDmndBuseoCd").val(buseoCode);
		      }else{
			    	parent.$("#orgnCode").val(orgnCode);
			    	parent.$("#buseoCode").val(buseoCode);
			    	parent.$("#orgn_nm").val(orgnNm);
			    	parent.$("#orgn_nm_st").val(orgnNmSt);
		      }

		      jsClose(flag);
		 		}
	   }	    
	</script>
 </head>

 <body class="winPopup selCate">
	<h2>기관명 검색 <a href="#close" onclick="jsClose();">닫기</a></h2>	
	<div>
	<form name="dataForm" id="dataForm" onsubmit="return jsSearch(1);">
	
		<input type="hidden" name="q_currPage"   id="q_currPage" value="${pager.currPage}"/> <!--  현재 페이지 -->
		<input type="hidden" name="flag"   id="flag" value="${param.flag}"/> <!--  현재 페이지 -->
		<div class="schArea">
		    <span class="sel_box">
				<select id="q_searchKey" name="q_searchKey">
					<option value="orgn_nm" <c:if test="${searchKey == 'orgn_nm'}">selected</c:if>>기관명</option>
					<option value="orgn_nm_st" <c:if test="${searchKey == 'orgn_nm_st'}">selected</c:if>>부서명</option>
				</select>
			</span>
			
			<div>
				<input type="text" id="q_searchVal" name="q_searchVal" value="${searchVal}" />
			</div>
			<a href="#search" class="btns st5" onclick="jsSearch(1);">검 색</a>
		</div>
	
		<table class="tbl_st1">
			<thead>
				<tr>
					<th>기관명</th>
					<%-- <th>기관명</th> --%>
				</tr>
			</thead>
			<tbody>

				<c:forEach items="${pager.list}" var="data" >
				<tr onclick="jsMemberSelect('${data.orgnCode}','${data.buseoCode}','${data.orgnNm}','${data.orgnNmSt}');">
					<td style="text-align:left; padding-left: 10px;"><c:out value='${data.orgnNm}'/></td>
					<%-- <td><c:out value='${data.orgnNmSt}'/></td> --%>
				</tr>
				</c:forEach>
				<c:if test="${empty pager.list}">
                    <op:no-data obj="${pager.list}" colspan="2" />
				</c:if>

			</tbody>
		</table>
		
		<p class="desc fcol_2 rig">※ 소속 기관 부서 조회 후 클릭하여 등록</p>
		
		<!-- paging  -->
		<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsSearch" />
		<%-- <div class="paging">
            <op:pager pager="${pager}" page="pager/v2Pager.jsp" script="jsSearch" />
		</div> --%> 
		<!--// paging  -->				

 	</form>
	</div>
 </body>
</html>