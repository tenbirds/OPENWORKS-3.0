<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
	var confTabz;

	$().ready(function(){
		$("#listConfigForm").validate({
			rules : {
				cutTitleNum : { required : true, maxlength : 3, number : true },
				newArticleNum : { required : true, maxlength : 2, number : true },
				emphasisNum : { required : true, maxlength : 3, number : true }
			},
			submitHandler: function(form){
				$(form).ajaxSubmit({
					url		: "ND_boardconf.update2.do",
					type	: "POST",
					success : function(response){
						try {
							if(eval(response)) {
								jsSuccessBox(Message.msg.processOk);
							} else {
								jsErrorBox(Message.msg.processFail);
							}
						} catch (e) {
							// 시스템 오류 발생시 처리 구간
							jsSysErrorBox(response, e);
							return;
						}
						changeFlag = false;
						jsReloadTab();
					}
				});
			}
		});
	});
</script>

<!-- 캡션 영역 시작 -->
<div class="bbs-caption">
	<div class="caption-right">
		<span id="listResult" class="result"></span>
	</div>
</div>
<!-- 캡션 영역 끝 -->

<form id="listConfigForm" method="post" action="ND_boardconf.update2.do">
<op:pagerParam view="view" />
	<input type="hidden" name="domainCd" value="${param.domainCd}" />
	<input type="hidden" name="bbsCd" value="${dataVo.bbsCd}" />
	<input type="hidden" name="gubunCd" value="<%=BoardConfConstant.GUBUN_CD_LIST%>" />

	<!-- 게시판 목록 상세보기 시작 -->
	<fieldset>
		<legend>목록설정</legend>
		<table class="boardWrite" cellspacing="0" border="0" summary="게시판 목록 설정페이지입니다.">
			<caption>목록설정</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="rppNum">페이지당 목록 수</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<select name="rppNum" id="rppNum" class="w-50" onchange="jsChkValueChange('select', 'rppNum', '${dataVo.rppNum}');">
							<option value="3" <c:if test="${dataVo.rppNum == 3}">selected="selected"</c:if> >3</option>
							<option value="5" <c:if test="${dataVo.rppNum == 5}">selected="selected"</c:if> >5</option>
							<option value="6" <c:if test="${dataVo.rppNum == 6}">selected="selected"</c:if> >6</option>
							<option value="9" <c:if test="${dataVo.rppNum == 9}">selected="selected"</c:if> >9</option>
							<option value="10" <c:if test="${dataVo.rppNum == 10}">selected="selected"</c:if> >10</option>
							<option value="15" <c:if test="${dataVo.rppNum == 15}">selected="selected"</c:if> >15</option>
							<option value="30" <c:if test="${dataVo.rppNum == 30}">selected="selected"</c:if> >30</option>
							<option value="50" <c:if test="${dataVo.rppNum == 50}">selected="selected"</c:if> >50</option>
							<option value="100" <c:if test="${dataVo.rppNum == 100}">selected="selected"</c:if> >100</option>
							<option value="200" <c:if test="${dataVo.rppNum == 200}">selected="selected"</c:if> >200</option>
							<option value="300" <c:if test="${dataVo.rppNum == 300}">selected="selected"</c:if> >300</option>
						</select>
						<span class="tx_blue_s">한 페이지에 표시할 게시글 수를 정의합니다.</span>
					</td>
				</tr>
				<tr>
					<th><label for="dwldYn">첨부파일 다운로드 사용 여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="dwldYn" id="dwldYn_Y" value="Y" class="radio"<c:if test="${dataVo.dwldYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'dwldYn', '${dataVo.dwldYn}');" />
						<label for="dwldYn_Y">사용</label> 
						<input type="radio" name="dwldYn" id="dwldYn_N" value="N" class="radio"<c:if test="${dataVo.dwldYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'dwldYn', '${dataVo.dwldYn}');" /> 
						<label for="dwldYn_N">미사용</label>
						<span class="tx_blue_s">- 목록에서 첨부파일을 직접 다운로드 하고자 한다면 사용으로 설정하세요.</span>
					</td>
				</tr>
				<tr>
					<th><label for="cutTitleNum">제목 생략 길이</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="text" name="cutTitleNum" id="cutTitleNum" class="w55" title="제목 생략 길이는 필수입력 항목입니다." value="${dataVo.cutTitleNum}" maxlength="3" onchange="jsChkValueChange('text', 'cutTitleNum', '${dataVo.cutTitleNum}');" />
						<span class="tx_blue_s">최대 3자리</span>
						<p class="tx_blue_s">- 제목이 화면보다 길어 잘릴 경우 생략해야 할 길이를 지정합니다. [한글 : 2글자, 영문 : 1글자]</p>
					</td>
				</tr>
				<tr>
					<th><label for="newArticleNum">새 글 표시 날짜</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="text" name="newArticleNum" id="newArticleNum" class="w55" title="새 글 표시 날짜는 필수입력 항목입니다." value="${dataVo.newArticleNum}" maxlength="2" onchange="jsChkValueChange('text', 'newArticleNum', '${dataVo.newArticleNum}');" />
						<span class="tx_blue_s">단위: 일 (숫자, 최대 2자리)</span>
						<p class="tx_blue_s">- 새글 [아이콘 표시] 아이콘을 표시할 기준 날짜를 지정합니다. 기준 날짜에 포함된다면 아이콘이 표시됩니다.</p>
					</td>
				</tr>
				<tr>
					<th><label for="emphasisNum">강조 조회 수</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="text" name="emphasisNum" id="emphasisNum" class="w55" title="강조 조회 수는 필수입력 항목입니다." value="${dataVo.emphasisNum}" maxlength="3" onchange="jsChkValueChange('text', 'emphasisNum', '${dataVo.emphasisNum}');" />
						<span class="tx_blue_s">숫자, 최대 3자리</span>
						<p class="tx_blue_s">- 강조해야 할 게시글의 기준 조회수를 지정합니다. 조회수가 설정 값 초과 시 강조됩니다.</p>
					</td>
				</tr>
				<%-- <tr>
					<th><label for="feedYn">FEED 제공여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="feedYn" id="feedYn_Y" value="Y" class="radio"<c:if test="${dataVo.feedYn eq 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'feedYn', '${dataVo.feedYn}');" />
						<label for="feedYn_Y">사용</label>
						<input type="radio" name="feedYn" id="feedYn_N" value="N" class="radio"<c:if test="${dataVo.feedYn eq 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'feedYn', '${dataVo.feedYn}');" /> 
						<label for="feedYn_N">미사용</label>
						<span class="tx_blue_s">- RSS, ATOM 제공여부를 설정하세요.</span>
					</td>
				</ tr>--%>
			</tbody>
		</table>
	</fieldset>
	<!-- 게시판 목록 상세보기 끝 -->

	<!-- 버튼 -->
	<div class="btn_r">
		<ul>
			<li><input type="submit" id="btnSubmit" value="저장" class="w_blue mar_r5" /></li>
			<li><input type="reset" id="btnCancel" value="취소" class="w_blue mar_r5" /></li>
			<li><input type="button" id="btnList" value="목록" class="blue" onclick="jsList();" /></li>
		</ul>
	</div>
	<!-- //버튼 -->
	
</form>