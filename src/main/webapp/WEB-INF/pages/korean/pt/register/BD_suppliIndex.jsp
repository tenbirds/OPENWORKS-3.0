<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<title></title>
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
    $("#dataForm").attr("action","/korean/pt/register/BD_suppliView.do");
    $("#dataForm").submit();
  };

var jsnewForm = function(){
	    $("#bassAgremManageSeq").val('');
		$("#dataForm").attr("action","/korean/pt/register/BD_supplinewForm.do");
		$("#dataForm").submit();
 };
  
var jsForm = function(agoSeq){
    <c:choose>
    <c:when test="${chkRegistTerm eq 0 }"> 
	    $("#bassAgremManageSeq").val(agoSeq); // 2차협약은 현재(1차)협약일련번호를 물고 들어간다.
		$("#dataForm").attr("action","/korean/pt/register/BD_suppliForm.do");
		$("#dataForm").submit();
    </c:when>
    <c:otherwise>
    	alert("2차 협약신청기간이 아닙니다.");
    </c:otherwise>
    </c:choose>
};
</script>

</head>
<body>
 <div class="supAdm supAdmin">
 <form name="dataForm" id="dataForm" method="POST">
   <input type="hidden" name="bassAgremManageSeq"    id="bassAgremManageSeq"    value=""/>
   <input name="q_currPage" id="q_currPage" type="hidden" value="${pager.currPage}"/>
					<table class="tbl_st1" summary="제공자정보 관리">
						<caption>제공자정보 관리</caption>
						<colgroup>
							<col width="5%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="10%"/>
							<col width="*"/>
							<col width="10%"/>
						</colgroup>
						<thead>
							<tr>
								<th scope="row">협약 차순</th>
								<th scope="row">권한 신청일</th>
								<th scope="row">승인일</th>
								<th scope="row">종료일</th>
								<th scope="row">협약상태</th>
								<th scope="row">관리자 의견</th>
								<th scope="row">상세/보완신청</th>
							</tr>
						</thead>
						<tbody>
						
						<!-- 리스트 시작 -->
												 
						<c:forEach items="${pager.list}" var="baseVo" varStatus="status">						
						<c:choose>
							<%-- 가장마지막 차수를 구한다. --%>
						    <c:when test="${status.index eq 0}"> 
						        <c:set var="lastAgremOrder" value="${baseVo.agremOrder}" scope="page"/>
						        <c:set var="lastBassAgremManageSeq" value="${baseVo.bassAgremManageSeq}" scope="page"/>
						    </c:when>
						</c:choose>
		                <tr>	
		                	<td>${baseVo.agremOrder} 차</td>
				            <td>${baseVo.presentnDe}</td>
				            <td>${baseVo.cnclsComptDe}</td> 
				            <td>${baseVo.agremEndDe}</td>
				            <td>${baseVo.agremNm}</td>
				            <td>
					            <c:choose>
					            	<c:when test="${null eq baseVo.mangComt}">
					            		의견 없음
					            	</c:when>
					            	<c:otherwise>
					            	${fn:substring(baseVo.mangComt,0,10)}<c:if test="${fn:length(baseVo.mangComt) > 10}">....</c:if>
					            	</c:otherwise>
					            </c:choose>
				            </td>
				            <%-- <td><c:if test="${null ne baseVo.mangComt}"><a href="#" class="fromNia">메세지</a></c:if></td> --%> 
				            <td>
				           
					            <a href="javascript:"  onclick="jsView('${baseVo.bassAgremManageSeq}');"  class="btns st3">보기</a>
	                		
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
				<div class="btnArea rig">
					<c:if test="${empty pager.list}">
						<%-- 자료가 없을 때만 신규 협약신청이 가능함 --%>
						<a href="javascript:"  onclick="jsnewForm();" class="btns st1 icn icnCheck2">신규 협약신청</a>
					</c:if>
					<c:choose>
						<%-- 가장마지막 차수가 1이고 현재일자가 기간내없을 때만  2차협약에 들어갈수 있다.--%>
					    <c:when test="${lastAgremOrder eq 1 }"> 
							<a href="javascript:"  onclick="jsForm('${lastBassAgremManageSeq}');" class="btns st1 icn icnCheck2">2차 협약신청</a>        
					    </c:when>
					</c:choose>						
				</div>				
			</div>
		</div>
	</section>

</body>
</html>