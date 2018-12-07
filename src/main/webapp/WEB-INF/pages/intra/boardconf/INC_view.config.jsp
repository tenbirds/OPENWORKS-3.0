<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
	var confTabz;

	$().ready(function(){
		$("#viewConfigForm").validate({
			rules : {
				rdcntIncrsLmttTime : { required : true, maxlength : 3, number : true }
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
		<span id="viewResult" class="result"></span>
	</div>
</div>
<!-- 캡션 영역 끝 -->

<form id="viewConfigForm">
	<input type="hidden" name="domainCd" value="${param.domainCd}" />
	<input type="hidden" name="bbsCd" value="${dataVo.bbsCd}" />
	<input type="hidden" name="gubunCd" value="<%=BoardConfConstant.GUBUN_CD_VIEW%>" />

	<!-- 게시판 목록 시작 -->
	<fieldset>
		<legend>상세조회 설정</legend>
		<table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="상세설정 정보를 표시" >
			<caption>상세조회 설정</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th><label for="listViewCd">하단 목록 표시 방법</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<f:select path="dataVo.listViewCd" id="listViewCd" items="${listViewCdMap}" onchange="jsChkValueChange('select', 'listViewCd', '${dataVo.listViewCd}');" />
					</td>
				</tr>
				<%-- <tr>
					<th><label for="recomendYn">추천 사용 여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="recomendYn" id="recomendYn_Y" value="Y" class="radio"<c:if test="${dataVo.recomendYn == 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'recomendYn', '${dataVo.recomendYn}');" /> 
						<label for="recomendYn_Y">사용</label> 
						<input type="radio" name="recomendYn" id="recomendYn_N" value="N" class="radio"<c:if test="${dataVo.recomendYn == 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'recomendYn', '${dataVo.recomendYn}');" /> 
						<label for="recomendYn_N">미사용</label>
						<span class="tx_blue_s">- 게시글의 추천 기능을 이용하고자 한다면 사용으로 설정하세요.</span>
					</td>
				</tr>
				<tr>
					<th><label for="accuseYn">신고 사용 여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="accuseYn" id="accuseYn_Y" value="Y" class="radio"<c:if test="${dataVo.accuseYn == 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'accuseYn', '${dataVo.accuseYn}');" />
						<label for="accuseYn_Y">사용</label> 
						<input type="radio" name="accuseYn" id="accuseYn_N" value="N" class="radio"<c:if test="${dataVo.accuseYn == 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'accuseYn', '${dataVo.accuseYn}');" /> 
						<label for="accuseYn_N">미사용</label>
						<span class="tx_blue_s">- 게시글의 신고 기능을 이용하고자 한다면 사용으로 설정하세요.</span>
					</td>
				</tr>
				<tr>
					<th><label for="stsfdgYn">만족도 사용 여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="stsfdgYn" id="stfyYn_Y" value="Y" class="radio"<c:if test="${dataVo.stsfdgYn == 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'stsfdgYn', '${dataVo.stsfdgYn}');" />
						<label for="stfyYn_Y">사용</label> 
						<input type="radio" name="stsfdgYn" id="stfyYn_N" value="N" class="radio"<c:if test="${dataVo.stsfdgYn == 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'stsfdgYn', '${dataVo.stsfdgYn}');" /> 
						<label for="stfyYn_N">미사용</label>
						<span class="tx_blue_s">- 게시글에 대한 사용자 만족도를 입력받고자 한다면 사용으로 설정하세요.</span>
					</td>
				</tr> --%>
				<tr>
					<th><label for="tagYn">태그 사용 여부</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="radio" name="tagYn" id="tagYn_Y" value="Y" class="radio"<c:if test="${dataVo.tagYn == 'Y'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'tagYn', '${dataVo.tagYn}');" />
						<label for="tagYn_Y">사용</label> 
						<input type="radio" name="tagYn" id="tagYn_N" value="N" class="radio"<c:if test="${dataVo.tagYn == 'N'}"> checked="checked"</c:if> onclick="jsChkValueChange('radio', 'tagYn', '${dataVo.tagYn}');" /> 
						<label for="tagYn_N">미사용</label>
						<span class="tx_blue_s">- 게시물 태그를 사용하려면 사용으로 설정하세요.</span>
					</td>
				</tr>
				<tr>
					<th><label for="rdcntIncrsLmttTime">조회수 증가 시간</label> <span class="tx_red tx_b">*</span></th>
					<td>
						<input type="text" name="rdcntIncrsLmttTime" id="rdcntIncrsLmttTime" title="조회수 증가 시간은 필수입력 항목입니다." class="w55" value="${dataVo.rdcntIncrsLmttTime}" maxlength="3" onchange="jsChkValueChange('text', 'rdcntIncrsLmttTime', '${dataVo.rdcntIncrsLmttTime}');" />
						<span class="tx_blue_s">단위: 시간 (숫자, 최대 3자)</span>
						<p class="tx_blue_s">- 조회수/추천수/신고수 등 증가할 기준 시간을 지정합니다. 기준 시간이 지나야만 조회수가 증가합니다. (쿠키에 저장됨)</p>
					</td>
				</tr>

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