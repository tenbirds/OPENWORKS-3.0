<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<!-- 검색 영역 시작 -->
<div class="search" id="Search_Menu_div" >
	<fieldset>
		<legend>게시물 검색</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="사용여부를 체크하실 수 있습니다.">
            <caption class="hidden"> 사용여부설정 </caption>
            <colgroup>
                <col width="15%" />
                <col width="28%" />
                <col width="13%" />
                <col width="" />
            </colgroup>
                <tbody>
                <tr>
                    <th>서비스언어</th>
                    <td colspan="3"> 
	                    <input type="checkbox"  name="q_domainCdAll" id="q_domainCdAll" value="0"  <c:if test="${fn:indexOf(param.q_domainCds,'0') > -1}">checked="checked"</c:if> onclick="jsCheck();" /><label for="q_domainCdAll">전체</label>
	                    <input type="checkbox"  name="q_domainCd" id="domainCd1" value="2" <c:if test="${fn:indexOf(param.q_domainCds,'2') > -1}">checked="checked"</c:if> /><label for="domainCd1">한국어</label>
	                    <input type="checkbox"  name="q_domainCd" id="domainCd2" value="3" <c:if test="${fn:indexOf(param.q_domainCds,'3') > -1}">checked="checked"</c:if>/><label for="domainCd2">영어</label>
	                    <input type="checkbox"  name="q_domainCd" id="domainCd3" value="4" <c:if test="${fn:indexOf(param.q_domainCds,'4') > -1}">checked="checked"</c:if>/><label for="domainCd3">스페인어</label>
	                    <input type="hidden" name="q_domainCds" id="q_domainCds" value=""></input>
                    </td>
                </tr>
                <tr>
                    <th>등록일</th>
                    <td colspan="3">
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
                    </td>
                </tr>
                <tr>
                    <th>선정여부</th>
                    <td >
	                    <select id="q_estnColumn5" name="q_estnColumn5">
	                        <option value="" >전체 </option>
	                        <option value="Y" <c:if test="${param.q_estnColumn5 eq 'Y'}">selected="selected"</c:if>>선정</option>
	                        <option value="N" <c:if test="${param.q_estnColumn5 eq 'N'}">selected="selected"</c:if>>미선정</option>
	                        <option value="S" <c:if test="${param.q_estnColumn5 eq 'S'}">selected="selected"</c:if>>대기</option>
	                    </select>
                    </td>
                    <th>상태</th>
                    <td >
	                    <select id="bizProgression" name="bizProgression">
	                        <option value="">전체</option>
	                        <option value="COM" <c:if test="${param.bizProgression eq 'COM'}">selected="selected"</c:if>>완료</option>
	                        <option value="INC" <c:if test="${param.bizProgression eq 'INC'}">selected="selected"</c:if>>미완료</option>
	                        <option value="PRO" <c:if test="${param.bizProgression eq 'PRO'}">selected="selected"</c:if>>진행중</option>
	                    </select>
                    </td>
                </tr>
                <tr>
                    <th>상세검색</th>
                    <td colspan="3">
	                    <select name="q_searchKeyType" id="q_searchKeyType" class="over" onchange="if($(this).val() != ''){$(this).next().focus().select();}">
				            <option value="">-- 검색선택 --</option>
				            <option value="BBSCTT_SJ___1002"<c:if test="${param.q_searchKeyType eq 'BBSCTT_SJ___1002'}"> selected="selected"</c:if>>제목</option>
				            <option value="REGISTER_NM___1002"<c:if test="${param.q_searchKeyType eq 'REGISTER_NM___1002'}"> selected="selected"</c:if>>문의자 이름</option>
				            <option value="REGIST_ID___1002"<c:if test="${param.q_searchKeyType eq 'REGIST_ID___1002'}"> selected="selected"</c:if>>문의자 ID</option>
				        </select>
	                    <input type="hidden" name="q_searchKey" value="${param.q_searchKey}" />
				        <label class="skip" for="searchText">검색단어 입력</label>
			            <input type="text" name="q_searchVal" id="q_searchVal" value="${param.q_searchVal}" maxlength='50' class="w215" />
                    </td>
                </tr>
                </tbody>

        </table>

        <div style="padding-top: 10px">        
		<button type="button" class="gray" onclick="jsSearch();">검색</button>
        <button type="button" class="gray" onclick="jsSearchReset2();">전체보기</button>
		</div>
		
		<!-- 검색 옵션 끝 -->
	</fieldset>
</div>
<!-- 검색 영역 끝 -->