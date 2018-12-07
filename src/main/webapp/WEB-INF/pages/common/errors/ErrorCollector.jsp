<%--
    장애관리 서버 페이지로 이동시켜 사용자 정보를 입력받을 수 있는 화면으로 이동시킨다.
    사용자에게 장애 결과를 통보하는 용도로 사용하며 이외에는 다른 셈플을 사용한다.
--%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="zes.openworks.monitor.client.*"%>
<%
    try {
        ParseDelegator delegator = new ParseDelegator(request);

        Map<String, String> errorMap = delegator.getMap();

        String resultPage = ErrorSupport.sendErrorInfo(errorMap);

        //if(resultPage != null && !resultPage.equals("")) {
        //    response.sendRedirect(resultPage);
        //} else {
%>
        <%-- 안내페이지로 이동이 필요 없는 경우 위 if 문장을 주석처리하고 아래 공간에 오류 페이지를 표시한다. --%>
<html>
<head>
    <title>오류가 발생되었습니다.</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <script type="text/javascript">
    </script>
    <style type="text/css">
        dl {
            padding: 8px; border: 1px solid gray;
        }
        dl dt {
            color: blue; margin-top: 6px; 
        }
        dl dd {
        }
        dd.req-page { color: #666666; font-weight: bold; }
        dd.debug-error { color: orange; }
    </style>
</head>

<body>

<h2><%= errorMap.get("domainNm") %> 사이트에서 오류가 발생되었습니다.</h2>

<dl>
    <dt>URL</dt>
    <dd class="req-page"><%= errorMap.get("errorUriNm") %></dd>
    <dt>브라우저</dt>
    <dd class="req-page"><%= errorMap.get("browserNm") %></dd>
    <dt>운영체제</dt>
    <dd class="req-page"><%= errorMap.get("osNm") %></dd>
    <dt>파라미터</dt>
    <dd class="req-page"><%= errorMap.get("errorParameter") %></dd>
    <dt>쿠키정보</dt>
    <dd class="req-page"><%= errorMap.get("errorCookie") %></dd>
    <dt>오류내용</dt>
    <dd class="req-page"><%= errorMap.get("errorBaseInfo") %></dd>
</dl>

</body>
</html>
<%
        //}
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
