<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!-- 검색 영역 시작 -->
<div class="sech_form">
    <div class="cont_wrap">
        <div class="selected" >
	        <c:if test="${boardConfVo.bbsCd eq 1008}">
                <style>#q_product{width:150px;}</style>
	            <select name="q_product" id="q_product" title="서비스 선택"  onchange="jsListReq(1);">
	                <option value="">Product Select</option>
	                    <c:forEach items="${boardConfVo.productList}" var="productVo" varStatus="status"> 
	                       <option value="${productVo.goodsCd}" <c:if test="${param.q_product eq productVo.goodsCd}"> selected="selected"</c:if>>${productVo.goodsNm}</option>
	                    </c:forEach>
	            </select>
	        </c:if>
        </div>
        <div class="selected" >
            <style>#q_searchKeyType{width:130px;}</style>
	        <select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}" style="width:117px;">
	            <option value="">Select</option>
	            <option value="BBSCTT_SJ_BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ_BBSCTT_CN'}"> selected="selected"</c:if>>Title + Contents</option>
	            
	            <c:if test="${boardConfVo.bbsCd ne 1001}"> <!-- 공지사항 사용안함 -->
	                <option value="REGISTER_NM___1002" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1002'}"> selected="selected"</c:if>>Author</option>
	            </c:if>         
	
	            <c:if test="${boardConfVo.bbsCd ne 1003 and boardConfVo.bbsCd ne 1002 and boardConfVo.bbsCd ne 1001}"> <!-- 묻고답하기, 자주찾는질문,공지사항 사용안함 -->
	                <option value="NTT_CMT_CN" <c:if test="${param.q_searchKeyType eq 'NTT_CMT_CN'}"> selected="selected"</c:if>>Reply contents</option>
	                <option value="REGISTER_NM___1007" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1007'}"> selected="selected"</c:if>>Reply Author</option>
	            </c:if>
	            
	            <c:forEach var="extensionVo" items="${boardConfVo.searchColunms}">
	                <c:set var="searchKey" value="${extensionVo.columnId}___${extensionVo.searchTy}" />
	                <option value="${searchKey}"<c:if test="${param.q_searchKeyType eq searchKey}"> selected="selected"</c:if>>${extensionVo.columnNm}</option>
	            </c:forEach>
	            
	            <c:if test="${param.q_searchKeyType eq 'TAG___1005'}">
	                <option value="TAG___1005"<c:if test="${param.q_searchKeyType eq 'TAG___1005'}"> selected="selected"</c:if>>Tag</option>
	            </c:if>
	        </select>
        </div>
        <div class="search">
            <input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>" />
            <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" maxlength='50' class="input" title="검색하실 단어 입력">

<!--        <input type="image" alt="검색옵션" src="/resources/web/theme/default/images/btn/btn_g_searchoption.gif" onclick="jsToggleSearchOption(this); return false;" /> -->
            <input type="button" class="btn" title="검색" onclick="jsSearch(); return false;" >
        </div>
        <c:if test="${boardConfVo.bbsCd eq 1002}">
            <div class="btn_org"><a href="#" onclick="jsSearchReset(); return false;" >View All</a></div>
        </c:if>
        <c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1009 and boardConfVo.bbsCd ne 1002 and boardConfVo.bbsCd ne 1003}">
            <div class="btn_org"><a href="#" onclick="jsInsertForm('INSERT');">Compose</a></div>
<%--             <c:if test="${boardConfVo.bbsCd eq 1008}"> --%>
<!--                <div class="btn_org"><a href="#" onclick="jsSearchReset(); return false;" />전체보기</a></div> -->
<%--             </c:if> --%>
        </c:if>
        <c:if test="${boardConfVo.bbsCd eq 1003}">
            <div class="btn_org"><a href="#" onclick="jsInsertForm('INSERT');">Submit a question</a></div>
        </c:if>
    </div>
</div>      
