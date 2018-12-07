<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op" %>

<html>
<head>
    <title>회원 등급 관리</title>

    <op:jsTag type="spi" items="validate, form, ui" />
    <op:jsTag type="openworks" items="validate" />

    <script type="text/javascript">
    //<CDATA[[

        var jsInsertUserGradeForm = function() {
            $('#treeDetailDiv').load("INC_InsertUserGradeForm.do", function(data) {
            });
        };

        var jsUpdateUserGradeForm = function(userGradCode) {
            $('#treeDetailDiv').load("INC_UpdateUserGradeForm.do", {
                userGradCode : userGradCode
            }, function(data) {
            });
        };

        var jsCheckCode = function() {
            if($.trim($("#userGradCode").val()) == "") {
                jsWarningBox("회원등급코드를 입력하세요.");
                return;
            }
            $.post("ND_CheckGradeCd.do", {
                userGradCode : $("#userGradCode").val()
                }, function(response) {
                    if (response.result) {
                        jsSuccessBox("사용가능한 코드입니다.");
                    } else { 
                        jsWarningBox("사용중인 코드입니다.");
                    }
                }
            );
        };
    //]]>
    </script>

</head>

<body>
    <div class="buser">
        <!-- 회원 등급 목록 -->
        <div class="b_list">
            <div class="tree_tit">회원 등급 목록</div>
            <div class="panel" id="BoxList" style="height: 350px;">
                <ul class="panList">
                    <c:forEach items="${dataList}" var="userGradeVo" varStatus="status">
                        <li><a href="javaScript:jsUpdateUserGradeForm('${userGradeVo.userGradCode}');"> ${userGradeVo.userGradNm} </a></li>
                    </c:forEach>
                </ul>
            </div>

            <!-- 버튼 -->
            <div class="btn_r">
                <ul>
                    <li><button type="button" class="w_blue" onclick="jsInsertUserGradeForm();">등록</button></li>
                </ul>
            </div>
        </div>
        <!-- //회원 등급 목록 -->

        <div id="treeDetailDiv" class="b_write">
            <h4 class="tx_13">회원 등급 등록</h4>
            <p>회원 등급 명을 선택하세요.</p>
        </div>
    </div>
</body>
</html>
