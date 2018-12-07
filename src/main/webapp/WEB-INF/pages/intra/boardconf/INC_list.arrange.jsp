<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ taglib uri="http://www.openworks.kr/jsp/validate" prefix="valid"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
	var confTabz;

	$().ready(function(){
		//대상항목 목록 중에 표시항목이 있으면 해당 항목 제거
		$("#allColumns").find("option").each(function(){
			var leftColumn = $(this);
			$("#displayColumns").find("option").each(function(){
				if($(this).val() == leftColumn.val()) leftColumn.remove();
			});
		});
		$("#btn_setList").click(function(){
			JSopt.doOpt("add");
		});
		$("#btn_resetList").click(function(){
			JSopt.doOpt("back");
		});
		$("#btn_upOption").click(function(){
			JSopt.doOpt("up");
		});
		$("#btn_downOption").click(function(){
			JSopt.doOpt("down");
		});

	});

	var jsInsertSave = function(){
	    
	    if($("#multiFiles").val() == ''){
	        alert("언어별 엑셀파일을 첨부해주세요 ");
	        return;
	    }
	    
        $("#displayColumns > option").attr("selected", "selected");
        dataString = $("#listArrangeForm").serialize();
                  $("#listArrangeForm").ajaxSubmit({
                      url      : "ND_boardconf.arrange.update.do",
                      type     : "POST",
                      dataType : "text",
                      data: dataString,
                      success: function(response){
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
     };
     
     
	var JSopt = {
		doOpt : function(_mode){
			/* Option 추가 실행 */
			if(_mode == 'add'){
				$("#allColumns").find("option").each(function(){
					if(this.selected){
						$("#displayColumns").append("<option value='" + this.value +"'>" + this.text +"</option>");
						$(this).remove();
					}
					changeFlag = true;
				});
			}else if(_mode == "back"){
				$("#displayColumns").find("option").each(function(){
					if(this.selected){
						$("#allColumns").append("<option value='" + this.value +"'>" + this.text +"</option>");
						$(this).remove();
					}else{
					}
					changeFlag = true;
				});
			}else if(_mode == "up"){
				$('#displayColumns option:selected').each(function(){
					var selectObj = $(this);
					if(selectObj.index() == 0) return false;
					var targetObj = $('#displayColumns option:eq(' + (selectObj.index()-1) + ')');
					targetObj.before(selectObj);
					changeFlag = true;
				});
			}else if(_mode == "down"){
				$('#displayColumns option:selected').each(function(){
					var selectObj = $(this);
					if(selectObj.index() == $('#displayColumns').children().length) return false;
					var targetObj = $('#displayColumns option:eq(' + (selectObj.index()+1) + ')');
					targetObj.after(selectObj);
					changeFlag = true;
				});
			}else{
			}
		}
	};

	var jsUpdateAction = function(){
		$("#displayColumns > option").attr("selected", "selected");
		$.post("ND_boardconf.arrange.update.do", {
			bbsCd : $("input[name=bbsCd]").val(),
			listViewSe : <%=BoardConfConstant.GUBUN_DISPLAY_COLUMN_LIST%>,
			displayColumns : $("#displayColumns option:selected").val()
		}, function(response){
			if(isNaN(response)){
				alert(response);
			}else{
				alert("요청정보를 성공적으로 수정했습니다.");
			}
			jsReloadTab();
		});
	};
</script>

<!-- 캡션 영역 시작 -->
<div class="bbs-caption">
	<div class="caption-right"> 
		<span id="formResult" class="result"></span>
	</div>
</div>
<!-- 캡션 영역 끝 -->

<form id="listArrangeForm" >
	<input type="hidden" name="domainCd" value="${param.domainCd}" />
	<input type="hidden" name="bbsCd" value="${param.bbsCd}" />
	<input type="hidden" name="listViewSe" value="<%= BoardConfConstant.GUBUN_DISPLAY_COLUMN_LIST %>" />

	<!-- 게시판 목록 배치 시작 -->
	<fieldset>
		<legend>목록 배치 설정</legend>
		<table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="목록 배치" >
			<caption>입력표 설정</caption>
			<colgroup>
				<col width="220" />
				<col width="60" />
				<col width="220" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th>대상 항목</th>
					<th></th>
					<th colspan="1">표시 항목</th>
					<th>언어별 컬럼명</th>
				</tr>
				<tr>
					<td>
						<select id="allColumns" name="allColumns" size="15" class="w200" multiple>
							<c:forEach items="${boardColumnList}" var="_bean">
								<option value="${_bean.columnId}">${_bean.columnNm}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input type="button" style="width:50px" id="btn_setList"  value="→" />
						<input type="button" style="width:50px" id="btn_resetList" value="←" />
						<input type="button" style="width:50px" id="btn_upOption" value="↑" />
						<input type="button" style="width:50px" id="btn_downOption" value="↓" />
					</td>
					<td>
						<select id="displayColumns" name="displayColumns" size="15" class="w200" multiple>
							<c:forEach items="${boardDisplayColumnList}" var="_bean">
								<option value="${_bean.columnId}">${_bean.columnNm}</option>
							</c:forEach>
						</select>
					</td>
					<td align="center">
						<table border="2">
		                    <thead>
			                    <tr>
				                    <th>컬럼명</th>
				                    <th>언어별 컬럼명</th>
			                    </tr>
		                    </thead>
							<tbody>
								<c:forEach items="${boardDisplayColumnList}" var="_bean">
									<tr>
										<td>${_bean.columnNm}</td>
										<td>${_bean.langColumnNm eq null ? '':_bean.langColumnNm}</td>
									</tr>
			                    </c:forEach>
							</tbody>
						</table>
						</br>
						<input type="file" name="multiFiles" id="multiFiles" class="multi max-1" value="찾아보기" accept="xls" style="width: 380px;"/>
	                    <button type="button" class="blue" onclick="document.location.href='/resources/download/Lang_Colum_Nm_Excel_Samply.xls';">샘플파일 다운로드</button>
			            <p class="tx_blue_s">* 작성 시 샘플파일에 맞추어 작성해 주시면 정확하게 데이터를 가져올 수 있습니다.</p>
			            <p class="tx_blue_s">* 목록배치 수정인 경우 언어별 컬럼명 첨부파일을 필수로 첨부하셔야합니다.</p>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<p class="tx_blue_s">* 갤러리 게시판인 경우 파일순번을 선택하면 썸네일로 표시됩니다.</p>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	<!-- 게시판 목록 배치 끝 -->

	<!-- 버튼 -->
	<div class="btn_r">
		<ul>
			<li><input type="button" id="btnSubmit" value="저장" class="w_blue mar_r5"  onclick="jsInsertSave();"/></li>
			<li><input type="reset" id="btnCancel" value="취소" class="w_blue mar_r5" /></li>
			<li><input type="button" id="btnList" value="목록" class="blue" onclick="jsList();" /></li>
		</ul>
	</div>
	<!-- //버튼 -->

</form>