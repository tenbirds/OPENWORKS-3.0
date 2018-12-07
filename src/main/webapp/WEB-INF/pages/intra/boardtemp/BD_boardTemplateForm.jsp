<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<c:set var="pageTitle" value="" />
<c:set var="jspFileNm" value="" />
<c:choose>
	<c:when test="${param.tmplatTy eq 'L'}">
		<c:set var="pageTitle" value="목록" />
		<c:set var="jspFileNm" value="BD_board.list.jsp" />
	</c:when>
	<c:when test="${param.tmplatTy eq 'V'}">
		<c:set var="pageTitle" value="읽기" />
		<c:set var="jspFileNm" value="BD_board.view.jsp" />
	</c:when>
	<c:when test="${param.tmplatTy eq 'F'}">
		<c:set var="pageTitle" value="쓰기" />
		<c:set var="jspFileNm" value="BD_board.form.jsp" />
	</c:when>
</c:choose>

<html>
<head>
<title>게시판 ${pageTitle} 템플릿 등록/수정</title>
<op:jsTag type="openworks" items="ui" />
<op:jsTag type="spi" items="form, validate, multifile" />

<script type="text/javascript">
// <!--
    //수정 버튼 클릭 이벤트
    var jsCodeUpdate = function(){
        $('#tmplatId').attr('readonly', false);
        $('input[name=isDupChecked]').val('R');
    };

    var jsMakeErrorLable = function($target, text){
        if($target.find('label.error1').length > 0){
            $target.find('label.error1').text(text);
        }else{
            $target.append('<label for="isDupChecked" class="error1">' + text + '</label>');
        }
    };

    //중복확인 버튼 클릭 이벤트
    var jsDulCheckAction = function(){
        var cnt = eval('${cntTemplateUsed}');
        if(cnt > 0){
            alert("현재 사용 중인 템플릿이므로 템플릿 ID를 수정할 수 없습니다.");
            $('#templateId').val($('input[id=oldTemplateId]').val());
            return;
        }
        $("#dataForm").ajaxSubmit({
            url      : "ND_templateIdDupCheck.do",
            type     : "POST",
            dataType:  "json",
            async    : false,
            success  : function(response){
                if(response != "0"){
                    jsMakeErrorLable($("button:contains('중복확인')").parent().parent(), '입력하신 템플릿 ID가 이미 존재합니다.');
                    $('#templateId').val($('input[name=oldTemplateId]').val());
                }else{
                    jsMessage('입력하신 템플릿 ID를 사용할 수 있습니다.');
                    $('#templateId').attr('readonly', true);
                    $('input[name=isDupChecked]').val('Y');
                    $('label[for="isDupChecked"]').remove();
                }
            }
        });
    };

    var jsSaveAction = function(){
        if($("#dataForm").valid() == false) return;

        //중복체크 관련
        if($('input[name=isDupChecked]').val() == 'R'){
            jsMakeErrorLable($("button:contains('중복확인')").parent().parent(), '중복확인을 해 주십시요.');
            return;
        }

        $("#dataForm").ajaxSubmit({
            url      : "ND_templateSaveAction.do",
            type     : "POST",
            async    : false,
            success  : function(response){
                alert(response);
                jsList();
            }
        });
    };

    var jsDeleteAction = function(){
        var cnt = eval('${cntTemplateUsed}');
        if(cnt > 0){
            alert("현재 사용 중인 템플릿이므로 삭제할 수 없습니다.");
            return;
        }

        if(!confirm("이 템플릿을 삭제하시겠습니까?\n\n한 번 삭제된 템플릿은 복구할 수 없습니다.")) return;
        $("#dataForm").ajaxSubmit({
            url      : "ND_templateDeleteAction.do",
            type     : "POST",
            async    : false,
            success  : function(response){
                jsMessage(response);
                jsList();
            }
        });
    };

    var jsList = function(){
        location.href = "BD_boardTemplateList.do?tmplatTy=${param.tmplatTy}";
    };

    $().ready(function() {
        $("#dataForm").validate({
            rules: {
                tmplatId:	{ required:true, minlength:3, maxlength:15, alphanumeric:true },
                tmplatNm:	{ required:true, minlength:3, maxlength:30 },
                tmplatFilePath:{ required:true }
            },
            submitHandler : function(form) {
            	//중복체크 관련
                if($('input[name=isDupChecked]').val() == 'R'){
                    jsMakeErrorLable($("button:contains('중복확인')").parent().parent(), '중복확인을 해 주십시요.');
                    return;
                }
// alert("???d" + $("#oldTemplateId").val())
            	$(form).ajaxSubmit({
                    url : "ND_templateSaveAction.do",
                    type : "POST",
                    success : function(response){
                        jsMessage(response);
                        jsList();
                    }
                });
            }
        });

        if($('input[name=oldTemplateId]').val() == ""){
            jsCodeUpdate();
        }
    });
//-->
</script>
</head>

<body>
<c:choose>
    <c:when test="${!empty dataVo and !empty dataVo.tmplatId}">
        <h4 class="tx_13">게시판 ${pageTitle} 템플릿 수정</h4>
    </c:when>
    <c:otherwise>
        <h4 class="tx_13">게시판 ${pageTitle} 템플릿 신규등록</h4>
    </c:otherwise>
</c:choose>


<form name="dataForm" id="dataForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="isDupChecked" value="N" />
<input type="hidden" name="oldtemplateId" id="oldTemplateId" value="${dataVo.tmplatId}" />
<input type="hidden" name="tmplatTy" id="tmplatTy" value="${param.tmplatTy}" />

<fieldset>
<legend>글입력</legend>
<table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
    <caption class="hidden"> 글입력하기 </caption>
    <colgroup>
        <col width="15%" />
        <col width="85%" />
    </colgroup>
    <tbody>
        <tr>
            <th><label for="tmplatId">템플릿 ID <span class="tx_red_s">*</span></label></th>
            <td>
            	<input type="text" id="tmplatId" name="tmplatId" class="w120" value="<c:out value="${dataVo.tmplatId}"/>" <c:if test="${not empty dataVo.tmplatId}">readonly="readonly"</c:if> />     
                <a href="#" onclick="jsCodeUpdate();"><button type="button" class="s_blue">수정</button></a>
                <a href="#" onclick="jsDulCheckAction();"><button type="button" class="s_blue">중복확인</button></a>
                <p><span class="tx_blue_s">(영문과 숫자만 사용 가능, 최대 15자)</span></p>
            </td>
        </tr>
        <tr>
            <th><label for="tmplatNm">템플릿명 <span class="tx_red_s">*</span></label></th>
            <td>
            	<input type="text" id="tmplatNm" name="tmplatNm" class="w215" value="<c:out value="${dataVo.tmplatNm}" />" />
            </td>
        </tr>
        <tr>
            <th><label for="tmplatFilePath">템플릿 소스 첨부 <span class="tx_red_s">*</span></label></th>
            <td>
            	<input type="file" name="file1" id="file1" class="multi max-1 w470" accept="jsp" value="찾아보기" />
            	<p><span class="tx_blue_s">- 기존의 템플릿을 다운받아서 수정한 파일을 첨부합니다. (파일명 : ${jspFileNm})</span></p>
            	<c:if test="${not empty dataVo.tmplatFilePath}">
            		<p><span class="tx_blue_s">- 새로운 파일을 지정하시면 기존의 템플릿 파일을 대체합니다.</span></p>
            	</c:if>
           </td>
        </tr>
        <tr>
            <th><label for="screenshotFilePath">템플릿 미리보기 첨부</label></th>
            <td>
            	<input type="file" name="file2" id="file2" class="multi max-1 w470" accept="jpg|jpeg|png|gif|bmp" value="찾아보기" />
            	<p><span class="tx_blue_s">- 이 템플릿의 미리보기 이미지를 첨부합니다.</span></p>
            	<c:if test="${not empty dataVo.screenshotFilePath}">
            		<p><span class="tx_blue_s">- 새로운 파일을 지정하시면 기존의 미리보기 파일을 대체합니다.</span></p>
            	</c:if>
            	<c:if test="${!empty dataVo && !empty dataVo.screenshotFilePath}">
            		<br /><img src="${dataVo.screenshotFilePath}" width="500" style="border: 1px solid #ddd; padding: 5px;" />            		
            	</c:if>
            </td>
        </tr>
        <c:if test="${!empty dataVo}">
	        <tr>
	            <th>등록자</th>
	            <td><c:out value="${dataVo.registId}" /></td>
	        </tr>
	        <tr>
	            <th>등록일시</th>
	            <td><c:out value="${dataVo.registDt}" /></td>
	        </tr>
	        <c:if test="${!empty dataVo.updtDt}">
		        <tr>
		            <th>수정자</th>
		            <td><c:out value="${dataVo.updtId}" /></td>
		        </tr>
		        <tr>
		            <th>수정일시</th>
		            <td><c:out value="${dataVo.updtDt}" /></td>
		        </tr>
	        </c:if>
        </c:if>
    </tbody>
</table>
</fieldset>

<p class="mar_t10 mar_b20 tx_r">
    <c:choose>
        <c:when test="${!empty dataVo and !empty dataVo.tmplatId}">
            <a href="#"><button class="blue">수정</button></a>
            <a href="#" onclick="jsDeleteAction();"><button type="button" class="blue">삭제</button></a>
        </c:when>
        <c:otherwise>
            <a href="#"><button class="blue">등록</button></a>
        </c:otherwise>
    </c:choose>
    <a href="#" onclick="jsList();"><button class="blue">취소</button></a>
</p>

</form>

</body>
</html>