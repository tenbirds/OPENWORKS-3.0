<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>
<%
String userDrmncyId = session.getAttribute("userDrmncyId").toString();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>회원 가입</title>
<op:jsTag type="openworks" items="ui" />
<script type="text/javascript">
    var jsConfirm = function(){
        var userDrmncyId = '<%=session.getAttribute("userDrmncyId")%>';
        if(userDrmncyId == '') {
            alert("로그인정보가 사라졋습니다. 휴면계정 해제하기를 위해 로그인을 다시 해주시기 바랍니다.");
            return false;
        }
        $('#dataForm').submit();
    };
</script>
</head>
<body>
    <!-- container -->
    <div id="container">
        <!-- contents -->
        <div id="contents">
            <form id="dataForm" name="dataForm" action="ND_userRecovryDrmncyAction.do" method="post">
                <section class="member">
                    <h3>휴면회원 안내</h3>
                    <fieldset class="certi">
                    <legend><span>패스워드 확인 서식</span></legend>
                        <div class="form">
                            <h4 style="color: darkorange;"><%=userDrmncyId%> 회원님의 아이디는 휴면상태입니다.</h4>
                            <p class="form_exp" style="font-size: 14px; font-weight: bold;">1년 이상 로그인하지 않은 계정은 휴면 상태로 전환하여 안전하게 보관하고 있습니다.<br/>
                            서비스를 이용하시려면 아래 버튼을 클릭하여 휴면을 해제하여 주시기 바랍니다.</p>
                            <div class="btn_member_c">
                                <div class="btn_navi_g">
                                    <a href="/korean/pt/index.do"><span class="cancel">취소</span></a>
                                </div>
                                <div class="btn_navi">
                                    <a href="#" onclick="jsConfirm();"><span class="gt">휴면계정 해제하기</span></a>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </section>
            </form>
        </div>
        <!-- //contents -->
    </div>
</body>
</html>