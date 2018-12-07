<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!-- title-area -->
<c:if test="${boardConfVo.bbsCd ne 1002}">
	<h2 id="menuNm">
		<c:if test="${boardConfVo.bbsCd eq 1003}">묻고 답하기</c:if>
	  <c:if test="${boardConfVo.bbsCd eq 1001}">공지사항</c:if>
		<c:if test="${boardConfVo.bbsCd eq 1004}">지식나눔</c:if>
		<c:if test="${boardConfVo.bbsCd eq 1007}">행사 및 이벤트</c:if>
		<c:if test="${boardConfVo.bbsCd eq 1011}">기타 입찰정보</c:if>	
		<c:if test="${boardConfVo.bbsCd eq 1009}">성공스토리</c:if>
		<c:if test="${boardConfVo.bbsCd eq 1012}">뉴스레터</c:if>
	</h2>
	<!-- sorting -->
	<div class="sech_form">
		<div class="cont_wrap">
			<div class="selected">
			    <c:if test="${boardConfVo.bbsCd eq 1008}">
				    <span class="selectbox_title" style="width:115px;vertical-align:middle;display:inline-block;cursor:pointer;"></span>
				    <select name="q_product" id="q_product" title="서비스 선택" style="width:150px;" onchange="jsListReq(1);">
		                <option value="">-- 서비스선택 --</option>
		                    <c:forEach items="${boardConfVo.productList}" var="productVo" varStatus="status">
		                       <option value="${productVo.goodsCd}" <c:if test="${param.q_product eq productVo.goodsCd}"> selected="selected"</c:if>>${productVo.goodsNm}</option>
		                    </c:forEach>
		           </select>
				</c:if>
			</div>
		    <div class="selected">
		        <select name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
			        <option value="">--검색선택--</option>
			        <option value="BBSCTT_SJ_BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ_BBSCTT_CN'}"> selected="selected"</c:if>>제11목+내용</option>
		            <!-- 공지사항 사용안함 -->
		            <c:if test="${boardConfVo.bbsCd ne 1001}">
			            <option value="REGISTER_NM___1002" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1002'}"> selected="selected"</c:if>>작성자</option>
                    </c:if>
                    <!-- 20150827 뉴스레터 사용안함 추가  -->
                    <!-- 묻고답하기, 자주찾는질문,공지사항 사용안함 -->
		            <c:if test="${boardConfVo.bbsCd ne 1003 and boardConfVo.bbsCd ne 1002 and boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1012}">
				        <option value="NTT_CMT_CN" <c:if test="${param.q_searchKeyType eq 'NTT_CMT_CN'}"> selected="selected"</c:if>>댓글내용</option>
				        <option value="REGISTER_NM___1007" <c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1007'}"> selected="selected"</c:if>>댓글작성자</option>
			        </c:if>
			        <c:forEach var="extensionVo" items="${boardConfVo.searchColunms}">
				        <c:set var="searchKey" value="${extensionVo.columnId}___${extensionVo.searchTy}" />
				        <option value="${searchKey}"<c:if test="${param.q_searchKeyType eq searchKey}"> selected="selected"</c:if>>${extensionVo.columnNm}</option>
			        </c:forEach>
			        <c:if test="${param.q_searchKeyType eq 'TAG___1005'}">
				        <option value="TAG___1005"<c:if test="${param.q_searchKeyType eq 'TAG___1005'}"> selected="selected"</c:if>>태그</option>
			        </c:if>
		        </select>
		    </div>
		    <div class="search">
		        <input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>" />
		        <input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" maxlength='50' class="input" title="검색하실 단어 입력"/>
                <input type="button" class="btn" title="검색" onclick="jsSearch(); return false;" />
		    </div>
		</div>
	</div>
	<!-- 버튼영역 -->
    <c:if test="${boardConfVo.bbsCd ne 1001 and boardConfVo.bbsCd ne 1009 and boardConfVo.bbsCd ne 1002 and boardConfVo.bbsCd ne 1003 and boardConfVo.bbsCd ne 1012 and boardConfVo.bbsCd ne 1004 and boardConfVo.bbsCd ne 1007 and boardConfVo.bbsCd ne 1011}"><!-- 20150826 조건에 1012 추가 -->
        <div class="btn-area mt10">
        	<a href="#" class="b-btn fr type3" onclick="jsInsertForm('INSERT');"><strong><span>작성하기</span></strong></a>
        </div>
    </c:if>
    <c:if test="${boardConfVo.bbsCd eq 1003}">
    	<div class="btn-area mt10">
        	<a href="#" class="b-btn fr type3" onclick="jsInsertForm('INSERT');"><strong><span>질문하기</span></strong></a>
    	</div>
    </c:if>  
    <!-- //버튼영역 -->
</c:if>
<!-- //title-area -->


		
		
        
 
