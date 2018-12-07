<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title>기본 협약 차수 관리</title>
<op:jsTag type="openworks" items="ui, validate, form" />
<op:jsTag type="spi" items="ui, validate, form, highlight, datepicker, colorbox"/>

<script type="text/javascript">
var jsPage = function(page) {
    $("#q_currPage").val(page);
    $("#dataForm").attr("/korean/pt/register/BD_suppliIndex.do");
    $("#dataForm").submit();
};

var jsView = function(seq){
    $("#bassAgremManageSeq").val(seq);
    $("#dataForm").attr("action","/korean/pt/register/BD_suppliModify.do");
    $("#dataForm").submit();
  };

var jsForm = function(){
    $("#bassAgremManageSeq").val('');
	$("#dataForm").attr("action","/korean/pt/register/BD_suppliForm.do");
	$("#dataForm").submit();

};
</script>

</head>
<body>
	<div class="supAdm supAdmin">
 		<form name="dataForm" id="dataForm" method="POST">
   	<input type="hidden" name="bassAgremManageSeq" id="bassAgremManageSeq" value=""/>
   	<input name="q_currPage" id="q_currPage" type="hidden" value="${pager.currPage}"/>
		<table class="tbl_st1" summary="협약체결이력">
			<caption>협약체결이력</caption>
			<colgroup>
				<col width="5%"/>
				<col width="5%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
				<col width="15%"/>
			</colgroup>
				<thead>
					<tr>
						<th scope="row">No</th>
						<th scope="row">협약 차순</th>
						<th scope="row">신청일</th>
						<th scope="row">승인일</th>
						<th scope="row">종료일</th>
						<th scope="row">협약상태</th>
						<th scope="row">진행상태</th>
						<th scope="row">수정</th>
					</tr>
				</thead>
						<tbody>
						<!-- 리스트 시작 -->
						<c:set var="index" value="${pager.indexNo}"/>
						<c:forEach items="${pager.list}" var="baseVo" varStatus="status">
		                <tr>	
		                	<td>${index-status.index}</td>
		                	<td>${baseVo.agremOrder} 차 협약</td>
				            <td>${baseVo.presentnDe}</td>
				            <td>${baseVo.cnclsComptDe}</td> 
				            <td>${baseVo.agremEndDe}</td>
				            <td>${baseVo.agremNm}</td>
				            <td>
				            <c:choose>
				            	<c:when test="${baseVo.cnclsComptDe eq ''}">
				            		신청
				            	</c:when>
				            	<c:otherwise>
				            		체결
				            	</c:otherwise>
				            </c:choose>
				            </td>
				            <td>
				             <!-- 협약 상태가 반려 인 경우에만 경우에만 수정 버튼이 나오게 설정 -->
			            	<c:if test="${baseVo.agremStat eq '1003'}">
			            		<a href="javascript:"  onclick="jsView('${baseVo.bassAgremManageSeq}');"  class="btns st3">수정</a>
			            	</c:if>
				            </td>
	                	</tr>
		                </c:forEach>
		                <op:no-data obj="${pager}"  colspan="7"/>
		                <!-- 리스트 끝 -->
		                
						</tbody>					</table>
				<!-- paging  -->
					<op:pager pager="${pager}" page="pager/webPager.jsp" script="jsPage" />
			   <!-- paging  -->
	 </form>  			
				<!-- <div class="btnArea rig">					
					<a href="javascript:"  onclick="jsForm();" class="btns st1 icn icnCheck2">연장(재)신청</a>
				</div> -->				
			</div>
		</div>
	</section>

</body>
</html>