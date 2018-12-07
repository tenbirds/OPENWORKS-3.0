<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%@ page language="java" import="java.net.InetAddress" %>

<html>
<head>
<title>${param.title1}</title>
<op:jsTag type="spi" items="validate,form" />
<script type="text/javascript">
$().ready(function() {
    $("#userPwd1").focus();

    $("#Form").validate({
        rules: {
        },
        submitHandler : function(form) {
             $(form).ajaxSubmit({
                url            : "BD_pwdAction.do",
                type        : "POST",
                dataType : "json",
                success    : function(response) {
                    if(!response.result) {
                        jsWarningBox(response.message);
                        return;
                    } else {
                        var returnUrl = "${param.returnUrl}";
                        self.location.href = returnUrl+"?pwdYn="+"Y";
                    }
                }
             });
         }
    });
});
</script>
</head>
<body>
    <form id="Form">

	<%
	InetAddress inet = InetAddress.getLocalHost();
	String svrIP     = inet.getHostAddress();
	String autoPw    = "192.168.85.26".equals(svrIP) || "192.168.85.31".equals(svrIP) ? "kwon!!" : "" ; // 로컬ip일때 자동으로 만능암호를 자동입력한다.	                   
	%>

    <!-- 컨텐츠영역 -->
    <div id="contents">
        <!-- 비밀번호 변경 -->
        <div class="w_100p clear">
        <fieldset>
        <legend>비밀번호확인</legend>
        <table class="boardWrite" cellspacing="0" border="0" summary="내용을 입력하실 수 있습니다.">
            <caption class="hidden"> 비밀번호확인 </caption>
            <colgroup>
                <col width="15%" />
                <col width="85%" />
            </colgroup>
            <tbody>
                <tr>
                    <th><label for="userPwd1">비밀번호 재입력</label></th>
                    <td><input type="password" id="userPwd1" class="w180" name="userPwd1" title="비밀번호를 재입력해주세요" value="<%=autoPw%>" /><br />
                    <p class="mar_t10">* <span class="tx_blue_n">로그인시 사용한 비밀번호</span>를 입력하세요.</p>
                    <p class="mar_t5">* <span class="tx_blue_n">3회 이상 입력 오류</span> 시 일정시간 동안의 <span class="tx_blue_n">접근이 차단</span>됩니다.</p>
                    </td>
                </tr>
            </tbody>
        </table>
        </fieldset>
        </div>

        <div class="mar_t30">
            <h4 class="tx_13">주의! ${param.title2}</h4>
            <ul class="blet">
                <li class="tx_red"> 회원의 개인정보 보호를 위하여 정보변경 이력에 대한 접근을 제한합니다.</li>
                <c:if test="${param.menuType eq 'R' }">
                <li class="tx_red">권한 있는 관리자 외에는 접근을 불허하며, 조회 및 출력 이력이 남습니다.</li>
                </c:if>
                <c:if test="${param.menuType eq 'L' }">
                <li class="tx_red">권한 있는 관리자 외에는 접근을 불허합니다.</li>
                </c:if>
            </ul>
        </div>

        <p class="tx_c">
            <a href="#"><button type="submit" class="blue">확인하기</button></a>
        </p>

    </div>
    <!-- //컨텐츠영역 -->
    </form>
</body>
</html>