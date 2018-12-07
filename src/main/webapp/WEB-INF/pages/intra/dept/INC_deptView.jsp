<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
<title>부서관리</title>
<script type="text/javascript">
	$().ready(function() {
		if ($("#deptAddForm")) {
			$("#deptAddForm").validate({
				rules : {
					nodeText : {
						required : true,	minlength : 3,	maxlength : 30
					},
					nodeId : {
						required : true,	minlength : 1,	maxlength : 10
					},
					telNum1 : {
						required : false,	minlength : 2,	maxlength : 3, number : true
					},
					telNum2 : {
						required : false,	minlength : 3,	maxlength : 4, number : true
					},
					telNum3 : {
						required : false,	minlength : 4,	maxlength : 4, number : true
					},
					faxNum1 : {
						required : false,	minlength : 2,	maxlength : 3, number : true
					},
					faxNum2 : {
						required : false,	minlength : 3,	maxlength : 4, number : true
					},
					faxNum3 : {
						required : false,	minlength : 4,	maxlength : 4, number : true
					}
				}
			});
		}

	});

	function go_read() {
		var f = document.deptAddForm;
		f.nodeId.readOnly = false;
		$('input[name=isDupChecked]').val('R');
	}


    // 중복확인 버튼 클릭 이벤트
    var jsDulCheckAction = function () {
    	$.ajax({
            url      : "INC_deptDupCheck.do",
            type     : "POST",
            data     : { deptCode : $("#nodeId").val() },
            async    : false,  //false 일 경우 동기로 요청한다는 뜻임. async 비동기
            success  : function (response) {
                if (response != "0") {
                    alert("입력하신 부서코드가 이미 존재합니다.");
                    $('#nodeId').val($('input[name=oldDeptCd]').val());
                } else {
                	alert("입력하신 부서코드를 사용할 수 있습니다.");
                	$('#nodeId').attr('readonly', true);
                    $('input[name=isDupChecked]').val('Y');
                    $('label[for="isDupChecked"]').remove();
                }
            }
        });
    };
	
  	//글자수체크
    function displayBytes( num, id ){
        var form = document.dataForm;
        var obj  = document.getElementById(id);
        if(obj.value.bytes() > num){
            //if(window.event.keyCode != '8'){
                alert(num+'바이트까지 입력이 가능합니다.');
            //}
        	obj.value = obj.value.substring(0, obj.value.length-10);
        }
        eval('document.all.'+id+'_bytes').innerHTML = eval('form.'+id).value.bytes()+" byte";
    }

    String.prototype.bytes = function(){
        var str = this;
        var size = 0;
        for (var i=0; i<str.length; i++){
        	size += (str.charCodeAt(i) > 128) ? 2 : 1;
        }
        return size;
    };
    
</script>

</head>

<c:set var="exist"
	value="${not empty dataVo and not empty dataVo.deptCode}" />
<c:if test="${dataVo.deptCode eq 0}">
    <script>
    //$('#treeDetailDiv').html("<h4 class='tx_13'>부서등록</h4><P>부서를 선택하세요.</P>");
    jsList();
    </script>
</c:if>

<body>

	<c:if test="${dataVo.deptCode != 0}">
		<div>
			<h4 class="tx_13" id="a">
				<c:if test="${empty dataVo.deptCode}">부서등록</c:if>
				<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">부서정보 및 수정</c:if>
			</h4>
            <div class="tx_r mar_b10">
                <a href="#"><button class="w_blue" onclick="jsNewForm();">부서등록</button></a>
                <a href="#"><button class="w_blue" id="excelEnBloc" onclick="jsRegisterExcelEnBloc();">엑셀일괄등록</button></a>
                <a href="#"><button class="w_blue" onclick="deptListExcel();">엑셀출력</button></a>
            </div>
			<!-- 내용쓰기 -->
			<fieldset>
				<legend>
					<c:if test="${empty dataVo.deptCode}">글입력</c:if>
					<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">정보수정</c:if>
				</legend>
				<form id="deptAddForm" name="deptAddForm" >

					<input type="hidden" id="selectNodeId" value="" />
					<input type="hidden" name="telno" id="telno"	value="${dataVo.telno}" />
					<input type="hidden" name="fxnum" id="fxnum" value="${dataVo.fxnum}" />
					<input type="hidden" name="isDupChecked" value="N" />
					<input type="hidden" name="deptCode" id="deptCode" value="" />
					<input type="hidden" name="oldDeptCd"  id="oldDeptCd" value="<c:out value="${dataVo.deptCode}" />"/>

					<table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
						<caption class="hidden">
							<c:if test="${empty dataVo.deptCode}">글입력하기</c:if>
							<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">정보 수정하기</c:if>
						</caption>
						<colgroup>
							<col width="15%" />
							<col width="85%" />
						</colgroup>
						<tbody>
 						    <tr <c:if test="${empty dataVo.deptCode}">style="display: none;"</c:if>>
							    <th>상위부서명</th>
								<td><span id="nodePath"></span></td>
							</tr>
							<tr>
								<th>
									<label for="nodeText">부서명<span class="tx_red_s">*</span></label></th>
								<td><input type="text" id="nodeText" name="nodeText" class="w120" maxlength="30" title="부서명을 입력해주세요"
									value="${dataVo.deptNm}" /> 최대 30자</td>
							</tr>
							<tr>
								<th><label for="nodeId">부서코드<span class="tx_red_s">*</span></label></th>
								<td><input type="text" id="nodeId" class="w120"
									name="nodeId" title="부서코드를 입력해주세요"
									<c:if test="${empty dataVo.deptCode}">value="${deptKey}"</c:if>
									<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">value="${dataVo.deptCode}"</c:if> readonly="readonly" />
									&nbsp;
									<button class="s_blue" type="button" onclick="go_read();">수정</button>&nbsp;
									<button class="s_blue" type="button" onclick="jsDulCheckAction();">중복확인</button></td>
							</tr>
							<tr>
								<th><label for="telNum1">부서전화번호</label></th>
								<td>
									<input type="text" id="telNum1" class="w55" name="telNum1" value="" maxlength="3" /> -
									<input type="text" id="telNum2" class="w55" name="telNum2" value="" maxlength="4" /> -
									<input type="text" id="telNum3" class="w55" name="telNum3" value="" maxlength="4" />
								</td>
							</tr>
							<tr>
								<th><label for="faxNum1">부서팩스번호</label></th>
								<td>
									<input type="text" id="faxNum1" class="w55" name="faxNum1" value="" maxlength="3" /> -
									<input type="text" id="faxNum2" class="w55" name="faxNum2" value="" maxlength="4" /> -
									<input type="text" id="faxNum3" class="w55" name="faxNum3" value="" maxlength="4" />
								</td>
							</tr>
							<tr>
								<th><label for="mainDuty">주요업무<br/>(250자이내)</label>
								<br/><b><span class="tx_blue_s"><div id="mainDuty_bytes"></div></th>
								<td><textarea id="mainDuty" name="mainDuty" rows="8" class="w99_p" onkeydown="displayBytes(250,'mainDuty');">${dataVo.mainDuty}</textarea></td>
							</tr>
							<tr>
								<th>사용여부</th>
								<td>

									<input type="radio" name="useYn" id="useYn_Y" value="Y"
										<c:if test="${dataVo.useYn == 'Y'}">checked="checked"</c:if>
										<c:if test="${empty dataVo.deptCode}">checked="checked"</c:if>/>
									<label for="useYn_Y">사용</label>&nbsp;&nbsp;&nbsp;

									<input type="radio" name="useYn" id="useYn_N" value="N"
										<c:if test="${dataVo.useYn != 'Y' && not empty dataVo.deptCode}">checked="checked"</c:if>/>
									<label for="useYn_N">미사용 <span class="tx_gray">(미사용시
											서비스 화면에는 표시되지 않습니다.)</span></label>
								</td>
							</tr>
							<tr <c:if test="${empty dataVo.deptCode}">style="display: none;"</c:if>>
								<th>등록일시</th>
								<td>${dataVo.regDt}</td>
							</tr>
							<tr <c:if test="${empty dataVo.deptCode}">style="display: none;"</c:if>>
								<th>수정일시</th>
								<td>${dataVo.modiDt}</td>
							</tr>
							<c:if test="${empty dataVo.deptCode}">
							<tr>
								<th>레벨설정</th>
								<td>
									<input type="radio" name="appendOption" id="isSame" value="isSame" />
									<label for="isSame">선택한 부서와 동일 레벨에 추가</label>&nbsp;&nbsp;&nbsp;

									<input type="radio" name="appendOption" id="isChild" value="isChild" />
									<label for="isChild">선택한 부서의 하위 레벨에 추가</label>&nbsp;&nbsp;&nbsp;

									<input type="radio" name="appendOption" id="isRoot" value="isRoot" checked="checked" />
									<label for="isRoot">홈(루트)부서에 추가</label>
								</td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</form>
			</fieldset>
			<!-- //내용쓰기 -->
			<p class="mar_t10 tx_r" id="d">
				<a href="#" <c:if test="${empty dataVo.deptCode}">onclick="jsInsertAction('#deptAddForm');"</c:if>
								<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">onclick="jsUpdateAction('#deptAddForm');"</c:if>>
					<button	class="blue" id="b">
						<c:if test="${empty dataVo.deptCode}">등록</c:if>
						<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">수정</c:if>
					</button>
				</a>
				<c:if test="${not empty dataVo.deptCode and dataVo.deptCode != 0}">
					<a href="#" onclick="jsDeleteAction();">
						<button	class="blue" id="c">삭제</button>
					</a>
				</c:if>
				<c:if test="${empty dataVo.deptCode}">
					<a href="#" onclick="jsView2();">
						<button	class="blue">취소</button>
					</a>
				</c:if>
			</p>
		</div>
	</c:if>
</body>
</html>