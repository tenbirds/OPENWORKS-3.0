<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<script type="text/javascript">
<!--
    // 수정 버튼 클릭 이벤트
    var jsCodeUpdate = function () {
        $('#authCode').attr('readonly', false);
        $('input[name=isDupChecked]').val('R');
    };

    var jsMakeErrorLable = function ($target, text) {
        if ($target.find('label.error1').length > 0) {
            $target.find('label.error1').text(text);
        } else {
            $target.append('<label for="isDupChecked" class="error1">' + text + '</label>');
        }
    };

    // 중복확인 버튼 클릭 이벤트
    var jsDulCheckAction = function () {
        $("#authDataForm").ajaxSubmit({
            url      : "ND_authDupCheck.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                if (response != "0") {
                    jsMakeErrorLable($("button:contains('중복확인')").parent().parent(), '입력하신 권한코드가 이미 존재합니다.');
                    $('#authCode').val($('input[name=oldAuthCd]').val());
                } else {
                    jsSuccessBox('입력하신 권한코드를 사용할 수 있습니다.');
                    $('#authCode').attr('readonly', true);
                    $('input[name=isDupChecked]').val('Y');
                    $('label[for="isDupChecked"]').remove();
                }
            }
        });
    };

    var jsSaveAction = function () {
        if ($("#authDataForm").valid() == false) return;

        // 중복체크 관련
        if ($('input[name=isDupChecked]').val() == 'R') {
            jsMakeErrorLable($("button:contains('중복확인')").parent().parent(), '중복확인을 해 주십시요.');
            return;
        }

        // 그룹권한 신규 신청 시 기본값 설정
        if ($('input[name=authTyCode]').val() == '') {
            $('input[name=authTyCode]').val('G');
        }

        $("#authDataForm").ajaxSubmit({
            url      : "ND_authSaveAction.do",
            type     : "POST",
            async    : false,
            dataType : "json",
            success  : function (response) {
                if(response.result) {
                    jsSuccessBox(response.message);

                } else {
                    jsErrorBox(Message.msg.processFail);
                }
                boxListLoad(BoxListConfig);
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    };

    var jsDeleteAction = function () {
        $("#authDataForm").ajaxSubmit({
            url      : "ND_authDeleteAction.do",
            type     : "POST",
            async    : false,
            success  : function (response) {
                try {
                    if(eval(response)) {
                        jsSuccessBox(Message.msg.deleteOk);
                        boxListLoad(BoxListConfig);
                        location.href = "/intra/auth/BD_index.do";
                    } else {
                        jsErrorBox(Message.msg.processFail);
                    }
                } catch (e) {
                    jsSysErrorBox(response, e);
                    return;
                }
            },
            error :  function(response) {
                jsSysErrorBox(response.responseText);
                return;
            }
        });
    };

    $().ready(function() {
        $("#authDataForm").validate({
            rules: {
                authNm:   { required:true, minlength:3, maxlength:15 },
                authCode:   { required:true, minlength:3, maxlength:20 },
                authDc: { maxlength:65 },
                useYn:    { required:true }
            }
        });

        if ($('input[name=oldAuthCd]').val() == '') {
            jsCodeUpdate();
        }
    });
//-->
</script>


<c:choose>
    <c:when test="${!empty dataVo and !empty dataVo.authCode}">
        <h4 class="tx_13">관리자권한 수정</h4>
    </c:when>
    <c:otherwise>
        <h4 class="tx_13">관리자권한 입력</h4>
    </c:otherwise>
</c:choose>

<fieldset>
<legend>글입력</legend>
<form id="authDataForm">
<input type="hidden" name="isDupChecked" value="N" />
<input type="hidden" name="authTyCode" value="${dataVo.authTyCode}" />
<input type="hidden" name="oldAuthCd" value="<c:out value="${dataVo.authCode}" />" />

<table class="boardWrite" summary="내용을 입력하실 수 있습니다.">
    <caption class="hidden"> 글입력하기 </caption>
    <colgroup>
        <col width="15%" />
        <col width="85%" />
    </colgroup>
    <tbody>
        <tr>
            <th><label for="authNm">권한명<span class="tx_red_s">*</span> (최대15자)</label></th>
            <td><input type="text" id="authNm" name="authNm" class="w120"
                       value="<c:out value="${dataVo.authNm}" />" />
            </td>
        </tr>
        <tr>
            <th><label for="authCode">권한코드<span class="tx_red_s">*</span></label></th>
            <td><input type="text" id="authCode" name="authCode" class="w120" readonly="readonly"
                       value="<c:out value="${dataVo.authCode}" />" />
                <a href="#" onclick="jsCodeUpdate();"><button type="button" class="s_blue">수정</button></a>
                <a href="#" onclick="jsDulCheckAction();"><button type="button" class="s_blue">중복확인</button></a>
            </td>
        </tr>
        <tr>
            <th><label for="authContent">권한설명 (최대65자)</label></th>
            <td><textarea id="authContent" name="authDc" rows="4" class="w99_p"><c:out value="${dataVo.authDc}" /></textarea></td>
        </tr>
        <tr>
            <th>사용여부</th>
            <td><input type="radio" id="useYn_Y" name="useYn" value="Y" <c:if test="${dataVo.useYn ne 'N'}">checked="checked"</c:if> />
                <label for="useYn_Y">사용</label>&nbsp;&nbsp;&nbsp;
                <input type="radio" id="useYn_N" name="useYn" value="N" <c:if test="${dataVo.useYn eq 'N'}">checked="checked"</c:if> />
                <label for="useYn_N">미사용</label>
            </td>
        </tr>
        <c:if test="${!empty dataVo}">
        <tr>
            <th>등록자</th>
            <td><c:out value="${dataVo.regNm}" /></td>
        </tr>
        <tr>
            <th>등록일시</th>
            <td><c:out value="${dataVo.regDtm}" /></td>
        </tr>
        <tr>
            <th>수정자</th>
            <td><c:out value="${dataVo.modiNm}" /></td>
        </tr>
        <tr>
            <th>수정일시</th>
            <td><c:out value="${dataVo.modiDtm}" /></td>
        </tr>
        </c:if>
    </tbody>
</table>
</form>
</fieldset>

<p class="mar_t10 mar_b20 tx_r">
    <c:choose>
        <c:when test="${!empty dataVo and !empty dataVo.authCode}">
            <a href="#" onclick="jsSaveAction();"><button class="blue">수정</button></a>
            <a href="#" onclick="jsDeleteAction();"><button class="blue">삭제</button></a>
        </c:when>
        <c:otherwise>
            <a href="#" onclick="jsSaveAction();"><button class="blue">입력</button></a>
        </c:otherwise>
    </c:choose>
</p>