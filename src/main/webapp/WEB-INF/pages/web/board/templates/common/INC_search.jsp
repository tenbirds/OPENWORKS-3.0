<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

					<!-- search -->
					<div class="search-area">
						<p class="select-box">
							<label for="list">제목+내용</label>
							<select class="list" name="q_searchKeyType" id="q_searchKeyType" title="검색하실 단어 제목, 내용 중 선택" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
								<option value="">-- 검색선택 --</option>
								<option value="BBSCTT_SJ_BBSCTT_CN" <c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ_BBSCTT_CN'}"> selected="selected"</c:if>>제목+내용</option>
								<option value="REGIST_ID_REGISTER_NM" <c:if test="${param.q_searchKeyType eq 'REGIST_ID_REGISTER_NM'}"> selected="selected"</c:if>>작성자</option>
								<option value="COMMENTS___1002" <c:if test="${param.q_searchKeyType eq 'COMMENTS___1002'}"> selected="selected"</c:if>>댓글내용</option>
								<option value="CMT_REG_ID_REGISTER_NM" <c:if test="${param.q_searchKeyType eq 'CMT_REG_ID_REGISTER_NM'}"> selected="selected"</c:if>>댓글작성자</option>
								<c:forEach var="extensionVo" items="${boardConfVo.searchColunms}">
								<c:set var="searchKey" value="${extensionVo.columnId}___${extensionVo.searchTy}" />
								<option value="${searchKey}"<c:if test="${param.q_searchKeyType eq searchKey}"> selected="selected"</c:if>>${extensionVo.columnNm}</option>
								</c:forEach>
								<c:if test="${param.q_searchKeyType eq 'TAG___1005'}">
									<option value="TAG___1005"<c:if test="${param.q_searchKeyType eq 'TAG___1005'}"> selected="selected"</c:if>>태그</option>
								</c:if>
							</select>
						</p>
						<span class="search-box">
							<input type="hidden" name="q_searchKey" value="<c:out value='${param.q_searchKey}'/>" />
							<input type="text" name="q_searchVal" id="q_searchVal" value="<c:out value='${param.q_searchVal}'/>" maxlength='50' title="검색하실 단어 입력" /><a href="#" class="" onclick="jsSearch(); return false;">검색</a>
						</span>
					</div>
					<!-- //search -->


        <c:if test="${boardConfVo.bbsCd eq '1002'}">
            <div class="btn_org"><a href="#" onclick="jsSearchReset(); return false;" >전체보기</a></div>
        </c:if>
        <c:if test="${boardConfVo.bbsCd ne '1001' and boardConfVo.bbsCd ne '1009' and boardConfVo.bbsCd ne '1002' and boardConfVo.bbsCd ne '1003'}">
            <div class="btn_org"><a href="#" onclick="jsInsertForm('INSERT');">작성하기</a></div>
        </c:if>
        <c:if test="${boardConfVo.bbsCd eq '1003'}">
            <div class="btn_org"><a href="#" onclick="jsInsertForm('INSERT');">질문하기</a></div>
        </c:if>
        
