<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>비밀번호 변경</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />
    <script type="text/javascript" src="<c:url value="/resources/openworks/login/js/validationOfPassword.js" />"></script>
    <script type="text/javascript">
    $().ready(function() {
        $("#securityBtn").colorbox({
            title  : "보안등급정책",
            href   : "PD_userSecurity.do",
            width  : "815" ,
            height : "740" ,
            iframe : true
        });

        $("#dataForm").validate({
            rules: {
                newPassword    : { required: true, rangelength: [10, 16], nowhitespace: true},
                confirm_userPwd: { required: true, equalTo: "#newPassword"}
            },
            submitHandler: function(form) {
                <%-- 비밀번호 적합성 검사 --%>
                var pwd = $("#newPassword").val();
                if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
                    $("#userPassword").focus();
                    alert(Message.msg.passwordCheck2);
                    return false;
                }
                <%--개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수--%>
                vrtn = validPwd(pwd, '${param.userId}', '${param.brthdy}', '${fn:substring(param.email, 0, fn:indexOf(param.email, '@'))}', '${fn:replace(param.mbtlnum, '-', null)}');
                if(vrtn != ''){
                    $("#newPassword").focus();
                    alert(vrtn);
                    return false;
                } else {
                    $(form).ajaxSubmit({
                        url     : "ND_passwordUpdateAction.do",
                        type    : "POST",
                        success : function(response) {
                            try {
                                if(response.result == true) {
                                    jsSuccessBox(Message.msg.updateOk);
                                    parent.$.fn.colorbox.close();
                                } else if (response.result == false){
                                    if(response.message != null){
                                        jsWarningBox(response.message);
                                    } else {
                                        jsErrorBox(Message.msg.processFail);
                                    }
                                }
                            } catch (e) {
                                jsSysErrorBox(response, e);
                                return;
                            }
                        }
                    });
                }
            }
        });
    });//ready end
    </script>
</head>
<body>
    <!-- //타이틀 및 상단아이콘 -->
    <form id="dataForm" name="dataForm">
    <input type="hidden" name="userId"   id="userId"   value="${param.userId}"/>

    <p class="gray_box_tx">개인정보보호와 안전한 서비스 이용을 위해 비밀번호 변경을 안내하고 있습니다. 비밀번호를 주기적으로 변경하시면 더욱 안전하게 개인정보 및 시스템을 보호할 수 있습니다.</p>

    <div class="w_100p">
        <h4 class="float_l">비밀번호 변경하기</h4>
        <div class="float_r">※ 변경된 비밀번호는 이후 90일간 사용가능합니다. 90일 이후에는 비밀번호를 다시 변경하셔야합니다.</div>
    </div>

    <!-- 비밀번호 변경 -->
    <div class="w_100p clear">
        <fieldset>
        <legend>비밀번호변경</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 비밀번호변경 </caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <!-- <tr>
                    <th><label for="old_userPwd">현재비밀번호</label></th>
                    <td><input type="password" id="old_userPwd" class="w180" name="old_userPwd" title="현재비밀번호를 입력해주세요" value="" /></td>
                </tr> -->
                <tr>
                    <th><label for="newPassword">새비밀번호</label></th>
                    <td><input type="password" id="newPassword" class="w180" name="newPassword" title="새비밀번호를 입력해주세요" value="" maxlength="32"/></td>
                </tr>
                <tr>
                    <th><label for="confirm_userPwd">새비밀번호 확인</label></th>
                    <td><input type="password" id="confirm_userPwd" class="w180" name="confirm_userPwd" title="새비밀번호를 입력해주세요" value="" maxlength="32"/></td>
                </tr>
            </tbody>
        </table>
        </fieldset>
    </div>

    <div class="mar_t30">
        <ul class="blet">
            <li class="tx_b"> 안전하게 비밀번호 변경하기 <a href="#"><button class="s_blue" id="securityBtn">보안등급 정책</button></a></li>
            <li><span class="tx_b">사용 : 10~16자의 영문 대소문자, 숫자, 특수문자로 조합 변경</span> (사용 가능한 특수문자 : !”#$%&amp;’()*+,-./:;&gt;=&lt;?@[\]^_`{|}~)</li>
            <li><span class="tx_b">불가</span> : 현재 비밀번호, 아이디, 동일한 글자 4번 이상, 휴대전화번호</li>
        </ul>
    </div>

    <p class="tx_c"><button type="submit" class="blue">변경하기</button></p>
    </form>
</body>
</html>