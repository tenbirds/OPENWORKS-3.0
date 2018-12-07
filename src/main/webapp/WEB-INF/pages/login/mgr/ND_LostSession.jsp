<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="zes.openworks.common.GlobalConfig"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.openworks.kr/jsp/jstl" prefix="op"%>

<html>
<head>
    <title>로그인 정보가 소멸되었습니다.</title>

    <op:jsTag type="spi" items="jquery" />
    <script type="text/javascript" src="<%= request.getContextPath() %>/component/javascript/MD_globalConfig.do"></script>
    <script type="text/javascript">CTX_PATH="<%=request.getContextPath()%>";</script>

    <script type="text/javascript">
    //<CDATA[[

        $(document).ready(function() {
            alert("로그인 정보가 소멸되었습니다.\n\n다시 로그인해 주시기 바랍니다.");
            top.location.href = CTX_PATH + Config.url.mgrLogin;
        });

        var jsMoveLogin = function() {
            top.location.href = CTX_PATH + Config.url.mgrLogin;
        };
    //]]>
    </script>
</head>

<body>
    로그인이 필요한 서비스입니다.<br />이동하기 버튼을 클릭하시면 로그인 페이지로 이동합니다.
    <button type="button" onclick="jsMoveLogin();">로그인</button>
</body>
</html>