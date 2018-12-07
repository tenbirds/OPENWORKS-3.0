<%@ page import="zes.core.lang.Validate"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title></title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form,validate,colorbox" />
<script type="text/javascript">
	$().ready(function(){

	});//ready end
	
	var deleteSubForm = function() {
	      var deleleLists = new Array();
	      $("input[name=box]:checked").each(function (i) {
	          deleleLists[i] = $(this).val();
	      });

	      if(deleleLists.length == 0){
	          jsWarningBox("대상 항목을 1개 이상 선택하세요.");
	          return false;
	      }else{
	          if(confirm("선택한 " + deleleLists.length + "개의 항목을 삭제하시겠습니까?")){
	              jQuery.ajaxSettings.traditional = true;
	              
	              $.ajax({
	                  url     : "BD_deleteSubForm.do",            
	                  type    : "POST",
	                  data : { deleleLists : deleleLists},
	                  success : function(result) {
	                      if(result == "true") {
	                         alert("삭제되었습니다");
	                          self.location.reload();                   
	                      } else {   
	                              alert("삭제를 실패했습니다");
	                      }                
	                  }
	             });
	          }
	      }
	  }
	  
</script>
</head>

<body>
<div class="supAdm mstSub regist">
	<form id="subList" name="subList" onsubmit="return false;">		
			<h3>
				<i class="quot">
					서브등록은 기업내 여러 담당자가 클라우드스토어 씨앗을<br />
					이용할 수 있도록 기업의 마스터가 계정을 생성해 주는 서비스 입니다.
				</i>				
			</h3>
	
			<div class="list_st1">
				<p class="head">
					<span class="totalcount">
				    	<op:pagerParam page="param/webListPagerParam.jsp" />
				 </span>
				</p>
				
				<table class="tbl_st1" summary="서브등록">
					<caption>서브등록</caption>
					<colgroup>
						<col width="5%"/>
						<col width="5%"/>
						<col width="20%"/>
						<col width="20%"/>
						<col width="25%"/>
						<col width="25%"/>
					</colgroup>
					<thead>
						<tr>
							<th scope="row">선택</th>
							<th scope="row">번호</th>
							<th scope="row">부서/팀</th>
							<th scope="row">이름</th>
							<th scope="row">계정활성화</th>
							<th scope="row">작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="index" value="${pager.indexNo}" />
			      			<c:forEach items="${pager.list}" var="data" varStatus="status">
								<tr>
									<td><input type="checkbox" name="box" value="<c:out value="${data.userId}" />"/></td>
									<td><c:out value='${data.seq}'/></td>
									<td><c:out value="${data.cmpnyBuseo}" /></td>
									<td><c:out value="${data.userNm}" /></td>
									<td>Y</td>
									<td class="date"><c:out value="${data.updtDt}" /></td>
								</tr>
						</c:forEach>
						<c:if test="${empty pager.list}">
							<tr>
								<td colspan="6">등록된 데이터가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>								
			</div>	
			
			<!-- paging  -->
			<div class="paging">
				<span><op:pager pager="${pager}" page="pager/webPager.jsp" script="jsMovePage" /></span>
			</div> 
			<!--// paging  -->
			
			<div class="btnArea lef">
<!-- 				<a href="#" class="btns st1 icn icnAct">계정활성화</a> -->
<!-- 				<a href="#" class="btns st1 icn icnAct_no">계정비활성화</a> -->
				<a href="#" onclick="deleteSubForm(this);" class="btns st1 icn icnDel">계정삭제</a>
				<a href="BD_subForm.do" class="f_r btns st1 icn icnWrite">작성하기</a>
			</div>
			</form>			
		</div>
</body>
</html>