<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>비밀번호 변경</title>
    <op:jsTag type="spi" items="form,validate,colorbox" />
    <script type="text/javascript" src="<c:url value="/resources/openworks/login/js/validationOfPassword.js" />"></script>
    <script type="text/javascript">
    $().ready(function() {
        $("#securityBtn").colorbox({
            title  : "보안등급정책",
            href   : "PD_security.do",
            width  : "815" ,
            height : "740" ,
            iframe : true
        });

        $("#dataForm").validate({
            rules: {
                mngrPassword: {
                    required: true, nowhitespace: true, minlength: 10, maxlength: 16
                },
                confirm_mgrPwd: {
                    required: true, equalTo: "#mngrPassword"
                }
            },
            messages: {
                confirm_mgrPwd: { equalTo: "새비밀번호와 동일하게 입력해주세요."}
            },
            submitHandler: function(form) {
                <%-- 비밀번호 적합성 검사 --%>
                var pwd = $("#mngrPassword").val();
                if ( !(fnLengthCheck(pwd) >= 10 && fnLengthCheck(pwd) <= 16) || !((isSpecial(pwd) || isInNumber(pwd)) && !isInteger(pwd))) {
                    $("#mngrPassword").focus();
                    jsWarningBox(Message.msg.passwordCheck2);
                    return false;
                }
                <%--개인신상,시스템명 등 유추하기 쉬운 단어 사용 금지, 간단한 문자나 숫자의 연속사용(4자리이상) 금지 체크 함수--%>
                vrtn = validPwd(pwd, '${dataVo.mngrId}', '', '${fn:substring(dataVo.email, 0, fn:indexOf(dataVo.email, '@'))}', '${fn:replace(dataVo.mbtlnum, '-', null)}');
                if(vrtn != ''){
                    $("#mngrPassword").focus();
                    jsWarningBox(vrtn);
                    return false;
                } else {
                    $(form).ajaxSubmit({
                        url     : "ND_updatePwdAction.do",
                        type    : "POST",
                        success : function(response) {
                            if(response.indexOf("-1") > -1){
                                jsErrorBox("현재 비밀번호나 이전 비밀번호로 동일하게 변경 할 수 없습니다.");
                            }else{
                                if(eval(response)) {
                                    jsSuccessBox(Message.msg.processOk);
                                    parent.$.fn.colorbox.close();
                                    parent.parent.$("#treeDetailDiv").load("ND_mgrListWithPermission.do", parent.$('#dataForm').serialize());
                                } else {
                                    jsErrorBox(Message.msg.processFail);
                                }
                            }
                        },
                        error :  function(response) {
                            jsSysErrorBox(response.responseText);
                            return;
                        }
                    });
                }
            }
        });
    });
    </script>
</head>

<body>
<div id="contents">
    <!-- //타이틀 및 상단아이콘 -->
    <form id="dataForm" name="dataForm">
    <input type="hidden" name="mngrId"   id="mngrId"   value="${param.mngrId}"/>

    <p class="gray_box_tx">개인정보보호와 안전한 서비스 이용을 위해 비밀번호 변경을 안내하고 있습니다. 비밀번호를 주기적으로 변경하시면 더욱 안전하게 개인정보 및 시스템을 보호할 수 있습니다.</p>

    <div class="w_100p">
        <h2 class="float_l">비밀번호 변경하기</h2>
        <div class="float_r" style="margin-top: 4px;">
                ※ 변경된 비밀번호는 이후 <span class="tx_b tx_red">90일간</span> 사용가능합니다. 90일 이후에는 <span class="tx_b tx_red">비밀번호를 다시 변경</span>하셔야합니다.
        </div>
    </div>

    <!-- 비밀번호 변경 -->
    <div class="w_100p clear">
        <fieldset>
        <legend>비밀번호변경</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 비밀번호변경 </caption>
            <colgroup>
                <col width="20%" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="mngrPassword">새비밀번호</label></th>
                    <td><input type="password" id="mngrPassword" class="w180" name="mngrPassword" title="새비밀번호를 입력해주세요" value="" maxlength="16"/></td>
                </tr>
                <tr>
                    <th><label for="confirm_mngrPassword">새비밀번호 확인</label></th>
                    <td><input type="password" id="confirm_mngrPassword" class="w180" name="confirm_mgrPwd" title="새비밀번호를 입력해주세요" value="" maxlength="16"/></td>
                </tr>
            </tbody>
        </table>
        </fieldset>
    </div>

    <div class="mar_t30">
        <ul class="blet">
            <li class="tx_b"> 안전하게 비밀번호 변경하기 <a href="#"><button class="s_blue" id="securityBtn">보안등급 정책</button></a></li>
            <li><span class="tx_b">사용 가능한 비밀번호</span> : 10~16자의 영문 대소문자, 숫자, 특수문자로 조합 변경
                <br/> <span style="margin-left:125px;">&nbsp;&nbsp;&nbsp;(사용 가능한 특수문자 32자: !”#$%&amp;’()*+,-./:;&gt;=&lt;?@[\]^_`{|}~)</span></li>
            <li><span class="tx_b">사용 불가한 비밀번호</span> : 현재/이전 비밀번호, 아이디, 동일한 글자 4번 이상, 이메일, 휴대전화번호</li>
        </ul>
    </div>

    <p class="tx_c"><button type="submit" class="blue">변경하기</button></p>
    </form>
</div>
</body>
</html>