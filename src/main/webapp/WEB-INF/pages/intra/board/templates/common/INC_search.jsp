<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!-- 검색 영역 시작 -->
<div class="search" id="Search_Menu_div" >
	<fieldset>
		<legend>게시물 검색</legend>
		<label class="skip" for="boardsearch">카테고리 검색</label>
		
		
		<c:if test="${boardConfVo.ctgYn eq 'Y'}">
			<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
				<script>
					bbsCtgAry['${ctgVo.ctgCd}'] = '${ctgVo.ctgNm}';
				</script>
			</c:forEach>
			
			<c:if test="${boardConfVo.bbsCd ne 1031}">
			<select id="q_ctgCd" name="q_ctgCd" class="over">
				<option value="">-- 구분선택 1 --</option>
				<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
					<option value="${ctgVo.ctgCd}"<c:if test="${param.q_ctgCd eq ctgVo.ctgCd}"> selected="selected"</c:if>>${ctgVo.ctgNm}</option>
				</c:forEach>
			</select>
			<c:if test="${boardConfVo.bbsCd eq 1002}">
				<select id="q_aditCtgCd" name="q_aditCtgCd" class="over" >
					<option value="">-- 구분선택 --</option>
				</select>
			</c:if>
			</c:if>
			<c:if test="${boardConfVo.bbsCd eq 1031}">
			<select id="q_ctgCd" name="q_ctgCd" title="분류를 선택해주세요" onchange="aditCtgSel();" class="over">
				<option value="">-- 구분선택 1 --</option>
				<c:forEach items="${boardConfVo.ctgList}" var="ctgVo" varStatus="status">
					<option value="${ctgVo.ctgCd}"<c:if test="${param.q_ctgCd eq ctgVo.ctgCd}"> selected="selected"</c:if>>${ctgVo.ctgNm}</option>
				</c:forEach>
			</select>
			
        <select id="q_aditCtgCd" name="q_aditCtgCd" title="분류를 선택해주세요">
            <option value="">- 구분선택 2 -</option>
            <c:if test ="${not empty param.q_ctgCd}">
             <c:forEach items="${aditCtgList}" var="ctgVo">
                 <option value="${ctgVo.aditCtgCd}" <c:if test='${ctgVo.aditCtgCd == dataVo.estnColumn1}' > selected='selected'</c:if>>${ctgVo.aditCtgNm}</option>
             </c:forEach>
            </c:if>
        </select>
        <valid:msg name="aditCtgCd" />
			</c:if>
		</c:if>
		<!-- 공개가부 조회 -->
		<c:if test="${boardConfVo.bbsCd eq 1003}">
            <select id="q_othbcAt" name="q_othbcAt" class="over" >
                <option value="">-- 공개여부선택 -- </option>
                <option value="Y" <c:if test="${param.q_othbcAt eq 'Y'}"> selected="selected"</c:if>>공개</option>
                <option value="N" <c:if test="${param.q_othbcAt eq 'N'}"> selected="selected"</c:if>>비공개</option>
            </select>
            <select id="q_estnColumn3" name="q_estnColumn3" class="over" >
                <option value="">-- 상태선택 -- </option>
                <option value="Y" <c:if test="${param.q_estnColumn3 eq 'Y'}"> selected="selected"</c:if>>답변완료</option>
                <option value="N" <c:if test="${param.q_estnColumn3 eq 'N'}"> selected="selected"</c:if>>답변미등록</option>
            </select>
            
            </br>
        </c:if>

		<label class="skip" for="boardsearch">게시물 검색항목</label>
		<select name="q_searchKeyType" id="q_searchKeyType" class="over" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
			<option value="">-- 검색선택 --</option>
			<option value="BBSCTT_SJ___1002"<c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ___1002'}"> selected="selected"</c:if>>제목</option>
			<option value="BBSCTT_CN___1002"<c:if test="${param.q_searchKeyType eq 'BBSCTT_CN___1002'}"> selected="selected"</c:if>>내용</option>
			<c:forEach var="extensionVo" items="${boardConfVo.searchColunms}">
				<c:set var="searchKey" value="${extensionVo.columnId}___${extensionVo.searchTy}" />
				<option value="${searchKey}"<c:if test="${param.q_searchKeyType eq searchKey}"> selected="selected"</c:if>>${extensionVo.columnNm}</option>
			</c:forEach>
			<c:if test="${param.q_searchKeyType eq 'TAG___1005'}">
				<option value="TAG___1005"<c:if test="${param.q_searchKeyType eq 'TAG___1005'}"> selected="selected"</c:if>>태그</option>
			</c:if>
		</select>
		<input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
		<label class="skip" for="searchText">검색단어 입력</label>
		<input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" maxlength='50' class="w215" />

		<button type="button" class="gray" onclick="jsSearch();">검색</button>
		<button type="button" class="gray" onclick="jsToggleSearchOption(this);">검색옵션</button>
		<button type="button" class="gray" onclick="jsSearchReset2();">초기화</button>
<!-- 		<button type="button" class="gray" onclick="jsSearchReset();">초기화</button> -->



		<!-- 검색 옵션 시작 -->
		<div id="SearchOptionDiv" class="mar_t5 none">
			<input type="text" id="q_startDt" name="q_startDt" class="w80" value="${param.q_startDt}" maxlength='8' /> ~ 
			<input type="text" id="q_endDt" name="q_endDt" class="w80" value="${param.q_endDt}" maxlength='8' />&nbsp;

			<button type="button" class="gray" onclick="jsSetDay(0, 1, 0);">오늘</button>
			<button type="button" class="gray" onclick="jsSetDay(0, 2, 0);">1일</button>
			<button type="button" class="gray" onclick="jsSetDay(0, 7, 0);">7일</button>
			<button type="button" class="gray" onclick="jsSetDay(0, 10, 0);">10일</button>
			<button type="button" class="gray" onclick="jsSetDay(0, 15, 0);">15일</button>
			<button type="button" class="gray" onclick="jsSetDay(1, 1, 0);">1개월</button>
			<button type="button" class="gray" onclick="jsSetDay(3, 1, 0);">3개월</button>
			<button type="button" class="gray" onclick="jsSetDay(6, 1, 0);">6개월</button>
			<button type="button" class="gray" onclick="jsSetDay(-1, 1, 0);">전체</button>
		</div>
		<!-- 검색 옵션 끝 -->
	</fieldset>
</div>
<!-- 검색 영역 끝 -->