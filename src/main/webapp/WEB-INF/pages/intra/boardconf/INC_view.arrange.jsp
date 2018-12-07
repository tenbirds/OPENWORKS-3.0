<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page import="zes.openworks.intra.boardconf.BoardConfConstant" %>

<op:jsTag type="spi" items="validate" />
<script type="text/javascript">
	var confTabz;

	$().ready(function(){
		//대상항목 목록 중에 표시항목이 있으면 해당 항목 제거
		$("#allColumns2").find("option").each(function(){
			var leftColumn = $(this);
			$("#displayColumns2").find("option").each(function(){
				if($(this).val() == leftColumn.val()) leftColumn.remove();
			});
		});
		$("#btn_setList2").click(function(){
			JSopt.doOpt("add");
		});
		$("#btn_resetList2").click(function(){
			JSopt.doOpt("back");
		});
		$("#btn_upOption2").click(function(){
			JSopt.doOpt("up");
		});
		$("#btn_downOption2").click(function(){
			JSopt.doOpt("down");
		});

		/* $("#viewArrangeForm").submit(function(){
			$("#displayColumns2 > option").attr("selected", "selected");
			dataString = $("#viewArrangeForm").serialize();
			$.ajax({
				type: "POST",
				url: "ND_boardconf.arrange.update.do",
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
			return false;
		}); */
	});
	
	   var jsInsertSave = function(){
	        
	        if($("#multiFiles").val() == ''){
	            alert("언어별 엑셀파일을 첨부해주세요 ");
	            return;
	        }
	        
	        $("#displayColumns2 > option").attr("selected", "selected");
	        dataString = $("#viewArrangeForm").serialize();
	                  $("#viewArrangeForm").ajaxSubmit({
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
				$("#allColumns2").find("option").each(function(){
					if(this.selected){
						$("#displayColumns2").append("<option value='" + this.value +"'>" + this.text +"</option>");
						$(this).remove();
					}
					changeFlag = true;
				});
			}else if(_mode == "back"){
				$("#displayColumns2").find("option").each(function(){
					if(this.selected){
						$("#allColumns2").append("<option value='" + this.value +"'>" + this.text +"</option>");
						$(this).remove();
					}else{
					}
					changeFlag = true;
				});
			}else if(_mode == "up"){
				$('#displayColumns2 option:selected').each(function(){
					var selectObj = $(this);
					if(selectObj.index() == 0) return false;
					var targetObj = $('#displayColumns2 option:eq(' + (selectObj.index()-1) + ')');
					targetObj.before(selectObj);
					changeFlag = true;
				});
			}else if(_mode == "down"){
				$('#displayColumns2 option:selected').each(function(){
					var selectObj = $(this);
					if(selectObj.index() == $('#displayColumns2').children().length) return false;
					var targetObj = $('#displayColumns2 option:eq(' + (selectObj.index()+1) + ')');
					targetObj.after(selectObj);
					changeFlag = true;
				});
			}else{
			}
		}
	};

	var jsUpdateAction = function(){
		$("#displayColumns2 > option").attr("selected", "selected");
		$.post("ND_boardconf.arrange.update.do", {
			bbsCd : $("input[name=bbsCd]").val(),
			listViewSe : '<%=BoardConfConstant.GUBUN_DISPLAY_COLUMN_VIEW%>',
			//displayColumns : $("#displayColumns2 option:selected").val()
			displayColumns : $("select[name=displayColumns]").val()
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

<form id="viewArrangeForm">
	<input type="hidden" name="domainCd" value="${param.domainCd}" />
	<input type="hidden" name="bbsCd" value="${param.bbsCd}" />
	<input type="hidden" name="listViewSe" value="<%= BoardConfConstant.GUBUN_DISPLAY_COLUMN_VIEW %>" />

	<!-- 게시판 상세 배치 시작 -->
	<fieldset>
		<legend>상세 배치 설정</legend>
		<table class="boardWrite" border="0" cellspacing="0" cellpadding="0" summary="상세 배치" >
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
                    <th>표시 항목</th>
                    <th>언어별 컬럼명</th>
				</tr>
				<tr>
					<td>
						<select id="allColumns2" name="allColumns" size="15" class="w200" multiple>
							<c:forEach items="${boardColumnList}" var="_bean">
								<option value="${_bean.columnId}">${_bean.columnNm}</option>
							</c:forEach>
						</select>
					</td>
					<td>
						<input type="button" style="width:50px" id="btn_setList2"  value="→" />
						<input type="button" style="width:50px" id="btn_resetList2" value="←" />
						<input type="button" style="width:50px" id="btn_upOption2" value="↑" />
						<input type="button" style="width:50px" id="btn_downOption2" value="↓" />
					</td>
					<td>
						<select id="displayColumns2" name="displayColumns" size="15" class="w200" multiple>
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
                        <p class="tx_blue_s" >* 작성 시 샘플파일에 맞추어 작성해 주시면 정확하게 데이터를 가져올 수 있습니다.</p>
                        <p class="tx_blue_s" >* 목록배치 수정인 경우 언어별 컬럼명 첨부파일을 필수로 첨부하셔야합니다.</p>
                    </td>
				</tr>
			</tbody>
		</table>
	</fieldset>
	<!-- 게시판 상세 배치 끝 -->

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